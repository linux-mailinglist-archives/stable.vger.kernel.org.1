Return-Path: <stable+bounces-48221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4A88FCEA0
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 15:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A05A0B2D854
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C141D1D19;
	Wed,  5 Jun 2024 12:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igR0OTup"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1350E1D1D14;
	Wed,  5 Jun 2024 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589172; cv=none; b=XhBxr+bvFcMuQxG1vHe+oWJW7Kc5CzjW9Z8r2QDl50t88I2shKgHa5dtLTxkHG4+QppV1ey9/TtoZ0EOhX/0tzFXEaO/zQjRcmK7XD6OvzXExX9hK5tmy72zxe88xC7WzuEFtrw29Um1hEwzVYLVIKD/m3aG3XQ1CEzGQ4ntmus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589172; c=relaxed/simple;
	bh=FyMwlV6zRQS7jXw1DmRiPuZ2aBUaTVtYyM8UZuF96AM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eO1onf30dnZIMhxZ6CI8KYQtysmQcVebcxrJD5CmyoB0AOw/Llj/xAJQXXTZevX3W3P1AfRfe4nEAVqoRMDthyk+Ufxi/iKoLwKB6QhD981ba0xYYdP+zkFkwtdVwKXXcPNrIdZv99pLajEPuXN5mPMlDlBP1Pv/tihU6DxH8m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igR0OTup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B453EC32786;
	Wed,  5 Jun 2024 12:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589171;
	bh=FyMwlV6zRQS7jXw1DmRiPuZ2aBUaTVtYyM8UZuF96AM=;
	h=From:To:Cc:Subject:Date:From;
	b=igR0OTupJOJlrKb4Ur2vakcY2JXJaoUdZ5xfiomxN0gjxO/SG196asuRp3ZPtJjBq
	 CHQZ18yDo155zKCMVgWH1MsPW5WTAXT3GthryzWXrSX3169Mof/KHzw+4KqXJvGh2c
	 4B7mV8ZlDul8lu6qUK3GyoNee62RaGsWAQyJw6onRXopGmFSq70HcgpjYB2Wl+mJln
	 kQmngoAV4Et4f4uy4woS5yhzswbT/WrYQltI+6PCIcdlZquo56th/ktw9zEaa5tN+P
	 yXhQEML+WzYOL5zL3Vs4eUJ0SaiU/ct79zarleu0dCYUaNdhEpCVFdy0DY08VjRUQ1
	 XCQBBtgjYHcrQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 1/2] nvme-multipath: find NUMA path only for online numa-node
Date: Wed,  5 Jun 2024 08:06:08 -0400
Message-ID: <20240605120609.2968188-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.277
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
index 811f7b96b5517..c993548403f5c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -436,7 +436,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 		int node, srcu_idx;
 
 		srcu_idx = srcu_read_lock(&head->srcu);
-		for_each_node(node)
+		for_each_online_node(node)
 			__nvme_find_path(head, node);
 		srcu_read_unlock(&head->srcu, srcu_idx);
 	}
-- 
2.43.0


