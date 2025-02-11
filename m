Return-Path: <stable+bounces-114892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6197EA3087A
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 11:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067FD165CBD
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 10:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15151F4171;
	Tue, 11 Feb 2025 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RxNdBmYq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17B01F3FF1
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739269692; cv=none; b=O6k0Mmee8edmaUNK5muBuBGldUt98XgKlmp/OXy7JN/jhAc4t+yzcwAo+GbKQiIMqevmznkZ9AweHSYjWTUyXT47Vy4cddV3YwiIlChbOnDMlYC1rinM56WfzyHQGwSYkjP64Np4O/IamxB7wsFkVEfGWUVNA5Kqc7CYuPazIaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739269692; c=relaxed/simple;
	bh=b7NmuxA+lpQwsk88feLMN83oPbmwhJaguhlHEWPuH3I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jkSPaPpA5uDA9tnDJrqQDSitoTMBev9FO2e5819QaaujRANDtDrMds0PQCFGPdOJAftA8okOGF0SAn+mmDwq5VVuqAFzS3Mn0XM3MD7bc133E5bU9X9SNsMmocGXv+2PW7ldRQKpQc+VRWDO4Sh0Fj+rzcH3Rl1pcvLv+cg8dlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RxNdBmYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4649C4CEDD;
	Tue, 11 Feb 2025 10:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739269692;
	bh=b7NmuxA+lpQwsk88feLMN83oPbmwhJaguhlHEWPuH3I=;
	h=Subject:To:Cc:From:Date:From;
	b=RxNdBmYqHV0FtZIGqctWKJM6PCaYw436SwfcEieGXfk/MkaSdCBadi6ggIwlVyS4i
	 jDK/vZmQQxRUewnB7t1Qv9O721FsNbu5obQkEbuQq1fivwuxSKNgg8fJVlDVHpJU7Q
	 rkco5nN7HGkiBOH2SCRq7x5wrGNK1q0WXCQGQC3Q=
Subject: FAILED: patch "[PATCH] spi: atmel-quadspi: Create `atmel_qspi_ops` to support newer" failed to apply to 6.1-stable tree
To: csokas.bence@prolan.hu,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 11 Feb 2025 11:28:08 +0100
Message-ID: <2025021108-trolling-dissuade-87cc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c0a0203cf579
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021108-trolling-dissuade-87cc@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c0a0203cf57963792d59b3e4317a1d07b73df42a Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Date: Thu, 28 Nov 2024 18:43:14 +0100
Subject: [PATCH] spi: atmel-quadspi: Create `atmel_qspi_ops` to support newer
 SoC families
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Refactor the code to introduce an ops struct, to prepare for merging
support for later SoCs, such as SAMA7G5. This code was based on the
vendor's kernel (linux4microchip). Cc'ing original contributors.

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
Link: https://patch.msgid.link/20241128174316.3209354-2-csokas.bence@prolan.hu
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 316bce577081..2aa68d58cfd7 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -138,11 +138,15 @@
 #define QSPI_WPSR_WPVSRC_MASK           GENMASK(15, 8)
 #define QSPI_WPSR_WPVSRC(src)           (((src) << 8) & QSPI_WPSR_WPVSRC)
 
+#define ATMEL_QSPI_TIMEOUT		1000	/* ms */
+
 struct atmel_qspi_caps {
 	bool has_qspick;
 	bool has_ricr;
 };
 
