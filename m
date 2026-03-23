Return-Path: <stable+bounces-229806-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COohGbxtwWnDTAQAu9opvQ
	(envelope-from <stable+bounces-229806-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:43:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 535A72F8ADE
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4EE2631AFD13
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905E33B38A4;
	Mon, 23 Mar 2026 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KFHUz6CK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5283AF647;
	Mon, 23 Mar 2026 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282915; cv=none; b=BZkOSfu26150MHoQ2MWNGCF6tYp3r3oa2oakKIfR5yopnXIi2K78iOb0G/hpokWIZhsCPJILjfW0qJpN7nP0MkyqxLBAU+YxoIBwLZNPWA6cIdiJVVCK64WzkT/Ics9wj3z8zpU/c2hwcQBnZwDOxb2yyWP7xl+DcikH5TfuUNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282915; c=relaxed/simple;
	bh=5X9rS10d7/I5ookLAdxyuv+FD89Jh+i5YyauEdk285U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFcfkl6wsE7ZXYBiD2MMl1Tp827oG8y53T7vNL6ctJDcUaVXIYNcK1HZ5y40chBwacIJeBDIx3h1nwQWLgG/G5DYyB9O5FnutpcUbcKHeEKpELvmooqAwYlmnzvbJA2ARTwvl8oj0w2hncBtYFgm6dhDBa1uM37jD3GjLfLlHvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KFHUz6CK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D71C4CEF7;
	Mon, 23 Mar 2026 16:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282915;
	bh=5X9rS10d7/I5ookLAdxyuv+FD89Jh+i5YyauEdk285U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KFHUz6CKu610iExhp68kdJ5Ejk1djXDSoDxLefiH9rx1lZHqfUlE2VwgJnHhG48GJ
	 5cplJELCrPVXd2aE2i8XpK1s+RndS01K//OHPE5QiHlLJBH7HYkYGa8hY+yMlP3H60
	 K3vYlnTjZ8kWby7KBLz25IQOUqbmR7N/ylp7PjQo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Potapenko <glider@google.com>,
	Ernesto Martinez Garcia <ernesto.martinezgarcia@tugraz.at>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Kees Cook <kees@kernel.org>,
	Marco Elver <elver@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 334/481] mm/kfence: fix KASAN hardware tag faults during late enablement
Date: Mon, 23 Mar 2026 14:45:16 +0100
Message-ID: <20260323134533.237451470@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229806-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,google.com,tugraz.at,gmail.com,kernel.org,linux-foundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 535A72F8ADE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/kfence/core.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

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



