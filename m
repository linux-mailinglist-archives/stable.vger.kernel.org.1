Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B9E7B89D1
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjJDS3l (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbjJDS3k (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:29:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A2E98
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:29:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775CAC433C8;
        Wed,  4 Oct 2023 18:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444176;
        bh=axQ5ipgjjcNmiLKTynLoRhWGb9T7WYNCyjGt9bdTP80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UTGaj9WWqJ7hQZNlSAjxYlfeR3QTVnIF/aXgV+YASTkOJm1DPQn8TiVu8SAIo/len
         1KVf30p7kTg8umTcp04agg7sV8tjCz4vExduWKuGJlYnrFNeLwKec2Fni6VzMwxd2Y
         eVkDjzw9orPFrcwePwi3wkJ7XMJK63VeEKTtLvpk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Sean Christopherson <seanjc@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 158/321] x86/reboot: VMCLEAR active VMCSes before emergency reboot
Date:   Wed,  4 Oct 2023 19:55:03 +0200
Message-ID: <20231004175236.563003673@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit b23c83ad2c638420ec0608a9de354507c41bec29 ]

VMCLEAR active VMCSes before any emergency reboot, not just if the kernel
may kexec into a new kernel after a crash.  Per Intel's SDM, the VMX
architecture doesn't require the CPU to flush the VMCS cache on INIT.  If
an emergency reboot doesn't RESET CPUs, cached VMCSes could theoretically
be kept and only be written back to memory after the new kernel is booted,
i.e. could effectively corrupt memory after reboot.

Opportunistically remove the setting of the global pointer to NULL to make
checkpatch happy.

Cc: Andrew Cooper <Andrew.Cooper3@citrix.com>
Link: https://lore.kernel.org/r/20230721201859.2307736-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/kexec.h  |  2 --
 arch/x86/include/asm/reboot.h |  2 ++
 arch/x86/kernel/crash.c       | 31 -------------------------------
 arch/x86/kernel/reboot.c      | 22 ++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c        | 10 +++-------
 5 files changed, 27 insertions(+), 40 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 5b77bbc28f969..819046974b997 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -205,8 +205,6 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image);
 #endif
 #endif
 
-typedef void crash_vmclear_fn(void);
-extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
 extern void kdump_nmi_shootdown_cpus(void);
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/include/asm/reboot.h b/arch/x86/include/asm/reboot.h
index 9177b4354c3f5..dc201724a6433 100644
--- a/arch/x86/include/asm/reboot.h
+++ b/arch/x86/include/asm/reboot.h
@@ -25,6 +25,8 @@ void __noreturn machine_real_restart(unsigned int type);
 #define MRR_BIOS	0
 #define MRR_APM		1
 
+typedef void crash_vmclear_fn(void);
+extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
 void cpu_emergency_disable_virtualization(void);
 
 typedef void (*nmi_shootdown_cb)(int, struct pt_regs*);
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index cdd92ab43cda4..54cd959cb3160 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -48,38 +48,12 @@ struct crash_memmap_data {
 	unsigned int type;
 };
 
-/*
- * This is used to VMCLEAR all VMCSs loaded on the
- * processor. And when loading kvm_intel module, the
- * callback function pointer will be assigned.
- *
- * protected by rcu.
- */
-crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss = NULL;
-EXPORT_SYMBOL_GPL(crash_vmclear_loaded_vmcss);
-
-static inline void cpu_crash_vmclear_loaded_vmcss(void)
-{
-	crash_vmclear_fn *do_vmclear_operation = NULL;
-
-	rcu_read_lock();
-	do_vmclear_operation = rcu_dereference(crash_vmclear_loaded_vmcss);
-	if (do_vmclear_operation)
-		do_vmclear_operation();
-	rcu_read_unlock();
-}
-
 #if defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
 
 static void kdump_nmi_callback(int cpu, struct pt_regs *regs)
 {
 	crash_save_cpu(regs, cpu);
 
-	/*
-	 * VMCLEAR VMCSs loaded on all cpus if needed.
-	 */
-	cpu_crash_vmclear_loaded_vmcss();
-
 	/*
 	 * Disable Intel PT to stop its logging
 	 */
@@ -133,11 +107,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 
 	crash_smp_send_stop();
 
-	/*
-	 * VMCLEAR VMCSs loaded on this cpu if needed.
-	 */
-	cpu_crash_vmclear_loaded_vmcss();
-
 	cpu_emergency_disable_virtualization();
 
 	/*
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 3adbe97015c13..3fa4c6717a1db 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -787,6 +787,26 @@ void machine_crash_shutdown(struct pt_regs *regs)
 }
 #endif
 
+/*
+ * This is used to VMCLEAR all VMCSs loaded on the
+ * processor. And when loading kvm_intel module, the
+ * callback function pointer will be assigned.
+ *
+ * protected by rcu.
+ */
+crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
+EXPORT_SYMBOL_GPL(crash_vmclear_loaded_vmcss);
+
+static inline void cpu_crash_vmclear_loaded_vmcss(void)
+{
+	crash_vmclear_fn *do_vmclear_operation = NULL;
+
+	rcu_read_lock();
+	do_vmclear_operation = rcu_dereference(crash_vmclear_loaded_vmcss);
+	if (do_vmclear_operation)
+		do_vmclear_operation();
+	rcu_read_unlock();
+}
 
 /* This is the CPU performing the emergency shutdown work. */
 int crashing_cpu = -1;
@@ -798,6 +818,8 @@ int crashing_cpu = -1;
  */
 void cpu_emergency_disable_virtualization(void)
 {
+	cpu_crash_vmclear_loaded_vmcss();
+
 	cpu_emergency_vmxoff();
 	cpu_emergency_svm_disable();
 }
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f2fb67a9dc050..bc6f0fea48b43 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -41,7 +41,7 @@
 #include <asm/idtentry.h>
 #include <asm/io.h>
 #include <asm/irq_remapping.h>
-#include <asm/kexec.h>
+#include <asm/reboot.h>
 #include <asm/perf_event.h>
 #include <asm/mmu_context.h>
 #include <asm/mshyperv.h>
@@ -754,7 +754,6 @@ static int vmx_set_guest_uret_msr(struct vcpu_vmx *vmx,
 	return ret;
 }
 
-#ifdef CONFIG_KEXEC_CORE
 static void crash_vmclear_local_loaded_vmcss(void)
 {
 	int cpu = raw_smp_processor_id();
@@ -764,7 +763,6 @@ static void crash_vmclear_local_loaded_vmcss(void)
 			    loaded_vmcss_on_cpu_link)
 		vmcs_clear(v->vmcs);
 }
-#endif /* CONFIG_KEXEC_CORE */
 
 static void __loaded_vmcs_clear(void *arg)
 {
@@ -8623,10 +8621,9 @@ static void __vmx_exit(void)
 {
 	allow_smaller_maxphyaddr = false;
 
-#ifdef CONFIG_KEXEC_CORE
 	RCU_INIT_POINTER(crash_vmclear_loaded_vmcss, NULL);
 	synchronize_rcu();
-#endif
+
 	vmx_cleanup_l1d_flush();
 }
 
@@ -8675,10 +8672,9 @@ static int __init vmx_init(void)
 		pi_init_cpu(cpu);
 	}
 
-#ifdef CONFIG_KEXEC_CORE
 	rcu_assign_pointer(crash_vmclear_loaded_vmcss,
 			   crash_vmclear_local_loaded_vmcss);
-#endif
+
 	vmx_check_vmcs12_offsets();
 
 	/*
-- 
2.40.1



