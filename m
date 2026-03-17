Return-Path: <stable+bounces-225858-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCGdBjJAuWkowQEAu9opvQ
	(envelope-from <stable+bounces-225858-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:51:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B555B2A93DB
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1023F3025E09
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF883B19CF;
	Tue, 17 Mar 2026 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/MJX3Io"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9E53B19C7
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748257; cv=none; b=WvclT7rltI2n/IK8Z3deybtjPGvhVnTqkQMqhHLeo2YIdoFVBiHiyf5Ma4QidSaR+A3HnE2q7mWq4F0+Yra8hTDkaz8wEliJbgOe9n+nEKavjMVfscJfQLMmRmkWeMe0DuzTzROeLWqtwIBJ4jBMJxu2H42bZ7ia/GGw6JMFtzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748257; c=relaxed/simple;
	bh=Ha3Ahw2465uwgqbd3xurkD/M13tKFu2NbrEkSPH6XD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odeaCoX88Dcsfh4ieMYwH2h46uJstzfH7vpQ4OWrMiC+0KjY5PanOyLBWkuonAiOG/AP57ChyDUVVPJAVQcXvMewZUnqZWRMYk1+jtwg9wHyxVWAaHYmm0Mfdn+gE58m2AINj8ublZlIW/fway5HhXH4g/UZjcc0L+tQ80xM2b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/MJX3Io; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68F2C4CEF7;
	Tue, 17 Mar 2026 11:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773748257;
	bh=Ha3Ahw2465uwgqbd3xurkD/M13tKFu2NbrEkSPH6XD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m/MJX3Io660WYlUgROeksOxOkqMG4mtRGI/RXt2GQwgDq3EmU6/mLMXCporUKdhSr
	 aiX6Jj+bNnpjKVuLalaQ8EWGwek4AbgFVjcyQn+5ENZJpUlFgZrtOu09yovFSuSj0W
	 O+pmcGtDS9JiJ0LBI1B4Oy7yNeW8XpJpFW+Lww6O0E/qZCyeiQNjrCgDoOhuoUaPEc
	 u2vw89iVBD6zsU77YPlnZCoxZ+R0gGLcAWQIC/onGgv+WKz136pg/nDhukKi9wySHH
	 2eADK3d1yE5HrSeP7seXd+cv+qZks4gfSAlqxhlcwATHBax08KeFMN3ryU5T3oYNk5
	 VgkPI9sfwUFfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Muchun Song <songmuchun@bytedance.com>,
	William Kucharski <william.kucharski@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] mm/page_alloc: move set_page_refcounted() to callers of post_alloc_hook()
Date: Tue, 17 Mar 2026 07:50:51 -0400
Message-ID: <20260317115054.127467-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031724-slimness-shell-ed87@gregkh>
References: <2026031724-slimness-shell-ed87@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[infradead.org,huawei.com,nvidia.com,redhat.com,suse.cz,gmail.com,techsingularity.net,bytedance.com,oracle.com,linux-foundation.org,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-225858-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email,linux-foundation.org:email,infradead.org:email,bytedance.com:email]
X-Rspamd-Queue-Id: B555B2A93DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

[ Upstream commit 8fd10a892a8db797fffb59a9a60bce23a56eef46 ]

In preparation for allocating frozen pages, stop initialising the page
refcount in post_alloc_hook().

Link: https://lkml.kernel.org/r/20241125210149.2976098-5-willy@infradead.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: William Kucharski <william.kucharski@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: d155aab90fff ("mm/kfence: fix KASAN hardware tag faults during late enablement")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/compaction.c | 2 ++
 mm/internal.h   | 3 +--
 mm/page_alloc.c | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index eb5474dea04d9..66032064387ef 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -83,6 +83,7 @@ static inline bool is_via_compact_memory(int order) { return false; }
 static struct page *mark_allocated_noprof(struct page *page, unsigned int order, gfp_t gfp_flags)
 {
 	post_alloc_hook(page, order, __GFP_MOVABLE);
+	set_page_refcounted(page);
 	return page;
 }
 #define mark_allocated(...)	alloc_hooks(mark_allocated_noprof(__VA_ARGS__))
@@ -1869,6 +1870,7 @@ static struct folio *compaction_alloc_noprof(struct folio *src, unsigned long da
 	dst = (struct folio *)freepage;
 
 	post_alloc_hook(&dst->page, order, __GFP_MOVABLE);
+	set_page_refcounted(&dst->page);
 	if (order)
 		prep_compound_page(&dst->page, order);
 	cc->nr_freepages -= 1 << order;
diff --git a/mm/internal.h b/mm/internal.h
index 9e0577413087c..b7b942767c702 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -729,8 +729,7 @@ static inline void prep_compound_tail(struct page *head, int tail_idx)
 
 extern void prep_compound_page(struct page *page, unsigned int order);
 
-extern void post_alloc_hook(struct page *page, unsigned int order,
-					gfp_t gfp_flags);
+void post_alloc_hook(struct page *page, unsigned int order, gfp_t gfp_flags);
 extern bool free_pages_prepare(struct page *page, unsigned int order);
 
 extern int user_min_free_kbytes;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4282c9d0a5ddd..0bd0784952386 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1542,7 +1542,6 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 	int i;
 
 	set_page_private(page, 0);
-	set_page_refcounted(page);
 
 	arch_alloc_page(page, order);
 	debug_pagealloc_map_pages(page, 1 << order);
@@ -1598,6 +1597,7 @@ static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags
 							unsigned int alloc_flags)
 {
 	post_alloc_hook(page, order, gfp_flags);
+	set_page_refcounted(page);
 
 	if (order && (gfp_flags & __GFP_COMP))
 		prep_compound_page(page, order);
@@ -6591,6 +6591,7 @@ static void split_free_pages(struct list_head *list)
 			int i;
 
 			post_alloc_hook(page, order, __GFP_MOVABLE);
+			set_page_refcounted(page);
 			if (!order)
 				continue;
 
-- 
2.51.0


