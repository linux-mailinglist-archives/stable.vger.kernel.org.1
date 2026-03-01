Return-Path: <stable+bounces-221781-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KkxD6aoo2mWJAUAu9opvQ
	(envelope-from <stable+bounces-221781-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:47:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 909061CDEB1
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EFB8319EAC0
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773951ADFE4;
	Sun,  1 Mar 2026 01:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckjl8/0E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABCB13B58A
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329121; cv=none; b=daPcYO9LePypXlO3LYhGduUTzHleq24ku54Ym7td4hxKVQf/b8X3tLdr7Bps8r97LzX/AfO2nJDVS9pq82DY5ATjdmDBTSv0bylokD5VaBTdV+wYC/YFPK3nrppl3dybTiwq3QMX03q1IZGKrsMeoE0892vCXrbcZck8gj9mg0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329121; c=relaxed/simple;
	bh=+7YmQSKJ/fHf3Smb0srHzTVLHJ/J+0CDrQdmpzRSmR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l3Qt37WVgfyoj+Y+INmoqQhvRSPNj3RUv406LoOYXvX8HEaTM6P5lES8l5KEulQj/wQJ5MrLxsQSlPA/tdA4fVl2duD+gKSKqy67i/66kD1tWV/YXgT8+b2d2SWnZ3R7KO7ptQySNJyrrU7c8qu8YvL/3okojVbASHWgYOmDA/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckjl8/0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4190FC19421;
	Sun,  1 Mar 2026 01:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329120;
	bh=+7YmQSKJ/fHf3Smb0srHzTVLHJ/J+0CDrQdmpzRSmR0=;
	h=From:To:Cc:Subject:Date:From;
	b=ckjl8/0EW3RxdcrYXG4f+tsQO8SZ+VDLklByi5H8WeTdRKP5f960LQCD33tzoAjMw
	 iK9YWcgZFE7iYIzlgC6ThqSMXW9sOIz2WsUiy+PkHEgZoIP6TV8eK6ctKlw6c1qAt3
	 OpTVxiyOkadISMku731lZBI0MyYFMi4WcgDJ/mPYlVxO0BvQp7hmbjOI9XRfohTHIP
	 0ypLsWOt3Aazea96kSmSyAYtEGGtNKiXMcs34xwlVn4AzVXsqGldhbZFWJE2XaMo8S
	 l24a7TAVmWGoI8nKMAZTk2xVB3s9hEedvSLU8VkgYFZI7yCa8gwjT3jSCB0iECRNPC
	 UOJsb5HCSk7UA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mikhail.v.gavrilov@gmail.com
Cc: Zi Yan <ziy@nvidia.com>,
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
	linux-mm@kvack.org
Subject: FAILED: Patch "mm/page_alloc: clear page->private in free_pages_prepare()" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:38:37 -0500
Message-ID: <20260301013838.1699247-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-221781-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,suse.cz,google.com,cmpxchg.org,gmail.com,infradead.org,suse.com,linux-foundation.org,kvack.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cmpxchg.org:email]
X-Rspamd-Queue-Id: 909061CDEB1
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ac1ea219590c09572ed5992dc233bbf7bb70fef9 Mon Sep 17 00:00:00 2001
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Sat, 7 Feb 2026 22:36:14 +0500
Subject: [PATCH] mm/page_alloc: clear page->private in free_pages_prepare()

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
---
 mm/page_alloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e4104973e22fd..77dcec36946f0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1429,6 +1429,7 @@ __always_inline bool free_pages_prepare(struct page *page,
 
 	page_cpupid_reset_last(page);
 	page->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
+	page->private = 0;
 	reset_page_owner(page, order);
 	page_table_check_free(page, order);
 	pgalloc_tag_sub(page, 1 << order);
-- 
2.51.0





