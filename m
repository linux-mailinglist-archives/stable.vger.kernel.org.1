Return-Path: <stable+bounces-125499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EDFA6912A
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 521C2463C93
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E8D20A5C4;
	Wed, 19 Mar 2025 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y2Qs3A50"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23B61CAA81;
	Wed, 19 Mar 2025 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395233; cv=none; b=ozZj73IBt/hpZDe85iKzQQLkqNcm6wzOYMLDE6SLd6M1go8W5iMBtIGfZH1tqfYfpZO4A2AyiodRugmBCGRK7sgGbv29pm/6ocL1rFvkVU/Qz7nBp0DUETp4AAxtJx1ZdBi5CUh8BELBz3REEILDgadJTfrsQpEjyRVO6Vc/nXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395233; c=relaxed/simple;
	bh=idJjtViYpvgW4kY3UD0BsPTX2xgm1rwPNh/Gr901FAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ab7Pta/vYCRu3+CoJi14s/peOgW7GEQnB/en1aePE3SqnDE2gPiXMedAJ8gfcj14l3GKGr07Ec7cTdOKeN9ZpcQuyqpqlGTxcGw9AwNpfVPCnkyVA+3QaGdT3DdGkiunjCjM8BXzqC3YO5QbN4tLo1AdNrAUPSs66jvNmOqvxUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y2Qs3A50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9185EC4CEE8;
	Wed, 19 Mar 2025 14:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742395233;
	bh=idJjtViYpvgW4kY3UD0BsPTX2xgm1rwPNh/Gr901FAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y2Qs3A50eq+PXdOl7+eVxnhCnNONMgS0LXVybOfY7ITxCkcZIBELK6aCAGIXLigTp
	 03EwVtSiYmj4hhjsC/OazAQFD7EUnLdOnX8jgd/pzf6gpPdRIh3TB0aEVLijpK1IoF
	 1HuIc3w2okMUbaHfjA2d3BtvSNNBpVcMK44HNRZ4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff LaBundy <jeff@labundy.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6.6 105/166] Input: iqs7222 - preserve system status register
Date: Wed, 19 Mar 2025 07:31:16 -0700
Message-ID: <20250319143022.862148910@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143019.983527953@linuxfoundation.org>
References: <20250319143019.983527953@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff LaBundy <jeff@labundy.com>

commit a2add513311b48cc924a699a8174db2c61ed5e8a upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/misc/iqs7222.c |   50 ++++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

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
@@ -286,6 +286,7 @@ static const struct iqs7222_event_desc i
 
 struct iqs7222_reg_grp_desc {
 	u16 base;
+	u16 val_len;
 	int num_row;
 	int num_col;
 };
@@ -342,6 +343,7 @@ static const struct iqs7222_dev_desc iqs
 			},
 			[IQS7222_REG_GRP_FILT] = {
 				.base = 0xAC00,
+				.val_len = 3,
 				.num_row = 1,
 				.num_col = 2,
 			},
@@ -400,6 +402,7 @@ static const struct iqs7222_dev_desc iqs
 			},
 			[IQS7222_REG_GRP_FILT] = {
 				.base = 0xAC00,
+				.val_len = 3,
 				.num_row = 1,
 				.num_col = 2,
 			},
@@ -454,6 +457,7 @@ static const struct iqs7222_dev_desc iqs
 			},
 			[IQS7222_REG_GRP_FILT] = {
 				.base = 0xC400,
+				.val_len = 3,
 				.num_row = 1,
 				.num_col = 2,
 			},
@@ -496,6 +500,7 @@ static const struct iqs7222_dev_desc iqs
 			},
 			[IQS7222_REG_GRP_FILT] = {
 				.base = 0xC400,
+				.val_len = 3,
 				.num_row = 1,
 				.num_col = 2,
 			},
@@ -543,6 +548,7 @@ static const struct iqs7222_dev_desc iqs
 			},
 			[IQS7222_REG_GRP_FILT] = {
 				.base = 0xAA00,
+				.val_len = 3,
 				.num_row = 1,
 				.num_col = 2,
 			},
@@ -600,6 +606,7 @@ static const struct iqs7222_dev_desc iqs
 			},
 			[IQS7222_REG_GRP_FILT] = {
 				.base = 0xAA00,
+				.val_len = 3,
 				.num_row = 1,
 				.num_col = 2,
 			},
