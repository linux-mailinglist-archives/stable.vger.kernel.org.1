Return-Path: <stable+bounces-185920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 939C8BE2460
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 11:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92E331882463
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 09:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B792530F558;
	Thu, 16 Oct 2025 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UXA97+J7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E6E2C0F70
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605249; cv=none; b=r8LYwaZB9KJ/ST7anUZI8jheK4e8eiJKIpzeCM4yu+0Ob8fuLSPc7bEDxV3LOjZdNFSj0PzgYexX8g1hjHlu6mChE23q6/1NtunKpGrq0pg9aAyTkUovp3yITOB4w3OgCLMveja828y93X7bjkoAAszaN5sb9e7ZRyCX2pTtw8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605249; c=relaxed/simple;
	bh=ZecoyxmDurO53Vkf+bSV9mNkDT/juKocELqK32U85jo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Yj6TNpOroYIxpRquqjxyHlaRL5+HMwUwWGKschY1M2mKpHaw244zzK+PkaROXteIxsLEj/HuCgh6+X6PQZ36B7Pum+a4W7Xdqqa+tTdYyZAj54WqH22Co5MvDCpxcWwsqyThzIGFTJiZ5R6+TssxqOKWBM9/JpUQa+R9Lo1bxtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UXA97+J7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3090C4CEF1;
	Thu, 16 Oct 2025 09:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760605249;
	bh=ZecoyxmDurO53Vkf+bSV9mNkDT/juKocELqK32U85jo=;
	h=Subject:To:Cc:From:Date:From;
	b=UXA97+J7cz+RZNH6yx9IGkb/AvQoAvxbp9UXf0k9ImffP7+iNxvVn8xNnC2wQhC1f
	 qf0FwJ0DKfPLAkORZqBAb+VvHhV6xY9cCOOx6Cjob2zgdCGAJ2I7aIrhoCqLtjzFc9
	 J036EhscM6ZVBuDwJ/iy9pKfP3smUegSZ4XksDNc=
Subject: FAILED: patch "[PATCH] media: s5p-mfc: remove an unused/uninitialized variable" failed to apply to 6.6-stable tree
To: arnd@arndb.de,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 11:00:46 +0200
Message-ID: <2025101646-unfunded-bootlace-0264@gregkh>
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
git cherry-pick -x 7fa37ba25a1dfc084e24ea9acc14bf1fad8af14c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101646-unfunded-bootlace-0264@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7fa37ba25a1dfc084e24ea9acc14bf1fad8af14c Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 7 Aug 2025 22:54:15 +0200
Subject: [PATCH] media: s5p-mfc: remove an unused/uninitialized variable

The s5p_mfc_cmd_args structure in the v6 driver is never used, not
initialized to anything other than zero, but as of clang-21 this
causes a warning:

drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c:45:7: error: variable 'h2r_args' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
   45 |                                         &h2r_args);
      |                                          ^~~~~~~~

Just remove this for simplicity. Since the function is also called
through a callback, this does require adding a trivial wrapper with
the correct prototype.

Fixes: f96f3cfa0bb8 ("[media] s5p-mfc: Update MFC v4l2 driver to support MFC6.x")
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
index 47bc3014b5d8..f7c682fca645 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
@@ -14,8 +14,7 @@
 #include "s5p_mfc_opr.h"
 #include "s5p_mfc_cmd_v6.h"
 
