Return-Path: <stable+bounces-253677-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGK3CBS7D2qCPAYAu9opvQ
	(envelope-from <stable+bounces-253677-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 04:10:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF8E5ADE50
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 04:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64A5B303D33B
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 02:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2154D2DC350;
	Fri, 22 May 2026 02:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="pSSo+9LC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B017F23393F;
	Fri, 22 May 2026 02:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779415625; cv=none; b=Hv8AQNFBLhn8jgtcx61/iYTfMs6A5Fb9RbbL9pkXVAubCgNVg+3zXeQ9OvCDpkdPOYPJkS5fT3O/34ss0k3lKzTM75qg5S66WRmXFZLy6B1TzS+oIITLYxthp9FmggtHZMN94ul8c/wFpDKwwGrbyrHSR3nBJqSENC5lIeRR4HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779415625; c=relaxed/simple;
	bh=tR5J228uT8stCRZYgt0EZw0z7D5p4iJml8gYdS7lkyw=;
	h=Date:To:From:Subject:Message-Id; b=ItCdhYAzonSHolpprizvbBTtoZ7snEu/5IxrBVZloCJj1yqhMm4z00uyitPuHznvIW4/s1QHZSM/lhitw8czEnQMkAHKMA97KYcD6uZD14iuXYcOil5S82gmwPdcfxklFQIaFbF+XzrVJD8LUddzcEvSlHl33MOrIoLhy/YRtf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=pSSo+9LC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5176B1F00A3D;
	Fri, 22 May 2026 02:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779415624;
	bh=3GlUrVpYhAtx2bSFMxzm4STWLSexb2wc2Z9ZrVAj7UA=;
	h=Date:To:From:Subject;
	b=pSSo+9LCWDKucaGypZzS9NopfeR021RL3x123nnB/2V5x1fSmR8w5Dwt5x+GkFpMC
	 Cfu22MEKQP/nesWxp3fvC3a6t71ZLI9Wn5pWgE0eNXK/ngz3sVq/xPYyITTxx9PtTP
	 HZ6GqAAT3phBPT3WiicTeQWZ0WetGg/6aHixKTMI=
Date: Thu, 21 May 2026 19:07:03 -0700
To: mm-commits@vger.kernel.org,ziy@nvidia.com,ying.huang@linux.alibaba.com,stable@vger.kernel.org,rakie.kim@sk.com,matthew.brost@intel.com,joshua.hahnjy@gmail.com,gourry@gourry.net,david@kernel.org,byungchul@sk.com,balbirs@nvidia.com,apopple@nvidia.com,nueralspacetech@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-migrate_device-fix-pgtable-leak-in-migrate_vma_insert_huge_pmd_page.patch removed from -mm tree
Message-Id: <20260522020704.5176B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-253677-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.989];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,alibaba.com:email,sk.com:email,nvidia.com:email]
X-Rspamd-Queue-Id: 7BF8E5ADE50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The quilt patch titled
     Subject: mm/migrate_device: fix pgtable leak in migrate_vma_insert_huge_pmd_page
has been removed from the -mm tree.  Its filename was
     mm-migrate_device-fix-pgtable-leak-in-migrate_vma_insert_huge_pmd_page.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

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
Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Gregory Price <gourry@gourry.net>
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

mm-migrate_device-cleanup-up-pmd-checks-and-warnings.patch


