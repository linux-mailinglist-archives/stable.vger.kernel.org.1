Return-Path: <stable+bounces-195334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3BDC75576
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E13D54E32E9
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC6E32D425;
	Thu, 20 Nov 2025 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H4YCyUS4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C7835CB8D
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763655232; cv=none; b=JJaXO1l65+vSWyE0+185NkSSYqv3YDGcmmCBNfi1y54U5xPGuy3ehlcCzWK/F7VN3fVl1yLNLGF3oGs1SIuCoM7yvDKOhHDPLvuUN0vvMcyRGEYrgPJF9u7X21jErquOVx8HQAkfa9lWfC5saV1HpjeGUa5oz9ljhq3BHG/ve0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763655232; c=relaxed/simple;
	bh=9zYIFmn3ZPLnYE6V2CFEB6VZJJuAmf3CqtYU87IMKjc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=C5+ms1V4NEoWQ8trKRHUhPthnw69LQlpc7i1LwckKGXVr5NsM7mxLgJGQbSC7BmrJF284YaYQoh6Ypd3PK9rUhWXsWDZm1RtDRjGbJCo0hyFYxeZIsBDmMweCA+VdUveBUE7GNgoezePIVHFKfmvpHaTrWFu1hpbWYO+anQ3fD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H4YCyUS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6140AC4CEF1;
	Thu, 20 Nov 2025 16:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763655231;
	bh=9zYIFmn3ZPLnYE6V2CFEB6VZJJuAmf3CqtYU87IMKjc=;
	h=Subject:To:Cc:From:Date:From;
	b=H4YCyUS4S3XieW0SyaSV0LsJRtEg9jNyCMc2hOM4TY8/9AmQB9c7HceCV5Jgcm3XO
	 KXCbbhMCnywFZI4l1T8DBGr0XfdjX8VB0t8ptVezKSutyONkbMGQZYq2Hh1S9ScJ8K
	 AZglwQpr5oGNSa4p6Iobk51jflMRQ0mmnlSwWHNA=
Subject: FAILED: patch "[PATCH] mm/truncate: unmap large folio on split failure" failed to apply to 5.15-stable tree
To: kas@kernel.org,akpm@linux-foundation.org,baolin.wang@linux.alibaba.com,brauner@kernel.org,david@fromorbit.com,david@redhat.com,djwong@kernel.org,hannes@cmpxchg.org,hughd@google.com,liam.howlett@oracle.com,lorenzo.stoakes@oracle.com,mhocko@suse.com,riel@surriel.com,rppt@kernel.org,shakeel.butt@linux.dev,stable@vger.kernel.org,surenb@google.com,vbabka@suse.cz,viro@zeniv.linux.org.uk,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 17:13:40 +0100
Message-ID: <2025112040-stucco-landed-445c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x fa04f5b60fda62c98a53a60de3a1e763f11feb41
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112040-stucco-landed-445c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fa04f5b60fda62c98a53a60de3a1e763f11feb41 Mon Sep 17 00:00:00 2001
From: Kiryl Shutsemau <kas@kernel.org>
Date: Mon, 27 Oct 2025 11:56:36 +0000
Subject: [PATCH] mm/truncate: unmap large folio on split failure

Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
supposed to generate SIGBUS.

This behavior might not be respected on truncation.

During truncation, the kernel splits a large folio in order to reclaim
memory.  As a side effect, it unmaps the folio and destroys PMD mappings
of the folio.  The folio will be refaulted as PTEs and SIGBUS semantics
are preserved.

However, if the split fails, PMD mappings are preserved and the user will
not receive SIGBUS on any accesses within the PMD.

Unmap the folio on split failure.  It will lead to refault as PTEs and
preserve SIGBUS semantics.

Make an exception for shmem/tmpfs that for long time intentionally mapped
with PMDs across i_size.

Link: https://lkml.kernel.org/r/20251027115636.82382-3-kirill@shutemov.name
Fixes: b9a8a4195c7d ("truncate,shmem: Handle truncates that split large folios")
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/truncate.c b/mm/truncate.c
index 9210cf808f5c..3c5a50ae3274 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -177,6 +177,32 @@ int truncate_inode_folio(struct address_space *mapping, struct folio *folio)
 	return 0;
 }
 
+static int try_folio_split_or_unmap(struct folio *folio, struct page *split_at,
+				    unsigned long min_order)
+{
+	enum ttu_flags ttu_flags =
+		TTU_SYNC |
+		TTU_SPLIT_HUGE_PMD |
+		TTU_IGNORE_MLOCK;
+	int ret;
+
+	ret = try_folio_split_to_order(folio, split_at, min_order);
+
+	/*
+	 * If the split fails, unmap the folio, so it will be refaulted
+	 * with PTEs to respect SIGBUS semantics.
+	 *
+	 * Make an exception for shmem/tmpfs that for long time
+	 * intentionally mapped with PMDs across i_size.
+	 */
+	if (ret && !shmem_mapping(folio->mapping)) {
+		try_to_unmap(folio, ttu_flags);
+		WARN_ON(folio_mapped(folio));
+	}
+
+	return ret;
+}
+
 /*
  * Handle partial folios.  The folio may be entirely within the
  * range if a split has raced with us.  If not, we zero the part of the
@@ -226,7 +252,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 
 	min_order = mapping_min_folio_order(folio->mapping);
 	split_at = folio_page(folio, PAGE_ALIGN_DOWN(offset) / PAGE_SIZE);
-	if (!try_folio_split_to_order(folio, split_at, min_order)) {
+	if (!try_folio_split_or_unmap(folio, split_at, min_order)) {
 		/*
 		 * try to split at offset + length to make sure folios within
 		 * the range can be dropped, especially to avoid memory waste
@@ -250,13 +276,10 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 		if (!folio_trylock(folio2))
 			goto out;
 
-		/*
-		 * make sure folio2 is large and does not change its mapping.
-		 * Its split result does not matter here.
-		 */
+		/* make sure folio2 is large and does not change its mapping */
 		if (folio_test_large(folio2) &&
 		    folio2->mapping == folio->mapping)
-			try_folio_split_to_order(folio2, split_at2, min_order);
+			try_folio_split_or_unmap(folio2, split_at2, min_order);
 
 		folio_unlock(folio2);
 out:


