Return-Path: <stable+bounces-264859-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bIHTBSl/MWp8kwUAu9opvQ
	(envelope-from <stable+bounces-264859-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:51:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D11692863
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:51:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=EHAtZKP0;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264859-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-264859-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29A3E30E2ED2
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D3245BD6F;
	Tue, 16 Jun 2026 16:44:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D19D2F745E;
	Tue, 16 Jun 2026 16:44:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628265; cv=none; b=dNdI5Xp5MYFx5ypt8Lb1kvvR9QtnnSifxrnGnQ8bEK6KyBy4NUUEDPCtzbizs2y9Zsu8/QCuaTdVkEVnnUXAgo7XdLe7bCq2ZgfdJP+lP7MV99ETNGRUHmm7+KX2vmfXV5RTLmpbKOP5Kr6s91DbOj1G2/OA0CBsIWVLrayUNMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628265; c=relaxed/simple;
	bh=8oFxNnN0xYp9R0Beqzj1BnTf7UV4+zYQcgZ3mefpYvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4Oln/AfNSQ5bRtMpbP52+SCLE/Z9OHC55Oqyq5cT8gG0t36NZkxaKMhOpM8bvt9hf3GYgqacO+j+I68UjbD5v7IPbIgWD2cEiIDdjbCeWHg82PQ3fcsEWVDVycKitwTN7jBnWv4k/N48LPj4DACKXKRrZ8L29Ldb0QJMOj02Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EHAtZKP0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34971F000E9;
	Tue, 16 Jun 2026 16:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781628264;
	bh=Z5ceESlV3BDh+VjrYtvU5Qikpbwh5gBdID0dfwJShHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EHAtZKP03ZeQb8SR+KORoBc3i/VgsDr3U7JBH7SH98HyVnVrfrIdMx0vDc5vA86bs
	 OS339HIkvaUSCqebBKLCbCmKyaDszIEaa0J4kR5YueCqUCxj0g1L55CeMkE6piX/r4
	 Dnrn8f/MaUFpBM6fKGFOfBKB/7XA24Z7bO+6P5bM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	Chris Li <chrisl@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kairui Song <ryncsn@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Li Wang <li.wang@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 062/452] mm/page_alloc: clear page->private in free_pages_prepare()
Date: Tue, 16 Jun 2026 20:24:49 +0530
Message-ID: <20260616145121.213065682@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264859-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:mikhail.v.gavrilov@gmail.com,m:ziy@nvidia.com,m:david@kernel.org,m:vbabka@suse.cz,m:jackmanb@google.com,m:chrisl@kernel.org,m:hughd@google.com,m:hannes@cmpxchg.org,m:ryncsn@gmail.com,m:willy@infradead.org,m:mhocko@suse.com,m:npiggin@gmail.com,m:surenb@google.com,m:akpm@linux-foundation.org,m:li.wang@windriver.com,m:sashal@kernel.org,m:mikhailvgavrilov@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,nvidia.com,kernel.org,suse.cz,google.com,cmpxchg.org,infradead.org,suse.com,linux-foundation.org,windriver.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78D11692863

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

[ Upstream commit ac1ea219590c09572ed5992dc233bbf7bb70fef9 ]

Several subsystems (slub, shmem, ttm, etc.) use page->private but don't
clear it before freeing pages.  When these pages are later allocated as
high-order pages and split via split_page(), tail pages retain stale
page->private values.

This causes a use-after-free in the swap subsystem.  The swap code uses
page->private to track swap count continuations, assuming freshly
allocated pages have page->private == 0.  When stale values are present,
swap_count_continued() incorrectly assumes the continuation list is valid
and iterates over uninitialized page->lru containing LIST_POISON values,
causing a crash:

  KASAN: maybe wild-memory-access in range [0xdead000000000100-0xdead000000000107]
  RIP: 0010:__do_sys_swapoff+0x1151/0x1860

Fix this by clearing page->private in free_pages_prepare(), ensuring all
freed pages have clean state regardless of previous use.

Link: https://lkml.kernel.org/r/20260207173615.146159-1-mikhail.v.gavrilov@gmail.com
Fixes: 3b8000ae185c ("mm/vmalloc: huge vmalloc backing pages should be split rather than compound")
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Suggested-by: Zi Yan <ziy@nvidia.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kairui Song <ryncsn@gmail.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[backport: context only]
Signed-off-by: Li Wang <li.wang@windriver.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b617fb364b15d1..ffdc71103c2ad2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1178,6 +1178,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 
 	page_cpupid_reset_last(page);
 	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
+	page->private = 0;
 	reset_page_owner(page, order);
 	page_table_check_free(page, order);
 
-- 
2.53.0




