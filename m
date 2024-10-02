Return-Path: <stable+bounces-80008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 304BC98DB53
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C6B1C239AD
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACD81D1E6A;
	Wed,  2 Oct 2024 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NSCn8Ie5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692B41D27B9;
	Wed,  2 Oct 2024 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879116; cv=none; b=RMY1rDX30QoKu1KmyBxBmpgnpAbr6EZvS5/bvJZWETfzRwmvOphjqsbrS9qwfhN70dEF/yseCgZ7HIraMmbMZocpXFLuQXdSIV6KyhFzvPZQbzRw4m2plIGncxuvDtva5Wlp+xNxKRh9FHq8s965RgT/tfx7TFgvQep5ib5VdAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879116; c=relaxed/simple;
	bh=lv2I7ZpS1qwDhzFg7NygFSjHl3u5uAG2zV3pfYuCNrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxFxevb2K7R7jnHo4iQc5QZIxx4DZOo62zuiuJxyrXH6rHkaNl34sOWEhiFp5UiI8bDWk0zPORY07SLHWFGVdtTzEU4TORXQiDpPM6tt1hxm0vA+erbOdXv1EBmCAijMuqdbEvUovjCLirmIOdxCBEg+HZBEGEN9YpLZ32ZttXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NSCn8Ie5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDECC4CEC5;
	Wed,  2 Oct 2024 14:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727879116;
	bh=lv2I7ZpS1qwDhzFg7NygFSjHl3u5uAG2zV3pfYuCNrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NSCn8Ie571PyBEXyOXwYyA5coomORqLqhskjRRPjJX/YKlNAvsqnp/MDllR/kOOrL
	 1UM2kTgusnhf3AfeRmyJs25QAD+aPOVrKLC5PGtOFtKWQd5oPZVKoEG7jXNdt8+3pP
	 Mcj5sCqBNnQ6D9MKR46O7tCJJfP3rv5bN8VeHHIw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Serge Semin <fancer.lancer@gmail.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 001/538] EDAC/synopsys: Fix ECC status and IRQ control race condition
Date: Wed,  2 Oct 2024 14:54:00 +0200
Message-ID: <20241002125752.031588346@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Serge Semin <fancer.lancer@gmail.com>

[ Upstream commit 591c946675d88dcc0ae9ff54be9d5caaee8ce1e3 ]

The race condition around the ECCCLR register access happens in the IRQ
disable method called in the device remove() procedure and in the ECC IRQ
handler:

  1. Enable IRQ:
     a. ECCCLR = EN_CE | EN_UE
  2. Disable IRQ:
     a. ECCCLR = 0
  3. IRQ handler:
     a. ECCCLR = CLR_CE | CLR_CE_CNT | CLR_CE | CLR_CE_CNT
     b. ECCCLR = 0
     c. ECCCLR = EN_CE | EN_UE

So if the IRQ disabling procedure is called concurrently with the IRQ
handler method the IRQ might be actually left enabled due to the
statement 3c.

The root cause of the problem is that ECCCLR register (which since
v3.10a has been called as ECCCTL) has intermixed ECC status data clear
flags and the IRQ enable/disable flags. Thus the IRQ disabling (clear EN
flags) and handling (write 1 to clear ECC status data) procedures must
be serialised around the ECCCTL register modification to prevent the
race.

So fix the problem described above by adding the spin-lock around the
ECCCLR modifications and preventing the IRQ-handler from modifying the
IRQs enable flags (there is no point in disabling the IRQ and then
re-enabling it again within a single IRQ handler call, see the
statements 3a/3b and 3c above).

Fixes: f7824ded4149 ("EDAC/synopsys: Add support for version 3 of the Synopsys EDAC DDR")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240222181324.28242-2-fancer.lancer@gmail.com
Stable-dep-of: 35e6dbfe1846 ("EDAC/synopsys: Fix error injection on Zynq UltraScale+")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/synopsys_edac.c | 50 ++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index c4fc64cbecd0e..1ab2f737e4f16 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -9,6 +9,7 @@
 #include <linux/edac.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
 
@@ -299,6 +300,7 @@ struct synps_ecc_status {
 /**
  * struct synps_edac_priv - DDR memory controller private instance data.
  * @baseaddr:		Base address of the DDR controller.
+ * @reglock:		Concurrent CSRs access lock.
  * @message:		Buffer for framing the event specific info.
  * @stat:		ECC status information.
  * @p_data:		Platform data.
@@ -313,6 +315,7 @@ struct synps_ecc_status {
  */
 struct synps_edac_priv {
 	void __iomem *baseaddr;
+	spinlock_t reglock;
 	char message[SYNPS_EDAC_MSG_SIZE];
 	struct synps_ecc_status stat;
 	const struct synps_platform_data *p_data;
@@ -408,7 +411,8 @@ static int zynq_get_error_info(struct synps_edac_priv *priv)
 static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 {
 	struct synps_ecc_status *p;
-	u32 regval, clearval = 0;
+	u32 regval, clearval;
+	unsigned long flags;
 	void __iomem *base;
 
 	base = priv->baseaddr;
@@ -452,10 +456,14 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 	p->ueinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
 	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
 out:
-	clearval = ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT;
-	clearval |= ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
+	spin_lock_irqsave(&priv->reglock, flags);
+
+	clearval = readl(base + ECC_CLR_OFST) |
+		   ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT |
+		   ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
 	writel(clearval, base + ECC_CLR_OFST);
-	writel(0x0, base + ECC_CLR_OFST);
+
+	spin_unlock_irqrestore(&priv->reglock, flags);
 
 	return 0;
 }
@@ -515,24 +523,41 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 
 static void enable_intr(struct synps_edac_priv *priv)
 {
+	unsigned long flags;
+
 	/* Enable UE/CE Interrupts */
-	if (priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)
-		writel(DDR_UE_MASK | DDR_CE_MASK,
-		       priv->baseaddr + ECC_CLR_OFST);
-	else
+	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)) {
 		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
 		       priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
 
+		return;
+	}
+
+	spin_lock_irqsave(&priv->reglock, flags);
+
+	writel(DDR_UE_MASK | DDR_CE_MASK,
+	       priv->baseaddr + ECC_CLR_OFST);
+
+	spin_unlock_irqrestore(&priv->reglock, flags);
 }
 
 static void disable_intr(struct synps_edac_priv *priv)
 {
+	unsigned long flags;
+
 	/* Disable UE/CE Interrupts */
-	if (priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)
-		writel(0x0, priv->baseaddr + ECC_CLR_OFST);
-	else
+	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)) {
 		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
 		       priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
+
+		return;
+	}
+
+	spin_lock_irqsave(&priv->reglock, flags);
+
+	writel(0, priv->baseaddr + ECC_CLR_OFST);
+
+	spin_unlock_irqrestore(&priv->reglock, flags);
 }
 
 /**
@@ -576,8 +601,6 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 	/* v3.0 of the controller does not have this register */
 	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR))
 		writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
-	else
-		enable_intr(priv);
 
 	return IRQ_HANDLED;
 }
@@ -1359,6 +1382,7 @@ static int mc_probe(struct platform_device *pdev)
 	priv = mci->pvt_info;
 	priv->baseaddr = baseaddr;
 	priv->p_data = p_data;
+	spin_lock_init(&priv->reglock);
 
 	mc_init(mci, pdev);
 
-- 
2.43.0




