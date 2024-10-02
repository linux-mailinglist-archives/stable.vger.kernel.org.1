Return-Path: <stable+bounces-78617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C2B98D0D8
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 12:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC17D1C21848
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 10:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338631E493F;
	Wed,  2 Oct 2024 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1ciYpPwi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CF91FA5
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 10:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727863757; cv=none; b=QYsfUVy8WatpdtmRAqUFRJahZqCkNZ7uSzghZwKeQz3i0RcOdMP3w8YcwKAJ0+NePRqbUPkrgpys3zowOt/NMJ363RoiZ3LwBRQcszX3dEkcLytMUY2MJdPd/hEv1AIDiZhoz7Nl9itu9LNQlUT0QI5dSCLIbeQTc/bEHsUAH3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727863757; c=relaxed/simple;
	bh=OOaJbhvvnCb4lpQfp5DGxMK489Rr0VhrvjrhtBOxBXQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=j9PsuCMe1F5mgbex2gFZI7wbpKImNzLfyCPGVS92J7c9Tvs7kOfBbRT3MJhhvG6340AiYU0+7ZedHGEQxqEiJ+h1oB0MtiS7ujztnHhomned1IlZkMqzV9lvNB5QAqEtWAlBSQjWcseMmw7ke87z2qkpjvSfEBVYhOY3jdPnabs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1ciYpPwi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F42C4CEC5;
	Wed,  2 Oct 2024 10:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727863756;
	bh=OOaJbhvvnCb4lpQfp5DGxMK489Rr0VhrvjrhtBOxBXQ=;
	h=Subject:To:Cc:From:Date:From;
	b=1ciYpPwiUeWb/egt3b2wqlxt6CwtW9CcXQR9HtATRI0gjclLVFli/bsVOahkLtGBs
	 9ekPGzSNxuVOg1m2P0eiRnhutpGOyd3XY/vemkpvfRFRs31IXdSHNqdgmA0sc6Fg5r
	 f1rPY5jR8Au7xM2db92XfOkWMJkOjdwVrUNGF6YE=
Subject: FAILED: patch "[PATCH] mm/codetag: add pgalloc_tag_copy()" failed to apply to 6.11-stable tree
To: yuzhao@google.com,akpm@linux-foundation.org,kent.overstreet@linux.dev,muchun.song@linux.dev,stable@vger.kernel.org,surenb@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 02 Oct 2024 12:09:10 +0200
Message-ID: <2024100210-untie-oven-64d6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.11-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
git checkout FETCH_HEAD
git cherry-pick -x e0a955bf7f61cb034d228736d81c1ab3a47a3dca
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100210-untie-oven-64d6@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..

Possible dependencies:

e0a955bf7f61 ("mm/codetag: add pgalloc_tag_copy()")
95599ef684d0 ("mm/codetag: fix pgalloc_tag_split()")
cf54f310d0d3 ("mm/hugetlb: use __GFP_COMP for gigantic folios")
c0f398c3b2cf ("mm/hugetlb_vmemmap: batch HVO work when demoting")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e0a955bf7f61cb034d228736d81c1ab3a47a3dca Mon Sep 17 00:00:00 2001
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 5 Sep 2024 22:21:08 -0600
Subject: [PATCH] mm/codetag: add pgalloc_tag_copy()

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

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 896491d9ebe8..1f0a9ff23a2c 100644
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
index 6bb778cbaabf..39f6faace590 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4108,10 +4108,37 @@ static inline void pgalloc_tag_split(struct folio *folio, int old_order, int new
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
index 0f6b78fd73aa..dfdb3a136bf8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -743,6 +743,7 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 		folio_set_readahead(newfolio);
 
 	folio_copy_owner(newfolio, folio);
+	pgalloc_tag_copy(newfolio, folio);
 
 	mem_cgroup_migrate(folio, newfolio);
 }


