Return-Path: <stable+bounces-77800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 299749876C2
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 17:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27C51F270DD
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 15:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CE81531CC;
	Thu, 26 Sep 2024 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vHtxVj2y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QGp6NLnH"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D4B152165;
	Thu, 26 Sep 2024 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727365410; cv=none; b=JCsayktzztRlf8XbNAiIZfZODxlO9SEwfFXi3wBYsOJyNcJBhbFufMFrfCKcna5sNrVm9jvlwzmuFOIBS+9hH8p+MtrF/5R4ymVTDl9yER0an2sLHnzMH061fpRg9vo80bonrwA0IU6I88/CU+/h+Be7mquivO7dpG31Xl392rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727365410; c=relaxed/simple;
	bh=LsaecnkOmRFc2Rb85nI2WQzfb4PTcDIVvWPaTLkMmKU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FSVSUYfXo17ZNGBAVxyvMfIAeyYYztJn3k0VDFBvLkMWolv4PAvj4Nu5LUsFgNJm9//0lBUDx9Mw/7yaaBKwxzYH8IAZsURULKBdL3J6T3tCXTyHaZIoo0CfXd3sZhMV6nHhhvZWOFmnWdBYwtxSyST9EtSs/nCYWUaC2Hp3Amo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vHtxVj2y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QGp6NLnH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727365406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vZ/HKgnyH2HmTsoqiD2jM9GAYr4moWSHAgynrG+F/AQ=;
	b=vHtxVj2yfehMPNOP5iiUaLPrtxiKreiaFchKIbhXVouWyk4l770aQfemwxS44NUbPTOjyK
	Y2k1BGYQwyOTU/h2Xm5depaeU0IjAnkyL7DSCT8RLIUyAudKqhVO2g4dZ+aE3BkNo8Hmur
	ZDHO715TXOYflWj8dc6D/anlY7NQiWCR5G5uP7YzO/EkTC97bF5QiW0I9UU2swsaK8U0rp
	zKxBZT8IsewPNvb7bW8tY8wdODTwfUWNde4b6Bmkhw+PoBCEazYr2ZzaIRYF5XGBVGbTgX
	LUhKvTUHoI5RHzhGqvhAntUXf2jpT3ihh6SNbdco/K0fBjm9NlVxije3ZRqNtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727365406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vZ/HKgnyH2HmTsoqiD2jM9GAYr4moWSHAgynrG+F/AQ=;
	b=QGp6NLnHhrwLB/1PcErLd2XM1lSocD1JGiXGFmlJtdoqe4XlvnwChgIDEBL+VZcU2WbZil
	jgoYPvSSG9jFxKAQ==
To: Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Marc Zyngier <maz@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Nam Cao <namcao@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH] irqchip/sifive-plic: Unmask interrupt in plic_irq_enable()
Date: Thu, 26 Sep 2024 17:43:15 +0200
Message-Id: <20240926154315.1244200-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It is possible that an interrupt is disabled and masked at the same time.
When the interrupt is enabled again by enable_irq(), only plic_irq_enable()
is called, not plic_irq_unmask(). The interrupt remains masked and never
raises.

An example where interrupt is both disabled and masked is when
handle_fasteoi_irq() is the handler, and IRQS_ONESHOT is set. The interrupt
handler:
  1. Mask the interrupt
  2. Handle the interrupt
  3. Check if interrupt is still enabled, and unmask it (see
     cond_unmask_eoi_irq())

If another task disables the interrupt in the middle of the above steps,
the interrupt will not get unmasked, and will remain masked when it is
enabled in the future.

The problem is occasionally observed when PREEMPT_RT is enabled, because
PREEMPT_RT add the IRQS_ONESHOT flag. But PREEMPT_RT only makes the
problem more likely to appear, the bug has been around since
commit a1706a1c5062 ("irqchip/sifive-plic: Separate the enable and mask
operations").

Fix it by unmasking interrupt in plic_irq_enable().

Fixes: a1706a1c5062 ("irqchip/sifive-plic: Separate the enable and mask ope=
rations").
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org
---
 drivers/irqchip/irq-sifive-plic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive=
-plic.c
index 2f6ef5c495bd..0efbf14ec9fa 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -128,6 +128,9 @@ static inline void plic_irq_toggle(const struct cpumask=
 *mask,
=20
 static void plic_irq_enable(struct irq_data *d)
 {
+	struct plic_priv *priv =3D irq_data_get_irq_chip_data(d);
+
+	writel(1, priv->regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
 	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 1);
 }
=20
--=20
2.39.5


