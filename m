Return-Path: <stable+bounces-177965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14777B46FEE
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 16:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001E41B27DE3
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 14:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BE92BE65C;
	Sat,  6 Sep 2025 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwdKOZjf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1513B1CFBA
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757168004; cv=none; b=Be+/LOibRIw6TUQxBy8/m5c3aNbDkz9Vg7HCI0mXbAO9yyv7R68ecprKwNtvzT3yOL8N/ARy51rtBAz4lf4U5YQ+Js558jLfI/PVp974by4fV00igOp/Xd8PHu4IKTu1nR2nRZf/XNcmD/Zypq1KipGzxZqvZBXoV8EnaedHwbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757168004; c=relaxed/simple;
	bh=ZV3vqEnM0WAi4bjJLZPzUz7OIaGMBCuljYkxOjETmwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8NcU5KKRWjdxq3BbilnmXhWa7/c1HdHIH5SYKwgpHr8L45QJr6vOeAkLYWt8G/EgIB2ZMW8tb1JZ30CAFUWsFq98NZggi9E2EvETO0S+j015Yrvsjl3T+haEyzCNjnUz75ScYcWtN6U74Ubc+o0O06LrThIYMUHnVqWiT7EDPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwdKOZjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20A7C4CEF5;
	Sat,  6 Sep 2025 14:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757168003;
	bh=ZV3vqEnM0WAi4bjJLZPzUz7OIaGMBCuljYkxOjETmwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uwdKOZjfDR2I4qOC7N7TcjwJMwuRnGVfavFsG2vsC1lXApkBqdikqzLCkotBdPs09
	 FxzXHtTVlIQpJewbq5fgbx2AOu6jmVaFvikv0G4YRfSLFvlYUsSlH2X0iB2AQnUTj+
	 W/Uw/x8LnsIe/riFjiSKE3ru6tpH0KF1pQ95JdTAwkcrLqFfnoaWAAgA/OJ2i7yyCs
	 MIMplp679qnoxkAwHj7A7Kh6V0STL8AOyUwGOuBf09v3mXTcXNy+F4he68D4BozsbL
	 b1nSC7oHP6Y07aZxJDSkWp+0OEhNq/1Zb1V2jmkxm0VoLdBjAUEeuHY0Y7yxNOzkiK
	 m3a4PKnE455GQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] memcg: drain obj stock on cpu hotplug teardown
Date: Sat,  6 Sep 2025 10:13:21 -0400
Message-ID: <20250906141321.25877-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025032807-famished-reprocess-abd3@gregkh>
References: <2025032807-famished-reprocess-abd3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shakeel Butt <shakeel.butt@linux.dev>

[ Upstream commit 9f01b4954490d4ccdbcc2b9be34a9921ceee9cbb ]

Currently on cpu hotplug teardown, only memcg stock is drained but we
need to drain the obj stock as well otherwise we will miss the stats
accumulated on the target cpu as well as the nr_bytes cached. The stats
include MEMCG_KMEM, NR_SLAB_RECLAIMABLE_B & NR_SLAB_UNRECLAIMABLE_B. In
addition we are leaking reference to struct obj_cgroup object.

Link: https://lkml.kernel.org/r/20250310230934.2913113-1-shakeel.butt@linux.dev
Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memcontrol.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 420efa1d2b203..8938013358997 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2366,9 +2366,18 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 static int memcg_hotplug_cpu_dead(unsigned int cpu)
 {
 	struct memcg_stock_pcp *stock;
+	struct obj_cgroup *old;
+	unsigned long flags;
 
 	stock = &per_cpu(memcg_stock, cpu);
+
+	/* drain_obj_stock requires stock_lock */
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	old = drain_obj_stock(stock);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+
 	drain_stock(stock);
+	obj_cgroup_put(old);
 
 	return 0;
 }
-- 
2.51.0


