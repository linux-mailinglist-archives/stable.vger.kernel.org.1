Return-Path: <stable+bounces-89931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5C69BD982
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 00:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF1B2842FD
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 23:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A452D216454;
	Tue,  5 Nov 2024 23:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xpWPIoT3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2201D270A;
	Tue,  5 Nov 2024 23:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730848323; cv=none; b=m63+6QoPEwhtmMYrs4M7cIDvGci3k8JwNv5iEAQbSFU34nmeioi6wKM+puLXHESi8+KlleECrMoazQRUX4hFVTbHcntw04krmL+6/YeW+l8bH+oilrvqK9j1kU6o9DSWGIBP2qIEAQWWxAfxsi3VH1L5FvNCMFV0GT1LA1k/C4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730848323; c=relaxed/simple;
	bh=tYeuqIN6ABGzW67RvPHRA9H0TABKa7wVpxmLpu0jWWk=;
	h=Date:To:From:Subject:Message-Id; b=hG0VSUWdFhlMIA6U/em/3kiaplM9UwkA1iWUYoaM0n4m4E9BTfWWNowMPZVMyQVgD3g0G6FMw9Okri27kWdDof0SKlI7oHLwII3z/pb7esxHAPvG0oticfchrSST+QXh/6JIIoTEp9PgKJni3BhJd53NVz7ZskwN+6R/pRK9iVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xpWPIoT3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC436C4CECF;
	Tue,  5 Nov 2024 23:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730848322;
	bh=tYeuqIN6ABGzW67RvPHRA9H0TABKa7wVpxmLpu0jWWk=;
	h=Date:To:From:Subject:From;
	b=xpWPIoT3w2EAHnCQs/FwMBY/BPE3UwJe9IqSziT9fDEJiWKqjgh6c7m0rVNlCKfTM
	 y+plMJuMyUX5lQBGCQvQHt7Krj5FM0u/mjRXOu6hS4rc8VlIKGoVacOU7KCyss+0VS
	 JH4PDwkQaR3shrspa6OiqGgPcouWXkDas2D5P+9o=
Date: Tue, 05 Nov 2024 15:12:02 -0800
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,gregkh@linuxfoundation.org,bartosz.golaszewski@linaro.org,aardelean@baylibre.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + util_macrosh-fix-rework-find_closest-macros.patch added to mm-nonmm-unstable branch
Message-Id: <20241105231202.CC436C4CECF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: util_macros.h: fix/rework find_closest() macros
has been added to the -mm mm-nonmm-unstable branch.  Its filename is
     util_macrosh-fix-rework-find_closest-macros.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/util_macrosh-fix-rework-find_closest-macros.patch

This patch will later appear in the mm-nonmm-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Alexandru Ardelean <aardelean@baylibre.com>
Subject: util_macros.h: fix/rework find_closest() macros
Date: Tue, 5 Nov 2024 16:54:05 +0200

A bug was found in the find_closest() (find_closest_descending() is also
affected after some testing), where for certain values with small
progressions, the rounding (done by averaging 2 values) causes an
incorrect index to be returned.  The rounding issues occur for
progressions of 1, 2 and 3.  It goes away when the progression/interval
between two values is 4 or larger.

It's particularly bad for progressions of 1.  For example if there's an
array of 'a = { 1, 2, 3 }', using 'find_closest(2, a ...)' would return 0
(the index of '1'), rather than returning 1 (the index of '2').  This
means that for exact values (with a progression of 1), find_closest() will
misbehave and return the index of the value smaller than the one we're
searching for.

For progressions of 2 and 3, the exact values are obtained correctly; but
values aren't approximated correctly (as one would expect).  Starting with
progressions of 4, all seems to be good (one gets what one would expect).

