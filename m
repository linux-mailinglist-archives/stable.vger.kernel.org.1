Return-Path: <stable+bounces-228707-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABo1LnVowWliSwQAu9opvQ
	(envelope-from <stable+bounces-228707-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:21:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADFE2F7EC9
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 563A231BEBBC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90303AF667;
	Mon, 23 Mar 2026 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VQoTKlZz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFB3396D3D;
	Mon, 23 Mar 2026 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774276906; cv=none; b=SF+/BLQP1r+Kb5CuTgg/8EvxLOwTu12/Y4fIHfbQUy7fafbApYnp/tBwjrYFjwErKMSlRs4VHYT6sC0Ahaw26W07OFi9pucYsol0A67F9WQeSlNpufWU1H7/dnMq6Y9bxPpJ4mTFIJ1gCcHLdYHjrU35RhyO9brQd8MsQZb9TqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774276906; c=relaxed/simple;
	bh=pVEPtLfdr35NL3sccPg0fMdXMHDsCa6dlEOpC+vqEW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ibl2VA0tNz4f6MKtDvpvyoKuy6CUVba/diUGlU24jKGPOi5cVt2G+YS+iXU/n7Bt9IRQsNxpocfxFHuSZjbRAw+Va8vYmdeOWFKvYgvvvyF9ikYqeJPBFqeZ0ShrsELSklw+eBxmlmE2g9dJsFrVR61FrTzxogO5FZNy5QjspuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VQoTKlZz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E6AC4CEF7;
	Mon, 23 Mar 2026 14:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774276906;
	bh=pVEPtLfdr35NL3sccPg0fMdXMHDsCa6dlEOpC+vqEW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VQoTKlZzGM6XBg/P5kKrduab704OGnY5c0/Zg7aKtcSapGrlKuwd9DoRZWGpexIzY
	 M/osx3U4orUA5uUyo5olYIdoLXDO8FN0Spcj3BURZ7dwoCXIIAwfNKcWXbw7vMFd0h
	 NLuP5V0rq5XDjz1hqXeTR+eiLBzEV6kjyZWMwX8Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
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
Subject: [PATCH 6.12 250/460] mm/page_alloc: move set_page_refcounted() to callers of post_alloc_hook()
Date: Mon, 23 Mar 2026 14:44:06 +0100
Message-ID: <20260323134532.638175106@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-228707-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,infradead.org,huawei.com,nvidia.com,redhat.com,suse.cz,gmail.com,techsingularity.net,bytedance.com,oracle.com,linux-foundation.org,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1ADFE2F7EC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/compaction.c |    2 ++
 mm/internal.h   |    3 +--
 mm/page_alloc.c |    3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -83,6 +83,7 @@ static inline bool is_via_compact_memory
 static struct page *mark_allocated_noprof(struct page *page, unsigned int order, gfp_t gfp_flags)
 {
 	post_alloc_hook(page, order, __GFP_MOVABLE);
+	set_page_refcounted(page);
 	return page;
 }
 #define mark_allocated(...)	alloc_hooks(mark_allocated_noprof(__VA_ARGS__))
@@ -1869,6 +1870,7 @@ again:
 	dst = (struct folio *)freepage;
 
 	post_alloc_hook(&dst->page, order, __GFP_MOVABLE);
+	set_page_refcounted(&dst->page);
 	if (order)
 		prep_compound_page(&dst->page, order);
 	cc->nr_freepages -= 1 << order;
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -729,8 +729,7 @@ static inline void prep_compound_tail(st
 
 extern void prep_compound_page(struct page *page, unsigned int order);
 
-extern void post_alloc_hook(struct page *page, unsigned int order,
-					gfp_t gfp_flags);
+void post_alloc_hook(struct page *page, unsigned int order, gfp_t gfp_flags);
 extern bool free_pages_prepare(struct page *page, unsigned int order);
 
 extern int user_min_free_kbytes;
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1542,7 +1542,6 @@ inline void post_alloc_hook(struct page
 	int i;
 
 	set_page_private(page, 0);
-	set_page_refcounted(page);
 
 	arch_alloc_page(page, order);
 	debug_pagealloc_map_pages(page, 1 << order);
@@ -1598,6 +1597,7 @@ static void prep_new_page(struct page *p
 							unsigned int alloc_flags)
 {
 	post_alloc_hook(page, order, gfp_flags);
+	set_page_refcounted(page);
 
 	if (order && (gfp_flags & __GFP_COMP))
 		prep_compound_page(page, order);
@@ -6591,6 +6591,7 @@ static void split_free_pages(struct list
 			int i;
 
 			post_alloc_hook(page, order, __GFP_MOVABLE);
+			set_page_refcounted(page);
 			if (!order)
 				continue;
 



