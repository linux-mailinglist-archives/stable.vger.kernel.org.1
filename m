Return-Path: <stable+bounces-271527-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7Gb4ENSnRmpsbAsAu9opvQ
	(envelope-from <stable+bounces-271527-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 20:03:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 430876FBCF5
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 20:02:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=rEgeUE4n;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271527-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-271527-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B560D3481471
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 17:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC583093DD;
	Thu,  2 Jul 2026 17:02:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213481FA859;
	Thu,  2 Jul 2026 17:02:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011776; cv=none; b=Bs+YbZ9ye1Uci/ugGD5qPZzBTkb3Xb3MGvOuq8oKfeNTrJrMdnFDAO8JPtazfNQ5LRDGBUoSyS83mw+KZIJ20TfG5Ij0HyBnBoFlv5MUJAQJweSW7RPlSRusSo6WvG4H1n5X+tdWBWOVIYt8fa2AA2F41hbL0Eu6QnDmE28GJQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011776; c=relaxed/simple;
	bh=6uVIWO55axgjFN4Xl+Zx2yRUjigWigUEIklyRwkaV10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IO6jFAkt13SlcMGoKuIEK5UrDTV4U8v0NBxeilTzO30NtTfJ93BTxYLxAUzLrvLSB6CUTxCp7BWVxOD79XChi2ykrLe5aFzm5mLhoE6D7TPhfHy09wPjnArEBcnZogY7eR1Ln2egvupr5xlsDPG51JLZV8497wMTXU+aZkIgs/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rEgeUE4n; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869AF1F000E9;
	Thu,  2 Jul 2026 17:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011775;
	bh=RoZHchTpKJPKtblYPBHSILuiZrUCb1XiOw2Vquavne4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rEgeUE4nc+fxvy3bB1bIyzV5BLZ3rJH+qOE78CHB3KHIETwF1gyb0QF7qAQbjqgE+
	 b1fppbcmlPmsoFULOlzdB6xyRrUDtm7SbbZobelW/fa2j0j9MqUTtnt+8DGUm+Rr1P
	 Ra/Cw+fUWGqwTsK9mRU9C4PH4LfxMnHhfCutkXtE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 7.1 094/120] KVM: x86: hyper-v: Bound the bank index when querying sparse banks
Date: Thu,  2 Jul 2026 18:21:30 +0200
Message-ID: <20260702155114.904169681@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.964534952@linuxfoundation.org>
References: <20260702155112.964534952@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-271527-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:imv4bel@gmail.com,m:vkuznets@redhat.com,m:seanjc@google.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,redhat.com,google.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 430876FBCF5

7.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hyunwoo Kim <imv4bel@gmail.com>

commit 4721f8160f17554b003e8928bb61e6c9b2fe92a3 upstream.

When checking if a VP ID is included in a sparse bank set, explicitly check
that the ID can actually be contained in a sparse bank (the TLFS allows for
a maximum of 64 banks of 64 vCPUs each).  When handling a paravirtual TLB
flush for L2, the VP ID is copied verbatim from the enlightened VMCS,
without any bounds check, i.e. isn't guaranteed to be under the limit of
4096.

Failure to check the bounds of the VP ID leads to an out-of-bounds read
when testing the sparse bank, and super strictly speaking could lead to KVM
performing an unnecessary TLB flush for an L2 vCPU.

  ==================================================================
  BUG: KASAN: use-after-free in hv_is_vp_in_sparse_set+0x85/0x100 [kvm]
  Read of size 8 at addr ffff88811ba5f598 by task hyperv_evmcs/2802

  CPU: 12 UID: 1000 PID: 2802 Comm: hyperv_evmcs Not tainted 7.1.0-rc2 #7 PREEMPT
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  Call Trace:
   <TASK>
   dump_stack_lvl+0x51/0x60
   print_report+0xcb/0x5d0
   kasan_report+0xb4/0xe0
   kasan_check_range+0x35/0x1b0
   hv_is_vp_in_sparse_set+0x85/0x100 [kvm]
   kvm_hv_flush_tlb+0xe9e/0x16c0 [kvm]
   kvm_hv_hypercall+0xe6b/0x1e60 [kvm]
   vmx_handle_exit+0x485/0x1b60 [kvm_intel]
   kvm_arch_vcpu_ioctl_run+0x22e3/0x5070 [kvm]
   kvm_vcpu_ioctl+0x5d0/0x10c0 [kvm]
   __x64_sys_ioctl+0x129/0x1a0
   do_syscall_64+0xb9/0xcf0
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
  RIP: 0033:0x7f0e62d1a9bf
   </TASK>

  The buggy address belongs to the physical page:
  page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffffffffffffffff pfn:0x11ba5f
  flags: 0x4000000000000000(zone=1)
  raw: 4000000000000000 0000000000000000 00000000ffffffff 0000000000000000
  raw: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000000
  page dumped because: kasan: bad access detected

  Memory state around the buggy address:
   ffff88811ba5f480: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
   ffff88811ba5f500: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  >ffff88811ba5f580: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                              ^
   ffff88811ba5f600: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
   ffff88811ba5f680: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ==================================================================
  Disabling lock debugging due to kernel taint

Opportunistically add a compile time assertion to ensure the maximum number
of sparse banks exactly matches the number of possible bits in the passed
in mask.

Cc: stable@vger.kernel.org
Fixes: c58a318f6090 ("KVM: x86: hyper-v: L2 TLB flush")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://patch.msgid.link/aiQyZIJtO-2Aj_xN@v4bel
[sean: add KASAN splat, drop comment, add assert, massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/hyperv.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1839,6 +1839,11 @@ static bool hv_is_vp_in_sparse_set(u32 v
 	int valid_bit_nr = vp_id / HV_VCPUS_PER_SPARSE_BANK;
 	unsigned long sbank;
 
+	BUILD_BUG_ON(BITS_PER_TYPE(valid_bank_mask) != HV_MAX_SPARSE_VCPU_BANKS);
+
+	if (valid_bit_nr >= HV_MAX_SPARSE_VCPU_BANKS)
+		return false;
+
 	if (!test_bit(valid_bit_nr, (unsigned long *)&valid_bank_mask))
 		return false;
 



