Return-Path: <stable+bounces-100851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1189EE11A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 09:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528CC16942E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 08:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193B120E30B;
	Thu, 12 Dec 2024 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lbefnI6I"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E990520CCC4
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 08:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733991546; cv=none; b=aB9XTW543DGBfGjhmaqLYqoAPDzUpyf4mmE31K35YB0FKq7LNjMB7cd2QOcGkac0WahdShIIr434dEOtsuo+RWWx7QB+an6Eas6o6PndbPSNOO0snMo8IrlSjvjnw0LFbI/viDeXaq9Chik+AU9VCEvBtAaZJqb83jtqSlzWllg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733991546; c=relaxed/simple;
	bh=TSAWPK/Xq8CQnN3cWTPKZFMUEVsxlNikLmVeEldXfz8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TmL01KB5X3UEIGY3RzwC775OWm09z6znbjSSss0Mlt8vd7ulsnAPsFqKgsJgaHIP0fVolqsXi4D40u8orHkJdC6LrPVBONlN5cOVOSrJNfvSyRmeG+ZZ823eKhTDaEYKAvGSgiSJrU3F10TmoFXq6LfgIlcyh+vi2wmRjvaMbrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lbefnI6I; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4361b090d23so1841915e9.0
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 00:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733991543; x=1734596343; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JMOjAKt7SYh21CnU2/gurhD18i4qBMjjU7YQtDJALn4=;
        b=lbefnI6IaqyjIRmR2IiY8AW60URYyrnaDQ/yy6fskoJQ3eSLX8IU+gr5/kp1op6fla
         AX6ubo3XcHfXuyPxRNVo7bm0mWuf/rAeM5uVR0kC3V9vhLTUKjyWpDWm6RhCV8XepZco
         1SCG9PlyYkY59erQYd52/15GX0PHg3T82A0HjmswDtV4+Qtrh1Dc7xsPcLWXKBotTE4Z
         1x0LQcCdUsoa577cJYfhkFEsyrR61xvHusTVmDoPYCX3YdSAeMhDiuOiS+SJKR4E1f3p
         2vqbZwOjU/etVUEnls7A9X8S9i69KNYgHdasyHkTX74nc9FLq6CgH4xEYmJdN4+kI566
         OygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733991543; x=1734596343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JMOjAKt7SYh21CnU2/gurhD18i4qBMjjU7YQtDJALn4=;
        b=b5rbib90bQchqJ5oTrdq21svDUwQU2xfG3BOpe68n0GrrizTU3CH64zrfRQ+tx1kGu
         LOshojSWnInz50M0k+7GdXwy7pHK7p9hZqzxy5lXP4I0ANJ/Dtr6Mp4ERJf5K0VRW70+
         bd81m6DLEK7EA7szrIAOYY6WCM6ZQiyhBmFx/BOZcQcgZdrFjAKC3e4MBI5Kr1zc+xSD
         JTFJFJFr1aVkk9Ysr8PqMXEAPyqP/xmb/eLRisplUPLFjWCrxgVzDBEzkRNwdVggX/H8
         mCESmqNGFjEw5mD8fvaOXOh9S5lna26XPxxMqeznALpdCqxqFjB5qww4ieZpWyKZWgcM
         W59A==
X-Forwarded-Encrypted: i=1; AJvYcCVSopDfHmOHQT/FnhzBhh5LsdEE75LntodCp4wzsyvSGnLwFOBodm3ozNnjTTNhZwL4yx8OZQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMvzORIRqIdo88wSx6l6KmdNn497cwzGkpRz7vnVW4mMrSESd9
	0Iv3Rl3vEmyMgDsH7kKX9y30lkhGZd65om86ejhG/A+EmAsaEwq/SfgI93cf3ClWitzd1Q==
X-Google-Smtp-Source: AGHT+IGEPZXeZNx8gT7l0K6n8hjylpD9slamcamh+DZ/t1Et8nSF8q/2TqsFY0uo9/d5Ix+2xT283bTa
X-Received: from wmee4.prod.google.com ([2002:a05:600c:2184:b0:434:f2eb:aa72])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3109:b0:434:fafe:edb
 with SMTP id 5b1f17b1804b1-4361c3e22e7mr42421225e9.24.1733991543459; Thu, 12
 Dec 2024 00:19:03 -0800 (PST)
Date: Thu, 12 Dec 2024 09:18:45 +0100
In-Reply-To: <20241212081841.2168124-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212081841.2168124-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2178; i=ardb@kernel.org;
 h=from:subject; bh=rw9Vhm4jDehzLkAS6zRdIPR2y59w9k4f1UOcpcAZYnI=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT1qTlrdArlJHb3+TBsqGsoKNB8W9Z027b7oFacqcWXDr
 YrT6/52lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIlUzmX4zX4/6nDo9FP3mzZI
 uV3zzz+6pfK36PIlc2r+ntb2zQqVPsDwv3pBaqX9/pkC57imvot+L9+VGLnZ8Mu2ZI60JsUWb20 5ZgA=
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212081841.2168124-11-ardb+git@google.com>
Subject: [PATCH v3 3/6] arm64/kvm: Configure HYP TCR.PS/DS based on host stage1
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
2.47.1.613.gc27f4b7a9f-goog


