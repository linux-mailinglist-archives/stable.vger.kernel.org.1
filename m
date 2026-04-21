Return-Path: <stable+bounces-240192-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEbLKo+a52lj+QEAu9opvQ
	(envelope-from <stable+bounces-240192-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 17:41:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A6A43CDEC
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 17:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 36C3930131E1
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19692E173D;
	Tue, 21 Apr 2026 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DolYikg4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DA42D94AB;
	Tue, 21 Apr 2026 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776785957; cv=none; b=kjvdyrt9bPv2KjaR8xnh/8lkxBkML7lIOqO6ju+riw2hP9h3OunfD77Y9aTxOq8x/v6hOwoCjc/J/9nEQpBZO0HHo9i/rmlWD/ZlShuze+o4borkd87hu4a42uTCN5hLZh+hYoWM2YJDBkGXQp0VLN7TAnLeZ4N/z15tX8nI/Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776785957; c=relaxed/simple;
	bh=Ik9BfKVfhf9yZ3LiURODlQpyNGNrs0AnoKj75WR+DEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jM2vMosycFA+njt3F5RpKTZ3e6GfdJd5Y2jbqfYSjMz6LAelPOeRKFC3z4Cn+b8/gd9jKZwAcvdpk1fWJckV7pnuIfCrts8U46lzH1Gth8gPlutIOYYXcWnduEJdmyM7V2v3Jq2OdMw9N/QnJwc5U3QEtUqL9k/LDMYiv963BKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DolYikg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74479C2BCB6;
	Tue, 21 Apr 2026 15:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776785957;
	bh=Ik9BfKVfhf9yZ3LiURODlQpyNGNrs0AnoKj75WR+DEs=;
	h=From:Date:Subject:To:Cc:From;
	b=DolYikg4H+7mnTbsnAlHUOtejFyckSeDJsZa0O/KWPbowntUsHTsFthTt2vYLcUKO
	 n4ibgl7imYZNrM6J0+PbmHuuRWivxHQXAU3aYCe2Qplntj+ueiR3wkzCABpt+oMNGE
	 1hvNlZZFJoZSYSsr3804XezMrmndYGYHDcCXhM57Mx3CyLyFOyCGEd+V0qxFAOm447
	 A5kekRRFZP6GiSY/nwS4uPO2prdRQwW23XzReaDYX1RgrtxB0ifppG3EyoAnVVVJ6I
	 1xuAQapdwHznNrlaASa1C0jaaKzawk8hZK28N0xA3xJ3eUTFbmTNlHuBwXousJEdPr
	 j1/sVa5TeUllA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 21 Apr 2026 17:39:07 +0200
Subject: [PATCH v2] mm/page_alloc: fix initialization of tags of the huge
 zero folio with init_on_free
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-zerotags-v2-1-05cb1035482e@kernel.org>
X-B4-Tracking: v=1; b=H4sIABqa52kC/0XMSwrCMBSF4a2UOzaSl6115D6kg7S5pkFJ5KYEt
 WTvxiI4/A+Hb4WE5DHBqVmBMPvkY6ghdw1MswkOmbe1QXLZci069kaKi3GJKa2MajuF4mih3h+
 EV//cqMtQe/ZpifTa5Cy+6w+R/I9kwQRTaKdeYX8YR32+IQW87yM5GEopH77SdXuhAAAA
To: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Mark Brown <broonie@kernel.org>, 
 Dev Jain <dev.jain@arm.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, stable@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240192-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C3A6A43CDEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

__GFP_ZEROTAGS semantics are currently a bit weird, but effectively this
flag is only ever set alongside __GFP_ZERO and __GFP_SKIP_KASAN.

If we run with init_on_free, we will zero out pages during
__free_pages_prepare(), to skip zeroing on the allocation path.

However, when allocating with __GFP_ZEROTAG set, post_alloc_hook() will
consequently not only skip clearing page content, but also skip
clearing tag memory.

Not clearing tags through __GFP_ZEROTAGS is irrelevant for most pages that
will get mapped to user space through set_pte_at() later: set_pte_at() and
friends will detect that the tags have not been initialized yet
(PG_mte_tagged not set), and initialize them.

However, for the huge zero folio, which will be mapped through a PMD
marked as special, this initialization will not be performed, ending up
exposing whatever tags were still set for the pages.

The docs (Documentation/arch/arm64/memory-tagging-extension.rst) state
that allocation tags are set to 0 when a page is first mapped to user
space. That no longer holds with the huge zero folio when init_on_free
is enabled.

Fix it by decoupling __GFP_ZEROTAGS from __GFP_ZERO, passing to
tag_clear_highpages() whether we want to also clear page content.

Invert the meaning of the tag_clear_highpages() return value to have
clearer semantics.

Reproduced with the huge zero folio by modifying the check_buffer_fill
arm64/mte selftest to use a 2 MiB area, after making sure that pages have
a non-0 tag set when freeing (note that, during boot, we will not
actually initialize tags, but only set KASAN_TAG_KERNEL in the page
flags).

	$ ./check_buffer_fill
	1..20
	...
	not ok 17 Check initial tags with private mapping, sync error mode and mmap memory
	not ok 18 Check initial tags with private mapping, sync error mode and mmap/mprotect memory
	...

This code needs more cleanups; we'll tackle that next, like
decoupling __GFP_ZEROTAGS from __GFP_SKIP_KASAN.

Fixes: adfb6609c680 ("mm/huge_memory: initialise the tags of the huge zero folio")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
Changes in v2:
- Drop kasan_hw_tags_enabled() handling, as it missed the case of
  user-space MTE without KASAN.
- Keep letting_clear_highpages() return a bool and re-instantiate
  system_supports_mte() handling in the arm64 variant.
- Rephrase __GFP_ZEROTAGS comment, making it clearer that this is not
  just a performance improvement.
- Retested and more excessively build tested
- Using a new b4 template, hopefully that doesn't mess things up
- Link to v1: https://lore.kernel.org/r/20260420-zerotags-v1-1-3edc93e95bb4@kernel.org
---
 arch/arm64/include/asm/page.h |  2 +-
 arch/arm64/mm/fault.c         | 11 +++++++----
 include/linux/gfp_types.h     | 10 +++++-----
 include/linux/highmem.h       |  7 ++++---
 mm/page_alloc.c               |  8 ++++----
 5 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index e25d0d18f6d7..58200de8a221 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -33,7 +33,7 @@ struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
 						unsigned long vaddr);
 #define vma_alloc_zeroed_movable_folio vma_alloc_zeroed_movable_folio
 
