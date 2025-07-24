Return-Path: <stable+bounces-164648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BC1B1102F
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 19:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B813B6C56
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 17:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE1B2EA758;
	Thu, 24 Jul 2025 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbQBxSgs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90FA1E5B6F
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753376854; cv=none; b=HWOCTHcArjT/cpI7gMB+UKrEqPdKloMk6ti5zwQLy4I2LI8DV9v7bsOBXU+k1Xxja993d1gP9GacjE/ZmJ1GAvqlNm/2OyzrSFzOJFieUZojgmawKQ5o24XGaYFU0VHUxXHxWffdtfC7bggg8+0Dqv8Lgx8ApUYhIemYr2QWvBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753376854; c=relaxed/simple;
	bh=htNaltEL7EoVBVHbpLsjkNcjOTHdhi1OAV4P4GdIGVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qqI6XmIywmzeG9CBQZry4Lqt7bWssHxFEEcDE/AaJ/IgSDulialIKX7vK7Z/9h5CU0/DuGbpqAKnYR2uDo0o1fv2QnKxVHSSSdVupCQTbYdlCFtzd30pulB5koYbJm8cK9FZUAbWv/qw2UdBg+4ggTRm/grmLYg+4u27Km5chcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbQBxSgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EE0C4CEF6;
	Thu, 24 Jul 2025 17:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753376853;
	bh=htNaltEL7EoVBVHbpLsjkNcjOTHdhi1OAV4P4GdIGVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TbQBxSgsnVBbfrJQt5N6LByBrnM1iN7sdUZYZeR0LWD5Bt0q+WokPNg1mluKh0i7B
	 HBGYEtkWbA87bzCYzZCp0VBc98OSlOszB7M1+QRCtaDUbGrOjwcdM8bCXIr8iYD3hd
	 aZzaATV0ZfQzVM1x0Zeh1Byef0V3PRIXV+8tJDF0yUgOMiWYjwuvkY/5028vGD88VC
	 Apowo7/WVeuzbRXWPhqNTMMZ8+3bOO9KQlNonhjlHlI+vBagaW/yUi+lS6jPc5kewl
	 Wbrp8ZD2RVDgP4TuTbhhJaAX9WzJTTglYFJYKWA5MMW3qqVaS+Jb1PpcVnNXdtD6Pi
	 h/ci62gxYlapg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Kai Huang <kai.huang@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] x86/reboot: KVM: Handle VMXOFF in KVM's reboot callback
Date: Thu, 24 Jul 2025 13:07:24 -0400
Message-Id: <20250724170725.1404455-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724170725.1404455-1-sashal@kernel.org>
References: <2025062034-chastise-wrecking-9a12@gregkh>
 <20250724170725.1404455-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 119b5cb4ffd0166f3e98e9ee042f5046f7744f28 ]

Use KVM VMX's reboot/crash callback to do VMXOFF in an emergency instead
of manually and blindly doing VMXOFF.  There's no need to attempt VMXOFF
if a hypervisor, i.e. KVM, isn't loaded/active, i.e. if the CPU can't
possibly be post-VMXON.

Reviewed-by: Kai Huang <kai.huang@intel.com>
Link: https://lore.kernel.org/r/20230721201859.2307736-4-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: a0ee1d5faff1 ("KVM: VMX: Flush shadow VMCS on emergency reboot")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/virtext.h | 10 ----------
 arch/x86/kernel/reboot.c       | 29 +++++++++--------------------
 arch/x86/kvm/vmx/vmx.c         |  8 +++++---
 3 files changed, 14 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index 724ce44809ed2..1b683bf71d14f 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -70,16 +70,6 @@ static inline void __cpu_emergency_vmxoff(void)
 		cpu_vmxoff();
 }
 
-/** Disable VMX if it is supported and enabled on the current CPU
- */
-static inline void cpu_emergency_vmxoff(void)
-{
-	if (cpu_has_vmx())
-		__cpu_emergency_vmxoff();
-}
-
-
-
 
 /*
  * SVM functions:
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 635995e7a704a..79e1ac3d0625d 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -787,13 +787,7 @@ void machine_crash_shutdown(struct pt_regs *regs)
 }
 #endif
 
-/*
- * This is used to VMCLEAR all VMCSs loaded on the
- * processor. And when loading kvm_intel module, the
- * callback function pointer will be assigned.
- *
- * protected by rcu.
- */
+/* RCU-protected callback to disable virtualization prior to reboot. */
 static cpu_emergency_virt_cb __rcu *cpu_emergency_virt_callback;
 
 void cpu_emergency_register_virt_callback(cpu_emergency_virt_cb *callback)
@@ -815,17 +809,6 @@ void cpu_emergency_unregister_virt_callback(cpu_emergency_virt_cb *callback)
 }
 EXPORT_SYMBOL_GPL(cpu_emergency_unregister_virt_callback);
 
-static inline void cpu_crash_vmclear_loaded_vmcss(void)
-{
-	cpu_emergency_virt_cb *callback;
-
-	rcu_read_lock();
-	callback = rcu_dereference(cpu_emergency_virt_callback);
-	if (callback)
-		callback();
-	rcu_read_unlock();
-}
-
 /* This is the CPU performing the emergency shutdown work. */
 int crashing_cpu = -1;
 
@@ -836,9 +819,15 @@ int crashing_cpu = -1;
  */
 void cpu_emergency_disable_virtualization(void)
 {
-	cpu_crash_vmclear_loaded_vmcss();
+	cpu_emergency_virt_cb *callback;
+
+	rcu_read_lock();
+	callback = rcu_dereference(cpu_emergency_virt_callback);
+	if (callback)
+		callback();
+	rcu_read_unlock();
 
-	cpu_emergency_vmxoff();
+	/* KVM_AMD doesn't yet utilize the common callback. */
 	cpu_emergency_svm_disable();
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index aef2f09718b57..ef9cb8445dc48 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -705,7 +705,7 @@ static int vmx_set_guest_uret_msr(struct vcpu_vmx *vmx,
 	return ret;
 }
 
-static void crash_vmclear_local_loaded_vmcss(void)
+static void vmx_emergency_disable(void)
 {
 	int cpu = raw_smp_processor_id();
 	struct loaded_vmcs *v;
@@ -713,6 +713,8 @@ static void crash_vmclear_local_loaded_vmcss(void)
 	list_for_each_entry(v, &per_cpu(loaded_vmcss_on_cpu, cpu),
 			    loaded_vmcss_on_cpu_link)
 		vmcs_clear(v->vmcs);
+
+	__cpu_emergency_vmxoff();
 }
 
 static void __loaded_vmcs_clear(void *arg)
@@ -8554,7 +8556,7 @@ static void __vmx_exit(void)
 {
 	allow_smaller_maxphyaddr = false;
 
-	cpu_emergency_unregister_virt_callback(crash_vmclear_local_loaded_vmcss);
+	cpu_emergency_unregister_virt_callback(vmx_emergency_disable);
 
 	vmx_cleanup_l1d_flush();
 }
@@ -8628,7 +8630,7 @@ static int __init vmx_init(void)
 		pi_init_cpu(cpu);
 	}
 
-	cpu_emergency_register_virt_callback(crash_vmclear_local_loaded_vmcss);
+	cpu_emergency_register_virt_callback(vmx_emergency_disable);
 
 	vmx_check_vmcs12_offsets();
 
-- 
2.39.5


