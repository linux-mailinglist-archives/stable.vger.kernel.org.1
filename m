Return-Path: <stable+bounces-35079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57924894247
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B54A1C213D7
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF194AED7;
	Mon,  1 Apr 2024 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CPPyK4wu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC88BA3F;
	Mon,  1 Apr 2024 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990269; cv=none; b=lu9Hg0hV5bGrtiC+0ZgfrWsbgIicIwYa95RyrQWAXsO07adubpp0yyNouv9Kf+/3zeXeRUxR47N57W/ok6m1opuEO9BFbvVCtLDhmOAdXu7qNhTdYhLBFe7ysLA/XpxaRMZWjaEXJNr579HfHqw3lsEVsTjyfYjczaxvaoUCbBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990269; c=relaxed/simple;
	bh=KT6guxKC4FOg4obVl0AMpoiQESAGt0lGJ0ULxNP59RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVcLQazka9Ka9dApF3nWKYXre/z0DLD0XH6jJAoa8SdcrZDcYxbQQxUV5yctiwaAwx7FvqIfRHDiwn0fbcsbO3MI/zhABh4ubMVlqL2q5Vo0fENG8SpyI416jWPzPkzTUExiZGsYp0CiXnSMfXQUK1AmSIkLGIm+ax+s+0ze3nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CPPyK4wu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BE8C433F1;
	Mon,  1 Apr 2024 16:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990268;
	bh=KT6guxKC4FOg4obVl0AMpoiQESAGt0lGJ0ULxNP59RI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CPPyK4wunEfAjqNAqasMPRAwNaIXGKtnPi6oJSjzWEf9LmNcP0S8f2Rfq/6FS+4RK
	 tzyhXvkjL6rVeeVAzBWTARrVw/jlkrt7eZEm0Kz1gcJ5ZdYZv0PJigRttbvO6LIvI3
	 ESBK0dCSMcJOziVOEkJMe9yd3X7mF7+tkhzbhhWU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 298/396] irqchip/renesas-rzg2l: Prevent spurious interrupts when setting trigger type
Date: Mon,  1 Apr 2024 17:45:47 +0200
Message-ID: <20240401152556.787100651@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
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
index 80cbe96505c92..02ab6a944539f 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -162,8 +162,10 @@ static void rzg2l_irqc_irq_enable(struct irq_data *d)
 
 static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type)
 {
-	unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_IRQ_START;
 	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+	unsigned int hwirq = irqd_to_hwirq(d);
+	u32 iitseln = hwirq - IRQC_IRQ_START;
+	bool clear_irq_int = false;
 	u16 sense, tmp;
 
 	switch (type & IRQ_TYPE_SENSE_MASK) {
@@ -173,14 +175,17 @@ static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type)
 
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
@@ -189,21 +194,40 @@ static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type)
 
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
@@ -225,10 +249,14 @@ static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type)
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




