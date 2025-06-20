Return-Path: <stable+bounces-155066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E49AE17A4
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43D41BC1D1C
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CF227D76E;
	Fri, 20 Jun 2025 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XQQjGC/d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BD030E830
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750412103; cv=none; b=J/KHY0Z/fHrb0XO3n+orQVDhu1gEk1W7Fq6wxs84sk/5x8BQQZIPP/yPLKX/H99T9mkick7H9FROabEMtZ8eEfAR7zsZK+FF5taJHwgv0RWODptW87Lv+PtFwp3VF82rVouJXK5b88q7wxeGa5J8b/yw38sqCfWKxz0w2iDi4xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750412103; c=relaxed/simple;
	bh=Lkw3pSQ2w7zkPK8jgUIhwt4AGIJYnCY10wjXnXC+sz0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=O6DeGxQCzeG192YasgHgMVGUpBQKTtIYK+d8a/oOuuHRd9+NiFlysFYNO8kq9iVo8wsLriMvlRh6TYHrKtAi6lSvTjydyHs0E5hwTybE81rcdeKbOKDf7/wTzhKQ7IvXnZ3mEMfytIl1bLNmLrx/3TCIZLTBoD1taJzcYCM9hTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XQQjGC/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95286C4CEE3;
	Fri, 20 Jun 2025 09:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750412103;
	bh=Lkw3pSQ2w7zkPK8jgUIhwt4AGIJYnCY10wjXnXC+sz0=;
	h=Subject:To:Cc:From:Date:From;
	b=XQQjGC/dXEsw2iTfTcmlC21o2NqAkcO/RH770QIpQ3yecINVAk/aVBBQBdEB7Eja9
	 J18UmnTEWmbxho7QZIaYbjvc7BXhnbHXmVhxZG5P94+sNrc5hS4T1VFCjBf0H245QS
	 Wc+oIDoE1i0ZSGahqvBezCVdJA9QdtNwJBmct6TA=
Subject: FAILED: patch "[PATCH] iio: accel: fxls8962af: Fix temperature calculation" failed to apply to 6.1-stable tree
To: sean@geanix.com,Jonathan.Cameron@huawei.com,marcelo.schmitt1@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 11:34:52 +0200
Message-ID: <2025062052-quadrant-bagging-7786@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 16038474e3a0263572f36326ef85057aaf341814
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062052-quadrant-bagging-7786@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 16038474e3a0263572f36326ef85057aaf341814 Mon Sep 17 00:00:00 2001
From: Sean Nyekjaer <sean@geanix.com>
Date: Mon, 5 May 2025 21:20:07 +0200
Subject: [PATCH] iio: accel: fxls8962af: Fix temperature calculation

According to spec temperature should be returned in milli degrees Celsius.
Add in_temp_scale to calculate from Celsius to milli Celsius.

Fixes: a3e0b51884ee ("iio: accel: add support for FXLS8962AF/FXLS8964AF accelerometers")
Cc: stable@vger.kernel.org
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Link: https://patch.msgid.link/20250505-fxls-v4-1-a38652e21738@geanix.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index bf1d3923a181..5f5e917f7aa5 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -23,6 +23,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
+#include <linux/units.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
@@ -439,8 +440,16 @@ static int fxls8962af_read_raw(struct iio_dev *indio_dev,
 		*val = FXLS8962AF_TEMP_CENTER_VAL;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = 0;
-		return fxls8962af_read_full_scale(data, val2);
+		switch (chan->type) {
+		case IIO_TEMP:
+			*val = MILLIDEGREE_PER_DEGREE;
+			return IIO_VAL_INT;
+		case IIO_ACCEL:
+			*val = 0;
+			return fxls8962af_read_full_scale(data, val2);
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return fxls8962af_read_samp_freq(data, val, val2);
 	default:
@@ -736,6 +745,7 @@ static const struct iio_event_spec fxls8962af_event[] = {
 	.type = IIO_TEMP, \
 	.address = FXLS8962AF_TEMP_OUT, \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			      BIT(IIO_CHAN_INFO_SCALE) | \
 			      BIT(IIO_CHAN_INFO_OFFSET),\
 	.scan_index = -1, \
 	.scan_type = { \


