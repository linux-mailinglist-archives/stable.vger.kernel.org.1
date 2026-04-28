Return-Path: <stable+bounces-241694-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MxXMpTR8GmRZAEAu9opvQ
	(envelope-from <stable+bounces-241694-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 17:26:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AFD487CB2
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 17:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02386305C4A5
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 15:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6D637C11A;
	Tue, 28 Apr 2026 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpg0lUsG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C0E2FFF99
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777389865; cv=none; b=F9MDd6GioBA4o4DN7a1/wHDzdZBZMnzRWuN+u1/eyfNZoHtIBnrswa2fK71jBzgCjcH2VCQWQ3R2kUcLlgesy+Sp1ue/EgUEmc7cPXBN43Bzvx1j0NrhN09GGkam/IuHoO31MKlaIPNt4c1iTI2RqwumHmxp2s170EpyMkY8B48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777389865; c=relaxed/simple;
	bh=r/SUcFvLKFcKJXPf2S/wi34hKwqFi7re0vfV3HpqjEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/zJFa9zW+5XPaUn4mvOxCruX1TnYAoQk5eEao6oBLiy2KAjINK3u7lrME97xprM9vQTjlXs6fGU7iNtYe18ac9jzzOFUrtAZ09IURotf42q7TLfX+pmdQaQ9xy2O7o8jq0pBedqeUT1Aumwtokxrjaee5BFknH5+9m6NCX00KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpg0lUsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F1BC2BCB7;
	Tue, 28 Apr 2026 15:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777389865;
	bh=r/SUcFvLKFcKJXPf2S/wi34hKwqFi7re0vfV3HpqjEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dpg0lUsG7DapB/oCVobC5TRA9Am3g8Lb3FHhtRH1+4sivEeI8qanzJo5mTDZv6GfE
	 hMIGDkuYUkRhqtff6JkQvaI0UUuM7radgyCx819RHyXjgETI8az+7uCLQg56uoyX7O
	 21buq7kcsTbEDCnY9NhZhBQvFqfhWXVBY3P0atFf1JZ6/T+KrwXULIYKBQ+xRvOf5b
	 mZLiDBRpVKywywPQaXuodhqz8sf5D2/VJmilBfJNREo9V5wvVRIpR2k8AnwW5659Tw
	 xHCIrdDlnkbpvP4T4PrV+qtsnEYbVgfNEPih7XX+yFfdtzaa9JEFXHnZQYYMFoR+xd
	 61aJcSGl1nA4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Usama Arif <usama.arif@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	SeongJae Park <sj@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Nico Pache <npache@redhat.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] mm: migrate: requeue destination folio on deferred split queue
Date: Tue, 28 Apr 2026 11:24:12 -0400
Message-ID: <20260428152412.3034119-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428152412.3034119-1-sashal@kernel.org>
References: <2026042723-large-sedan-f63a@gregkh>
 <20260428152412.3034119-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 04AFD487CB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,cmpxchg.org,nvidia.com,kernel.org,gmail.com,sk.com,gourry.net,linux.alibaba.com,intel.com,infradead.org,redhat.com,linux-foundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-241694-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.969];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Usama Arif <usama.arif@linux.dev>

[ Upstream commit a2e0c0668a3486f96b86c50e02872c8e94fd4f9c ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/migrate.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index d541612c7377d..f3d1dc8d72b78 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1345,6 +1345,8 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 	int rc;
 	int old_page_state = 0;
 	struct anon_vma *anon_vma = NULL;
+	bool src_deferred_split = false;
+	bool src_partially_mapped = false;
 	struct list_head *prev;
 
 	__migrate_folio_extract(dst, &old_page_state, &anon_vma);
@@ -1358,6 +1360,12 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
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
@@ -1378,6 +1386,15 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
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
 	set_page_owner_migrate_reason(&dst->page, reason);
-- 
2.53.0


