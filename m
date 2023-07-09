Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E7074C276
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjGILUu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjGILUt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:20:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823D5137
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:20:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20C0060B7F
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FFEC433C7;
        Sun,  9 Jul 2023 11:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901647;
        bh=VHsxXXCr2Qjp99LS03mMQsWyWU8tiXQthxzWivfPO1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KUiuTtpnHQZVGW7pRaO/s9kWLtL5Wr380VaO4Dj3sQu07QOr5cR80ft/p+c+Prmzg
         Aq7QNg90C2uMHaPD0J8R+9x4OgA2GStiSAo6NZ4jLnIPeegbi6baSoYf0baxbnncbd
         4UOfKnLxYkFYoc7nm3ZDIHxBM2G450BRJZvKCp0I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 067/431] x86/xen: Set MTRR state when running as Xen PV initial domain
Date:   Sun,  9 Jul 2023 13:10:15 +0200
Message-ID: <20230709111452.719067559@linuxfoundation.org>
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

[ Upstream commit a153f254e5cdf8fa3a1df90a6ffed3063fede154 ]

When running as Xen PV initial domain (aka dom0), MTRRs are disabled
by the hypervisor, but the system should nevertheless use correct
cache memory types. This has always kind of worked, as disabled MTRRs
resulted in disabled PAT, too, so that the kernel avoided code paths
resulting in inconsistencies. This bypassed all of the sanity checks
the kernel is doing with enabled MTRRs in order to avoid memory
mappings with conflicting memory types.

This has been changed recently, leading to PAT being accepted to be
enabled, while MTRRs stayed disabled. The result is that
mtrr_type_lookup() no longer is accepting all memory type requests,
but started to return WB even if UC- was requested. This led to
driver failures during initialization of some devices.

In reality MTRRs are still in effect, but they are under complete
control of the Xen hypervisor. It is possible, however, to retrieve
the MTRR settings from the hypervisor.

In order to fix those problems, overwrite the MTRR state via
mtrr_overwrite_state() with the MTRR data from the hypervisor, if the
system is running as a Xen dom0.

Fixes: 72cbc8f04fe2 ("x86/PAT: Have pat_enabled() properly reflect state when running on Xen")
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/20230502120931.20719-6-jgross@suse.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/xen/enlighten_pv.c | 52 +++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 093b78c8bbec0..8732b85d56505 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -68,6 +68,7 @@
 #include <asm/reboot.h>
 #include <asm/hypervisor.h>
 #include <asm/mach_traps.h>
+#include <asm/mtrr.h>
 #include <asm/mwait.h>
 #include <asm/pci_x86.h>
 #include <asm/cpu.h>
@@ -119,6 +120,54 @@ static int __init parse_xen_msr_safe(char *str)
 }
 early_param("xen_msr_safe", parse_xen_msr_safe);
 
+/* Get MTRR settings from Xen and put them into mtrr_state. */
+static void __init xen_set_mtrr_data(void)
+{
+#ifdef CONFIG_MTRR
+	struct xen_platform_op op = {
+		.cmd = XENPF_read_memtype,
+		.interface_version = XENPF_INTERFACE_VERSION,
+	};
+	unsigned int reg;
+	unsigned long mask;
+	uint32_t eax, width;
+	static struct mtrr_var_range var[MTRR_MAX_VAR_RANGES] __initdata;
+
+	/* Get physical address width (only 64-bit cpus supported). */
+	width = 36;
+	eax = cpuid_eax(0x80000000);
+	if ((eax >> 16) == 0x8000 && eax >= 0x80000008) {
+		eax = cpuid_eax(0x80000008);
+		width = eax & 0xff;
+	}
+
+	for (reg = 0; reg < MTRR_MAX_VAR_RANGES; reg++) {
+		op.u.read_memtype.reg = reg;
+		if (HYPERVISOR_platform_op(&op))
+			break;
+
+		/*
+		 * Only called in dom0, which has all RAM PFNs mapped at
+		 * RAM MFNs, and all PCI space etc. is identity mapped.
+		 * This means we can treat MFN == PFN regarding MTRR settings.
+		 */
+		var[reg].base_lo = op.u.read_memtype.type;
+		var[reg].base_lo |= op.u.read_memtype.mfn << PAGE_SHIFT;
+		var[reg].base_hi = op.u.read_memtype.mfn >> (32 - PAGE_SHIFT);
+		mask = ~((op.u.read_memtype.nr_mfns << PAGE_SHIFT) - 1);
+		mask &= (1UL << width) - 1;
+		if (mask)
+			mask |= MTRR_PHYSMASK_V;
+		var[reg].mask_lo = mask;
+		var[reg].mask_hi = mask >> 32;
+	}
+
+	/* Only overwrite MTRR state if any MTRR could be got from Xen. */
+	if (reg)
+		mtrr_overwrite_state(var, reg, MTRR_TYPE_UNCACHABLE);
+#endif
+}
+
 static void __init xen_pv_init_platform(void)
 {
 	/* PV guests can't operate virtio devices without grants. */
@@ -135,6 +184,9 @@ static void __init xen_pv_init_platform(void)
 
 	/* pvclock is in shared info area */
 	xen_init_time_ops();
+
+	if (xen_initial_domain())
+		xen_set_mtrr_data();
 }
 
 static void __init xen_pv_guest_late_init(void)
-- 
2.39.2



