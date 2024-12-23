Return-Path: <stable+bounces-105855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128569FB20D
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 17:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D33162716
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800081B2EEB;
	Mon, 23 Dec 2024 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cZuIushn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0821AF0C7;
	Mon, 23 Dec 2024 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734970370; cv=none; b=nRYZ9sCBra4A323tE9X5KVu2NQWMrd6H3q6CQb7vT/CDmtqujfuwSgSt7jGzd0AZ4lJq2qRb3raKumnuwOZW1CyzBy9D0AsVVebkeux+k3EkqqpP+5Xn+3SzaAdbkUNyYXBsSJznT0vTP/wQ26ksa2msxMismnJ9oABKRi30QIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734970370; c=relaxed/simple;
	bh=z3M9MU/BlK9qy0+3nQbkuIRqoMAmkJrjmwwQfOAm8Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gw3D+PJkPw+k787NblnY4FvSaqe/F98asbxYN+6iSzrikIlaWsoeo6t05eLKBAGJM3ILaTVKlCb868k1AtOc1XxXv29QU/Ods2jpETpfQlbW62w9C2ZEnet7GzowrOV1FizoABLeHkgDFqcYPeICJ1UBjLEuy2hnBIRXpfuzt4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cZuIushn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8537FC4CED3;
	Mon, 23 Dec 2024 16:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734970370;
	bh=z3M9MU/BlK9qy0+3nQbkuIRqoMAmkJrjmwwQfOAm8Qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cZuIushnssr52pupPIREHo62EMT36iGTQFq0onxxfE98h9AijboUlKfwAOMUzY3X9
	 Q7iRI2KXHlz94bX9mhKUKAL2ACgfJ4bSDpteja2Llc9CdwwqBOpg6lyQmaKUkRtpr4
	 R6nrVcDM3MvfMSRakuVmnBlP7SIL39HfaE+VgzW8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jim Mattson <jmattson@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 6.6 061/116] KVM: x86: Cache CPUID.0xD XSTATE offsets+sizes during module init
Date: Mon, 23 Dec 2024 16:58:51 +0100
Message-ID: <20241223155401.935305157@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223155359.534468176@linuxfoundation.org>
References: <20241223155359.534468176@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

commit 1201f226c863b7da739f7420ddba818cedf372fc upstream.

Snapshot the output of CPUID.0xD.[1..n] during kvm.ko initiliaization to
avoid the overead of CPUID during runtime.  The offset, size, and metadata
for CPUID.0xD.[1..n] sub-leaves does not depend on XCR0 or XSS values, i.e.
is constant for a given CPU, and thus can be cached during module load.

On Intel's Emerald Rapids, CPUID is *wildly* expensive, to the point where
recomputing XSAVE offsets and sizes results in a 4x increase in latency of
nested VM-Enter and VM-Exit (nested transitions can trigger
xstate_required_size() multiple times per transition), relative to using
cached values.  The issue is easily visible by running `perf top` while
triggering nested transitions: kvm_update_cpuid_runtime() shows up at a
whopping 50%.

As measured via RDTSC from L2 (using KVM-Unit-Test's CPUID VM-Exit test
and a slightly modified L1 KVM to handle CPUID in the fastpath), a nested
roundtrip to emulate CPUID on Skylake (SKX), Icelake (ICX), and Emerald
Rapids (EMR) takes:

  SKX 11650
  ICX 22350
  EMR 28850

Using cached values, the latency drops to:

  SKX 6850
  ICX 9000
  EMR 7900

The underlying issue is that CPUID itself is slow on ICX, and comically
slow on EMR.  The problem is exacerbated on CPUs which support XSAVES
and/or XSAVEC, as KVM invokes xstate_required_size() twice on each
runtime CPUID update, and because there are more supported XSAVE features
(CPUID for supported XSAVE feature sub-leafs is significantly slower).

 SKX:
  CPUID.0xD.2  = 348 cycles
  CPUID.0xD.3  = 400 cycles
  CPUID.0xD.4  = 276 cycles
  CPUID.0xD.5  = 236 cycles
  <other sub-leaves are similar>

 EMR:
  CPUID.0xD.2  = 1138 cycles
  CPUID.0xD.3  = 1362 cycles
  CPUID.0xD.4  = 1068 cycles
  CPUID.0xD.5  = 910 cycles
  CPUID.0xD.6  = 914 cycles
  CPUID.0xD.7  = 1350 cycles
  CPUID.0xD.8  = 734 cycles
  CPUID.0xD.9  = 766 cycles
  CPUID.0xD.10 = 732 cycles
  CPUID.0xD.11 = 718 cycles
  CPUID.0xD.12 = 734 cycles
  CPUID.0xD.13 = 1700 cycles
  CPUID.0xD.14 = 1126 cycles
  CPUID.0xD.15 = 898 cycles
  CPUID.0xD.16 = 716 cycles
  CPUID.0xD.17 = 748 cycles
  CPUID.0xD.18 = 776 cycles

