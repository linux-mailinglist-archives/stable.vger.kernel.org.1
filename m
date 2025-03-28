Return-Path: <stable+bounces-126944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A113FA74D21
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 15:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2536D3A304E
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6858E1C2324;
	Fri, 28 Mar 2025 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XStpX9Q8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CE01BFE00
	for <stable@vger.kernel.org>; Fri, 28 Mar 2025 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743173419; cv=none; b=dCYiYCTeEYF1jdOiLvG0N7GReOcTAmINonvjI8o2PbmGGdF6BlQobmxquWfKOhk5e1GZ1girE0esPu9kJTMmaDQifklQTQ5EKhddKZP5TB29c2SDLO7t033qBLDx/aSwEjeQDPQKhtlRQsvZ4OtDxMqY3Hlrtngz/bEn/bJpFSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743173419; c=relaxed/simple;
	bh=W239FsM/QQcyF5qOMiB3Nx771fV4LnRa7VgT/KkuwB4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oc1W1kVNEK3zmvJLeMD32Q4bTCR3eBSV1Rxrj2ymDkpFfui9+ahuPvLjuenmdKTF9YxCeioCT5EhafTi7gCkIwEI+n/Lad/I2LU3B0pNe5Lo0ryM5wKbYBVY7E7OR60hZUhzyOSruAoAyYybZ6/d13cRFP3qGyAN7iHYOw9FsjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XStpX9Q8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213A7C4CEE5;
	Fri, 28 Mar 2025 14:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743173417;
	bh=W239FsM/QQcyF5qOMiB3Nx771fV4LnRa7VgT/KkuwB4=;
	h=Subject:To:Cc:From:Date:From;
	b=XStpX9Q8ugoIbC/iHCVDuUtm2R4QRoAu1/zr7o1NHRSEsQ1RU0HZLeEIPShUlHYHb
	 B1JrisZJz8+CSjAno7l+BSeDQAMg76VRzckA7+A+oIxVihjsB1jvKkdWD3rdR2Z8Sr
	 IgrZKiW0ohRL51R7z7vMSaQxFt4LuH8iedeRFXRg=
Subject: FAILED: patch "[PATCH] memcg: drain obj stock on cpu hotplug teardown" failed to apply to 6.6-stable tree
To: shakeel.butt@linux.dev,akpm@linux-foundation.org,hannes@cmpxchg.org,mhocko@kernel.org,muchun.song@linux.dev,roman.gushchin@linux.dev,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 28 Mar 2025 15:48:53 +0100
Message-ID: <2025032853-copy-crank-1c82@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9f01b4954490d4ccdbcc2b9be34a9921ceee9cbb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025032853-copy-crank-1c82@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


