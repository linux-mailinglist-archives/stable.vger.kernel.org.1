Return-Path: <stable+bounces-151986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEFCAD1802
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 06:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9B016B250
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 04:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3B727FD5B;
	Mon,  9 Jun 2025 04:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="NI1fzrF7"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EBD19309E;
	Mon,  9 Jun 2025 04:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749443595; cv=none; b=fKwHljEa/gZPcuK5/XP8jI5gyhwsJx/ymuqRMwCNJeARVbh1cpb6JJZg8aJ4EX7SpxlLFamWUO/Pv2C1vGNSch17FdQAOPdlXvpWRqC1YtXj9KIOu+9tboODKM2viT3gjyer568/xs0Ou0vG9sUPCeM6mfrSRTx7TRgT7saents=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749443595; c=relaxed/simple;
	bh=7+bSEDdkuLIICSf100hVTfZ2IMYgPaUemWV4CuSRMwY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I2j6r1+SUqdEIcwcAgHKQXMSBoqeGt1plpwgeSHBJwnaJQsf+fmGTp/GyRlGkUwq0MxGtMyJL0+wFySkLS3i9AjAIS8bTvoNVyIFW8q+CJtFxWIQQiCpVF5MA6qRM3fQOp7vjklI1j46H3uYLbA64z3FbDgpGz9et8MTPk0vGaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=NI1fzrF7; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1749443595; x=1780979595;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K1IXsGeOjEMrDiz6/avTqx4a+iEDZuQrzJNH3kyvoUo=;
  b=NI1fzrF753ZGmjB8gZiWxdHuXcuaonGlved08f0dvwD8n+tAEXKAJgAY
   eeCwFL+har4LxLOPCifFcaAxL6hUPf2GfNKC9KxToiI9RrgIVm3dP9rnq
   k0fHDhZuYsS9Am4TiWm/NC1TgytGt3pHsesAp6RdUyNox+Oc8GnCfpDaC
   jE0Dr/7qyTrfjAPpKPtHLUFa43tU5/7ZtGRsYX411oDVwZ6bXTjk3o3AQ
   yun51rAnZNUKqrmkc84B+rDPZmdptnbOWCxC3OdXmtNlFushI/MOwFoPZ
   q/3U+K+dDaInbfLo9WeU7h3P5oi7HWClKA6MeYxITa2g9FZ7/QJ9TOUUh
   A==;
X-IronPort-AV: E=Sophos;i="6.16,221,1744070400"; 
   d="scan'208";a="306689927"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 04:33:14 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:63521]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.32.98:2525] with esmtp (Farcaster)
 id 267c9614-9b46-44a6-817f-8e49af2d718e; Mon, 9 Jun 2025 04:33:12 +0000 (UTC)
X-Farcaster-Flow-ID: 267c9614-9b46-44a6-817f-8e49af2d718e
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 9 Jun 2025 04:33:12 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Mon, 9 Jun 2025
 04:33:09 +0000
From: Eliav Farber <farbere@amazon.com>
To: <davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>, <yoshfuji@linux-ipv6.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <sashal@kernel.org>,
	<edumazet@google.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <stable@vger.kernel.org>, <farbere@amazon.com>
Subject: [PATCH v2 5.10.y] net/ipv4: fix type mismatch in inet_ehash_locks_alloc() causing build failure
Date: Mon, 9 Jun 2025 04:32:59 +0000
Message-ID: <20250609043259.10772-1-farbere@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

Fix compilation warning:

In file included from ./include/linux/kernel.h:15,
                 from ./include/linux/list.h:9,
                 from ./include/linux/module.h:12,
                 from net/ipv4/inet_hashtables.c:12:
net/ipv4/inet_hashtables.c: In function ‘inet_ehash_locks_alloc’:
./include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast
   20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |                                   ^~
./include/linux/minmax.h:26:18: note: in expansion of macro ‘__typecheck’
   26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
      |                  ^~~~~~~~~~~
./include/linux/minmax.h:36:31: note: in expansion of macro ‘__safe_cmp’
   36 |         __builtin_choose_expr(__safe_cmp(x, y), \
      |                               ^~~~~~~~~~
./include/linux/minmax.h:52:25: note: in expansion of macro ‘__careful_cmp’
   52 | #define max(x, y)       __careful_cmp(x, y, >)
      |                         ^~~~~~~~~~~~~
net/ipv4/inet_hashtables.c:946:19: note: in expansion of macro ‘max’
  946 |         nblocks = max(nblocks, num_online_nodes() * PAGE_SIZE / locksz);
      |                   ^~~
  CC      block/badblocks.o

When warnings are treated as errors, this causes the build to fail.

The issue is a type mismatch between the operands passed to the max()
macro. Here, nblocks is an unsigned int, while the expression
num_online_nodes() * PAGE_SIZE / locksz is promoted to unsigned long.

This happens because:
 - num_online_nodes() returns int
 - PAGE_SIZE is typically defined as an unsigned long (depending on the
   architecture)
 - locksz is unsigned int

The resulting arithmetic expression is promoted to unsigned long.

Thus, the max() macro compares values of different types: unsigned int
vs unsigned long.

This issue was introduced in commit f8ece40786c9 ("tcp: bring back NUMA
dispersion in inet_ehash_locks_alloc()") during the update from kernel
v5.10.237 to v5.10.238.

It does not exist in newer kernel branches (e.g., v5.15.185 and all 6.x
branches), because they include commit d03eba99f5bf ("minmax: allow
min()/max()/clamp() if the arguments have the same signedness.")

Fix the issue by using max_t(unsigned int, ...) to explicitly cast both
operands to the same type, avoiding the type mismatch and ensuring
correctness.

Fixes: f8ece40786c9 ("tcp: bring back NUMA dispersion in inet_ehash_locks_alloc()")
Signed-off-by: Eliav Farber <farbere@amazon.com>
---
V1 -> V2: Use upstream commit SHA1 in reference
 net/ipv4/inet_hashtables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index fea74ab2a4be..ac2d185c04ef 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -943,7 +943,7 @@ int inet_ehash_locks_alloc(struct inet_hashinfo *hashinfo)
 	nblocks = max(2U * L1_CACHE_BYTES / locksz, 1U) * num_possible_cpus();
 
 	/* At least one page per NUMA node. */
-	nblocks = max(nblocks, num_online_nodes() * PAGE_SIZE / locksz);
+	nblocks = max_t(unsigned int, nblocks, num_online_nodes() * PAGE_SIZE / locksz);
 
 	nblocks = roundup_pow_of_two(nblocks);
 
-- 
2.47.1


