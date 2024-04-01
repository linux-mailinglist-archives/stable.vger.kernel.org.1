Return-Path: <stable+bounces-35078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56593894246
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88A3C1C21A91
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE7A4AEFD;
	Mon,  1 Apr 2024 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xxPMmEML"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E159D4AEF0;
	Mon,  1 Apr 2024 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990266; cv=none; b=rTwoP55QvyKQdS8hadw7BFFRubZtDmmIwrnNJ1g4pNfrvctjjco/Z1Sgidz7Zq6+ll2VfGlQS9De5JPSrzEUQKjTL62npSsURse9WwGVYPvL9bSt18zMAJRkrwrrx3muc7mMcPBjlkDTQJJKZQdgyScxn1lLC8NaEzkZ5aKSc9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990266; c=relaxed/simple;
	bh=H1Z7a4aObt2gOuiSEAFBdl/Fb/auva7T6A9tOcvgzcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOuC5X1KTRJYV6L9SaE1n94DLEsO5srtwFCqH60GUIloMIEJtd4cEHTRFy6mY7Ep4w1VXKHdCIETJVCNEUpX5zqR5UnE/olOJTErJrNjOFmo2XBE8wyGurqonWBHass+zGxLcvR2O+2Oy/mfh8u9acq1h3jvc5YXYQkWoC2THtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xxPMmEML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B530C433C7;
	Mon,  1 Apr 2024 16:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990265;
	bh=H1Z7a4aObt2gOuiSEAFBdl/Fb/auva7T6A9tOcvgzcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xxPMmEMLXyehchRJf8wYoDZVPZDgwlnOkPzchHWL+UL/SUsppnv3ASMmxVAEEDULZ
	 L2PS7cP+DxXWA+cqtF2owCmMpQwbWPl4KBhhLeTGURDbOHqoR2Q9D8GqqZkJ46z9mZ
	 LsNpwpFCrCy4/AWtK95roQ3gEudyqV3xNR60K3HU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 297/396] irqchip/renesas-rzg2l: Rename rzg2l_irq_eoi()
Date: Mon,  1 Apr 2024 17:45:46 +0200
Message-ID: <20240401152556.757734978@linuxfoundation.org>
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

[ Upstream commit b4b5cd61a6fdd92ede0dc39f0850a182affd1323 ]

Rename rzg2l_irq_eoi()->rzg2l_clear_irq_int() and simplify the code by
removing redundant priv local variable.

Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Stable-dep-of: 853a6030303f ("irqchip/renesas-rzg2l: Prevent spurious interrupts when setting trigger type")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 2fcd63bfb44d2..80cbe96505c92 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -66,10 +66,9 @@ static struct rzg2l_irqc_priv *irq_data_to_priv(struct irq_data *data)
 	return data->domain->host_data;
 }
 
-static void rzg2l_irq_eoi(struct irq_data *d)
+static void rzg2l_clear_irq_int(struct rzg2l_irqc_priv *priv, unsigned int hwirq)
 {
-	unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_IRQ_START;
-	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+	unsigned int hw_irq = hwirq - IRQC_IRQ_START;
 	u32 bit = BIT(hw_irq);
 	u32 iitsr, iscr;
 
@@ -113,7 +112,7 @@ static void rzg2l_irqc_eoi(struct irq_data *d)
 
 	raw_spin_lock(&priv->lock);
 	if (hw_irq >= IRQC_IRQ_START && hw_irq <= IRQC_IRQ_COUNT)
-		rzg2l_irq_eoi(d);
+		rzg2l_clear_irq_int(priv, hw_irq);
 	else if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ)
 		rzg2l_clear_tint_int(priv, hw_irq);
 	raw_spin_unlock(&priv->lock);
-- 
2.43.0




