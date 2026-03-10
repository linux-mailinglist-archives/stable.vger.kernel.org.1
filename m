Return-Path: <stable+bounces-224604-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLtLMh+jsGnQlQIAu9opvQ
	(envelope-from <stable+bounces-224604-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 00:02:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 233202591EC
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 00:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 813C031B07E8
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 23:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FE62DB780;
	Tue, 10 Mar 2026 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SWvz7meS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B21225D1E9;
	Tue, 10 Mar 2026 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773183755; cv=none; b=t3ZTP0njySaS+wze9riKXtgYv6F3Dsn4msf4QYjbQJxHL88hpMljvlUjAXRGcmaQJv7zT+czXyCMiqf69N7uxU9O2n4R5FhJqNvKCyYxWZ/kn5MEmS2my6PakOTobXCN4skLVLID0oXMr2Lhu0kObXlWL06R2xVXkZ1nS5b6tDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773183755; c=relaxed/simple;
	bh=uUZaSTtt0jCTm/6+i25qRZbafPjatcldNS3bS32gNjQ=;
	h=Date:To:From:Subject:Message-Id; b=CxA81ixOh1XJBR+Rju5vRdsEcBh0Ez7ie3dbtQZD2IHQGToXJFBpsw+MnPxucGYknZ9g6opOgMqUVYwHu0HmtD+970WP7hq9jpFTF7L1rUT2k5tM0dWoI1ALyp4sn6ZsM7QvIWeaUOMjl9HcwH5mY8lQEa32HsZaXU9TEnkvmls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SWvz7meS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FC3C19423;
	Tue, 10 Mar 2026 23:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773183755;
	bh=uUZaSTtt0jCTm/6+i25qRZbafPjatcldNS3bS32gNjQ=;
	h=Date:To:From:Subject:From;
	b=SWvz7meSqYCz85uQRR/XQqLpeOxBcqlmOzF7E3qI86dxvJDfPUTinDdeE+5wyfVxi
	 B6l9T2TxUNmrtIC3/bTs67JUz8EIDVFgb5wIrJGbNvMAySiD9FzYSeDY4VDW4FENky
	 2Al3fKWv9zntSM+YflN2O8yVy9/eEJxGEGR+CzRU=
Date: Tue, 10 Mar 2026 16:02:34 -0700
To: mm-commits@vger.kernel.org,ziy@nvidia.com,stable@vger.kernel.org,ljs@kernel.org,lance.yang@linux.dev,gavinguo@igalia.com,david@kernel.org,baolin.wang@linux.alibaba.com,richard.weiyang@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-huge_memory-fix-early-failure-try_to_migrate-when-split-huge-pmd-for-shared-thp.patch removed from -mm tree
Message-Id: <20260310230234.E6FC3C19423@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 233202591EC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224604-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,nvidia.com,kernel.org,linux.dev,igalia.com,linux.alibaba.com,gmail.com,linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,linux-foundation.org:dkim,linux-foundation.org:email,linux.dev:email,igalia.com:email,alibaba.com:email]
X-Rspamd-Action: no action


The quilt patch titled
     Subject: mm/huge_memory: fix early failure try_to_migrate() when split huge pmd for shared THP
has been removed from the -mm tree.  Its filename was
     mm-huge_memory-fix-early-failure-try_to_migrate-when-split-huge-pmd-for-shared-thp.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Wei Yang <richard.weiyang@gmail.com>
Subject: mm/huge_memory: fix early failure try_to_migrate() when split huge pmd for shared THP
Date: Thu, 5 Mar 2026 01:50:06 +0000

Commit 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and
split_huge_pmd_locked()") return false unconditionally after
split_huge_pmd_locked().  This may fail try_to_migrate() early when
TTU_SPLIT_HUGE_PMD is specified.

The reason is the above commit adjusted try_to_migrate_one() to, when a
PMD-mapped THP entry is found, and TTU_SPLIT_HUGE_PMD is specified (for
example, via unmap_folio()), return false unconditionally.  This breaks
the rmap walk and fail try_to_migrate() early, if this PMD-mapped THP is
mapped in multiple processes.

The user sensible impact of this bug could be:

  * On memory pressure, shrink_folio_list() may split partially mapped
    folio with split_folio_to_list(). Then free unmapped pages without IO.
    If failed, it may not be reclaimed.
  * On memory failure, memory_failure() would call try_to_split_thp_page()
    to split folio contains the bad page. If succeed, the PG_has_hwpoisoned
    bit is only set in the after-split folio contains @split_at. By doing
    so, we limit bad memory. If failed to split, the whole folios is not
    usable.

One way to reproduce:

    Create an anonymous THP range and fork 512 children, so we have a
    THP shared mapped in 513 processes. Then trigger folio split with
    /sys/kernel/debug/split_huge_pages debugfs to split the THP folio to
    order 0.

Without the above commit, we can successfully split to order 0.  With the
above commit, the folio is still a large folio.

And currently there are two core users of TTU_SPLIT_HUGE_PMD:

  * try_to_unmap_one()
  * try_to_migrate_one()

try_to_unmap_one() would restart the rmap walk, so only
try_to_migrate_one() is affected.

We can't simply revert commit 60fbb14396d5 ("mm/huge_memory: adjust
try_to_migrate_one() and split_huge_pmd_locked()"), since it removed some
duplicated check covered by page_vma_mapped_walk().

This patch fixes this by restart page_vma_mapped_walk() after
split_huge_pmd_locked().  Since we cannot simply return "true" to fix the
problem, as that would affect another case:

    When invoking folio_try_share_anon_rmap_pmd() from
    split_huge_pmd_locked(), the latter can fail and leave a large folio
    mapped through PTEs, in which case we ought to return true from
    try_to_migrate_one(). This might result in unnecessary walking of the
    rmap but is relatively harmless.

Link: https://lkml.kernel.org/r/20260305015006.27343-1-richard.weiyang@gmail.com
Fixes: 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and split_huge_pmd_locked()")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Tested-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Gavin Guo <gavinguo@igalia.com>
Acked-by: David Hildenbrand (arm) <david@kernel.org>
Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/rmap.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/mm/rmap.c~mm-huge_memory-fix-early-failure-try_to_migrate-when-split-huge-pmd-for-shared-thp
+++ a/mm/rmap.c
@@ -2450,11 +2450,17 @@ static bool try_to_migrate_one(struct fo
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
_

Patches currently in -mm which might be from richard.weiyang@gmail.com are



