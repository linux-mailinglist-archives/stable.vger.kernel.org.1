Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A06874C274
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjGILUp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjGILUo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:20:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCB1130
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:20:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DFBC60B7F
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADB2C433C8;
        Sun,  9 Jul 2023 11:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901641;
        bh=5xXdPxb0knsPTFsf5dIsj6OgkhZmI3gfxkg/jx6eUrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z3g5SeSy1a31m+EZZA8niNkV9N/MHW+2rQ4TYoeaTHBaRvJNhxZA9u4h7BSoogRz8
         WKbzEQ0Q5FqKjCqRBFGUESQ6Cr3vub5i5A1U01NVYxk1AZo6brWl1b4fXOdrcygLUP
         niBLavCrjJPCpSL8lGSUtJZ7dFDRp+qrTNtwTwO4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 065/431] x86/mtrr: Replace size_or_mask and size_and_mask with a much easier concept
Date:   Sun,  9 Jul 2023 13:10:13 +0200
Message-ID: <20230709111452.670771939@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Juergen Gross <jgross@suse.com>

[ Upstream commit d053b481a5f16dbd4f020c6b3ebdf9173fdef0e2 ]

Replace size_or_mask and size_and_mask with the much easier concept of
high reserved bits.

While at it, instead of using constants in the MTRR code, use some new

  [ bp:
   - Drop mtrr_set_mask()
   - Unbreak long lines
   - Move struct mtrr_state_type out of the uapi header as it doesn't
     belong there. It also fixes a HDRTEST breakage "unknown type name ‘bool’"
     as Reported-by: kernel test robot <lkp@intel.com>
   - Massage.
  ]

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230502120931.20719-3-jgross@suse.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Stable-dep-of: a153f254e5cd ("x86/xen: Set MTRR state when running as Xen PV initial domain")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/mtrr.h        | 32 +++++++++++++-
 arch/x86/include/uapi/asm/mtrr.h   |  8 ----
 arch/x86/kernel/cpu/mtrr/cleanup.c |  2 +-
 arch/x86/kernel/cpu/mtrr/generic.c | 70 +++++++++++++-----------------
 arch/x86/kernel/cpu/mtrr/mtrr.c    |  4 +-
 arch/x86/kernel/cpu/mtrr/mtrr.h    |  2 +-
 6 files changed, 65 insertions(+), 53 deletions(-)

diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index f0eeaf6e5f5f7..1421fe811401e 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -23,8 +23,35 @@
 #ifndef _ASM_X86_MTRR_H
 #define _ASM_X86_MTRR_H
 
+#include <linux/bits.h>
 #include <uapi/asm/mtrr.h>
 
+/* Defines for hardware MTRR registers. */
+#define MTRR_CAP_VCNT		GENMASK(7, 0)
+#define MTRR_CAP_FIX		BIT_MASK(8)
+#define MTRR_CAP_WC		BIT_MASK(10)
+
+#define MTRR_DEF_TYPE_TYPE	GENMASK(7, 0)
+#define MTRR_DEF_TYPE_FE	BIT_MASK(10)
+#define MTRR_DEF_TYPE_E		BIT_MASK(11)
+
+#define MTRR_DEF_TYPE_ENABLE	(MTRR_DEF_TYPE_FE | MTRR_DEF_TYPE_E)
+#define MTRR_DEF_TYPE_DISABLE	~(MTRR_DEF_TYPE_TYPE | MTRR_DEF_TYPE_ENABLE)
+
+#define MTRR_PHYSBASE_TYPE	GENMASK(7, 0)
+#define MTRR_PHYSBASE_RSVD	GENMASK(11, 8)
+
+#define MTRR_PHYSMASK_RSVD	GENMASK(10, 0)
+#define MTRR_PHYSMASK_V		BIT_MASK(11)
+
+struct mtrr_state_type {
+	struct mtrr_var_range var_ranges[MTRR_MAX_VAR_RANGES];
+	mtrr_type fixed_ranges[MTRR_NUM_FIXED_RANGES];
+	unsigned char enabled;
+	bool have_fixed;
+	mtrr_type def_type;
+};
+
 /*
  * The following functions are for use by other drivers that cannot use
  * arch_phys_wc_add and arch_phys_wc_del.
@@ -121,7 +148,8 @@ struct mtrr_gentry32 {
 #endif /* CONFIG_COMPAT */
 
 /* Bit fields for enabled in struct mtrr_state_type */
-#define MTRR_STATE_MTRR_FIXED_ENABLED	0x01
-#define MTRR_STATE_MTRR_ENABLED		0x02
+#define MTRR_STATE_SHIFT		10
+#define MTRR_STATE_MTRR_FIXED_ENABLED	(MTRR_DEF_TYPE_FE >> MTRR_STATE_SHIFT)
+#define MTRR_STATE_MTRR_ENABLED		(MTRR_DEF_TYPE_E >> MTRR_STATE_SHIFT)
 
 #endif /* _ASM_X86_MTRR_H */
