Return-Path: <stable+bounces-232877-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OKRJhapzWmvfgYAu9opvQ
	(envelope-from <stable+bounces-232877-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 01:24:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2603381A75
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 01:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FD9930329AB
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 23:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A748377EDC;
	Wed,  1 Apr 2026 23:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TMkszWqQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C488364EBA;
	Wed,  1 Apr 2026 23:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775085600; cv=none; b=FV79Rv8LhhXhFcFyJye7oMIglSO7dmNvvKranxHdpXNU0BANktEAo/2hS6m8Ra82bz6ovYP/OJQHSAXIBC2lKGG+lAcOLte3Yzwhyh31Ux2C4wcKrvswvLZsOwfOUjjN7PiOItxXNZYUX3P7vgIlwLbxKdV7fslohlzGLd+KvX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775085600; c=relaxed/simple;
	bh=tE1I6QqGm0tUZMScDuiyoHJK4m2GtY03FdDFEhbLMBY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=G7ymlKqh0PxbxrCD6Bbc8JGDbpH7ol0tQE3Kl7AI46z63cSEY3WqoCHxDikNY1UtV5ZGj2CMehM6n2DX+VYue8bFAHwKpQ9PZCQtFfzXdFWrZ0rvlV2TCfDDBS6l4Xn/OKTwbPyNhkm6up6kZ+S1q3YMw4FPOUr7qIY6Unmo5+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TMkszWqQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26513C4CEF7;
	Wed,  1 Apr 2026 23:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775085599;
	bh=tE1I6QqGm0tUZMScDuiyoHJK4m2GtY03FdDFEhbLMBY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TMkszWqQ7EaxmW4yhB5tGTUs1Tu1rc9aZVXZf/+1lHc2CQMdR/Sj2aa5QxfsWKMek
	 q8cphQkovBOxKE2l+OpHWdUv4ypVBEJazmcOs28A8oWpZiCKQZuo+CP9I48bHJr5//
	 FuuUX/5PKBn69LPTQbyXt1dHX7yLJXElk7f72hws=
Date: Wed, 1 Apr 2026 16:19:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Lance Yang <lance.yang@linux.dev>, david@kernel.org, ljs@kernel.org,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, richard.weiyang@gmail.com, usama.arif@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kartikey406@gmail.com,
 syzbot+a7067a757858ac8eb085@syzkaller.appspotmail.com,
 stable@vger.kernel.org
Subject: Re: [PATCH mm-unstable 1/1] mm: fix deferred split queue races
 during migration
Message-Id: <20260401161958.38ab50f44e7629e6475d3eca@linux-foundation.org>
In-Reply-To: <FB71A764-0F10-4E5A-B4A0-BA4C7F138408@nvidia.com>
References: <20260401131032.13011-1-lance.yang@linux.dev>
	<C4A8301D-C76B-430B-A6A6-8B642B80FE2E@nvidia.com>
	<FB71A764-0F10-4E5A-B4A0-BA4C7F138408@nvidia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232877-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,linux.alibaba.com,oracle.com,redhat.com,arm.com,intel.com,gmail.com,sk.com,gourry.net,nvidia.com,kvack.org,vger.kernel.org,syzkaller.appspotmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,a7067a757858ac8eb085];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F2603381A75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 01 Apr 2026 18:55:48 -0400 Zi Yan <ziy@nvidia.com> wrote:

> Can you apply the fixup below to move the comment? Lance told me he
> would be away for a while, so he could not send a fixup to move
> the comment.

Thanks.  I folded that into Lance's base patch so here's the whole
thing:



From: Lance Yang <lance.yang@linux.dev>
Subject: mm: fix deferred split queue races during migration
Date: Wed, 1 Apr 2026 21:10:32 +0800

migrate_folio_move() records the deferred split queue state from src and
replays it on dst.  Replaying it after remove_migration_ptes(src, dst, 0)
makes dst visible before it is requeued, so a concurrent rmap-removal path
can mark dst partially mapped and trip the WARN in deferred_split_folio().

