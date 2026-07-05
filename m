Return-Path: <stable+bounces-271994-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NLO9JvG8SWpF6gAAu9opvQ
	(envelope-from <stable+bounces-271994-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 04:09:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D66708CC4
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 04:09:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=w8QYyz2G;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271994-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-271994-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9EC8D300998E
	for <lists+stable@lfdr.de>; Sun,  5 Jul 2026 02:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7F6245019;
	Sun,  5 Jul 2026 02:09:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ECA33EC;
	Sun,  5 Jul 2026 02:09:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783217388; cv=none; b=KyWsmd37kKZsV59md1VRzI/VI28a7W3GUlzJ1xNgVOMzBWnardouPrF0K2qqOelIF5xxXo5kvAxluPW6KFOxM5Mcp71DNr+vy8taqRUXUmBHml4Bsx6Go+jYts00Fc8EyuCD4m3uCa8ivLizeJjlJsOQDdclMig3wVF6mNukpEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783217388; c=relaxed/simple;
	bh=+/Lqf+ZJ1qW2UK8whU8NOqI5qJwSvaVBBJi000cusPQ=;
	h=Date:To:From:Subject:Message-Id; b=lzPcWZeCFmqfTz5h4t3ifr9WU9zcmmbbST8aahDscVOwcaaHLvI1frPVWwvyrJk9PcJxxacTYu40S8wb1foPuIMSGHQBLyiBZOQb3iUpc11YaH/qjyRY0lobIMXQW/dX3E4SXGNYs6a0nZCMpm+3uzYMugaa5U0VUmQZQ4vXC90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=w8QYyz2G; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA751F000E9;
	Sun,  5 Jul 2026 02:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783217387;
	bh=Ej69p+5G438yY/D6Cf3vGWBeZNjFw8yZGGYysrgn4W4=;
	h=Date:To:From:Subject;
	b=w8QYyz2G17i/UIc2+tdWTLb6dE4W5yxtCT/zOuvBW0P3LD8DD7tVfs331DMLTwgTt
	 rViICisPeMmdP6M7a0wC+sDGOZA+NOZlBkrYEbt7pmYceR3Vw2gxt+4pUNCqypz+89
	 JAlG9yK5BQDvhq2VHL313xOn9vwhvGqx4b/Id9z0=
Date: Sat, 04 Jul 2026 19:09:46 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,ptikhomirov@virtuozzo.com,catalin.marinas@arm.com,leitao@debian.org,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-kmemleak-fix-checksum-computation-for-per-cpu-objects.patch added to mm-hotfixes-unstable branch
Message-Id: <20260705020947.3AA751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271994-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:stable@vger.kernel.org,m:ptikhomirov@virtuozzo.com,m:catalin.marinas@arm.com,m:leitao@debian.org,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,smtp.kernel.org:mid,linux-foundation.org:from_mime,linux-foundation.org:email,linux-foundation.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28D66708CC4


The patch titled
     Subject: mm/kmemleak: fix checksum computation for per-cpu objects
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-kmemleak-fix-checksum-computation-for-per-cpu-objects.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-kmemleak-fix-checksum-computation-for-per-cpu-objects.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via various
branches at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there most days

------------------------------------------------------
From: Breno Leitao <leitao@debian.org>
Subject: mm/kmemleak: fix checksum computation for per-cpu objects
Date: Fri, 03 Jul 2026 09:17:24 -0700

The per-cpu object checksum folds each CPU's CRC together with XOR and
seeds every CRC with 0.  Both choices make update_checksum() miss content
changes:

  - XOR is self-cancelling, so equal contents on two CPUs cancel out and
    simultaneous identical changes leave the checksum unchanged.
  - crc32(0, ...) over all-zero content is 0, so a freshly allocated,
    zeroed per-cpu area checksums to 0, matching the initial value, and
    the object is never seen to change.

See discussions at [0].

When update_checksum() wrongly reports an actively modified object as
unchanged, kmemleak stops greying it for an extra scan and can report a
live per-cpu object as a leak.

Fold the per-cpu CRC as a single rolling checksum across all CPUs and
initialise the object checksum to ~0 so the first computed value always
registers as a change, even for content that hashes to 0. 
reset_checksum() is seeded the same way.

Link: https://lore.kernel.org/all/akfYImSNDh3OjIfR@gmail.com [0]
Link: https://lore.kernel.org/20260703-kmemleak_checksum-v1-1-5e0ab7d6966f@debian.org
Fixes: 6c99d4eb7c5e ("kmemleak: enable tracking for percpu pointers")
Signed-off-by: Breno Leitao <leitao@debian.org>
Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/kmemleak.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/mm/kmemleak.c~mm-kmemleak-fix-checksum-computation-for-per-cpu-objects
+++ a/mm/kmemleak.c
@@ -687,7 +687,7 @@ static struct kmemleak_object *__alloc_o
 	atomic_set(&object->use_count, 1);
 	object->excess_ref = 0;
 	object->count = 0;			/* white color initially */
-	object->checksum = 0;
+	object->checksum = ~0;
 	object->del_state = 0;
 
 	/* task information */
@@ -981,7 +981,7 @@ static void reset_checksum(unsigned long
 	}
 
 	raw_spin_lock_irqsave(&object->lock, flags);
-	object->checksum = 0;
+	object->checksum = ~0;
 	raw_spin_unlock_irqrestore(&object->lock, flags);
 	put_object(object);
 }
@@ -1410,7 +1410,8 @@ static bool update_checksum(struct kmeml
 		for_each_possible_cpu(cpu) {
 			void *ptr = per_cpu_ptr((void __percpu *)object->pointer, cpu);
 
-			object->checksum ^= crc32(0, kasan_reset_tag((void *)ptr), object->size);
+			object->checksum = crc32(object->checksum,
+						 kasan_reset_tag((void *)ptr), object->size);
 		}
 	} else {
 		object->checksum = crc32(0, kasan_reset_tag((void *)object->pointer), object->size);
_

Patches currently in -mm which might be from leitao@debian.org are

mm-kmemleak-fix-checksum-computation-for-per-cpu-objects.patch
mm-kmemleak-avoid-soft-lockup-when-scanning-task-stacks.patch
mm-kmemleak-stop-the-task-stack-scan-early-when-interrupted.patch
mm-kmemleak-stop-the-per-cpu-and-struct-page-scans-early-too.patch
mm-memory-failure-drop-dead-error_states-entry-for-reserved-pages.patch
mm-memory-failure-surface-unhandlable-kernel-pages-as-enotrecoverable.patch
mm-memory-failure-report-mf_msg_kernel-for-unrecoverable-kernel-pages.patch
mm-memory-failure-add-panic-option-for-unrecoverable-pages.patch
documentation-document-panic_on_unrecoverable_memory_failure-sysctl.patch
selftests-mm-add-hwpoison-panic-destructive-test.patch
mm-kmemleak-skip-the-remaining-scan-phases-when-interrupted.patch
radix-tree-fix-kmemleak-false-positives-on-tree-head-reassignment.patch


