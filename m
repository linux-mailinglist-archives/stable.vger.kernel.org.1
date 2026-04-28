Return-Path: <stable+bounces-241784-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FXGBMoq8WkJeQEAu9opvQ
	(envelope-from <stable+bounces-241784-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 23:46:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF5B48C64A
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 23:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 15BC9301E659
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 21:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BB51862A;
	Tue, 28 Apr 2026 21:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="ecwCEO8O"
X-Original-To: stable@vger.kernel.org
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F80A29CE9
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 21:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777412807; cv=none; b=ZilqqcAsus7Khr9Zk6VJ0+7lgrWOHpSnz3UOcIoGhgMSq9nL8B0fBOwSgwXDMQUlB5BAAlby+aIl83nkjMtEJXk526nRRYE5/3Bz0euy3QXVOiv7QoUjZmBBPkpvWXDomCegfaXpiQfN7FeyWdQa40fyip0bdV2URGRa0FvkUXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777412807; c=relaxed/simple;
	bh=rFLZYY7c/bvLuWly86LbBKa8tBhc3B2uNHrSUR9zhEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O3rmzItci0tYdklyIddLvzSADpNXV4zmAURSdpsck8TS0duzGdx3K0Ia6Tof3fcB6+9701YLEc/8TP7XfwsCkHWqYxHs5yxDGeRW6tDKB66lyMN3zY66rhKdIog0f0a2TKFvIegnb0o7TEhZULhsIIvzxtLFneRCa8IrexMj3VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=ecwCEO8O; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id E12B6C0269;
	Wed, 29 Apr 2026 00:46:43 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown [2a02:6bf:8080:761::1:11])
	by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA id TkhkmZ1L4iE0-0xEjLUEv;
	Wed, 29 Apr 2026 00:46:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1777412803;
	bh=It9c3ljWoFuAhx+GFzLS9Dpl6niS/i1eIB5fYFweXwY=;
	h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=ecwCEO8O2S3+4iRMkURiy2ZKWmsbT7nfe1lw8dQ3uPmX+a0jnSzTNc7q/a1NHDE2O
	 OXHfUYbl4wsLg9Q1kr/rt5Uq31Ki/s/xEpcqKu5kgA6cYTwG196VRkZzPBal1GotgP
	 pEyYZ1qlXmMxsQ2YyEHEPIBZXKUoHq+4fIJnrWOw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: stable@vger.kernel.org
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	"Xin Li (Intel)" <xin@zytor.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Michael Larabel <Michael@michaellarabel.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.6.y v1 6/6] KVM: SVM: Set/clear SRSO's BP_SPEC_REDUCE on 0 <=> 1 VM count transitions
Date: Wed, 29 Apr 2026 00:46:10 +0300
Message-Id: <20260428214610.2138600-7-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428214610.2138600-1-d-tatianin@yandex-team.ru>
References: <20260428214610.2138600-1-d-tatianin@yandex-team.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CAF5B48C64A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[yandex-team.ru:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yandex-team.ru,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[yandex-team.ru:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241784-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_NEQ_ENVFROM(0.00)[d-tatianin@yandex-team.ru,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[yandex-team.ru:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alien8.de:email]

[ Upstream commit e3417ab75ab2e7dca6372a1bfa26b1be3ac5889e ]

Set the magic BP_SPEC_REDUCE bit to mitigate SRSO when running VMs if and
only if KVM has at least one active VM.  Leaving the bit set at all times
unfortunately degrades performance by a wee bit more than expected.

Use a dedicated spinlock and counter instead of hooking virtualization
enablement, as changing the behavior of kvm.enable_virt_at_load based on
SRSO_BP_SPEC_REDUCE is painful, and has its own drawbacks, e.g. could
result in performance issues for flows that are sensitive to VM creation
latency.

Defer setting BP_SPEC_REDUCE until VMRUN is imminent to avoid impacting
performance on CPUs that aren't running VMs, e.g. if a setup is using
housekeeping CPUs.  Setting BP_SPEC_REDUCE in task context, i.e. without
blasting IPIs to all CPUs, also helps avoid serializing 1<=>N transitions
without incurring a gross amount of complexity (see the Link for details
on how ugly coordinating via IPIs gets).

Link: https://lore.kernel.org/all/aBOnzNCngyS_pQIW@google.com
Fixes: 8442df2b49ed ("x86/bugs: KVM: Add support for SRSO_MSR_FIX")
Reported-by: Michael Larabel <Michael@michaellarabel.com>
Closes: https://www.phoronix.com/review/linux-615-amd-regression
Cc: Borislav Petkov <bp@alien8.de>
Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250505180300.973137-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 arch/x86/kvm/svm/svm.c | 71 ++++++++++++++++++++++++++++++++++++++----
 arch/x86/kvm/svm/svm.h |  2 ++
 2 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ecb77ac074ea1..4a319e4fc51bd 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -623,9 +623,6 @@ static void svm_hardware_disable(void)
 	kvm_cpu_svm_disable();
 
 	amd_pmu_disable_virt();
-
-	if (cpu_feature_enabled(X86_FEATURE_SRSO_BP_SPEC_REDUCE))
-		msr_clear_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT);
 }
 
 static int svm_hardware_enable(void)
@@ -706,9 +703,6 @@ static int svm_hardware_enable(void)
 		rdmsr(MSR_TSC_AUX, hostsa->tsc_aux, msr_hi);
 	}
 
