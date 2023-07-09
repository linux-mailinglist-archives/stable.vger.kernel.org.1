Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C40974C275
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjGILUs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjGILUr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:20:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0326130
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:20:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46A5C60BA4
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59674C433C9;
        Sun,  9 Jul 2023 11:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901644;
        bh=zC4BWervXavknPtWMH9OVoJAiK337TshwXSoAx9hpjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iKBKPxFSIMRbkE9WlRtEGGnO+alb1kyQ7hJNnMDugpzz/0+w5Fb9+VB9pwwp5ubiO
         V4hpE0aGCADhqX0C5IbW3iuXjLd0i3ocouLuElbJgrOiQySXppK/YLFAtLcCXQ3EcJ
         dJqcbRV5P5AKgynwX0t5OaI2Qut+IxuG5af+FaDA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 066/431] x86/mtrr: Support setting MTRR state for software defined MTRRs
Date:   Sun,  9 Jul 2023 13:10:14 +0200
Message-ID: <20230709111452.695042909@linuxfoundation.org>
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

[ Upstream commit 29055dc74287467bd7a053d60b4afe753832960d ]

When running virtualized, MTRR access can be reduced (e.g. in Xen PV
guests or when running as a SEV-SNP guest under Hyper-V). Typically, the
hypervisor will not advertize the MTRR feature in CPUID data, resulting
in no MTRR memory type information being available for the kernel.

This has turned out to result in problems (Link tags below):

- Hyper-V SEV-SNP guests using uncached mappings where they shouldn't
- Xen PV dom0 mapping memory as WB which should be UC- instead

Solve those problems by allowing an MTRR static state override,
overwriting the empty state used today. In case such a state has been
set, don't call get_mtrr_state() in mtrr_bp_init().

The set state will only be used by mtrr_type_lookup(), as in all other
cases mtrr_enabled() is being checked, which will return false. Accept
the overwrite call only for selected cases when running as a guest.
Disable X86_FEATURE_MTRR in order to avoid any MTRR modifications by
just refusing them.

  [ bp: Massage. ]

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/all/4fe9541e-4d4c-2b2a-f8c8-2d34a7284930@nerdbynature.de/
Link: https://lore.kernel.org/lkml/BYAPR21MB16883ABC186566BD4D2A1451D7FE9@BYAPR21MB1688.namprd21.prod.outlook.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Stable-dep-of: a153f254e5cd ("x86/xen: Set MTRR state when running as Xen PV initial domain")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/mtrr.h        |  8 ++++
 arch/x86/kernel/cpu/mtrr/generic.c | 60 +++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/mtrr/mtrr.c    | 14 ++++++-
 arch/x86/kernel/setup.c            |  2 +
 4 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 1421fe811401e..1bae790a553a5 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -58,6 +58,8 @@ struct mtrr_state_type {
  */
 # ifdef CONFIG_MTRR
 void mtrr_bp_init(void);
+void mtrr_overwrite_state(struct mtrr_var_range *var, unsigned int num_var,
+			  mtrr_type def_type);
 extern u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform);
 extern void mtrr_save_fixed_ranges(void *);
 extern void mtrr_save_state(void);
@@ -75,6 +77,12 @@ void mtrr_disable(void);
 void mtrr_enable(void);
 void mtrr_generic_set_state(void);
 #  else
