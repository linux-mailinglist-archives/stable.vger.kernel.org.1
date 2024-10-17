Return-Path: <stable+bounces-86724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B24B19A316F
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 01:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681A11F22D1C
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 23:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B115920E313;
	Thu, 17 Oct 2024 23:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcRs+/vi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9E120E30E
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 23:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729208139; cv=none; b=kKwXvTCOpHd/jru6dG5hu5MX6XBM/Xjk6y7AqioapTmKDuS2sIk6cwnVm/CiL6MJWSSuLupTfayX2144vc5Gw62REMV5oDdrec0i0WkleDLy1NeA8eZ4xgM5KDjoTRhJUnW+bx3wBxznNLFrPRiu8jGvCA+s1Vgj5MsbqlixK8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729208139; c=relaxed/simple;
	bh=5m05mP2lmk4FplchHiboxDo1t+0ydnJgh6wVvBZp+SQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W2liH10qkYlBx2XtoeQ/9j6Aqyc6vRQFLyh3Hx5m9C4W4vgN+D3rcRT6DGmLfFRov+4LwNlzOsslHS2msK3qV0jwSOZZqCu6v6xBl8crLjV7CEIZQ4JAHxJIYR+/xvEU7H4WDXwQMyEb0WqoUHdBn8T1NME7tKd53E2o5cPQ5ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcRs+/vi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A117C4CED2;
	Thu, 17 Oct 2024 23:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729208139;
	bh=5m05mP2lmk4FplchHiboxDo1t+0ydnJgh6wVvBZp+SQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tcRs+/viyiYqg6Hcn0mn4qQObsz5h/13sTPwcqKbZs4wyZ8aRv00Y/R86u+OKbGnj
	 bymzzj0TdnMQSiDkJ2bkljJmyoXjdKFuX90Rpm6KUKPFBJxdIiOLCiEMWqKWBcFcm+
	 JqwRZvxzK84dHCPT8iaUdwfvyOQqA9Xo+Gi/dMpDJhWKdVYndig522jwvUsCl9aUoK
	 P3mzV5YMoCbGoNlUUwpjb5QtrrL2ZG5bLWSpGb5PDYc5+EVZyJAk40hxE9Q/mQvmjJ
	 K20mbLnXlAo6Ci6EJDWB6Va4g5KdSXb0XqXUSNSeQgRtPQgig1vpzhlO1lZyWEdEdw
	 +3AQpSInsj4jw==
From: chrisl@kernel.org
Date: Thu, 17 Oct 2024 16:35:38 -0700
Subject: [PATCH 6.10.y 3/3] mm/codetag: add pgalloc_tag_copy()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-stable-yuzhao-6.10-v1-3-4827ff1e64ce@kernel.org>
References: <20241017-stable-yuzhao-6.10-v1-0-4827ff1e64ce@kernel.org>
In-Reply-To: <20241017-stable-yuzhao-6.10-v1-0-4827ff1e64ce@kernel.org>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, 
 Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Yu Zhao <yuzhao@google.com>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Kent Overstreet <kent.overstreet@linux.dev>, 
 Vlastimil Babka <vbabka@suse.cz>
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
index a7783b57c90eb..f26caad370803 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4288,10 +4288,37 @@ static inline void pgalloc_tag_split(struct folio *folio, int old_order, int new
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
index 817019be89365..b31603ca3d93a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -655,6 +655,7 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 		folio_set_readahead(newfolio);
 
 	folio_copy_owner(newfolio, folio);
+	pgalloc_tag_copy(newfolio, folio);
 
 	mem_cgroup_migrate(folio, newfolio);
 }

-- 
2.47.0.rc1.288.g06298d1525-goog


