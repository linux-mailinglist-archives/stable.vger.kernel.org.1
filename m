Return-Path: <stable+bounces-98838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C588E9E594E
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 16:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D2216D09D
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 15:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FB921D59D;
	Thu,  5 Dec 2024 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w9aVK67m"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29BC219A6E
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411006; cv=none; b=uobs1ANh+NmoxX+5m3QBn8kSnc/7PFZkT/2WOQXef3Gw3iI2Sv2Qkmiwy/Ui5aCrUA37pouUjRwRECov5WNRlTP/f7nEFiaKXCTYA6RX3/UduHOSj6IjATtil6UFV8C1PpKEl2Ai+LxmBwFgse8LJT65MYpf2w+2ybu2+TH4eF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411006; c=relaxed/simple;
	bh=2iJ29fh1AWeIbKMcfJ3M2ftbDMnexR7YdF6JACF/QqY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eFW7Vxz6RNmQAMpPC+1P2+K/x32G4XOr1OFarUyMLet7vHNrkGmrDQUC5uQReo3HERSW/lRiDxRvDhmb5k6o5TyHHcUDGl+l9Gn83QDHNGrNv2DQy0dG5tmd33Lj+RPwMJOJA2Y+HSk/VxrUV9epV1f+U+FwGiQ74eZ3+7DqkUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w9aVK67m; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-434941aa9c2so6434055e9.3
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 07:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733411003; x=1734015803; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=adk2aH/4GDKjaqv21ityBwrpMTayAeXtNiToa+jV3u8=;
        b=w9aVK67mkW/RzvC6PkXUYXAZfSyyPrAHgnCtRkboUeALJmvQMZvCjXwEYYTBauqDBB
         EMuT3bKefu+hoeTX9i3+8jXdBGTL9Iw3VU00bXu77O9QOyqPEMwEjtlk6MnTaffeGtr8
         APOI/43Vu+dnPA/A6oeobT6VO1bfxp29VZ/2hdysbkxWJraZJ3l3upfwD4+pbB3ZjU3y
         EAswsiGu8dREJX4wqu8Q1bWG6ylcn+vS5bfMoXCq591QzIYiGmEJXmuj/8nhUcCQGro6
         FgE7jsLsb1SBMtvywwEZt/tnhMAPVY0KUcZ8sVqGR4afZbPDWAW/YCBeVsLHB4EDha/m
         pbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733411003; x=1734015803;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=adk2aH/4GDKjaqv21ityBwrpMTayAeXtNiToa+jV3u8=;
        b=KOa4A32ORG/KDYb/MPFKwGibkljIirBPVEXifyn3DC8mSlPy+o2nZixJlm2f6zWn5T
         0m6qeu0xIziKehSKeKlV5a3M7gO5+kNZnTHakdFUrwzhCNjQuVcBUzmx85aZ70D0VZUm
         V32ptA6vbKmQQIOWtCHgyWrrfTM/qnXox7tLQrhOnXh4+xGdL9n7RuRsW6q68zHoWQFc
         iXJY5QFgDI7t5V5Cr4vcPE34cB2LktqOCYV9yY+7aYnjGif4e7vNYhbmG/akOzNQOXuu
         H+58wZxc58UZ9c5lgw7QIzj4AWORukFeIR6FdGnYljd54CFAroL5heKoW0zS3llF4O8a
         OdSg==
X-Forwarded-Encrypted: i=1; AJvYcCURat2rznjq71kSf4DHloBC+og7kG9vvb5UgXvtfliRctZqeLc/9EPqMCz9uxK4b1dx3mA059g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7wSelHxPGF3EZ/kUpo6UJ5Fs7VKoIrsO0O2aiplnfLIcMKRCp
	fPClK0oO2la1+5qazJZPMRiSoE3XDUC5MuyM+/Nlt+YMUpUCnQx5CzmQRmnbIY8XlrwAxQ==