Note, updating runtime CPUID information multiple times per nested
transition is itself a flaw, especially since CPUID is a mandotory
intercept on both Intel and AMD.  E.g. KVM doesn't need to ensure emulated
CPUID state is up-to-date while running L2.  That flaw will be fixed in a
future patch, as deferring runtime CPUID updates is more subtle than it
appears at first glance, the benefits aren't super critical to have once
the XSAVE issue is resolved, and caching CPUID output is desirable even if
KVM's updates are deferred.

Cc: Jim Mattson <jmattson@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20241211013302.1347853-2-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/cpuid.c |   31 ++++++++++++++++++++++++++-----
 arch/x86/kvm/cpuid.h |    1 +
 arch/x86/kvm/x86.c   |    2 ++
 3 files changed, 29 insertions(+), 5 deletions(-)

--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -36,6 +36,26 @@
 u32 kvm_cpu_caps[NR_KVM_CPU_CAPS] __read_mostly;
 EXPORT_SYMBOL_GPL(kvm_cpu_caps);
 
+struct cpuid_xstate_sizes {
+	u32 eax;
+	u32 ebx;
+	u32 ecx;
+};
+
+static struct cpuid_xstate_sizes xstate_sizes[XFEATURE_MAX] __ro_after_init;
+
+void __init kvm_init_xstate_sizes(void)
+{
+	u32 ign;
+	int i;
+
+	for (i = XFEATURE_YMM; i < ARRAY_SIZE(xstate_sizes); i++) {
+		struct cpuid_xstate_sizes *xs = &xstate_sizes[i];
+
+		cpuid_count(0xD, i, &xs->eax, &xs->ebx, &xs->ecx, &ign);
+	}
+}
+
 u32 xstate_required_size(u64 xstate_bv, bool compacted)
 {
 	int feature_bit = 0;
@@ -44,14 +64,15 @@ u32 xstate_required_size(u64 xstate_bv,
 	xstate_bv &= XFEATURE_MASK_EXTEND;
 	while (xstate_bv) {
 		if (xstate_bv & 0x1) {
-		        u32 eax, ebx, ecx, edx, offset;
-		        cpuid_count(0xD, feature_bit, &eax, &ebx, &ecx, &edx);
+			struct cpuid_xstate_sizes *xs = &xstate_sizes[feature_bit];
+			u32 offset;
+
 			/* ECX[1]: 64B alignment in compacted form */
 			if (compacted)
-				offset = (ecx & 0x2) ? ALIGN(ret, 64) : ret;
+				offset = (xs->ecx & 0x2) ? ALIGN(ret, 64) : ret;
 			else
-				offset = ebx;
-			ret = max(ret, offset + eax);
+				offset = xs->ebx;
+			ret = max(ret, offset + xs->eax);
 		}
 
 		xstate_bv >>= 1;
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -32,6 +32,7 @@ int kvm_vcpu_ioctl_get_cpuid2(struct kvm
 bool kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u32 *ebx,
 	       u32 *ecx, u32 *edx, bool exact_only);
 
+void __init kvm_init_xstate_sizes(void);
 u32 xstate_required_size(u64 xstate_bv, bool compacted);
 
 int cpuid_query_maxphyaddr(struct kvm_vcpu *vcpu);
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13694,6 +13694,8 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_vmgexit
 
 static int __init kvm_x86_init(void)
 {
+	kvm_init_xstate_sizes();
+
 	kvm_mmu_x86_module_init();
 	mitigate_smt_rsb &= boot_cpu_has_bug(X86_BUG_SMT_RSB) && cpu_smt_possible();
 	return 0;



