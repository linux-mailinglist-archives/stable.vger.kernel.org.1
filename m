Return-Path: <stable+bounces-93748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F199A9D0726
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 00:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7428281B73
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 23:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BF91DD885;
	Sun, 17 Nov 2024 23:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6VuJ9Pb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512B42309A7
	for <stable@vger.kernel.org>; Sun, 17 Nov 2024 23:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731887839; cv=none; b=CRWIyYIYP0zGrceAj8wg8/yi6QAAYQZwEWIfltAqzwnZOOhrSqOmLPVLQC50wHJG5wLMq49cvYn4erkl3/C8/SXDqGpT+AZ5BjdA6ixe/UFZZdwvD1p6UjchrmeQk3dqW04mRtcIwlVB0+yLAVvr7oJ85WbPlmbfCYFrYCp5KU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731887839; c=relaxed/simple;
	bh=38MeneUAXui+Jj89qENzmsFvmVpa63V4Y7j2IzxkEvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WF3WVa2lFmNnfm8l4v9dDPd1f3rO7A+jtG29Ilm4IbXPldLlqrJJQvRsFu14f2Dgsxd2KSP21oMtklFUMgSCwTAsPWDks4ORW83Y/BfX+nHxgbaTooG24rBV/bYZLt5eudhvAZS7Jtidtzx6R+FWUazJGoMAgpIWSenmILTh6RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6VuJ9Pb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8DCC4CECD;
	Sun, 17 Nov 2024 23:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731887839;
	bh=38MeneUAXui+Jj89qENzmsFvmVpa63V4Y7j2IzxkEvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W6VuJ9Pbn5Rb+uBbPvtohg+aaa4i51bGn+raYmPmVtBzct0P1321i83tX0eGFMB0q
	 I9l3dAzq9FRSugOL49NjBlxzxzLN8IjWol0dd3RF8mD7SIiwjd7pq4U1EAfQ2uHesE
	 t2KAOnj7OgqpIGRTnJtPhsFWySJ0UMyThrjK85d7heXhdn+AyVo7nZpEkNYPOY5HgG
	 +u1pHGuiGhtD5DgFFMbDP0y7jPsJ/AadnkgeZRhCXQkTc5ENqj6txwxnGF+nGSVpVC
	 qesHQZKX7C1qribJ4+ET0IAhX1vRTtCjDpyoOnWzxlqoxTDnGMR1zxGMHbkWkAwt5i
	 20f4XgkIvR8lw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: John Hubbard <jhubbard@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] mm/gup: avoid an unnecessary allocation call for FOLL_LONGTERM cases
Date: Sun, 17 Nov 2024 18:57:16 -0500
Message-ID: <20241117213229.104346-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241117213229.104346-1-jhubbard@nvidia.com>
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

Found matching upstream commit: 94efde1d15399f5c88e576923db9bcd422d217f2

