Return-Path: <stable+bounces-124152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B41DA5DC82
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 13:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CAF8177B95
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 12:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28548242909;
	Wed, 12 Mar 2025 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LuERG0dX"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3955223F387
	for <stable@vger.kernel.org>; Wed, 12 Mar 2025 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741782290; cv=none; b=XiKwn5hnciCahGzt9lYKepI61YrQJLMrHNZge3DkV9Uhb1NAPE7i2FPf4REwaJPRnY2I7JTtyMw7q0Mlu9vYYSs6tuwXceGrReCtb9ABINe3pr448Q1uDp0YEc1K7Qdr9lg/wUMCvM3bpEyg5mIvjTgejh2HsRUoHPdX81iI4xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741782290; c=relaxed/simple;
	bh=2aObfUgW5kLLChw1L77eViniYvt2fXMp2V77auMG68k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dG/kPldBtLiTi2Jt2nUudsINky6SFddF8aXsWB7SiRNQuqZ7FS3pUNNt21l+QSa7dBDDh3Rr1IOx0+XIF7ovPxv44/DGqcSm9WqbqRNwqsNpob2x76IHGcDxaytcV/oud0bm58Na4HWSBzBW+mgiLBcQThboNuZoyC+9t95vBU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LuERG0dX; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741782289; x=1773318289;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zS7POgrCKapyCaNIhR4qRcrAqmZzKbiAtGQtns8L5xw=;
  b=LuERG0dX3McCTsLRmfdSdGDq2KvtCZdEsJKOzPAz+exOVvaiRCzQITZO
   n7E9HN2ZEys2sbiAx4vjggB3AqeWd04cZ8o6qU3OQxiTZg8/xsEmqad/Y
   859ORpJG3Q6ILhK8r8ZUQ15NTL3gPiwWnR4AWKEujLx9k5bfysoA2NopD
   s=;
X-IronPort-AV: E=Sophos;i="6.14,241,1736812800"; 
   d="scan'208";a="181243565"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 12:24:47 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:54479]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.0.98:2525] with esmtp (Farcaster)
 id c3fd7185-ab74-48cf-a786-15e76a6c276a; Wed, 12 Mar 2025 12:24:46 +0000 (UTC)
X-Farcaster-Flow-ID: c3fd7185-ab74-48cf-a786-15e76a6c276a
Received: from EX19D016EUA002.ant.amazon.com (10.252.50.57) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 12 Mar 2025 12:24:41 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D016EUA002.ant.amazon.com (10.252.50.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 12 Mar 2025 12:24:40 +0000
Received: from email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 12:24:40 +0000
Received: from dev-dsk-kareemem-1c-885b5fe7.eu-west-1.amazon.com (dev-dsk-kareemem-1c-885b5fe7.eu-west-1.amazon.com [10.13.243.223])
	by email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com (Postfix) with ESMTPS id 406A1402B2;
	Wed, 12 Mar 2025 12:24:39 +0000 (UTC)
From: Abdelkareem Abdelsaamad <kareemem@amazon.com>
To: <stable@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Dongjie Zou
	<zoudongjie@huawei.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Abdelkareem Abdelsaamad
	<kareemem@amazon.com>
Subject: [PATCH 5.10.y] KVM: x86: Reject Hyper-V's SEND_IPI hypercalls if local APIC isn't in-kernel
Date: Wed, 12 Mar 2025 12:24:31 +0000
Message-ID: <20250312122431.39721-1-kareemem@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Sean Christopherson <seanjc@google.com>

commit a8de7f100bb5989d9c3627d3a223ee1c863f3b69 upstream.

Advertise support for Hyper-V's SEND_IPI and SEND_IPI_EX hypercalls if and
only if the local API is emulated/virtualized by KVM, and explicitly reject
said hypercalls if the local APIC is emulated in userspace, i.e. don't rely
on userspace to opt-in to KVM_CAP_HYPERV_ENFORCE_CPUID.

Rejecting SEND_IPI and SEND_IPI_EX fixes a NULL-pointer dereference if
Hyper-V enlightenments are exposed to the guest without an in-kernel local
APIC:

  dump_stack+0xbe/0xfd
  __kasan_report.cold+0x34/0x84
  kasan_report+0x3a/0x50
  __apic_accept_irq+0x3a/0x5c0
  kvm_hv_send_ipi.isra.0+0x34e/0x820
  kvm_hv_hypercall+0x8d9/0x9d0
  kvm_emulate_hypercall+0x506/0x7e0
  __vmx_handle_exit+0x283/0xb60
  vmx_handle_exit+0x1d/0xd0
  vcpu_enter_guest+0x16b0/0x24c0
  vcpu_run+0xc0/0x550
  kvm_arch_vcpu_ioctl_run+0x170/0x6d0
  kvm_vcpu_ioctl+0x413/0xb20
  __se_sys_ioctl+0x111/0x160
  do_syscal1_64+0x30/0x40
  entry_SYSCALL_64_after_hwframe+0x67/0xd1

Note, checking the sending vCPU is sufficient, as the per-VM irqchip_mode
can't be modified after vCPUs are created, i.e. if one vCPU has an
in-kernel local APIC, then all vCPUs have an in-kernel local APIC.

Reported-by: Dongjie Zou <zoudongjie@huawei.com>
Fixes: 214ff83d4473 ("KVM: x86: hyperv: implement PV IPI send hypercalls")
Fixes: 2bc39970e932 ("x86/kvm/hyper-v: Introduce KVM_GET_SUPPORTED_HV_CPUID")
Cc: stable@vger.kernel.org
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lore.kernel.org/r/20250118003454.2619573-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Conflict due to
72167a9d7da2 ("KVM: x86: hyper-v: Stop shadowing global 'current_vcpu'
variable")
not in the tree]
Signed-off-by: Abdelkareem Abdelsaamad <kareemem@amazon.com>
---
 arch/x86/kvm/hyperv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 20eb8f55e1f1..e097faf12c82 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1618,6 +1618,9 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *current_vcpu, u64 ingpa, u64 outgpa,
 	u32 vector;
 	bool all_cpus;
 
+	if (!lapic_in_kernel(current_vcpu))
+		return HV_STATUS_INVALID_HYPERCALL_INPUT;
+
 	if (!ex) {
 		if (!fast) {
 			if (unlikely(kvm_read_guest(kvm, ingpa, &send_ipi,
@@ -2060,7 +2063,8 @@ int kvm_vcpu_ioctl_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 			ent->eax |= HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED;
 			ent->eax |= HV_X64_APIC_ACCESS_RECOMMENDED;
 			ent->eax |= HV_X64_RELAXED_TIMING_RECOMMENDED;
-			ent->eax |= HV_X64_CLUSTER_IPI_RECOMMENDED;
+			if (!vcpu || lapic_in_kernel(vcpu))
+				ent->eax |= HV_X64_CLUSTER_IPI_RECOMMENDED;
 			ent->eax |= HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED;
 			if (evmcs_ver)
 				ent->eax |= HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
-- 
2.47.1


