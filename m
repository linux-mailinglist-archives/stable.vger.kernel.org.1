Return-Path: <stable+bounces-118874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189DBA41D3E
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59613A656E
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A8D27FE79;
	Mon, 24 Feb 2025 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOjvUXUu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5467F27FE71;
	Mon, 24 Feb 2025 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396027; cv=none; b=Jz5PSAzhJOurkmyRqpEtF5koaKIz0iDCYUxAWnUhstX9eIy2l/9yyrKr5wHupSU/uV9dUmgQv4IN6mZ/yppwHZq4k56LHxiNpOk6QFnBiMIF2Vvm2nCPJYBbwWG5MxNl4Doj556PkDe7ww0u3MltjVf8ddfBxasv3/7KNis6UnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396027; c=relaxed/simple;
	bh=WhZhiJFmlviInd25I00iuuq/F/ZpFPymnJWovYMggBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yd0jn3+EsOEtw0ermBW9H3n+yGy+lg8OW2a58GSMS8r9YGKr4arF+c3MxuHqTbZna4ymn1xdyjuo/8ce0jEkqb39KRSlCngCkTpAYu5KTLMV63jfgWKnfrs/ja1IgTJUN4vTn14fHX5gPtjegfRCUbsERFaDu2ImVWipz+t4Q3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOjvUXUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6DCC4CEE8;
	Mon, 24 Feb 2025 11:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740396027;
	bh=WhZhiJFmlviInd25I00iuuq/F/ZpFPymnJWovYMggBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TOjvUXUu9ZTIO7G/dgvA0obQaOWwbJ6LbOpub9/LRiTOjZTTPAe2plh/ZS4//HcUr
	 a4cfs9uP4p939slsU863zONMCr/gn7XUB2ZW+kfwLcPU6D3k1ehLzIG5XM6DZK7M8h
	 DAlk2k2bqqIJCS2dDRF/7s8iMarDrnTm5UsIicdVdF/OAFhTMVW8/bC+tqOKPu2me4
	 5TFglBpySyrLcYz8TC3cIcjMYio71PWKWA3sAewhbMgsgNeICwWWLsml+PSYIcZFpC
	 3uQ1165uga8nz8dUB4/CXasdTNqWCRt0zb0vC+TY9o1A47g/091i36P8MvqM8yPJ49
	 zVlgZDfnUqLVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ruozhu Li <david.li@jaguarmicro.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 10/12] nvmet-rdma: recheck queue state is LIVE in state lock in recv done
Date: Mon, 24 Feb 2025 06:19:58 -0500
Message-Id: <20250224112002.2214613-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224112002.2214613-1-sashal@kernel.org>
References: <20250224112002.2214613-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.129
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


