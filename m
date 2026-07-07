Return-Path: <stable+bounces-272519-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Rs0NFxmCTWqK1QEAu9opvQ
	(envelope-from <stable+bounces-272519-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 00:47:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB46572044C
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 00:47:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.de header.s=amazoncorp2 header.b=pobzSrEz;
	dmarc=pass (policy=quarantine) header.from=amazon.de;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272519-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-272519-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8BE5301230F
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 22:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A892D7DC4;
	Tue,  7 Jul 2026 22:47:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF62A18E02A
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 22:47:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464468; cv=none; b=bFHHqSGbRwObhnG5MnrMyUx/7e3KPjiA1rbu9GF2i/vXB0KqMokwers7sKVDCjcnquoOiDvYA+D7KcY8XJWcP5ryAXRIXrs8YG02K4NObNDOew9jAyqi6vI3O4bN4j04mkjGPdc6n0wnVmqzTXgEq7dO4YiPQTg8c5FUJuC3H0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464468; c=relaxed/simple;
	bh=LQsh94zadtkC9nyta6P9MbRXPV/XRoqULoa6mZoqOOY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=D6BYmds76bvIeP2RR2IdXoEUdPtpJB5uFDiKMHRRy4ee85oL0pOw1KzBMQylgehliQCARLKHHsuTH98da8fomInEloQx32lsy6DEM/sxrFhELTHpn9ok5ScQmnPmBOhXyyfJeCIOiI5SGFgiCisJQ1Nn/4m+99WYxGADZH/CZGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=pobzSrEz; arc=none smtp.client-ip=52.34.181.151
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1783464467; x=1815000467;
  h=date:from:to:subject:message-id:mime-version;
  bh=64j/uzzdTARlhRXRg7MHJ8c1W8O+7OUGtRHdfl3Te/c=;
  b=pobzSrEzCjCRYPWrfggEqS8iD8kKQT3ew6toq8t9uncRVOPxsv3fuwEU
   8uZYRUegHrLn7eIrp/tdhtXkUBtakbJVLRFEqyA5GW751HhW53g87sAhZ
   m5DUzW+JpF9RzNYPpu2Mq2av242V//ROh99lGy0PUFp6YD/dPQuK9oPAT
   3EAiunUgTP1mwQDLA1Y1xJ9veTB/Duldd2Jtrh+HXv4xs6/MaOU7nZTVa
   KAX957OFfrpt2qGsI2qlfNIs0mh5TPzi0JWaxu4+Zs2U742UZiwz2DZIb
   OZ5GFmq/NmGkNzD6DX7ldvunKS5BSwbwC5DoPH52Ar1ShAYfHSWUgpHdK
   w==;
X-CSE-ConnectionGUID: imLfaWCmRb6Y3PPV5FVMPw==
X-CSE-MsgGUID: 5OCXDmXkQfiNszZy5CcTHg==
X-IronPort-AV: E=Sophos;i="6.25,153,1779148800"; 
   d="scan'208";a="23238721"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 22:47:45 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:29661]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.151:2525] with esmtp (Farcaster)
 id 6839a8a2-7893-4381-906d-5bef720ea8f3; Tue, 7 Jul 2026 22:47:44 +0000 (UTC)
X-Farcaster-Flow-ID: 6839a8a2-7893-4381-906d-5bef720ea8f3
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 7 Jul 2026 22:47:44 +0000
Received: from dev-dsk-darnshah-1a-8576ca1e.eu-west-1.amazon.com (10.1.57.121)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 7 Jul 2026 22:47:43 +0000
Date: Tue, 7 Jul 2026 22:47:42 +0000
From: Darshit Shah <darnshah@amazon.de>
To: <stable@vger.kernel.org>
Subject: [PATCH 5.10.y 5.15.y 6.1.y 6.6.y] KVM: Replace guest-triggerable
 BUG_ON() in ioeventfd datamatch with get_unaligned()
