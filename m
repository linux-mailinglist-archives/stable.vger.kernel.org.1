Return-Path: <stable+bounces-226095-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEKKHDBxuWm8EgIAu9opvQ
	(envelope-from <stable+bounces-226095-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:20:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E384D2ACE4F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29A5130DBED3
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9C93EB7EF;
	Tue, 17 Mar 2026 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFzYzubu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AD63EAC78
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760358; cv=none; b=ZwWIZCD8ixrC3UBwV/ei1yP0/xXQlrnkWt9PMG/fD81UlZ080SyFnLR/lJL6kN5q7XYAMbUXhBEB8je0soOLZyNHG1gEpyjbxMCPAVhzI+HkseJioIcefaH6BZP5sY3rb7YghS2DZaCdZnqNWl6Kpp0rkrbK058mhW7lNliru90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760358; c=relaxed/simple;
	bh=oXss1Qhz5NOqCruVAuKSAobY8d1H+KGulKPdY3vvH4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hM845yaUd/rWsqrHgGBmeIxkDH9IWFjVORsT9DjIG6PaA3q5aLTQ+blnvOWcRdfumrF2qFRpo8fV7hG/Wpn4bHarjwUqO44EjPtotcUds9TBCxYGDKUW8dWZFys4bGRL9Owl/Qc7Z7v6cVPwAvdPTka9Tp4ldvJ5cr43mCCDJ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFzYzubu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC3EC2BC86;
	Tue, 17 Mar 2026 15:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773760357;
	bh=oXss1Qhz5NOqCruVAuKSAobY8d1H+KGulKPdY3vvH4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZFzYzubutCmeOQDGMuJwCuWQ/FomCS25AxeMrAQqWpwAavXRd/EvjbE8d96s/YKMG
	 VqO/SpkbZ4ReUtE0NxDQIkaIRG6fyysQUlPE1mrQDn2+Unhy/d5mbjuuHp+z6vPjBW
	 vF+Dj7fLxeX6tZFkPK75mud47AZjAAOZJJuWTreQX9YHrrMVwUf9VlqNFnJNroW+wo
	 g6/NAYozxF2yTuxiACnWFF4vLBz8h6E3UU2fMcTP4A4AvMg5nQibGH3O9dTzs9SWbm
	 f00VTGD8G1Eovr6YC/ak8zdWbv4DIA4l89DhWXbsrVTVd7u9RSdsVkJ9JO2I2R1Z/j
	 IVqizxGWf8u7w==
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
Subject: [PATCH 6.1.y] mm/kfence: fix KASAN hardware tag faults during late enablement
Date: Tue, 17 Mar 2026 11:12:34 -0400
Message-ID: <20260317151234.185462-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031730-shucking-dreaded-e3cf@gregkh>
References: <2026031730-shucking-dreaded-e3cf@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,tugraz.at,gmail.com,linuxfoundation.org,kernel.org,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226095-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tugraz.at:email,linux-foundation.org:email]
X-Rspamd-Queue-Id: E384D2ACE4F
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
[ expand __GFP_SKIP_KASAN + nr_pages_pool => nr_pages ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/kfence/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index edf6deb382b67..bdb864384f2af 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -897,7 +897,8 @@ static int kfence_init_late(void)
 #ifdef CONFIG_CONTIG_ALLOC
 	struct page *pages;
 
-	pages = alloc_contig_pages(nr_pages, GFP_KERNEL, first_online_node, NULL);
+	pages = alloc_contig_pages(nr_pages, GFP_KERNEL | __GFP_SKIP_KASAN_UNPOISON |
+				   __GFP_SKIP_KASAN_POISON, first_online_node, NULL);
 	if (!pages)
 		return -ENOMEM;
 	__kfence_pool = page_to_virt(pages);
@@ -906,7 +907,9 @@ static int kfence_init_late(void)
 		pr_warn("KFENCE_NUM_OBJECTS too large for buddy allocator\n");
 		return -EINVAL;
 	}
-	__kfence_pool = alloc_pages_exact(KFENCE_POOL_SIZE, GFP_KERNEL);
+	__kfence_pool = alloc_pages_exact(KFENCE_POOL_SIZE, GFP_KERNEL |
+					  __GFP_SKIP_KASAN_UNPOISON |
+					  __GFP_SKIP_KASAN_POISON);
 	if (!__kfence_pool)
 		return -ENOMEM;
 #endif
-- 
2.51.0


