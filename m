Return-Path: <stable+bounces-114654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCECA2F0EB
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 16:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E9C16847D
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A0F1F8BAC;
	Mon, 10 Feb 2025 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w/AYxWCw"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4006735972
	for <Stable@vger.kernel.org>; Mon, 10 Feb 2025 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199991; cv=none; b=JMRd9Sp1EbY+rsfSxeW7uQv1HdpiP8BfUDRPnJN65xeOJ0Bj/hMher0MlHm/jEZsl9QeOQl7mV2AjG9rYd2rhDqt4e2W1A6OTXNkmfkTF29sCUVBAJdENJWNGbKK0FqXcyU7axR3cK849jG1rUS/ynIHVMOoiTUaZ2Yc+RLJ57c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199991; c=relaxed/simple;
	bh=QrtM1AFg4ipMVs8SVZ7aQ5d/CvGQsv7hyDpPW9pKe0o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ij+jPSowLuvVn8inhZJECkC5EyPhcwgS4khV4KQw10xNh75tQm3pZIYRUqPvhYzir3hExXVeYEuStOzt+aQthgo7EdL4vAAXW+tAYdMz1en4vP3qG9YOjvmzAWFPUD4K13tvrQ/GZgfwnMZCqr6AsicgWhU1iwsa0Ii6nqwoWuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w/AYxWCw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F3CC4CED1;
	Mon, 10 Feb 2025 15:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739199991;
	bh=QrtM1AFg4ipMVs8SVZ7aQ5d/CvGQsv7hyDpPW9pKe0o=;
	h=Subject:To:Cc:From:Date:From;
	b=w/AYxWCwiBS/HkC7lDxWzSL84B8aMn5qLNHNzS0HzJwGf01Tddq5h/Zk/h9Z7qERW
	 iPEBtsuRoLKF5mh6peCJIIL401Ze0hyujLOEpzJQ6QE256BY/7vIunZWROo/xDHPSV
	 oXV9fbtLbmQxhiKbtgSVfx/sF63FCRIMYcaKsFA8=
Subject: FAILED: patch "[PATCH] iio: dac: ad3552r-common: fix ad3541/2r ranges" failed to apply to 6.6-stable tree
To: adureghello@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dlechner@baylibre.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 16:06:11 +0100
Message-ID: <2025021011-ending-obliged-c11e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1e758b613212b6964518a67939535910b5aee831
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021011-ending-obliged-c11e@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1e758b613212b6964518a67939535910b5aee831 Mon Sep 17 00:00:00 2001
From: Angelo Dureghello <adureghello@baylibre.com>
Date: Wed, 8 Jan 2025 18:29:15 +0100
Subject: [PATCH] iio: dac: ad3552r-common: fix ad3541/2r ranges

Fix ad3541/2r voltage ranges to be as per ad3542r datasheet,
rev. C, table 38 (page 57).

The wrong ad354xr ranges was generating erroneous Vpp output.

In more details:
- fix wrong number of ranges, they are 5 ranges, not 6,
- remove non-existent 0-3V range,
- adjust order, since ad3552r_find_range() get a wrong index,
  producing a wrong Vpp as output.

Retested all the ranges on real hardware, EVALAD3542RFMCZ:

adi,output-range-microvolt (fdt):
<(000000) (2500000)>;   ok (Rfbx1, switch 10)
<(000000) (5000000)>;   ok (Rfbx1, switch 10)
<(000000) (10000000)>;  ok (Rfbx1, switch 10)
<(-5000000) (5000000)>; ok (Rfbx2, switch +/- 5)
<(-2500000) (7500000)>; ok (Rfbx2, switch -2.5/7.5)

Fixes: 8f2b54824b28 ("drivers:iio:dac: Add AD3552R driver support")
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-1-2dac02f04638@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/dac/ad3552r-common.c b/drivers/iio/dac/ad3552r-common.c
index 0f495df2e5ce..03e0864f5084 100644
--- a/drivers/iio/dac/ad3552r-common.c
+++ b/drivers/iio/dac/ad3552r-common.c
@@ -22,11 +22,10 @@ EXPORT_SYMBOL_NS_GPL(ad3552r_ch_ranges, "IIO_AD3552R");
 
 const s32 ad3542r_ch_ranges[AD3542R_MAX_RANGES][2] = {
 	[AD3542R_CH_OUTPUT_RANGE_0__2P5V]	= { 0, 2500 },
-	[AD3542R_CH_OUTPUT_RANGE_0__3V]		= { 0, 3000 },
 	[AD3542R_CH_OUTPUT_RANGE_0__5V]		= { 0, 5000 },
 	[AD3542R_CH_OUTPUT_RANGE_0__10V]	= { 0, 10000 },
-	[AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V]	= { -2500, 7500 },
-	[AD3542R_CH_OUTPUT_RANGE_NEG_5__5V]	= { -5000, 5000 }
+	[AD3542R_CH_OUTPUT_RANGE_NEG_5__5V]	= { -5000, 5000 },
+	[AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V]	= { -2500, 7500 }
 };
 EXPORT_SYMBOL_NS_GPL(ad3542r_ch_ranges, "IIO_AD3552R");
 
diff --git a/drivers/iio/dac/ad3552r.h b/drivers/iio/dac/ad3552r.h
index fd5a3dfd1d1c..4b5581039ae9 100644
--- a/drivers/iio/dac/ad3552r.h
+++ b/drivers/iio/dac/ad3552r.h
@@ -131,7 +131,7 @@
 #define AD3552R_CH1_ACTIVE				BIT(1)
 
 #define AD3552R_MAX_RANGES	5
-#define AD3542R_MAX_RANGES	6
+#define AD3542R_MAX_RANGES	5
 #define AD3552R_QUAD_SPI	2
 
 extern const s32 ad3552r_ch_ranges[AD3552R_MAX_RANGES][2];
@@ -189,16 +189,14 @@ enum ad3552r_ch_vref_select {
 enum ad3542r_ch_output_range {
 	/* Range from 0 V to 2.5 V. Requires Rfb1x connection */
 	AD3542R_CH_OUTPUT_RANGE_0__2P5V,
-	/* Range from 0 V to 3 V. Requires Rfb1x connection  */
-	AD3542R_CH_OUTPUT_RANGE_0__3V,
 	/* Range from 0 V to 5 V. Requires Rfb1x connection  */
 	AD3542R_CH_OUTPUT_RANGE_0__5V,
 	/* Range from 0 V to 10 V. Requires Rfb2x connection  */
 	AD3542R_CH_OUTPUT_RANGE_0__10V,
-	/* Range from -2.5 V to 7.5 V. Requires Rfb2x connection  */
-	AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V,
 	/* Range from -5 V to 5 V. Requires Rfb2x connection  */
 	AD3542R_CH_OUTPUT_RANGE_NEG_5__5V,
+	/* Range from -2.5 V to 7.5 V. Requires Rfb2x connection  */
+	AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V,
 };
 
 enum ad3552r_ch_output_range {


