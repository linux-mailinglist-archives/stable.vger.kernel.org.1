Return-Path: <stable+bounces-238768-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHddFWsm5mmgsgEAu9opvQ
	(envelope-from <stable+bounces-238768-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:13:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B5442B52C
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30FCC302359E
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B6A3A0B1F;
	Mon, 20 Apr 2026 13:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z+5Gj1vg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7198339F185
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 13:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690464; cv=none; b=WvOGZsqmH1XKuXX2k3f/Yz7dzzdEptsknxHZ2tDhYfd53DCZfH5KLna33831wv/NC77zEiEIws3ormzRBs4CD4ZO8tckVvf/4bjo57oOCbgbwOy0IE7nbP/29zBms2x9yLxhxhU9uotoWGhWBLR+h3jFsXo2KfDFNEW1D9gCdxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690464; c=relaxed/simple;
	bh=zMovZN4T5fea1JaOyGlFzDM0a7uqbqOo4g1UgSsP1oQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ubF7pARufBezw8SvDgGGOPAiV4Yb5mg7KCYyWaAkQmH9xifxy7cP1Lzt7B8TzU/JIumPwm2SEjUHuHTpVqYf3C8OvYgDbFkb0jJ4wJbn7HkQbgjLttQ/Dt2SlX1T5NhAjUtePxw4JhJp/uMVv+DeqWSgCJUwFB3LzAfa5utvHt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z+5Gj1vg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0F8C19425;
	Mon, 20 Apr 2026 13:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776690464;
	bh=zMovZN4T5fea1JaOyGlFzDM0a7uqbqOo4g1UgSsP1oQ=;
	h=Subject:To:Cc:From:Date:From;
	b=z+5Gj1vg0uQqwoC1xAcVdspTi9O5opd6VYT7itotZGJ0fJ4EAYK9oT+N1WCFxAx6q
	 iDYG8PSa4tzfLTj4jIq32SgPN69N6valzRjEJi3hnQvCAu5sNVzauFXI0v+NkiYsi0
	 N6kfR8Bs+Lymt3169LGn1/gMXxb2pm7u/KADg2Ac=
Subject: FAILED: patch "[PATCH] KVM: SEV: Protect *all* of sev_mem_enc_register_region() with" failed to apply to 6.1-stable tree
To: seanjc@google.com,glider@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Apr 2026 15:07:38 +0200
Message-ID: <2026042038-cable-curly-8e1b@gregkh>
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
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238768-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 67B5442B52C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b6408b6cec5df76a165575777800ef2aba12b109
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042038-cable-curly-8e1b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b6408b6cec5df76a165575777800ef2aba12b109 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 16:48:11 -0700
Subject: [PATCH] KVM: SEV: Protect *all* of sev_mem_enc_register_region() with
 kvm->lock

Take and hold kvm->lock for before checking sev_guest() in
sev_mem_enc_register_region(), as sev_guest() isn't stable unless kvm->lock
is held (or KVM can guarantee KVM_SEV_INIT{2} has completed and can't
rollack state).  If KVM_SEV_INIT{2} fails, KVM can end up trying to add to
a not-yet-initialized sev->regions_list, e.g. triggering a #GP

  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  CPU: 110 UID: 0 PID: 72717 Comm: syz.15.11462 Tainted: G     U  W  O        6.16.0-smp-DEV #1 NONE
  Tainted: [U]=USER, [W]=WARN, [O]=OOT_MODULE
  Hardware name: Google, Inc. Arcadia_IT_80/Arcadia_IT_80, BIOS 12.52.0-0 10/28/2024
  RIP: 0010:sev_mem_enc_register_region+0x3f0/0x4f0 ../include/linux/list.h:83
  Code: <41> 80 3c 04 00 74 08 4c 89 ff e8 f1 c7 a2 00 49 39 ed 0f 84 c6 00
  RSP: 0018:ffff88838647fbb8 EFLAGS: 00010256
  RAX: dffffc0000000000 RBX: 1ffff92015cf1e0b RCX: dffffc0000000000
  RDX: 0000000000000000 RSI: 0000000000001000 RDI: ffff888367870000
  RBP: ffffc900ae78f050 R08: ffffea000d9e0007 R09: 1ffffd4001b3c000
  R10: dffffc0000000000 R11: fffff94001b3c001 R12: 0000000000000000
  R13: ffff8982ab0bde00 R14: ffffc900ae78f058 R15: 0000000000000000
  FS:  00007f34e9dc66c0(0000) GS:ffff89ee64d33000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007fe180adef98 CR3: 000000047210e000 CR4: 0000000000350ef0
  Call Trace:
   <TASK>
   kvm_arch_vm_ioctl+0xa72/0x1240 ../arch/x86/kvm/x86.c:7371
   kvm_vm_ioctl+0x649/0x990 ../virt/kvm/kvm_main.c:5363
   __se_sys_ioctl+0x101/0x170 ../fs/ioctl.c:51
   do_syscall_x64 ../arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0x6f/0x1f0 ../arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7f34e9f7e9a9
  Code: <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
  RSP: 002b:00007f34e9dc6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
  RAX: ffffffffffffffda RBX: 00007f34ea1a6080 RCX: 00007f34e9f7e9a9
  RDX: 0000200000000280 RSI: 000000008010aebb RDI: 0000000000000007
  RBP: 00007f34ea000d69 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
  R13: 0000000000000000 R14: 00007f34ea1a6080 R15: 00007ffce77197a8
   </TASK>

with a syzlang reproducer that looks like:

  syz_kvm_add_vcpu$x86(0x0, &(0x7f0000000040)={0x0, &(0x7f0000000180)=ANY=[], 0x70}) (async)
  syz_kvm_add_vcpu$x86(0x0, &(0x7f0000000080)={0x0, &(0x7f0000000180)=ANY=[@ANYBLOB="..."], 0x4f}) (async)
  r0 = openat$kvm(0xffffffffffffff9c, &(0x7f0000000200), 0x0, 0x0)
  r1 = ioctl$KVM_CREATE_VM(r0, 0xae01, 0x0)
  r2 = openat$kvm(0xffffffffffffff9c, &(0x7f0000000240), 0x0, 0x0)
  r3 = ioctl$KVM_CREATE_VM(r2, 0xae01, 0x0)
  ioctl$KVM_SET_CLOCK(r3, 0xc008aeba, &(0x7f0000000040)={0x1, 0x8, 0x0, 0x5625e9b0}) (async)
  ioctl$KVM_SET_PIT2(r3, 0x8010aebb, &(0x7f0000000280)={[...], 0x5}) (async)
  ioctl$KVM_SET_PIT2(r1, 0x4070aea0, 0x0) (async)
  r4 = ioctl$KVM_CREATE_VM(0xffffffffffffffff, 0xae01, 0x0)
  openat$kvm(0xffffffffffffff9c, 0x0, 0x0, 0x0) (async)
  ioctl$KVM_SET_USER_MEMORY_REGION(r4, 0x4020ae46, &(0x7f0000000400)={0x0, 0x0, 0x0, 0x2000, &(0x7f0000001000/0x2000)=nil}) (async)
  r5 = ioctl$KVM_CREATE_VCPU(r4, 0xae41, 0x2)
  close(r0) (async)
  openat$kvm(0xffffffffffffff9c, &(0x7f0000000000), 0x8000, 0x0) (async)
  ioctl$KVM_SET_GUEST_DEBUG(r5, 0x4048ae9b, &(0x7f0000000300)={0x4376ea830d46549b, 0x0, [0x46, 0x0, 0x0, 0x0, 0x0, 0x1000]}) (async)
  ioctl$KVM_RUN(r5, 0xae80, 0x0)

Opportunistically use guard() to avoid having to define a new error label
and goto usage.

Fixes: 1e80fdc09d12 ("KVM: SVM: Pin guest memory when SEV is active")
Cc: stable@vger.kernel.org
Reported-by: Alexander Potapenko <glider@google.com>
Tested-by: Alexander Potapenko <glider@google.com>
Link: https://patch.msgid.link/20260310234829.2608037-4-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index d29783c3075a..9265ebd9aa18 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2706,6 +2706,8 @@ int sev_mem_enc_register_region(struct kvm *kvm,
 	struct enc_region *region;
 	int ret = 0;
 
+	guard(mutex)(&kvm->lock);
+
 	if (!sev_guest(kvm))
 		return -ENOTTY;
 
@@ -2717,12 +2719,10 @@ int sev_mem_enc_register_region(struct kvm *kvm,
 	if (!region)
 		return -ENOMEM;
 
-	mutex_lock(&kvm->lock);
 	region->pages = sev_pin_memory(kvm, range->addr, range->size, &region->npages,
 				       FOLL_WRITE | FOLL_LONGTERM);
 	if (IS_ERR(region->pages)) {
 		ret = PTR_ERR(region->pages);
-		mutex_unlock(&kvm->lock);
 		goto e_free;
 	}
 
@@ -2740,8 +2740,6 @@ int sev_mem_enc_register_region(struct kvm *kvm,
 	region->size = range->size;
 
 	list_add_tail(&region->list, &sev->regions_list);
-	mutex_unlock(&kvm->lock);
-
 	return ret;
 
 e_free:


