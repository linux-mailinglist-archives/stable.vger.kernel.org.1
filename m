Return-Path: <stable+bounces-145825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A844ABF435
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B6513A8C4A
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 12:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EE8264A6E;
	Wed, 21 May 2025 12:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HLUjpRXp"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87E026462E
	for <Stable@vger.kernel.org>; Wed, 21 May 2025 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829811; cv=none; b=hF+YPX7foiov/g5fJPDZNT6J5vR8WTdVts0asjlJ/aGXT64/9cmKPhwMAWWFZtX3ro9zoXqvv2xUNLH2rvZT8bVou3DBoobcGENWhj/DSvoSNuph0Ft0YpdJkS2XwDXSqZOrjG6D0FmiYEFwm8HOlxMm9m0igQgEPXNB6o7CdAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829811; c=relaxed/simple;
	bh=4Go8FiKg26RZd3PjSOLrl1AY7m4fwkQKNQi38rRkrAU=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=nnTlyou36bK6vxk601rjHIXT7jg7hhv1nKoBJaPzbHc5RnuK45YORoeuqzEFgJTJzJSa2dP/66k5tx/sc2VUtadqpZBDx+CAkHzUz2yrXm8vUl4CPZq8l+4NvQqyFzya1iOQHQiKumGIVsqRhqLpwsi2A1yPRk/Pu7xDlxXo7D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HLUjpRXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED12C4CEE4;
	Wed, 21 May 2025 12:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747829811;
	bh=4Go8FiKg26RZd3PjSOLrl1AY7m4fwkQKNQi38rRkrAU=;
	h=Subject:To:From:Date:From;
	b=HLUjpRXpqTx9WZgywbdPM3TDQ8jp7FU8txtyjd+CgfuZbxvLJ4qwh9fIVhpp/IAy3
	 fCASApxOW/YqmQUU9h45FPidhVgbz4eXuHcpiYb+6Sr7rFtAdMgCTp7Br+JkKqcMsw
	 sksQcOxChCoa3USkGIcflvZ1fBgp2cu5Kj9l5HeY=
Subject: patch "iio: imu: inv_icm42600: Fix temperature calculation" added to char-misc-next
To: sean@geanix.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,jean-baptiste.maneyrol@tdk.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 May 2025 14:16:11 +0200
Message-ID: <2025052111-writing-spearmint-450a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: imu: inv_icm42600: Fix temperature calculation

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From e2f820014239df9360064079ae93f838ff3b7f8c Mon Sep 17 00:00:00 2001
From: Sean Nyekjaer <sean@geanix.com>
Date: Fri, 2 May 2025 11:37:26 +0200
Subject: iio: imu: inv_icm42600: Fix temperature calculation

>From the documentation:
"offset to be added to <type>[Y]_raw prior toscaling by <type>[Y]_scale"
Offset should be applied before multiplying scale, so divide offset by
scale to make this correct.

Fixes: bc3eb0207fb5 ("iio: imu: inv_icm42600: add temperature sensor support")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Link: https://patch.msgid.link/20250502-imu-v1-1-129b8391a4e3@geanix.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
index 213cce1c3111..91f0f381082b 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
@@ -67,16 +67,18 @@ int inv_icm42600_temp_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	/*
 	 * T°C = (temp / 132.48) + 25
-	 * Tm°C = 1000 * ((temp * 100 / 13248) + 25)
+	 * Tm°C = 1000 * ((temp / 132.48) + 25)
+	 * Tm°C = 7.548309 * temp + 25000
+	 * Tm°C = (temp + 3312) * 7.548309
 	 * scale: 100000 / 13248 ~= 7.548309
-	 * offset: 25000
+	 * offset: 3312
 	 */
 	case IIO_CHAN_INFO_SCALE:
 		*val = 7;
 		*val2 = 548309;
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_OFFSET:
-		*val = 25000;
+		*val = 3312;
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
-- 
2.49.0