+static inline void mtrr_overwrite_state(struct mtrr_var_range *var,
+					unsigned int num_var,
+					mtrr_type def_type)
+{
+}
+
 static inline u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform)
 {
 	/*
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 08ba558321825..e81d832475a1f 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -8,10 +8,12 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/mm.h>
-
+#include <linux/cc_platform.h>
 #include <asm/processor-flags.h>
 #include <asm/cacheinfo.h>
 #include <asm/cpufeature.h>
+#include <asm/hypervisor.h>
+#include <asm/mshyperv.h>
 #include <asm/tlbflush.h>
 #include <asm/mtrr.h>
 #include <asm/msr.h>
@@ -242,6 +244,62 @@ static u8 mtrr_type_lookup_variable(u64 start, u64 end, u64 *partial_end,
 	return mtrr_state.def_type;
 }
 
+/**
+ * mtrr_overwrite_state - set static MTRR state
+ *
+ * Used to set MTRR state via different means (e.g. with data obtained from
+ * a hypervisor).
+ * Is allowed only for special cases when running virtualized. Must be called
+ * from the x86_init.hyper.init_platform() hook.  It can be called only once.
+ * The MTRR state can't be changed afterwards.  To ensure that, X86_FEATURE_MTRR
+ * is cleared.
+ */
+void mtrr_overwrite_state(struct mtrr_var_range *var, unsigned int num_var,
+			  mtrr_type def_type)
+{
+	unsigned int i;
+
+	/* Only allowed to be called once before mtrr_bp_init(). */
+	if (WARN_ON_ONCE(mtrr_state_set))
+		return;
+
+	/* Only allowed when running virtualized. */
+	if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+		return;
+
+	/*
+	 * Only allowed for special virtualization cases:
+	 * - when running as Hyper-V, SEV-SNP guest using vTOM
+	 * - when running as Xen PV guest
+	 * - when running as SEV-SNP or TDX guest to avoid unnecessary
+	 *   VMM communication/Virtualization exceptions (#VC, #VE)
+	 */
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP) &&
+	    !hv_is_isolation_supported() &&
+	    !cpu_feature_enabled(X86_FEATURE_XENPV) &&
+	    !cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return;
+
+	/* Disable MTRR in order to disable MTRR modifications. */
+	setup_clear_cpu_cap(X86_FEATURE_MTRR);
+
+	if (var) {
+		if (num_var > MTRR_MAX_VAR_RANGES) {
+			pr_warn("Trying to overwrite MTRR state with %u variable entries\n",
+				num_var);
+			num_var = MTRR_MAX_VAR_RANGES;
+		}
+		for (i = 0; i < num_var; i++)
+			mtrr_state.var_ranges[i] = var[i];
+		num_var_ranges = num_var;
+	}
+
+	mtrr_state.def_type = def_type;
+	mtrr_state.enabled |= MTRR_STATE_MTRR_ENABLED;
+
+	mtrr_state_set = 1;
+}
+
 /**
  * mtrr_type_lookup - look up memory type in MTRR
  *
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 1067f128bded1..be35a0b09604d 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -625,11 +625,23 @@ int __initdata changed_by_mtrr_cleanup;
  */
 void __init mtrr_bp_init(void)
 {
+	bool generic_mtrrs = cpu_feature_enabled(X86_FEATURE_MTRR);
 	const char *why = "(not available)";
 
 	phys_hi_rsvd = GENMASK(31, boot_cpu_data.x86_phys_bits - 32);
 
-	if (cpu_feature_enabled(X86_FEATURE_MTRR)) {
+	if (!generic_mtrrs && mtrr_state.enabled) {
+		/*
+		 * Software overwrite of MTRR state, only for generic case.
+		 * Note that X86_FEATURE_MTRR has been reset in this case.
+		 */
+		init_table();
+		pr_info("MTRRs set to read-only\n");
+
+		return;
+	}
+
+	if (generic_mtrrs) {
 		mtrr_if = &generic_mtrr_ops;
 	} else {
 		switch (boot_cpu_data.x86_vendor) {
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 16babff771bdf..0cccfeb67c3ad 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1037,6 +1037,8 @@ void __init setup_arch(char **cmdline_p)
 	/*
 	 * VMware detection requires dmi to be available, so this
 	 * needs to be done after dmi_setup(), for the boot CPU.
+	 * For some guest types (Xen PV, SEV-SNP, TDX) it is required to be
+	 * called before cache_bp_init() for setting up MTRR state.
 	 */
 	init_hypervisor_platform();
 
-- 
2.39.2



