Return-Path: <stable+bounces-100850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214D39EE118
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 09:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31C8168088
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 08:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008E020DD6B;
	Thu, 12 Dec 2024 08:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mxnuOOwE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA4620CCDF
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 08:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733991544; cv=none; b=Aq08r+RXb0HJKCNt+FJwSORRT/Mz/e3RQQ5oLAzAxIIgM3O61clRdSoOOVuNexi0az2WHkebnsd6h8dKjUJMzXUlaB6VU1pjnvH9Xh2z9vjHthmwIv3ZKv08FdKjyjW1/VGxNveE7BhPwPsBISC28OsTLslWw/crY6C/IIusHNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733991544; c=relaxed/simple;
	bh=IIRiZC5XZyzMgI3gPKX+55Yr6deZmolnCGPQJASUFJg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cBxF1bGjSV+CC0ryXRXJZUs/N+/Bt2CoaTbhxqIQ5Pq+WQWftuS7EGSArH8ac69PYea3MNFYxais2TUfrLqQwM95Y5kEJkTODbUeVZ9eOFd+TG9siF5CKl7IUqPXu3M7npGEufpEZtvhmW8/TvZYbCIs2SCJ5e6h/JG9ZPb00eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mxnuOOwE; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4361ac607b6so2607305e9.0
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 00:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733991541; x=1734596341; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2hytoeGuBGhQsTErvMf3yZxZWvdEkxkHmgM5PMFEUtg=;
        b=mxnuOOwEP9Bh0VXpEgZx7tNwfouXe39x1/hcv6TtBwWxJIW9F6bfJQtdalSq59INQE
         8mtkooSzjMU6PYUiqXbufdFic9vqJ7ji/7KQr/jySlktwT9y/yoxDlslXgSooEfs2BTs
         uWdXBhbdKVC02RVF3dMEuRpFMa559SVksxECodVEyZJmVGXQBBMLWjNJ3BydQ4EgVWR0
         CK5nigosTf2cVbCwx+CwYmMYl1J1Fo68nvSk3UO8QCwoGPPwOBcZaP7Bw1b2hv2wx9tZ
         cfnLrsbKiQA/AA7MjPcRvyLm5zkKooepYGK1mx6tmuvD+ME02pgo5WvkEJTAn9piT9r6
         Hh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733991541; x=1734596341;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2hytoeGuBGhQsTErvMf3yZxZWvdEkxkHmgM5PMFEUtg=;
        b=fNzNkHxH/EPHNngSpXVntx3Eo/wnqmPSjtdwHAuclxBOAsKbsr0+9gpQY5D7rq/hQB
         BGKefG7AhpaBxMx7e/Yq4RJh+uPL3+aJ9+KDZSxV+2BRpf05F7MhOQ21HHGw7eeVtxRV
         ditAzdiOE7sTswkpHc1fzQzgOLz2A1c3W+ljO9oYvx+3DTPg5re+gZEU6P/bhurx5uB1
         yX/eN8YiMOEQuvrkIIkWmDoR00z59DwjP/SeqWcFnUKwEGhzS6l+vsiLOSQW7twB+CEQ
         th3Zn+40rvwDi25/Idb2SojqNw5SL11Y//6x4lbJw6n/WAQVEVfe/LiJ+Ot7NTelDKgz
         1YTA==
X-Forwarded-Encrypted: i=1; AJvYcCUyLEqYZnwmbx+xoHAnNg/dYu/B5Whmapxp1CuUsX4At5lXR7p0Vsm0iTJI2UbA3JcuajAjdc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi09xqXjfagHyOflhzNQHxRiQESiN8/yDKaxVfv4bmlCgVKvHr
	DTHchmw68A7R7uf3in7OQEoWouE7JOO24boVj90xQM/kZo15bEc0Ces9q3SlL37kP7+IlQ==
X-Google-Smtp-Source: AGHT+IEGYsYtFhuo1M+mXxwr1oPLrb4FHzvmxqJpmKzmSM6VR7FR039Eo4mTnt9ojOSbZqHRyAKca3wz
X-Received: from wmee4.prod.google.com ([2002:a05:600c:2184:b0:434:f2eb:aa72])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:190c:b0:434:fe62:28c1
 with SMTP id 5b1f17b1804b1-43622842fe4mr19916235e9.18.1733991541383; Thu, 12
 Dec 2024 00:19:01 -0800 (PST)
Date: Thu, 12 Dec 2024 09:18:44 +0100
In-Reply-To: <20241212081841.2168124-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212081841.2168124-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4458; i=ardb@kernel.org;
 h=from:subject; bh=sxVQfPUsQxyoLylOvN26XLQadF9/wxwUb33vSk2ahfI=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT1qTur1D0H+U+c0Oh3k/7fY2m9Tvtv6JrPF/g+Z/q4oz
 2tbGnKoo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEykxIXhf/BxLV/To+f/h2of
 CzpiU5aroGt51O/cxPIvmscNVMwOP2Bk+F9k6SMTXssv+fCnKHMSz4GvK3OWVls23FAM+LvUb8o KBgA=
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212081841.2168124-10-ardb+git@google.com>
Subject: [PATCH v3 2/6] arm64/mm: Override PARange for !LPA2 and use it consistently
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kees Cook <keescook@chromium.org>, 
	Quentin Perret <qperret@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