diff --git a/arch/x86/include/uapi/asm/mtrr.h b/arch/x86/include/uapi/asm/mtrr.h
index 376563f2bac1f..ab194c8316259 100644
--- a/arch/x86/include/uapi/asm/mtrr.h
+++ b/arch/x86/include/uapi/asm/mtrr.h
@@ -81,14 +81,6 @@ typedef __u8 mtrr_type;
 #define MTRR_NUM_FIXED_RANGES 88
 #define MTRR_MAX_VAR_RANGES 256
 
-struct mtrr_state_type {
-	struct mtrr_var_range var_ranges[MTRR_MAX_VAR_RANGES];
-	mtrr_type fixed_ranges[MTRR_NUM_FIXED_RANGES];
-	unsigned char enabled;
-	unsigned char have_fixed;
-	mtrr_type def_type;
-};
-
 #define MTRRphysBase_MSR(reg) (0x200 + 2 * (reg))
 #define MTRRphysMask_MSR(reg) (0x200 + 2 * (reg) + 1)
 
diff --git a/arch/x86/kernel/cpu/mtrr/cleanup.c b/arch/x86/kernel/cpu/mtrr/cleanup.c
index 70314093bb9b5..ca2d567e729e2 100644
--- a/arch/x86/kernel/cpu/mtrr/cleanup.c
+++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
@@ -890,7 +890,7 @@ int __init mtrr_trim_uncached_memory(unsigned long end_pfn)
 		return 0;
 
 	rdmsr(MSR_MTRRdefType, def, dummy);
-	def &= 0xff;
+	def &= MTRR_DEF_TYPE_TYPE;
 	if (def != MTRR_TYPE_UNCACHABLE)
 		return 0;
 
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 3922552340b13..08ba558321825 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -38,15 +38,8 @@ u64 mtrr_tom2;
 struct mtrr_state_type mtrr_state;
 EXPORT_SYMBOL_GPL(mtrr_state);
 
-static u64 size_or_mask, size_and_mask;
-
-void __init mtrr_set_mask(void)
-{
-	unsigned int phys_addr = boot_cpu_data.x86_phys_bits;
-
-	size_or_mask = ~GENMASK_ULL(phys_addr - PAGE_SHIFT - 1, 0);
-	size_and_mask = ~size_or_mask & GENMASK_ULL(39, 20);
-}
+/* Reserved bits in the high portion of the MTRRphysBaseN MSR. */
+u32 phys_hi_rsvd;
 
 /*
  * BIOS is expected to clear MtrrFixDramModEn bit, see for example
@@ -79,10 +72,9 @@ static u64 get_mtrr_size(u64 mask)
 {
 	u64 size;
 
-	mask >>= PAGE_SHIFT;
-	mask |= size_or_mask;
+	mask |= (u64)phys_hi_rsvd << 32;
 	size = -mask;
-	size <<= PAGE_SHIFT;
+
 	return size;
 }
 
@@ -181,7 +173,7 @@ static u8 mtrr_type_lookup_variable(u64 start, u64 end, u64 *partial_end,
 	for (i = 0; i < num_var_ranges; ++i) {
 		unsigned short start_state, end_state, inclusive;
 
-		if (!(mtrr_state.var_ranges[i].mask_lo & (1 << 11)))
+		if (!(mtrr_state.var_ranges[i].mask_lo & MTRR_PHYSMASK_V))
 			continue;
 
 		base = (((u64)mtrr_state.var_ranges[i].base_hi) << 32) +
@@ -233,7 +225,7 @@ static u8 mtrr_type_lookup_variable(u64 start, u64 end, u64 *partial_end,
 		if ((start & mask) != (base & mask))
 			continue;
 
-		curr_match = mtrr_state.var_ranges[i].base_lo & 0xff;
+		curr_match = mtrr_state.var_ranges[i].base_lo & MTRR_PHYSBASE_TYPE;
 		if (prev_match == MTRR_TYPE_INVALID) {
 			prev_match = curr_match;
 			continue;
@@ -435,7 +427,7 @@ static void __init print_mtrr_state(void)
 	high_width = (boot_cpu_data.x86_phys_bits - (32 - PAGE_SHIFT) + 3) / 4;
 
 	for (i = 0; i < num_var_ranges; ++i) {
-		if (mtrr_state.var_ranges[i].mask_lo & (1 << 11))
+		if (mtrr_state.var_ranges[i].mask_lo & MTRR_PHYSMASK_V)
 			pr_debug("  %u base %0*X%05X000 mask %0*X%05X000 %s\n",
 				 i,
 				 high_width,
@@ -444,7 +436,8 @@ static void __init print_mtrr_state(void)
 				 high_width,
 				 mtrr_state.var_ranges[i].mask_hi,
 				 mtrr_state.var_ranges[i].mask_lo >> 12,
-				 mtrr_attrib_to_str(mtrr_state.var_ranges[i].base_lo & 0xff));
+				 mtrr_attrib_to_str(mtrr_state.var_ranges[i].base_lo &
+						    MTRR_PHYSBASE_TYPE));
 		else
 			pr_debug("  %u disabled\n", i);
 	}
@@ -462,7 +455,7 @@ bool __init get_mtrr_state(void)
 	vrs = mtrr_state.var_ranges;
 
 	rdmsr(MSR_MTRRcap, lo, dummy);
-	mtrr_state.have_fixed = (lo >> 8) & 1;
+	mtrr_state.have_fixed = lo & MTRR_CAP_FIX;
 
 	for (i = 0; i < num_var_ranges; i++)
 		get_mtrr_var_range(i, &vrs[i]);
@@ -470,8 +463,8 @@ bool __init get_mtrr_state(void)
 		get_fixed_ranges(mtrr_state.fixed_ranges);
 
 	rdmsr(MSR_MTRRdefType, lo, dummy);
-	mtrr_state.def_type = (lo & 0xff);
-	mtrr_state.enabled = (lo & 0xc00) >> 10;
+	mtrr_state.def_type = lo & MTRR_DEF_TYPE_TYPE;
+	mtrr_state.enabled = (lo & MTRR_DEF_TYPE_ENABLE) >> MTRR_STATE_SHIFT;
 
 	if (amd_special_default_mtrr()) {
 		unsigned low, high;
@@ -584,7 +577,7 @@ static void generic_get_mtrr(unsigned int reg, unsigned long *base,
 
 	rdmsr(MTRRphysMask_MSR(reg), mask_lo, mask_hi);
 
-	if ((mask_lo & 0x800) == 0) {
+	if (!(mask_lo & MTRR_PHYSMASK_V)) {
 		/*  Invalid (i.e. free) range */
 		*base = 0;
 		*size = 0;
