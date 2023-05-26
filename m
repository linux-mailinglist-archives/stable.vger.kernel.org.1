Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A835712D6D
	for <lists+stable@lfdr.de>; Fri, 26 May 2023 21:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbjEZT1h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 15:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbjEZT1f (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 26 May 2023 15:27:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A97AE5E
        for <stable@vger.kernel.org>; Fri, 26 May 2023 12:27:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64B62652E5
        for <stable@vger.kernel.org>; Fri, 26 May 2023 19:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88701C433EF;
        Fri, 26 May 2023 19:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685129247;
        bh=ILSJCfbDLdlfNfjACY3OBQWC6jEw7yx40IcwgLkMeFU=;
        h=Subject:To:Cc:From:Date:From;
        b=0vHfgTANVLIzfL5x/bzAKWQxOpdmQf59ER+/dx5tCNnYT7PnvLCD18bbEfZXbGSQr
         FtCrzimzuujVd2l45qxz3dqkYb83lPUkea2TgXHfLGzjd9ge82h7fs4bUCGJKjlB4+
         6CRC+1Z1Lbl9N6EcP5BU6LJHX5Iod/oJXB4x5vcQ=
Subject: FAILED: patch "[PATCH] x86/mm: Avoid incomplete Global INVLPG flushes" failed to apply to 4.14-stable tree
To:     dave.hansen@linux.intel.com, tglx@linutronix.de
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 26 May 2023 20:27:16 +0100
Message-ID: <2023052616-audibly-grinning-73b4@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x ce0b15d11ad837fbacc5356941712218e38a0a83
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052616-audibly-grinning-73b4@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

ce0b15d11ad8 ("x86/mm: Avoid incomplete Global INVLPG flushes")
6cff64b86aaa ("x86/mm: Use INVPCID for __native_flush_tlb_single()")
6fd166aae78c ("x86/mm: Use/Fix PCID to optimize user/kernel switches")
48e111982cda ("x86/mm: Abstract switching CR3")
2ea907c4fe7b ("x86/mm: Allow flushing for future ASID switches")
aa8c6248f8c7 ("x86/mm/pti: Add infrastructure for page table isolation")
8a09317b895f ("x86/mm/pti: Prepare the x86/entry assembly code for entry/exit CR3 switching")
613e396bc0d4 ("init: Invoke init_espfix_bsp() from mm_init()")
1a3b0caeb77e ("x86/mm: Create asm/invpcid.h")
dd95f1a4b5ca ("x86/mm: Put MMU to hardware ASID translation in one place")
cb0a9144a744 ("x86/mm: Remove hard-coded ASID limit checks")
50fb83a62cf4 ("x86/mm: Move the CR3 construction functions to tlbflush.h")
3f67af51e56f ("x86/mm: Add comments to clarify which TLB-flush functions are supposed to flush what")
23cb7d46f371 ("x86/microcode: Dont abuse the TLB-flush interface")
c482feefe1ae ("x86/entry/64: Make cpu_entry_area.tss read-only")
0f9a48100fba ("x86/entry: Clean up the SYSENTER_stack code")
7fbbd5cbebf1 ("x86/entry/64: Remove the SYSENTER stack canary")
40e7f949e0d9 ("x86/entry/64: Move the IST stacks into struct cpu_entry_area")
3386bc8aed82 ("x86/entry/64: Create a per-CPU SYSCALL entry trampoline")
3e3b9293d392 ("x86/entry/64: Return to userspace from the trampoline stack")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ce0b15d11ad837fbacc5356941712218e38a0a83 Mon Sep 17 00:00:00 2001
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Tue, 16 May 2023 12:24:25 -0700
Subject: [PATCH] x86/mm: Avoid incomplete Global INVLPG flushes

The INVLPG instruction is used to invalidate TLB entries for a
specified virtual address.  When PCIDs are enabled, INVLPG is supposed
to invalidate TLB entries for the specified address for both the
current PCID *and* Global entries.  (Note: Only kernel mappings set
Global=1.)

Unfortunately, some INVLPG implementations can leave Global
translations unflushed when PCIDs are enabled.

As a workaround, never enable PCIDs on affected processors.

I expect there to eventually be microcode mitigations to replace this
software workaround.  However, the exact version numbers where that
will happen are not known today.  Once the version numbers are set in
stone, the processor list can be tweaked to only disable PCIDs on
affected processors with affected microcode.

Note: if anyone wants a quick fix that doesn't require patching, just
stick 'nopcid' on your kernel command-line.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 3cdac0f0055d..8192452d1d2d 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -9,6 +9,7 @@
 #include <linux/sched/task.h>
 
 #include <asm/set_memory.h>
+#include <asm/cpu_device_id.h>
 #include <asm/e820/api.h>
 #include <asm/init.h>
 #include <asm/page.h>
@@ -261,6 +262,24 @@ static void __init probe_page_size_mask(void)
 	}
 }
 
+#define INTEL_MATCH(_model) { .vendor  = X86_VENDOR_INTEL,	\
+			      .family  = 6,			\
+			      .model = _model,			\
+			    }
+/*
+ * INVLPG may not properly flush Global entries
+ * on these CPUs when PCIDs are enabled.
+ */
+static const struct x86_cpu_id invlpg_miss_ids[] = {
+	INTEL_MATCH(INTEL_FAM6_ALDERLAKE   ),
+	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L ),
+	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_N ),
+	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE  ),
+	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P),
+	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S),
+	{}
+};
+
 static void setup_pcid(void)
 {
 	if (!IS_ENABLED(CONFIG_X86_64))
@@ -269,6 +288,12 @@ static void setup_pcid(void)
 	if (!boot_cpu_has(X86_FEATURE_PCID))
 		return;
 
+	if (x86_match_cpu(invlpg_miss_ids)) {
+		pr_info("Incomplete global flushes, disabling PCID");
+		setup_clear_cpu_cap(X86_FEATURE_PCID);
+		return;
+	}
+
 	if (boot_cpu_has(X86_FEATURE_PGE)) {
 		/*
 		 * This can't be cr4_set_bits_and_update_boot() -- the

