Return-Path: <stable+bounces-93905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 686A69D1F5A
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 05:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2A17B24322
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 04:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261171514DC;
	Tue, 19 Nov 2024 04:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+KBleyg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF9814E2CD
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 04:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731990991; cv=none; b=fD9PLw0adoIMvy8hgPp9t8xdyYb55qx5LXsxBhZZG65pSNqaZTjRhvcywHrjFu5WSYI8Zew0ezLsbVST6wJLZf/B50tRnKKJE3yV93AwujJXqigq00XXFAPA32X6m3yC6KP68IJLo6tOkkshvPBsn8eHO1Zz0B70dp8T6erOSDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731990991; c=relaxed/simple;
	bh=DQ+0+ZHqGlziw23OFCUNcV3YgHVuasllZ37JsOFodnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stxAmFXfhD2yHk0sSFkEb85mPn1UBybimNAgKDwZVY/CkJpyoL+jnNuQqpTIA6pd4+QzIiENk1PRZwcGls6mzX8nwv05UPXkpgkTkI8StLikqUbgo885jDgQoi+NSJ5UjBfLuc3wevlrveOu1pNGC6CGugwklviDtJLvoWcXzQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+KBleyg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D88C4CED2;
	Tue, 19 Nov 2024 04:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731990991;
	bh=DQ+0+ZHqGlziw23OFCUNcV3YgHVuasllZ37JsOFodnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V+KBleygMtRAcPP2wlGm2LR7uSDLXpLqb4BQ98Svwisqhlotysss6d8pyKM3tRztY
	 ZTm1wV+DIi2qYd4x6j6Mkj89q728epVVYfYpk1RBRLci57uaI2PH9MSqFMd5YopsNV
	 YnZL+p5BDuipqNw9Ohsr4Oip/MelFVoIGUemtjyN9TWIeglgPNd9iM4wm4+HWnLOl3
	 wjV9D0pUWe1i9yRH0TDho0wHW0wtVEnvkiTESf/7hOtgF6IiPphQyXbeEGYxOuN2Z8
	 eP9hgorQthATKp0k5Ia8HPvU5RHZBCEWPcoASMJ9cU8PZU8HVQuje8wLokOzhF0cf+
	 2huozX8INsArg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugh Dickins <hughd@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: FAILED: patch "[PATCH] mm: page_alloc: move mlocked flag clearance into" failed to apply to 6.6-stable tree
Date: Mon, 18 Nov 2024 23:36:29 -0500
Message-ID: <92845557-1e54-71b7-0501-4733005a8fc3@google.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <92845557-1e54-71b7-0501-4733005a8fc3@google.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 66edc3a5894c74f8887c8af23b97593a0dd0df4d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Hugh Dickins <hughd@google.com>
Commit author: Roman Gushchin <roman.gushchin@linux.dev>

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (different SHA1: fa484b40621a)      |
| 6.6.y           |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-18 16:46:31.817057604 -0500
+++ /tmp/tmp.r9qovxR4fN	2024-11-18 16:46:31.809104506 -0500
@@ -1,3 +1,13 @@
+For 6.6 and 6.1 please use this replacement patch:
+
+>From 9de12cbafdf2fae7d5bfdf14f4684ce3244469df Mon Sep 17 00:00:00 2001
+From: Roman Gushchin <roman.gushchin@linux.dev>
+Date: Wed, 6 Nov 2024 19:53:54 +0000
+Subject: [PATCH] mm: page_alloc: move mlocked flag clearance into
+ free_pages_prepare()
+
+commit 66edc3a5894c74f8887c8af23b97593a0dd0df4d upstream.
+
 Syzbot reported a bad page state problem caused by a page being freed
 using free_page() still having a mlocked flag at free_pages_prepare()
 stage:
@@ -109,26 +119,26 @@
 Cc: Vlastimil Babka <vbabka@suse.cz>
 Cc: <stable@vger.kernel.org>
 Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
+Signed-off-by: Hugh Dickins <hughd@google.com>
 ---
  mm/page_alloc.c | 15 +++++++++++++++
