Return-Path: <stable+bounces-54930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C46913B4B
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 15:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4F51C20D1B
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 13:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185D5195980;
	Sun, 23 Jun 2024 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNnvGdrC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA13019580B;
	Sun, 23 Jun 2024 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150314; cv=none; b=SCXJoMKVk8G9wQPuiw7QXqAAbeMlqvExcYvuYp26+UmYk3j0B59qHM3muMhWyUJfGxxzajLaTGrc+atkvpAxTq/EvwLRGcDNyidVPHDZ3LgQ0ZG1+FZQL7Bz8eBemgGiQuDtwV3LUKuNFAZQkudxsVeEajf8hN4ObZxSEF7tCt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150314; c=relaxed/simple;
	bh=XnkzjUGnmHtfejr5zlO70LbC+m3sC+G88oEw09wDnZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfYz8j+Ojh+rUtP7tssoSWq3KLHqwslu13hJ/kzrMweIAUq5w43TYVriLhN71B0s7oRNld+vOylZ+s9WSHMHBi8AmUPO2dEa9WEh0RSMxYTQjLB2YJi4wT/0cU/ZbNJgy8qLxtkPBEuk6hylvmUFy1quxlF67RtlK0e4W8ueJIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNnvGdrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9625EC32781;
	Sun, 23 Jun 2024 13:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150314;
	bh=XnkzjUGnmHtfejr5zlO70LbC+m3sC+G88oEw09wDnZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VNnvGdrC9V41pRrnrgAsDy7HJHvCB3p41q5fT+tIxolZzfejm5aIxTJLb+ygrXaz0
	 6obvJbotQPswlWmTki8G5xfGdgIiTdpZOa2PnuHaoTrvA0/wOC3FszgP4fSnv9Wc5f
	 QU4Ng4IQKpNvL3CS0Ca5SMFC8W3HcGYlqnYBRKENwbwV3jrUdmc2Pz8OOiemJdBlqy
	 1qrzvWgdsXg2Fia6atMSydqHG8kCZjpqiM+3Mr0CcjARhJTggRaPoiRkOnV6FPdlmn
	 aFHr/Tt6x/puxZ6MSByAtQvSr2FgiwIUW6i3L/aKZLKikse4hcizT2Il6Qy9dBGjKC
	 wZW5CfH95a7tg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 16/16] nvmet: always initialize cqe.result
Date: Sun, 23 Jun 2024 09:44:45 -0400
Message-ID: <20240623134448.809470-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134448.809470-1-sashal@kernel.org>
References: <20240623134448.809470-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.35
Content-Transfer-Encoding: 8bit

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit cd0c1b8e045a8d2785342b385cb2684d9b48e426 ]

The spec doesn't mandate that the first two double words (aka results)
for the command queue entry need to be set to 0 when they are not
used (not specified). Though, the target implemention returns 0 for TCP
and FC but not for RDMA.

Let's make RDMA behave the same and thus explicitly initializing the
result field. This prevents leaking any data from the stack.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/core.c             | 1 +
 drivers/nvme/target/fabrics-cmd-auth.c | 3 ---
 drivers/nvme/target/fabrics-cmd.c      | 6 ------
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ce7e945cb4f7e..61bf1bc1ac243 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -936,6 +936,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	req->metadata_sg_cnt = 0;
 	req->transfer_len = 0;
 	req->metadata_len = 0;
+	req->cqe->result.u64 = 0;
 	req->cqe->status = 0;
 	req->cqe->sq_head = 0;
 	req->ns = NULL;
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 1d9854484e2e8..c103eba96350e 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -332,7 +332,6 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 		pr_debug("%s: ctrl %d qid %d nvme status %x error loc %d\n",
 			 __func__, ctrl->cntlid, req->sq->qid,
 			 status, req->error_loc);
-	req->cqe->result.u64 = 0;
 	if (req->sq->dhchap_step != NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2 &&
 	    req->sq->dhchap_step != NVME_AUTH_DHCHAP_MESSAGE_FAILURE2) {
 		unsigned long auth_expire_secs = ctrl->kato ? ctrl->kato : 120;
@@ -515,8 +514,6 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 	status = nvmet_copy_to_sgl(req, 0, d, al);
 	kfree(d);
 done:
-	req->cqe->result.u64 = 0;
-
 	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2)
 		nvmet_auth_sq_free(req->sq);
 	else if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index d8da840a1c0ed..fa9e8dc921539 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -225,9 +225,6 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	if (status)
 		goto out;
 
-	/* zero out initial completion result, assign values as needed */
-	req->cqe->result.u32 = 0;
-
 	if (c->recfmt != 0) {
 		pr_warn("invalid connect version (%d).\n",
 			le16_to_cpu(c->recfmt));
@@ -305,9 +302,6 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	if (status)
 		goto out;
 
-	/* zero out initial completion result, assign values as needed */
-	req->cqe->result.u32 = 0;
-
 	if (c->recfmt != 0) {
 		pr_warn("invalid connect version (%d).\n",
 			le16_to_cpu(c->recfmt));
-- 
2.43.0


