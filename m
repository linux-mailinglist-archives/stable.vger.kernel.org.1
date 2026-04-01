Return-Path: <stable+bounces-232616-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAi7MUhlzGnZSgYAu9opvQ
	(envelope-from <stable+bounces-232616-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:22:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3969937317D
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47FA83004C74
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 00:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DD019067C;
	Wed,  1 Apr 2026 00:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHKODAfa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5403218C332
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 00:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775002764; cv=none; b=Op++T8O6ExHrSwl6YXTmkME216CttUl/weQBoGP16Z1JH0AuV3sPI+mAaNJBGuaU5MV9lERIKejQcO46LlS+CI3eS3LrHcVCW16M/WVSp90OwgI/8Hmvcj7Nu99E1QBtfPXAtJUKOaj7H4ZEyoF0BBO2e1jWyodi1I6Y4Xf/z+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775002764; c=relaxed/simple;
	bh=gglabgqdiJuUAASlPNy/Z2xhBEy+YtuEBIpJ59nKp2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpK7VOETipltTsxr9F6DZv3FKQ9LNReCBB9jL23+T1oPUYXuhLl03e8xP9NHzog6H7dlTp8xVRd7Q1wZp6toKP/qStSVbXdjiZhGB7ez1Ze2xfEXeI7fsa3h1dnaXjy1pmTWte1gZ65heDW+4TB3gupP5PUceSDNc7D8Tm1fKm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHKODAfa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570E6C2BCB0;
	Wed,  1 Apr 2026 00:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775002763;
	bh=gglabgqdiJuUAASlPNy/Z2xhBEy+YtuEBIpJ59nKp2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kHKODAfaUrSxDqnPDlxAQQY/oReGkpIbawMPv6L7wh4Vz/LHYByMdZMJOwltVNkQL
	 ZyqpPTDteKOXkn8CrU6MiyCBKMDgbkar1uJUDWbIgs/B9wzEWN3Oi7r9Sdpm3wJ96M
	 CVh4slIq/zKuPduWwuWTn+V4Yiy7RLcpwd6YSHEBo4tomRw+pL2UE1UCsdFSn4QlNF
	 n+xHpVMmzKxWDJkQPbhk8cqLfbLBmUnnYmfniKbSqGb5iCcdaIPfU4yQ8F3q+lUopP
	 V+Vg7xQP2nh6RwXQ1X2jTFYCvRhkOM0gbYyYQB3bQKPco63ZMokRGreexfzTkOKGpO
	 8TNUVpzAJdFfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] KVM: x86/mmu: Drop/zap existing present SPTE even when creating an MMIO SPTE
Date: Tue, 31 Mar 2026 20:19:21 -0400
Message-ID: <20260401001921.3983428-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033038-rebate-reclusive-6171@gregkh>
References: <2026033038-rebate-reclusive-6171@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232616-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3969937317D
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
 arch/x86/kvm/mmu/mmu.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index acb9193fc06a4..e4813964bfa07 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2717,11 +2717,6 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 	pgprintk("%s: spte %llx write_fault %d gfn %llx\n", __func__,
 		 *sptep, write_fault, gfn);
 
-	if (unlikely(is_noslot_pfn(pfn))) {
-		mark_mmio_spte(vcpu, sptep, gfn, pte_access);
-		return RET_PF_EMULATE;
-	}
-
 	if (is_shadow_present_pte(*sptep)) {
 		/*
 		 * If we overwrite a PTE page pointer with a 2MB PMD, unlink
@@ -2743,6 +2738,14 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
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


