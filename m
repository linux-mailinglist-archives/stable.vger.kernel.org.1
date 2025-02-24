Return-Path: <stable+bounces-118881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4344AA41D58
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2568D3B3013
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAFD21931C;
	Mon, 24 Feb 2025 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMychr3t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DEE21931D;
	Mon, 24 Feb 2025 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396047; cv=none; b=HmfnBjmLytUt4BT4tClSfkOQaXT/AoixdCFR+iX0on1f491HPigQcGnXtNBjuVCnYYrnAfB60oTkfCRcpY2qExUjxOmJjUq28yUWyq5v8OwMl2+k4/wafNpqGyzShgUeXlZij+W0bDeiuMYWh7ROQa5eoG97WWytnTZVNmgC2AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396047; c=relaxed/simple;
	bh=zMzkz1mI6jtcn7+HAEQsWDVeXJfP5TGwxGUXHph+jXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B0BL/v3UXjJKqOtz/2kVQAjwhpNvIKiZ5oZ1XZZYo8pw8HtVkdqEYUsVhi8PboctfzqipcpWuEQvr711Oq/x6cwGagp+sbgJPy29ajSXA9yb7updnxwaagtlvA15pZRKG6NpXN8dCdJ+cSyoL0eHCFFbUICEXYuqabfuvv+1po8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMychr3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585BAC4CEE6;
	Mon, 24 Feb 2025 11:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740396047;
	bh=zMzkz1mI6jtcn7+HAEQsWDVeXJfP5TGwxGUXHph+jXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hMychr3tGyKTBzGIF1szi7Z2srViMK2Lnu6Nd5XxGFPmxtSUiHB36Q+WMTaqr7e8s
	 Ou4JcprkgbFIRyiWCtvyTQjNXyGa4YYNxYRlD/WbPfvqd+BEbvOasOaafFYRMOW57P
	 pK47OiNzPXp7EBLmy+Ty4Ii4ZL0BbGIDYfqcL/7U9XNsgZkekGqT6JiZxx5Zk3eMHM
	 q+qW1MstYKY7y2Bm0iQ28WAPgL+vjQrg5WyTysF5LU9JhN0lxU/qsmqtVt1oddGclf
	 TjBr395a13LTDhsUpW041hP6DTWejzYKZJF7NiOtZduim/ueu25hsy4K/FDta6FN+C
	 TEA/HlAO7enkA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ruozhu Li <david.li@jaguarmicro.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 5/7] nvmet-rdma: recheck queue state is LIVE in state lock in recv done
Date: Mon, 24 Feb 2025 06:20:28 -0500
Message-Id: <20250224112033.2214818-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224112033.2214818-1-sashal@kernel.org>
References: <20250224112033.2214818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.178
Content-Transfer-Encoding: 8bit

From: Ruozhu Li <david.li@jaguarmicro.com>

[ Upstream commit 3988ac1c67e6e84d2feb987d7b36d5791174b3da ]

The queue state checking in nvmet_rdma_recv_done is not in queue state
lock.Queue state can transfer to LIVE in cm establish handler between
state checking and state lock here, cause a silent drop of nvme connect
cmd.
Recheck queue state whether in LIVE state in state lock to prevent this
issue.

Signed-off-by: Ruozhu Li <david.li@jaguarmicro.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/rdma.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 9561ba3d43138..3b4b2d134cf81 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -996,6 +996,27 @@ static void nvmet_rdma_handle_command(struct nvmet_rdma_queue *queue,
 	nvmet_req_complete(&cmd->req, status);
 }
 
+static bool nvmet_rdma_recv_not_live(struct nvmet_rdma_queue *queue,
+		struct nvmet_rdma_rsp *rsp)
+{
+	unsigned long flags;
+	bool ret = true;
+
+	spin_lock_irqsave(&queue->state_lock, flags);
+	/*
+	 * recheck queue state is not live to prevent a race condition
+	 * with RDMA_CM_EVENT_ESTABLISHED handler.
+	 */
+	if (queue->state == NVMET_RDMA_Q_LIVE)
+		ret = false;
+	else if (queue->state == NVMET_RDMA_Q_CONNECTING)
+		list_add_tail(&rsp->wait_list, &queue->rsp_wait_list);
+	else
+		nvmet_rdma_put_rsp(rsp);
+	spin_unlock_irqrestore(&queue->state_lock, flags);
+	return ret;
+}
+
 static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct nvmet_rdma_cmd *cmd =
@@ -1037,17 +1058,9 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	rsp->req.port = queue->port;
 	rsp->n_rdma = 0;
 
-	if (unlikely(queue->state != NVMET_RDMA_Q_LIVE)) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&queue->state_lock, flags);
-		if (queue->state == NVMET_RDMA_Q_CONNECTING)
-			list_add_tail(&rsp->wait_list, &queue->rsp_wait_list);
-		else
-			nvmet_rdma_put_rsp(rsp);
-		spin_unlock_irqrestore(&queue->state_lock, flags);
+	if (unlikely(queue->state != NVMET_RDMA_Q_LIVE) &&
+	    nvmet_rdma_recv_not_live(queue, rsp))
 		return;
-	}
 
 	nvmet_rdma_handle_command(queue, rsp);
 }
-- 
2.39.5


