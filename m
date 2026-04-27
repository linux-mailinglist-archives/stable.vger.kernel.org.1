Return-Path: <stable+bounces-241406-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMBRC7aT72ktDAEAu9opvQ
	(envelope-from <stable+bounces-241406-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:49:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BAB476AB3
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0525D300A63D
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 16:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CE83C73EA;
	Mon, 27 Apr 2026 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I8+DvHf5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C7E37C927
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777308240; cv=none; b=uKrsyG6w2I7eoQflX6mzwWOP+Ejz6uGM34ERT5PZ2QjbZ/4lVBDhwopEabjruwWXr325JKHxYDGs09Zgnvo/11wYjQz6NCAQMBbwjSpc6lyBjJIl65CVPuRmG9jAtQwdTh6zqZYHa4rc6OQSNWWyJfS8gdj8qk2mPKGcvLDljs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777308240; c=relaxed/simple;
	bh=rvs/NnYVzNhcY62vgmE0zDl+jNVKTXSAO6NUirDatI8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=febYQnnpXxkYlcgpsk00QGE4Bv4j821NrqKfxntYgHx5RG4nxzu7FpQktu4LxnRsRbu0GYXkQgVHaNoxjZdD9OpK1V/qCq3J6Vtoupf/I1JbCM+Iq54d2ZDGo96dN52uzybbqRMnwO+ECOb9SsxLlB4JUSko+vBlbeXskykrzl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I8+DvHf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4DEC19425;
	Mon, 27 Apr 2026 16:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777308239;
	bh=rvs/NnYVzNhcY62vgmE0zDl+jNVKTXSAO6NUirDatI8=;
	h=Subject:To:Cc:From:Date:From;
	b=I8+DvHf5kjDGPVccl9C6oTGn/C7pgiRpjjxjWWzHmSvwLky12HPIyKS3sRV+Dzzwf
	 +C8sPvtzB8nAy8IWAgNgwswIe/qg6NxCO3Ygh4QHRE0j/57tn3uB3Ut7cZMT/1OG6B
	 WDQkwcX/T/zCgZOaNT4IrISh/5h6gYu5VbVe42uw=
Subject: FAILED: patch "[PATCH] mm: migrate: requeue destination folio on deferred split" failed to apply to 6.12-stable tree
To: usama.arif@linux.dev,akpm@linux-foundation.org,apopple@nvidia.com,byungchul@sk.com,david@kernel.org,gourry@gourry.net,hannes@cmpxchg.org,joshua.hahnjy@gmail.com,matthew.brost@intel.com,npache@redhat.com,rakie.kim@sk.com,richard.weiyang@gmail.com,sj@kernel.org,stable@vger.kernel.org,willy@infradead.org,ying.huang@linux.alibaba.com,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 27 Apr 2026 10:43:23 -0600
Message-ID: <2026042723-large-sedan-f63a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 81BAB476AB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241406-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,linux-foundation.org,nvidia.com,sk.com,kernel.org,gourry.net,cmpxchg.org,gmail.com,intel.com,redhat.com,vger.kernel.org,infradead.org,linux.alibaba.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a2e0c0668a3486f96b86c50e02872c8e94fd4f9c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042723-large-sedan-f63a@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a2e0c0668a3486f96b86c50e02872c8e94fd4f9c Mon Sep 17 00:00:00 2001
From: Usama Arif <usama.arif@linux.dev>
Date: Thu, 12 Mar 2026 03:47:23 -0700
Subject: [PATCH] mm: migrate: requeue destination folio on deferred split
 queue

During folio migration, __folio_migrate_mapping() removes the source folio
from the deferred split queue, but the destination folio is never
re-queued.  This causes underutilized THPs to escape the shrinker after
NUMA migration, since they silently drop off the deferred split list.

Fix this by recording whether the source folio was on the deferred split
queue and its partially mapped state before move_to_new_folio() unqueues
it, and re-queuing the destination folio after a successful migration if
it was.

By the time migrate_folio_move() runs, partially mapped folios without a
pin have already been split by migrate_pages_batch().  So only two cases
remain on the deferred list at this point:
  1. Partially mapped folios with a pin (split failed).
  2. Fully mapped but potentially underused folios.  The recorded
     partially_mapped state is forwarded to deferred_split_folio() so that
     the destination folio is correctly re-queued in both cases.

Because THPs are removed from the deferred_list, THP shinker cannot
split the underutilized THPs in time.  As a result, users will show
less free memory than before.

Link: https://lkml.kernel.org/r/20260312104723.1351321-1-usama.arif@linux.dev
Fixes: dafff3f4c850 ("mm: split underused THPs")
Signed-off-by: Usama Arif <usama.arif@linux.dev>
Reported-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Nico Pache <npache@redhat.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Ying Huang <ying.huang@linux.alibaba.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/migrate.c b/mm/migrate.c
index 6cc654858da6..3323fc96b1cd 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1358,6 +1358,8 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 	int rc;
 	int old_page_state = 0;
 	struct anon_vma *anon_vma = NULL;
+	bool src_deferred_split = false;
+	bool src_partially_mapped = false;
 	struct list_head *prev;
 
 	__migrate_folio_extract(dst, &old_page_state, &anon_vma);
@@ -1371,6 +1373,12 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 		goto out_unlock_both;
 	}
 
+	if (folio_order(src) > 1 &&
+	    !data_race(list_empty(&src->_deferred_list))) {
+		src_deferred_split = true;
+		src_partially_mapped = folio_test_partially_mapped(src);
+	}
+
 	rc = move_to_new_folio(dst, src, mode);
 	if (rc)
 		goto out;
@@ -1391,6 +1399,15 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 	if (old_page_state & PAGE_WAS_MAPPED)
 		remove_migration_ptes(src, dst, 0);
 
+	/*
+	 * Requeue the destination folio on the deferred split queue if
+	 * the source was on the queue.  The source is unqueued in
+	 * __folio_migrate_mapping(), so we recorded the state from
+	 * before move_to_new_folio().
+	 */
+	if (src_deferred_split)
+		deferred_split_folio(dst, src_partially_mapped);
+
 out_unlock_both:
 	folio_unlock(dst);
 	folio_set_owner_migrate_reason(dst, reason);


