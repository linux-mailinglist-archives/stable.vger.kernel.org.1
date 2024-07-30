Return-Path: <stable+bounces-64616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF69941ED8
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6F81B25AB1
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBF2188017;
	Tue, 30 Jul 2024 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="thU0nR32"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EE61649C6;
	Tue, 30 Jul 2024 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360703; cv=none; b=YQcpQW7t3nQhv0p39255XNx1wcMJv7N8wfhOR1vvNA4Q+SX8jQCEEpoeQeZra7xPR2/7jhuACZ9Nh9VZIEGYG7p7V0xILa4oR8K7ZN1pel4q9ycrZ4sVzd1x8FZytOHu1qceq+X4WQy+qK4tMbqZpYzczlFFbbjhcVyoD/zYx9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360703; c=relaxed/simple;
	bh=rSsB6cyeTTiLJ7RKwjE9waAs5gdMe/mIx8PWDL/neic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=meqr2SEyFQEprnUhO+sCECCYs3FE/hWV6H7tEiGoClvxjjFFBKjeC70H/mMb+tiv3LKvJHPfCq9svCc5rabSDPVfqDwYk5TU4M1C4zfVPQrF1QcIm3ycnXR68AdYXP6CUEk/BIm16Sat4fsHNGG8WQdX+o4uSRbzTjSTBgHheX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=thU0nR32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B82BC32782;
	Tue, 30 Jul 2024 17:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722360703;
	bh=rSsB6cyeTTiLJ7RKwjE9waAs5gdMe/mIx8PWDL/neic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=thU0nR32VBGQoaCYbA2SSDrZP5+VaEvF41GkrtPRvPZi8QyllRujyuAMlykA/vXcz
	 q/N6FrPFYZbZiSvjUd/PlGJlo7uW5qoHt9i4ZItKjVl3HEFmmWuNgKBDTJ4ohh/c/y
	 1Og1y3xhT/C0Tn1CH0o6GTDGMCV0UmcXrsp238SA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steve Wilkins <steve.wilkins@raymarine.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 781/809] spi: microchip-core: only disable SPI controller when register value change requires it
Date: Tue, 30 Jul 2024 17:50:57 +0200
Message-ID: <20240730151755.814641527@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve Wilkins <steve.wilkins@raymarine.com>

[ Upstream commit de9850b5c606b754dd7861678d6e2874b96b04f8 ]

Setting up many of the registers for a new SPI transfer involves
unconditionally disabling the SPI controller, writing the register
value and re-enabling the controller. This is being done for registers
even when the value is unchanged and is also done for registers that
don't require the controller to be disabled for the change to take
effect. Make an effort to detect changes to the register values, and
only disables the controller if the new register value is different
and disabling the controller is required. This stops the controller
being repeated disabled and the bus going tristate before every
transfer.

Fixes: 9ac8d17694b6 ("spi: add support for microchip fpga spi controllers")
Signed-off-by: Steve Wilkins <steve.wilkins@raymarine.com>
Co-developed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://patch.msgid.link/20240715-depict-twirl-7e592eeabaad@wendy
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-microchip-core.c | 79 +++++++++++++++++---------------
 1 file changed, 41 insertions(+), 38 deletions(-)

diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
index 8043a18e7c3bd..65dbd59c45962 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -75,6 +75,7 @@
 
 #define REG_CONTROL		(0x00)
 #define REG_FRAME_SIZE		(0x04)
+#define  FRAME_SIZE_MASK	GENMASK(5, 0)
 #define REG_STATUS		(0x08)
 #define REG_INT_CLEAR		(0x0c)
 #define REG_RX_DATA		(0x10)
@@ -89,6 +90,7 @@
 #define REG_RIS			(0x24)
 #define REG_CONTROL2		(0x28)
 #define REG_COMMAND		(0x2c)
+#define  COMMAND_CLRFRAMECNT	BIT(4)
 #define REG_PKTSIZE		(0x30)
 #define REG_CMD_SIZE		(0x34)
 #define REG_HWSTATUS		(0x38)
