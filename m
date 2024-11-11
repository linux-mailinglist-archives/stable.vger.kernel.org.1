Return-Path: <stable+bounces-92078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B43C39C39B1
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 09:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7F501C21729
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 08:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D62915C15F;
	Mon, 11 Nov 2024 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aA5MrO+a"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A15D42A8A
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731314162; cv=none; b=aevpz9cyMv5C0uIzScyUWNfgxRWjquQGkxhK2piIfMPNuqb9ZbVB8I6Jxg2LPNf7zBCX4DnjDaSciaChjPmtwPDTVV5d7mwej10YCMbMgNAAoJ8RABzVEDRHHRrfW/bztKfAWN0ifYRO5radYE1lbLX54DgxenTwIlaGSKxZLFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731314162; c=relaxed/simple;
	bh=Sv4o3GiX+6xKepE5orowU06nSjVs9y8JwLVCSH3z74c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HP0Kjh9KDvlo94sAQ5w0RFsooxp5JcMpJDeqeosDCxTETTCaMhRF3kzolu8lY61yBVeHYpJ8nGULRjljTqIYVJu08777NZmTlFe/HMD75PH1+lqRuy9cti5dXDvO6Bjg66RaZeO6CFc3yXh62InErkG6UQr6HEbWj+K4aQXncoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aA5MrO+a; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6eb0a1d0216so12796437b3.2
        for <stable@vger.kernel.org>; Mon, 11 Nov 2024 00:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731314159; x=1731918959; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+4O6vPXncAdT+5klHHB6JLQEFGlmp/qVLkbHu/JVbLo=;
        b=aA5MrO+ajJXOAYSS8FRv9NhbUxgXjZxQClkTtxVVANsmpDq89r68EOLvnjReHVxS3r
         OOGbuJTFga8LhPjPIhgth40OBZUTMgI3lzS9xRZb/PAKPXLhZ2vHakXTxlNW9D/tMxRO
         9akMpVqt6huzKBhBodM8pL8Z/sllHLpuclGN5GDnuZYFTFqsIL6FsIHCk5kKxPxUBM+O
         Kde7jN3G5I8q4zaa3yFrsRzqMgJCM8aVV9RLu4QbZxHEB3OwRmL6tOqKtA6y4KWVfnmr
         T5gZ826h3RE987a2N2I5p5yNAWM6DZUfaKuhYigkQFo2UjmS5IY8A9Wmg38rCGSED6Ej
         lUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731314159; x=1731918959;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4O6vPXncAdT+5klHHB6JLQEFGlmp/qVLkbHu/JVbLo=;
        b=lo4qS0alVheS8SFW2xaYtdcYRU0DnCTH02RHfXw9+RtUPGKNTZ9Y2PCItRoaxVF293
         hSCNMy8ggdhNVIPffFJn1xDxXAOgufCiSp/iXvG1rXCqsBJN55QEomOiERuUqZaqSE6O
         gt+Xd1oKxHdugc4um72koycxb+e5whppkN0Be1Or0zhytdTrqxSkGwIViKOr2RGNDIHj
         /SQgkA3KrVsrW/NwQq26vHTC6LvqA0DfKv/CukKjCTAJBx/FPKo3dsE2HhHvAZnKez4b
         WZmUR2e3/ZYrA9w+TvuCOicFe5eZGk2bjyBZrjgagZVIk9yJw2+MbqHOrkaAs6QwWGcK
         CL9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcHunX5DyKeTGOl7JkfZSOPnw2oHaS++SRIC8/XBtkTlfXG8EeJlIXUG2PxozL153TrgGd2Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmBzSazaFmTaUkHPPxl/DgC1k7pKsAtqOwE2qjeTTXkXux+5WK
	gASs6rACdexCqM7HKZsWLdpGSWDI4+YwlA5l9A9Dl6XaJQoBC+QBjhjvlBvSX/zmnsR4BA==
X-Google-Smtp-Source: AGHT+IFHExbV/UaCmb9SO/GvwiePUkfieauhVEdjQbeeo7rkNuDf0FnYJMGSUhAwD4yKRoCmYO6xtYGR
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a0d:fd01:0:b0:6e3:6414:80c5 with SMTP id
 00721157ae682-6eadda22e76mr762687b3.0.1731314159320; Mon, 11 Nov 2024
 00:35:59 -0800 (PST)
Date: Mon, 11 Nov 2024 09:35:46 +0100
In-Reply-To: <20241111083544.1845845-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241111083544.1845845-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4298; i=ardb@kernel.org;
 h=from:subject; bh=v82eHrgTptnYI3SkH3DFWlg65i0BvRLyLZmKr5z7P/o=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JId3w4CP/at7Cu+4F321Y7dhUrNetClomFBRmzcf5YvKOq
 fIXZq/uKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABMRCGNk+PMnf9quWKN9P7eX
 p4kJl9w36Dxn7+fDWl1QO1X+6IQbBxkZni2erlXhv50vlmOeGceUp3Zhxf1vdmnusX8sH+e0oaK QCwA=
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241111083544.1845845-10-ardb+git@google.com>
Subject: [PATCH 2/6] arm64/mm: Override PARange for !LPA2 and use it consistently
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Kees Cook <keescook@chromium.org>, stable@vger.kernel.org
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
 arch/arm64/mm/init.c                  | 2 +-
 5 files changed, 22 insertions(+), 2 deletions(-)

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
index 37e4c02e0272..6f5137040ff6 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -3399,7 +3399,7 @@ static void verify_hyp_capabilities(void)
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
index d21f67d67cf5..4db9887b2aef 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -280,7 +280,7 @@ void __init arm64_memblock_init(void)
 
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
 		extern u16 memstart_offset_seed;
-		u64 mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
+		u64 mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
 		int parange = cpuid_feature_extract_unsigned_field(
 					mmfr0, ID_AA64MMFR0_EL1_PARANGE_SHIFT);
 		s64 range = linear_region_size -
-- 
2.47.0.277.g8800431eea-goog


