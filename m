Return-Path: <stable+bounces-54953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211CF913BF7
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 17:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C1F28330E
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 15:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99444181D1C;
	Sun, 23 Jun 2024 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k9E9XvaK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XKa180aw"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35A6146D43;
	Sun, 23 Jun 2024 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719155594; cv=none; b=PKMf1czZtElZFqW2rzcHcyTAlPjTvyndkMRK8OrNPQhdFdAu71ewp7Xj9S9UKFsx4eULoH3B3sQyq/QhlLD9nsex+0rgg11Q9dY3jrGAfioHhQhGY65A04hMBLan+h+DIDu5OsZrK0hnsE0F0nlOqDAn66g28Z1o74JLq0F1xqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719155594; c=relaxed/simple;
	bh=+MqnAKRNdejjY5l2R0Dy3iv4HIzhydmxMXAVjSB5h1Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FUCxv4sxCnWA1g8W39UXqInSDQ9nhO9faXLL1xIjRxBhN9jhnztENhTNWDRPgVZxzTc3xBwtAq7CiV6neykwd9v7yO2q2jdV3fhTMNRzOKXfL3IH5Iry67ban5yS9CTLFtCPHq2g1rUsepJJyQtalWemq4bUO4Qz+Pj0n+/+jqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k9E9XvaK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XKa180aw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 23 Jun 2024 15:13:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719155590;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0i5HwOxvrubqfPMuGELUlxJWvJlIjg/P1HE2K1DlMgA=;
	b=k9E9XvaKprszC/sHP6n846hqg4SGx4uQRHOCaLgrExm8tpyDD/vE4mqEpmAvSsRiJQu1LG
	VXOeA5hJ5zbdDHbMCk+U1JijrcKXFIJG7E6bvHwumzxin6gSEZ3EO+5zF6dmrH1Tej0L/4
	bTEbJPt4PJHK8pIYJzsU0Nv4G1ZqtonwYvIK/btUa7u+1fnDMHNGulYDIEPXMFW1WSWFLb
	p9RhCNO3OsctKHL5Aipct8hHLnKAnvyJ4RKFjaPVE8QG/ma3PI3QZO0tqlgxA0xQbImulR
	lYwc63iQV6kQcIUz9XE+P7Deb/ne5XIYsjFZiHNrSV4lgQxBy6orty9Ha5QcAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719155590;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0i5HwOxvrubqfPMuGELUlxJWvJlIjg/P1HE2K1DlMgA=;
	b=XKa180awA/CQZOrkf7HUx9ejmtOavFfOD/dVJ3X+kL2Sgls82cS9YAOUpO54ijEUYkrraJ
	N4jvMO8FYx7b/xAA==
From: "tip-bot2 for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/loongson-liointc: Set different ISRs for
 different cores
Cc: Tianli Xiong <xiongtianli@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>, Thomas Gleixner <tglx@linutronix.de>,
  <stable@vger.kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20240622043338.1566945-1-chenhuacai@loongson.cn>
References: <20240622043338.1566945-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171915559018.10875.5329528120431987607.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     a9c3ee5d0fdb069b54902300df6ac822027f3b0a
Gitweb:        https://git.kernel.org/tip/a9c3ee5d0fdb069b54902300df6ac822027f3b0a
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Sat, 22 Jun 2024 12:33:38 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 23 Jun 2024 17:09:26 +02:00

irqchip/loongson-liointc: Set different ISRs for different cores

The liointc hardware provides separate Interrupt Status Registers (ISR) for
each core. The current code uses always the ISR of core #0, which works
during boot because by default all interrupts are routed to core #0.

When the interrupt routing changes in the firmware configuration then this
causes interrupts to be lost because they are not configured in the
corresponding core.

Use the core index to access the correct ISR instead of a hardcoded 0.

[ tglx: Massaged changelog ]

Fixes: 0858ed035a85 ("irqchip/loongson-liointc: Add ACPI init support")
Co-developed-by: Tianli Xiong <xiongtianli@loongson.cn>
Signed-off-by: Tianli Xiong <xiongtianli@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20240622043338.1566945-1-chenhuacai@loongson.cn

---
 drivers/irqchip/irq-loongson-liointc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index e4b33ae..7c4fe7a 100644
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

