Return-Path: <stable+bounces-172642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA81BB329D9
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 17:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306F51C227CE
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 15:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA052C15BF;
	Sat, 23 Aug 2025 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t7GzVGDZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8262E92C4
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755963990; cv=none; b=BVNq3emPHn5evwZ144u8QcYmkfEKXxaHm4veZhLzf3vv65rC8hW6LmF1jfuHQvYIME5eVCJGj44PyNO0z2rNH3mdAWAdQOzM+Usq434FHl/UojJPuzx4UxYS4UQkuZvVPepgwSaaEkLkMIZwtS5Ry5py50MIt0gnNDq0t689RqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755963990; c=relaxed/simple;
	bh=TqrjLgf0zWtJq2wLzjpNvc2myMPwmp6JkeuyRv7fpN8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=M93rdCdf7nz6zB45f8cU2jAXn+Q/voYdGU8AtippfRnb2ZLmoTrR1qpP8G07wLXdgjQ9n0BC6lAr8Z0Uw0eVjFa3V3wdRKPYKkvdSgTZSOyy5hfN4IhjE62Xdxy+8z9naX/n5+SEzWBZOS+ZIjM0oGlDWA1EpTDfviSv6Pr7deU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t7GzVGDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E9CC4CEE7;
	Sat, 23 Aug 2025 15:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755963990;
	bh=TqrjLgf0zWtJq2wLzjpNvc2myMPwmp6JkeuyRv7fpN8=;
	h=Subject:To:Cc:From:Date:From;
	b=t7GzVGDZrJQpDro/iEiGIdBHNTjlioK3bSg2NRHIXfP8lfWckhcTQVPoN3z4JULyG
	 PJ62xx3/w3QUvgQMi4iewMQduYyOqCRj3EcYAppJ8z93KhW/Qc3GbfICtCFdkPMssI
	 VSNRkW1mrJpKX1dtzbVV23q1WWS3SlmObT1y/1Z8=
Subject: FAILED: patch "[PATCH] iio: imu: inv_icm42600: change invalid data error to -EBUSY" failed to apply to 6.6-stable tree
To: jean-baptiste.maneyrol@tdk.com,Jonathan.Cameron@huawei.com,andy@kernel.org,sean@geanix.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 23 Aug 2025 17:46:14 +0200
Message-ID: <2025082314-steed-eldercare-ccf9@gregkh>
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
git cherry-pick -x dfdc31e7ccf3ac1d5ec01d5120c71e14745e3dd8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082314-steed-eldercare-ccf9@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dfdc31e7ccf3ac1d5ec01d5120c71e14745e3dd8 Mon Sep 17 00:00:00 2001
From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Date: Fri, 8 Aug 2025 09:40:10 +0200
Subject: [PATCH] iio: imu: inv_icm42600: change invalid data error to -EBUSY

Temperature sensor returns the temperature of the mechanical parts
of the chip. If both accel and gyro are off, the temperature sensor is
also automatically turned off and returns invalid data.

In this case, returning -EBUSY error code is better then -EINVAL and
indicates userspace that it needs to retry reading temperature in
another context.

Fixes: bc3eb0207fb5 ("iio: imu: inv_icm42600: add temperature sensor support")
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Cc: stable@vger.kernel.org
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
Link: https://patch.msgid.link/20250808-inv-icm42600-change-temperature-error-code-v1-1-986fbf63b77d@tdk.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
index 8b15afca498c..271a4788604a 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
@@ -32,8 +32,12 @@ static int inv_icm42600_temp_read(struct inv_icm42600_state *st, s16 *temp)
 		goto exit;
 
 	*temp = (s16)be16_to_cpup(raw);
+	/*
+	 * Temperature data is invalid if both accel and gyro are off.
+	 * Return -EBUSY in this case.
+	 */
 	if (*temp == INV_ICM42600_DATA_INVALID)
-		ret = -EINVAL;
+		ret = -EBUSY;
 
 exit:
 	mutex_unlock(&st->lock);


