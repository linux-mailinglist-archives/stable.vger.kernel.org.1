Return-Path: <stable+bounces-230740-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNL8AFAjx2lATgUAu9opvQ
	(envelope-from <stable+bounces-230740-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 01:39:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D4634CBE7
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 01:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA1693052708
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 00:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331DB1E2606;
	Sat, 28 Mar 2026 00:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Jd2rqgkG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5949443;
	Sat, 28 Mar 2026 00:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774658352; cv=none; b=uvWjJwYsf7r40GsYjkW51mYnE6+LySwPv3dCOj3gyJWv8y5T82agCfnDajO5kUXk9b1tnU6DI0XLjlC8btR1trG9gzhi5fDBYKK0DfrVGu1/DVsXUM+7esB5AgWY8eDyytMojsx1exOaxQ5TAKF5jp2IRWcn/ORmJy+cgG/iKKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774658352; c=relaxed/simple;
	bh=IKg1epWzI8nxEolEELCAkUnG2vAB235sGGgcKlYixqg=;
	h=Date:To:From:Subject:Message-Id; b=NSQgakjI7jQgeuWZ3iPBJxt/Xx69ffNwgSHRRFB6iWfiME71vy/IbZ/Ih9sg722jmsdWBL+D6h+UuTnZ7/jDghrq3bQ23ZqP1rWZu/fgBT4LxX5oLq/Xf186lLGL+0sMe35gCCINIuzy1nBrhKlE4WELTJHrl2HYontm1sW8AuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Jd2rqgkG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D84BC19423;
	Sat, 28 Mar 2026 00:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774658351;
	bh=IKg1epWzI8nxEolEELCAkUnG2vAB235sGGgcKlYixqg=;
	h=Date:To:From:Subject:From;
	b=Jd2rqgkGwKYJu5sqmhGcJWZ6g53kPxLBPLM4IXr6LE6R9Ja5A6optNszMqPKDoQc8
	 1VtKg23zVbRXYA2dvKqyJ5sTsE2ZXZTp7hjq61kzEmfXXj52pfZit3aYkSBDVMwl9S
	 pPPt4XhYcBodYgJ+FNoTR/QL3YvM/95KHuoinXUc=
Date: Fri, 27 Mar 2026 17:39:10 -0700
To: mm-commits@vger.kernel.org,xiangzao@linux.alibaba.com,willy@infradead.org,stable@vger.kernel.org,p.raghav@samsung.com,mcgrof@kernel.org,ljs@kernel.org,kas@kernel.org,hare@suse.de,djwong@kernel.org,dhowells@redhat.com,dchinner@redhat.com,david@kernel.org,da.gomez@samsung.com,brauner@kernel.org,baolin.wang@linux.alibaba.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-filemap-fix-nr_pages-calculation-overflow-in-filemap_map_pages.patch removed from -mm tree
Message-Id: <20260328003911.5D84BC19423@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230740-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[17];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,infradead.org:email]
X-Rspamd-Queue-Id: 59D4634CBE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The quilt patch titled
     Subject: mm: filemap: fix nr_pages calculation overflow in filemap_map_pages()
has been removed from the -mm tree.  Its filename was
     mm-filemap-fix-nr_pages-calculation-overflow-in-filemap_map_pages.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: mm: filemap: fix nr_pages calculation overflow in filemap_map_pages()
Date: Tue, 17 Mar 2026 17:29:55 +0800

On arm64 server, we found folio that get from migration entry isn't locked
in softleaf_to_folio().  This issue triggers when mTHP splitting and
zap_nonpresent_ptes() races, and the root cause is lack of memory barrier
in softleaf_to_folio().  The race is as follows:

	CPU0                                             CPU1

deferred_split_scan()                              zap_nonpresent_ptes()
  lock folio
  split_folio()
    unmap_folio()
      change ptes to migration entries
    __split_folio_to_order()                         softleaf_to_folio()
      set flags(including PG_locked) for tail pages    folio = pfn_folio(softleaf_to_pfn(entry))
      smp_wmb()                                        VM_WARN_ON_ONCE(!folio_test_locked(folio))
      prep_compound_page() for tail pages

In __split_folio_to_order(), smp_wmb() guarantees page flags of tail pages
are visible before the tail page becomes non-compound.  smp_wmb() should
be paired with smp_rmb() in softleaf_to_folio(), which is missed.  As a
result, if zap_nonpresent_ptes() accesses migration entry that stores tail
pfn, softleaf_to_folio() may see the updated compound_head of tail page
before page->flags.

To fix it, add missing smp_rmb() if the softleaf entry is migration entry
in softleaf_to_folio() and softleaf_to_page().

Link: https://lkml.kernel.org/r/1cf1ac59018fc647a87b0dad605d4056a71c14e4.1773739704.git.baolin.wang@linux.alibaba.com
Fixes: 743a2753a02e ("filemap: cap PTE range to be created to allowed zero fill in folio_map_range()")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reported-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
Tested-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Daniel Gomez <da.gomez@samsung.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Cc: Luis Chamberalin <mcgrof@kernel.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Pankaj Raghav <p.raghav@samsung.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/filemap.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/mm/filemap.c~mm-filemap-fix-nr_pages-calculation-overflow-in-filemap_map_pages
+++ a/mm/filemap.c
@@ -3883,14 +3883,19 @@ vm_fault_t filemap_map_pages(struct vm_f
 	unsigned int nr_pages = 0, folio_type;
 	unsigned short mmap_miss = 0, mmap_miss_saved;
 
+	/*
+	 * Recalculate end_pgoff based on file_end before calling
+	 * next_uptodate_folio() to avoid races with concurrent
+	 * truncation.
+	 */
+	file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
+	end_pgoff = min(end_pgoff, file_end);
+
 	rcu_read_lock();
 	folio = next_uptodate_folio(&xas, mapping, end_pgoff);
 	if (!folio)
 		goto out;
 
-	file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
-	end_pgoff = min(end_pgoff, file_end);
-
 	/*
 	 * Do not allow to map with PMD across i_size to preserve
 	 * SIGBUS semantics.
_

Patches currently in -mm which might be from baolin.wang@linux.alibaba.com are

mm-use-inline-helper-functions-instead-of-ugly-macros.patch
mm-rename-ptep-pmdp_clear_young_notify-to-ptep-pmdp_test_and_clear_young_notify.patch
mm-rmap-add-a-zone_device-folio-warning-in-folio_referenced.patch
mm-add-a-batched-helper-to-clear-the-young-flag-for-large-folios.patch
mm-support-batched-checking-of-the-young-flag-for-mglru.patch
arm64-mm-implement-the-architecture-specific-test_and_clear_young_ptes.patch
mm-change-to-return-bool-for-ptep_test_and_clear_young.patch
mm-change-to-return-bool-for-ptep_clear_flush_young-clear_flush_young_ptes.patch
mm-change-to-return-bool-for-pmdp_test_and_clear_young.patch
mm-change-to-return-bool-for-pmdp_clear_flush_young.patch
mm-change-to-return-bool-for-pudp_test_and_clear_young.patch
mm-change-to-return-bool-for-the-mmu-notifiers-young-flag-check.patch
mm-vmscan-fix-dirty-folios-throttling-on-cgroup-v1-for-mglru.patch