- mm/swap.c       | 14 --------------
- 2 files changed, 15 insertions(+), 14 deletions(-)
+ mm/swap.c       | 20 --------------------
+ 2 files changed, 15 insertions(+), 20 deletions(-)
 
 diff --git a/mm/page_alloc.c b/mm/page_alloc.c
-index c6c7bb3ea71bc..216fbbfbedcf9 100644
+index 7272a922b838..3d7e685bdd0b 100644
 --- a/mm/page_alloc.c
 +++ b/mm/page_alloc.c
-@@ -1048,6 +1048,7 @@ __always_inline bool free_pages_prepare(struct page *page,
- 	bool skip_kasan_poison = should_skip_kasan_poison(page);
+@@ -1082,12 +1082,27 @@ static __always_inline bool free_pages_prepare(struct page *page,
+ 	int bad = 0;
+ 	bool skip_kasan_poison = should_skip_kasan_poison(page, fpi_flags);
  	bool init = want_init_on_free();
- 	bool compound = PageCompound(page);
 +	struct folio *folio = page_folio(page);
  
  	VM_BUG_ON_PAGE(PageTail(page), page);
  
-@@ -1057,6 +1058,20 @@ __always_inline bool free_pages_prepare(struct page *page,
- 	if (memcg_kmem_online() && PageMemcgKmem(page))
- 		__memcg_kmem_uncharge_page(page, order);
+ 	trace_mm_page_free(page, order);
+ 	kmsan_free_page(page, order);
  
 +	/*
 +	 * In rare cases, when truncation or holepunching raced with
@@ -145,23 +155,17 @@
 +	}
 +
  	if (unlikely(PageHWPoison(page)) && !order) {
- 		/* Do not let hwpoison pages hit pcplists/buddy */
- 		reset_page_owner(page, order);
+ 		/*
+ 		 * Do not let hwpoison pages hit pcplists/buddy
 diff --git a/mm/swap.c b/mm/swap.c
-index b8e3259ea2c47..59f30a981c6f9 100644
+index cd8f0150ba3a..42082eba42de 100644
 --- a/mm/swap.c
 +++ b/mm/swap.c
-@@ -78,20 +78,6 @@ static void __page_cache_release(struct folio *folio, struct lruvec **lruvecp,
- 		lruvec_del_folio(*lruvecp, folio);
+@@ -89,14 +89,6 @@ static void __page_cache_release(struct folio *folio)
  		__folio_clear_lru_flags(folio);
+ 		unlock_page_lruvec_irqrestore(lruvec, flags);
  	}
--
--	/*
--	 * In rare cases, when truncation or holepunching raced with
--	 * munlock after VM_LOCKED was cleared, Mlocked may still be
--	 * found set here.  This does not indicate a problem, unless
--	 * "unevictable_pgs_cleared" appears worryingly large.
--	 */
+-	/* See comment on folio_test_mlocked in release_pages() */
 -	if (unlikely(folio_test_mlocked(folio))) {
 -		long nr_pages = folio_nr_pages(folio);
 -
@@ -171,4 +175,26 @@
 -	}
  }
  
- /*
+ static void __folio_put_small(struct folio *folio)
+@@ -1021,18 +1013,6 @@ void release_pages(release_pages_arg arg, int nr)
+ 			__folio_clear_lru_flags(folio);
+ 		}
+ 
+-		/*
+-		 * In rare cases, when truncation or holepunching raced with
+-		 * munlock after VM_LOCKED was cleared, Mlocked may still be
+-		 * found set here.  This does not indicate a problem, unless
+-		 * "unevictable_pgs_cleared" appears worryingly large.
+-		 */
+-		if (unlikely(folio_test_mlocked(folio))) {
+-			__folio_clear_mlocked(folio);
+-			zone_stat_sub_folio(folio, NR_MLOCK);
+-			count_vm_event(UNEVICTABLE_PGCLEARED);
+-		}
+-
+ 		list_add(&folio->lru, &pages_to_free);
+ 	}
+ 	if (lruvec)
+-- 
+2.47.0.338.g60cca15819-goog
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

