Return-Path: <stable+bounces-34241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFD4893E7E
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D39B2B20E56
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670D545BE4;
	Mon,  1 Apr 2024 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nL5LRl/l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264C3383BA;
	Mon,  1 Apr 2024 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987459; cv=none; b=Df7kxDl+d4TKcAXwsA+Higa8R9WUuwxLjkX7I2EvEz81PKt+5uVcD1ynK9a1LMI8+nbwslbkBkto8JUQ5VHs1+6gON/rBdfarMOeuQdCBwENOzQUej/qKx087kFvTU4HnlJ9nou/UYl7XCMJyX3a0FxQVfk7P8JnuYqr9yC0y1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987459; c=relaxed/simple;
	bh=2ZqsW0iFFkovSEXsLZVNO5yBNzTarwDsRA+23tFgzoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGtOuEH4ky3NVehlDDiQoZ2Tzmy8CHnHdxN3w+mGBcqdaPcZLTDbxonmeY6AO+6ytE4BGd8+y0rGzE3A9ZYVy3ej2scOy0PHCgEqYVy5rq32LoclJv15QLyVDJgJgOT8LdemyRIDXooD3RGBWLKQps7jvEtVDEWp9wJnNL+WHNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nL5LRl/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCEEC433F1;
	Mon,  1 Apr 2024 16:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711987459;
	bh=2ZqsW0iFFkovSEXsLZVNO5yBNzTarwDsRA+23tFgzoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nL5LRl/lP58GfpCfY2UKLqaHaNNtSQZS8RzyASSeYL7c/TafxgD1+Tl2uoVdm+c8w
	 6oaGrsolQ9IreVhhy8xT4DYZXYAwSmJylfd5fC3yNsI3oaQ78QCccFe3dfXF5LwuKm
	 /AmdpEHAuKjKWXYA9FBvB3Iu0IAO3j1hHOUYuFQI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 265/399] irqchip/renesas-rzg2l: Prevent spurious interrupts when setting trigger type
Date: Mon,  1 Apr 2024 17:43:51 +0200
Message-ID: <20240401152557.097666578@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 853a6030303f8a8fa54929b68e5665d9b21aa405 ]

RZ/G2L interrupt chips require that the interrupt is masked before changing
the NMI, IRQ, TINT interrupt settings. Aside of that, after setting an edge
trigger type it is required to clear the interrupt status register in order
to avoid spurious interrupts.

The current implementation fails to do either of that and therefore is
prone to generate spurious interrupts when setting the trigger type.

Address this by:

  - Ensuring that the interrupt is masked at the chip level across the
    update for the TINT chip

  - Clearing the interrupt status register after updating the trigger mode
    for edge type interrupts

[ tglx: Massaged changelog and reverted the spin_lock_irqsave() change as
  	the set_type() callback is always called with interrupts disabled. ]

Fixes: 3fed09559cd8 ("irqchip: Add RZ/G2L IA55 Interrupt Controller driver")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 36 +++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 8133f05590b67..8803facbb3a2e 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -181,8 +181,10 @@ static void rzg2l_irqc_irq_enable(struct irq_data *d)
 
 static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type)
 {
-	unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_IRQ_START;
 	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+	unsigned int hwirq = irqd_to_hwirq(d);
+	u32 iitseln = hwirq - IRQC_IRQ_START;
+	bool clear_irq_int = false;
 	u16 sense, tmp;
 
 	switch (type & IRQ_TYPE_SENSE_MASK) {
@@ -192,14 +194,17 @@ static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type)
 
 	case IRQ_TYPE_EDGE_FALLING:
 		sense = IITSR_IITSEL_EDGE_FALLING;
+		clear_irq_int = true;
 		break;
 
 	case IRQ_TYPE_EDGE_RISING:
 		sense = IITSR_IITSEL_EDGE_RISING;
+		clear_irq_int = true;
 		break;
 
 	case IRQ_TYPE_EDGE_BOTH:
 		sense = IITSR_IITSEL_EDGE_BOTH;
+		clear_irq_int = true;
 		break;
 
 	default:
@@ -208,21 +213,40 @@ static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type)
 
 	raw_spin_lock(&priv->lock);
 	tmp = readl_relaxed(priv->base + IITSR);
-	tmp &= ~IITSR_IITSEL_MASK(hw_irq);
-	tmp |= IITSR_IITSEL(hw_irq, sense);
+	tmp &= ~IITSR_IITSEL_MASK(iitseln);
+	tmp |= IITSR_IITSEL(iitseln, sense);
+	if (clear_irq_int)
+		rzg2l_clear_irq_int(priv, hwirq);
 	writel_relaxed(tmp, priv->base + IITSR);
 	raw_spin_unlock(&priv->lock);
 
 	return 0;
 }
 
+static u32 rzg2l_disable_tint_and_set_tint_source(struct irq_data *d, struct rzg2l_irqc_priv *priv,
+						  u32 reg, u32 tssr_offset, u8 tssr_index)
+{
+	u32 tint = (u32)(uintptr_t)irq_data_get_irq_chip_data(d);
+	u32 tien = reg & (TIEN << TSSEL_SHIFT(tssr_offset));
+
+	/* Clear the relevant byte in reg */
+	reg &= ~(TSSEL_MASK << TSSEL_SHIFT(tssr_offset));
+	/* Set TINT and leave TIEN clear */
+	reg |= tint << TSSEL_SHIFT(tssr_offset);
+	writel_relaxed(reg, priv->base + TSSR(tssr_index));
+
+	return reg | tien;
+}
+
 static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type)
 {
 	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 	unsigned int hwirq = irqd_to_hwirq(d);
 	u32 titseln = hwirq - IRQC_TINT_START;
+	u32 tssr_offset = TSSR_OFFSET(titseln);
+	u8 tssr_index = TSSR_INDEX(titseln);
 	u8 index, sense;
-	u32 reg;
+	u32 reg, tssr;
 
 	switch (type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_EDGE_RISING:
@@ -244,10 +268,14 @@ static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type)
 	}
 
 	raw_spin_lock(&priv->lock);
+	tssr = readl_relaxed(priv->base + TSSR(tssr_index));
+	tssr = rzg2l_disable_tint_and_set_tint_source(d, priv, tssr, tssr_offset, tssr_index);
 	reg = readl_relaxed(priv->base + TITSR(index));
 	reg &= ~(IRQ_MASK << (titseln * TITSEL_WIDTH));
 	reg |= sense << (titseln * TITSEL_WIDTH);
 	writel_relaxed(reg, priv->base + TITSR(index));
+	rzg2l_clear_tint_int(priv, hwirq);
+	writel_relaxed(tssr, priv->base + TSSR(tssr_index));
 	raw_spin_unlock(&priv->lock);
 
 	return 0;
-- 
2.43.0




