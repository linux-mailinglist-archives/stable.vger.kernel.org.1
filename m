Return-Path: <stable+bounces-78404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9C198B96A
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5790E1F23526
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB941A08B6;
	Tue,  1 Oct 2024 10:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DmEdKyQr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E093C19CC2D
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778128; cv=none; b=ga7kTfSYwANYealrmL5QmuWTBzX48VFXHR/j7fL1UTmpi2gtN4+xzMKeCwpqM0y7t25rqCrjwJ8TidRg8n8PR4bRbO2gWUs4HVaNyjtoGTq2EeS9FIvXMZtYK56wKAu3edjJyw/LM6olZEqg8ZZ5eMZup4nCyYMAr83NrnIWPOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778128; c=relaxed/simple;
	bh=ubOPK61DiVG3Lx3DhQI/y2payCt/gztP33KGMRnEdpk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S6R0SbbDaosXXPjOoooMEqoHlT0a6oDXY48X6LBNR8dV1oiIEtL0ck9UFnU4fIauEy0CxDdcA2IxDGQulFt9tqaqqbmsRPVVYtQsQBnipD7BXRGqm5nRSk2BZGn0s/l/UcpeFjh8B8DpC+e326+1lA/wrFqPZKhpYG89ryMRojU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DmEdKyQr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662F1C4CEC6;
	Tue,  1 Oct 2024 10:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727778127;
	bh=ubOPK61DiVG3Lx3DhQI/y2payCt/gztP33KGMRnEdpk=;
	h=Subject:To:Cc:From:Date:From;
	b=DmEdKyQr9l5LzlPit7EVoDio8DYfPHefPTn+w+rsT2B9BScRmcf2NN9IP2FuQXffP
	 dWCXSbA2QHEJ/u3bFcSNYc695j9ursxlB6Q/Ybz1vLhTjAC/Dfly16KMIrqvZYfN3r
	 p91ev3T0oP9Q+zwXkGkUfUKOJNcmR2yHcqWxJqQo=
Subject: FAILED: patch "[PATCH] USB: misc: yurex: fix race between read and write" failed to apply to 5.15-stable tree
To: oneukum@suse.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 12:21:57 +0200
Message-ID: <2024100157-unsocial-jogger-5114@gregkh>
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
git cherry-pick -x 93907620b308609c72ba4b95b09a6aa2658bb553
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100157-unsocial-jogger-5114@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

93907620b308 ("USB: misc: yurex: fix race between read and write")
86b20af11e84 ("usb: yurex: Replace snprintf() with the safer scnprintf() variant")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 93907620b308609c72ba4b95b09a6aa2658bb553 Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oneukum@suse.com>
Date: Thu, 12 Sep 2024 15:21:22 +0200
Subject: [PATCH] USB: misc: yurex: fix race between read and write

The write code path touches the bbu member in a non atomic manner
without taking the spinlock. Fix it.

The bug is as old as the driver.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
CC: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240912132126.1034743-1-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/misc/yurex.c b/drivers/usb/misc/yurex.c
index 4745a320eae4..4a9859e03f6b 100644
--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -404,7 +404,6 @@ static ssize_t yurex_read(struct file *file, char __user *buffer, size_t count,
 	struct usb_yurex *dev;
 	int len = 0;
 	char in_buffer[MAX_S64_STRLEN];
-	unsigned long flags;
 
 	dev = file->private_data;
 
@@ -419,9 +418,9 @@ static ssize_t yurex_read(struct file *file, char __user *buffer, size_t count,
 		return -EIO;
 	}
 
-	spin_lock_irqsave(&dev->lock, flags);
+	spin_lock_irq(&dev->lock);
 	scnprintf(in_buffer, MAX_S64_STRLEN, "%lld\n", dev->bbu);
-	spin_unlock_irqrestore(&dev->lock, flags);
+	spin_unlock_irq(&dev->lock);
 	mutex_unlock(&dev->io_mutex);
 
 	return simple_read_from_buffer(buffer, count, ppos, in_buffer, len);
@@ -511,8 +510,11 @@ static ssize_t yurex_write(struct file *file, const char __user *user_buffer,
 			__func__, retval);
 		goto error;
 	}
-	if (set && timeout)
+	if (set && timeout) {
+		spin_lock_irq(&dev->lock);
 		dev->bbu = c2;
+		spin_unlock_irq(&dev->lock);
+	}
 	return timeout ? count : -EIO;
 
 error:


