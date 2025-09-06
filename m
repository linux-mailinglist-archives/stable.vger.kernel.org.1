Return-Path: <stable+bounces-177962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CD3B46EC8
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 15:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3C67C70EC
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 13:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316A71F1921;
	Sat,  6 Sep 2025 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqvX65gI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C671B4244
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 13:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757166529; cv=none; b=tKl+GNiXjsaOzwAxZeY2zsu6bYUdWtYKMxcjvDaUxyhGmbHNbvNI6QtyYorWA3uhAwcrG0IKMu8tZk3EoKhxhznXsRZpO6l/HJnKxYtC8FFBKEyUY4d8wtl5aHVX8dmh27d7zY9L7XaM9oRXbmSFYrYQnrnVrMUeXcfXhmVFQz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757166529; c=relaxed/simple;
	bh=7bjUI+rrm2mZGbrniHbTzQo84U0pFOpKzCBSMiTgqVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lze1Ou/7Uw1kdqv5GyF1Jy3UBEoFwqy8xlprP4LNtF7BtkuEBob/byVVKVTT1n/13D9dW5eS8oVmvHb6ICtb2Gva0SNB0TJQNF9Fr1wpM4KEeAGGGEyH0vLhv6bLRfPsohDIxlQeTa3CN1pkuEzICwx8L94UMJVIQpfT3SYmsbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqvX65gI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D89CC4CEE7;
	Sat,  6 Sep 2025 13:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757166528;
	bh=7bjUI+rrm2mZGbrniHbTzQo84U0pFOpKzCBSMiTgqVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LqvX65gIOZy/42tbfojrk+ATjUuGFNRODjZ4FnVPgxMPYuixNOJoFW7xw7Re4GMC3
	 Te/eiXQidXZW3r/C6TLFPXowC5Pyn4rFsj/R8LE3Ry+65fCIa764MSv4IRzB8f7Xn8
	 ItqSoSSOrz52IBeKbriu5p8cIBe/XfoLhOOl32kcNarLTCXbbeZrriZfA5Pt0c+Rp9
	 rumAfAjJ+IggzGLwTErw106o1320O9OsLDLRvowVFXofOcjJcTY92tkGfPdhsGIF7Z
	 F/Olg9WKODfRJPhyJtIaE79MlJqjYz5GFO2oWII92OfeeQEx0ip8jhigKziaiTFimi
	 epCwIRuH2LLAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] memcg: drain obj stock on cpu hotplug teardown
Date: Sat,  6 Sep 2025 09:48:45 -0400
Message-ID: <20250906134845.8414-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025032853-copy-crank-1c82@gregkh>
References: <2025032853-copy-crank-1c82@gregkh>
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
index 2d2cada8a8a4c..87e3f7761f561 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2376,9 +2376,18 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
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


