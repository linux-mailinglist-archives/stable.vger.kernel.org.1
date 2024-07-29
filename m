Return-Path: <stable+bounces-62367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A8693EE58
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B262815EF
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 07:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B128002A;
	Mon, 29 Jul 2024 07:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WLN9UtL2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14E66A8DB
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722237581; cv=none; b=sHB+/lN/rM7BrK896oZu7Znzi69NyyhuRotFh+IKCguTtwTDaJZ1CoWgA7I7HJwa3SddO1lQJKAbgVN3KfMSKqAjAOP2pkB0AA4zNCW8eZ1UhkgqVoijOxUcitK0ILbhfCAgiAKct4Po9gI4reNYYj89a0CFVOWqLiBNBS6+/GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722237581; c=relaxed/simple;
	bh=AX4q8RivPU1r2MhCa+VHpo0evUCI91pSeJyPvHR5+Lk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mKtgo8bUt4Lxsn2QqKrLBDYRIOKVyhDkbG2s5TShNnC6fG2RQyFVM5h/by4IsyLOcKVkJ2dlLxcPjYyLoiqusr86fHEtQ8FDDxnSq/wZUWLdXk/Vq+H/J4ZgBKV+ds9B8ZrHjFo7DB0xSmVHPDzopTXi/iA3mt5GU94ywQ1eFBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WLN9UtL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F388CC32786;
	Mon, 29 Jul 2024 07:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722237580;
	bh=AX4q8RivPU1r2MhCa+VHpo0evUCI91pSeJyPvHR5+Lk=;
	h=Subject:To:Cc:From:Date:From;
	b=WLN9UtL2Ymelz+TgFBQ4Mz53rXvRZ86nTGqM7FMjd7rcZJLu8Fhxg2zK2TPmQmLuM
	 f+IwKXOxpRo5XrWLV+7AM2vI6vyNyqdx7tVF5mkQrSayPX/499VWmeGk8SkyRidBj8
	 QQJtZrnyWC1oZP8SIU4+DnOYlviXCxQvFb2BZibI=
Subject: FAILED: patch "[PATCH] mm/migrate: putback split folios when numa hint migration" failed to apply to 6.10-stable tree
To: peterx@redhat.com,akpm@linux-foundation.org,baolin.wang@linux.alibaba.com,david@redhat.com,hughd@google.com,shy828301@gmail.com,stable@vger.kernel.org,ying.huang@intel.com,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 09:19:37 +0200
Message-ID: <2024072937-aloe-fog-7fc4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6e49019db5f7a09a9c0e8ac4d108e656c3f8e583
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072937-aloe-fog-7fc4@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

6e49019db5f7 ("mm/migrate: putback split folios when numa hint migration fails")
ee86814b0562 ("mm/migrate: move NUMA hinting fault folio isolation + checks under PTL")
4b88c23ab8c9 ("mm/migrate: make migrate_misplaced_folio() return 0 on success")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6e49019db5f7a09a9c0e8ac4d108e656c3f8e583 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Mon, 8 Jul 2024 17:55:37 -0400
Subject: [PATCH] mm/migrate: putback split folios when numa hint migration
 fails

This issue is not from any report yet, but by code observation only.

This is yet another fix besides Hugh's patch [1] but on relevant code
path, where eager split of folio can happen if the folio is already on
deferred list during a folio migration.

Here the issue is NUMA path (migrate_misplaced_folio()) may start to
encounter such folio split now even with MR_NUMA_MISPLACED hint applied.
Then when migrate_pages() didn't migrate all the folios, it's possible the
split small folios be put onto the list instead of the original folio.
Then putting back only the head page won't be enough.

Fix it by putting back all the folios on the list.

[1] https://lore.kernel.org/all/46c948b4-4dd8-6e03-4c7b-ce4e81cfa536@google.com/

[akpm@linux-foundation.org: remove now unused local `nr_pages']
Link: https://lkml.kernel.org/r/20240708215537.2630610-1-peterx@redhat.com
Fixes: 7262f208ca68 ("mm/migrate: split source folio if it is on deferred split list")
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/migrate.c b/mm/migrate.c
index 6eb9df239230..bdbb5bb04c91 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2621,20 +2621,13 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
 	int nr_remaining;
 	unsigned int nr_succeeded;
 	LIST_HEAD(migratepages);
-	int nr_pages = folio_nr_pages(folio);
 
 	list_add(&folio->lru, &migratepages);
 	nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_folio,
 				     NULL, node, MIGRATE_ASYNC,
 				     MR_NUMA_MISPLACED, &nr_succeeded);
-	if (nr_remaining) {
-		if (!list_empty(&migratepages)) {
-			list_del(&folio->lru);
-			node_stat_mod_folio(folio, NR_ISOLATED_ANON +
-					folio_is_file_lru(folio), -nr_pages);
-			folio_putback_lru(folio);
-		}
-	}
+	if (nr_remaining && !list_empty(&migratepages))
+		putback_movable_pages(&migratepages);
 	if (nr_succeeded) {
 		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
 		if (!node_is_toptier(folio_nid(folio)) && node_is_toptier(node))


