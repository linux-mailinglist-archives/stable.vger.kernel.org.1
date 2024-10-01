Return-Path: <stable+bounces-78405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1DA98B96D
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9864A2845FE
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452CF1A08AB;
	Tue,  1 Oct 2024 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uSm5LmDv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060DC192D74
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 10:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778131; cv=none; b=VrYUe6Vs70tK26R2ewbktQc6P1Gas6Ut/0KE1S+hDNxS+KUepliGTvhkXYIp+SQ4XiXVgS8Mnj2iyV1+auiJD8H2WPmhvSxuZwpMGHLB7rT9rh5cuybR059DbT6iVa5RYwnwM448pJA0VPkbG9hUpDJdXt0/ktPrcCAauFkWkUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778131; c=relaxed/simple;
	bh=Rqi8H5jrs/JLuRwjKjOQwttJlR94dwNoXfNShOWDbaU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UbaRftcYfUrJIx47QzpvwCg70qPVBW57mr/yZC4GYAnRK57wrN/h6nqL78YeYiuQZTv7Gu+5EyXOfdh3PstAR6w+Vm8EivXZlYmZAE7ZUFsjjpfuF5VGhnaZiS/sTvL00sLtI+DMhqSktnAcTHwbusiqLO0rzIdHU7LLgiDIKpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uSm5LmDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A9BC4CEC6;
	Tue,  1 Oct 2024 10:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727778130;
	bh=Rqi8H5jrs/JLuRwjKjOQwttJlR94dwNoXfNShOWDbaU=;
	h=Subject:To:Cc:From:Date:From;
	b=uSm5LmDvqJTEXPGrQKmLY8hazu2SZMQo3D/Sd18XbCUdQOt5RF/ZW+7hPxnEE+pPX
	 g+GBs4pWZ3lv+TJngP06JSoK1VqF0L4HdX0Fz93l7fvReUv7JRvFDXnPJ62SoYOca9
	 n6fpND011zY0X2/wkHaCGxK31pGeN+DGd4I/oe48=
Subject: FAILED: patch "[PATCH] USB: misc: yurex: fix race between read and write" failed to apply to 5.4-stable tree
To: oneukum@suse.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 12:21:58 +0200
Message-ID: <2024100158-doorstop-atom-5aa4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 93907620b308609c72ba4b95b09a6aa2658bb553
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100158-doorstop-atom-5aa4@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