When FEAT_LPA{,2} are not implemented, the ID_AA64MMFR0_EL1.PARange and
TCR.IPS values corresponding with 52-bit physical addressing are
reserved.

Setting the TCR.IPS field to 0b110 (52-bit physical addressing) has side
effects, such as how the TTBRn_ELx.BADDR fields are interpreted, and so
it is important that disabling FEAT_LPA2 (by overriding the
ID_AA64MMFR0.TGran fields) also presents a PARange field consistent with
that.

So limit the field to 48 bits unless LPA2 is enabled, and update
existing references to use the override consistently.

Fixes: 352b0395b505 ("arm64: Enable 52-bit virtual addressing for 4k and 16k granule configs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/assembler.h    | 5 +++++
 arch/arm64/kernel/cpufeature.c        | 2 +-
 arch/arm64/kernel/pi/idreg-override.c | 9 +++++++++
 arch/arm64/kernel/pi/map_kernel.c     | 6 ++++++
 arch/arm64/mm/init.c                  | 7 ++++++-
 5 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 3d8d534a7a77..ad63457a05c5 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -343,6 +343,11 @@ alternative_cb_end
 	// Narrow PARange to fit the PS field in TCR_ELx
 	ubfx	\tmp0, \tmp0, #ID_AA64MMFR0_EL1_PARANGE_SHIFT, #3
 	mov	\tmp1, #ID_AA64MMFR0_EL1_PARANGE_MAX
+#ifdef CONFIG_ARM64_LPA2
+alternative_if_not ARM64_HAS_VA52
+	mov	\tmp1, #ID_AA64MMFR0_EL1_PARANGE_48
+alternative_else_nop_endif
+#endif
 	cmp	\tmp0, \tmp1
 	csel	\tmp0, \tmp1, \tmp0, hi
 	bfi	\tcr, \tmp0, \pos, #3
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6ce71f444ed8..f8cb8a6ab98a 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -3478,7 +3478,7 @@ static void verify_hyp_capabilities(void)
 		return;
 
 	safe_mmfr1 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
-	mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
+	mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
 	mmfr1 = read_cpuid(ID_AA64MMFR1_EL1);
 
 	/* Verify VMID bits */
diff --git a/arch/arm64/kernel/pi/idreg-override.c b/arch/arm64/kernel/pi/idreg-override.c
index 22159251eb3a..c6b185b885f7 100644
--- a/arch/arm64/kernel/pi/idreg-override.c
+++ b/arch/arm64/kernel/pi/idreg-override.c
@@ -83,6 +83,15 @@ static bool __init mmfr2_varange_filter(u64 val)
 		id_aa64mmfr0_override.val |=
 			(ID_AA64MMFR0_EL1_TGRAN_LPA2 - 1) << ID_AA64MMFR0_EL1_TGRAN_SHIFT;
 		id_aa64mmfr0_override.mask |= 0xfU << ID_AA64MMFR0_EL1_TGRAN_SHIFT;
+
+		/*
+		 * Override PARange to 48 bits - the override will just be
+		 * ignored if the actual PARange is smaller, but this is
+		 * unlikely to be the case for LPA2 capable silicon.
+		 */
+		id_aa64mmfr0_override.val |=
+			ID_AA64MMFR0_EL1_PARANGE_48 << ID_AA64MMFR0_EL1_PARANGE_SHIFT;
+		id_aa64mmfr0_override.mask |= 0xfU << ID_AA64MMFR0_EL1_PARANGE_SHIFT;
 	}
 #endif
 	return true;
diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
index f374a3e5a5fe..e57b043f324b 100644
--- a/arch/arm64/kernel/pi/map_kernel.c
+++ b/arch/arm64/kernel/pi/map_kernel.c
@@ -136,6 +136,12 @@ static void noinline __section(".idmap.text") set_ttbr0_for_lpa2(u64 ttbr)
 {
 	u64 sctlr = read_sysreg(sctlr_el1);
 	u64 tcr = read_sysreg(tcr_el1) | TCR_DS;
+	u64 mmfr0 = read_sysreg(id_aa64mmfr0_el1);
+	u64 parange = cpuid_feature_extract_unsigned_field(mmfr0,
+							   ID_AA64MMFR0_EL1_PARANGE_SHIFT);
+
+	tcr &= ~TCR_IPS_MASK;
+	tcr |= parange << TCR_IPS_SHIFT;
 
 	asm("	msr	sctlr_el1, %0		;"
 	    "	isb				;"
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index d21f67d67cf5..2b2289d55eaa 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -280,7 +280,12 @@ void __init arm64_memblock_init(void)
 
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
 		extern u16 memstart_offset_seed;
-		u64 mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
+
+		/*
+		 * Use the sanitised version of id_aa64mmfr0_el1 so that linear
+		 * map randomization can be enabled by shrinking the IPA space.
+		 */
+		u64 mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
 		int parange = cpuid_feature_extract_unsigned_field(
 					mmfr0, ID_AA64MMFR0_EL1_PARANGE_SHIFT);
 		s64 range = linear_region_size -
-- 
2.47.1.613.gc27f4b7a9f-goog


