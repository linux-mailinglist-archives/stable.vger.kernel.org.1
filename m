Return-Path: <stable+bounces-141277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42E1AAB233
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DCF83AE83F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7A23671A9;
	Tue,  6 May 2025 00:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDRtQETv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2434E2D4B49;
	Mon,  5 May 2025 22:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485660; cv=none; b=p1AeYbp+bdbzU4Dv/Za+G7zs2AG0nB1/mrQuiEZCOBL7Whi9W64hQcktzLS7/AT1egzs4toPcwL7K9vJVFKOlNusGPCmAdSm2srJvWwtDJznOvq94V56HmbeDhvg7YtQex895I+AbuNbmH+2a/Y/ojXYYs9PALLQcgAJXZYZvv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485660; c=relaxed/simple;
	bh=bpkrz8KBNf3ONWBnGX36j1LvOm1wwo0jVhbLIIk0ZOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jxbzES4OI6Ui8NX09xfR7vBbS33HKWmroo+CYrWye/Ect4kcgaN43SbAbG+zec69rUcCSekJ0VbhZ4x932W22cLR0NkIbvZ+n2IBu96TOcJ/DgStJdrqTVyVuhy0LyLqCcAs3IlFOlz729lUT5U5yorXabqaH/GqBSEfdVgBq2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDRtQETv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44702C4CEE4;
	Mon,  5 May 2025 22:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485659;
	bh=bpkrz8KBNf3ONWBnGX36j1LvOm1wwo0jVhbLIIk0ZOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CDRtQETvnqghjafQBDajbDdkbVtdJvCMegOb0BqNO8MaOWUPNOd35XCz1pd04nmQ+
	 6TG0VnW0/X4F2hfHtgSsVfluhdxZDdF0pQGnOaZ2HsK9so3QsrzsXblENhTZZ0QMdE
	 2rXrVgztQCLuyrRbRf8zMmmU6EGTIdmwcBFUk03KlLio51lemHLo+gFPzU23NHxDEG
	 2muKeAzhx1SfXmhO5czhQt9JiTXKSwBleS1uHxs4muL+1xybSJuC0x8+Mt5v4eAzHb
	 z0Un/a0YYR9I/TsoQYOAip7SxY2Y4e2OzIBrlVYSaPVBh/aCr0/lzUv/M0e1c5a+3n
	 6LkpccVBiW3BA==
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
Subject: [PATCH AUTOSEL 6.12 412/486] net: page_pool: avoid false positive warning if NAPI was never added
Date: Mon,  5 May 2025 18:38:08 -0400
Message-Id: <20250505223922.2682012-412-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 2e3bb7669984a..764e0097ccf22 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -148,6 +148,18 @@ void xdp_do_check_flushed(struct napi_struct *napi);
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
index 7b20f6fcb82c0..c8ce069605c42 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -25,6 +25,7 @@
 
 #include <trace/events/page_pool.h>
 
+#include "dev.h"
 #include "mp_dmabuf_devmem.h"
 #include "netmem_priv.h"
 #include "page_pool_priv.h"
@@ -1108,11 +1109,7 @@ void page_pool_disable_direct_recycling(struct page_pool *pool)
 	if (!pool->p.napi)
 		return;
 
-	/* To avoid races with recycling and additional barriers make sure
-	 * pool and NAPI are unlinked when NAPI is disabled.
-	 */
-	WARN_ON(!test_bit(NAPI_STATE_SCHED, &pool->p.napi->state));
-	WARN_ON(READ_ONCE(pool->p.napi->list_owner) != -1);
+	napi_assert_will_not_race(pool->p.napi);
 
 	WRITE_ONCE(pool->p.napi, NULL);
 }
-- 
2.39.5


