Return-Path: <stable+bounces-155067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E061AE17A5
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07E43A752F
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D681028368D;
	Fri, 20 Jun 2025 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xnBxDeV0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958BF28315A
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750412106; cv=none; b=myJV53LqV7YVIh20BeWz12BuWnXXY9naxLzjB9TupuoPGX8XiST8LUkk328e7B2atuNa7PL/bZxxdfbZDAz4LHReiLyzziL79fJLPXC407GZpz4d46kLDV7OJaOkHDMfPn2n1Ts9q1ecQQ42W4JMqqWXpHui/xIUWmOSGR/R3Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750412106; c=relaxed/simple;
	bh=wc7Cm9KtbZ70oSTu1BG3ZzgPiOpDa0dKsFnefMLr6aU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Wzw1cxtXKr4acopa/bjq6Fs/DaZd3biTQMUT4W01LYSXA3y0LxUyWZIn3YV+eS5lJRnZHKB5qn+AxVY9P3ckmHu/3ZECzKzUmOSAK0rQQJlKX4ueqmIZi840Rp+WuKXARoB4r5bE4gzS7oNTHz5arQ1vuTjQdwHSbmPiT3yYLxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xnBxDeV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B67C4CEED;
	Fri, 20 Jun 2025 09:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750412106;
	bh=wc7Cm9KtbZ70oSTu1BG3ZzgPiOpDa0dKsFnefMLr6aU=;
	h=Subject:To:Cc:From:Date:From;
	b=xnBxDeV0oPs55iUWza5iLk2Ygldz7fNX/Qgfqe4RkMwoahqtNP8JZJdVQm6y+g950
	 facjTv4IQVb2w4WuvPakxhZBAT82ji9VezSynoBdVxFrchR2Y8ZDnN9QV9qgMC0cen
	 rxVlLYGJpg5f06oY1ghAhXQyZu3WoGzFdr23ewm4=
Subject: FAILED: patch "[PATCH] iio: accel: fxls8962af: Fix temperature calculation" failed to apply to 5.15-stable tree
To: sean@geanix.com,Jonathan.Cameron@huawei.com,marcelo.schmitt1@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 11:34:52 +0200
Message-ID: <2025062052-collar-amuser-47fe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 16038474e3a0263572f36326ef85057aaf341814
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062052-collar-amuser-47fe@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


