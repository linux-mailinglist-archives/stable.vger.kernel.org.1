Return-Path: <stable+bounces-125937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FE8A6DF04
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBA6A7A2EA2
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 15:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586A33D561;
	Mon, 24 Mar 2025 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hSphK0L1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AC41DDE9
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742831505; cv=none; b=jEmMSgnbuv+esRzi8d737fDGRyRmP9E/kU0gXyYOB5YOEshvuBBJ+RG/LpKic5ph+Ab5wL5du1i5uClLZy0gHyvxT8eNmaBJim5/OY1LRhhtPQK/MQfEvA+T8AlsKvtvg5P4vqbnTy4txTihumHEigHv0W6UMqZBNaaY69kxX+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742831505; c=relaxed/simple;
	bh=YVkFt9nWJemUEM4H8boJxzFO2za0CjrQrMV7wgDqB2g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kKrMuiwQ9QiVUhujgOuEnJ+OveLh5BJM6a2SKXDtMFmd6fZ0MqfxfI4obs6r477m404mJKTmW0/8YAHkR/AifCaOwld471Np5aQfZOIphEvD+KEpr05M6l2590wgYrNXCQF48LwjWBYQMa+Yrf2+1hlC/ZivkivhsSiBmQ8eYZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hSphK0L1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390CEC4CEDD;
	Mon, 24 Mar 2025 15:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742831504;
	bh=YVkFt9nWJemUEM4H8boJxzFO2za0CjrQrMV7wgDqB2g=;
	h=Subject:To:Cc:From:Date:From;
	b=hSphK0L1uyCfwfkN7mRaPADjZXHFtRKNfJhhMlIdbLSkYUjAwqWMagj3tJu9az1Ej
	 8MAF7vl/6jnAnxs42AzL36IJret4Pu+XkSTjVtE/cLnWl841duvgHedtAXy/Sqpkx8
	 Uvvf8oghVkBvKrk1UaX+xqKFXwTDYOHt5+YiUID8=
Subject: FAILED: patch "[PATCH] memcg: drain obj stock on cpu hotplug teardown" failed to apply to 5.10-stable tree
To: shakeel.butt@linux.dev,akpm@linux-foundation.org,hannes@cmpxchg.org,mhocko@kernel.org,muchun.song@linux.dev,roman.gushchin@linux.dev,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Mar 2025 08:50:22 -0700
Message-ID: <2025032421-cost-prodigy-8d3a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9f01b4954490d4ccdbcc2b9be34a9921ceee9cbb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025032421-cost-prodigy-8d3a@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9f01b4954490d4ccdbcc2b9be34a9921ceee9cbb Mon Sep 17 00:00:00 2001
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Mon, 10 Mar 2025 16:09:34 -0700
Subject: [PATCH] memcg: drain obj stock on cpu hotplug teardown

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

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8f9b35f80e24..a037ec92881d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1921,9 +1921,18 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
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