@@ -149,62 +151,59 @@ static inline void mchp_corespi_read_fifo(struct mchp_corespi *spi)
 
 static void mchp_corespi_enable_ints(struct mchp_corespi *spi)
 {
-	u32 control, mask = INT_ENABLE_MASK;
-
-	mchp_corespi_disable(spi);
-
-	control = mchp_corespi_read(spi, REG_CONTROL);
-
-	control |= mask;
-	mchp_corespi_write(spi, REG_CONTROL, control);
+	u32 control = mchp_corespi_read(spi, REG_CONTROL);
 
-	control |= CONTROL_ENABLE;
+	control |= INT_ENABLE_MASK;
 	mchp_corespi_write(spi, REG_CONTROL, control);
 }
 
 static void mchp_corespi_disable_ints(struct mchp_corespi *spi)
 {
-	u32 control, mask = INT_ENABLE_MASK;
-
-	mchp_corespi_disable(spi);
-
-	control = mchp_corespi_read(spi, REG_CONTROL);
-	control &= ~mask;
-	mchp_corespi_write(spi, REG_CONTROL, control);
+	u32 control = mchp_corespi_read(spi, REG_CONTROL);
 
-	control |= CONTROL_ENABLE;
+	control &= ~INT_ENABLE_MASK;
 	mchp_corespi_write(spi, REG_CONTROL, control);
 }
 
 static inline void mchp_corespi_set_xfer_size(struct mchp_corespi *spi, int len)
 {
 	u32 control;
-	u16 lenpart;
+	u32 lenpart;
+	u32 frames = mchp_corespi_read(spi, REG_FRAMESUP);
 
 	/*
-	 * Disable the SPI controller. Writes to transfer length have
-	 * no effect when the controller is enabled.
+	 * Writing to FRAMECNT in REG_CONTROL will reset the frame count, taking
+	 * a shortcut requires an explicit clear.
 	 */
-	mchp_corespi_disable(spi);
+	if (frames == len) {
+		mchp_corespi_write(spi, REG_COMMAND, COMMAND_CLRFRAMECNT);
+		return;
+	}
 
 	/*
 	 * The lower 16 bits of the frame count are stored in the control reg
 	 * for legacy reasons, but the upper 16 written to a different register:
 	 * FRAMESUP. While both the upper and lower bits can be *READ* from the
-	 * FRAMESUP register, writing to the lower 16 bits is a NOP
+	 * FRAMESUP register, writing to the lower 16 bits is (supposedly) a NOP.
+	 *
+	 * The driver used to disable the controller while modifying the frame
+	 * count, and mask off the lower 16 bits of len while writing to
+	 * FRAMES_UP. When the driver was changed to disable the controller as
+	 * infrequently as possible, it was discovered that the logic of
+	 * lenpart = len & 0xffff_0000
+	 * write(REG_FRAMESUP, lenpart)
+	 * would actually write zeros into the lower 16 bits on an mpfs250t-es,
+	 * despite documentation stating these bits were read-only.
+	 * Writing len unmasked into FRAMES_UP ensures those bits aren't zeroed
+	 * on an mpfs250t-es and will be a NOP for the lower 16 bits on hardware
+	 * that matches the documentation.
 	 */
 	lenpart = len & 0xffff;
-
 	control = mchp_corespi_read(spi, REG_CONTROL);
 	control &= ~CONTROL_FRAMECNT_MASK;
 	control |= lenpart << CONTROL_FRAMECNT_SHIFT;
 	mchp_corespi_write(spi, REG_CONTROL, control);
-
-	lenpart = len & 0xffff0000;
-	mchp_corespi_write(spi, REG_FRAMESUP, lenpart);
-
-	control |= CONTROL_ENABLE;
-	mchp_corespi_write(spi, REG_CONTROL, control);
+	mchp_corespi_write(spi, REG_FRAMESUP, len);
 }
 
 static inline void mchp_corespi_write_fifo(struct mchp_corespi *spi)
@@ -227,17 +226,22 @@ static inline void mchp_corespi_write_fifo(struct mchp_corespi *spi)
 
 static inline void mchp_corespi_set_framesize(struct mchp_corespi *spi, int bt)
 {
+	u32 frame_size = mchp_corespi_read(spi, REG_FRAME_SIZE);
 	u32 control;
 
+	if ((frame_size & FRAME_SIZE_MASK) == bt)
+		return;
+
 	/*
 	 * Disable the SPI controller. Writes to the frame size have
 	 * no effect when the controller is enabled.
 	 */
-	mchp_corespi_disable(spi);
+	control = mchp_corespi_read(spi, REG_CONTROL);
+	control &= ~CONTROL_ENABLE;
+	mchp_corespi_write(spi, REG_CONTROL, control);
 
 	mchp_corespi_write(spi, REG_FRAME_SIZE, bt);
 
-	control = mchp_corespi_read(spi, REG_CONTROL);
 	control |= CONTROL_ENABLE;
 	mchp_corespi_write(spi, REG_CONTROL, control);
 }
@@ -334,8 +338,6 @@ static inline void mchp_corespi_set_clk_gen(struct mchp_corespi *spi)
 {
 	u32 control;
 
-	mchp_corespi_disable(spi);
-
 	control = mchp_corespi_read(spi, REG_CONTROL);
 	if (spi->clk_mode)
 		control |= CONTROL_CLKMODE;
@@ -344,12 +346,12 @@ static inline void mchp_corespi_set_clk_gen(struct mchp_corespi *spi)
 
 	mchp_corespi_write(spi, REG_CLK_GEN, spi->clk_gen);
 	mchp_corespi_write(spi, REG_CONTROL, control);
-	mchp_corespi_write(spi, REG_CONTROL, control | CONTROL_ENABLE);
 }
 
 static inline void mchp_corespi_set_mode(struct mchp_corespi *spi, unsigned int mode)
 {
-	u32 control, mode_val;
+	u32 mode_val;
+	u32 control = mchp_corespi_read(spi, REG_CONTROL);
 
 	switch (mode & SPI_MODE_X_MASK) {
 	case SPI_MODE_0:
@@ -367,12 +369,13 @@ static inline void mchp_corespi_set_mode(struct mchp_corespi *spi, unsigned int
 	}
 
 	/*
-	 * Disable the SPI controller. Writes to the frame size have
+	 * Disable the SPI controller. Writes to the frame protocol have
 	 * no effect when the controller is enabled.
 	 */
-	mchp_corespi_disable(spi);
 
-	control = mchp_corespi_read(spi, REG_CONTROL);
+	control &= ~CONTROL_ENABLE;
+	mchp_corespi_write(spi, REG_CONTROL, control);
+
 	control &= ~(SPI_MODE_X_MASK << MODE_X_MASK_SHIFT);
 	control |= mode_val;
 
-- 
2.43.0




