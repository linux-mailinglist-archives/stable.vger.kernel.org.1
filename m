Return-Path: <stable+bounces-225861-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cD7eDjlAuWmB9QEAu9opvQ
	(envelope-from <stable+bounces-225861-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:51:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F38252A93EF
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C4BF302BF62
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910653B52E0;
	Tue, 17 Mar 2026 11:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eX65buUj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8AC3B3BF8
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 11:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748261; cv=none; b=ueC/NYiaMl3lV0QWoyuGUHoytsx4hZeFlm2JSY6FqqVI3Uww6hnPTHJqbUbcrWfkHxt7AxRxrFsPypdqbD4Ubac1fgfnqkmhL4zuRj+EXETTQLPr+kC+ltQKv6ts4NorwRzBHQ/S8AnmczesRGQjshBzVXg6Cuu+Up4T95gbx1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748261; c=relaxed/simple;
	bh=pcyhFKxxmQ7y1ClXS+RxDiQmjW2HNyRFc1CyBwQIGwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jfBmM1Ecc+deTbAKDQmr+8KbRLrV9MaDM2PpQFyvHfnaQJRQS5Tn+R5v2bAtIPnYbr09ECqLzgTe+jp0aSF7V6EKkCLefYAHshT5maWLMGylYVsz7Ti/1HMNlLsPtN7FU3coar+mrUMCT9Gw+ajA7uBCV+lWLNYrUYfk4pvRPwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eX65buUj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54961C4CEF7;
	Tue, 17 Mar 2026 11:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773748261;
	bh=pcyhFKxxmQ7y1ClXS+RxDiQmjW2HNyRFc1CyBwQIGwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eX65buUjK5bj9t47H0iTdOKXOJ5KYjzkz5T0FAfPojzCEE1vlaBcY47r2z8/tqPzs
	 9gHYpny99Abm4S5fiFRazoU6Pp8gClLaWCu7KT9bI4CVJ/T4f3Oib/9S4jXKC5e7y0
	 i9Fo9RCnPST31e9HR4r1nyX5OHm/E1ouNBlUddj6ivMKoM7o7ty3knqIovTVLH4Iv3
	 8SFnLtXj7R/zpWT399ooPlZtfyw+gj/OifFm9f+EaTF9ETGdAwFKWQCpXguDDmaSHy
	 ujOlILwN/slqwfdkB0JlcTMCVWm0e5loKpp6Pwj6bIRPP+V4VqSrMEzo33tcf8Xuph
	 Tfb+wR3OjwRRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Potapenko <glider@google.com>,
	Ernesto Martinez Garcia <ernesto.martinezgarcia@tugraz.at>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>,
	Marco Elver <elver@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] mm/kfence: fix KASAN hardware tag faults during late enablement
Date: Tue, 17 Mar 2026 07:50:54 -0400
Message-ID: <20260317115054.127467-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317115054.127467-1-sashal@kernel.org>
References: <2026031724-slimness-shell-ed87@gregkh>
 <20260317115054.127467-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,tugraz.at,gmail.com,linuxfoundation.org,kernel.org,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225861-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: F38252A93EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alexander Potapenko <glider@google.com>

[ Upstream commit d155aab90fffa00f93cea1f107aef0a3d548b2ff ]

When KASAN hardware tags are enabled, re-enabling KFENCE late (via
/sys/module/kfence/parameters/sample_interval) causes KASAN faults.

This happens because the KFENCE pool and metadata are allocated via the
page allocator, which tags the memory, while KFENCE continues to access it
using untagged pointers during initialization.

Use __GFP_SKIP_KASAN for late KFENCE pool and metadata allocations to
ensure the memory remains untagged, consistent with early allocations from
memblock.  To support this, add __GFP_SKIP_KASAN to the allowlist in
__alloc_contig_verify_gfp_mask().

Link: https://lkml.kernel.org/r/20260220144940.2779209-1-glider@google.com
Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
Signed-off-by: Alexander Potapenko <glider@google.com>
Suggested-by: Ernesto Martinez Garcia <ernesto.martinezgarcia@tugraz.at>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Marco Elver <elver@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/kfence/core.c | 14 ++++++++------
 mm/page_alloc.c  |  3 ++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index b301ca3375086..7e7e0e4f1c10b 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -949,14 +949,14 @@ static int kfence_init_late(void)
 #ifdef CONFIG_CONTIG_ALLOC
 	struct page *pages;
 
-	pages = alloc_contig_pages(nr_pages_pool, GFP_KERNEL, first_online_node,
-				   NULL);
+	pages = alloc_contig_pages(nr_pages_pool, GFP_KERNEL | __GFP_SKIP_KASAN,
+				   first_online_node, NULL);
 	if (!pages)
 		return -ENOMEM;
 
 	__kfence_pool = page_to_virt(pages);
-	pages = alloc_contig_pages(nr_pages_meta, GFP_KERNEL, first_online_node,
-				   NULL);
+	pages = alloc_contig_pages(nr_pages_meta, GFP_KERNEL | __GFP_SKIP_KASAN,
+				   first_online_node, NULL);
 	if (pages)
 		kfence_metadata_init = page_to_virt(pages);
 #else
@@ -966,11 +966,13 @@ static int kfence_init_late(void)
 		return -EINVAL;
 	}
 
-	__kfence_pool = alloc_pages_exact(KFENCE_POOL_SIZE, GFP_KERNEL);
+	__kfence_pool = alloc_pages_exact(KFENCE_POOL_SIZE,
+					  GFP_KERNEL | __GFP_SKIP_KASAN);
 	if (!__kfence_pool)
 		return -ENOMEM;
 
-	kfence_metadata_init = alloc_pages_exact(KFENCE_METADATA_SIZE, GFP_KERNEL);
+	kfence_metadata_init = alloc_pages_exact(KFENCE_METADATA_SIZE,
+						 GFP_KERNEL | __GFP_SKIP_KASAN);
 #endif
 
 	if (!kfence_metadata_init)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6eff98b22b3b6..b1a8abe5005e9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6609,7 +6609,8 @@ static int __alloc_contig_verify_gfp_mask(gfp_t gfp_mask, gfp_t *gfp_cc_mask)
 {
 	const gfp_t reclaim_mask = __GFP_IO | __GFP_FS | __GFP_RECLAIM;
 	const gfp_t action_mask = __GFP_COMP | __GFP_RETRY_MAYFAIL | __GFP_NOWARN |
-				  __GFP_ZERO | __GFP_ZEROTAGS | __GFP_SKIP_ZERO;
+				  __GFP_ZERO | __GFP_ZEROTAGS | __GFP_SKIP_ZERO |
+				  __GFP_SKIP_KASAN;
 	const gfp_t cc_action_mask = __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
 
 	/*
-- 
2.51.0


