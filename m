Return-Path: <stable+bounces-185928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2915BE248A
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 11:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C103544355
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 09:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA072DEA99;
	Thu, 16 Oct 2025 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A4SDrC2C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7931A294
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605334; cv=none; b=J1FtwybJyie2CxpwLq/J/se2JO04pRgo+yes+fgxXFvL3kvSVEICSEx5G8vdjuN0rPWN6SQ57XDzkG9A24BnxB02Ck4WkyA+gLCoGttu/Nddn0Q92RK8IJeV5Yg1yaa7mo/1tgWqW5BrrOvsaIcwjXAPlarVvq4iv0zhbRdcEVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605334; c=relaxed/simple;
	bh=DGqAmf2ELkZh6orUrQv3mmztR9gRhqgkLKAuANwabfc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a4cplfMC9msfkRh21hu73ekaxjPimf/0TtoOht1HILn6ZD1Jg5/G+YfqfvlWtzZdHjivDCFJ8PU5BqqpQm6PTggKFuOS+HupBCY8ShGCzxMK3enoj9dn7lT2xs1cLPoarKFyjCP24nKjkEvC73KSHc/raETcw93kKxnSNRF/8W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A4SDrC2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD4CC4CEF1;
	Thu, 16 Oct 2025 09:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760605333;
	bh=DGqAmf2ELkZh6orUrQv3mmztR9gRhqgkLKAuANwabfc=;
	h=Subject:To:Cc:From:Date:From;
	b=A4SDrC2CWVlBNvI8IWJRT14ADljW1yEsctMGqhFH6/3lzpxrlhtFc3wSa1aq2KVbG
	 6zMdX9+2xoddRX2V2dAW2/65XAYNCEfbcZV+B2m61HQE256scLOuuCgrubBeX/Cs85
	 74IUNRdkru66ynG8dQwwiaxsf+IgycXE+3Rk5w14=
Subject: FAILED: patch "[PATCH] media: lirc: Fix error handling in lirc_register()" failed to apply to 5.10-stable tree
To: make24@iscas.ac.cn,hverkuil+cisco@kernel.org,sean@mess.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 11:02:07 +0200
Message-ID: <2025101607-carrousel-blush-1a4d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 4f4098c57e139ad972154077fb45c3e3141555dd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101607-carrousel-blush-1a4d@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


