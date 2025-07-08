Return-Path: <stable+bounces-160411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67030AFBEC2
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 01:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2634A4786
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 23:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396B2267F58;
	Mon,  7 Jul 2025 23:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bI7kggyo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22921A76D0;
	Mon,  7 Jul 2025 23:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751932114; cv=none; b=EMTjDJc4t2SP2DqNM5H9oqJjKKcTB4lOc9NjvaE4+z0PC72hmnqk6vQwjqhkFH8xZkH30EPsDZI+9T4e+suRoELHc+UATqKoTZzJJXQYyU8EzYV4yQU2XqA0/flotdtAn2N/gYcaAGlaH+tbSN90Vf7zl1osfu+GZLCIRvsB0RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751932114; c=relaxed/simple;
	bh=uFGcVC28YdRdpiqvCMoSXomY41MXaicNNF/paUdf1Po=;
	h=Date:To:From:Subject:Message-Id; b=VLyzmLZjX+RRy26zmuC4LO8AU+04ZDPRM2gSAaCD3GsOdG73lEpRdLoRhhkO71KolPF7lR45WtcdJFUmLvMWwukZRlUSFaXGIdT1EiMJ/xA398ouniQ6bimezk5QeYKxIij/yR1yD7dY3SxY4YBl6ENpR74eDxK+J2vumtdGCaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bI7kggyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6640BC4CEF1;
	Mon,  7 Jul 2025 23:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1751932113;
	bh=uFGcVC28YdRdpiqvCMoSXomY41MXaicNNF/paUdf1Po=;
	h=Date:To:From:Subject:From;
	b=bI7kggyoYc6CQpgh2E9vF7TncReOxP1P3Ljx6+yLxEk92OZM2psfHXJnaCK2uaxIP
	 VwCXoOo14UH7jlIST0CyTagowIdGs+1fDBuq8GmgMGSM1ec81oSBy4DNUA9qcxn5F+
	 4XHVKNNTtHvg0cNy+ETIarM3oeKf4a0XTkRyg5wU=
Date: Mon, 07 Jul 2025 16:48:32 -0700
To: mm-commits@vger.kernel.org,willy@infradead.org,vbabka@suse.cz,surenb@google.com,stable@vger.kernel.org,rppt@kernel.org,rientjes@google.com,mhocko@suse.com,lorenzo.stoakes@oracle.com,liam.howlett@oracle.com,david@redhat.com,cl@gentwo.org,harry.yoo@oracle.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-check-if-folio-has-valid-mapcount-before-folio_test_anonksm-when-necessary.patch added to mm-new branch
Message-Id: <20250707234833.6640BC4CEF1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: mm: check if folio has valid mapcount before folio_test_{anon,ksm}() when necessary
has been added to the -mm mm-new branch.  Its filename is
     mm-check-if-folio-has-valid-mapcount-before-folio_test_anonksm-when-necessary.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-check-if-folio-has-valid-mapcount-before-folio_test_anonksm-when-necessary.patch

This patch will later appear in the mm-new branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Note, mm-new is a provisional staging ground for work-in-progress
patches, and acceptance into mm-new is a notification for others take
notice and to finish up reviews.  Please do not hesitate to respond to
review feedback and post updated versions to replace or incrementally
fixup patches in mm-new.

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Harry Yoo <harry.yoo@oracle.com>
Subject: mm: check if folio has valid mapcount before folio_test_{anon,ksm}() when necessary
Date: Mon, 7 Jul 2025 21:07:40 +0900

folio_test_anon() and folio_test_ksm() may return false positives when the
folio is a typed page (except hugetlb), because lower bits of
folio->mapping field can be set even if it doesn't mean FOLIO_MAPPING_*
flags.

To avoid false positives, folio_test_{anon,ksm}() should be called only if
!page_has_type(&folio->page) || folio_test_hugetlb(folio).  However, the
check can be skipped if a folio is or will be mapped to userspace because
typed pages that are not hugetlb folios cannot be mapped to userspace.

As folio_expected_ref_count() already does the check, introduce a helper
function folio_has_mapcount() and use it in folio_expected_ref_count() and
stable_page_flags().

Update the comment in FOLIO_MAPPING_* flags accordingly.

This fixes tools/mm/page-types reporting pages with
KPF_SLAB, KPF_ANON and KPF_SLAB (with flags, page-counts, MB omitted):
  $ sudo ./page-types | grep slab
  _______S___________________________________	slab
  _______S____a________x_____________________	slab,anonymous,ksm

