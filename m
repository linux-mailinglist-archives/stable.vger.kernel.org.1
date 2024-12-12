Return-Path: <stable+bounces-103331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDAB9EF64A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C8428ABA4
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A622E176AA1;
	Thu, 12 Dec 2024 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rkYnGkrs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622BE215764;
	Thu, 12 Dec 2024 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024244; cv=none; b=RUWyyTEnSSVJaTmOKhk9beHqCj5DV9HBDCtxcjmpeU+b8F283C3Xcl95EpVSNxa+dya+ylzlAPfc5Qi8GLI4eXC0Xsd60ArLxsdqXSCO/+j0ELWY2M2XQ9FO+W6TruSazg5Y2wKej8wjVRYk/YARKWroW6VbDSs1MxGLHwOGDe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024244; c=relaxed/simple;
	bh=F/LTyNWHzeU84I/8xqIqys32jo8RII3bhFHEbAnc6uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FqHEps1SFj2RQiUGuAbPn4VuS7wxfD/p3DKrnJkhvk1Eg3iR8yH/9U5ObBC1yjSgEBM0uBZ13KA9qaLJPHryFX3Rgnot3T0Gl1//jM6lwT5ujHC+Zk0Azz3kKgthXBDYuOkPqyowPcSocIEaUXWQxBL2gBWBUVMAL5Mp+sqQqWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rkYnGkrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819D3C4CEE0;
	Thu, 12 Dec 2024 17:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734024244;
	bh=F/LTyNWHzeU84I/8xqIqys32jo8RII3bhFHEbAnc6uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rkYnGkrsfauc1ZvQkPMqlAOjVL1AlHgZfh+l78vWGXrKbq7qjdPJ5bwWUJOx7cBjm
	 8gbgyGGy3u2I3rWlZzgnKcfWAjZz7r+3b2JbZ8pSE8yF+VJ5OB4X9jpPwB7oU+d3Cc
	 MtWbOu5DNI119dWdFYYV6S4u1czdtXCLpxNHLQe8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oliver Neukum <oneukum@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 233/459] usb: yurex: make waiting on yurex_write interruptible
Date: Thu, 12 Dec 2024 15:59:31 +0100
Message-ID: <20241212144302.772745698@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

[ Upstream commit e0aa9614ab0fd35b404e4b16ebe879f9fc152591 ]

The IO yurex_write() needs to wait for in order to have a device
ready for writing again can take a long time time.
Consequently the sleep is done in an interruptible state.
Therefore others waiting for yurex_write() itself to finish should
use mutex_lock_interruptible.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Fixes: 6bc235a2e24a5 ("USB: add driver for Meywa-Denki & Kayac YUREX")
Rule: add
Link: https://lore.kernel.org/stable/20240924084415.300557-1-oneukum%40suse.com
Link: https://lore.kernel.org/r/20240924084415.300557-1-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/misc/iowarrior.c | 4 ----
 drivers/usb/misc/yurex.c     | 5 ++++-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index c06238ce70eaa..2a0036d8fc292 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -915,7 +915,6 @@ static int iowarrior_probe(struct usb_interface *interface,
 static void iowarrior_disconnect(struct usb_interface *interface)
 {
 	struct iowarrior *dev = usb_get_intfdata(interface);
-	int minor = dev->minor;
 
 	usb_deregister_dev(interface, &iowarrior_class);
 
@@ -939,9 +938,6 @@ static void iowarrior_disconnect(struct usb_interface *interface)
 		mutex_unlock(&dev->mutex);
 		iowarrior_delete(dev);
 	}
-
-	dev_info(&interface->dev, "I/O-Warror #%d now disconnected\n",
-		 minor - IOWARRIOR_MINOR_BASE);
 }
 
 /* usb specific object needed to register this driver with the usb subsystem */
diff --git a/drivers/usb/misc/yurex.c b/drivers/usb/misc/yurex.c
index 8bc7c683bf836..36192fbf915a6 100644
--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -440,7 +440,10 @@ static ssize_t yurex_write(struct file *file, const char __user *user_buffer,
 	if (count == 0)
 		goto error;
 
-	mutex_lock(&dev->io_mutex);
+	retval = mutex_lock_interruptible(&dev->io_mutex);
+	if (retval < 0)
+		return -EINTR;
+
 	if (dev->disconnected) {		/* already disconnected */
 		mutex_unlock(&dev->io_mutex);
 		retval = -ENODEV;
-- 
2.43.0




