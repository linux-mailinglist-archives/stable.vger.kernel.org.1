Return-Path: <stable+bounces-231098-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0F+XFetGymkQ7QUAu9opvQ
	(envelope-from <stable+bounces-231098-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:48:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2A0358821
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63629302D5CB
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4214B3AB29D;
	Mon, 30 Mar 2026 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CL4Pel5t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D883B47CF
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863582; cv=none; b=P/kP1xlforn2t/AQW/9GIwXAu4YNaLMUAUT1gkt/XN9fkdUcKD4UOOxTbuFCxkDiFS1RWTvRKyJVXQTVpluBq0g52OTkVg0HqEkNzipVeK0UaoQxE6X7M60pvQiXoXPrnJgRBc2vAMMjnvDTjkd3E9dhBxgEmOjwjUFNJvcHgUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863582; c=relaxed/simple;
	bh=kniCZzCiFjSh9Zv/542ujbCU0vCRdxl/WQNUrC0xTR4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JPLsX4VyBpJO6gFrKgkuQ2HtqtYIBNvJgfgZOq5peRAUuFqZm+4vA/c6ryYXsLYr4PUt8XQbaX5OZ1PC0V7ZbB1Kq4i36ozxTb+IQY2eeaHuEIRXHRyWEEu1WRmNiTvX4u6fnOZ5xYb95r8OcwabNpbJZ7w+Px2qIebWpQJy2DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CL4Pel5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9384BC4CEF7;
	Mon, 30 Mar 2026 09:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774863582;
	bh=kniCZzCiFjSh9Zv/542ujbCU0vCRdxl/WQNUrC0xTR4=;
	h=Subject:To:Cc:From:Date:From;
	b=CL4Pel5trY13dOYc31xSGEzlFp/o2rGE9mJz9lXQPnRCWsJmbluqBz483A3OC+2gx
	 YWEEdrpUWUAZACc12QFjxPpLkMXgPgFLCJO+HE3Um28yN+QSnQ8aTB3gFvnCRvLp6z
	 ZRshZ3jEa6drNGfW7+nu+m2oTBGKklbszlvrxF2o=
Subject: FAILED: patch "[PATCH] KVM: x86/mmu: Drop/zap existing present SPTE even when" failed to apply to 5.15-stable tree
To: seanjc@google.com,bkov@amazon.com,fgriffo@amazon.co.uk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Mar 2026 11:39:38 +0200
Message-ID: <2026033038-rebate-reclusive-6171@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231098-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amazon.co.uk:email,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Queue-Id: BC2A0358821
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x aad885e774966e97b675dfe928da164214a71605
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033038-rebate-reclusive-6171@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aad885e774966e97b675dfe928da164214a71605 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 5 Mar 2026 17:28:04 -0800
Subject: [PATCH] KVM: x86/mmu: Drop/zap existing present SPTE even when
 creating an MMIO SPTE

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

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b922a8b00057..98406d6aa2d6 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3044,12 +3044,6 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
 	bool prefetch = !fault || fault->prefetch;
 	bool write_fault = fault && fault->write;
 
-	if (unlikely(is_noslot_pfn(pfn))) {
-		vcpu->stat.pf_mmio_spte_created++;
-		mark_mmio_spte(vcpu, sptep, gfn, pte_access);
-		return RET_PF_EMULATE;
-	}
-
 	if (is_shadow_present_pte(*sptep)) {
 		if (prefetch && is_last_spte(*sptep, level) &&
 		    pfn == spte_to_pfn(*sptep))
@@ -3073,6 +3067,14 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
 			was_rmapped = 1;
 	}
 
+	if (unlikely(is_noslot_pfn(pfn))) {
+		vcpu->stat.pf_mmio_spte_created++;
+		mark_mmio_spte(vcpu, sptep, gfn, pte_access);
+		if (flush)
+			kvm_flush_remote_tlbs_gfn(vcpu->kvm, gfn, level);
+		return RET_PF_EMULATE;
+	}
+
 	wrprot = make_spte(vcpu, sp, slot, pte_access, gfn, pfn, *sptep, prefetch,
 			   false, host_writable, &spte);
 


