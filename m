Return-Path: <stable+bounces-133065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0071DA91B37
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69D1519E3E56
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9D7238164;
	Thu, 17 Apr 2025 11:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hnIwcbic"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15D822B594
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744890538; cv=none; b=smVFsIcGeSl3zAH+PqT7oGfpzSvAKEMUJnrWOh9I5YKU7hx9uJep8QYYet0VfY0xv/mdBBW0YhyCyTygX34NAlfRRWZfbGQcbGhNk5PIu8s+C6GhSLJVVSehPC07XNJeWEYRKVpBHLbw7Qu7I3CZbxph+18+RnitzmfUZ0uup5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744890538; c=relaxed/simple;
	bh=8KY9RvmMVWrSxz0HcP09LD0xw/Kw0hwf2BPN5LkHLhI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rw2vNJOhnUhPNdTAEzY5HJPfhs2dyQ+5Lz5Qz9dk6idjK/GaoJsRAha2KsWrfFOhs2d1Dnx4A2KzrNZHaS7fBRzczjunJoAcSnPgitv6All2UKTqk7C06vFEmO634zslR1mOgmlOowJn8F7IG+Ag1r2YvmdtWRAN5+LhkqKMyA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hnIwcbic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371B2C4CEE4;
	Thu, 17 Apr 2025 11:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744890538;
	bh=8KY9RvmMVWrSxz0HcP09LD0xw/Kw0hwf2BPN5LkHLhI=;
	h=Subject:To:Cc:From:Date:From;
	b=hnIwcbicc61bq2ATcwhU1m0nBBYewulT8agBddpzSwDaDpeVTblWmXMhPBXhGdtRM
	 y04UGElJZH7YwG1x11W8wC1yk/UfZCJCcQ8lmTFOMfwtN9DZ4d8PcaNMrzf6EZhqwc
	 CtmFShUFG8D4YKMniQ/7gPptkZxgVj12tSdQbeLY=
Subject: FAILED: patch "[PATCH] mm/damon/ops: have damon_get_folio return folio even for tail" failed to apply to 6.1-stable tree
To: usamaarif642@gmail.com,akpm@linux-foundation.org,sj@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 13:45:14 +0200
Message-ID: <2025041714-coeditor-trance-46cb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3a06696305e757f652dd0dcf4dfa2272eda39434
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041714-coeditor-trance-46cb@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3a06696305e757f652dd0dcf4dfa2272eda39434 Mon Sep 17 00:00:00 2001
From: Usama Arif <usamaarif642@gmail.com>
Date: Fri, 7 Feb 2025 13:20:32 -0800
Subject: [PATCH] mm/damon/ops: have damon_get_folio return folio even for tail
 pages

Patch series "mm/damon/paddr: fix large folios access and schemes handling".

DAMON operations set for physical address space, namely 'paddr', treats
tail pages as unaccessed always.  It can also apply DAMOS action to a
large folio multiple times within single DAMOS' regions walking.  As a
result, the monitoring output has poor quality and DAMOS works in
unexpected ways when large folios are being used.  Fix those.

The patches were parts of Usama's hugepage_size DAMOS filter patch
series[1].  The first fix has collected from there with a slight commit
message change for the subject prefix.  The second fix is re-written by SJ
and posted as an RFC before this series.  The second one also got a slight
commit message change for the subject prefix.

[1] https://lore.kernel.org/20250203225604.44742-1-usamaarif642@gmail.com
[2] https://lore.kernel.org/20250206231103.38298-1-sj@kernel.org


This patch (of 2):

This effectively adds support for large folios in damon for paddr, as
damon_pa_mkold/young won't get a null folio from this function and won't
ignore it, hence access will be checked and reported.  This also means
that larger folios will be considered for different DAMOS actions like
pageout, prioritization and migration.  As these DAMOS actions will
consider larger folios, iterate through the region at folio_size and not
PAGE_SIZE intervals.  This should not have an affect on vaddr, as
damon_young_pmd_entry considers pmd entries.

Link: https://lkml.kernel.org/r/20250207212033.45269-1-sj@kernel.org
Link: https://lkml.kernel.org/r/20250207212033.45269-2-sj@kernel.org
Fixes: a28397beb55b ("mm/damon: implement primitives for physical address space monitoring")
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 86a50e8fbc80..0db1fc70c84d 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -26,7 +26,7 @@ struct folio *damon_get_folio(unsigned long pfn)
 	struct page *page = pfn_to_online_page(pfn);
 	struct folio *folio;
 
-	if (!page || PageTail(page))
+	if (!page)
 		return NULL;
 
 	folio = page_folio(page);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 1a89920efce9..2ac19ebc7076 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -277,11 +277,14 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
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
@@ -297,6 +300,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 		else
 			list_add(&folio->lru, &folio_list);
 put_folio:
+		addr += folio_size(folio);
 		folio_put(folio);
 	}
 	if (install_young_filter)
@@ -312,11 +316,14 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
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
@@ -329,6 +336,7 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 			folio_deactivate(folio);
 		applied += folio_nr_pages(folio);
 put_folio:
+		addr += folio_size(folio);
 		folio_put(folio);
 	}
 	return applied * PAGE_SIZE;
@@ -475,11 +483,14 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
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
@@ -490,6 +501,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 			goto put_folio;
 		list_add(&folio->lru, &folio_list);
 put_folio:
+		addr += folio_size(folio);
 		folio_put(folio);
 	}
 	applied = damon_pa_migrate_pages(&folio_list, s->target_nid);