-	if (cpu_feature_enabled(X86_FEATURE_SRSO_BP_SPEC_REDUCE))
-		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT);
-
 	return 0;
 }
 
@@ -1533,6 +1527,63 @@ static void svm_vcpu_free(struct kvm_vcpu *vcpu)
 	__free_pages(virt_to_page(svm->msrpm), get_order(MSRPM_SIZE));
 }
 
+#ifdef CONFIG_CPU_MITIGATIONS
+static DEFINE_SPINLOCK(srso_lock);
+static atomic_t srso_nr_vms;
+
+static void svm_srso_clear_bp_spec_reduce(void *ign)
+{
+	struct svm_cpu_data *sd = this_cpu_ptr(&svm_data);
+
+	if (!sd->bp_spec_reduce_set)
+		return;
+
+	msr_clear_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT);
+	sd->bp_spec_reduce_set = false;
+}
+
+static void svm_srso_vm_destroy(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_SRSO_BP_SPEC_REDUCE))
+		return;
+
+	if (atomic_dec_return(&srso_nr_vms))
+		return;
+
+	guard(spinlock)(&srso_lock);
+
+	/*
+	 * Verify a new VM didn't come along, acquire the lock, and increment
+	 * the count before this task acquired the lock.
+	 */
+	if (atomic_read(&srso_nr_vms))
+		return;
+
+	on_each_cpu(svm_srso_clear_bp_spec_reduce, NULL, 1);
+}
+
+static void svm_srso_vm_init(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_SRSO_BP_SPEC_REDUCE))
+		return;
+
+	/*
+	 * Acquire the lock on 0 => 1 transitions to ensure a potential 1 => 0
+	 * transition, i.e. destroying the last VM, is fully complete, e.g. so
+	 * that a delayed IPI doesn't clear BP_SPEC_REDUCE after a vCPU runs.
+	 */
+	if (atomic_inc_not_zero(&srso_nr_vms))
+		return;
+
+	guard(spinlock)(&srso_lock);
+
+	atomic_inc(&srso_nr_vms);
+}
+#else
+static void svm_srso_vm_init(void) { }
+static void svm_srso_vm_destroy(void) { }
+#endif
+
 static void svm_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -1569,6 +1620,11 @@ static void svm_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 	    (!boot_cpu_has(X86_FEATURE_V_TSC_AUX) || !sev_es_guest(vcpu->kvm)))
 		kvm_set_user_return_msr(tsc_aux_uret_slot, svm->tsc_aux, -1ull);
 
+	if (cpu_feature_enabled(X86_FEATURE_SRSO_BP_SPEC_REDUCE) &&
+	    !sd->bp_spec_reduce_set) {
+		sd->bp_spec_reduce_set = true;
+		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT);
+	}
 	svm->guest_state_loaded = true;
 }
 
@@ -5001,6 +5057,8 @@ static void svm_vm_destroy(struct kvm *kvm)
 {
 	avic_vm_destroy(kvm);
 	sev_vm_destroy(kvm);
+
+	svm_srso_vm_destroy();
 }
 
 static int svm_vm_init(struct kvm *kvm)
@@ -5014,6 +5072,7 @@ static int svm_vm_init(struct kvm *kvm)
 			return ret;
 	}
 
+	svm_srso_vm_init();
 	return 0;
 }
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 0b4344595db37..d5548ea995f1c 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -300,6 +300,8 @@ struct svm_cpu_data {
 	u32 next_asid;
 	u32 min_asid;
 
+	bool bp_spec_reduce_set;
+
 	struct page *save_area;
 	unsigned long save_area_pa;
 
-- 
2.34.1


