Return-Path: <stable+bounces-226123-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBTSK/iBuWmxHAIAu9opvQ
	(envelope-from <stable+bounces-226123-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:31:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FF22AE041
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A37F73174CA1
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD0F317169;
	Tue, 17 Mar 2026 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7HUBtFx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F2630F818
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764706; cv=none; b=Z+i/vnvE/gOv+GWIgNHFvRbQRl72bUVg086qF3Q0I/ih1bxvMfaeU7IyGkzBnRUti5INJD+anqqpAWG6UXDFYP2iRslXSQJj2lnK719ChTTrAfO128A5Z6I+VXdDqREwYP1Zgbwjk/a2IjO6TPPhmc8pEmSmTkW4t4xWjo/OOus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764706; c=relaxed/simple;
	bh=aG9KWY3cqvaH3qRzTt/gRb7ZJCNg1ybMOukZ535BBKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aP5Kz9doQ55AUuidNDsrWWO0Va5k8rmkC1S0WOluQc74v1qT3uZgJ6y9qjzee2T5g6Y7VbPX36GIedg8WRNpTWUNtpdGGaA6IvAov9k/kBMPxQysibdi0Yg0INTtfQQHRQ6peCJUzQ6P+LxROQZkYz08gyfcLBz5A3U8gwQXcsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7HUBtFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F49C4CEF7;
	Tue, 17 Mar 2026 16:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773764705;
	bh=aG9KWY3cqvaH3qRzTt/gRb7ZJCNg1ybMOukZ535BBKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j7HUBtFxRrdRMzgmntMegKJi6L/pmE5Gd/qHxZSXrhE19sP7IEm4/nBd1onmbg5bc
	 sB76hVIybrMBZytxKWSu4IlIYbE1T/g5Suimap5mpSYVyVRTSescrY7OMI8hdVvUoi
	 0L5lAYeHLJ5bDNT+MDhsbikVOLFJFWHjNaBUI1dfZZmmbyEQHUojEGMO6TFVi6XEpr
	 P21CR5O7v/uyepZ5yrppP4dPNZHNfBnRSR3oj8JYbdBkTrtHsM/9Q7WvZ+xk9snral
	 FUCIu/fU6Mr+tRk62IjK8IhWV6XupiBcrYxsxAzyfeqTYS7KD5kVJj13YUnFYe65Nz
	 gEpHYeiCbgePg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Ernesto Martinez Garcia <ernesto.martinezgarcia@tugraz.at>,
	Greg KH <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/kfence: disable KFENCE upon KASAN HW tags enablement
Date: Tue, 17 Mar 2026 12:25:01 -0400
Message-ID: <20260317162502.213232-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031743-sixth-control-6db4@gregkh>
References: <2026031743-sixth-control-6db4@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,gmail.com,tugraz.at,linuxfoundation.org,kernel.org,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226123-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 32FF22AE041
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alexander Potapenko <glider@google.com>

[ Upstream commit 09833d99db36d74456a4d13eb29c32d56ff8f2b6 ]

KFENCE does not currently support KASAN hardware tags.  As a result, the
two features are incompatible when enabled simultaneously.

Given that MTE provides deterministic protection and KFENCE is a
sampling-based debugging tool, prioritize the stronger hardware
protections.  Disable KFENCE initialization and free the pre-allocated
pool if KASAN hardware tags are detected to ensure the system maintains
the security guarantees provided by MTE.

Link: https://lkml.kernel.org/r/20260213095410.1862978-1-glider@google.com
Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
Signed-off-by: Alexander Potapenko <glider@google.com>
Suggested-by: Marco Elver <elver@google.com>
Reviewed-by: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Ernesto Martinez Garcia <ernesto.martinezgarcia@tugraz.at>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ Context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/kfence/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index edf6deb382b67..5efb063aa5c53 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -13,6 +13,7 @@
 #include <linux/hash.h>
 #include <linux/irq_work.h>
 #include <linux/jhash.h>
+#include <linux/kasan-enabled.h>
 #include <linux/kcsan-checks.h>
 #include <linux/kfence.h>
 #include <linux/kmemleak.h>
@@ -844,6 +845,20 @@ void __init kfence_alloc_pool(void)
 	if (!kfence_sample_interval)
 		return;
 
+	/*
+	 * If KASAN hardware tags are enabled, disable KFENCE, because it
+	 * does not support MTE yet.
+	 */
+	if (kasan_hw_tags_enabled()) {
+		pr_info("disabled as KASAN HW tags are enabled\n");
+		if (__kfence_pool) {
+			memblock_free(__kfence_pool, KFENCE_POOL_SIZE);
+			__kfence_pool = NULL;
+		}
+		kfence_sample_interval = 0;
+		return;
+	}
+
 	/* if the pool has already been initialized by arch, skip the below. */
 	if (__kfence_pool)
 		return;
-- 
2.51.0


