Return-Path: <stable+bounces-179505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2774EB561CE
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 17:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D16273BA45E
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 15:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAEE1A5B9E;
	Sat, 13 Sep 2025 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLDWwl4y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7236FC5
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757777453; cv=none; b=b8ogY0CIf5zyl7CLG/yozArKf5yzElRO8NFRkFkJIkJKZ1rdWD+x05IuQP/LNnKwBEjD532OzqAlo6y8ICCTn0XFx7iRdI4L8hg8+MUfIgnjxIdg01eFSar5GB2KKEYPbNZ1M7vbCpFGheH6jVWVUqwmeFMxW4I91pXLxOcWtTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757777453; c=relaxed/simple;
	bh=OyaqNmzZUPlW/gQfTvm/X2RI6dw6Ts+xPtX0SlJfOfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tx94khMv9drG8+cFFlz49UZ4zqtHWU806d01Jh6P2V38rH7/XSPbnr4wL92MtgvO1g4OoWZT9S9dFghk09e9kuqpLB16usflaDFFvDWSb3+7cxKOSU4/yEm/7QrcTCc+hj79UKDywV93iOqnNh8h70FhYPBvLBXVIh8+6b7na5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLDWwl4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103CAC4CEEB;
	Sat, 13 Sep 2025 15:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757777452;
	bh=OyaqNmzZUPlW/gQfTvm/X2RI6dw6Ts+xPtX0SlJfOfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SLDWwl4ySJMguegZyD0T2+i5CcbfNu0RQzi1QWIR1E+h7ZBgcgnYgL+PJaGudNbE8
	 oFlEN3fRg1rrHe9n074j7LKvTkvlvDqVoU8E+2IGqXwmbBL5mgFxuLDeatJ+7EyQbl
	 xAMZ3D27BwgMION39NQ5Nw+G7/zgMrAq+xYx+RdvFYFAWwpNhavaQQS1kdlI6IyjnT
	 +gEYQ8BQ4X6Mbp52EW+SksiyRR4V7lzNRYGqrmyBz4nL+3XLYny+sx9p/LzMP27gxZ
	 p0fHQE3ZMlV5LASFgoK+BP0Ws4F9Zn7IjDiqBPArwXB4gBh1rSttklNQ+twJQaeh5p
	 uJB0/wMuwB++w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 1/3] mtd: spinand: Add a ->configure_chip() hook
Date: Sat, 13 Sep 2025 11:30:47 -0400
Message-ID: <20250913153049.1419819-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091343-unmade-clapped-31e9@gregkh>
References: <2025091343-unmade-clapped-31e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit da55809ebb45d1d80b7a388ffef841ed683e1a6f ]

There is already a manufacturer hook, which is manufacturer specific but
not chip specific. We no longer have access to the actual NAND identity
at this stage so let's add a per-chip configuration hook to align the
chip configuration (if any) with the core's setting.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Stable-dep-of: 4550d33e1811 ("mtd: spinand: winbond: Fix oob_layout for W25N01JW")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/spi/core.c | 16 ++++++++++++++--
 include/linux/mtd/spinand.h |  7 +++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index b90f15c986a31..83e5e79e2f0db 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1253,8 +1253,19 @@ static int spinand_id_detect(struct spinand_device *spinand)
 
 static int spinand_manufacturer_init(struct spinand_device *spinand)
 {
-	if (spinand->manufacturer->ops->init)
-		return spinand->manufacturer->ops->init(spinand);
+	int ret;
+
+	if (spinand->manufacturer->ops->init) {
+		ret = spinand->manufacturer->ops->init(spinand);
+		if (ret)
+			return ret;
+	}
+
+	if (spinand->configure_chip) {
+		ret = spinand->configure_chip(spinand);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
@@ -1349,6 +1360,7 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->flags = table[i].flags;
 		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
+		spinand->configure_chip = table[i].configure_chip;
 		spinand->set_cont_read = table[i].set_cont_read;
 		spinand->fact_otp = &table[i].fact_otp;
 		spinand->user_otp = &table[i].user_otp;
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 15eaa09da998c..c13b088ef75f1 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -484,6 +484,7 @@ struct spinand_user_otp {
  * @op_variants.update_cache: variants of the update-cache operation
  * @select_target: function used to select a target/die. Required only for
  *		   multi-die chips
+ * @configure_chip: Align the chip configuration with the core settings
  * @set_cont_read: enable/disable continuous cached reads
  * @fact_otp: SPI NAND factory OTP info.
  * @user_otp: SPI NAND user OTP info.
@@ -507,6 +508,7 @@ struct spinand_info {
 	} op_variants;
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
+	int (*configure_chip)(struct spinand_device *spinand);
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
 	struct spinand_fact_otp fact_otp;
@@ -539,6 +541,9 @@ struct spinand_info {
 #define SPINAND_SELECT_TARGET(__func)					\
 	.select_target = __func
 
+#define SPINAND_CONFIGURE_CHIP(__configure_chip)			\
+	.configure_chip = __configure_chip
+
 #define SPINAND_CONT_READ(__set_cont_read)				\
 	.set_cont_read = __set_cont_read
 
@@ -607,6 +612,7 @@ struct spinand_dirmap {
  *		passed in spi_mem_op be DMA-able, so we can't based the bufs on
  *		the stack
  * @manufacturer: SPI NAND manufacturer information
+ * @configure_chip: Align the chip configuration with the core settings
  * @cont_read_possible: Field filled by the core once the whole system
  *		configuration is known to tell whether continuous reads are
  *		suitable to use or not in general with this chip/configuration.
@@ -647,6 +653,7 @@ struct spinand_device {
 	const struct spinand_manufacturer *manufacturer;
 	void *priv;
 
+	int (*configure_chip)(struct spinand_device *spinand);
 	bool cont_read_possible;
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
-- 
2.51.0


