Return-Path: <stable+bounces-242423-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AG5qDkag9GnhCwIAu9opvQ
	(envelope-from <stable+bounces-242423-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 14:44:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3074AC795
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 14:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90D9E3024152
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 12:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B863A543B;
	Fri,  1 May 2026 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JXYUR0ch"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9FC3A4F5C;
	Fri,  1 May 2026 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777639461; cv=none; b=grDhZqkl5DFuz5Z2d7YYvSqK6uzF5yB74dq9GJwOd80QRalKYyMwkZnMxTEBePEOyl0awqEJ77YILdm9fP8Q3CmZ8V4SOlHEoahzmQSfJ5gQPYWXyKQU/8J7OU+YN8vdCHVUBF8pB7PR8kfUeICK1V/An2vDrcAeAcd1FToyFT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777639461; c=relaxed/simple;
	bh=Co7AAEOHhntQaF9+Fh5IMH/5LNJU0qJVIyfZxwmuJ74=;
	h=Date:To:From:Subject:Message-Id; b=Boqr7YRBUWBTC3oPLH2w4ZTG6DoxUKxGOba/gHu8DhQo0XGVChcLyyJb7VWRClV9VgmlR5iC5Hu4Xn6hUa4JvJVw5HpQT3nEMroiL01Pq6SzptqT0xdSyN+1eQKh9OSlIqlWuPhk/FZcgGT5+Sy4paOdJe+uWc9Jr1O7+gw+808=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JXYUR0ch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC15BC2BCB7;
	Fri,  1 May 2026 12:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777639460;
	bh=Co7AAEOHhntQaF9+Fh5IMH/5LNJU0qJVIyfZxwmuJ74=;
	h=Date:To:From:Subject:From;
	b=JXYUR0chbl9QfoGs+oFlKKN86v9mNgRz4I6Zy7QCcQZlPLnx5xbxVOD+aMpZ6vDK3
	 /MwfjaZe3EBVny6FD2TmtWDmk+ue+nPjy0Gas7XRHjGaDoDhJd/QwsqWrphISiHBfE
	 VpE9cVY6Na6lVc6sAMT+C6UdoFMOlIjFTj6m2nPE=
Date: Fri, 01 May 2026 05:44:20 -0700
To: mm-commits@vger.kernel.org,ziy@nvidia.com,ying.huang@linux.alibaba.com,stable@vger.kernel.org,rakie.kim@sk.com,matthew.brost@intel.com,joshua.hahnjy@gmail.com,gourry@gourry.net,david@kernel.org,byungchul@sk.com,balbirs@nvidia.com,apopple@nvidia.com,nueralspacetech@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-migrate_device-fix-pgtable-leak-in-migrate_vma_insert_huge_pmd_page.patch added to mm-hotfixes-unstable branch
Message-Id: <20260501124420.BC15BC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 8F3074AC795
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242423-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,nvidia.com,linux.alibaba.com,sk.com,intel.com,gmail.com,gourry.net,kernel.org,linux-foundation.org];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


The patch titled
     Subject: mm/migrate_device: fix pgtable leak in migrate_vma_insert_huge_pmd_page
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-migrate_device-fix-pgtable-leak-in-migrate_vma_insert_huge_pmd_page.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-migrate_device-fix-pgtable-leak-in-migrate_vma_insert_huge_pmd_page.patch

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
From: Sunny Patel <nueralspacetech@gmail.com>
Subject: mm/migrate_device: fix pgtable leak in migrate_vma_insert_huge_pmd_page
Date: Fri, 1 May 2026 17:21:16 +0530

When migrate_vma_insert_huge_pmd_page() jumps to unlock_abort due
to a PMD check failure, the pgtable allocated earlier via
pte_alloc_one() is never freed, causing a memory leak.

Added free_abort label to release the pgtable in error path.

Link: https://lore.kernel.org/20260501115122.23288-1-nueralspacetech@gmail.com
Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
Signed-off-by: Sunny Patel <nueralspacetech@gmail.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/migrate_device.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/mm/migrate_device.c~mm-migrate_device-fix-pgtable-leak-in-migrate_vma_insert_huge_pmd_page
+++ a/mm/migrate_device.c
@@ -840,7 +840,7 @@ static int migrate_vma_insert_huge_pmd_p
 	} else {
 		if (folio_is_zone_device(folio) &&
 		    !folio_is_device_coherent(folio)) {
-			goto abort;
+			goto free_abort;
 		}
 		entry = folio_mk_pmd(folio, vma->vm_page_prot);
 		if (vma->vm_flags & VM_WRITE)
@@ -893,6 +893,8 @@ static int migrate_vma_insert_huge_pmd_p
 
 unlock_abort:
 	spin_unlock(ptl);
+free_abort:
+	pte_free(vma->vm_mm, pgtable);
 abort:
 	for (i = 0; i < HPAGE_PMD_NR; i++)
 		src[i] &= ~MIGRATE_PFN_MIGRATE;
_

Patches currently in -mm which might be from nueralspacetech@gmail.com are

mm-migrate_device-fix-spinlock-leak-in-migrate_vma_insert_huge_pmd_page.patch
mm-migrate_device-fix-pgtable-leak-in-migrate_vma_insert_huge_pmd_page.patch
mm-migrate_device-cleanup-up-pmd-checks-and-warnings.patch


