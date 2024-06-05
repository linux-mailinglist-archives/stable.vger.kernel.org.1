Return-Path: <stable+bounces-48169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 970038FCD4D
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44BF1C232DD
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B9A1C6190;
	Wed,  5 Jun 2024 12:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LksSl/7s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAA41C618C;
	Wed,  5 Jun 2024 12:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589051; cv=none; b=AdU8LyjkixmeUhLI/YYle0rQqfivcDbxG+eZ18TyR9oR9X1Gyfv8olfKZWA6P7f6BiOuhoSjplU5tQmworRENiMc1JC52Jpno7F1aRoIZKZhwOU5Hw0iGNlNjnFtyfpd0u/9qcjpRf2opuEhrFri97UeQttXbELjEQ8QYM9OtMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589051; c=relaxed/simple;
	bh=lsSnOw/I7PMfIGzl4KME7Z/oNsBryNMwUMCncRfe738=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o6F4uuJVUkAr6Ko2Qlk74AeiRPsVXEJcFZSrUrJhxAIseS0pNR8U8GXdkxG7wehOqLt0oSQWzK31qMvplp0OYqWRca3Q7ubnYlfYuL7tqgbqOM2bGoXPsGJ59c1G9f0rAlKQP7unX8hdz57Fedh4lxtpIfbSEkeYicATSRyX/mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LksSl/7s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BB0C3277B;
	Wed,  5 Jun 2024 12:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589051;
	bh=lsSnOw/I7PMfIGzl4KME7Z/oNsBryNMwUMCncRfe738=;
	h=From:To:Cc:Subject:Date:From;
	b=LksSl/7shuJUqm8jngnyi56asL30++7+Fh5WDIztbsg7ABt4fOMDGiwSn0//Haw/d
	 39joLO9L4H3Pr7kai/VkCJCajkGcTIaq9BkgOSPz6w3PWTqGyGTzMNKiLY8HbFpENU
	 Oph3vc6xRXFBIjboZyDi9MPKz+NFd29++EtpnDS6kuxNEkSVyQ7fXMHvRncZJQr7BU
	 Y7csAdgIkfvpeKBwHh1KQaBNewXvlltBnLyrgv918IY/a/hO958FMkxTz/1wzczOh9
	 nEJ9IAta+veum773UPfu3CGD23Desw3W6eA2PvB3bG4ki7dIpMjxwE4XyFScj62uEG
	 F+w6sOk3E8nwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 01/18] nvme-multipath: find NUMA path only for online numa-node
Date: Wed,  5 Jun 2024 08:03:40 -0400
Message-ID: <20240605120409.2967044-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
Content-Transfer-Encoding: 8bit

From: Nilay Shroff <nilay@linux.ibm.com>

[ Upstream commit d3a043733f25d743f3aa617c7f82dbcb5ee2211a ]

In current native multipath design when a shared namespace is created,
we loop through each possible numa-node, calculate the NUMA distance of
that node from each nvme controller and then cache the optimal IO path
for future reference while sending IO. The issue with this design is that
we may refer to the NUMA distance table for an offline node which may not
be populated at the time and so we may inadvertently end up finding and
caching a non-optimal path for IO. Then latter when the corresponding
numa-node becomes online and hence the NUMA distance table entry for that
node is created, ideally we should re-calculate the multipath node distance
for the newly added node however that doesn't happen unless we rescan/reset
the controller. So essentially, we may keep using non-optimal IO path for a
node which is made online after namespace is created.
This patch helps fix this issue ensuring that when a shared namespace is
created, we calculate the multipath node distance for each online numa-node
instead of each possible numa-node. Then latter when a node becomes online
and we receive any IO on that newly added node, we would calculate the
multipath node distance for newly added node but this time NUMA distance
table would have been already populated for newly added node. Hence we
would be able to correctly calculate the multipath node distance and choose
the optimal path for the IO.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0a88d7bdc5e37..6a444ce273366 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -592,7 +592,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 		int node, srcu_idx;
 
 		srcu_idx = srcu_read_lock(&head->srcu);
-		for_each_node(node)
+		for_each_online_node(node)
 			__nvme_find_path(head, node);
 		srcu_read_unlock(&head->srcu, srcu_idx);
 	}
-- 
2.43.0


