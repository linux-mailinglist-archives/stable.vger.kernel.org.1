Return-Path: <stable+bounces-164471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C1DB0F6D3
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 17:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF449188F209
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FC32E542A;
	Wed, 23 Jul 2025 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eK5BfVcS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638C3170A26
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283661; cv=none; b=F9SI2boceDHM8/ceExBiivoxqSZI0JIjF38G9+NtMLoXHCoP/7liWuaLRAxyNLre49/OXT84kHP/Tt3j/z9nGTcnSCsi9EJXeuBoD1S10yxz+orbUChOAARn9YQYxrbaferLRrDQ7q/aDdxlwTVidcakHiZRF4kiHUquMpSuxmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283661; c=relaxed/simple;
	bh=ynp9z1BPrkAZ8xymsPnl3Kry1EsBuTECLuMxhWzLc4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KoSJQrUifhqgWvGER4VaqwW7EGG//+zRTxukYJ5LHzXxNAlP/RYS60vHD/zSFMb4VWiL+Hl4w/bVkqJ+8WO+IeotMhNcxSHM8nPppyZzg43VLqtudL7j6WLKCJlZoXaPqCXhArDjtE1dPZWSSgCWVKVGJ46U5kWjsXBnKOo5IRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eK5BfVcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24795C4CEE7;
	Wed, 23 Jul 2025 15:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753283661;
	bh=ynp9z1BPrkAZ8xymsPnl3Kry1EsBuTECLuMxhWzLc4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eK5BfVcSgkKCDx6TqVgLi8DHbP+Z0/ZYlNGoyOQRPPeTgAhTO2zysPPgUsv8t07t+
	 xwJ5865NqiS0vclmc0KePjG76roZeGECFxHxnlOjUcAQrLRxrpuJ5m2JqDL0EG06wa
	 nSzSVyFmefhL0iwq90OMdBU7vKF7CI7FOyTjn9tQui4Gi/NU7m9XzAInxCpXyipbZE
	 6iG+9xV/N5sDefV/2LbPxT67EsQNvbRAqBepAu8UegE2rWb6jhEN1rnkkmv/iaxaoz
	 mh4RBvtUTp6hU6cOBr3y08Ln/kx+gKHCe2hzcKbPVZPoniXVRnGvgJskmdilL3N3Rz
	 +G0IestKFM1Tw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/5] KVM: x86: drop x86.h include from cpuid.h
Date: Wed, 23 Jul 2025 11:14:12 -0400
Message-Id: <20250723151416.1092631-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025071240-phoney-deniable-545a@gregkh>
References: <2025071240-phoney-deniable-545a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Levitsky <mlevitsk@redhat.com>

[ Upstream commit e52ad1ddd0a3b07777141ec9406d5dc2c9a0de17 ]

Drop x86.h include from cpuid.h to allow the x86.h to include the cpuid.h
instead.

Also fix various places where x86.h was implicitly included via cpuid.h

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Link: https://lore.kernel.org/r/20240906221824.491834-2-mlevitsk@redhat.com
[sean: fixup a missed include in mtrr.c]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: fa787ac07b3c ("KVM: x86/hyper-v: Skip non-canonical addresses during PV TLB flush")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/cpuid.h      | 1 -
 arch/x86/kvm/mmu.h        | 1 +
 arch/x86/kvm/mtrr.c       | 1 +
 arch/x86/kvm/vmx/hyperv.c | 1 +
 arch/x86/kvm/vmx/nested.c | 2 +-
 arch/x86/kvm/vmx/sgx.c    | 3 +--
 6 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index ad479cfb91bc7..f16a7b2c2adcf 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -2,7 +2,6 @@
 #ifndef ARCH_X86_KVM_CPUID_H
 #define ARCH_X86_KVM_CPUID_H
 
-#include "x86.h"
 #include "reverse_cpuid.h"
 #include <asm/cpu.h>
 #include <asm/processor.h>
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 9dc5dd43ae7f2..e9322358678b6 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -4,6 +4,7 @@
 
 #include <linux/kvm_host.h>
 #include "kvm_cache_regs.h"
+#include "x86.h"
 #include "cpuid.h"
 
 extern bool __read_mostly enable_mmio_caching;
diff --git a/arch/x86/kvm/mtrr.c b/arch/x86/kvm/mtrr.c
index 05490b9d8a434..6f74e2b27c1ed 100644
--- a/arch/x86/kvm/mtrr.c
+++ b/arch/x86/kvm/mtrr.c
@@ -19,6 +19,7 @@
 #include <asm/mtrr.h>
 
 #include "cpuid.h"
+#include "x86.h"
 
 static u64 *find_mtrr(struct kvm_vcpu *vcpu, unsigned int msr)
 {
diff --git a/arch/x86/kvm/vmx/hyperv.c b/arch/x86/kvm/vmx/hyperv.c
index fab6a1ad98dc1..fa41d036acd49 100644
--- a/arch/x86/kvm/vmx/hyperv.c
+++ b/arch/x86/kvm/vmx/hyperv.c
@@ -4,6 +4,7 @@
 #include <linux/errno.h>
 #include <linux/smp.h>
 
+#include "x86.h"
 #include "../cpuid.h"
 #include "hyperv.h"
 #include "nested.h"
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 22bee8a711442..7c42d8627fc90 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -7,6 +7,7 @@
 #include <asm/debugreg.h>
 #include <asm/mmu_context.h>
 
+#include "x86.h"
 #include "cpuid.h"
 #include "hyperv.h"
 #include "mmu.h"
@@ -16,7 +17,6 @@
 #include "sgx.h"
 #include "trace.h"
 #include "vmx.h"
-#include "x86.h"
 #include "smm.h"
 
 static bool __read_mostly enable_shadow_vmcs = 1;
diff --git a/arch/x86/kvm/vmx/sgx.c b/arch/x86/kvm/vmx/sgx.c
index a3c3d2a51f47d..7fc64b759f851 100644
--- a/arch/x86/kvm/vmx/sgx.c
+++ b/arch/x86/kvm/vmx/sgx.c
@@ -4,12 +4,11 @@
 
 #include <asm/sgx.h>
 
-#include "cpuid.h"
+#include "x86.h"
 #include "kvm_cache_regs.h"
 #include "nested.h"
 #include "sgx.h"
 #include "vmx.h"
-#include "x86.h"
 
 bool __read_mostly enable_sgx = 1;
 module_param_named(sgx, enable_sgx, bool, 0444);
-- 
2.39.5


