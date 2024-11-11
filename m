Return-Path: <stable+bounces-92079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF7A9C39B2
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 09:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11187B21226
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 08:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F58C15DBBA;
	Mon, 11 Nov 2024 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FaODa/nZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BED42A8A
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731314164; cv=none; b=eQOzg72i08LDmBIwLzUYPO8FXHMeGor3ASw+T6X+0jNiiEEYcS0CCrxR/OWF7ayZ85a560s4NxTdR7tIl/JWE1x8IM54GDFj/jdEUDOe4yar+5pNVMx+CWtsBPy3eei6XSR0mUPM6fNub/ZAKMIWROPPO337yYQQgSBjUk+MfMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731314164; c=relaxed/simple;
	bh=bl7nMArJ73V6ooL67PqaXb7WKstGiYhVVP4ZCtw8cR4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d98lcNN3QWSuzkczX28rqiC3J59jtOU8tLMpRmBlc/i+jIlNmOaqAB3oehd+XDTypcPCC8ysdw+h5kRhn93Lol9elI1UmYBNWhKqEdB0Bo/FY7XkxAI8qtscOxCNiBiWOpwxhCLkGf64CTJylBHUN7Jt9dCGdmJgtt4BYwiAQUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FaODa/nZ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea86f1df79so78480957b3.1
        for <stable@vger.kernel.org>; Mon, 11 Nov 2024 00:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731314161; x=1731918961; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0N4/8trK7fv9irXSAqJ3zFfA8vt6Qj0oJ/C7156uK8I=;
        b=FaODa/nZDZtRaBFiLfF0rnZ7anvoKf1a5XvHQlWKRuezB+jEPcS+PjGrTeKP2Oyibm
         X2B4Axtx+zlRm9hLrEYAmGHwGLfuZdiRBPTriuWVSMCvB1mvDbUnHiGxFWJ4p6piOsKe
         GUMC8kMrCrKRl4UnBf5K4VwZxS3vVSDiqXmrxZnYM42SYI9IC++vyaBskRE7NA9fPgsn
         bji8Oam+4w4FlCWy/ISUBgCENZn5ZAAyKDDfqntDrd+W3s2UekluUmfxAgwTYTmyzO+o
         aTxppKcrp7peJC7WjwB03yGDQEWeYf9Jm2vBD45p2e+bNXn/34ytWw5yuskZvpfPBn9T
         nuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731314161; x=1731918961;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0N4/8trK7fv9irXSAqJ3zFfA8vt6Qj0oJ/C7156uK8I=;
        b=bpiXaGzBwQ12HCveyKNWsg/Hzh76v0/fD/LCdWXs7wyb1T6Y72B5/0OLLxyZYFFzr7
         V1slbS+6S5yw1LOju1UcxYb5TEJtGU7qNbJqDS/yDQjAjz6dNj+G/76emAYrJAKR9ioT
         +01zu1eVCFJxNig/n5QG5AXGdHu+kMAKWdJ6ijr7A2Mz/cXIy3N85sa64pvGRsKncZqH
         B6wzZKECsxnQITumEdJ5W8m7lEbgKKnpimV8LKUe2/qQGjetSSzhLg72z9LYzmAAJ0UE
         cF41WhDxKCkmnE0yauEHsvIywLTy2aw/QbOz2v367PcQz5X9aAMFzySpeEHYd2JuyxT1
         SDdg==
X-Forwarded-Encrypted: i=1; AJvYcCXz3z6v2N67KCZkwOJTA0T4hCLQqhNA3A77i/J2xoMXePrtRB0V+7GXzlEPqA4aLt73JMmMX4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp9YhRNBFZ++88lJnIGVPmRpKOgrnTH5oSTvkA20AudBCTijCh
	nXJT0sZ4JTIdU+vsqd4NbhdWv9gJ3lSQZ+4V3cwiR8UC4dN/Uo6LN3Wdm/VFvmuXdDu/kA==
X-Google-Smtp-Source: AGHT+IEaVcyWaEFOsAGEmUmx521XJZzIe6O0nRTJpeaLf4pyHpMVyj2xe5eAr/hgU4liSlwSx1Soq/gO
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a81:be05:0:b0:6e2:6f2:efc with SMTP id
 00721157ae682-6eb028d6c59mr467177b3.5.1731314161525; Mon, 11 Nov 2024
 00:36:01 -0800 (PST)
Date: Mon, 11 Nov 2024 09:35:47 +0100
In-Reply-To: <20241111083544.1845845-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241111083544.1845845-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2178; i=ardb@kernel.org;
 h=from:subject; bh=Rsge2hKhZ3IgLduep4Ol+NMdQ1OnlqaAQBu4vFWrM8I=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JId3w4OOI3t6JM3he6wj/fvl1/iRNb5+KfI0rxVsSN3fVB
 d7tbdrbUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbiE8jwTzsjSViaR1mnNmoX
 60UTV7//fRcMNrQk7GviOF0zeSnDXob/DosF7weG9whVPg2PLs25au19KFFvwdm4D6GXDs7quXC dFQA=
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241111083544.1845845-11-ardb+git@google.com>
Subject: [PATCH 3/6] arm64/kvm: Configure HYP TCR.PS/DS based on host stage1
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Kees Cook <keescook@chromium.org>, stable@vger.kernel.org
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
index a0d01c46e408..1d20d86bb9f5 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2005,8 +2005,7 @@ static int kvm_init_vector_slots(void)
 static void __init cpu_prepare_hyp_mode(int cpu, u32 hyp_va_bits)
 {
 	struct kvm_nvhe_init_params *params = per_cpu_ptr_nvhe_sym(kvm_init_params, cpu);
-	u64 mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
-	unsigned long tcr;
+	unsigned long tcr, ips;
 
 	/*
 	 * Calculate the raw per-cpu offset without a translation from the
@@ -2020,6 +2019,7 @@ static void __init cpu_prepare_hyp_mode(int cpu, u32 hyp_va_bits)
 	params->mair_el2 = read_sysreg(mair_el1);
 
 	tcr = read_sysreg(tcr_el1);
+	ips = FIELD_GET(TCR_IPS_MASK, tcr);
 	if (cpus_have_final_cap(ARM64_KVM_HVHE)) {
 		tcr |= TCR_EPD1_MASK;
 	} else {
@@ -2029,8 +2029,8 @@ static void __init cpu_prepare_hyp_mode(int cpu, u32 hyp_va_bits)
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
2.47.0.277.g8800431eea-goog