X-Google-Smtp-Source: AGHT+IF7/7yWatbx9m9EKm+cZ06mzA7cFMWteGbOArm8KBWUGs6ZGHFU/BgFWuC7Z2P10SoaWhuvRscf
X-Received: from wmql16.prod.google.com ([2002:a05:600c:4f10:b0:434:a346:77e5])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:19ce:b0:431:5871:6c5d
 with SMTP id 5b1f17b1804b1-434d3f8e454mr83608715e9.3.1733411003473; Thu, 05
 Dec 2024 07:03:23 -0800 (PST)
Date: Thu,  5 Dec 2024 16:02:33 +0100
In-Reply-To: <20241205150229.3510177-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241205150229.3510177-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2178; i=ardb@kernel.org;
 h=from:subject; bh=k2Mzp/wMZGFRYdDSzEySynVgHnYysUYKKCSLnjGJFrc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT3wQBcD07YY/8JkFrHzO87lqd8rFWx/6/Ni8pHKSFe+E
 zmsocwdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMYEO4OAVgIofeMzIsro/PTHeecONt0M87
 8/ayrVOX+HL/XP75ZUbHFnvqWThXMTKca5NMzX3+x+PBosBvlytrP655xf77i8p7/7u7TA9UaH/ gBgA=
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205150229.3510177-11-ardb+git@google.com>
Subject: [PATCH v2 3/6] arm64/kvm: Configure HYP TCR.PS/DS based on host stage1
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kees Cook <keescook@chromium.org>, 
	Quentin Perret <qperret@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

When the host stage1 is configured for LPA2, the value currently being
programmed into TCR_EL2.T0SZ may be invalid unless LPA2 is configured
at HYP as well.  This means kvm_lpa2_is_enabled() is not the right
condition to test when setting TCR_EL2.DS, as it will return false if
LPA2 is only available for stage 1 but not for stage 2.

Similary, programming TCR_EL2.PS based on a limited IPA range due to
lack of stage2 LPA2 support could potentially result in problems.

So use lpa2_is_enabled() instead, and set the PS field according to the
host's IPS, which is capped at 48 bits if LPA2 support is absent or
disabled. Whether or not we can make meaningful use of such a
configuration is a different question.

Cc: <stable@vger.kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kvm/arm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index a102c3aebdbc..7b2735ad32e9 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1990,8 +1990,7 @@ static int kvm_init_vector_slots(void)
 static void __init cpu_prepare_hyp_mode(int cpu, u32 hyp_va_bits)
 {
 	struct kvm_nvhe_init_params *params = per_cpu_ptr_nvhe_sym(kvm_init_params, cpu);
-	u64 mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
-	unsigned long tcr;
+	unsigned long tcr, ips;
 
 	/*
 	 * Calculate the raw per-cpu offset without a translation from the
@@ -2005,6 +2004,7 @@ static void __init cpu_prepare_hyp_mode(int cpu, u32 hyp_va_bits)
 	params->mair_el2 = read_sysreg(mair_el1);
 
 	tcr = read_sysreg(tcr_el1);
+	ips = FIELD_GET(TCR_IPS_MASK, tcr);
 	if (cpus_have_final_cap(ARM64_KVM_HVHE)) {
 		tcr |= TCR_EPD1_MASK;
 	} else {
@@ -2014,8 +2014,8 @@ static void __init cpu_prepare_hyp_mode(int cpu, u32 hyp_va_bits)
 	tcr &= ~TCR_T0SZ_MASK;
 	tcr |= TCR_T0SZ(hyp_va_bits);
 	tcr &= ~TCR_EL2_PS_MASK;
-	tcr |= FIELD_PREP(TCR_EL2_PS_MASK, kvm_get_parange(mmfr0));
-	if (kvm_lpa2_is_enabled())
+	tcr |= FIELD_PREP(TCR_EL2_PS_MASK, ips);
+	if (lpa2_is_enabled())
 		tcr |= TCR_EL2_DS;
 	params->tcr_el2 = tcr;
 
-- 
2.47.0.338.g60cca15819-goog


