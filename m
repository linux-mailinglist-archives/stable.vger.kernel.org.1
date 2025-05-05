Return-Path: <stable+bounces-140282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A32FFAAA707
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9A81B639AB
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9C6332808;
	Mon,  5 May 2025 22:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHtq7YJr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5E13327FE;
	Mon,  5 May 2025 22:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484556; cv=none; b=akVoQAqyLIEUH0VapjKjpAyCLUpSizXthm3/G9AuJayxEfRbxy4wK4KxSu282L42xGhGWL6hd8dM9zrFSXuKCInBEtGmM4ib/PCe5ksE+ZFFOgL3nIPfHBXp4vc4BvMV2J7NwTyYjAUtybIFp4LsGf6330Gl8tfu82YQcfpSuMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484556; c=relaxed/simple;
	bh=N50elTsvLV/m+xQAOHeAKX14EuZ7+WW4CerdYMMbhFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WtnW5AM/KN35LZv17xEZfWiNLn1QifTyfH4XKHxBoNFd6JOIWp9ZY4YrkkuYd/T8TQxixCdtR55bwoaNBc6PN2ndl6CeGsmd3C0HSBwDTn6xOjUI6a6qV9GWrMPXTZr0PsGgGLJkhIuAfSPO5197hGhRdAC6goKCGGx8HBZ5NAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHtq7YJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD3AC4CEE4;
	Mon,  5 May 2025 22:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484556;
	bh=N50elTsvLV/m+xQAOHeAKX14EuZ7+WW4CerdYMMbhFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XHtq7YJrgQU4euZaYr9NUkUnBusOgvwbCM8uIqKNQduS4Bg274nMq1kwcxpFqAH3U
	 +PnpN/vjDm1/XbelL2pvhtF/THUl4fVKj9f9WOWscdlY89IstWH5wP6fVeHhA7qNXw
	 o5R+4U/sSn/mMx9cNnuX+Do7hFigNSo+6WXM1Bcns/Mo6sNuSRylvQbgFFnfzDxelJ
	 SKR0jGazhOimXTJPBmHSxa82MYwWykNl5KOLGs5siSo2BSJ87ylvmHXVkb3ZTYJkfw
	 ijivj+ASHdE8kpMpvqrxvBn8+IT5ZENV0TQ4Uwx/RWos2pAL3y9brl8KGlU4M/xV1X
	 zyFxUNS4uIrJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	jdamato@fastly.com,
	sdf@fomichev.me,
	kuniyu@amazon.com,
	kory.maincent@bootlin.com,
	mkarsten@uwaterloo.ca,
	bigeasy@linutronix.de,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 534/642] net: page_pool: avoid false positive warning if NAPI was never added
Date: Mon,  5 May 2025 18:12:30 -0400
Message-Id: <20250505221419.2672473-534-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit c1e00bc4be06cacee6307cedb9b55bbaddb5044d ]

We expect NAPI to be in disabled state when page pool is torn down.
But it is also legal if the NAPI is completely uninitialized.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Link: https://patch.msgid.link/20250206225638.1387810-4-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/dev.h       | 12 ++++++++++++
 net/core/page_pool.c |  7 ++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/core/dev.h b/net/core/dev.h
index a5b166bbd169a..caa13e431a6bc 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -299,6 +299,18 @@ void xdp_do_check_flushed(struct napi_struct *napi);
 static inline void xdp_do_check_flushed(struct napi_struct *napi) { }
 #endif
 
+/* Best effort check that NAPI is not idle (can't be scheduled to run) */
+static inline void napi_assert_will_not_race(const struct napi_struct *napi)
+{
+	/* uninitialized instance, can't race */
+	if (!napi->poll_list.next)
+		return;
+
+	/* SCHED bit is set on disabled instances */
+	WARN_ON(!test_bit(NAPI_STATE_SCHED, &napi->state));
+	WARN_ON(READ_ONCE(napi->list_owner) != -1);
+}
+
 void kick_defer_list_purge(struct softnet_data *sd, unsigned int cpu);
 
 #define XMIT_RECURSION_LIMIT	8
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index ede82c610936e..cca51aa2e876f 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -25,6 +25,7 @@
 
 #include <trace/events/page_pool.h>
 
+#include "dev.h"
 #include "mp_dmabuf_devmem.h"
 #include "netmem_priv.h"
 #include "page_pool_priv.h"
@@ -1146,11 +1147,7 @@ void page_pool_disable_direct_recycling(struct page_pool *pool)
 	if (!pool->p.napi)
 		return;
 
-	/* To avoid races with recycling and additional barriers make sure
-	 * pool and NAPI are unlinked when NAPI is disabled.
-	 */
-	WARN_ON(!test_bit(NAPI_STATE_SCHED, &pool->p.napi->state));
-	WARN_ON(READ_ONCE(pool->p.napi->list_owner) != -1);
+	napi_assert_will_not_race(pool->p.napi);
 
 	mutex_lock(&page_pools_lock);
 	WRITE_ONCE(pool->p.napi, NULL);
-- 
2.39.5


