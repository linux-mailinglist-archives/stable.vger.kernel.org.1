Return-Path: <stable+bounces-170024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33333B2A014
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691534E13B9
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 11:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85F130EF81;
	Mon, 18 Aug 2025 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gd0Jt+LN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EE1261B71
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755515262; cv=none; b=Q7FX+cV/byugU71uFHQiRUqnnfsRhtURwrCIQmxDbDvYTQrO311j7TOyyusIhFuRbJWBrvsInzkj5iGALcNo5pay8H4rWXaGBxLFgv0nYum3Mu5lXlAi8AyUz9uGu8Y5tCFrTIw+vqu7UJR7Io6xH8ZU1t+s3Z7cJjKUzB+T6x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755515262; c=relaxed/simple;
	bh=NpIiikvQNYRXa71/PzDQ3miV1XA/bcDPS0RQn3tgwo4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HufxHio/SlHx7wjLvD727/5p91vk9JOIAxDEPeXtIjXHRbVj6fk7bLbCDXTOd7utwX3hZEFIxwnuvH9jU/eZe2THi4nqnlFE/KaebJszjuYuy2s8TsuAUpvHqP8Ju4W88FrOI2w9gNDOX4Zn26HTT+6eYcbDDaqfbotrLj3Y/Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gd0Jt+LN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E7CC4CEEB;
	Mon, 18 Aug 2025 11:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755515261;
	bh=NpIiikvQNYRXa71/PzDQ3miV1XA/bcDPS0RQn3tgwo4=;
	h=Subject:To:Cc:From:Date:From;
	b=gd0Jt+LN9Q0SUXOYtfmyR1rXB6hrubUslRcsIYpk1uEn3dZdWDxDV632yqlkiZ+bp
	 VuyfEcv+lQxqA/1SuB6NEnhKZy7pfPuPsGMbDc5x7HmxboTgrOyJgUWUWD7TQ9mcpj
	 STja/Dmisy1Z55YHwuySnP6Exyu7pYZX0/4LIi/w=
Subject: FAILED: patch "[PATCH] mm/huge_memory: don't ignore queried cachemode in" failed to apply to 6.12-stable tree
To: david@redhat.com,akpm@linux-foundation.org,apopple@nvidia.com,baolin.wang@linux.alibaba.com,dan.j.williams@intel.com,dev.jain@arm.com,jgg@nvidia.com,liam.howlett@oracle.com,lorenzo.stoakes@oracle.com,mhocko@suse.com,npache@redhat.com,osalvador@suse.de,rppt@kernel.org,ryan.roberts@arm.com,stable@vger.kernel.org,surenb@google.com,vbabka@suse.cz,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 13:07:38 +0200
Message-ID: <2025081838-flap-rewire-69a5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 09fefdca80aebd1023e827cb0ee174983d829d18
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081838-flap-rewire-69a5@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 09fefdca80aebd1023e827cb0ee174983d829d18 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Fri, 13 Jun 2025 11:27:00 +0200
Subject: [PATCH] mm/huge_memory: don't ignore queried cachemode in
 vmf_insert_pfn_pud()

Patch series "mm/huge_memory: vmf_insert_folio_*() and
vmf_insert_pfn_pud() fixes", v3.

While working on improving vm_normal_page() and friends, I stumbled over
this issues: refcounted "normal" folios must not be marked using
pmd_special() / pud_special().  Otherwise, we're effectively telling the
system that these folios are no "normal", violating the rules we
documented for vm_normal_page().

Fortunately, there are not many pmd_special()/pud_special() users yet.  So
far there doesn't seem to be serious damage.

Tested using the ndctl tests ("ndctl:dax" suite).


This patch (of 3):

We set up the cache mode but ...  don't forward the updated pgprot to
insert_pfn_pud().

Only a problem on x86-64 PAT when mapping PFNs using PUDs that require a
special cachemode.

Fix it by using the proper pgprot where the cachemode was setup.

It is unclear in which configurations we would get the cachemode wrong:
through vfio seems possible.  Getting cachemodes wrong is usually ...
bad.  As the fix is easy, let's backport it to stable.

Identified by code inspection.

Link: https://lkml.kernel.org/r/20250613092702.1943533-1-david@redhat.com
Link: https://lkml.kernel.org/r/20250613092702.1943533-2-david@redhat.com
Fixes: 7b806d229ef1 ("mm: remove vmf_insert_pfn_xxx_prot() for huge page-table entries")
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Tested-by: Dan Williams <dan.j.williams@intel.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Mariano Pache <npache@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d3e66136e41a..49b98082c540 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1516,10 +1516,9 @@ static pud_t maybe_pud_mkwrite(pud_t pud, struct vm_area_struct *vma)
 }
 
 static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
-		pud_t *pud, pfn_t pfn, bool write)
+		pud_t *pud, pfn_t pfn, pgprot_t prot, bool write)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	pgprot_t prot = vma->vm_page_prot;
 	pud_t entry;
 
 	if (!pud_none(*pud)) {
@@ -1581,7 +1580,7 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 	pfnmap_setup_cachemode_pfn(pfn_t_to_pfn(pfn), &pgprot);
 
 	ptl = pud_lock(vma->vm_mm, vmf->pud);
-	insert_pfn_pud(vma, addr, vmf->pud, pfn, write);
+	insert_pfn_pud(vma, addr, vmf->pud, pfn, pgprot, write);
 	spin_unlock(ptl);
 
 	return VM_FAULT_NOPAGE;
@@ -1625,7 +1624,7 @@ vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio,
 		add_mm_counter(mm, mm_counter_file(folio), HPAGE_PUD_NR);
 	}
 	insert_pfn_pud(vma, addr, vmf->pud, pfn_to_pfn_t(folio_pfn(folio)),
-		write);
+		       vma->vm_page_prot, write);
 	spin_unlock(ptl);
 
 	return VM_FAULT_NOPAGE;