@@ -595,8 +588,8 @@ static void generic_get_mtrr(unsigned int reg, unsigned long *base,
 	rdmsr(MTRRphysBase_MSR(reg), base_lo, base_hi);
 
 	/* Work out the shifted address mask: */
-	tmp = (u64)mask_hi << (32 - PAGE_SHIFT) | mask_lo >> PAGE_SHIFT;
-	mask = size_or_mask | tmp;
+	tmp = (u64)mask_hi << 32 | (mask_lo & PAGE_MASK);
+	mask = (u64)phys_hi_rsvd << 32 | tmp;
 
 	/* Expand tmp with high bits to all 1s: */
 	hi = fls64(tmp);
@@ -614,9 +607,9 @@ static void generic_get_mtrr(unsigned int reg, unsigned long *base,
 	 * This works correctly if size is a power of two, i.e. a
 	 * contiguous range:
 	 */
-	*size = -mask;
+	*size = -mask >> PAGE_SHIFT;
 	*base = (u64)base_hi << (32 - PAGE_SHIFT) | base_lo >> PAGE_SHIFT;
-	*type = base_lo & 0xff;
+	*type = base_lo & MTRR_PHYSBASE_TYPE;
 
 out_put_cpu:
 	put_cpu();
@@ -654,9 +647,8 @@ static bool set_mtrr_var_ranges(unsigned int index, struct mtrr_var_range *vr)
 	bool changed = false;
 
 	rdmsr(MTRRphysBase_MSR(index), lo, hi);
-	if ((vr->base_lo & 0xfffff0ffUL) != (lo & 0xfffff0ffUL)
-	    || (vr->base_hi & (size_and_mask >> (32 - PAGE_SHIFT))) !=
-		(hi & (size_and_mask >> (32 - PAGE_SHIFT)))) {
+	if ((vr->base_lo & ~MTRR_PHYSBASE_RSVD) != (lo & ~MTRR_PHYSBASE_RSVD)
+	    || (vr->base_hi & ~phys_hi_rsvd) != (hi & ~phys_hi_rsvd)) {
 
 		mtrr_wrmsr(MTRRphysBase_MSR(index), vr->base_lo, vr->base_hi);
 		changed = true;
@@ -664,9 +656,8 @@ static bool set_mtrr_var_ranges(unsigned int index, struct mtrr_var_range *vr)
 
 	rdmsr(MTRRphysMask_MSR(index), lo, hi);
 
-	if ((vr->mask_lo & 0xfffff800UL) != (lo & 0xfffff800UL)
-	    || (vr->mask_hi & (size_and_mask >> (32 - PAGE_SHIFT))) !=
-		(hi & (size_and_mask >> (32 - PAGE_SHIFT)))) {
+	if ((vr->mask_lo & ~MTRR_PHYSMASK_RSVD) != (lo & ~MTRR_PHYSMASK_RSVD)
+	    || (vr->mask_hi & ~phys_hi_rsvd) != (hi & ~phys_hi_rsvd)) {
 		mtrr_wrmsr(MTRRphysMask_MSR(index), vr->mask_lo, vr->mask_hi);
 		changed = true;
 	}
@@ -701,11 +692,12 @@ static unsigned long set_mtrr_state(void)
 	 * Set_mtrr_restore restores the old value of MTRRdefType,
 	 * so to set it we fiddle with the saved value:
 	 */
-	if ((deftype_lo & 0xff) != mtrr_state.def_type
-	    || ((deftype_lo & 0xc00) >> 10) != mtrr_state.enabled) {
+	if ((deftype_lo & MTRR_DEF_TYPE_TYPE) != mtrr_state.def_type ||
+	    ((deftype_lo & MTRR_DEF_TYPE_ENABLE) >> MTRR_STATE_SHIFT) != mtrr_state.enabled) {
 
-		deftype_lo = (deftype_lo & ~0xcff) | mtrr_state.def_type |
-			     (mtrr_state.enabled << 10);
+		deftype_lo = (deftype_lo & MTRR_DEF_TYPE_DISABLE) |
+			     mtrr_state.def_type |
+			     (mtrr_state.enabled << MTRR_STATE_SHIFT);
 		change_mask |= MTRR_CHANGE_MASK_DEFTYPE;
 	}
 
@@ -718,7 +710,7 @@ void mtrr_disable(void)
 	rdmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
 
 	/* Disable MTRRs, and set the default type to uncached */
-	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo & ~0xcff, deftype_hi);
+	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo & MTRR_DEF_TYPE_DISABLE, deftype_hi);
 }
 
 void mtrr_enable(void)
@@ -772,9 +764,9 @@ static void generic_set_mtrr(unsigned int reg, unsigned long base,
 		memset(vr, 0, sizeof(struct mtrr_var_range));
 	} else {
 		vr->base_lo = base << PAGE_SHIFT | type;
-		vr->base_hi = (base & size_and_mask) >> (32 - PAGE_SHIFT);
-		vr->mask_lo = -size << PAGE_SHIFT | 0x800;
-		vr->mask_hi = (-size & size_and_mask) >> (32 - PAGE_SHIFT);
+		vr->base_hi = (base >> (32 - PAGE_SHIFT)) & ~phys_hi_rsvd;
+		vr->mask_lo = -size << PAGE_SHIFT | MTRR_PHYSMASK_V;
+		vr->mask_hi = (-size >> (32 - PAGE_SHIFT)) & ~phys_hi_rsvd;
 
 		mtrr_wrmsr(MTRRphysBase_MSR(reg), vr->base_lo, vr->base_hi);
 		mtrr_wrmsr(MTRRphysMask_MSR(reg), vr->mask_lo, vr->mask_hi);
@@ -827,7 +819,7 @@ static int generic_have_wrcomb(void)
 {
 	unsigned long config, dummy;
 	rdmsr(MSR_MTRRcap, config, dummy);
-	return config & (1 << 10);
+	return config & MTRR_CAP_WC;
 }
 
 int positive_have_wrcomb(void)
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 1bdab16f16bdc..1067f128bded1 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -115,7 +115,7 @@ static void __init set_num_var_ranges(bool use_generic)
 	else if (is_cpu(CYRIX) || is_cpu(CENTAUR))
 		config = 8;
 
-	num_var_ranges = config & 0xff;
+	num_var_ranges = config & MTRR_CAP_VCNT;
 }
 
 static void __init init_table(void)
@@ -627,7 +627,7 @@ void __init mtrr_bp_init(void)
 {
 	const char *why = "(not available)";
 
-	mtrr_set_mask();
+	phys_hi_rsvd = GENMASK(31, boot_cpu_data.x86_phys_bits - 32);
 
 	if (cpu_feature_enabled(X86_FEATURE_MTRR)) {
 		mtrr_if = &generic_mtrr_ops;
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.h b/arch/x86/kernel/cpu/mtrr/mtrr.h
index a00987e6cc1c1..59e8fb26bf9dd 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.h
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.h
@@ -58,8 +58,8 @@ extern const struct mtrr_ops *mtrr_if;
 extern unsigned int num_var_ranges;
 extern u64 mtrr_tom2;
 extern struct mtrr_state_type mtrr_state;
+extern u32 phys_hi_rsvd;
 
-void mtrr_set_mask(void);
 void mtrr_state_warn(void);
 const char *mtrr_attrib_to_str(int x);
 void mtrr_wrmsr(unsigned, unsigned, unsigned);
-- 
2.39.2



