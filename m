Return-Path: <stable+bounces-211709-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAjRKZIueGl7oQEAu9opvQ
	(envelope-from <stable+bounces-211709-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 04:18:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD36C8F7D3
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 04:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A031305B44D
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 02:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E762D97A4;
	Tue, 27 Jan 2026 02:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="qQfXXkUZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CD017D2;
	Tue, 27 Jan 2026 02:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769482654; cv=none; b=eIIcS4tKtMrcH/780Wj84sZs+0MPOaaNxQ38iNR3LYIOk9/qo67dIJnyDT1XwTcSi42/YE2l6Hcfe+sxwyeNnlPFi9SN0C+XE/Tf6FL+QbYdCdV98dND331mCHO7WgHuJhVdzhPAbdefjBRK5YIvgFHPSEdjHaHfhh/rzbdfTGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769482654; c=relaxed/simple;
	bh=xN8B/HzpPnq1bx6YL/JH5oiDdL/2K4QN7tiPwzCIQyg=;
	h=Date:To:From:Subject:Message-Id; b=inizvZlfNr4CKEnstbkm8aOAVgfMPt8dZ4LGOaMuohQdvkyBAIF0QkJzY5VSvxAnfNMIp+0yvOGmx+SJAPSXC4Y6uN7Y89nnaSr1CJWSvq7IZU02CgNAKPTnoVQ/84nMVtITTdhA/wVoA/hV0efJSIo//9APgv9jBnHvg3y3BZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=qQfXXkUZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F3AC116C6;
	Tue, 27 Jan 2026 02:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769482654;
	bh=xN8B/HzpPnq1bx6YL/JH5oiDdL/2K4QN7tiPwzCIQyg=;
	h=Date:To:From:Subject:From;
	b=qQfXXkUZxg9WSu1mIrK1bJ7OntkTOTY3YOjIxGTEfTCB0QXtieVVv9u9XTiFCYY4S
	 gTnRmdv+aOn8Wet55EtP5Stf2rfulQ+YLBdI7dgvSR1teUCpxVhch81EApXQPCudxB
	 6SYlq8tx25vNlN+o+HTjs/MgsPZVpWlJ7Hk9xGkM=
Date: Mon, 26 Jan 2026 18:57:33 -0800
To: mm-commits@vger.kernel.org,vincenzo.frascino@arm.com,urezki@gmail.com,stable@vger.kernel.org,maze@google.com,maciej.wieczor-retman@intel.com,joonki.min@samsung-slsi.corp-partner.google.com,glider@google.com,dvyukov@google.com,andreyknvl@gmail.com,ryabinin.a.a@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-kasan-fix-kasan-poisoning-in-vrealloc.patch removed from -mm tree
Message-Id: <20260127025734.73F3AC116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.34 / 15.00];
	R_BAD_CTE_7BIT(3.50)[unknown];
	SUSPICIOUS_RECIPS(1.50)[];
	BROKEN_CONTENT_TYPE(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-211709-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,arm.com,gmail.com,google.com,intel.com,samsung-slsi.corp-partner.google.com,linux-foundation.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD36C8F7D3
X-Rspamd-Action: no action


The quilt patch titled
     Subject: mm/kasan: fix KASAN poisoning in vrealloc()
has been removed from the -mm tree.  Its filename was
     mm-kasan-fix-kasan-poisoning-in-vrealloc.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Subject: mm/kasan: fix KASAN poisoning in vrealloc()
Date: Tue, 13 Jan 2026 20:15:15 +0100

A KASAN warning can be triggered when vrealloc() changes the requested
size to a value that is not aligned to KASAN_GRANULE_SIZE.

    ------------[ cut here ]------------
    WARNING: CPU: 2 PID: 1 at mm/kasan/shadow.c:174 kasan_unpoison+0x40/0x48
    ...
    pc : kasan_unpoison+0x40/0x48
    lr : __kasan_unpoison_vmalloc+0x40/0x68
    Call trace:
     kasan_unpoison+0x40/0x48 (P)
     vrealloc_node_align_noprof+0x200/0x320
     bpf_patch_insn_data+0x90/0x2f0
     convert_ctx_accesses+0x8c0/0x1158
     bpf_check+0x1488/0x1900
     bpf_prog_load+0xd20/0x1258
     __sys_bpf+0x96c/0xdf0
     __arm64_sys_bpf+0x50/0xa0
     invoke_syscall+0x90/0x160

Introduce a dedicated kasan_vrealloc() helper that centralizes KASAN
handling for vmalloc reallocations.  The helper accounts for KASAN granule
alignment when growing or shrinking an allocation and ensures that partial
granules are handled correctly.

Use this helper from vrealloc_node_align_noprof() to fix poisoning logic.

[ryabinin.a.a@gmail.com: move kasan_enabled() check, fix build]
  Link: https://lkml.kernel.org/r/20260119144509.32767-1-ryabinin.a.a@gmail.com
Link: https://lkml.kernel.org/r/20260113191516.31015-1-ryabinin.a.a@gmail.com
Fixes: d699440f58ce ("mm: fix vrealloc()'s KASAN poisoning logic")
Signed-off-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Reported-by: Maciej Żenczykowski <maze@google.com>
Reported-by: <joonki.min@samsung-slsi.corp-partner.google.com>
Closes: https://lkml.kernel.org/r/CANP3RGeuRW53vukDy7WDO3FiVgu34-xVJYkfpm08oLO3odYFrA@mail.gmail.com
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Tested-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/kasan.h |   14 ++++++++++++++
 mm/kasan/common.c     |   21 +++++++++++++++++++++
 mm/vmalloc.c          |    7 ++-----
 3 files changed, 37 insertions(+), 5 deletions(-)

--- a/include/linux/kasan.h~mm-kasan-fix-kasan-poisoning-in-vrealloc
+++ a/include/linux/kasan.h
@@ -641,6 +641,17 @@ kasan_unpoison_vmap_areas(struct vm_stru
 		__kasan_unpoison_vmap_areas(vms, nr_vms, flags);
 }
 
+void __kasan_vrealloc(const void *start, unsigned long old_size,
+		unsigned long new_size);
+
+static __always_inline void kasan_vrealloc(const void *start,
+					unsigned long old_size,
+					unsigned long new_size)
+{
+	if (kasan_enabled())
+		__kasan_vrealloc(start, old_size, new_size);
+}
+
 #else /* CONFIG_KASAN_VMALLOC */
 
 static inline void kasan_populate_early_vm_area_shadow(void *start,
@@ -670,6 +681,9 @@ kasan_unpoison_vmap_areas(struct vm_stru
 			  kasan_vmalloc_flags_t flags)
 { }
 
+static inline void kasan_vrealloc(const void *start, unsigned long old_size,
+				unsigned long new_size) { }
+
 #endif /* CONFIG_KASAN_VMALLOC */
 
 #if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
--- a/mm/kasan/common.c~mm-kasan-fix-kasan-poisoning-in-vrealloc
+++ a/mm/kasan/common.c
@@ -606,4 +606,25 @@ void __kasan_unpoison_vmap_areas(struct
 			__kasan_unpoison_vmalloc(addr, size, flags | KASAN_VMALLOC_KEEP_TAG);
 	}
 }
+
+void __kasan_vrealloc(const void *addr, unsigned long old_size,
+		unsigned long new_size)
+{
+	if (new_size < old_size) {
+		kasan_poison_last_granule(addr, new_size);
+
+		new_size = round_up(new_size, KASAN_GRANULE_SIZE);
+		old_size = round_up(old_size, KASAN_GRANULE_SIZE);
+		if (new_size < old_size)
+			__kasan_poison_vmalloc(addr + new_size,
+					old_size - new_size);
+	} else if (new_size > old_size) {
+		old_size = round_down(old_size, KASAN_GRANULE_SIZE);
+		__kasan_unpoison_vmalloc(addr + old_size,
+					new_size - old_size,
+					KASAN_VMALLOC_PROT_NORMAL |
+					KASAN_VMALLOC_VM_ALLOC |
+					KASAN_VMALLOC_KEEP_TAG);
+	}
+}
 #endif
--- a/mm/vmalloc.c~mm-kasan-fix-kasan-poisoning-in-vrealloc
+++ a/mm/vmalloc.c
@@ -4327,7 +4327,7 @@ void *vrealloc_node_align_noprof(const v
 		if (want_init_on_free() || want_init_on_alloc(flags))
 			memset((void *)p + size, 0, old_size - size);
 		vm->requested_size = size;
-		kasan_poison_vmalloc(p + size, old_size - size);
+		kasan_vrealloc(p, old_size, size);
 		return (void *)p;
 	}
 
@@ -4335,16 +4335,13 @@ void *vrealloc_node_align_noprof(const v
 	 * We already have the bytes available in the allocation; use them.
 	 */
 	if (size <= alloced_size) {
-		kasan_unpoison_vmalloc(p + old_size, size - old_size,
-				       KASAN_VMALLOC_PROT_NORMAL |
-				       KASAN_VMALLOC_VM_ALLOC |
-				       KASAN_VMALLOC_KEEP_TAG);
 		/*
 		 * No need to zero memory here, as unused memory will have
 		 * already been zeroed at initial allocation time or during
 		 * realloc shrink time.
 		 */
 		vm->requested_size = size;
+		kasan_vrealloc(p, old_size, size);
 		return (void *)p;
 	}
 
_

Patches currently in -mm which might be from ryabinin.a.a@gmail.com are

mm-kasan-kunit-extend-vmalloc-oob-tests-to-cover-vrealloc.patch
mm-kasan-kunit-extend-vmalloc-oob-tests-to-cover-vrealloc-fix.patch


