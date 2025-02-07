Return-Path: <stable+bounces-114312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2AFA2CEF0
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 589853A76DE
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 21:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF17F1BD9E6;
	Fri,  7 Feb 2025 21:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dj4E40C8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22021B87CC;
	Fri,  7 Feb 2025 21:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738963241; cv=none; b=SfvQt1vnACsZFo8HLRYJnAY7W0kf0b4ycRUHPMsL5cYFkrBdXUgUKpPGt9PBQkqmGj7o0hhka3HfCgnLoeiv4pQSI7lhSxCQC07UugILNOCtCAann5Y3L/30ekrSG3b/khdvA8hJ9gRGKiQvPHws7YbMtjkBuQtwfH7hX0+90WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738963241; c=relaxed/simple;
	bh=5eAb6WCJyd/QZQWOfoLnHQEwZBeSQIp9J24NNYIAJsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H4ej9iXdGGhH61HPEpWe1j4V0IzQUkP1PodzVEoE112ze5Zvm3nYfYOaZiillfLdCoC6bKtQCBIa1jVtL+du7R1pVyYmb+v5yrYNOF8A4xH2hDeEIizAraBO9q48khX+e4JuVmzZFycKtLX5eOQnObU7SXyja35YOdNqPSIAATI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dj4E40C8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6096C4CED1;
	Fri,  7 Feb 2025 21:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738963239;
	bh=5eAb6WCJyd/QZQWOfoLnHQEwZBeSQIp9J24NNYIAJsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dj4E40C8q0gg3ud86pNgaTm+kbxa71t2XiAGOaMKWerPD4HMKWLzhpR5OcEi1pieM
	 LvSdpdKIOfzfIIiMB/j+G1OcGL+j1k8FEHWrPwhzps3WSQFDeRJ+JRJ3B8ONpNpN2r
	 COTpEwjtAWtj3ET7sA+YfPeQCx4sn7CgXJocQF8NDwo8JB8WGVFcHrHlIfGwg6mGz+
	 petGKMi5vKt0jKi1NkdjE28Y+2+ohBfFaPRSZGEXe/z937Ej1VA4CvZnOz3JjyAx/c
	 mIi6D+X/jvCNwTiZ/5EqbX7eYmSEquKprB8vy9IVks0wck4efGgRy3FlY6tG03NCs9
	 jCa5cmMHDpviw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Usama Arif <usamaarif642@gmail.com>,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mm/damon/ops: have damon_get_folio return folio even for tail pages
Date: Fri,  7 Feb 2025 13:20:32 -0800
Message-Id: <20250207212033.45269-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207212033.45269-1-sj@kernel.org>
References: <20250207212033.45269-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Usama Arif <usamaarif642@gmail.com>

This effectively adds support for large folios in damon for paddr,
as damon_pa_mkold/young won't get a null folio from this function
and won't ignore it, hence access will be checked and reported.
This also means that larger folios will be considered for
different DAMOS actions like pageout, prioritization and migration.
As these DAMOS actions will consider larger folios, iterate through
the region at folio_size and not PAGE_SIZE intervals.
This should not have an affect on vaddr, as damon_young_pmd_entry
considers pmd entries.

Fixes: a28397beb55b ("mm/damon: implement primitives for physical address space monitoring")
Cc: <stable@vger.kernel.org>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/ops-common.c |  2 +-
 mm/damon/paddr.c      | 24 ++++++++++++++++++------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index d25d99cb5f2b..d511be201c4c 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -24,7 +24,7 @@ struct folio *damon_get_folio(unsigned long pfn)
 	struct page *page = pfn_to_online_page(pfn);
 	struct folio *folio;
 
-	if (!page || PageTail(page))
+	if (!page)
 		return NULL;
 
 	folio = page_folio(page);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 0f9ae14f884d..0fb61f6ddb8d 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -266,11 +266,14 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 		damos_add_filter(s, filter);
 	}
 
-	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
+	addr = r->ar.start;
+	while (addr < r->ar.end) {
 		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
 
-		if (!folio)
+		if (!folio) {
+			addr += PAGE_SIZE;
 			continue;
+		}
 
 		if (damos_pa_filter_out(s, folio))
 			goto put_folio;
@@ -286,6 +289,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 		else
 			list_add(&folio->lru, &folio_list);
 put_folio:
+		addr += folio_size(folio);
 		folio_put(folio);
 	}
 	if (install_young_filter)
@@ -301,11 +305,14 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 {
 	unsigned long addr, applied = 0;
 
-	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
+	addr = r->ar.start;
+	while (addr < r->ar.end) {
 		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
 
-		if (!folio)
+		if (!folio) {
+			addr += PAGE_SIZE;
 			continue;
+		}
 
 		if (damos_pa_filter_out(s, folio))
 			goto put_folio;
@@ -318,6 +325,7 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 			folio_deactivate(folio);
 		applied += folio_nr_pages(folio);
 put_folio:
+		addr += folio_size(folio);
 		folio_put(folio);
 	}
 	return applied * PAGE_SIZE;
@@ -464,11 +472,14 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 	unsigned long addr, applied;
 	LIST_HEAD(folio_list);
 
-	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
+	addr = r->ar.start;
+	while (addr < r->ar.end) {
 		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
 
-		if (!folio)
+		if (!folio) {
+			addr += PAGE_SIZE;
 			continue;
+		}
 
 		if (damos_pa_filter_out(s, folio))
 			goto put_folio;
@@ -479,6 +490,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 			goto put_folio;
 		list_add(&folio->lru, &folio_list);
 put_folio:
+		addr += folio_size(folio);
 		folio_put(folio);
 	}
 	applied = damon_pa_migrate_pages(&folio_list, s->target_nid);
-- 
2.39.5