-bool tag_clear_highpages(struct page *to, int numpages);
+bool tag_clear_highpages(struct page *to, int numpages, bool clear_pages);
 #define __HAVE_ARCH_TAG_CLEAR_HIGHPAGES
 
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 0f3c5c7ca054..739800835920 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -1018,7 +1018,7 @@ struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
 	return vma_alloc_folio(flags, 0, vma, vaddr);
 }
 
-bool tag_clear_highpages(struct page *page, int numpages)
+bool tag_clear_highpages(struct page *page, int numpages, bool clear_pages)
 {
 	/*
 	 * Check if MTE is supported and fall back to clear_highpage().
@@ -1026,13 +1026,16 @@ bool tag_clear_highpages(struct page *page, int numpages)
 	 * post_alloc_hook() will invoke tag_clear_highpages().
 	 */
 	if (!system_supports_mte())
-		return false;
+		return clear_pages;
 
 	/* Newly allocated pages, shouldn't have been tagged yet */
 	for (int i = 0; i < numpages; i++, page++) {
 		WARN_ON_ONCE(!try_page_mte_tagging(page));
-		mte_zero_clear_page_tags(page_address(page));
+		if (clear_pages)
+			mte_zero_clear_page_tags(page_address(page));
+		else
+			mte_clear_page_tags(page_address(page));
 		set_page_mte_tagged(page);
 	}
-	return true;
+	return false;
 }
diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 6c75df30a281..d79049291b1a 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -273,11 +273,11 @@ enum {
  *
  * %__GFP_ZERO returns a zeroed page on success.
  *
- * %__GFP_ZEROTAGS zeroes memory tags at allocation time if the memory itself
- * is being zeroed (either via __GFP_ZERO or via init_on_alloc, provided that
- * __GFP_SKIP_ZERO is not set). This flag is intended for optimization: setting
- * memory tags at the same time as zeroing memory has minimal additional
- * performance impact.
+ * %__GFP_ZEROTAGS zeroes memory tags at allocation time. Setting memory tags at
+ * the same time as zeroing memory (e.g., with __GPF_ZERO) has minimal
+ * additional performance impact. However, __GFP_ZEROTAGS also zeroes the tags
+ * even if memory is not getting zeroed at allocation time (e.g.,
+ * with init_on_free).
  *
  * %__GFP_SKIP_KASAN makes KASAN skip unpoisoning on page allocation.
  * Used for userspace and vmalloc pages; the latter are unpoisoned by
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index af03db851a1d..d7aac9de1c8a 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -347,10 +347,11 @@ static inline void clear_highpage_kasan_tagged(struct page *page)
 
 #ifndef __HAVE_ARCH_TAG_CLEAR_HIGHPAGES
 
-/* Return false to let people know we did not initialize the pages */
-static inline bool tag_clear_highpages(struct page *page, int numpages)
+/* Returns true if the caller has to initialize the pages */
+static inline bool tag_clear_highpages(struct page *page, int numpages,
+		bool clear_pages)
 {
-	return false;
+	return clear_pages;
 }
 
 #endif
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 65e205111553..71859993dd54 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1808,9 +1808,9 @@ static inline bool should_skip_init(gfp_t flags)
 inline void post_alloc_hook(struct page *page, unsigned int order,
 				gfp_t gfp_flags)
 {
+	const bool zero_tags = gfp_flags & __GFP_ZEROTAGS;
 	bool init = !want_init_on_free() && want_init_on_alloc(gfp_flags) &&
 			!should_skip_init(gfp_flags);
-	bool zero_tags = init && (gfp_flags & __GFP_ZEROTAGS);
 	int i;
 
 	set_page_private(page, 0);
@@ -1832,11 +1832,11 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 	 */
 
 	/*
-	 * If memory tags should be zeroed
-	 * (which happens only when memory should be initialized as well).
+	 * Clearing tags can efficiently clear the memory for us as well, if
+	 * required.
 	 */
 	if (zero_tags)
-		init = !tag_clear_highpages(page, 1 << order);
+		init = tag_clear_highpages(page, 1 << order, /* clear_pages= */init);
 
 	if (!should_skip_kasan_unpoison(gfp_flags) &&
 	    kasan_unpoison_pages(page, order, init)) {

---

base-commit: f1541b40cd422d7e22273be9b7e9edfc9ea4f0d7

change-id: 20260417-zerotags-343a3673e18d

--

Cheers,

David


