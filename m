Return-Path: <stable+bounces-54912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE746913B18
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 15:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E461F210B8
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 13:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FDA187570;
	Sun, 23 Jun 2024 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFGokYHD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01FB181D0E;
	Sun, 23 Jun 2024 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150278; cv=none; b=a5KNlJxOA0EmLnB6sMyq6uALznOtX4ukPhNnAr75j3+2iSptfM0JSYzA0P5ppPQEDlJHJ9YuI+Fewv3Srcm1NvaPoPMxqYYqspdTZSauacQncP59EJTdDFwZhDA8jo1o86X73hWNoRnYg6lhhJjeRU0dgiedcg3IXKYIk0Jzu/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150278; c=relaxed/simple;
	bh=kneZVnQX/xGvS8R5iLK83sOS5TyfkaXQ1vIlBiY/tw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2QGihEKP/s+Bn52W7DZmtoMKHKyF/mF/+OlM7sp2ckOEYjR8XzSk1mNK2KLMZxtyBZNwK+6mrg0OMEFntZG1xnOPAdUtsRXRmfsNx8N6ly309sKMkz+1ZnnbX88pZDq9Vr+LEK1Oniq956s0v/bdI3eo3mY5wRR7ErrnbZPPmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFGokYHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DF4C32781;
	Sun, 23 Jun 2024 13:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150278;
	bh=kneZVnQX/xGvS8R5iLK83sOS5TyfkaXQ1vIlBiY/tw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LFGokYHDBw3d7ipWeUILAAA57bJFumaYrw2XG4JjDRc+py4u/Bl0HW+KdUpRAaonH
	 URT0GaT7RxVLCxd7Gchs0FBLaCXr11Mu7biVgvqGICikfu2dDfFgNpIXMHeJziEk/n
	 82y19XPZsJ1Tiv8JzdF1oTRxYBkVMY/2O7qreorb0umkN5+0Wyj6V6ikj6tq9XYZVQ
	 rXo0UXfEdHgLPSuFPhqm/wCATvmDS4WHzvn3WS6QCCplg5hL30MU2bm5jikkwXwV/K
	 d/guLbsZZiK8Nz/EB8VXUaDO7tZ99oEtUNV+C1l5mE4rk4OBUSnwjefzJqQqoER7aJ
	 Z9DqdxIUCI1LQ==
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
Subject: [PATCH AUTOSEL 6.9 19/21] nvmet: always initialize cqe.result
Date: Sun, 23 Jun 2024 09:43:52 -0400
Message-ID: <20240623134405.809025-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134405.809025-1-sashal@kernel.org>
References: <20240623134405.809025-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.6
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
index 2fde22323622e..29d324b97f8c3 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -948,6 +948,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	req->metadata_sg_cnt = 0;
 	req->transfer_len = 0;
 	req->metadata_len = 0;
+	req->cqe->result.u64 = 0;
 	req->cqe->status = 0;
 	req->cqe->sq_head = 0;
 	req->ns = NULL;
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index eb7785be0ca77..ee76491e8b12c 100644
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
index b23f4cf840bd5..f6714453b8bb3 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -226,9 +226,6 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	if (status)
 		goto out;
 
-	/* zero out initial completion result, assign values as needed */
-	req->cqe->result.u32 = 0;
-
 	if (c->recfmt != 0) {
 		pr_warn("invalid connect version (%d).\n",
 			le16_to_cpu(c->recfmt));
@@ -304,9 +301,6 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
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


