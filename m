Return-Path: <stable+bounces-48151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D0F8FCD03
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6C71F21F20
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534F91C2246;
	Wed,  5 Jun 2024 12:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJ+BX1TL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8571C2240;
	Wed,  5 Jun 2024 12:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589002; cv=none; b=r2Stwn/+QRctb0VrNqFBRnhViuWrPCEqMmD2L4NqtCdhh3u3ObNJt0fgbxWXTe9UzDPy6v6Uknu2NVW9RgG+aPhcYBEfCpQhi8OboA+EClQW0fVNgLeYJRWnJGlbERo+hMssgKCLEmNt84P56r20vuaGhyPd8vKns5KYBDLM+FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589002; c=relaxed/simple;
	bh=vp7txUi8D2St2iqv2V5exkdfuTRTiuxEQ5umbddoIao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zxfu8pyGHmwORKJjF7IszYAFlWt0r+daiRxlQx0pO0rdmCSxDeO+YJWEtWSiyNgY85z3mzp/0pdsD0D1WJiaXlqfyRT0m/uhDP4klvXU6YAdAWPKTcqLEScs1RLOa5o9eNcOB6SRD+NvNlYJLnrjL+DqkAxrAABNrnDHC+SfwxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJ+BX1TL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01387C32781;
	Wed,  5 Jun 2024 12:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589001;
	bh=vp7txUi8D2St2iqv2V5exkdfuTRTiuxEQ5umbddoIao=;
	h=From:To:Cc:Subject:Date:From;
	b=kJ+BX1TLZ/LCkV87oxxoZjz0VCBhepmeIjsRu4FNIhtCCXuL6L0MNdejBjVS4Juuy
	 lbTV8sLjIn53FxfE0Nc047mPSv4wPQXmW7EuMnEUZ5B3luGTeNKfKPgb0ZajbEzriO
	 xAiBp89/urhT/kIROtvFoPy3OMunhYd4s2c9ca+Yn76C7Uz4dExXUlZO/wobpCAxBY
	 aRw9E+ktBvMzq/siwycfu/7EV0vDHCDatmZKSfgXQG3Q2VY947xuIiZH1b/wV5v8mR
	 19AMRYaf86gsuocv15A2ztRbz2mZB+9lSnYRSOXyHdPiMNt97XoBuNDnFWkKM10yk8
	 aQH0b0p4vKt0A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.8 01/18] nvme-multipath: find NUMA path only for online numa-node
Date: Wed,  5 Jun 2024 08:02:51 -0400
Message-ID: <20240605120319.2966627-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.12
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
index 75386d3e0f981..615fbdc09d1cc 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -594,7 +594,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 		int node, srcu_idx;
 
 		srcu_idx = srcu_read_lock(&head->srcu);
-		for_each_node(node)
+		for_each_online_node(node)
 			__nvme_find_path(head, node);
 		srcu_read_unlock(&head->srcu, srcu_idx);
 	}
-- 
2.43.0


