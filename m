Return-Path: <stable+bounces-48213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0124F8FCDC9
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9392B1F2A646
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B3D1AC240;
	Wed,  5 Jun 2024 12:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JszvcpbW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027971AC238;
	Wed,  5 Jun 2024 12:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589157; cv=none; b=RDuM+E/HBV2Gg2WMmUf3ngIq6jzwxMyZUxqF2XqQPXqDHTLtDpSXOf0smP1eA+lg2y9u+s5dQJxfuB2evhPnkcM6eWxHgRCE+1jUYIFh5EOCwzSls47puTtE7eR9Siyx0kLsXKs2hAOAMyUmF85kjQoc4xnVVlaM2ViBRH9h/4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589157; c=relaxed/simple;
	bh=nVJRpRaHgI+nkFlBEpSJxAeDE8zbvLSqEEqAymsMMJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FHayZfy3eSRz6nFb9MQz3FlYdxCazO3R8SVJovx0CLiCH9ohC1pAyoTrsCIy7Y4IM/BBQtxzd89dNkCdqqGoroBc8VfR9lmFsEkOWhDiQVgq8m6QD3KTxTE9T/6IJxnjbzhoUz6a5678hv0jf5/Y1YjEPgxMD3drX70DgyEXgSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JszvcpbW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A416BC3277B;
	Wed,  5 Jun 2024 12:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589156;
	bh=nVJRpRaHgI+nkFlBEpSJxAeDE8zbvLSqEEqAymsMMJ0=;
	h=From:To:Cc:Subject:Date:From;
	b=JszvcpbW45EYPcXuA8boXylLE9f5o38xvpBQPtqyqAXLLRjaUazyLEj2uQWPTv6Bu
	 R4ZRruuTlz0THdOjDb2HWp68ho5mReMFXEv7Ec3XVFcfDYwS0aYxxi7SbDatGz4LKl
	 wDyRKwEbg6kOWJU1dDr5clTPn76mk4dn8ssXppzyao3IYgHWa2ckb8Q54xs7rjj+oi
	 nk0izIh9dEQrxn7orgHpiKX1C9YnsrwL3uGVOrM3o7+xqZsHDuWYesWdf8XYzq6ESU
	 FXbfAn3xw3oFFa7VARXwC6L4I0zjFmdmLvDC15Moo1uS0iIDJ2+TUoTVnyas5MBJJS
	 3nY77hckZOW3A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 1/8] nvme-multipath: find NUMA path only for online numa-node
Date: Wed,  5 Jun 2024 08:05:44 -0400
Message-ID: <20240605120554.2968012-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.218
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
index 379d6818a0635..a4e8e7f331235 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -419,7 +419,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 		int node, srcu_idx;
 
 		srcu_idx = srcu_read_lock(&head->srcu);
-		for_each_node(node)
+		for_each_online_node(node)
 			__nvme_find_path(head, node);
 		srcu_read_unlock(&head->srcu, srcu_idx);
 	}
-- 
2.43.0


