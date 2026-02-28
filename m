Return-Path: <stable+bounces-220765-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBjoNS9Co2li+wQAu9opvQ
	(envelope-from <stable+bounces-220765-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:29:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BF31C70EB
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2CFFB31576C1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA9B406D38;
	Sat, 28 Feb 2026 17:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ms1NaqP2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214DB406D30;
	Sat, 28 Feb 2026 17:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300645; cv=none; b=co7/taRn3BNSQg0Rt6AwxcfGjNls+PW4HSCUhqd03DTkBx9thzzzKcT66rDe6anUKFwhRuJKmP/ZitEYL4DZJUwbjAb4q+m2N0VTyAqmtvSrmRVkudGsuNbXkn8Al+elfWnHA5b7OIeuUBoVfdAoOJNlA7Q8NCyAPGolvai68Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300645; c=relaxed/simple;
	bh=MbuABjn9H9HKfHNv7nGjfbWLKR6u++7irBa3GmCmfZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsTiUXyMHFYcHe9eq9T87Wz1ELELphVW44aq824WPGZ367bnLyANNiRLPAn4dY/H6EpevRbkLRfqXoojSJPU9IL+vjcgVAWfaZaFL8mf1spNTdB58WIp9MeaCV8SXD51uVjIadgltNIcpw9erKdqTOfnznBPpvZXBNLkGQdO43s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ms1NaqP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68911C19424;
	Sat, 28 Feb 2026 17:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300645;
	bh=MbuABjn9H9HKfHNv7nGjfbWLKR6u++7irBa3GmCmfZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ms1NaqP2fhY07hwI5kmwqa7QjCwWC1enFCUDtTv7Q02G3EtBRYYo5LjoxwTRo5kLY
	 Vws8utbGTT0LVQz/8i3r3hLpDHx9AkVcFsN3fXRZ1pyg9jRSQzT5BkzKKqg4VZoBJt
	 gGIuDS661pjgSKZouAbaM+hHGPOa0/8zO1nrKVsqiCWXTyTXvrlvvSRWRAGQaNsEp2
	 r4qXdua1LIW6seWzDiGscSo5fhVk8o9kzRU54bx3KbBQN6+lhq3c/+ayFbV8x3R7FU
	 OTr2uf7Ej9UE2Oo/9q2yR9heMtSUMDoQy9PMn5SynRa6TlfvA8bLG6Q/O0qcgYxa8C
	 Iz6KoY19fBvOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vasiliy Kovalev <kovalev@altlinux.org>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 686/844] KVM: x86: Add SRCU protection for reading PDPTRs in __get_sregs2()
Date: Sat, 28 Feb 2026 12:29:59 -0500
Message-ID: <20260228173244.1509663-687-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-220765-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,altlinux.org:email]
X-Rspamd-Queue-Id: 80BF31C70EB
X-Rspamd-Action: no action

From: Vasiliy Kovalev <kovalev@altlinux.org>

[ Upstream commit 95d848dc7e639988dbb385a8cba9b484607cf98c ]

Add SRCU read-side protection when reading PDPTR registers in
__get_sregs2().

Reading PDPTRs may trigger access to guest memory:
kvm_pdptr_read() -> svm_cache_reg() -> load_pdptrs() ->
kvm_vcpu_read_guest_page() -> kvm_vcpu_gfn_to_memslot()

kvm_vcpu_gfn_to_memslot() dereferences memslots via __kvm_memslots(),
which uses srcu_dereference_check() and requires either kvm->srcu or
kvm->slots_lock to be held. Currently only vcpu->mutex is held,
triggering lockdep warning:

=============================
WARNING: suspicious RCU usage in kvm_vcpu_gfn_to_memslot
6.12.59+ #3 Not tainted

include/linux/kvm_host.h:1062 suspicious rcu_dereference_check() usage!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz.5.1717/15100:
 #0: ff1100002f4b00b0 (&vcpu->mutex){+.+.}-{3:3}, at: kvm_vcpu_ioctl+0x1d5/0x1590

Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xf0/0x120 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x1e3/0x270 kernel/locking/lockdep.c:6824
 __kvm_memslots include/linux/kvm_host.h:1062 [inline]
 __kvm_memslots include/linux/kvm_host.h:1059 [inline]
 kvm_vcpu_memslots include/linux/kvm_host.h:1076 [inline]
 kvm_vcpu_gfn_to_memslot+0x518/0x5e0 virt/kvm/kvm_main.c:2617
 kvm_vcpu_read_guest_page+0x27/0x50 virt/kvm/kvm_main.c:3302
 load_pdptrs+0xff/0x4b0 arch/x86/kvm/x86.c:1065
 svm_cache_reg+0x1c9/0x230 arch/x86/kvm/svm/svm.c:1688
 kvm_pdptr_read arch/x86/kvm/kvm_cache_regs.h:141 [inline]
 __get_sregs2 arch/x86/kvm/x86.c:11784 [inline]
 kvm_arch_vcpu_ioctl+0x3e20/0x4aa0 arch/x86/kvm/x86.c:6279
 kvm_vcpu_ioctl+0x856/0x1590 virt/kvm/kvm_main.c:4663
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18b/0x210 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xbd/0x1d0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Suggested-by: Sean Christopherson <seanjc@google.com>
Cc: stable@vger.kernel.org
Fixes: 6dba94035203 ("KVM: x86: Introduce KVM_GET_SREGS2 / KVM_SET_SREGS2")
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
Link: https://patch.msgid.link/20260123222801.646123-1-kovalev@altlinux.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d65ebaed18986..8b12bf0774c77 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12157,9 +12157,11 @@ static void __get_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2)
 		return;
 
 	if (is_pae_paging(vcpu)) {
+		kvm_vcpu_srcu_read_lock(vcpu);
 		for (i = 0 ; i < 4 ; i++)
 			sregs2->pdptrs[i] = kvm_pdptr_read(vcpu, i);
 		sregs2->flags |= KVM_SREGS2_FLAGS_PDPTRS_VALID;
+		kvm_vcpu_srcu_read_unlock(vcpu);
 	}
 }
 
-- 
2.51.0


