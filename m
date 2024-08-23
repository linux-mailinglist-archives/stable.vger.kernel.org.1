Return-Path: <stable+bounces-69955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F093C95CB12
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 12:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C801F21961
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 10:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A84185B6B;
	Fri, 23 Aug 2024 10:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z7930IdX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cURR8ESM"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FC713D510;
	Fri, 23 Aug 2024 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724410490; cv=none; b=SKT+aOFHTOlLTGzfsUYwWqqYTuArfDdYxop67AmQd6NMFKZGjy3Bp1fwjL8qfK8D9Bt9UdQmV1BkbOVpOt/xZYsu9PbxOn4GGWrGfMb/Av+SN+uTESmFMRyKnhvvv1RPR99s6kf+lF1gZ5OVq0nYDbtyyFP3CrwUmAXP8VVPSQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724410490; c=relaxed/simple;
	bh=nV1rJ7mFj7D2LWOoXbGFS4NGG4aj8vtgEZgAKaSvd3U=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=DSJTjp285h3J9NyAEAgNqrfzrszFyZj3OYGZ6BZkQ+n7iYuP/yzHv4PEBzDA1srWRJKgtWBa6ehni6PO8kMCMMp0I4NBuu3UjrbPJFkDz/Uq+UxobveNTr3tHb3yWe0XtW/HLVXX8iBZnqN4qUknDcg+iRt6tY1yzhrbKU2k9iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z7930IdX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cURR8ESM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 23 Aug 2024 10:54:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724410486;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=nQDmBLB7fvZWidF39jIDNgKNBEhq3neDcKkIUR8OuCI=;
	b=z7930IdXpJKfuhI+rHDVSxMmtqqKgdYWM9KPEGfQYOokSDCa7LAy1bEfLhE3/YkEfmx77i
	V08y1fQm00mwoVGp36O7+CoTAv8jn4cooWtpaSxPezh7pA9TbIoHcqk5Rl9JUrvk39frYi
	tosls/u9LUovVvSpnlzE1KL/AQj17X+w+XoI4Orq6VEktJWue43decJXFAy8nQvDO6feJn
	NyIgFHWbGKHQX/F6zqN7b3YKM0NNeBd4WjRXHw1AbKpvssUyMbvfJ2fnKb9ug0fIKGw9dO
	VPJlefKNMtIoSOLKNZYlWblFcoCfQqvzPs04FBuRpur2/qWOvYQfCFluxU3aPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724410486;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=nQDmBLB7fvZWidF39jIDNgKNBEhq3neDcKkIUR8OuCI=;
	b=cURR8ESMXJjb+FBaAtZ4LKtd76CUZVlYjNwBi8LPAV3FWE2cbmC8oiGHx5ulC/t/iTl0eg
	nQDQNEquSNFwBPBA==
From: "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v3: Init SRE before poking sysregs
Cc: Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Marc Zyngier <maz@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172441048623.2215.7507767492322657764.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     71c8e2a7c822ee557b07d9bb49028dd269c87b2e
Gitweb:        https://git.kernel.org/tip/71c8e2a7c822ee557b07d9bb49028dd269c87b2e
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Thu, 22 Aug 2024 11:23:08 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 23 Aug 2024 12:45:45 +02:00

irqchip/gic-v3: Init SRE before poking sysregs

The GICv3 driver pokes GICv3 system registers in gic_prio_init() before
gic_cpu_sys_reg_init() ensures that GICv3 system registers have been
enabled by writing to ICC_SRE_EL1.SRE.

On arm64 this is benign as has_useable_gicv3_cpuif() runs earlier during
cpufeature detection, and this enables the GICv3 system registers.

On 32-bit arm when booting on an FVP using the boot-wrapper, the accesses
in gic_prio_init() end up being UNDEFINED and crashes the kernel during
boot.

This is a regression introduced by the addition of gic_prio_init().

Fix this by factoring out the SRE initialization into a new function and
calling it early in the three paths where SRE may not have been
initialized:

(1) gic_init_bases(), before the primary CPU pokes GICv3 sysregs in
    gic_prio_init().

(2) gic_starting_cpu(), before secondary CPUs initialize GICv3 sysregs
    in gic_cpu_init().

(3) gic_cpu_pm_notifier(), before CPUs re-initialize GICv3 sysregs in
    gic_cpu_sys_reg_init().

Fixes: d447bf09a4013541 ("irqchip/gic-v3: Detect GICD_CTRL.DS and SCR_EL3.FIQ earlier")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/irqchip/irq-gic-v3.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index c19083b..74f21e0 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1154,14 +1154,8 @@ static void gic_update_rdist_properties(void)
 			gic_data.rdists.has_vpend_valid_dirty ? "Valid+Dirty " : "");
 }
 
-static void gic_cpu_sys_reg_init(void)
+static void gic_cpu_sys_reg_enable(void)
 {
-	int i, cpu = smp_processor_id();
-	u64 mpidr = gic_cpu_to_affinity(cpu);
-	u64 need_rss = MPIDR_RS(mpidr);
-	bool group0;
-	u32 pribits;
-
 	/*
 	 * Need to check that the SRE bit has actually been set. If
 	 * not, it means that SRE is disabled at EL2. We're going to
@@ -1172,6 +1166,16 @@ static void gic_cpu_sys_reg_init(void)
 	if (!gic_enable_sre())
 		pr_err("GIC: unable to set SRE (disabled at EL2), panic ahead\n");
 
+}
+
+static void gic_cpu_sys_reg_init(void)
+{
+	int i, cpu = smp_processor_id();
+	u64 mpidr = gic_cpu_to_affinity(cpu);
+	u64 need_rss = MPIDR_RS(mpidr);
+	bool group0;
+	u32 pribits;
+
 	pribits = gic_get_pribits();
 
 	group0 = gic_has_group0();
@@ -1333,6 +1337,7 @@ static int gic_check_rdist(unsigned int cpu)
 
 static int gic_starting_cpu(unsigned int cpu)
 {
+	gic_cpu_sys_reg_enable();
 	gic_cpu_init();
 
 	if (gic_dist_supports_lpis())
@@ -1498,6 +1503,7 @@ static int gic_cpu_pm_notifier(struct notifier_block *self,
 	if (cmd == CPU_PM_EXIT) {
 		if (gic_dist_security_disabled())
 			gic_enable_redist(true);
+		gic_cpu_sys_reg_enable();
 		gic_cpu_sys_reg_init();
 	} else if (cmd == CPU_PM_ENTER && gic_dist_security_disabled()) {
 		gic_write_grpen1(0);
@@ -2070,6 +2076,7 @@ static int __init gic_init_bases(phys_addr_t dist_phys_base,
 
 	gic_update_rdist_properties();
 
+	gic_cpu_sys_reg_enable();
 	gic_prio_init();
 	gic_dist_init();
 	gic_cpu_init();

