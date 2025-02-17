Return-Path: <stable+bounces-116627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50A5A38E44
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 22:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520C63ACA01
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 21:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2291A256E;
	Mon, 17 Feb 2025 21:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PELFBUR0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ICRbi6t7"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B11419CD19;
	Mon, 17 Feb 2025 21:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739828861; cv=none; b=F2NuZEM6aEUlvTu2/Ft4Ordfxgd5LVVR7wNjny0sPmpzTgrHTezpo1E2GjvJPeLF3WH17HT4R3qw0MWapeuts3qs/XpMqLtiVFYeMGhI8zP/R61InK/hdQbpJ2spud9U1sCQ64aeMAZl5r2QIGxPgrb0y57Koi8uRFpU6BGaW4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739828861; c=relaxed/simple;
	bh=6I52qKTO8xXxaGOo+fo6UwbMEZo/VJ4wdhcirNvj9XM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=l743ZWEk4HfXtnwbif7Ed2L7d0/pdTxTZ+iItlHeOWIHJb309Ls6R7XvdB5xdP5OFHhG14Mn+F5tqsKwsRuj8uy4Yf/RpP67JD817A6Its5GEN9m9FK3q6zluxzQAcJSZLEoHb7pcce71rnZQCRJb6qljkWTene8VRU7benn1b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PELFBUR0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ICRbi6t7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Feb 2025 21:47:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739828856;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qR4ihC83aIVBuKTHNw290iskMNQB6fjA69OpPfEtZzw=;
	b=PELFBUR00FanrjDHaHsxyaI3R64NCpb0GcJn3IDs8FZRf8npIoNthf9NDCvS3DtQTUP0kb
	vXufOB9PAkOS4xM03RxvKz/sSADV17Ti1QjtY5V6abHyth5bYXaN2m6trRkdKHGFjFGVRV
	09RtmLB9RV2+PDvQ5qCZLox1BennS5Cwkr6qHXXMMmMhOb/adz42NjfLRyzJgWAguv84a2
	0V4sTpDGx15Bp02PbLWPekM/NSgBUZNLOXPVsCslKKL4RrDJSjARsgI8WISJDJYVjlY96Z
	85FvgW6gYbs2yz8yHdjad2U4cAb7PDIr5Yzp9fikV+4O34QGldzQfEyf2XNm/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739828856;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qR4ihC83aIVBuKTHNw290iskMNQB6fjA69OpPfEtZzw=;
	b=ICRbi6t7B+PwsoUYv7isWBbzRJh2E2/TtU30INmS6Ice8dlGHddkP2K4BdSeqSIVXUDK00
	0583xvPDHbfzbnCA==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v3: Fix rk3399 workaround when secure
 interrupts are enabled
Cc: Christoph Fritz <chf.fritz@googlemail.com>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250215185241.3768218-1-maz@kernel.org>
References: <20250215185241.3768218-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173982885309.10177.1439704589709977070.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     4cb77793842a351b39a030f77caebace3524840e
Gitweb:        https://git.kernel.org/tip/4cb77793842a351b39a030f77caebace3524840e
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sat, 15 Feb 2025 18:52:41 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Feb 2025 22:41:06 +01:00

irqchip/gic-v3: Fix rk3399 workaround when secure interrupts are enabled

Christoph reports that their rk3399 system dies since commit 773c05f417fa1
("irqchip/gic-v3: Work around insecure GIC integrations").

It appears that some rk3399 have secure payloads, and that the firmware
sets SCR_EL3.FIQ==1. Obivously, disabling security in that configuration
leads to even more problems.

Revisit the workaround by:

  - making it rk3399 specific
  - checking whether Group-0 is available, which is a good proxy
    for SCR_EL3.FIQ being 0
  - either apply the workaround if Group-0 is available, or disable
    pseudo-NMIs if not

Note that this doesn't mean that the secure side is able to receive
interrupts, as all interrupts are made non-secure anyway.

Clearly, nobody ever tested secure interrupts on this platform.

