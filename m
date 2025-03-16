Return-Path: <stable+bounces-124512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD86A63462
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 08:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5367E188C704
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 07:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8194514900B;
	Sun, 16 Mar 2025 07:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mHH3AJYd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308F42A1B2
	for <stable@vger.kernel.org>; Sun, 16 Mar 2025 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742108907; cv=none; b=ezZEBdYSaThz2rs/cYlA2fyjfPvDSgjF7HzIs7lZfjUiYJH1+F68cRF7mpBcdp282YjlyouNrbZZF8idYCjT/pK59FMKuV+yJlxq96Jl6hbO+yUcI0286mXKOPt6Rhd0DpPHPROweaL0z096TdB0y/+v9amMCSmvcDOXtoC/z+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742108907; c=relaxed/simple;
	bh=pQopdhR5B9u1/UDQBs4vIG4+jRgbEB2dSVM9vnfNzyQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AeKsa2qOORQgnbg9KvCqedoKB8vWQq401VJGmh9Mg3Uh4ubR7ccAOE2ZFZKNcBELFyb7CtwunQU0IB3AAf/jMaEC3bijXFlR+qnnH8vUaF8FXOAad/xgxI8mJS4D9Id7e45yd8o30rl9TO0P2+AmDGFbCHoOmqI3HYymrozMi58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mHH3AJYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA45C4CEDD;
	Sun, 16 Mar 2025 07:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742108906;
	bh=pQopdhR5B9u1/UDQBs4vIG4+jRgbEB2dSVM9vnfNzyQ=;
	h=Subject:To:Cc:From:Date:From;
	b=mHH3AJYdmjoW6p2bd/JN6oc5GZmSlqgQ8m+FDlMk3E4ObZ8nddVSzd0GmHzeVaIVZ
	 2zAek2Lb29QiI3A9qA1NkBMPNk+kST1uXWjOVLxjIE28GU6jPFfnMpPC8fkaQidWuy
	 dz53h2KwXucmUBa7t1Vt0dIMg4lnl3G7s08ZnxQA=
Subject: FAILED: patch "[PATCH] Input: iqs7222 - preserve system status register" failed to apply to 6.1-stable tree
To: jeff@labundy.com,dmitry.torokhov@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 16 Mar 2025 08:07:08 +0100
Message-ID: <2025031607-striking-creasing-c69c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a2add513311b48cc924a699a8174db2c61ed5e8a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025031607-striking-creasing-c69c@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a2add513311b48cc924a699a8174db2c61ed5e8a Mon Sep 17 00:00:00 2001
From: Jeff LaBundy <jeff@labundy.com>
Date: Sun, 9 Mar 2025 20:29:59 -0500
Subject: [PATCH] Input: iqs7222 - preserve system status register

Some register groups reserve a byte at the end of their continuous
address space. Depending on the variant of silicon, this field may
share the same memory space as the lower byte of the system status
register (0x10).

In these cases, caching the reserved byte and writing it later may
effectively reset the device depending on what happened in between
the read and write operations.

Solve this problem by avoiding any access to this last byte within
offending register groups. This method replaces a workaround which
attempted to write the reserved byte with up-to-date contents, but
left a small window in which updates by the device could have been
clobbered.

Now that the driver does not touch these reserved bytes, the order
in which the device's registers are written no longer matters, and
they can be written in their natural order. The new method is also
much more generic, and can be more easily extended to new variants
of silicon with different register maps.

As part of this change, the register read and write functions must
be gently updated to support byte access instead of word access.

Fixes: 2e70ef525b73 ("Input: iqs7222 - acknowledge reset before writing registers")
Signed-off-by: Jeff LaBundy <jeff@labundy.com>
Link: https://lore.kernel.org/r/Z85Alw+d9EHKXx2e@nixie71
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