-static int s5p_mfc_cmd_host2risc_v6(struct s5p_mfc_dev *dev, int cmd,
-				    const struct s5p_mfc_cmd_args *args)
+static int s5p_mfc_cmd_host2risc_v6(struct s5p_mfc_dev *dev, int cmd)
 {
 	mfc_debug(2, "Issue the command: %d\n", cmd);
 
@@ -31,7 +30,6 @@ static int s5p_mfc_cmd_host2risc_v6(struct s5p_mfc_dev *dev, int cmd,
 
 static int s5p_mfc_sys_init_cmd_v6(struct s5p_mfc_dev *dev)
 {
-	struct s5p_mfc_cmd_args h2r_args;
 	const struct s5p_mfc_buf_size_v6 *buf_size = dev->variant->buf_size->priv;
 	int ret;
 
@@ -41,33 +39,23 @@ static int s5p_mfc_sys_init_cmd_v6(struct s5p_mfc_dev *dev)
 
 	mfc_write(dev, dev->ctx_buf.dma, S5P_FIMV_CONTEXT_MEM_ADDR_V6);
 	mfc_write(dev, buf_size->dev_ctx, S5P_FIMV_CONTEXT_MEM_SIZE_V6);
-	return s5p_mfc_cmd_host2risc_v6(dev, S5P_FIMV_H2R_CMD_SYS_INIT_V6,
-					&h2r_args);
+	return s5p_mfc_cmd_host2risc_v6(dev, S5P_FIMV_H2R_CMD_SYS_INIT_V6);
 }
 
 static int s5p_mfc_sleep_cmd_v6(struct s5p_mfc_dev *dev)
 {
-	struct s5p_mfc_cmd_args h2r_args;
-
-	memset(&h2r_args, 0, sizeof(struct s5p_mfc_cmd_args));
-	return s5p_mfc_cmd_host2risc_v6(dev, S5P_FIMV_H2R_CMD_SLEEP_V6,
-			&h2r_args);
+	return s5p_mfc_cmd_host2risc_v6(dev, S5P_FIMV_H2R_CMD_SLEEP_V6);
 }
 
 static int s5p_mfc_wakeup_cmd_v6(struct s5p_mfc_dev *dev)
 {
-	struct s5p_mfc_cmd_args h2r_args;
-
-	memset(&h2r_args, 0, sizeof(struct s5p_mfc_cmd_args));
-	return s5p_mfc_cmd_host2risc_v6(dev, S5P_FIMV_H2R_CMD_WAKEUP_V6,
-					&h2r_args);
+	return s5p_mfc_cmd_host2risc_v6(dev, S5P_FIMV_H2R_CMD_WAKEUP_V6);
 }
 
 /* Open a new instance and get its number */
 static int s5p_mfc_open_inst_cmd_v6(struct s5p_mfc_ctx *ctx)
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
-	struct s5p_mfc_cmd_args h2r_args;
 	int codec_type;
 
 	mfc_debug(2, "Requested codec mode: %d\n", ctx->codec_mode);
@@ -129,23 +117,20 @@ static int s5p_mfc_open_inst_cmd_v6(struct s5p_mfc_ctx *ctx)
 	mfc_write(dev, ctx->ctx.size, S5P_FIMV_CONTEXT_MEM_SIZE_V6);
 	mfc_write(dev, 0, S5P_FIMV_D_CRC_CTRL_V6); /* no crc */
 
-	return s5p_mfc_cmd_host2risc_v6(dev, S5P_FIMV_H2R_CMD_OPEN_INSTANCE_V6,
-					&h2r_args);
+	return s5p_mfc_cmd_host2risc_v6(dev, S5P_FIMV_H2R_CMD_OPEN_INSTANCE_V6);
 }
 
 /* Close instance */
 static int s5p_mfc_close_inst_cmd_v6(struct s5p_mfc_ctx *ctx)
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
-	struct s5p_mfc_cmd_args h2r_args;
 	int ret = 0;
 
 	dev->curr_ctx = ctx->num;
 	if (ctx->state != MFCINST_FREE) {
 		mfc_write(dev, ctx->inst_no, S5P_FIMV_INSTANCE_ID_V6);
 		ret = s5p_mfc_cmd_host2risc_v6(dev,
-					S5P_FIMV_H2R_CMD_CLOSE_INSTANCE_V6,
-					&h2r_args);
+					S5P_FIMV_H2R_CMD_CLOSE_INSTANCE_V6);
 	} else {
 		ret = -EINVAL;
 	}
@@ -153,9 +138,15 @@ static int s5p_mfc_close_inst_cmd_v6(struct s5p_mfc_ctx *ctx)
 	return ret;
 }
 
+static int s5p_mfc_cmd_host2risc_v6_args(struct s5p_mfc_dev *dev, int cmd,
+				    const struct s5p_mfc_cmd_args *ignored)
+{
+	return s5p_mfc_cmd_host2risc_v6(dev, cmd);
+}
+
 /* Initialize cmd function pointers for MFC v6 */
 static const struct s5p_mfc_hw_cmds s5p_mfc_cmds_v6 = {
-	.cmd_host2risc = s5p_mfc_cmd_host2risc_v6,
+	.cmd_host2risc = s5p_mfc_cmd_host2risc_v6_args,
 	.sys_init_cmd = s5p_mfc_sys_init_cmd_v6,
 	.sleep_cmd = s5p_mfc_sleep_cmd_v6,
 	.wakeup_cmd = s5p_mfc_wakeup_cmd_v6,


