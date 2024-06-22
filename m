Return-Path: <stable+bounces-54855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DB49131F3
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 06:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85CEF1F22E91
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 04:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBED69959;
	Sat, 22 Jun 2024 04:34:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CCA2F34;
	Sat, 22 Jun 2024 04:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719030842; cv=none; b=IBotZnbx14VVdCXnnLas6bXrQ3agSPZAviRno5dqwi8tdQwI9255UN91u7ggMLQnCJKMokZGFcXp/cGpcsFprjAdV21o5sUZiAfQ+k32pr2kW842kuD5knevMBkX67UNrhitO+t28KM4giJ1ZUSVB07Yi4XZlC255pvIWrlA7PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719030842; c=relaxed/simple;
	bh=0DLgiXMv2VNAjFqkV/Fh9y4pl1XIfT2meHbwwLIol7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oLFYNoKm46HMVYPt7vBepXpwPahs3mi9+H43Moz5c1sCJgvD58EHGqz5EQH7Bk+XyVzN9cdJ2zL+7zFQu9Vt6n4LqjY7FiKVehHYOdT+H4AJKeb5fa01PRcM/hJ9EoSHyTEIkiylhNHcip8MizUPkAuiFXO9KWzPT0qi+SKIncQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B146AC32781;
	Sat, 22 Jun 2024 04:33:59 +0000 (UTC)
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
Subject: [PATCH V2] irqchip/loongson-liointc: Set different ISRs for different cores
Date: Sat, 22 Jun 2024 12:33:38 +0800
Message-ID: <20240622043338.1566945-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the liointc hardware, there are different ISRs (i.e. Interrupt Status
Registers) for different cores. We always use core#0's ISR before but it
has no problem, this is because the interrupts are routed to core#0 by
default. If we change the routing (which can be done by changing firmware
configuration) then we will lose interrupts while CPU hotplugging, so we
should set correct ISRs for different cores.

Cc: <stable@vger.kernel.org>
Co-developed-by: Tianli Xiong <xiongtianli@loongson.cn>
Signed-off-by: Tianli Xiong <xiongtianli@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Update commit messages.

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


