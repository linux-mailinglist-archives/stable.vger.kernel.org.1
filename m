Return-Path: <stable+bounces-226533-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKCkJUaKuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226533-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:07:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 308FB2AEF97
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8431307E87A
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FF73F0778;
	Tue, 17 Mar 2026 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2SPpp7O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06895332604
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767112; cv=none; b=fq1iAVJv5lgHbH0+JpFHxvaRqyyZdMXhVXPgd64xUtrxUGj/jcVefBFxqb9vbZermMDyWlDZApnjenfaqJy05YeDoy/cqJ/Yc3j00AxJR0jiLz8WQWFgZp/kpW1TDMON0cIhnpKjwzIBR3+rtJ3gW8JaL3D0yYXPUIvtuw1cDuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767112; c=relaxed/simple;
	bh=e4xMtnDeKyB7PvCGE3vq4Y6ib+TJDGqMPkMU2n1Z2kA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9Na1fL3Gf3sAQgimdslcB3nZ4ua10MRXBGabZZRendlx0jHp0aEQw0dK6QQJKPx1jV/kJ1Jk5DsdPNXLE+9exIveFbk98cCe2JKT5b+sKpUcoEm6tzsFSA/fyRdndM/fc9LmVJdn0QYcHnLO4FhCvbWVJ3mls/qxuNZSrb80Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2SPpp7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC0CC4CEF7;
	Tue, 17 Mar 2026 17:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773767111;
	bh=e4xMtnDeKyB7PvCGE3vq4Y6ib+TJDGqMPkMU2n1Z2kA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l2SPpp7OvzfPH+5LcD8mxS9aj4wqIV9SYvV2I1dzUUR56qmI/AZqaRnJWIaR6Iri/
	 1bb+OgG8odsrACh8gAceW7yVOkuJAvKLtPKutDi52JO9JnwciEN1EO75VBk7bx2TGL
	 OQLelTWgf0rkWVEo8Dq5nOExz3w8qvCzp7GgSyeKS0Q4Lddq/3eY/TcaT3oUibtUMA
	 XtfwPpYnPaeVuPe8V8BpOJ6TcxNKqVPoIUXpF6qLel/DNtzbljFkaq7R39lLZjMtZ5
	 9UnBTcrMymzGqFv4iLvudjURaG3meE00d3W8uYJNiyBMeS7uTYOdAvvD8Oc53ijhu4
	 YMKOJh1VM1yaw==
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
Subject: [PATCH 5.15.y] mm/kfence: disable KFENCE upon KASAN HW tags enablement
Date: Tue, 17 Mar 2026 13:05:08 -0400
Message-ID: <20260317170508.231008-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031757-abreast-angling-34e3@gregkh>
References: <2026031757-abreast-angling-34e3@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,gmail.com,tugraz.at,linuxfoundation.org,kernel.org,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226533-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linux-foundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tugraz.at:email]
X-Rspamd-Queue-Id: 308FB2AEF97
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
[ replaced missing kasan_hw_tags_enabled() with equivalent IS_ENABLED/kasan_enabled() check, used kasan.h header, adapted memblock_free() to phys_addr_t API, and targeted older kfence_alloc_pool() function name ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/kfence/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index e1a555eeec459..9efcf2a4e54f9 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -13,6 +13,7 @@
 #include <linux/hash.h>
 #include <linux/irq_work.h>
 #include <linux/jhash.h>
+#include <linux/kasan.h>
 #include <linux/kcsan-checks.h>
 #include <linux/kfence.h>
 #include <linux/kmemleak.h>
@@ -807,6 +808,20 @@ void __init kfence_alloc_pool(void)
 	if (!kfence_sample_interval)
 		return;
 
+	/*
+	 * If KASAN hardware tags are enabled, disable KFENCE, because it
+	 * does not support MTE yet.
+	 */
+	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS) && kasan_enabled()) {
+		pr_info("disabled as KASAN HW tags are enabled\n");
+		if (__kfence_pool) {
+			memblock_free(__pa(__kfence_pool), KFENCE_POOL_SIZE);
+			__kfence_pool = NULL;
+		}
+		kfence_sample_interval = 0;
+		return;
+	}
+
 	__kfence_pool = memblock_alloc(KFENCE_POOL_SIZE, PAGE_SIZE);
 
 	if (!__kfence_pool)
-- 
2.51.0