While one could argue that 'find_closest()' should not be used for arrays
with progressions of 1 (i.e. '{1, 2, 3, ...}', the macro should still
behave correctly.

The bug was found while testing the 'drivers/iio/adc/ad7606.c',
specifically the oversampling feature.
For reference, the oversampling values are listed as:
   static const unsigned int ad7606_oversampling_avail[7] = {
          1, 2, 4, 8, 16, 32, 64,
   };

When doing:
  1. $ echo 1 > /sys/bus/iio/devices/iio\:device0/oversampling_ratio
     $ cat /sys/bus/iio/devices/iio\:device0/oversampling_ratio
     1  # this is fine
  2. $ echo 2 > /sys/bus/iio/devices/iio\:device0/oversampling_ratio
     $ cat /sys/bus/iio/devices/iio\:device0/oversampling_ratio
     1  # this is wrong; 2 should be returned here
  3. $ echo 3 > /sys/bus/iio/devices/iio\:device0/oversampling_ratio
     $ cat /sys/bus/iio/devices/iio\:device0/oversampling_ratio
     2  # this is fine
  4. $ echo 4 > /sys/bus/iio/devices/iio\:device0/oversampling_ratio
     $ cat /sys/bus/iio/devices/iio\:device0/oversampling_ratio
     4  # this is fine
And from here-on, the values are as correct (one gets what one would
expect.)

While writing a kunit test for this bug, a peculiar issue was found for the
array in the 'drivers/hwmon/ina2xx.c' & 'drivers/iio/adc/ina2xx-adc.c'
drivers. While running the kunit test (for 'ina226_avg_tab' from these
drivers):
  * idx = find_closest([-1 to 2], ina226_avg_tab, ARRAY_SIZE(ina226_avg_tab));
    This returns idx == 0, so value.
  * idx = find_closest(3, ina226_avg_tab, ARRAY_SIZE(ina226_avg_tab));
    This returns idx == 0, value 1; and now one could argue whether 3 is
    closer to 4 or to 1. This quirk only appears for value '3' in this
    array, but it seems to be a another rounding issue.
  * And from 4 onwards the 'find_closest'() works fine (one gets what one
    would expect).

This change reworks the find_closest() macros to also check the difference
between the left and right elements when 'x'. If the distance to the right
is smaller (than the distance to the left), the index is incremented by 1.
This also makes redundant the need for using the DIV_ROUND_CLOSEST() macro.

In order to accommodate for any mix of negative + positive values, the
internal variables '__fc_x', '__fc_mid_x', '__fc_left' & '__fc_right' are
forced to 'long' type. This also addresses any potential bugs/issues with
'x' being of an unsigned type. In those situations any comparison between
signed & unsigned would be promoted to a comparison between 2 unsigned
numbers; this is especially annoying when '__fc_left' & '__fc_right'
underflow.

The find_closest_descending() macro was also reworked and duplicated from
the find_closest(), and it is being iterated in reverse. The main reason
for this is to get the same indices as 'find_closest()' (but in reverse).
The comparison for '__fc_right < __fc_left' favors going the array in
ascending order.
For example for array '{ 1024, 512, 256, 128, 64, 16, 4, 1 }' and x = 3, we
get:
    __fc_mid_x = 2
    __fc_left = -1
    __fc_right = -2
    Then '__fc_right < __fc_left' evaluates to true and '__fc_i++' becomes 7
    which is not quite incorrect, but 3 is closer to 4 than to 1.

This change has been validated with the kunit from the next patch.

Link: https://lkml.kernel.org/r/20241105145406.554365-1-aardelean@baylibre.com
Fixes: 95d119528b0b ("util_macros.h: add find_closest() macro")
Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/util_macros.h |   56 ++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 16 deletions(-)

--- a/include/linux/util_macros.h~util_macrosh-fix-rework-find_closest-macros
+++ a/include/linux/util_macros.h
@@ -4,19 +4,6 @@
 
 #include <linux/math.h>
 
-#define __find_closest(x, a, as, op)					\
-({									\
-	typeof(as) __fc_i, __fc_as = (as) - 1;				\
-	typeof(x) __fc_x = (x);						\
-	typeof(*a) const *__fc_a = (a);					\
-	for (__fc_i = 0; __fc_i < __fc_as; __fc_i++) {			\
-		if (__fc_x op DIV_ROUND_CLOSEST(__fc_a[__fc_i] +	\
-						__fc_a[__fc_i + 1], 2))	\
-			break;						\
-	}								\
-	(__fc_i);							\
-})
-
 /**
  * find_closest - locate the closest element in a sorted array
  * @x: The reference value.
@@ -25,8 +12,27 @@
  * @as: Size of 'a'.
  *
  * Returns the index of the element closest to 'x'.
+ * Note: If using an array of negative numbers (or mixed positive numbers),
+ *       then be sure that 'x' is of a signed-type to get good results.
  */
-#define find_closest(x, a, as) __find_closest(x, a, as, <=)
+#define find_closest(x, a, as)						\
+({									\
+	typeof(as) __fc_i, __fc_as = (as) - 1;				\
+	long __fc_mid_x, __fc_x = (x);					\
+	long __fc_left, __fc_right;					\
+	typeof(*a) const *__fc_a = (a);					\
+	for (__fc_i = 0; __fc_i < __fc_as; __fc_i++) {			\
+		__fc_mid_x = (__fc_a[__fc_i] + __fc_a[__fc_i + 1]) / 2;	\
+		if (__fc_x <= __fc_mid_x) {				\
+			__fc_left = __fc_x - __fc_a[__fc_i];		\
+			__fc_right = __fc_a[__fc_i + 1] - __fc_x;	\
+			if (__fc_right < __fc_left)			\
+				__fc_i++;				\
+			break;						\
+		}							\
+	}								\
+	(__fc_i);							\
+})
 
 /**
  * find_closest_descending - locate the closest element in a sorted array
@@ -36,9 +42,27 @@
  * @as: Size of 'a'.
  *
  * Similar to find_closest() but 'a' is expected to be sorted in descending
- * order.
+ * order. The iteration is done in reverse order, so that the comparison
+ * of '__fc_right' & '__fc_left' also works for unsigned numbers.
  */
-#define find_closest_descending(x, a, as) __find_closest(x, a, as, >=)
+#define find_closest_descending(x, a, as)				\
+({									\
+	typeof(as) __fc_i, __fc_as = (as) - 1;				\
+	long __fc_mid_x, __fc_x = (x);					\
+	long __fc_left, __fc_right;					\
+	typeof(*a) const *__fc_a = (a);					\
+	for (__fc_i = __fc_as; __fc_i >= 1; __fc_i--) {			\
+		__fc_mid_x = (__fc_a[__fc_i] + __fc_a[__fc_i - 1]) / 2;	\
+		if (__fc_x <= __fc_mid_x) {				\
+			__fc_left = __fc_x - __fc_a[__fc_i];		\
+			__fc_right = __fc_a[__fc_i - 1] - __fc_x;	\
+			if (__fc_right < __fc_left)			\
+				__fc_i--;				\
+			break;						\
+		}							\
+	}								\
+	(__fc_i);							\
+})
 
 /**
  * is_insidevar - check if the @ptr points inside the @var memory range.
_

Patches currently in -mm which might be from aardelean@baylibre.com are

util_macrosh-fix-rework-find_closest-macros.patch
lib-util_macros_kunit-add-kunit-test-for-util_macrosh.patch


