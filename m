Return-Path: <stable+bounces-185929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BBBBE247E
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 11:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523021895ED3
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 09:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838F7257853;
	Thu, 16 Oct 2025 09:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t34NOrm1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F3F1A294
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605337; cv=none; b=KmMVZw/FLPmdomtD5FijugBqXcFlKgjv5sKM8vNXOh7WuYVAcd3wmp5lhzA8FYtOlcYAMe/3aDpslEAL8FwcKou0NoiVsDPrHWn/eVl2BOXJxFDR9GzhNsOa5uN59veaWAB1pQf8CE7RjcEca0EBf8jSXXt2v3CakJLjLQlVT6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605337; c=relaxed/simple;
	bh=e1ZiOGMehnIyY4o2twrrNeFvvAIpzOjGs8fNl9rNREY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=o2R8oMbXayqOy8q32YFst4IQKbiHcHlNis1TFoYZlTQ1+RuD3YQWVGAitKPuW3OHPLX96ezLmdQ6qp0Uwm2Sa6Wf8q11+4YseWFeWvfbkVRBzkPDnpy7bQaCJGrT2/PJsEffm0zLDLxvByK9GBig2ynBPvBMX28hlZ0HwPb2TJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t34NOrm1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CE2C4CEF1;
	Thu, 16 Oct 2025 09:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760605336;
	bh=e1ZiOGMehnIyY4o2twrrNeFvvAIpzOjGs8fNl9rNREY=;
	h=Subject:To:Cc:From:Date:From;
	b=t34NOrm1K50b04F2FQFV56aLuMbpzQ5A8bBcEZXWLyoatf3jkTcbQZ2+xWqAZzosX
	 1mOP6igHVE4xDyu7pnwuTXHqarhdVdla2/S4m1p1DpLI7LwLrmEwk6il8/03v1WjLF
	 KmBmtjiV/lByQ9nMTqMj/zbghc3yZlz7Pf71q2Bo=
Subject: FAILED: patch "[PATCH] media: lirc: Fix error handling in lirc_register()" failed to apply to 5.15-stable tree
To: make24@iscas.ac.cn,hverkuil+cisco@kernel.org,sean@mess.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 11:02:07 +0200
Message-ID: <2025101607-boring-luminance-9766@gregkh>
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
git cherry-pick -x 4f4098c57e139ad972154077fb45c3e3141555dd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101607-boring-luminance-9766@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4f4098c57e139ad972154077fb45c3e3141555dd Mon Sep 17 00:00:00 2001
From: Ma Ke <make24@iscas.ac.cn>
Date: Fri, 18 Jul 2025 17:50:54 +0800
Subject: [PATCH] media: lirc: Fix error handling in lirc_register()

When cdev_device_add() failed, calling put_device() to explicitly
release dev->lirc_dev. Otherwise, it could cause the fault of the
reference count.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: a6ddd4fecbb0 ("media: lirc: remove last remnants of lirc kapi")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/rc/lirc_dev.c b/drivers/media/rc/lirc_dev.c
index a2257dc2f25d..7d4942925993 100644
--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -736,11 +736,11 @@ int lirc_register(struct rc_dev *dev)
 
 	cdev_init(&dev->lirc_cdev, &lirc_fops);
 
+	get_device(&dev->dev);
+
 	err = cdev_device_add(&dev->lirc_cdev, &dev->lirc_dev);
 	if (err)
-		goto out_ida;
-
-	get_device(&dev->dev);
+		goto out_put_device;
 
 	switch (dev->driver_type) {
 	case RC_DRIVER_SCANCODE:
@@ -764,7 +764,8 @@ int lirc_register(struct rc_dev *dev)
 
 	return 0;
 
-out_ida:
+out_put_device:
+	put_device(&dev->lirc_dev);
 	ida_free(&lirc_ida, minor);
 	return err;
 }


