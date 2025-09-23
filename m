Return-Path: <stable+bounces-181481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0816EB95D9F
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 14:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1930419C2637
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 12:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBCF288530;
	Tue, 23 Sep 2025 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xnI8KSo7"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3AF946A
	for <Stable@vger.kernel.org>; Tue, 23 Sep 2025 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758630865; cv=none; b=BoXC1uNDdKbO20ZbhMhL/0vAXFLC9V+uQeDKArWFJAMVrbfuTAwrulp4iJMWuPaPYdvAfaBu+V5r7XUMMTHStqLEWjKNoJhaELxMLddOfJR1ah3y7yj7wyCqUbck/0YcXxOfLSoHG5EJsKLrHPg5dgUOn39JvQMmTArzLdJC56U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758630865; c=relaxed/simple;
	bh=x+NI7Dw86CizeGUglDrKFa14sMzXlIg6I0paPf6hBKc=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=O1Ue6ywtwzvhWrAtxtRM0k3fi5jpqBuDQYAiBRdGedzZ0kiHj/Uncg19HQQwA9H7rf+Wkz0RrZ0HXekEBn8g7nnzEt6HYq/Xf7YR6m1UqOwFXfbrba6ZoJ/Ypx5v2ZnQTTFJ7QBKOzilWkMjyRg9/k32OTcXQf7kwbfcgoBtjhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xnI8KSo7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3680FC4CEF5;
	Tue, 23 Sep 2025 12:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758630864;
	bh=x+NI7Dw86CizeGUglDrKFa14sMzXlIg6I0paPf6hBKc=;
	h=Subject:To:From:Date:From;
	b=xnI8KSo7432cVkf/MEz+nIxUxMrlyaDokXLy49dQ+i1JiUXf+TwQeRZYmjFYJ+b8b
	 4ejdoi3zE4TWA3yJ+xohLPiRvgmJUnzrOsxzZDA3NX35ex9wRmAZXzLI//7cDopWpR
	 +sEs3Gm5Za9vUIkYEHBacUr7lzjgNes0IogKkB2Y=
Subject: patch "iio: imu: inv_icm42600: Avoid configuring if already pm_runtime" added to char-misc-next
To: sean@geanix.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Sep 2025 14:19:21 +0200
Message-ID: <2025092321-distress-pogo-7d5c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: imu: inv_icm42600: Avoid configuring if already pm_runtime

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 466f7a2fef2a4e426f809f79845a1ec1aeb558f4 Mon Sep 17 00:00:00 2001
From: Sean Nyekjaer <sean@geanix.com>
Date: Mon, 1 Sep 2025 09:49:15 +0200
Subject: iio: imu: inv_icm42600: Avoid configuring if already pm_runtime
 suspended

Do as in suspend, skip resume configuration steps if the device is already
pm_runtime suspended. This avoids reconfiguring a device that is already
in the correct low-power state and ensures that pm_runtime handles the
power state transitions properly.

Fixes: 31c24c1e93c3 ("iio: imu: inv_icm42600: add core of new inv_icm42600 driver")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Link: https://patch.msgid.link/20250901-icm42pmreg-v3-3-ef1336246960@geanix.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

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
-- 
2.51.0



