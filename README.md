                                                                                                                  # Green Grocer

## Learning Goals

- Translate data from AoH to AoH
- Perform calculations based on AoH data

## Introduction

In the last lab, we built out a couple of methods for simulating a grocery
shopping experience. We built a method for finding items in an `Array` of
`Hash`es, `find_item_by_name_in_collection`, then a second method,
`consolidated_cart`. `consolidated_cart` takes an `Array` of `Hash`es of single
grocery items and creates a new AoH that includes quantities for each item.

In this lab, we're going to finish the work we've started by writing three more
methods. The first two methods, `apply_coupons` and `apply_clearance`, will
apply discounts to a cart that has already been consolidated - one applies
coupons, and the other applies discounts for clearance items.

The final method, `checkout`, will bring the entire process together - it will
run the `consolidated_cart` method we wrote in part 1 of this lab as well as
`apply_coupons` and `apply_clearance`. The `checkout` method will need to take
in an **unconsolidated** cart, consolidate it, apply coupons, and apply
discounts. Finally, the `checkout` method will total up the cost of all items,
apply a 'total price' discount if applicable, and return the final cost.

Recalling from the previous lab, when you pay for all your items at the
checkout, you expect to get a "consolidated" receipt that:

* lists all of the items you bought
* lists how many of each item you bought
* accounts for any coupons or discounts per item
* applies any "total price" discounts

We've covered the first two items in this list with `consolidated_cart`. Let's
get started on the last two.

## Instructions

Complete your solution in `lib/grocer_part_2.rb`. Since this is part 2 of two
labs, a solution to part 1 is provided in `lib/part_1_solution.rb`. This file is
required at the top of `lib/grocer_part_2.rb`, so you will be able to access and
use the existing `consolidated_cart` method in your solution code. The tests
from the previous lab are included and currently passing.

### Write the `apply_coupons` Method

* Arguments:
  * `Array`: a collection of item `Hash`es
  * `Array`: a collection of coupon `Hash`es
* Returns:
  * A ***new*** `Array`. Its members will be a mix of the item `Hash`es and,
    where applicable, the "ITEM W/COUPON" `Hash`. Rules for application are
    described below.

_Example:_

Given the following consolidated cart:

```ruby
[
  {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 3},
  {:item => "KALE",    :price => 3.00, :clearance => false, :count => 1}
]
```

and an Array with a single coupon:

```ruby
[
  {:item => "AVOCADO", :num => 2, :cost => 5.00}
]
```

then `apply_coupons` should change the first Array to look like:

```ruby
[
  {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 1},
  {:item => "KALE", :price => 3.00, :clearance => false, :count => 1},
  {:item => "AVOCADO W/COUPON", :price => 2.50, :clearance => true, :count => 2}
]
```

In this case, we have a 2 for $5.00 coupon and 3 avocados counted in the
consolidated cart. Since the coupon only applies to 2 avocados, the cart shows
there is one remaining avocado at full-price, $3.00, and a count of _2_
discounted avocados.

**Note:** We want to be consistent in the way our data is structured, so each
item in the consolidated cart should include the price of _one_ of that item.
For example, even though the coupon states $5.00—because there are 2
avocados—the price is listed as $2.50.

### Write the `apply_clearance` Method

* Arguments:
  * `Array`: a collection of item `Hash`es
* Returns:
  * a ***new*** `Array` where every ***unique*** item in the original is present
    *but* with its price reduced by 20% if its `:clearance` value is `true`

This method should discount the price of every item on clearance by twenty
percent.

_Example:_

Given the following consolidated cart:

```ruby
[
  {:item => "PEANUT BUTTER", :price => 3.00, :clearance => true,  :count => 2},
  {:item => "KALE", :price => 3.00, :clearance => false, :count => 3},
  {:item => "SOY MILK", :price => 4.50, :clearance => true,  :count => 1}
]
```

`apply_clearance` should update the cart with clearance applied to PEANUT BUTTER
and SOY MILK:

```ruby
[
  {:item => "PEANUT BUTTER", :price => 2.40, :clearance => true,  :count => 2},
  {:item => "KALE", :price => 3.00, :clearance => false, :count => 3},
  {:item => "SOY MILK", :price => 3.60, :clearance => true,  :count => 1}
]
```

Sometimes, these operations can lead to numbers with many decimal places. The
`Float` class' built-in [round][round] method will be helpful here to make sure
your values align. `2.4900923090909029304` becomes `2.5` if we use it like so:
`2.4900923090909029304.round(2)`

### Write the `checkout` Method

* Arguments:
  * `Array`: a collection of item `Hash`es
  * `Array`: a collection of coupon `Hash`es
* Returns:
  * `Float`: a total of the cart

Here's where we stitch all our work together. Given a "cart" `Array`, the first
argument, we should first create a new consolidated cart using the
`consolidate_cart` method.

We should pass the newly consolidated cart to `apply_coupons` and then send it to
`apply_clearance`. With all the discounts applied, we should loop through the
"consolidated and discounts-applied" cart and multiply each item Hash's price
by its count and accumulate that to a grand total.

As one last wrinkle, our grocery store offers a deal for customers buying lots
of items. If, after the coupons and discounts are applied, the cart's total is
over $100, the customer gets an additional 10% off. Apply this discount when
appropriate.

## Conclusion

When working with a lot of data, utilizing arrays and hashes is key. With our
knowledge of iteration and data manipulation, we can do all sorts of things
with this data. We can build methods that access that data and modify only what
we want. We can extract additional information, as we did here, calculating a
total.  We can take data that isn't helpful to us and restructure it to be
_exactly_ what we need. Most importantly, we can process this data in a way
that lets us extract relevant insights that have meaning in the real world. The
better we can structure our programs to represent people and the actions they
need to perform, the easier we can make our programs necessary to users.

## Resources

- [Round][round]
- [Nested Data Structures to Insights](https://github.com/learn-co-curriculum/programming-univbasics-nds-nds-to-insights)

[round]: https://ruby-doc.org/core-2.1.2/Float.html#method-i-round

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/green_grocer'>Green Grocer</a> on Learn.co and start learning to code for free.</p>