Link: https://lkml.kernel.org/r/20250707120740.4413-1-harry.yoo@oracle.com
Fixes: 130d4df57390 ("mm/sl[au]b: rearrange struct slab fields to allow larger rcu_head")
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter (Ampere) <cl@gentwo.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/proc/page.c             |   19 +++++++++++--------
 include/linux/mm.h         |    2 +-
 include/linux/page-flags.h |   20 ++++++++++++++------
 3 files changed, 26 insertions(+), 15 deletions(-)

--- a/fs/proc/page.c~mm-check-if-folio-has-valid-mapcount-before-folio_test_anonksm-when-necessary
+++ a/fs/proc/page.c
@@ -148,18 +148,21 @@ u64 stable_page_flags(const struct page
 	folio = page_folio(page);
 
 	k = folio->flags;
-	mapping = (unsigned long)folio->mapping;
-	is_anon = mapping & FOLIO_MAPPING_ANON;
 
 	/*
 	 * pseudo flags for the well known (anonymous) memory mapped pages
 	 */
-	if (page_mapped(page))
-		u |= 1 << KPF_MMAP;
-	if (is_anon) {
-		u |= 1 << KPF_ANON;
-		if (mapping & FOLIO_MAPPING_KSM)
-			u |= 1 << KPF_KSM;
+	if (folio_has_mapcount(folio)) {
+		mapping = (unsigned long)folio->mapping;
+		is_anon = mapping & FOLIO_MAPPING_ANON;
+
+		if (page_mapped(page))
+			u |= 1 << KPF_MMAP;
+		if (is_anon) {
+			u |= 1 << KPF_ANON;
+			if (mapping & FOLIO_MAPPING_KSM)
+				u |= 1 << KPF_KSM;
+		}
 	}
 
 	/*
--- a/include/linux/mm.h~mm-check-if-folio-has-valid-mapcount-before-folio_test_anonksm-when-necessary
+++ a/include/linux/mm.h
@@ -2167,7 +2167,7 @@ static inline int folio_expected_ref_cou
 	const int order = folio_order(folio);
 	int ref_count = 0;
 
-	if (WARN_ON_ONCE(page_has_type(&folio->page) && !folio_test_hugetlb(folio)))
+	if (WARN_ON_ONCE(!folio_has_mapcount(folio)))
 		return 0;
 
 	if (folio_test_anon(folio)) {
--- a/include/linux/page-flags.h~mm-check-if-folio-has-valid-mapcount-before-folio_test_anonksm-when-necessary
+++ a/include/linux/page-flags.h
@@ -706,12 +706,15 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemma
  * address_space which maps the folio from disk; whereas "folio_mapped"
  * refers to user virtual address space into which the folio is mapped.
  *
- * For slab pages, since slab reuses the bits in struct page to store its
- * internal states, the folio->mapping does not exist as such, nor do
- * these flags below.  So in order to avoid testing non-existent bits,
- * please make sure that folio_test_slab(folio) actually evaluates to
- * false before calling the following functions (e.g., folio_test_anon).
- * See mm/slab.h.
+ * For certain typed pages like slabs, since they reuse bits in struct page
+ * to store internal states, folio->mapping does not point to a valid
+ * mapping, nor do these flags exist. To avoid testing non-existent bits,
+ * make sure folio_has_mapcount() actually evaluates to true before calling
+ * the following functions (e.g., folio_test_anon).
+ *
+ * The folio_has_mapcount() check can be skipped if the folio is mapped
+ * to userspace, since a folio with !folio_has_mapcount() cannot be mapped
+ * to userspace at all.
  */
 #define FOLIO_MAPPING_ANON	0x1
 #define FOLIO_MAPPING_ANON_KSM	0x2
@@ -1092,6 +1095,11 @@ static inline bool PageHuge(const struct
 	return folio_test_hugetlb(page_folio(page));
 }
 
+static inline bool folio_has_mapcount(const struct folio *folio)
+{
+	return !page_has_type(&folio->page) || folio_test_hugetlb(folio);
+}
+
 /*
  * Check if a page is currently marked HWPoisoned. Note that this check is
  * best effort only and inherently racy: there is no way to synchronize with
_

Patches currently in -mm which might be from harry.yoo@oracle.com are

lib-alloc_tag-do-not-acquire-non-existent-lock-in-alloc_tag_top_users.patch
lib-alloc_tag-do-not-acquire-non-existent-lock-in-alloc_tag_top_users-v3.patch
mm-zsmalloc-do-not-pass-__gfp_movable-if-config_compaction=n.patch
mm-check-if-folio-has-valid-mapcount-before-folio_test_anonksm-when-necessary.patch


