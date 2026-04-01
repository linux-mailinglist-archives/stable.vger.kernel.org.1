Return-Path: <stable+bounces-232630-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPuFFIJqzGlXSwYAu9opvQ
	(envelope-from <stable+bounces-232630-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:44:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC7F373425
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 102C13034202
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 00:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970F01EB1AA;
	Wed,  1 Apr 2026 00:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1mUBPo+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC601D5146
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 00:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775004281; cv=none; b=OYAeITPurSxLcjNomNz8VEaoK4SN8SB0KVUe0O2zOobJKo7KpOvfSlnQPUSTHcziO+5kVtkvf2jRpnxE3KRNCnSMSnNq33rOoFBCegh5xMWPiKQaod03kgYNWTqL8cfXlI2QDd+kvvnSCJtmiGiBvPIJ+/zAETzTLEAtjkyH2is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775004281; c=relaxed/simple;
	bh=KwpVvquIJ71zR4kLsr7quLVkpwY5T7Yu3Q+C3u1ZC84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jzu++3IVeWqSM6e5VekvadPAzRjjWvO/zgbKWXjj8jjsOExJRQ7xtJbSyaug9gN8eorQqZ2iGz9xY+Nx5CmGkdOF8N96urO/7gxcBwKhlEKhfR6uldRSrmTiPqfqfj03W3b22ni8VAkGFHgS+Utnc3C9NFQaMZB9/yw+smykD7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1mUBPo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FB5C19423;
	Wed,  1 Apr 2026 00:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775004281;
	bh=KwpVvquIJ71zR4kLsr7quLVkpwY5T7Yu3Q+C3u1ZC84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p1mUBPo+hpANa/yCU4S/W2nsmwcHqYstgn52yk85CJqzSrIHAmGbx8kd54KzyyTAR
	 6NO042xkClC5talOC9/rKt1YlyDp0zk7Jz2yrGsiV19oxRpoqL0U+NgXo1Thzm3UXa
	 AbwHcsFNPvYGTMggGrlgw4efUk1YooZwPPVPjG6vZrcZNAHTILJELjr/RuUtCPxy6N
	 xyRG+zBP6TbRCmg/nSsLnIkZWS9qkEzbyzJY84eQkArnJjnwSQm4WKsZD30DKdCC+M
	 dCgEMTjtCuOUsZxrrTBUBLLwe/tIAo4ipl5fMxKiJSqsWvAlPMerGcvZxVrEcaPTXg
	 idUmCrmgxry2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] KVM: x86/mmu: Drop/zap existing present SPTE even when creating an MMIO SPTE
Date: Tue, 31 Mar 2026 20:44:37 -0400
Message-ID: <20260401004437.4036016-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033039-occupy-slush-db02@gregkh>
References: <2026033039-occupy-slush-db02@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232630-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ECC7F373425
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit aad885e774966e97b675dfe928da164214a71605 ]

When installing an emulated MMIO SPTE, do so *after* dropping/zapping the
existing SPTE (if it's shadow-present).  While commit a54aa15c6bda3 was
right about it being impossible to convert a shadow-present SPTE to an
MMIO SPTE due to a _guest_ write, it failed to account for writes to guest
memory that are outside the scope of KVM.

E.g. if host userspace modifies a shadowed gPTE to switch from a memslot
to emulted MMIO and then the guest hits a relevant page fault, KVM will
install the MMIO SPTE without first zapping the shadow-present SPTE.

  ------------[ cut here ]------------
  is_shadow_present_pte(*sptep)
  WARNING: arch/x86/kvm/mmu/mmu.c:484 at mark_mmio_spte+0xb2/0xc0 [kvm], CPU#0: vmx_ept_stale_r/4292
  Modules linked in: kvm_intel kvm irqbypass
  CPU: 0 UID: 1000 PID: 4292 Comm: vmx_ept_stale_r Not tainted 7.0.0-rc2-eafebd2d2ab0-sink-vm #319 PREEMPT
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:mark_mmio_spte+0xb2/0xc0 [kvm]
  Call Trace:
   <TASK>
   mmu_set_spte+0x237/0x440 [kvm]
   ept_page_fault+0x535/0x7f0 [kvm]
   kvm_mmu_do_page_fault+0xee/0x1f0 [kvm]
   kvm_mmu_page_fault+0x8d/0x620 [kvm]
   vmx_handle_exit+0x18c/0x5a0 [kvm_intel]
   kvm_arch_vcpu_ioctl_run+0xc55/0x1c20 [kvm]
   kvm_vcpu_ioctl+0x2d5/0x980 [kvm]
   __x64_sys_ioctl+0x8a/0xd0
   do_syscall_64+0xb5/0x730
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
  RIP: 0033:0x47fa3f
   </TASK>
  ---[ end trace 0000000000000000 ]---

Reported-by: Alexander Bulekov <bkov@amazon.com>
Debugged-by: Alexander Bulekov <bkov@amazon.com>
Suggested-by: Fred Griffoul <fgriffo@amazon.co.uk>
Fixes: a54aa15c6bda3 ("KVM: x86/mmu: Handle MMIO SPTEs directly in mmu_set_spte()")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ replaced `kvm_flush_remote_tlbs_gfn()` with `kvm_flush_remote_tlbs_with_address()` and omitted `pf_mmio_spte_created` stat counter ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/mmu/mmu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 13bf3198d0cee..79bcb5430b5f8 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2619,6 +2619,14 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 			was_rmapped = 1;
 	}
 
+	if (unlikely(is_noslot_pfn(pfn))) {
+		mark_mmio_spte(vcpu, sptep, gfn, pte_access);
+		if (flush)
+			kvm_flush_remote_tlbs_with_address(vcpu->kvm, gfn,
+					KVM_PAGES_PER_HPAGE(level));
+		return RET_PF_EMULATE;
+	}
+
 	set_spte_ret = set_spte(vcpu, sptep, pte_access, level, gfn, pfn,
 				speculative, true, host_writable);
 	if (set_spte_ret & SET_SPTE_WRITE_PROTECTED_PT) {
-- 
2.53.0


