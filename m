Return-Path: <stable+bounces-172640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB52B329D2
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 17:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B41E17ABCE8
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 15:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312E51F4C87;
	Sat, 23 Aug 2025 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1rN8mHgf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42CD21257A
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755963985; cv=none; b=lglRiZ9tH80fF3tB7YXTKlhQiHDyxPFmAAGCD/WMMT/ZSo/2nlDzODoV9brONjbtIm6fQUzi1nxvghuojLYJ+c1JBfta38haXHAS+4Z2iR6OQx1eR1xivqva6nixBF/u0p8EKQYNAvUbEvdq2i+BFVFtty3SNKZ+PXkaLYBZCwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755963985; c=relaxed/simple;
	bh=f3MPHrpBU+Kb/SsUB+iC9922/WEIfiMC3OKPL/y/frw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JCKRBvy986nhU6ORzFjasYqtUBr2AjC5OyQ0DTR5Cj4a08NEq7WH9n7KCfttaE3BoVhV/u6+4wAnKlHM0cNNPfmTc5V8zI868ZzEUXZIKcjM12NNNNY3hLGIkJPbqgkWjzO7VrZq2lJdkJA7/vJgZbnG5G4isNey77OYkG9J3xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1rN8mHgf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191ECC4CEF4;
	Sat, 23 Aug 2025 15:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755963984;
	bh=f3MPHrpBU+Kb/SsUB+iC9922/WEIfiMC3OKPL/y/frw=;
	h=Subject:To:Cc:From:Date:From;
	b=1rN8mHgf8X5w37+MO/D03B9K9lJAfbHg1iPuO0mFQpp3pkzC4j+UwPfk+rR+5VpIO
	 x2/EqZfitj1nFVnY/rP/exJqrCx0CbT/yAdmS2mf+AnVAEQIVqpmR4o0WW3H3Nslhe
	 G5no1dubpxQw0i8iKLtEfKSH6sAdoYy62FuiysNk=
Subject: FAILED: patch "[PATCH] iio: imu: inv_icm42600: change invalid data error to -EBUSY" failed to apply to 6.12-stable tree
To: jean-baptiste.maneyrol@tdk.com,Jonathan.Cameron@huawei.com,andy@kernel.org,sean@geanix.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 23 Aug 2025 17:46:13 +0200
Message-ID: <2025082313-lubricant-traction-2a78@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x dfdc31e7ccf3ac1d5ec01d5120c71e14745e3dd8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082313-lubricant-traction-2a78@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


