Return-Path: <stable+bounces-270750-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4vwvCjyVRmp0ZAsAu9opvQ
	(envelope-from <stable+bounces-270750-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:43:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7416FA72A
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:43:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=EV9Gy8bn;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270750-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270750-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7654E31C783B
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795713AA50A;
	Thu,  2 Jul 2026 16:29:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C6E4EA368;
	Thu,  2 Jul 2026 16:29:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009754; cv=none; b=O/GtZILVHtNarEUqjfatY2VISLuWUnwx5R3sMktnHbWpzUWdeTC/sQbAkzdWZHHOr2jbTaNEysbGLTJ7+hzaw/8WrTRzCQ882KpRnzf9XDLrnzZ4HqXkpPsKURcxOvzyVHF95XNcPNUwvgBug5s6mGkZceh/SxOmWcToMSt6Ys0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009754; c=relaxed/simple;
	bh=L0bEpCYpI299zq/HRO6Mf617fuTFZnCYPg281mK3JRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tP463LxfnoolAwpH8bOWBxTHfBmBk++R324+Z/ni0Htyj6nIDznxPQjx60m+r8YosAluhUyGlUwVbpArWsADkoDrBUK7YLo9cQ3PycsmIHofEOdZUVM/rUFrAm1/u1bbbdJyDPOS9qucRMxD5mV/OY1jsthTpZgUJexbQv5EDrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EV9Gy8bn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F00B1F000E9;
	Thu,  2 Jul 2026 16:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783009751;
	bh=HKBEjTCklhoz7fmP2SDadzTYGcBHL+etHANZfEKVSRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EV9Gy8bnoSnH0/S10deozfC3S+tr4U3YciygFzesDPqBxfISrF63cQsMEw4ote1O2
	 lerdn97MmR5A4u0/OeVJsBjaTNWGny1RO5iGgiQe0MPezw67UTzc+JGxzlhA1I2zKt
	 Ukd+J2J3eEV1xn+pRWLiTjRcUWoPgYn181ibInYc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ashutosh Desai <ashutoshdesai993@gmail.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 5.15 73/95] KVM: SVM: Fix page overflow in sev_dbg_crypt() for ENCRYPT path
Date: Thu,  2 Jul 2026 18:20:16 +0200
Message-ID: <20260702155110.749755316@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155109.196223802@linuxfoundation.org>
References: <20260702155109.196223802@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-270750-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:ashutoshdesai993@gmail.com,m:seanjc@google.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,google.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E7416FA72A

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ashutosh Desai <ashutoshdesai993@gmail.com>

commit 78ee2d50185a037b3d2452a97f3dad69c3f7f389 upstream.

In sev_dbg_crypt(), the per-iteration transfer length is bounded by
the source page offset (PAGE_SIZE - s_off) but not by the destination
page offset (PAGE_SIZE - d_off).  When d_off > s_off, the encrypt
path (__sev_dbg_encrypt_user) performs a read-modify-write using a
single-page intermediate buffer (dst_tpage):

  1. __sev_dbg_decrypt() expands the size to round_up(len + (d_off & 15), 16)
     before issuing the PSP command.  If len + (d_off & 15) > PAGE_SIZE,
     the PSP writes beyond the end of the 4096-byte dst_tpage allocation.

  2. The subsequent memcpy()/copy_from_user() into
     page_address(dst_tpage) + (d_off & 15) of 'len' bytes overflows
     by up to 15 bytes under the same condition.

Trigger example: s_off = 0, d_off = 1, debug.len = PAGE_SIZE -
the PSP is instructed to write round_up(4097, 16) = 4112 bytes to
a 4096-byte buffer.

Fix by also bounding len by (PAGE_SIZE - d_off), the same check that
sev_send_update_data() already performs for its single-page guest
region.

 ==================================================================
 BUG: KASAN: slab-use-after-free in sev_dbg_crypt+0x993/0xd10 [kvm_amd]
 Write of size 4095 at addr ff110062293bb009 by task sev_dbg_test/228214

 CPU: 96 UID: 0 PID: 228214 Comm: sev_dbg_test Tainted: G     U  W           7.0.0-smp--5ce9b0c48211-dbg #156 PREEMPTLAZY
 Tainted: [U]=USER, [W]=WARN
 Hardware name: Google Astoria/astoria, BIOS 0.20250817.1-0 08/25/2025
 Call Trace:
  <TASK>
  dump_stack_lvl+0x54/0x70
  print_report+0xbc/0x260
  kasan_report+0xa2/0xd0
  kasan_check_range+0x25f/0x2c0
  __asan_memcpy+0x40/0x70
  sev_dbg_crypt+0x993/0xd10 [kvm_amd]
  sev_mem_enc_ioctl+0x33c/0x450 [kvm_amd]
  kvm_vm_ioctl+0x65d/0x6d0 [kvm]
  __se_sys_ioctl+0xb2/0x100
  do_syscall_64+0xe8/0x870
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
  </TASK>

 The buggy address belongs to the physical page:
 page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x7fe72b6a0 pfn:0x62293bb
 memcg:ff11000112827d82
 flags: 0x1400000000000000(node=1|zone=1)
 raw: 1400000000000000 0000000000000000 dead000000000122 0000000000000000
 raw: 00000007fe72b6a0 0000000000000000 00000001ffffffff ff11000112827d82
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  ff110062293bbf00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ff110062293bbf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 >ff110062293bc000: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                    ^
  ff110062293bc080: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ff110062293bc100: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ==================================================================
 Disabling lock debugging due to kernel taint

Fixes: 24f41fb23a39 ("KVM: SVM: Add support for SEV DEBUG_DECRYPT command")
Fixes: 7d1594f5d94b ("KVM: SVM: Add support for SEV DEBUG_ENCRYPT command")
Cc: stable@vger.kernel.org
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
[sean: add sample KASAN splat, Fixes, and stable@]
Link: https://patch.msgid.link/20260501203537.2120074-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/sev.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -954,6 +954,7 @@ static int sev_dbg_crypt(struct kvm *kvm
 		s_off = vaddr & ~PAGE_MASK;
 		d_off = dst_vaddr & ~PAGE_MASK;
 		len = min_t(size_t, (PAGE_SIZE - s_off), size);
+		len = min_t(size_t, len, PAGE_SIZE - d_off);
 
 		if (dec)
 			ret = __sev_dbg_decrypt_user(kvm,



