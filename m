Return-Path: <stable+bounces-50201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEF4904C3D
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 09:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6581D1F2305B
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 07:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB771649BE;
	Wed, 12 Jun 2024 07:01:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD181369BF;
	Wed, 12 Jun 2024 07:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718175683; cv=none; b=M//QqlU3NvU4RnS7gZiVYrPIhdAjjNVUYj38dTyfS6uXi+ImIahzdhP6JbO2rWv/PS1zy3fXTG0FpwlA9ELY7p2JgLLLePv1DSdhLfyQEtx95rag+HJyxrec5UX6aPR4malz8J90YAEGpHpyBjwbV/oqXx/tEBcrwSaxika/YFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718175683; c=relaxed/simple;
	bh=byg081w8LScES6hyDS+Ae58c0/R6FGaUJ4LIR59/D+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dxgDeNHi9JKztiGi43I9xX8IxWlT0z/QFYpn0UqJTKgvZ+t7t7FHkHSLTYUrKEZGofmT+c2x1K5jtBm2lnOXCJlBH6D5awGlINLhHcMDI+6vcgcKZnOtCma0BgCQWh3sqdYBLUnSfrvfuvqExgTHvDnYFwPJgOUIZwDnZct3m5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5E1C3277B;
	Wed, 12 Jun 2024 07:01:21 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org,
	Tianli Xiong <xiongtianli@loongson.cn>
Subject: [PATCH] irqchip/loongson-liointc: Set different ISRs for different cores
Date: Wed, 12 Jun 2024 15:01:06 +0800
Message-ID: <20240612070106.2060334-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the liointc hardware, there are different ISRs for different cores.
We always use core#0's ISR before but has no problem, it is because the
interrupts are routed to core#0 by default. If we change the routing,
we should set correct ISRs for different cores.

Cc: <stable@vger.kernel.org>
Signed-off-by: Tianli Xiong <xiongtianli@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/irq-loongson-liointc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index e4b33aed1c97..7c4fe7ab4b83 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -28,7 +28,7 @@
 
 #define LIOINTC_INTC_CHIP_START	0x20
 
-#define LIOINTC_REG_INTC_STATUS	(LIOINTC_INTC_CHIP_START + 0x20)
+#define LIOINTC_REG_INTC_STATUS(core)	(LIOINTC_INTC_CHIP_START + 0x20 + (core) * 8)
 #define LIOINTC_REG_INTC_EN_STATUS	(LIOINTC_INTC_CHIP_START + 0x04)
 #define LIOINTC_REG_INTC_ENABLE	(LIOINTC_INTC_CHIP_START + 0x08)
 #define LIOINTC_REG_INTC_DISABLE	(LIOINTC_INTC_CHIP_START + 0x0c)
@@ -217,7 +217,7 @@ static int liointc_init(phys_addr_t addr, unsigned long size, int revision,
 		goto out_free_priv;
 
 	for (i = 0; i < LIOINTC_NUM_CORES; i++)
-		priv->core_isr[i] = base + LIOINTC_REG_INTC_STATUS;
+		priv->core_isr[i] = base + LIOINTC_REG_INTC_STATUS(i);
 
 	for (i = 0; i < LIOINTC_NUM_PARENT; i++)
 		priv->handler[i].parent_int_map = parent_int_map[i];
-- 
2.43.0