Move the requeue before remove_migration_ptes() so dst is back on the
deferred split queue before it becomes visible again.

Because migration still holds dst locked at that point, teach
deferred_split_scan() to requeue a folio when folio_trylock() fails. 
Otherwise a fully mapped underused folio can be dequeued by the shrinker
and silently lost from split_queue.

[ziy@nvidia.com: move the comment]
  Link: https://lkml.kernel.org/r/FB71A764-0F10-4E5A-B4A0-BA4C7F138408@nvidia.com
Link: https://syzkaller.appspot.com/bug?extid=a7067a757858ac8eb085
Link: https://lkml.kernel.org/r/20260401131032.13011-1-lance.yang@linux.dev
Fixes: 8a8ca142a488 ("mm: migrate: requeue destination folio on deferred split queue")
Signed-off-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reported-by: syzbot+a7067a757858ac8eb085@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-mm/69ccb65b.050a0220.183828.003a.GAE@google.com/
Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Zi Yan <ziy@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Byungchul Park <byungchul@sk.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Ying Huang <ying.huang@linux.alibaba.com>
Cc: Usama Arif <usama.arif@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/huge_memory.c |   15 ++++++++++-----
 mm/migrate.c     |   18 +++++++++---------
 2 files changed, 19 insertions(+), 14 deletions(-)

--- a/mm/huge_memory.c~mm-fix-deferred-split-queue-races-during-migration
+++ a/mm/huge_memory.c
@@ -4542,7 +4542,7 @@ retry:
 				goto next;
 		}
 		if (!folio_trylock(folio))
-			goto next;
+			goto requeue;
 		if (!split_folio(folio)) {
 			did_split = true;
 			if (underused)
@@ -4551,13 +4551,18 @@ retry:
 		}
 		folio_unlock(folio);
 next:
+		/*
+		 * If thp_underused() returns false, or if split_folio()
+		 * succeeds, or if split_folio() fails in the case it was
+		 * underused, then consider it used and don't add it back to
+		 * split_queue.
+		 */
 		if (did_split || !folio_test_partially_mapped(folio))
 			continue;
+requeue:
 		/*
-		 * Only add back to the queue if folio is partially mapped.
-		 * If thp_underused returns false, or if split_folio fails
-		 * in the case it was underused, then consider it used and
-		 * don't add it back to split_queue.
+		 * Add back partially mapped folios, or underused folios that
+		 * we could not lock this round.
 		 */
 		fqueue = folio_split_queue_lock_irqsave(folio, &flags);
 		if (list_empty(&folio->_deferred_list)) {
--- a/mm/migrate.c~mm-fix-deferred-split-queue-races-during-migration
+++ a/mm/migrate.c
@@ -1384,6 +1384,15 @@ static int migrate_folio_move(free_folio
 		goto out;
 
 	/*
+	 * Requeue the destination folio on the deferred split queue if
+	 * the source was on the queue.  The source is unqueued in
+	 * __folio_migrate_mapping(), so we recorded the state from
+	 * before move_to_new_folio().
+	 */
+	if (src_deferred_split)
+		deferred_split_folio(dst, src_partially_mapped);
+
+	/*
 	 * When successful, push dst to LRU immediately: so that if it
 	 * turns out to be an mlocked page, remove_migration_ptes() will
 	 * automatically build up the correct dst->mlock_count for it.
@@ -1399,15 +1408,6 @@ static int migrate_folio_move(free_folio
 	if (old_page_state & PAGE_WAS_MAPPED)
 		remove_migration_ptes(src, dst, 0);
 
-	/*
-	 * Requeue the destination folio on the deferred split queue if
-	 * the source was on the queue.  The source is unqueued in
-	 * __folio_migrate_mapping(), so we recorded the state from
-	 * before move_to_new_folio().
-	 */
-	if (src_deferred_split)
-		deferred_split_folio(dst, src_partially_mapped);
-
 out_unlock_both:
 	folio_unlock(dst);
 	folio_set_owner_migrate_reason(dst, reason);
_


