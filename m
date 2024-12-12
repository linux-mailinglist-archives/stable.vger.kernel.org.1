Return-Path: <stable+bounces-101379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 165739EEC14
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562321632A2
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975ED21578E;
	Thu, 12 Dec 2024 15:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xHd13+63"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5439C748A;
	Thu, 12 Dec 2024 15:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017351; cv=none; b=qJCtN/YQD0M62BukWZiX2BDnIONPbh2+UxHz52+4hJab+5luhheS4Iep7PAfFvoCjbcJg+p8UioItm+Y7BzJLDMe12PIcIorK5fUSVWyh/v1nnZN34+aq3P0dnJzN/dWll45y7KlBqzvDHSkn+FRt9OUEJA359e6CBqmg5lrVHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017351; c=relaxed/simple;
	bh=+5GXDHsRheaHQpbv8SqvqKWGRIbF13nZxsgqPK0I71I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRUfbC2omPUQpU+eYUmEamDktX7UATSukIWOBQd0orbZuIaL0C2aGHHB0S1BkjAFtyjP0Y3tSyX4yR90C5XdapdncPRyxmoXK63wSJJtDZ5wao1ORRBwLVyKWh+hW2Z0bFiVd7OrOsTnHGDXmljrpeeKM+ppgSgsCYh1wS17X7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xHd13+63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCB9C4CECE;
	Thu, 12 Dec 2024 15:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734017350;
	bh=+5GXDHsRheaHQpbv8SqvqKWGRIbF13nZxsgqPK0I71I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xHd13+63uh//MHhtiaLNoTbmbGnP1HCn9T0fhdmSzrlRH2axA1L4uSM45q0Ty7Qx5
	 d7uAgholLZozAQkWuZQn06Z0e1eALCsmSOsGkBzTNYTDhdoj/Eh50sv8s32S7ghi5s
	 Mk1HJqTTlSKJA2Vh0oyN8QWhM+yMqkdVAk2IrQuk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 425/466] Revert "nvme: make keep-alive synchronous operation"
Date: Thu, 12 Dec 2024 15:59:54 +0100
Message-ID: <20241212144323.544396455@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144306.641051666@linuxfoundation.org>
References: <20241212144306.641051666@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nilay Shroff <nilay@linux.ibm.com>

[ Upstream commit 84488282166de6b6760ada8030e87aaa08bce3aa ]

This reverts commit d06923670b5a5f609603d4a9fee4dec02d38de9c.

It was realized that the fix implemented to contain the race condition
among the keep alive task and the fabric shutdown code path in the commit
d06923670b5ia ("nvme: make keep-alive synchronous operation") is not
optimal. The reason being keep-alive runs under the workqueue and making
it synchronous would waste a workqueue context.
Furthermore, we later found that the above race condition is a regression
caused due to the changes implemented in commit a54a93d0e359 ("nvme: move
stopping keep-alive into nvme_uninit_ctrl()"). So we decided to revert the
commit d06923670b5a ("nvme: make keep-alive synchronous operation") and
then fix the regression.

Link: https://lore.kernel.org/all/196f4013-3bbf-43ff-98b4-9cb2a96c20c2@grimberg.me/
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ec03b25eacbbc..249914b90dbfa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1303,9 +1303,10 @@ static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
 	queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
 }
 
-static void nvme_keep_alive_finish(struct request *rq,
-		blk_status_t status, struct nvme_ctrl *ctrl)
+static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
+						 blk_status_t status)
 {
+	struct nvme_ctrl *ctrl = rq->end_io_data;
 	unsigned long rtt = jiffies - (rq->deadline - rq->timeout);
 	unsigned long delay = nvme_keep_alive_work_period(ctrl);
 	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
@@ -1322,17 +1323,20 @@ static void nvme_keep_alive_finish(struct request *rq,
 		delay = 0;
 	}
 
+	blk_mq_free_request(rq);
+
 	if (status) {
 		dev_err(ctrl->device,
 			"failed nvme_keep_alive_end_io error=%d\n",
 				status);
-		return;
+		return RQ_END_IO_NONE;
 	}
 
 	ctrl->ka_last_check_time = jiffies;
 	ctrl->comp_seen = false;
 	if (state == NVME_CTRL_LIVE || state == NVME_CTRL_CONNECTING)
 		queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
+	return RQ_END_IO_NONE;
 }
 
 static void nvme_keep_alive_work(struct work_struct *work)
@@ -1341,7 +1345,6 @@ static void nvme_keep_alive_work(struct work_struct *work)
 			struct nvme_ctrl, ka_work);
 	bool comp_seen = ctrl->comp_seen;
 	struct request *rq;
-	blk_status_t status;
 
 	ctrl->ka_last_check_time = jiffies;
 
@@ -1364,9 +1367,9 @@ static void nvme_keep_alive_work(struct work_struct *work)
 	nvme_init_request(rq, &ctrl->ka_cmd);
 
 	rq->timeout = ctrl->kato * HZ;
-	status = blk_execute_rq(rq, false);
-	nvme_keep_alive_finish(rq, status, ctrl);
-	blk_mq_free_request(rq);
+	rq->end_io = nvme_keep_alive_end_io;
+	rq->end_io_data = ctrl;
+	blk_execute_rq_nowait(rq, false);
 }
 
 static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
-- 
2.43.0