@@ -656,6 +663,7 @@ static const struct iqs7222_dev_desc iqs
 			},
 			[IQS7222_REG_GRP_FILT] = {
 				.base = 0xAE00,
+				.val_len = 3,
 				.num_row = 1,
 				.num_col = 2,
 			},
@@ -712,6 +720,7 @@ static const struct iqs7222_dev_desc iqs
 			},
 			[IQS7222_REG_GRP_FILT] = {
 				.base = 0xAE00,
+				.val_len = 3,
 				.num_row = 1,
 				.num_col = 2,
 			},
@@ -768,6 +777,7 @@ static const struct iqs7222_dev_desc iqs
 			},
 			[IQS7222_REG_GRP_FILT] = {
 				.base = 0xAE00,
+				.val_len = 3,
 				.num_row = 1,
 				.num_col = 2,
 			},
@@ -1604,7 +1614,7 @@ static int iqs7222_force_comms(struct iq
 }
 
 static int iqs7222_read_burst(struct iqs7222_private *iqs7222,
-			      u16 reg, void *val, u16 num_val)
+			      u16 reg, void *val, u16 val_len)
 {
 	u8 reg_buf[sizeof(__be16)];
 	int ret, i;
@@ -1619,7 +1629,7 @@ static int iqs7222_read_burst(struct iqs
 		{
 			.addr = client->addr,
 			.flags = I2C_M_RD,
-			.len = num_val * sizeof(__le16),
+			.len = val_len,
 			.buf = (u8 *)val,
 		},
 	};
@@ -1675,7 +1685,7 @@ static int iqs7222_read_word(struct iqs7
 	__le16 val_buf;
 	int error;
 
-	error = iqs7222_read_burst(iqs7222, reg, &val_buf, 1);
+	error = iqs7222_read_burst(iqs7222, reg, &val_buf, sizeof(val_buf));
 	if (error)
 		return error;
 
@@ -1685,10 +1695,9 @@ static int iqs7222_read_word(struct iqs7
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
@@ -1747,7 +1756,7 @@ static int iqs7222_write_word(struct iqs
 {
 	__le16 val_buf = cpu_to_le16(val);
 
-	return iqs7222_write_burst(iqs7222, reg, &val_buf, 1);
+	return iqs7222_write_burst(iqs7222, reg, &val_buf, sizeof(val_buf));
 }
 
 static int iqs7222_ati_trigger(struct iqs7222_private *iqs7222)
@@ -1831,30 +1840,14 @@ static int iqs7222_dev_init(struct iqs72
 
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
@@ -1883,6 +1876,7 @@ static int iqs7222_dev_init(struct iqs72
 		int num_col = dev_desc->reg_grps[i].num_col;
 		u16 reg = dev_desc->reg_grps[i].base;
 		__le16 *val_buf;
+		u16 val_len = dev_desc->reg_grps[i].val_len ? : num_col * sizeof(*val_buf);
 		u16 *val;
 
 		if (!num_col)
@@ -1900,7 +1894,7 @@ static int iqs7222_dev_init(struct iqs72
 			switch (dir) {
 			case READ:
 				error = iqs7222_read_burst(iqs7222, reg,
-							   val_buf, num_col);
+							   val_buf, val_len);
 				for (k = 0; k < num_col; k++)
 					val[k] = le16_to_cpu(val_buf[k]);
 				break;
@@ -1909,7 +1903,7 @@ static int iqs7222_dev_init(struct iqs72
 				for (k = 0; k < num_col; k++)
 					val_buf[k] = cpu_to_le16(val[k]);
 				error = iqs7222_write_burst(iqs7222, reg,
-							    val_buf, num_col);
+							    val_buf, val_len);
 				break;
 
 			default:
@@ -1962,7 +1956,7 @@ static int iqs7222_dev_info(struct iqs72
 	int error, i;
 
 	error = iqs7222_read_burst(iqs7222, IQS7222_PROD_NUM, dev_id,
-				   ARRAY_SIZE(dev_id));
+				   sizeof(dev_id));
 	if (error)
 		return error;
 
@@ -2917,7 +2911,7 @@ static int iqs7222_report(struct iqs7222
 	__le16 status[IQS7222_MAX_COLS_STAT];
 
 	error = iqs7222_read_burst(iqs7222, IQS7222_SYS_STATUS, status,
-				   num_stat);
+				   num_stat * sizeof(*status));
 	if (error)
 		return error;
 



