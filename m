Return-Path: <stable+bounces-177960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B214B46E33
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 15:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44A417B8CC4
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 13:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B92286D7C;
	Sat,  6 Sep 2025 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRgNJAnV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953DD2773E6
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757165599; cv=none; b=QhqFSlIWOzpInN+Fu59vjRCqSCNLz2l83KTckm3BZI/xELZ1f+wQo2R+G14QD9lbFKB2lmocLi5oCCKzVXrpWzrhnAJH+eWDGbvjbZcPbf6mMTlVAjk5wGbv+HS6cchj+LDYCqnaY2Ib8sH8T3FEXsSPMiYCJquXDZyGgXUkgL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757165599; c=relaxed/simple;
	bh=7bjUI+rrm2mZGbrniHbTzQo84U0pFOpKzCBSMiTgqVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fge48KddvOpxwXMMUjtfXAYRlB2seoRfxiSmSWiXp3+S0PrwJIeTND1hrhIVKC+0zVixPEUyUQu94WUXTtkL0Is/irBxjTwLxKNMFEqwGpryI3lFdpOGqpKpR2Jd1hg/BwCVfUbqqC0fD4AYT5hA+lTZASqtbQCS7BFa5/fYYJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRgNJAnV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255F4C4CEE7;
	Sat,  6 Sep 2025 13:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757165599;
	bh=7bjUI+rrm2mZGbrniHbTzQo84U0pFOpKzCBSMiTgqVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sRgNJAnVJmE7WEcQz7SHGWKYMBlOvns4cv+jeVS6xvDBd8nTtqrbU1gnKRN+J8l56
	 CRXmRZV50DoIqAneEo/FZkv3gj8wTej/kSIp/417C/HlrbvgInsJFMWxtiVv6tRZfC
	 booQ7YMg3VCkGiHjmU+PpbVaxzqa+uv28Gz0+YFVPxQ5YXMvs271f6twCLTvZW25hc
	 aTnQrBlSLzbjpi6IJ0EXwu2JHnGbfDy82uB8wrlA8sv1swkH/miYW4/8RGszI0nfTH
	 LyWpYSyOIHN9cqgbxTy5uSMAEoJG1QjLuCvxeX508ArtSu4qhbYOGU25jUvZn2fE4g
	 9CZzri/qiJvCA==
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
Date: Sat,  6 Sep 2025 09:33:16 -0400
Message-ID: <20250906133316.3895732-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025050154-cubical-audience-b6a2@gregkh>
References: <2025050154-cubical-audience-b6a2@gregkh>
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


