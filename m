Return-Path: <stable+bounces-177963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3240B46FD5
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 16:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DC2F1632EB
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 14:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0568329D27E;
	Sat,  6 Sep 2025 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgFRJqb1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73E822DFA3
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757166993; cv=none; b=LCmgaqdy7CrZzkb46WeQC2JArGyuW1O6u1dTlA2xCDNWFxEoKPQa0xPdHAUjWy9QiebVlkqNIhfpqRi0DjXTNqlOJsZVqy9SWcQyf+mIrxp6sSBamThievQ9JUn8eFfFpShQkczR4sLjR+zZigxlXi1IHSrBa0R4c0nrwQ3Sp1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757166993; c=relaxed/simple;
	bh=ZV3vqEnM0WAi4bjJLZPzUz7OIaGMBCuljYkxOjETmwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LH6K5ea/KqQncWsVrJoYD3b0GT4U8jObbVgtHkLSbMxKTgPDF5lOjy8oKR821qNhj6NWfM3D8hqGIZkxK8mMnT8kOoYuXyRz1R5eJcGb+IU6TAo58YI62eBJJaq7zvtT2j67ZF58Xs3DdlCn92qniiBHRaKb6unNjnogooY6eR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgFRJqb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C916C4CEE7;
	Sat,  6 Sep 2025 13:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757166993;
	bh=ZV3vqEnM0WAi4bjJLZPzUz7OIaGMBCuljYkxOjETmwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RgFRJqb1YLPj6Ve5NwSmo34qAfldLv31t+OC/yypQx2TKZ+jnNX21OL4l3FZ1Cqsj
	 F81Guk0xMA1h+bAXhAzc7P1aHkiX3gUcTp05zTy6NGCzulA5H/ly8NwccgPSc7Lm0v
	 3uA9nplyeUwTRsYqOXSgh2X8YMlFdlvFp2Dtkxzl8cSq7aOFtofWZ9WpHVfr9DnR0I
	 ddFjDxlbwUjmpQENqaJvokybiF/CtpYEDBdTZdrSfcnSexm1O5R9QE3rmqMoPG6xSs
	 rP4sAWGO+vtpFgAYufNG/JEwRF2yY6piCohXZrOiKfyY2lmgsK+ccSm+KP1D7oD/S7
	 oXKApSkhv48Yw==
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
Date: Sat,  6 Sep 2025 09:56:30 -0400
Message-ID: <20250906135630.16941-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025050155-approve-flatly-068d@gregkh>
References: <2025050155-approve-flatly-068d@gregkh>
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