Note: The patch differs from the upstream commit:
---
--- -	2024-11-17 18:44:18.356569875 -0500
+++ /tmp/tmp.ThMcI6kBWx	2024-11-17 18:44:18.344880435 -0500
@@ -1,8 +1,3 @@
-commit 53ba78de064b ("mm/gup: introduce
-check_and_migrate_movable_folios()") created a new constraint on the
-pin_user_pages*() API family: a potentially large internal allocation must
-now occur, for FOLL_LONGTERM cases.
-
 A user-visible consequence has now appeared: user space can no longer pin
 more than 2GB of memory anymore on x86_64.  That's because, on a 4KB
 PAGE_SIZE system, when user space tries to (indirectly, via a device
@@ -21,6 +16,7 @@
 approach and for providing the initial implementation (which I've tested
 and adjusted slightly) as well.
 
+[jhubbard@nvidia.com]: tweaked the patch to apply to linux-stable/6.11.y
 [jhubbard@nvidia.com: whitespace tweak, per David]
   Link: https://lkml.kernel.org/r/131cf9c8-ebc0-4cbb-b722-22fa8527bf3c@nvidia.com
 [jhubbard@nvidia.com: bypass pofs_get_folio(), per Oscar]
@@ -46,14 +42,14 @@
 Cc: <stable@vger.kernel.org>
 Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
 ---
- mm/gup.c | 116 ++++++++++++++++++++++++++++++++++++-------------------
- 1 file changed, 77 insertions(+), 39 deletions(-)
+ mm/gup.c | 114 +++++++++++++++++++++++++++++++++++++------------------
+ 1 file changed, 77 insertions(+), 37 deletions(-)
 
 diff --git a/mm/gup.c b/mm/gup.c
-index 4637dab7b54f1..ad0c8922dac3c 100644
+index 947881ff5e8f..fd3d7900c24b 100644
 --- a/mm/gup.c
 +++ b/mm/gup.c
-@@ -2273,20 +2273,57 @@ struct page *get_dump_page(unsigned long addr)
+@@ -2282,20 +2282,57 @@ struct page *get_dump_page(unsigned long addr)
  #endif /* CONFIG_ELF_CORE */
  
  #ifdef CONFIG_MIGRATION
@@ -116,7 +112,7 @@
  
  		if (folio == prev_folio)
  			continue;
-@@ -2327,16 +2364,15 @@ static unsigned long collect_longterm_unpinnable_folios(
+@@ -2336,16 +2373,15 @@ static unsigned long collect_longterm_unpinnable_folios(
   * Returns -EAGAIN if all folios were successfully migrated or -errno for
   * failure (or partial success).
   */
@@ -138,7 +134,7 @@
  
  		if (folio_is_device_coherent(folio)) {
  			/*
-@@ -2344,7 +2380,7 @@ static int migrate_longterm_unpinnable_folios(
+@@ -2353,7 +2389,7 @@ static int migrate_longterm_unpinnable_folios(
  			 * convert the pin on the source folio to a normal
  			 * reference.
  			 */
@@ -147,7 +143,7 @@
  			folio_get(folio);
  			gup_put_folio(folio, 1, FOLL_PIN);
  
-@@ -2363,8 +2399,8 @@ static int migrate_longterm_unpinnable_folios(
+@@ -2372,8 +2408,8 @@ static int migrate_longterm_unpinnable_folios(
  		 * calling folio_isolate_lru() which takes a reference so the
  		 * folio won't be freed if it's migrating.
  		 */
@@ -158,7 +154,7 @@
  	}
  
  	if (!list_empty(movable_folio_list)) {
-@@ -2387,12 +2423,26 @@ static int migrate_longterm_unpinnable_folios(
+@@ -2396,12 +2432,26 @@ static int migrate_longterm_unpinnable_folios(
  	return -EAGAIN;
  
  err:
@@ -184,9 +180,9 @@
 +}
 +
  /*
-  * Check whether all folios are *allowed* to be pinned indefinitely (long term).
+  * Check whether all folios are *allowed* to be pinned indefinitely (longterm).
   * Rather confusingly, all folios in the range are required to be pinned via
-@@ -2417,16 +2467,13 @@ static int migrate_longterm_unpinnable_folios(
+@@ -2421,16 +2471,13 @@ static int migrate_longterm_unpinnable_folios(
  static long check_and_migrate_movable_folios(unsigned long nr_folios,
  					     struct folio **folios)
  {
@@ -209,7 +205,7 @@
  }
  
  /*
-@@ -2436,22 +2483,13 @@ static long check_and_migrate_movable_folios(unsigned long nr_folios,
+@@ -2442,20 +2489,13 @@ static long check_and_migrate_movable_folios(unsigned long nr_folios,
  static long check_and_migrate_movable_pages(unsigned long nr_pages,
  					    struct page **pages)
  {
@@ -222,10 +218,8 @@
 +	};
  
 -	folios = kmalloc_array(nr_pages, sizeof(*folios), GFP_KERNEL);
--	if (!folios) {
--		unpin_user_pages(pages, nr_pages);
+-	if (!folios)
 -		return -ENOMEM;
--	}
 -
 -	for (i = 0; i < nr_pages; i++)
 -		folios[i] = page_folio(pages[i]);
@@ -238,3 +232,6 @@
  }
  #else
  static long check_and_migrate_movable_pages(unsigned long nr_pages,
+-- 
+2.47.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.11.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |
| stable/linux-4.19.y       |  Failed     |  N/A       |

