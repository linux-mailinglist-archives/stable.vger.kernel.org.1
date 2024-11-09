Return-Path: <stable+bounces-91991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F4B9C2C4F
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 12:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A5528161C
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 11:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9318175D5E;
	Sat,  9 Nov 2024 11:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KnVEefo6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DF515443D
	for <stable@vger.kernel.org>; Sat,  9 Nov 2024 11:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731153309; cv=none; b=kx5M0+LFDRRGNmKMaesWzmu0Ht/aAB39/RQM3/JYNbIrGiiH1VH2egqyXnmKpkNGO292SvtYhwrB2O7NbNf/Ofg7BMdfVl43BR7YMupNQN7hdwukPooZs2THbOcyA+A9F0ca8qHJcCL0Qtnr6S1WOxkI7aT1qsFy+lae7gpuAh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731153309; c=relaxed/simple;
	bh=gnVXjW0AJ4ZglMou0WYu4fpm/7Yh2Aw1Ok1U7GzOOUo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Zs3Mbbh3rat5uuLhtnIdVMsiQF8GJyRa9tC87odzXcGMIIR+i7us3bXQSc14GboFg/XlJu4r+chn7H+Mt2VB2PdBdd/mZHkjdvFiIxXx+IJ5/FFd0YZqtfQScSkpYe/PkW1NpWGtgW8xdGTkooJ0RoYc+y790mqh9vbwac8syQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KnVEefo6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF655C4CECE;
	Sat,  9 Nov 2024 11:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731153309;
	bh=gnVXjW0AJ4ZglMou0WYu4fpm/7Yh2Aw1Ok1U7GzOOUo=;
	h=Subject:To:Cc:From:Date:From;
	b=KnVEefo6itWQNCKUKzcit1z2czIsbaUm71/D/YNTl3ttys+6yxE4RPtY5MJbNEYFh
	 wxJJ+IUDzr2209/fxmvjxGQyl1NP7lVqnUcd/HbKN0zVBg7ClL3tUtKdJF/GV9YPtb
	 5E9ZkFFfUPFksdALibgxE1/homzHtmNDlqdYChGo=
Subject: FAILED: patch "[PATCH] media: av7110: fix a spectre vulnerability" failed to apply to 5.4-stable tree
To: mchehab+huawei@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 09 Nov 2024 12:54:49 +0100
Message-ID: <2024110949-unseeing-smolder-1b43@gregkh>
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
git cherry-pick -x 458ea1c0be991573ec436aa0afa23baacfae101a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024110949-unseeing-smolder-1b43@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 458ea1c0be991573ec436aa0afa23baacfae101a Mon Sep 17 00:00:00 2001
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Tue, 15 Oct 2024 09:24:24 +0200
Subject: [PATCH] media: av7110: fix a spectre vulnerability

As warned by smatch:
	drivers/staging/media/av7110/av7110_ca.c:270 dvb_ca_ioctl() warn: potential spectre issue 'av7110->ci_slot' [w] (local cap)

There is a spectre-related vulnerability at the code. Fix it.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/drivers/staging/media/av7110/av7110.h b/drivers/staging/media/av7110/av7110.h
index ec461fd187af..b584754f4be0 100644
--- a/drivers/staging/media/av7110/av7110.h
+++ b/drivers/staging/media/av7110/av7110.h
@@ -88,6 +88,8 @@ struct infrared {
 	u32			ir_config;
 };
 
+#define MAX_CI_SLOTS	2
+
 /* place to store all the necessary device information */
 struct av7110 {
 	/* devices */
@@ -163,7 +165,7 @@ struct av7110 {
 
 	/* CA */
 
-	struct ca_slot_info	ci_slot[2];
+	struct ca_slot_info	ci_slot[MAX_CI_SLOTS];
 
 	enum av7110_video_mode	vidmode;
 	struct dmxdev		dmxdev;
diff --git a/drivers/staging/media/av7110/av7110_ca.c b/drivers/staging/media/av7110/av7110_ca.c
index 6ce212c64e5d..fce4023c9dea 100644
--- a/drivers/staging/media/av7110/av7110_ca.c
+++ b/drivers/staging/media/av7110/av7110_ca.c
@@ -26,23 +26,28 @@
 
 void CI_handle(struct av7110 *av7110, u8 *data, u16 len)
 {
+	unsigned slot_num;
+
 	dprintk(8, "av7110:%p\n", av7110);
 
 	if (len < 3)
 		return;
 	switch (data[0]) {
 	case CI_MSG_CI_INFO:
-		if (data[2] != 1 && data[2] != 2)
+		if (data[2] != 1 && data[2] != MAX_CI_SLOTS)
 			break;
+
+		slot_num = array_index_nospec(data[2] - 1, MAX_CI_SLOTS);
+
 		switch (data[1]) {
 		case 0:
-			av7110->ci_slot[data[2] - 1].flags = 0;
+			av7110->ci_slot[slot_num].flags = 0;
 			break;
 		case 1:
-			av7110->ci_slot[data[2] - 1].flags |= CA_CI_MODULE_PRESENT;
+			av7110->ci_slot[slot_num].flags |= CA_CI_MODULE_PRESENT;
 			break;
 		case 2:
-			av7110->ci_slot[data[2] - 1].flags |= CA_CI_MODULE_READY;
+			av7110->ci_slot[slot_num].flags |= CA_CI_MODULE_READY;
 			break;
 		}
 		break;
@@ -262,15 +267,19 @@ static int dvb_ca_ioctl(struct file *file, unsigned int cmd, void *parg)
 	case CA_GET_SLOT_INFO:
 	{
 		struct ca_slot_info *info = (struct ca_slot_info *)parg;
+		unsigned int slot_num;
 
 		if (info->num < 0 || info->num > 1) {
 			mutex_unlock(&av7110->ioctl_mutex);
 			return -EINVAL;
 		}
-		av7110->ci_slot[info->num].num = info->num;
-		av7110->ci_slot[info->num].type = FW_CI_LL_SUPPORT(av7110->arm_app) ?
-							CA_CI_LINK : CA_CI;
-		memcpy(info, &av7110->ci_slot[info->num], sizeof(struct ca_slot_info));
+		slot_num = array_index_nospec(info->num, MAX_CI_SLOTS);
+
+		av7110->ci_slot[slot_num].num = info->num;
+		av7110->ci_slot[slot_num].type = FW_CI_LL_SUPPORT(av7110->arm_app) ?
+						 CA_CI_LINK : CA_CI;
+		memcpy(info, &av7110->ci_slot[slot_num],
+		       sizeof(struct ca_slot_info));
 		break;
 	}
 