diff --git a/drivers/input/misc/iqs7222.c b/drivers/input/misc/iqs7222.c
index 22022d11470d..80b917944b51 100644
--- a/drivers/input/misc/iqs7222.c
+++ b/drivers/input/misc/iqs7222.c
@@ -100,11 +100,11 @@ enum iqs7222_reg_key_id {
 
 enum iqs7222_reg_grp_id {
 	IQS7222_REG_GRP_STAT,
-	IQS7222_REG_GRP_FILT,
 	IQS7222_REG_GRP_CYCLE,
 	IQS7222_REG_GRP_GLBL,
 	IQS7222_REG_GRP_BTN,
 	IQS7222_REG_GRP_CHAN,
+	IQS7222_REG_GRP_FILT,
 	IQS7222_REG_GRP_SLDR,
 	IQS7222_REG_GRP_TPAD,
 	IQS7222_REG_GRP_GPIO,
@@ -286,6 +286,7 @@ static const struct iqs7222_event_desc iqs7222_tp_events[] = {
 
 struct iqs7222_reg_grp_desc {
 	u16 base;
+	u16 val_len;
 	int num_row;
 	int num_col;
 };
@@ -342,6 +343,7 @@ static const struct iqs7222_dev_desc iqs7222_devs[] = {
 			},
 			[IQS7222_REG_GRP_FILT] = {
 				.base = 0xAC00,
+				.val_len = 3,
 				.num_row = 1,
 				.num_col = 2,
 			},
@@ -400,6 +402,7 @@ static const struct iqs7222_dev_desc iqs7222_devs[] = {
 			},
 			[IQS7222_REG_GRP_FILT] = {
 				.base = 0xAC00,
+				.val_len = 3,
 				.num_row = 1,
 				.num_col = 2,
 			},
@@ -454,6 +457,7 @@ static const struct iqs7222_dev_desc iqs7222_devs[] = {
 			},
 			[IQS7222_REG_GRP_FILT] = {
 				.base = 0xC400,
+				.val_len = 3,
 				.num_row = 1,
 				.num_col = 2,
 			},
@@ -496,6 +500,7 @@ static const struct iqs7222_dev_desc iqs7222_devs[] = {
 			},
 			[IQS7222_REG_GRP_FILT] = {
 				.base = 0xC400,
+				.val_len = 3,
 				.num_row = 1,
 				.num_col = 2,
 			},
@@ -543,6 +548,7 @@ static const struct iqs7222_dev_desc iqs7222_devs[] = {
 			},
 			[IQS7222_REG_GRP_FILT] = {
 				.base = 0xAA00,
+				.val_len = 3,
 				.num_row = 1,
 				.num_col = 2,
 			},
@@ -600,6 +606,7 @@ static const struct iqs7222_dev_desc iqs7222_devs[] = {
 			},
 			[IQS7222_REG_GRP_FILT] = {
 				.base = 0xAA00,
+				.val_len = 3,
 				.num_row = 1,
 				.num_col = 2,
 			},
@@ -656,6 +663,7 @@ static const struct iqs7222_dev_desc iqs7222_devs[] = {
 			},
 			[IQS7222_REG_GRP_FILT] = {
 				.base = 0xAE00,
+				.val_len = 3,
 				.num_row = 1,
 				.num_col = 2,
 			},
@@ -712,6 +720,7 @@ static const struct iqs7222_dev_desc iqs7222_devs[] = {
 			},
 			[IQS7222_REG_GRP_FILT] = {
 				.base = 0xAE00,
+				.val_len = 3,
 				.num_row = 1,
 				.num_col = 2,
 			},
@@ -768,6 +777,7 @@ static const struct iqs7222_dev_desc iqs7222_devs[] = {
 			},
 			[IQS7222_REG_GRP_FILT] = {
 				.base = 0xAE00,
+				.val_len = 3,
 				.num_row = 1,
 				.num_col = 2,
 			},
@@ -1604,7 +1614,7 @@ static int iqs7222_force_comms(struct iqs7222_private *iqs7222)
 }
 
 static int iqs7222_read_burst(struct iqs7222_private *iqs7222,
-			      u16 reg, void *val, u16 num_val)
+			      u16 reg, void *val, u16 val_len)
 {
 	u8 reg_buf[sizeof(__be16)];
 	int ret, i;
@@ -1619,7 +1629,7 @@ static int iqs7222_read_burst(struct iqs7222_private *iqs7222,
 		{
 			.addr = client->addr,
 			.flags = I2C_M_RD,
-			.len = num_val * sizeof(__le16),
+			.len = val_len,
 			.buf = (u8 *)val,
 		},
 	};
@@ -1675,7 +1685,7 @@ static int iqs7222_read_word(struct iqs7222_private *iqs7222, u16 reg, u16 *val)
 	__le16 val_buf;
 	int error;
 
-	error = iqs7222_read_burst(iqs7222, reg, &val_buf, 1);
+	error = iqs7222_read_burst(iqs7222, reg, &val_buf, sizeof(val_buf));
 	if (error)
 		return error;
 
@@ -1685,10 +1695,9 @@ static int iqs7222_read_word(struct iqs7222_private *iqs7222, u16 reg, u16 *val)
 }
 
 static int iqs7222_write_burst(struct iqs7222_private *iqs7222,
-			       u16 reg, const void *val, u16 num_val)
+			       u16 reg, const void *val, u16 val_len)
 {
 	int reg_len = reg > U8_MAX ? sizeof(reg) : sizeof(u8);
-	int val_len = num_val * sizeof(__le16);
 	int msg_len = reg_len + val_len;
 	int ret, i;
 	struct i2c_client *client = iqs7222->client;
@@ -1747,7 +1756,7 @@ static int iqs7222_write_word(struct iqs7222_private *iqs7222, u16 reg, u16 val)
 {
 	__le16 val_buf = cpu_to_le16(val);
 
-	return iqs7222_write_burst(iqs7222, reg, &val_buf, 1);
+	return iqs7222_write_burst(iqs7222, reg, &val_buf, sizeof(val_buf));
 }
 
 static int iqs7222_ati_trigger(struct iqs7222_private *iqs7222)
@@ -1831,30 +1840,14 @@ static int iqs7222_dev_init(struct iqs7222_private *iqs7222, int dir)
 
 	/*
 	 * Acknowledge reset before writing any registers in case the device
-	 * suffers a spurious reset during initialization. Because this step
-	 * may change the reserved fields of the second filter beta register,
-	 * its cache must be updated.
-	 *
-	 * Writing the second filter beta register, in turn, may clobber the
-	 * system status register. As such, the filter beta register pair is
-	 * written first to protect against this hazard.
+	 * suffers a spurious reset during initialization.
 	 */
 	if (dir == WRITE) {
-		u16 reg = dev_desc->reg_grps[IQS7222_REG_GRP_FILT].base + 1;
-		u16 filt_setup;
-
 		error = iqs7222_write_word(iqs7222, IQS7222_SYS_SETUP,
 					   iqs7222->sys_setup[0] |
 					   IQS7222_SYS_SETUP_ACK_RESET);
 		if (error)
 			return error;
-
-		error = iqs7222_read_word(iqs7222, reg, &filt_setup);
-		if (error)
-			return error;
-
-		iqs7222->filt_setup[1] &= GENMASK(7, 0);
-		iqs7222->filt_setup[1] |= (filt_setup & ~GENMASK(7, 0));
 	}
 
 	/*
@@ -1883,6 +1876,7 @@ static int iqs7222_dev_init(struct iqs7222_private *iqs7222, int dir)
 		int num_col = dev_desc->reg_grps[i].num_col;
 		u16 reg = dev_desc->reg_grps[i].base;
 		__le16 *val_buf;
+		u16 val_len = dev_desc->reg_grps[i].val_len ? : num_col * sizeof(*val_buf);
 		u16 *val;
 
 		if (!num_col)
@@ -1900,7 +1894,7 @@ static int iqs7222_dev_init(struct iqs7222_private *iqs7222, int dir)
 			switch (dir) {
 			case READ:
 				error = iqs7222_read_burst(iqs7222, reg,
-							   val_buf, num_col);
+							   val_buf, val_len);
 				for (k = 0; k < num_col; k++)
 					val[k] = le16_to_cpu(val_buf[k]);
 				break;
@@ -1909,7 +1903,7 @@ static int iqs7222_dev_init(struct iqs7222_private *iqs7222, int dir)
 				for (k = 0; k < num_col; k++)
 					val_buf[k] = cpu_to_le16(val[k]);
 				error = iqs7222_write_burst(iqs7222, reg,
-							    val_buf, num_col);
+							    val_buf, val_len);
 				break;
 
 			default:
@@ -1962,7 +1956,7 @@ static int iqs7222_dev_info(struct iqs7222_private *iqs7222)
 	int error, i;
 
 	error = iqs7222_read_burst(iqs7222, IQS7222_PROD_NUM, dev_id,
-				   ARRAY_SIZE(dev_id));
+				   sizeof(dev_id));
 	if (error)
 		return error;
 
@@ -2915,7 +2909,7 @@ static int iqs7222_report(struct iqs7222_private *iqs7222)
 	__le16 status[IQS7222_MAX_COLS_STAT];
 
 	error = iqs7222_read_burst(iqs7222, IQS7222_SYS_STATUS, status,
-				   num_stat);
+				   num_stat * sizeof(*status));
 	if (error)
 		return error;
 


