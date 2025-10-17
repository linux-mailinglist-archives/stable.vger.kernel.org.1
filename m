Return-Path: <stable+bounces-187717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B569BEBFB2
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 01:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 597E84E1DBC
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 23:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6E613AD26;
	Fri, 17 Oct 2025 23:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oozWtpfQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC10354AE7
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 23:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760743093; cv=none; b=K/TTItGhEJGSeSw2kAO+dA6N2IOfK+tLg0BSehj2VziaQB7c7D10o4DwRW6eEQAoml0VfNstMTmRqjIS1RON6B9BHH8ac/qu1VsFQF34lJGV+U5W67Aahk/s0UEQAhdMnQTKJxCqbIlP+O5f2/SBnd/TlfeEDPXWhXTxW81UtMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760743093; c=relaxed/simple;
	bh=FejHJB5bTLCKMaVE2Q8+6k/9eSyGBUHoqQJnAkwAgEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EF7fqrPWvrZeMlntasHot5LwItkzejyR/D+X+oE3O8ULCKd5XUzZut12iPiHc+bxOsDPIbSce9f+7udFHbj3umLyejwP90bTpJPTUuIcH9sR5OpAKltwieNmrowdHDoB5QnjTdiLl2HDIVnjYihUBf9ZdK4aMiMMqJTtYhbDhMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oozWtpfQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E72AC4CEE7;
	Fri, 17 Oct 2025 23:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760743092;
	bh=FejHJB5bTLCKMaVE2Q8+6k/9eSyGBUHoqQJnAkwAgEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oozWtpfQm8bLOCOdjmrS6nmMjuSi8vdsAXK1k3ynDkS3xS8BQZGOPGbph1dZaaTIe
	 rmEc7BBzO11IE66YykzEc+jIqpabyrm2sX+PpAxeTwCOeY2wdapdKc9R0Jg5VpG65X
	 jo6RB+W/eC7IxboL4n7VRbmDrYXLCo8s2gZfpVuNsHvej2dOUMBsnzxVN/If2Si+l2
	 zPR0mEGTwf7eANXIcmv3WBPuQ9R4WUxYgWaJSZ/UrLNLIATdix+7xdcgmrl+elA2I3
	 0eMz/Nmd1V6gNG5xm7webcBUpjbYO0hzdeqetogsMtmqxua+rBOuZiV3DSwN+S5Vpu
	 iErwQ8zcdWCfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] media: s5p-mfc: remove an unused/uninitialized variable
Date: Fri, 17 Oct 2025 19:18:09 -0400
Message-ID: <20251017231809.29564-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101647-myspace-pavement-96d9@gregkh>
References: <2025101647-myspace-pavement-96d9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 7fa37ba25a1dfc084e24ea9acc14bf1fad8af14c ]

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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/platform/s5p-mfc/s5p_mfc_cmd_v6.c   | 35 +++++++------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v6.c b/drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v6.c
index 1f42130cc8658..23c47d92c0717 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v6.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v6.c
@@ -14,8 +14,7 @@
 #include "s5p_mfc_opr.h"
 #include "s5p_mfc_cmd_v6.h"
 
-static int s5p_mfc_cmd_host2risc_v6(struct s5p_mfc_dev *dev, int cmd,
-				struct s5p_mfc_cmd_args *args)
+static int s5p_mfc_cmd_host2risc_v6(struct s5p_mfc_dev *dev, int cmd)
 {
 	mfc_debug(2, "Issue the command: %d\n", cmd);
 
@@ -31,7 +30,6 @@ static int s5p_mfc_cmd_host2risc_v6(struct s5p_mfc_dev *dev, int cmd,
 
 static int s5p_mfc_sys_init_cmd_v6(struct s5p_mfc_dev *dev)
 {
-	struct s5p_mfc_cmd_args h2r_args;
 	struct s5p_mfc_buf_size_v6 *buf_size = dev->variant->buf_size->priv;
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
+				    struct s5p_mfc_cmd_args *ignored)
+{
+	return s5p_mfc_cmd_host2risc_v6(dev, cmd);
+}
+
 /* Initialize cmd function pointers for MFC v6 */
 static struct s5p_mfc_hw_cmds s5p_mfc_cmds_v6 = {
-	.cmd_host2risc = s5p_mfc_cmd_host2risc_v6,
+	.cmd_host2risc = s5p_mfc_cmd_host2risc_v6_args,
 	.sys_init_cmd = s5p_mfc_sys_init_cmd_v6,
 	.sleep_cmd = s5p_mfc_sleep_cmd_v6,
 	.wakeup_cmd = s5p_mfc_wakeup_cmd_v6,
-- 
2.51.0


