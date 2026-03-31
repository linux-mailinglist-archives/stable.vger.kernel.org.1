Return-Path: <stable+bounces-231408-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIg8IHS2y2kpKAYAu9opvQ
	(envelope-from <stable+bounces-231408-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:56:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB733692D2
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8744C305DD1A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC24D3BAD8D;
	Tue, 31 Mar 2026 11:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khe4O7h+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9092C378812
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 11:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774957886; cv=none; b=mI9d0Bwiv5hMn2pv2nIe+2dgbmqBlmQww1bwmLi1RuGla2otlZj6sOZ0fDnIfzrXtRDkyoP/7F5dfW3dwOrb4NjbcRDAr4igvOw+l35IYUzNskDDGFdAa/XpkbEkfte2m1+mwi1snEemaUl4SNf/EV9Qfi9rYkGbM3ZvmrwDt9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774957886; c=relaxed/simple;
	bh=T0w0qR+ML9AF96aFpedODhWrVK3Pryyi5Z8+jwCNTf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFGGM9xOz5XbynjuKyT8H/hqCLW4unsO//LL0s7Dn0rPaLyhlbELrG1dCTdunrfE0MP4ZqNDTVlRt7NPHlelvSeUcQzc+3yVFZJKpykrAAK7EzswIxHRDdIvwXjgD60eZ+22jRKWhPGFPeFUtW02iAEwFqIC0HW0gUPFo3TujKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khe4O7h+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F93C19423;
	Tue, 31 Mar 2026 11:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774957886;
	bh=T0w0qR+ML9AF96aFpedODhWrVK3Pryyi5Z8+jwCNTf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=khe4O7h+6pH1j/0JXABwSqxe/HvMAc2HxFLNgG0rnixYjIdEMy7ZMwKJEeiQZKdtG
	 /HPOGZR6cqqqM6g8FeZE8n6b/xHn4LCSHyTe+Uw6mRnWtB/a5QCavHcjRseoP3/Qik
	 sGPHnUE/vNyuehN1ehUgj9TdwdBUrhx+Q63cDbSandCAf1xwQGn/07jxTdlkVGvGQ5
	 f7LyJtQv/QHNhd3uJeyy4TPgVv+Tao82g8L4yOaE8AHIl2dGt/nGeyubtBhFgTM/eD
	 JJ+eYaXFJfyvZiCWEokvDLKFHDk6xCMRTeRLlLJApE/GrJXy5QXNHnMO51O8dROdd6
	 SUw5HU/CaPZCw==
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
Subject: [PATCH 6.6.y] mm/huge_memory: fix folio isn't locked in softleaf_to_folio()
Date: Tue, 31 Mar 2026 07:51:22 -0400
Message-ID: <20260331115122.2131507-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033037-lethargic-pandemic-39fa@gregkh>
References: <2026033037-lethargic-pandemic-39fa@gregkh>
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
	TAGGED_FROM(0.00)[bounces-231408-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DCB733692D2
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
[ adapted fix from leafops.h softleaf_to_page()/softleaf_to_folio() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/swapops.h | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 925c84653af5e..7555a4a3d3d49 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -488,11 +488,21 @@ static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
 {
 	struct page *p = pfn_to_page(swp_offset_pfn(entry));
 
-	/*
-	 * Any use of migration entries may only occur while the
-	 * corresponding page is locked
-	 */
-	BUG_ON(is_migration_entry(entry) && !PageLocked(p));
+	if (is_migration_entry(entry)) {
+		/*
+		 * Ensure we do not race with split, which might alter tail
+		 * pages into new folios and thus result in observing an
+		 * unlocked folio.
+		 * This matches the write barrier in __split_folio_to_order().
+		 */
+		smp_rmb();
+
+		/*
+		 * Any use of migration entries may only occur while the
+		 * corresponding page is locked
+		 */
+		BUG_ON(!PageLocked(p));
+	}
 
 	return p;
 }
-- 
2.53.0


