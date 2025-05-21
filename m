Return-Path: <stable+bounces-145820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AC1ABF400
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6589C7B69C6
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 12:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFB4267F5D;
	Wed, 21 May 2025 12:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oXe3XsGH"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B97267B92
	for <Stable@vger.kernel.org>; Wed, 21 May 2025 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829760; cv=none; b=Hi9C9WXUxXvYwJ6WVQtHVgrJfiVW/O3L5ZfEev0bXXjWfJNQPH1uJ/zQoDd9NCKte82p1mAQsd+oljbyh/OkinJ5clBOkrPGMVFQIbCCXn80ffZs4EJtB6rOrqKRUe061agr/8Ofccr5LvRdPrDk6f27EpHP5ucY5XxzM3SAvqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829760; c=relaxed/simple;
	bh=K9Dn3vnTQ9QBcKTYKhUiaFJakmNUF2oQzU3fneB4TeY=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=BMHqt+v89Ig2Bj+AlUBRROyndQwK1AQAtIYgJjYNAMzdsV2SKrKQIhfHQamuysFQm4rT7zTQIYVO6rXSsWfS29vTvTURjVPu+jG9N7fMOzI/u3kpEzowRx7jS4UPII47My74WX7dwvvn8qUTfzC+2IXIFtDr9UaTeJey4h0Cs5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oXe3XsGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB4EC4CEE7;
	Wed, 21 May 2025 12:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747829759;
	bh=K9Dn3vnTQ9QBcKTYKhUiaFJakmNUF2oQzU3fneB4TeY=;
	h=Subject:To:From:Date:From;
	b=oXe3XsGHeHw9rR1tQjIg52/jZq6pKHkM9L5ZWOxP/7lup+IjNTAU4GZK265l4kW0/
	 DQld9CKF1aUgMM54FCnrpnLtfjJ2V8VCTYE33a0GKkpaLOzA7bFG2HAx7fNhkI0lYh
	 0eQtC/fFUojEllEA8HmN78eUK5HIiOs1EMSHvWzs=
Subject: patch "iio: imu: inv_icm42600: Fix temperature calculation" added to char-misc-testing
To: sean@geanix.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,jean-baptiste.maneyrol@tdk.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 May 2025 14:15:49 +0200
Message-ID: <2025052149-luncheon-clarinet-1fc3@gregkh>
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
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

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