+struct atmel_qspi_ops;
+
 struct atmel_qspi {
 	void __iomem		*regs;
 	void __iomem		*mem;
@@ -150,13 +154,22 @@ struct atmel_qspi {
 	struct clk		*qspick;
 	struct platform_device	*pdev;
 	const struct atmel_qspi_caps *caps;
+	const struct atmel_qspi_ops *ops;
 	resource_size_t		mmap_size;
 	u32			pending;
+	u32			irq_mask;
 	u32			mr;
 	u32			scr;
 	struct completion	cmd_completion;
 };
 
+struct atmel_qspi_ops {
+	int (*set_cfg)(struct atmel_qspi *aq, const struct spi_mem_op *op,
+		       u32 *offset);
+	int (*transfer)(struct spi_mem *mem, const struct spi_mem_op *op,
+			u32 offset);
+};
+
 struct atmel_qspi_mode {
 	u8 cmd_buswidth;
 	u8 addr_buswidth;
@@ -404,10 +417,60 @@ static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
 	return 0;
 }
 
+static int atmel_qspi_wait_for_completion(struct atmel_qspi *aq, u32 irq_mask)
+{
+	int err = 0;
+	u32 sr;
+
+	/* Poll INSTRuction End status */
+	sr = atmel_qspi_read(aq, QSPI_SR);
+	if ((sr & irq_mask) == irq_mask)
+		return 0;
+
+	/* Wait for INSTRuction End interrupt */
+	reinit_completion(&aq->cmd_completion);
+	aq->pending = sr & irq_mask;
+	aq->irq_mask = irq_mask;
+	atmel_qspi_write(irq_mask, aq, QSPI_IER);
+	if (!wait_for_completion_timeout(&aq->cmd_completion,
+					 msecs_to_jiffies(ATMEL_QSPI_TIMEOUT)))
+		err = -ETIMEDOUT;
+	atmel_qspi_write(irq_mask, aq, QSPI_IDR);
+
+	return err;
+}
+
+static int atmel_qspi_transfer(struct spi_mem *mem,
+			       const struct spi_mem_op *op, u32 offset)
+{
+	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->controller);
+
+	/* Skip to the final steps if there is no data */
+	if (!op->data.nbytes)
+		return atmel_qspi_wait_for_completion(aq,
+						      QSPI_SR_CMD_COMPLETED);
+
+	/* Dummy read of QSPI_IFR to synchronize APB and AHB accesses */
+	(void)atmel_qspi_read(aq, QSPI_IFR);
+
+	/* Send/Receive data */
+	if (op->data.dir == SPI_MEM_DATA_IN)
+		memcpy_fromio(op->data.buf.in, aq->mem + offset,
+			      op->data.nbytes);
+	else
+		memcpy_toio(aq->mem + offset, op->data.buf.out,
+			    op->data.nbytes);
+
+	/* Release the chip-select */
+	atmel_qspi_write(QSPI_CR_LASTXFER, aq, QSPI_CR);
+
+	return atmel_qspi_wait_for_completion(aq, QSPI_SR_CMD_COMPLETED);
+}
+
 static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->controller);
-	u32 sr, offset;
+	u32 offset;
 	int err;
 
 	/*
@@ -416,46 +479,20 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	 * when the flash memories overrun the controller's memory space.
 	 */
 	if (op->addr.val + op->data.nbytes > aq->mmap_size)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
+
+	if (op->addr.nbytes > 4)
+		return -EOPNOTSUPP;
 
 	err = pm_runtime_resume_and_get(&aq->pdev->dev);
 	if (err < 0)
 		return err;
 
-	err = atmel_qspi_set_cfg(aq, op, &offset);
+	err = aq->ops->set_cfg(aq, op, &offset);
 	if (err)
 		goto pm_runtime_put;
 
-	/* Skip to the final steps if there is no data */
-	if (op->data.nbytes) {
-		/* Dummy read of QSPI_IFR to synchronize APB and AHB accesses */
-		(void)atmel_qspi_read(aq, QSPI_IFR);
-
-		/* Send/Receive data */
-		if (op->data.dir == SPI_MEM_DATA_IN)
-			memcpy_fromio(op->data.buf.in, aq->mem + offset,
-				      op->data.nbytes);
-		else
-			memcpy_toio(aq->mem + offset, op->data.buf.out,
-				    op->data.nbytes);
-
-		/* Release the chip-select */
-		atmel_qspi_write(QSPI_CR_LASTXFER, aq, QSPI_CR);
-	}
-
-	/* Poll INSTRuction End status */
-	sr = atmel_qspi_read(aq, QSPI_SR);
-	if ((sr & QSPI_SR_CMD_COMPLETED) == QSPI_SR_CMD_COMPLETED)
-		goto pm_runtime_put;
-
-	/* Wait for INSTRuction End interrupt */
-	reinit_completion(&aq->cmd_completion);
-	aq->pending = sr & QSPI_SR_CMD_COMPLETED;
-	atmel_qspi_write(QSPI_SR_CMD_COMPLETED, aq, QSPI_IER);
-	if (!wait_for_completion_timeout(&aq->cmd_completion,
-					 msecs_to_jiffies(1000)))
-		err = -ETIMEDOUT;
-	atmel_qspi_write(QSPI_SR_CMD_COMPLETED, aq, QSPI_IDR);
+	err = aq->ops->transfer(mem, op, offset);
 
 pm_runtime_put:
 	pm_runtime_mark_last_busy(&aq->pdev->dev);
@@ -599,12 +636,17 @@ static irqreturn_t atmel_qspi_interrupt(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	aq->pending |= pending;
-	if ((aq->pending & QSPI_SR_CMD_COMPLETED) == QSPI_SR_CMD_COMPLETED)
+	if ((aq->pending & aq->irq_mask) == aq->irq_mask)
 		complete(&aq->cmd_completion);
 
 	return IRQ_HANDLED;
 }
 
+static const struct atmel_qspi_ops atmel_qspi_ops = {
+	.set_cfg = atmel_qspi_set_cfg,
+	.transfer = atmel_qspi_transfer,
+};
+
 static int atmel_qspi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctrl;
@@ -629,6 +671,7 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 
 	init_completion(&aq->cmd_completion);
 	aq->pdev = pdev;
+	aq->ops = &atmel_qspi_ops;
 
 	/* Map the registers */
 	aq->regs = devm_platform_ioremap_resource_byname(pdev, "qspi_base");


