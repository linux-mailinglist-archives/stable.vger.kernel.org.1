Return-Path: <stable+bounces-104358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B48BF9F3343
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 15:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DDA018844E2
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 14:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D9129406;
	Mon, 16 Dec 2024 14:32:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D3C18E25;
	Mon, 16 Dec 2024 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734359520; cv=none; b=JYMoaZz56QaxrftxOqop1U2PpVWokflHtW/C4cN/AF3rrRu7RMk/JFH1lqcgqzL3jNQtx3G4FDd7tTIRVftC5v+m4mK+IZqYy8OnNBCndiCwLZtvwJh2AF1SipWZJUuyYs4KlKyHCzi+0DTIs0W2lSHwC1al50YU2T7e/ise1VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734359520; c=relaxed/simple;
	bh=dglKhAEZ5GcPn4/vHvJBOyuC1GCMSzd1CLig1Ni8yA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3v7byD1OBcl2Gwyb7Eyss/bJ5269QT1O3CMm4X8OyRIpzvvkzeDOPjrn0rnr89/61aZahu7gv+cqPW4l8A3wshY8XB1HgWB3cLTqw4Ru8hEqY7hBgQ4b+L5w1xM0eocD78sch39bbVG6yZWs4jUmE8v7R0mXjGfUxIOs8kQyEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50212113E;
	Mon, 16 Dec 2024 06:32:25 -0800 (PST)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7D693F58B;
	Mon, 16 Dec 2024 06:31:55 -0800 (PST)
Date: Mon, 16 Dec 2024 14:31:47 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Peter Collingbourne <pcc@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64/sme: Move storage of reg_smidr to
 __cpuinfo_store_cpu()
Message-ID: <Z2A502_EpqvLYN8g@J2N7QTR9R3.cambridge.arm.com>
References: <20241214-arm64-fix-boot-cpu-smidr-v1-1-0745c40772dd@kernel.org>
 <87a5cysfci.wl-maz@kernel.org>
 <709a0e75-0d0c-4bff-b9fd-3bbb55c97bd5@sirena.org.uk>
 <Z2Agntn52mY5bSTp@J2N7QTR9R3>
 <855dbb91-db37-4178-bd0b-511994d3aef7@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <855dbb91-db37-4178-bd0b-511994d3aef7@sirena.org.uk>

On Mon, Dec 16, 2024 at 01:23:55PM +0000, Mark Brown wrote:
> On Mon, Dec 16, 2024 at 12:44:14PM +0000, Mark Rutland wrote:
> 
> > ... didn't matter either way, and using '&boot_cpu_data' was intended to
> > make it clear that the features were based on the boot CPU's info, even
> > if you just grepped for that and didn't see the surrounding context.
> 
> Right, that was my best guess as to what was supposed to be going on
> but it wasn't super clear.  The code could use some more comments.
> 
> > I think the real fix here is to move the reading back into
> > __cpuinfo_store_cpu(), but to have an explicit check that SME has been
> > disabled on the commandline, with a comment explaining that this is a
> > bodge for broken FW which traps the SME ID regs.
> 
> That should be doable.
> 
> There's a few other similar ID registers (eg, we already read GMID_EL1
> and MPAMIDR_EL1) make me a bit nervous that we might need to generalise
> it a bit, but we can deal with that if it comes up.  Even for SME the
> disable was added speculatively, the factors that made this come up for
> SVE are less likely to be an issue with SME.

FWIW, I had a quick go (with only the SME case), and I think the shape
that we want is roughly as below, which I think is easy to generalise to
those other cases.

MarcZ, thoughts?

Mark.

---->8----
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 8b4e5a3cd24c8..f16eb99c10723 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -91,6 +91,16 @@ struct arm64_ftr_override {
 	u64		mask;
 };
 
+static inline u64
+arm64_ftr_override_apply(const struct arm64_ftr_override *override,
+			 u64 val)
+{
+	val &= ~override->mask;
+	val |= override->val & override->mask;
+
+	return val;
+}
+
 /*
  * @arm64_ftr_reg - Feature register
  * @strict_mask		Bits which should match across all CPUs for sanity.
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6ce71f444ed84..faad7d3e4cf5f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1167,12 +1167,6 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	    id_aa64pfr1_sme(read_sanitised_ftr_reg(SYS_ID_AA64PFR1_EL1))) {
 		unsigned long cpacr = cpacr_save_enable_kernel_sme();
 
-		/*
-		 * We mask out SMPS since even if the hardware
-		 * supports priorities the kernel does not at present
-		 * and we block access to them.
-		 */
-		info->reg_smidr = read_cpuid(SMIDR_EL1) & ~SMIDR_EL1_SMPS;
 		vec_init_vq_map(ARM64_VEC_SME);
 
 		cpacr_restore(cpacr);
@@ -1550,10 +1544,8 @@ u64 __read_sysreg_by_encoding(u32 sys_id)
 	}
 
 	regp  = get_arm64_ftr_reg(sys_id);
-	if (regp) {
-		val &= ~regp->override->mask;
-		val |= (regp->override->val & regp->override->mask);
-	}
+	if (regp)
+		val = arm64_ftr_override_apply(regp->override, val);
 
 	return val;
 }
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index d79e88fccdfce..1460e3541132f 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -439,6 +439,24 @@ static void __cpuinfo_store_cpu_32bit(struct cpuinfo_32bit *info)
 	info->reg_mvfr2 = read_cpuid(MVFR2_EL1);
 }
 
+static void __cpuinfo_store_cpu_sme(struct cpuinfo_arm64 *info)
+{
+	/*
+	 * TODO: explain that this bodge is to avoid trapping.
+	 */
+	u64 pfr1 = info->reg_id_aa64pfr1;
+	pfr1 = arm64_ftr_override_apply(&id_aa64pfr1_override, pfr1);
+	if (!id_aa64pfr1_sme(pfr1))
+		return;
+
+	/*
+	 * We mask out SMPS since even if the hardware
+	 * supports priorities the kernel does not at present
+	 * and we block access to them.
+	 */
+	info->reg_smidr = read_cpuid(SMIDR_EL1) & ~SMIDR_EL1_SMPS;
+}
+
 static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 {
 	info->reg_cntfrq = arch_timer_get_cntfrq();
@@ -482,6 +500,8 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	if (id_aa64pfr0_mpam(info->reg_id_aa64pfr0))
 		info->reg_mpamidr = read_cpuid(MPAMIDR_EL1);
 
+	__cpuinfo_store_cpu_sme(info);
+
 	cpuinfo_detect_icache_policy(info);
 }
 



