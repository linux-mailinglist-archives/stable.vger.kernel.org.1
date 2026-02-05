Return-Path: <stable+bounces-214383-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JuCGQ0PhGnixgMAu9opvQ
	(envelope-from <stable+bounces-214383-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 04:31:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0190EE483
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 04:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0A0A30143E4
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 03:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49996288B1;
	Thu,  5 Feb 2026 03:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCtdEY00"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94C11E487
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 03:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770262280; cv=none; b=uZ8QdoQzijGEiqDeAWYnGtMa1Z94icZ3y8pPFbHEdD1uzLIjTDSzj+UZvp8Nu5hsqDnh1ow4kbR/3nZQpKjJfYQqHtVF5XY38MA7jUY5M6vsibpN//iZOgQeI0flRYOwIQ5qmjKPhkkm2f178Wcm6XKverPcXipcXqAajS3jRg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770262280; c=relaxed/simple;
	bh=lbzXO5z8Loc3zd4/BCmUZ3IWZues+qEuQJsuXBZHM8U=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Tknzep1zD8Vf+h2O39BH7LEr207QDumGO74c4QZ/S2ETt/cDHgy9xGTZZcK8Vvx35U8DHic2KOam4TO83bH4fvgX9k/mDZ5F2E9LXsG7aqWC3tW7dHdeEMyMCXo2pEOkq8xMs/sfexAb0lnlW5MYpFJZdSDiK27qv9OEo3LIyJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCtdEY00; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-658ad86082dso797726a12.0
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 19:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770262278; x=1770867078; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaaXsJL5AGetw98gAbGYxxD6vHawDzL3XjdFErrz8Eo=;
        b=VCtdEY00ndxBBH/mLl2Mda/gjnLpsoojibgdbNCCZXdpEq1CMp/ymdApilK6PKsDlf
         bWDTn+mmkOUtEux+I6Ky1IjLbRnUO4xzoer/tkjntPKBs62rcitjX+vJomVAL77LZXbi
         svdmDoKFDNWd0yFlVmh58eIoJDSA9IQ3NzRJuEQnUNozmSDEwbdYy3ad5DPrS5sdKmgl
         eyVovLxrD3UOdo0EJ6rUb4D3W2Z3cKZXn7wuamWUB8fNus0jI3IOcAhuQBi5A6xNgnRN
         mHsDYKq2d3oY0CoiMVQoGeE3b8weHhlvYEjwWHaSmdvm5Y4AA5XtmhZHa27USTDYP3xF
         tl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770262278; x=1770867078;
        h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vaaXsJL5AGetw98gAbGYxxD6vHawDzL3XjdFErrz8Eo=;
        b=Hl8nBx8WB7PcBpgjO6sSGKpJXaL269OevJvLS8ysANsKAKSZhdUItBGrVFIvobH6RD
         HxacIEp9pcYB4Badl0A5PQuLWcVlXe6jhR+AhWCgpRw4ExyVV7fdH1dv0fmq679zDQkC
         7PErfMrMSq38ZFAoNJsSRZMXFD9LaHIstSq88G2eDVK/ZobGG8GjjR0u8qGVtqh8Gbqm
         lKYC5D4U9TVZ0P53GNPnmDaRl8uJzAxg+/qTXKA1ngAU5Qrp+LXltry6cBvMNwwf2uAJ
         i6HR8Fjj8c9H3rWpChnga3U2j5QgNk0xGZz1wW7wzeMSKv7qF9hkkkt5y29BgcWZb9D0
         oiAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd+FhWSPR7vT6Ch8L8CAoS7uFA9I62L6WQ57sdA54A5ARpSddBxG5v6c/yZ9WQTNdNL+FWQV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRbSlivZVKx9xlJQoJ2gaRw61+WvNN8j7+eIJU49FkzrqG4K7t
	5foExJz2HnLXKOipmWHyzF0WcP/ouahM31/IUgLBGPZrvpD5Js7spsmz
X-Gm-Gg: AZuq6aJc5+WwZl31iIIqEJF95fSqpSKKGNujN1NOURK1w08ZNIgklZvcsCjdRG6UQ1p
	SnqGmNXZ5YNOxPPPdEEVuHExw05bTHer7PAzEGHif3ZMrW5H6f3sAwC9ngtI90KzjSBQMXx0BTv
	Rjv0rSrey0BmKOMgiaq8cj9QR30092xol1Pl3UMqNJq/eyrhyu04NVAhkRS1iXpGbZONvjPKsno
	0a456uF1xLYfAzjI3EqZ46znsDwFBDSWe3GlvvmQtqqj3E/h8nGb0r5bJ5gU9FQuP82bownkCMu
	ptsLLWwTmc4sQfa0Sz8I8vAl+UKKCG0LttwDKHItI7mOk582gqfDSa0BZw6FKbcW1rHObAJorcb
	GVgjOcdH/8srJ92uOQvtmrUDOrXxcDetFyzoGeDVoqVdkAAPEI6RnmlhnJmXapAwAX/rFTxEAal
	2BpbkUcuMRhA==
X-Received: by 2002:a17:907:72c7:b0:b88:5385:59d7 with SMTP id a640c23a62f3a-b8e9f04c9c1mr375893466b.4.1770262277573;
        Wed, 04 Feb 2026 19:31:17 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8ea00455adsm186412066b.60.2026.02.04.19.31.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Feb 2026 19:31:16 -0800 (PST)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	riel@surriel.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	harry.yoo@oracle.com,
	jannh@google.com,
	gavinguo@igalia.com,
	baolin.wang@linux.alibaba.com,
	ziy@nvidia.com
Cc: linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	Lance Yang <lance.yang@linux.dev>,
	stable@vger.kernel.org
Subject: [Patch v3] mm/huge_memory: fix early failure try_to_migrate() when split huge pmd for shared thp
Date: Thu,  5 Feb 2026 03:31:13 +0000
Message-Id: <20260205033113.30724-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-214383-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,gmail.com,linux.dev,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,nvidia.com:email,linux.dev:email,igalia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0190EE483
X-Rspamd-Action: no action

Commit 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and
split_huge_pmd_locked()") return false unconditionally after
split_huge_pmd_locked() which may fail early during try_to_migrate() for
shared thp. This will lead to unexpected folio split failure.

One way to reproduce:

    Create an anonymous thp range and fork 512 children, so we have a
    thp shared mapped in 513 processes. Then trigger folio split with
    /sys/kernel/debug/split_huge_pages debugfs to split the thp folio to
    order 0.

Without the above commit, we can successfully split to order 0.
With the above commit, the folio is still a large folio.

The reason is the above commit return false after split pmd
unconditionally in the first process and break try_to_migrate().

On memory pressure or failure, we would try to reclaim unused memory or
limit bad memory after folio split. If failed to split it, we will leave
some more memory unusable than expected.

The tricky thing in above reproduce method is current debugfs interface
leverage function split_huge_pages_pid(), which will iterate the whole
pmd range and do folio split on each base page address. This means it
will try 512 times, and each time split one pmd from pmd mapped to pte
mapped thp. If there are less than 512 shared mapped process,
the folio is still split successfully at last. But in real world, we
usually try it for once.

This patch fixes this by restart page_vma_mapped_walk() after
split_huge_pmd_locked(). We cannot simply return "true" to fix the
problem, as that would affect another case:
split_huge_pmd_locked()->folio_try_share_anon_rmap_pmd() can failed and
leave the folio mapped through PTEs; we would return "true" from
try_to_migrate_one() in that case as well. While that is mostly
harmless, we could end up walking the rmap, wasting some cycles.

Fixes: 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and split_huge_pmd_locked()")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Tested-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Gavin Guo <gavinguo@igalia.com>
Acked-by: David Hildenbrand (arm) <david@kernel.org>
Cc: Gavin Guo <gavinguo@igalia.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: <stable@vger.kernel.org>

---
v3:
  * gather RB
  * adjust the commit log and comment per David
  * add userspace-visible runtime effect in change log
v2:
  * restart page_vma_mapped_walk() after split_huge_pmd_locked()
---
 mm/rmap.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 618df3385c8b..1041a64b8e6b 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2446,11 +2446,17 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			__maybe_unused pmd_t pmdval;
 
 			if (flags & TTU_SPLIT_HUGE_PMD) {
+				/*
+				 * split_huge_pmd_locked() might leave the
+				 * folio mapped through PTEs. Retry the walk
+				 * so we can detect this scenario and properly
+				 * abort the walk.
+				 */
 				split_huge_pmd_locked(vma, pvmw.address,
 						      pvmw.pmd, true);
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+				flags &= ~TTU_SPLIT_HUGE_PMD;
+				page_vma_mapped_walk_restart(&pvmw);
+				continue;
 			}
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 			pmdval = pmdp_get(pvmw.pmd);
-- 
2.34.1


