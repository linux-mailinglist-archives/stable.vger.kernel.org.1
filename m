Return-Path: <stable+bounces-273085-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S7O9D98lUGpjuQIAu9opvQ
	(envelope-from <stable+bounces-273085-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 00:51:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D18D73623E
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 00:51:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b="Jy1Vyza/";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273085-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273085-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EF003048AC2
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 22:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659013AEB2C;
	Thu,  9 Jul 2026 22:50:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C211B7910;
	Thu,  9 Jul 2026 22:50:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637403; cv=none; b=G2Wu9gCCLusF6eDLhFMYtYsshG/ZAouB4dCsljZKCjD+CMkga2Ovd3spqpOndoUQ8wHhqbEdVdubd2FRrpeccCNCsp14tchcZxkEM3SnTfjK8/E+hFWcXConkMW+BpeXIDHVw5nl8DnjORIcFVNaWJ8LyWldf2SqpIzA0gaDWYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637403; c=relaxed/simple;
	bh=MXWl9743OlI0yBH9ENlulcrJG6PbN4JKfnOPBmu/p2E=;
	h=Date:To:From:Subject:Message-Id; b=Xda2FVQROzTzecFm+jL94pVUzW1Or7E9zsnF10AxQ0BBG5Fc1hH+17badhevMIDgv8LEBKN1LRtgfnWR6I+2nQ3z8YBMCM7maxGMAwsY+2qJ4l/gn+gO9zHMTqSR3GDDT9zxpmcpP/M7LddltWPcj1pZdkLSQ9vo50TD47NPBUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Jy1Vyza/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4FA1F000E9;
	Thu,  9 Jul 2026 22:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783637401;
	bh=Fvz8FvpvuI8Mu3TmVeDNkelcEl6ydpYYqwP9EkRIErQ=;
	h=Date:To:From:Subject;
	b=Jy1Vyza/J8y2q57xA27AbsG3/2qz4OF0hBWVmzyO/G7Pfe4BCoSX/Vx9JVKg2+ol5
	 FACN9ZY4woYe2mexQZZZENPGzgsMYyk1XQWCebs6K+ObbLG/KPFC4ABVWgHSCN+Zw5
	 9HCCqoc3bmVUkbaZxhtxcEZMnwm7qMNwGQ+Q5i+4=
Date: Thu, 09 Jul 2026 15:50:01 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,ptikhomirov@virtuozzo.com,catalin.marinas@arm.com,leitao@debian.org,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-kmemleak-fix-checksum-computation-for-per-cpu-objects.patch removed from -mm tree
Message-Id: <20260709225001.BC4FA1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273085-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux-foundation.org:from_mime,linux-foundation.org:email,linux-foundation.org:dkim,arm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D18D73623E


The quilt patch titled
     Subject: mm/kmemleak: fix checksum computation for per-cpu objects
has been removed from the -mm tree.  Its filename was
     mm-kmemleak-fix-checksum-computation-for-per-cpu-objects.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

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


