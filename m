Return-Path: <stable+bounces-118859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535EDA41D09
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C91037AA65A
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C1C26BD9A;
	Mon, 24 Feb 2025 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjsngUxP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7B126BD93;
	Mon, 24 Feb 2025 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395993; cv=none; b=hZOo1M5UHn6OyAIWW7CHlFUpoCJFscQ2vQmzap70PcMhpiaQrqQaARwNtLvz7FX5+xDAELpMnOQbLMphij8KFj8tkhQJqlpJYgKPabqU0jwqml70JESwVOhfy2WItp6GY9VLa1OV4QdZMYje/1bE2gSSbux9HnAv1ti6QZoInyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395993; c=relaxed/simple;
	bh=WhZhiJFmlviInd25I00iuuq/F/ZpFPymnJWovYMggBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oym/aEQ49j9zlHIk+GyLEnm09X9F8P0UzslxLA/Gc6n6MO0AGJY0zSdUp0hZKWw0Y30xc0YVrQHyWwf0jFLnpG6Dey6imYPVa4IpwEkiVTZCRB8W7MSKyysVe5pwYOiyZ0vNuW8gA5fxboMznuzDDkIbudp5jOe/ByYAuHGaUKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjsngUxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54833C4CED6;
	Mon, 24 Feb 2025 11:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395992;
	bh=WhZhiJFmlviInd25I00iuuq/F/ZpFPymnJWovYMggBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tjsngUxPR7tQytsdc0FIkunukPl/MO2rvHGJl0qrboKDtK9w0D/vVOEo2Gg6/qmw7
	 MjVP4tKigV4AdYSpXFSk5IUFdxhYvoREi6U97Y5kfXv13a2d4/KhccVIPOJwqgWyy3
	 JgNhKLaeSC7eFiA687lnkJ5ke8W28DV6Z0/DPT722ZV/f22JhRmGviJCN8z1RaqJJb
	 NWSktasehkVUlp2nnHCkgg1YXhq2nUOIz+dMO68coVgp5Yq1a2FFvmpKUvVZQcbAhu
	 spQnNVOKelS+MrpezkDKNneC6he1OQfoc3HmJ76wJR5w6NukXnj6yg4CoxrqJGbzKg
	 8BV1nXpvQh3lg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ruozhu Li <david.li@jaguarmicro.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 15/20] nvmet-rdma: recheck queue state is LIVE in state lock in recv done
Date: Mon, 24 Feb 2025 06:19:08 -0500
Message-Id: <20250224111914.2214326-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111914.2214326-1-sashal@kernel.org>
References: <20250224111914.2214326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.79
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
index a6d55ebb82382..298c46834a539 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -997,6 +997,27 @@ static void nvmet_rdma_handle_command(struct nvmet_rdma_queue *queue,
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
@@ -1038,17 +1059,9 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
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


