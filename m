Return-Path: <stable+bounces-186044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD52BE36F6
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7956F583086
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F4B326D50;
	Thu, 16 Oct 2025 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CnQlA+Yc"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CB931AF00
	for <Stable@vger.kernel.org>; Thu, 16 Oct 2025 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760618314; cv=none; b=iG3NjO82BTkZwptZZw7qJl0HXckZ9t7uvuDNxzj0x7MrlUpN43FldVhvoKGU7FsmHoPcIpCtAJ0ZDMkO7vX3c1bln3nOiKS2zl7HMzMGZ+4Mmg20cpfasMf3sqDWGE7GAa00eDf4vMekLTGmTVpaOjkZ6o1C8nNHxg8qHNxO/T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760618314; c=relaxed/simple;
	bh=c4nksWM7cXNse/NNTLlMrHSZsdpIL/sGnrHuvlGgYgg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MIMM7uH2QFVSDRLdPuYjsPc86nTAfcUMoIA3g/MpjE09MAUkZ9cIG+mSEbvtniF7CEp22zAgXWZ9OunWOVtt6yU17QGjFQ0tnXnJyyhoFzRld+nOnR7UmVd8FdPla6xVYr9xsv86Pjp+2k5cFFVSD/oAcrW+xRRbs3l7LRmxxUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CnQlA+Yc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB47DC4CEF1;
	Thu, 16 Oct 2025 12:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760618314;
	bh=c4nksWM7cXNse/NNTLlMrHSZsdpIL/sGnrHuvlGgYgg=;
	h=Subject:To:Cc:From:Date:From;
	b=CnQlA+YcYNx6XQtjRl/ZvoWj/lPydvuRzrFyoJPc284T780WRLM4k94NEIKaWR9Oy
	 f1et1b2uN9SmHx30NdpDU+MI7aYKaRxMuLaDZqxTpiv2ZqDMVu6vtG4+8VtqPr/6ay
	 RxS6zYBlYrSw8Rd+51MEmpG4k6tHT4zNDAFH0RZs=
Subject: FAILED: patch "[PATCH] iio: imu: inv_icm42600: Avoid configuring if already" failed to apply to 6.6-stable tree
To: sean@geanix.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:38:23 +0200
Message-ID: <2025101623-dry-crummiest-15b3@gregkh>
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
git cherry-pick -x 466f7a2fef2a4e426f809f79845a1ec1aeb558f4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101623-dry-crummiest-15b3@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 466f7a2fef2a4e426f809f79845a1ec1aeb558f4 Mon Sep 17 00:00:00 2001
From: Sean Nyekjaer <sean@geanix.com>
Date: Mon, 1 Sep 2025 09:49:15 +0200
Subject: [PATCH] iio: imu: inv_icm42600: Avoid configuring if already
 pm_runtime suspended

Do as in suspend, skip resume configuration steps if the device is already
pm_runtime suspended. This avoids reconfiguring a device that is already
in the correct low-power state and ensures that pm_runtime handles the
power state transitions properly.

Fixes: 31c24c1e93c3 ("iio: imu: inv_icm42600: add core of new inv_icm42600 driver")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Link: https://patch.msgid.link/20250901-icm42pmreg-v3-3-ef1336246960@geanix.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 41b275ecc7e2..ee780f530dc8 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -837,17 +837,15 @@ static int inv_icm42600_suspend(struct device *dev)
 	struct device *accel_dev;
 	bool wakeup;
 	int accel_conf;
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&st->lock);
 
 	st->suspended.gyro = st->conf.gyro.mode;
 	st->suspended.accel = st->conf.accel.mode;
 	st->suspended.temp = st->conf.temp_en;
-	if (pm_runtime_suspended(dev)) {
-		ret = 0;
+	if (pm_runtime_suspended(dev))
 		goto out_unlock;
-	}
 
 	/* disable FIFO data streaming */
 	if (st->fifo.on) {
@@ -900,10 +898,13 @@ static int inv_icm42600_resume(struct device *dev)
 	struct inv_icm42600_sensor_state *accel_st = iio_priv(st->indio_accel);
 	struct device *accel_dev;
 	bool wakeup;
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&st->lock);
 
+	if (pm_runtime_suspended(dev))
+		goto out_unlock;
+
 	/* check wakeup capability */
 	accel_dev = &st->indio_accel->dev;
 	wakeup = st->apex.on && device_may_wakeup(accel_dev);


