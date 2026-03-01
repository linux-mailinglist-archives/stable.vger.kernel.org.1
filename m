Return-Path: <stable+bounces-221534-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HKUHeWXo2neHgUAu9opvQ
	(envelope-from <stable+bounces-221534-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:35:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CBE1CB0E6
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0FFDB303C108
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBF625C802;
	Sun,  1 Mar 2026 01:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3uSM8T3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842CF2868B5
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328506; cv=none; b=e/CV+1gnGzmIMbZLt4qKhTZ6BzOkDzfCSrJwWgkqKbu6EgEWdOY+QWCurtrY/yLxuVsHKg+wzoLpyMR3si8lzsWPx9EcZmkz0o9cJ4QfpfOMiqQ1C/HGru1O8rYnoea0QHSq4ZQ3aTyIXgUMoAkGV02Rt/OL2Eo8V3BMWoxilwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328506; c=relaxed/simple;
	bh=+O76RfsTh16i6VAVyeQr5CmkQXtbbU5Iq6n/A3Vz5/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fldi6fzPy5ZXA7IVmdzNLjTSi8dCzfR0iFeeJ9CQ+vOKYQopYJ0SdQo9AtazVjPeqy2oQZBfDsPY0bNM1f+DScA1aO5/SnB30B5EWHWwzYjLTytcEDa3SmB/SA/hadzAB7bFRICe02N8g+R7nQa2XX0z2Z6YhJVUwf048ynZ6tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3uSM8T3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA864C19424;
	Sun,  1 Mar 2026 01:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328506;
	bh=+O76RfsTh16i6VAVyeQr5CmkQXtbbU5Iq6n/A3Vz5/g=;
	h=From:To:Cc:Subject:Date:From;
	b=K3uSM8T3owkqgbaEfkbzjp+eeY+Z7L09OoYYWBDkLJHnWuzfrH8CG/MQYf4zlfd6s
	 XFDWy5IT5s018NUV8AoOjMx0EkZTKh/1vTvkGYZ3oxsqAKpg41tWH1Nh12uDx3U+mL
	 UPDJRBeTHlesWSTKScS0uXuDJi04TSvY2Y/1r/i/Drbf2H9hXaguYXLSHa+w0aD9Q7
	 9XHZj6TYP1H/39JCf7C0VHaWMZ8a797+es7UtEKxVeFxmt7fq2XciICBfJ2+nicwKm
	 tD81GNWv5jV+S/b7j3nZmK7aLzUVUkblch34NPYjSF6xPA6R6aUCxDGsgithh2yKQF
	 u1dC+wTo1nNOg==
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
Subject: FAILED: Patch "mm/page_alloc: clear page->private in free_pages_prepare()" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:28:23 -0500
Message-ID: <20260301012823.1686138-1-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-221534-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,suse.cz,google.com,cmpxchg.org,gmail.com,infradead.org,suse.com,linux-foundation.org,kvack.org];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 79CBE1CB0E6
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
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





