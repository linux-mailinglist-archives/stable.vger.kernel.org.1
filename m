Return-Path: <stable+bounces-86871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5572A9A4491
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 19:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B31E1F22F56
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 17:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A888A204012;
	Fri, 18 Oct 2024 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTDd9hlp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D20204021
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729272426; cv=none; b=MskI9Tv9DG2eKx38ON7eDSEuiI/o5isJ4vlC+1YGTrx0b3+wCmdC9+wTwafnYQGsnk0MAvZogS5HQTYtmBP+PPHnRMN7KiyrJoyC2EI3/rcAUiBIEXYRrA4KOAf2LLblweHytU/tAS+grs+6srSLpH6KH2ReN8Go2rHgfdhOUZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729272426; c=relaxed/simple;
	bh=psG8/z/USQpSlbxCcVowNhZZ7cvZiKehgVTmZhOCEyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bCK/eCZvZ9xqClMyJ3eqRNaZMCDJZ37YoDFOIdp71/KNr8eve0IHuG8r8opm9FPqxqpyuf8Bgn7jaiNODorGf2C3xF+PhTm447siLClJaT9R/CMEXzU9bxAt1J+rvaiezp0gcF8bKDhZ9shr0DE+ac1LhAWgxBPjC+0OpC4BpOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTDd9hlp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4F7C4CED3;
	Fri, 18 Oct 2024 17:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729272426;
	bh=psG8/z/USQpSlbxCcVowNhZZ7cvZiKehgVTmZhOCEyw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QTDd9hlpVoMQPyzeYxBXGJRki/rxriJtsMpBOlNuhkXAr6YLghuJ1vRIdF+KD0v9X
	 b4oXqSQmodWKWA5PsihoZl8YSy9u0N5H+tuQ6sWo1ET+fcrtN8W+aRUx0kKRXyqliE
	 TzrS6Vys6wcmMhLj13cggruVBu1nbrNjpixr0PZvcatrY1GpQwqipPdbws/sfuoNeO
	 AWPE4c6w1hGIjF4Yy64G0+F32JJrgwZVQRP7TYk6cYJD7C7kuf3QQmLveQ1DkDNMeP
	 KuFOR/yxhvw11En0IYuHERgI6hrHbMMHK8adY0NwguZGytE5mxnakBwJLUMUl3oPA4
	 oQMJLD47i6R2g==
From: chrisl@kernel.org
Date: Fri, 18 Oct 2024 10:27:06 -0700
Subject: [PATCH 6.11.y v2 3/3] mm/codetag: add pgalloc_tag_copy()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-stable-yuzhao-v2-3-1fd556716eda@kernel.org>
References: <20241018-stable-yuzhao-v2-0-1fd556716eda@kernel.org>
In-Reply-To: <20241018-stable-yuzhao-v2-0-1fd556716eda@kernel.org>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, 
 Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Yu Zhao <yuzhao@google.com>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Kent Overstreet <kent.overstreet@linux.dev>, 
 Vlastimil Babka <vbabka@suse.cz>, Chris Li <chrisl@kernel.org>
X-Mailer: b4 0.13.0

From: Yu Zhao <yuzhao@google.com>

[ Upstream commit e0a955bf7f61cb034d228736d81c1ab3a47a3dca ]

Add pgalloc_tag_copy() to transfer the codetag from the old folio to the
new one during migration.  This makes original allocation sites persist
cross migration rather than lump into the get_new_folio callbacks passed
into migrate_pages(), e.g., compaction_alloc():

  # echo 1 >/proc/sys/vm/compact_memory
  # grep compaction_alloc /proc/allocinfo

Before this patch:
  132968448  32463  mm/compaction.c:1880 func:compaction_alloc

After this patch:
          0      0  mm/compaction.c:1880 func:compaction_alloc

Link: https://lkml.kernel.org/r/20240906042108.1150526-3-yuzhao@google.com
Fixes: dcfe378c81f7 ("lib: introduce support for page allocation tagging")
Signed-off-by: Yu Zhao <yuzhao@google.com>
Acked-by: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Chris Li <chrisl@kernel.org>
---
 include/linux/alloc_tag.h | 24 ++++++++++--------------
 include/linux/mm.h        | 27 +++++++++++++++++++++++++++
 mm/migrate.c              |  1 +
 3 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 8c61ccd161ba3..39a7fd60e389a 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -137,7 +137,16 @@ static inline void alloc_tag_sub_check(union codetag_ref *ref) {}
 /* Caller should verify both ref and tag to be valid */
 static inline void __alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag *tag)
 {
+	alloc_tag_add_check(ref, tag);
+	if (!ref || !tag)
+		return;
+
 	ref->ct = &tag->ct;
+}
+
+static inline void alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag *tag)
+{
+	__alloc_tag_ref_set(ref, tag);
 	/*
 	 * We need in increment the call counter every time we have a new
 	 * allocation or when we split a large allocation into smaller ones.
@@ -147,22 +156,9 @@ static inline void __alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag
 	this_cpu_inc(tag->counters->calls);
 }
 
-static inline void alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag *tag)
-{
-	alloc_tag_add_check(ref, tag);
-	if (!ref || !tag)
-		return;
-
-	__alloc_tag_ref_set(ref, tag);
-}
-
 static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag, size_t bytes)
 {
-	alloc_tag_add_check(ref, tag);
-	if (!ref || !tag)
-		return;
-
-	__alloc_tag_ref_set(ref, tag);
+	alloc_tag_ref_set(ref, tag);
 	this_cpu_add(tag->counters->bytes, bytes);
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8330363126918..a3a86fc407385 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4240,10 +4240,37 @@ static inline void pgalloc_tag_split(struct folio *folio, int old_order, int new
 		}
 	}
 }
+
+static inline void pgalloc_tag_copy(struct folio *new, struct folio *old)
+{
+	struct alloc_tag *tag;
+	union codetag_ref *ref;
+
+	tag = pgalloc_tag_get(&old->page);
+	if (!tag)
+		return;
+
+	ref = get_page_tag_ref(&new->page);
+	if (!ref)
+		return;
+
+	/* Clear the old ref to the original allocation tag. */
+	clear_page_tag_ref(&old->page);
+	/* Decrement the counters of the tag on get_new_folio. */
+	alloc_tag_sub(ref, folio_nr_pages(new));
+
+	__alloc_tag_ref_set(ref, tag);
+
+	put_page_tag_ref(ref);
+}
 #else /* !CONFIG_MEM_ALLOC_PROFILING */
 static inline void pgalloc_tag_split(struct folio *folio, int old_order, int new_order)
 {
 }
+
+static inline void pgalloc_tag_copy(struct folio *new, struct folio *old)
+{
+}
 #endif /* CONFIG_MEM_ALLOC_PROFILING */
 
 #endif /* _LINUX_MM_H */
diff --git a/mm/migrate.c b/mm/migrate.c
index 368ab3878fa6e..028282b28242e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -666,6 +666,7 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 		folio_set_readahead(newfolio);
 
 	folio_copy_owner(newfolio, folio);
+	pgalloc_tag_copy(newfolio, folio);
 
 	mem_cgroup_migrate(folio, newfolio);
 }

-- 
2.47.0.rc1.288.g06298d1525-goog


