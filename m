Return-Path: <stable+bounces-67692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13BB952178
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 19:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFBDB1C216D0
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 17:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8271BC078;
	Wed, 14 Aug 2024 17:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g+d8jvSG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7F/9Gu9F"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D68566A;
	Wed, 14 Aug 2024 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723657565; cv=none; b=Y+L1NWBhAzHxpseRGAGSB0Rd/KXE7ITTLHtUrAAWUOKrivzy7zN1EuL8qsowkZcbMw6y6SXx7nFc/zvLgk3FO27bs17nXJsbOyskoWALM7r17CTZMkx1qr435hZssZC/xmB0ZmSZKbVADXoIh6JUe5gWV9Ri+pZ+EDmuA6hJ5PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723657565; c=relaxed/simple;
	bh=JcaldmfnFYAt+jUWVK+elZO4VsADhqj/eohUp/acJmA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OHRbs2xeeP0p+2F6PT1xEvhM+wYjkVtY3Y74DfIdrnTvdN5gEF2eIiS9BiQEpiRcKAHPlIb5j7ahDdWvEzCEFKAnSdlYVhrjGUUwEDWV10FvhkqZQxqk/4UMY0Ym8rL4xkSHg7dgwLW0ANCuRGnJngNgmXV+sAXlG9MmXG2RelQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g+d8jvSG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7F/9Gu9F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Aug 2024 17:46:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723657561;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5tHJcWyKTskKQPz1GYgeShBBXBAHgfe5/Oey9oBQv/A=;
	b=g+d8jvSG70OqbUjiRS80vFNWY3pBHQIgMmlQjBuRQOK+bh5vLwPgicW+HC2GmPq1/6K9pa
	ZVPF3I/1eQqWD4PPkTucWXeGWbitZjQYbGoavoVNOzalyanGEmgkeTws8x/cKkwdfEqKp3
	9MEF5qH2rO1dR7QWejd40tBM7wW7mMTV6Ybg9+Nkg8Ox9fvJ+pgbGWkShRU7qwCd+fjkEF
	+UuCye7nhu4QX3F80Ggg6T2eZi4GSJ3s/HnyWoL/y4YsBqvNRkHPy50hTdPQjKtyrsspUF
	HclyXSZ6YZIZw3YKZBIXb9MyOVNGiXjIRUdMc2MxnxWlckpx2TaLRXmPGStaxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723657561;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5tHJcWyKTskKQPz1GYgeShBBXBAHgfe5/Oey9oBQv/A=;
	b=7F/9Gu9FbE1pMAksMR/ywD1RN4c1V63G0JgraKohlkKjky1GmBOKz7JPkk2gKgMnKNa0QH
	zjm7nQhJMhkIruDg==
From: "tip-bot2 for Mitchell Levy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/fpu: Avoid writing LBR bit to IA32_XSS unless supported
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Mitchell Levy <levymitchell0@gmail.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240812-xsave-lbr-fix-v3-1-95bac1bf62f4@gmail.com>
References: <20240812-xsave-lbr-fix-v3-1-95bac1bf62f4@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172365756054.2215.15784552768690591050.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     2848ff28d180bd63a95da8e5dcbcdd76c1beeb7b
Gitweb:        https://git.kernel.org/tip/2848ff28d180bd63a95da8e5dcbcdd76c1beeb7b
Author:        Mitchell Levy <levymitchell0@gmail.com>
AuthorDate:    Mon, 12 Aug 2024 13:44:12 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 14 Aug 2024 19:40:20 +02:00

x86/fpu: Avoid writing LBR bit to IA32_XSS unless supported

There are two distinct CPU features related to the use of XSAVES and LBR:
whether LBR is itself supported and whether XSAVES supports LBR. The LBR
subsystem correctly checks both in intel_pmu_arch_lbr_init(), but the
XSTATE subsystem does not.

The LBR bit is only removed from xfeatures_mask_independent when LBR is not
supported by the CPU, but there is no validation of XSTATE support.

If XSAVES does not support LBR the write to IA32_XSS causes a #GP fault,
leaving the state of IA32_XSS unchanged, i.e. zero. The fault is handled
with a warning and the boot continues.

Consequently the next XRSTORS which tries to restore supervisor state fails
with #GP because the RFBM has zero for all supervisor features, which does
not match the XCOMP_BV field.

As XFEATURE_MASK_FPSTATE includes supervisor features setting up the FPU
causes a #GP, which ends up in fpu_reset_from_exception_fixup(). That fails
due to the same problem resulting in recursive #GPs until the kernel runs
out of stack space and double faults.

Prevent this by storing the supported independent features in
fpu_kernel_cfg during XSTATE initialization and use that cached value for
retrieving the independent feature bits to be written into IA32_XSS.

[ tglx: Massaged change log ]

Fixes: f0dccc9da4c0 ("x86/fpu/xstate: Support dynamic supervisor feature for LBR")
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240812-xsave-lbr-fix-v3-1-95bac1bf62f4@gmail.com
---
 arch/x86/include/asm/fpu/types.h | 7 +++++++
 arch/x86/kernel/fpu/xstate.c     | 3 +++
 arch/x86/kernel/fpu/xstate.h     | 4 ++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index eb17f31..de16862 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -591,6 +591,13 @@ struct fpu_state_config {
 	 * even without XSAVE support, i.e. legacy features FP + SSE
 	 */
 	u64 legacy_features;
+	/*
+	 * @independent_features:
+	 *
+	 * Features that are supported by XSAVES, but not managed as part of
+	 * the FPU core, such as LBR
+	 */
+	u64 independent_features;
 };
 
 /* FPU state configuration information */
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c5a026f..1339f83 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -788,6 +788,9 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 		goto out_disable;
 	}
 
+	fpu_kernel_cfg.independent_features = fpu_kernel_cfg.max_features &
+					      XFEATURE_MASK_INDEPENDENT;
+
 	/*
 	 * Clear XSAVE features that are disabled in the normal CPUID.
 	 */
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 2ee0b9c..afb404c 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -62,9 +62,9 @@ static inline u64 xfeatures_mask_supervisor(void)
 static inline u64 xfeatures_mask_independent(void)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR))
-		return XFEATURE_MASK_INDEPENDENT & ~XFEATURE_MASK_LBR;
+		return fpu_kernel_cfg.independent_features & ~XFEATURE_MASK_LBR;
 
-	return XFEATURE_MASK_INDEPENDENT;
+	return fpu_kernel_cfg.independent_features;
 }
 
 /* XSAVE/XRSTOR wrapper functions */