Message-ID: <ak2B3ewAu6g7hShc@dev-dsk-darnshah-1a-8576ca1e.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
X-ClientProxiedBy: EX19D044UWA003.ant.amazon.com (10.13.139.43) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[amazon.de:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amazon.de:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272519-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amazon.de:from_mime,amazon.de:email,amazon.de:dkim,dev-dsk-darnshah-1a-8576ca1e.eu-west-1.amazon.com:mid];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[darnshah@amazon.de,stable@vger.kernel.org];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[amazon.de:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[darnshah@amazon.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB46572044C

commit f1edbed787ba67988ed34e0132ca128b052b6ce8 upstream.

Drop a BUG_ON() that has been reachable since it was first added, way back
in 2009, and instead use get_unaligned() to perform potentially-unaligned
accesses.

For a given store, KVM x86's emulator tracks the entire value in the
destination operand, x86_emulate_ctxt.dst.  If the destination is memory,
and the target splits multiple pages and/or is emulated MMIO, then KVM
handles each fragment independently.  E.g. on a page split starting at page
offset 0xffc, KVM writes 4 bytes to the first page, then the remaining
bytes to the second page, using ctxt->dst as the source for both (with
appropriate offsets).

If the destination splits a page *and* hits emulated MMIO on the second
page, then KVM will complete the write to the first page, then emulate the
MMIO access to the second page.  If there is a datamatch-enabled ioeventfd
at offset 0 of the second page, then KVM will process the remainder of the
store as a potential ioeventfd signal.

Putting it all together, if the guest emits a store that splits a page
starting at page offset N, and the second page has a datamatch-enabled
ioeventfd at offset 0, then KVM will check for datamatch using
&dst.valptr[N] as the source.  Due to dst (and thus dst.valptr) being
32-byte aligned, if N is not aligned to @len, the BUG_ON() fires.

E.g. with a 16-byte store at page offset 0xffc, to an ioeventfd of len 8,
all initial checks in ioeventfd_in_range() will succeed, and the BUG_ON()
fires due to @val being 4-byte aligned, but not 8-byte aligned.

  ------------[ cut here ]------------
  kernel BUG at arch/x86/kvm/../../../virt/kvm/eventfd.c:783!
  Oops: invalid opcode: 0000 [#1] SMP
  CPU: 0 UID: 1000 PID: 615 Comm: repro Not tainted 7.1.0-rc2-ff238429d1ea #365 PREEMPT
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:ioeventfd_write+0x6c/0x70 [kvm]
  Call Trace:
   <TASK>
   __kvm_io_bus_write+0x85/0xb0 [kvm]
   kvm_io_bus_write+0x53/0x80 [kvm]
   vcpu_mmio_write+0x66/0xf0 [kvm]
   emulator_read_write_onepage+0x12a/0x540 [kvm]
   emulator_read_write+0x109/0x2b0 [kvm]
   x86_emulate_insn+0x4f8/0xfb0 [kvm]
   x86_emulate_instruction+0x181/0x790 [kvm]
   kvm_mmu_page_fault+0x313/0x630 [kvm]
   vmx_handle_exit+0x18a/0x590 [kvm_intel]
   kvm_arch_vcpu_ioctl_run+0xc81/0x1c90 [kvm]
   kvm_vcpu_ioctl+0x2d5/0x970 [kvm]
   __x64_sys_ioctl+0x8a/0xd0
   do_syscall_64+0xb7/0x890
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
  RIP: 0033:0x7f19c931a9bf
   </TASK>
  Modules linked in: kvm_intel kvm irqbypass
  ---[ end trace 0000000000000000 ]---

In a perfect world, the fix would be to simply delete the BUG_ON(), as KVM
x86 doesn't perform alignment checks on "normal" memory accesses at CPL0.
Sadly, C99 ruins all the fun; while the x86 architecture plays nice,
dereferencing an unaligned pointer directly is undefined behavior in C,
e.g. triggers splats when running with CONFIG_UBSAN_ALIGNMENT=y.

Fixes: d34e6b175e61 ("KVM: add ioeventfd support")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260612225241.678509-1-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[ Use the old <asm/unaligned.h> header instead ]
Signed-off-by: Darshit Shah <darnshah@amazon.de>
---
 virt/kvm/eventfd.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 4702b71aad08..ff0ef5f7246e 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/seqlock.h>
 #include <linux/irqbypass.h>
+#include <asm/unaligned.h>
 #include <trace/events/kvm.h>
 
 #include <kvm/iodev.h>
@@ -695,21 +696,18 @@ ioeventfd_in_range(struct _ioeventfd *p, gpa_t addr, int len, const void *val)
 		return true;
 
 	/* otherwise, we have to actually compare the data */
-
-	BUG_ON(!IS_ALIGNED((unsigned long)val, len));
-
 	switch (len) {
 	case 1:
-		_val = *(u8 *)val;
+		_val = get_unaligned((u8 *)val);
 		break;
 	case 2:
-		_val = *(u16 *)val;
+		_val = get_unaligned((u16 *)val);
 		break;
 	case 4:
-		_val = *(u32 *)val;
+		_val = get_unaligned((u32 *)val);
 		break;
 	case 8:
-		_val = *(u64 *)val;
+		_val = get_unaligned((u64 *)val);
 		break;
 	default:
 		return false;
-- 
2.54.0


