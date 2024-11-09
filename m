Return-Path: <stable+bounces-91990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D058E9C2C4E
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 12:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91170280F74
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 11:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9424155389;
	Sat,  9 Nov 2024 11:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rHYE64SF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B3915443D
	for <stable@vger.kernel.org>; Sat,  9 Nov 2024 11:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731153306; cv=none; b=a6BoT68dMtfjo0kC2ICTYKskAOXOjHHM37kJOk/7CWryYRnAqk5vXmbtG39W5RcClQvbnqp2lVto+YdK4z4crsygu7566lRzZDLvPVvegFRqrl9cqkasB/zgJC+aifS6w88N2M1FGXnOu6KLBcAiTvJdCB+Mq+ZjepK+YhVQATE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731153306; c=relaxed/simple;
	bh=+yw76SmKUb0yrleqHhk5JNXxVql8RVkpODtxlHD7QiA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=le6/5SSv4yqwq6S08epv1DdFu45o4KVKOWiR1Pw/Rvr2Eng6UxP13kSS2xNC/+0hQ+FNruSMhR2EJnG5F17zZR7yHdG5PvEY/qb9+p9L3nIB8Id1O21QAzDoyL1UAakjJ5rh2Pz7ayixZAIe1D1Vj4xmwiHxKjsIozj1XV//EvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rHYE64SF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F77EC4CECE;
	Sat,  9 Nov 2024 11:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731153305;
	bh=+yw76SmKUb0yrleqHhk5JNXxVql8RVkpODtxlHD7QiA=;
	h=Subject:To:Cc:From:Date:From;
	b=rHYE64SFEIpT81ni0BLv0UyVT9/8gmVQ3LQYVWvpakFRpTpmsRx49ubkEdj9d2SXO
	 N90wMBj5pRTKG6a5pQxjr9wle2FBmwCOkL9bjRS/bvzoYiTznNFmz+ha1TKqM6frH3
	 80LjCkBXzpjgJe1kODU7F7Z3ReWVg3OhsceNil+E=
Subject: FAILED: patch "[PATCH] media: av7110: fix a spectre vulnerability" failed to apply to 5.15-stable tree
To: mchehab+huawei@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 09 Nov 2024 12:54:48 +0100
Message-ID: <2024110948-sharply-unissued-74b9@gregkh>
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
git cherry-pick -x 458ea1c0be991573ec436aa0afa23baacfae101a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024110948-sharply-unissued-74b9@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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
 


