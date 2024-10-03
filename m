Return-Path: <stable+bounces-80632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF5A98EBCB
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 10:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3770DB2178B
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 08:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589DD13CA95;
	Thu,  3 Oct 2024 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gDFM3aPc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mKdHY1W4"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A3D1EA90;
	Thu,  3 Oct 2024 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727944925; cv=none; b=AheOPS946JH4cAV7UvNp6tHE2+qULrG8O74r476qANpxbrsWCghNJTkMx1xEgHsLHgG/NISfZAy1ofbSKEkiLfQkOnFv63CKMH2yCyzRHLx48Phtwd1uD+e1Yj7aK8EZEOaEojY16sX2jf6M8R1GIjm4QoVuL+DxZvsM8fu7anI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727944925; c=relaxed/simple;
	bh=vdtpXfuTI8pp3SUQEr+XxdJ7LctMhBwMVdifKK49z1E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TGZveC72XVBKuZ16Ot32NTZ4Hb8zoxNLyVAdqR9pltws+ihU07YIOM2YFTGyi0uDriRhmbsXDzhev/Idnrs6C7mgVdOpWrvy98TvUf7xxz0qk6uu9+o9A1EihBPWIIVShzFzAuplP4RhjpLU7OlXhsgdAUF6EYLTJ2+cWeB95bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gDFM3aPc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mKdHY1W4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727944921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rwv7c4XBUYlK7OuEf5OGodB7wdW8JkOOx3+ovXT0/yA=;
	b=gDFM3aPcSHzQk9Nq0Ac6UZIj6UneTF9kc+1+7PtO4KMg8BQSlGWo/9wbgojQLOUJkmxpbD
	CPlH083bA4S9kWahpx8Ira1MW9uUG6x/4cq3BZ/PBxEGgRV28kCZTK9wrDe1A9gm8F5Pon
	wWKRpvNm4XesfzMAuTr5+D5AQTsY9vbH+4rkZVkQAG06GdMflUT7EAeg+27N8GmJnbLl4r
	6N6b/rhgNT8FiT87kCiA2PjF+yHxib8AaKFqJqgVkUzKBtXUHrWb/E4afBqwwp/H4bHdEY
	bgV1bXAAjknZiJnuY2tXuSrW9r22p91nMNu0xaSogdRzMqjo17/lpj5zzS7rvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727944921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rwv7c4XBUYlK7OuEf5OGodB7wdW8JkOOx3+ovXT0/yA=;
	b=mKdHY1W4AoZI5KWvzwikGqlnOCzQP4N+0b9H4jAGcJGLHeZv8ZAkkyN3sxHbVRQMTaogi3
	SpyUY03p778buxCw==
To: Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Marc Zyngier <maz@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Nam Cao <namcao@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH v2] irqchip/sifive-plic: Unmask interrupt in plic_irq_enable()
Date: Thu,  3 Oct 2024 10:41:52 +0200
Message-Id: <20241003084152.2422969-1-namcao@linutronix.de>
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
rations")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org
---
v2: re-use plic_irq_unmask() instead of duplicating its code

 drivers/irqchip/irq-sifive-plic.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive=
-plic.c
index 2f6ef5c495bd..503d36d5a869 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -126,16 +126,6 @@ static inline void plic_irq_toggle(const struct cpumas=
k *mask,
 	}
 }
=20
-static void plic_irq_enable(struct irq_data *d)
-{
-	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 1);
-}
-
-static void plic_irq_disable(struct irq_data *d)
-{
-	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 0);
-}
-
 static void plic_irq_unmask(struct irq_data *d)
 {
 	struct plic_priv *priv =3D irq_data_get_irq_chip_data(d);
@@ -150,6 +140,17 @@ static void plic_irq_mask(struct irq_data *d)
 	writel(0, priv->regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
 }
=20
+static void plic_irq_enable(struct irq_data *d)
+{
+	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 1);
+	plic_irq_unmask(d);
+}
+
+static void plic_irq_disable(struct irq_data *d)
+{
+	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 0);
+}
+
 static void plic_irq_eoi(struct irq_data *d)
 {
 	struct plic_handler *handler =3D this_cpu_ptr(&plic_handlers);
--=20
2.39.5


