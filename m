Return-Path: <stable+bounces-231405-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEwaMR60y2kpKAYAu9opvQ
	(envelope-from <stable+bounces-231405-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:46:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 137C1369064
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 897DE3078291
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF4D3D6CC4;
	Tue, 31 Mar 2026 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZYa3VPH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7B6371040
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774957149; cv=none; b=QcRtOaTTggCAr2p+mTBQfGwoCqw6KGxuD9Zvbfj0Scqw/R3hDZ33N+tRLxUdd4djOIZik2JflYtRg9X/gCr+AnY0d7IfyxIT43yCXHA4ajcJ/hAJeYm4AVtD8xYeQZsy98OtcD5QRqT72ItYruGF4l8JB4bkMh2bWlscDwFdnws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774957149; c=relaxed/simple;
	bh=9TVsGpRL6+MN3e1y5lPWhM/OGbwY7tdezVxx7EO5ug8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXAB/MsbzePZB/WSGsBDvt0gGjhkM9GUy/pnEah8VQgZ7IXULotkAMhaERHONGqWGJfYzNjCrNr2PjS6Ehj+LHgFku5UhGYGFQYPk8yFkfIIbuYBD1g0+ApErlQOK3wE+MlkTtu3DmTRx7Gft6JIjTgG8WQb/MAPgn+a7zNKkR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZYa3VPH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97FBC19423;
	Tue, 31 Mar 2026 11:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774957149;
	bh=9TVsGpRL6+MN3e1y5lPWhM/OGbwY7tdezVxx7EO5ug8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HZYa3VPHcJnsLB506fvFBfNovyHwUpJkgN/wAgVrF+W5y7/Bx5MP7OKs8wDRfN+R4
	 E0zHJY7zdgjZi2RcpzOUKlTVEexqGxU2xEfrGMvutBaqWGxP3ZPvBH66J5QBGEtAGt
	 kJTKTay32zJicFeWBLsdvylj6guMElpSE+ZqlZy5Lc/ZPVsqwWZnN9IwXCOBfegV3W
	 lCvYgbHFnGGGc+Y5o3SKVH6PN3tV59oRk8V8J4Vbok6yvTtpXTpKIohebWhy9IO+Qq
	 ETRVdAkXUFLZeNIx3fZL8YMqJM7ZU86d77jP/ZChaNqguuDbgORAunHt9gmWLpqGz2
	 2JPAy+nBTEDNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jinjiang Tu <tujinjiang@huawei.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nanyong Sun <sunnanyong@huawei.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/huge_memory: fix folio isn't locked in softleaf_to_folio()
Date: Tue, 31 Mar 2026 07:39:06 -0400
Message-ID: <20260331113906.2080339-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033036-upstate-manifesto-09c1@gregkh>
References: <2026033036-upstate-manifesto-09c1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231405-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,suse.com:email,oracle.com:email]
X-Rspamd-Queue-Id: 137C1369064
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jinjiang Tu <tujinjiang@huawei.com>

[ Upstream commit 4c5e7f0fcd592801c9cc18f29f80fbee84eb8669 ]

On arm64 server, we found folio that get from migration entry isn't locked
in softleaf_to_folio().  This issue triggers when mTHP splitting and
zap_nonpresent_ptes() races, and the root cause is lack of memory barrier
in softleaf_to_folio().  The race is as follows:

	CPU0                                             CPU1

deferred_split_scan()                              zap_nonpresent_ptes()
  lock folio
  split_folio()
    unmap_folio()
      change ptes to migration entries
    __split_folio_to_order()                         softleaf_to_folio()
      set flags(including PG_locked) for tail pages    folio = pfn_folio(softleaf_to_pfn(entry))
      smp_wmb()                                        VM_WARN_ON_ONCE(!folio_test_locked(folio))
      prep_compound_page() for tail pages

In __split_folio_to_order(), smp_wmb() guarantees page flags of tail pages
are visible before the tail page becomes non-compound.  smp_wmb() should
be paired with smp_rmb() in softleaf_to_folio(), which is missed.  As a
result, if zap_nonpresent_ptes() accesses migration entry that stores tail
pfn, softleaf_to_folio() may see the updated compound_head of tail page
before page->flags.

This issue will trigger VM_WARN_ON_ONCE() in pfn_swap_entry_folio()
because of the race between folio split and zap_nonpresent_ptes()
leading to a folio incorrectly undergoing modification without a folio
lock being held.

This is a BUG_ON() before commit 93976a20345b ("mm: eliminate further
swapops predicates"), which in merged in v6.19-rc1.

To fix it, add missing smp_rmb() if the softleaf entry is migration entry
in softleaf_to_folio() and softleaf_to_page().

[tujinjiang@huawei.com: update function name and comments]
  Link: https://lkml.kernel.org/r/20260321075214.3305564-1-tujinjiang@huawei.com
Link: https://lkml.kernel.org/r/20260319012541.4158561-1-tujinjiang@huawei.com
Fixes: e9b61f19858a ("thp: reintroduce split_huge_page()")
Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Cc: Barry Song <baohua@kernel.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Nanyong Sun <sunnanyong@huawei.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ applied fix to swapops.h using old pfn_swap_entry/swp_entry_t naming ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/swapops.h | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index cb468e418ea11..d988ce9516510 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -484,15 +484,29 @@ static inline int pte_none_mostly(pte_t pte)
 	return pte_none(pte) || is_pte_marker(pte);
 }
 
-static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
+static inline void swap_entry_migration_sync(swp_entry_t entry,
+		struct folio *folio)
 {
-	struct page *p = pfn_to_page(swp_offset_pfn(entry));
+	/*
+	 * Ensure we do not race with split, which might alter tail pages into new
+	 * folios and thus result in observing an unlocked folio.
+	 * This matches the write barrier in __split_folio_to_order().
+	 */
+	smp_rmb();
 
 	/*
 	 * Any use of migration entries may only occur while the
 	 * corresponding page is locked
 	 */
-	BUG_ON(is_migration_entry(entry) && !PageLocked(p));
+	BUG_ON(!folio_test_locked(folio));
+}
+
+static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
+{
+	struct page *p = pfn_to_page(swp_offset_pfn(entry));
+
+	if (is_migration_entry(entry))
+		swap_entry_migration_sync(entry, page_folio(p));
 
 	return p;
 }
@@ -501,11 +515,8 @@ static inline struct folio *pfn_swap_entry_folio(swp_entry_t entry)
 {
 	struct folio *folio = pfn_folio(swp_offset_pfn(entry));
 
-	/*
-	 * Any use of migration entries may only occur while the
-	 * corresponding folio is locked
-	 */
-	BUG_ON(is_migration_entry(entry) && !folio_test_locked(folio));
+	if (is_migration_entry(entry))
+		swap_entry_migration_sync(entry, folio);
 
 	return folio;
 }
-- 
2.53.0