Fixes: 773c05f417fa1 ("irqchip/gic-v3: Work around insecure GIC integrations")
Reported-by: Christoph Fritz <chf.fritz@googlemail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Christoph Fritz <chf.fritz@googlemail.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250215185241.3768218-1-maz@kernel.org
Closes: https://lore.kernel.org/r/b1266652fb64857246e8babdf268d0df8f0c36d9.camel@googlemail.com
---
 drivers/irqchip/irq-gic-v3.c | 53 ++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 76dce0a..270d7a4 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -44,6 +44,7 @@ static u8 dist_prio_nmi __ro_after_init = GICV3_PRIO_NMI;
 #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
 #define FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539	(1ULL << 1)
 #define FLAGS_WORKAROUND_ASR_ERRATUM_8601001	(1ULL << 2)
+#define FLAGS_WORKAROUND_INSECURE		(1ULL << 3)
 
 #define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
 
@@ -83,6 +84,8 @@ static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
 #define GIC_LINE_NR	min(GICD_TYPER_SPIS(gic_data.rdists.gicd_typer), 1020U)
 #define GIC_ESPI_NR	GICD_TYPER_ESPIS(gic_data.rdists.gicd_typer)
 
+static bool nmi_support_forbidden;
+
 /*
  * There are 16 SGIs, though we only actually use 8 in Linux. The other 8 SGIs
  * are potentially stolen by the secure side. Some code, especially code dealing
@@ -163,21 +166,27 @@ static void __init gic_prio_init(void)
 {
 	bool ds;
 
-	ds = gic_dist_security_disabled();
-	if (!ds) {
-		u32 val;
-
-		val = readl_relaxed(gic_data.dist_base + GICD_CTLR);
-		val |= GICD_CTLR_DS;
-		writel_relaxed(val, gic_data.dist_base + GICD_CTLR);
+	cpus_have_group0 = gic_has_group0();
 
-		ds = gic_dist_security_disabled();
-		if (ds)
-			pr_warn("Broken GIC integration, security disabled");
+	ds = gic_dist_security_disabled();
+	if ((gic_data.flags & FLAGS_WORKAROUND_INSECURE) && !ds) {
+		if (cpus_have_group0) {
+			u32 val;
+
+			val = readl_relaxed(gic_data.dist_base + GICD_CTLR);
+			val |= GICD_CTLR_DS;
+			writel_relaxed(val, gic_data.dist_base + GICD_CTLR);
+
+			ds = gic_dist_security_disabled();
+			if (ds)
+				pr_warn("Broken GIC integration, security disabled\n");
+		} else {
+			pr_warn("Broken GIC integration, pNMI forbidden\n");
+			nmi_support_forbidden = true;
+		}
 	}
 
 	cpus_have_security_disabled = ds;
-	cpus_have_group0 = gic_has_group0();
 
 	/*
 	 * How priority values are used by the GIC depends on two things:
@@ -209,7 +218,7 @@ static void __init gic_prio_init(void)
 	 * be in the non-secure range, we program the non-secure values into
 	 * the distributor to match the PMR values we want.
 	 */
-	if (cpus_have_group0 & !cpus_have_security_disabled) {
+	if (cpus_have_group0 && !cpus_have_security_disabled) {
 		dist_prio_irq = __gicv3_prio_to_ns(dist_prio_irq);
 		dist_prio_nmi = __gicv3_prio_to_ns(dist_prio_nmi);
 	}
@@ -1922,6 +1931,18 @@ static bool gic_enable_quirk_arm64_2941627(void *data)
 	return true;
 }
 
+static bool gic_enable_quirk_rk3399(void *data)
+{
+	struct gic_chip_data *d = data;
+
+	if (of_machine_is_compatible("rockchip,rk3399")) {
+		d->flags |= FLAGS_WORKAROUND_INSECURE;
+		return true;
+	}
+
+	return false;
+}
+
 static bool rd_set_non_coherent(void *data)
 {
 	struct gic_chip_data *d = data;
@@ -1997,6 +2018,12 @@ static const struct gic_quirk gic_quirks[] = {
 		.init   = rd_set_non_coherent,
 	},
 	{
+		.desc	= "GICv3: Insecure RK3399 integration",
+		.iidr	= 0x0000043b,
+		.mask	= 0xff000fff,
+		.init	= gic_enable_quirk_rk3399,
+	},
+	{
 	}
 };
 
@@ -2004,7 +2031,7 @@ static void gic_enable_nmi_support(void)
 {
 	int i;
 
-	if (!gic_prio_masking_enabled())
+	if (!gic_prio_masking_enabled() || nmi_support_forbidden)
 		return;
 
 	rdist_nmi_refs = kcalloc(gic_data.ppi_nr + SGI_NR,

