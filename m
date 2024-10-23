Return-Path: <stable+bounces-87905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC829ACD1E
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB867B22962
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F341CC179;
	Wed, 23 Oct 2024 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyTH+7EP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DA5212643;
	Wed, 23 Oct 2024 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693951; cv=none; b=XMM+IUilz50BVieMUfMahrH/Mh4CMLx3bwtpJu4cIZ4x3fDMU4TUCS/zbRm2vC/jzWFZf7EKqz2abn4wMXRHELLB6jjut2m8xVJYtpSwzFaZ36Nt5b/jewckbnnWKBcHGcOgs7Q7xKqqn0WiyfipLyoNZjMvQBoV6Us1a1XV2Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693951; c=relaxed/simple;
	bh=tOOD41nVgXP8XBFfFqbGOJwRj41r+Yqj/FNVwYtzep8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfGMMzqznUK1TSCbdjz8OZyL1T9ZoL6mtuejGE3IL7Uqc3sgHbcCdE1ss1FM9KEq6iYgPT39iXwpROv9w8XMW4tdNf4TYK47PEnxbG1ESlEh+wDFT2/h7tbuKJ2B8W1amC7f872LbOJ8o2vGihwYtZK4W5+jCnlmxwJA7Tmgz60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyTH+7EP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C779BC4CEE5;
	Wed, 23 Oct 2024 14:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693950;
	bh=tOOD41nVgXP8XBFfFqbGOJwRj41r+Yqj/FNVwYtzep8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hyTH+7EPMeuGrmT6PBQlaUKM6HNMKLVJRYU6SPITqlQalUQPDLj4P2spLJj/+M4bB
	 bmI8GIeVl7EYkVizpg4hgqE36imeby4BN7y/Nymz0CVKPWNlG9yLq/ytkO0lzQeZkk
	 lnCs23eTQ5Z5ATXyQxnQpfobB9wMuqVca37ORbtGl4MYmVaKM/ROqkQeqZ/fL96qjy
	 ikUbxxFHYrId65cGmimmpst5f1QNo6thMyFk88Rf0rpfn6gME526jjWEDxMoTpjoS0
	 wzN0ZEnZqkXT5lCadsheIiJUA3mex0LvTJF3ervB+lMfSQK3N+JhrOtMZXnrejPmX4
	 XRMva0iVWgMfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 17/17] nvme: make keep-alive synchronous operation
Date: Wed, 23 Oct 2024 10:31:56 -0400
Message-ID: <20241023143202.2981992-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143202.2981992-1-sashal@kernel.org>
References: <20241023143202.2981992-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.114
Content-Transfer-Encoding: 8bit

From: Nilay Shroff <nilay@linux.ibm.com>

[ Upstream commit d06923670b5a5f609603d4a9fee4dec02d38de9c ]

The nvme keep-alive operation, which executes at a periodic interval,
could potentially sneak in while shutting down a fabric controller.
This may lead to a race between the fabric controller admin queue
destroy code path (invoked while shutting down controller) and hw/hctx
queue dispatcher called from the nvme keep-alive async request queuing
operation. This race could lead to the kernel crash shown below:

Call Trace:
    autoremove_wake_function+0x0/0xbc (unreliable)
    __blk_mq_sched_dispatch_requests+0x114/0x24c
    blk_mq_sched_dispatch_requests+0x44/0x84
    blk_mq_run_hw_queue+0x140/0x220
    nvme_keep_alive_work+0xc8/0x19c [nvme_core]
    process_one_work+0x200/0x4e0
    worker_thread+0x340/0x504
    kthread+0x138/0x140
    start_kernel_thread+0x14/0x18

While shutting down fabric controller, if nvme keep-alive request sneaks
in then it would be flushed off. The nvme_keep_alive_end_io function is
then invoked to handle the end of the keep-alive operation which
decrements the admin->q_usage_counter and assuming this is the last/only
request in the admin queue then the admin->q_usage_counter becomes zero.
If that happens then blk-mq destroy queue operation (blk_mq_destroy_
queue()) which could be potentially running simultaneously on another
cpu (as this is the controller shutdown code path) would forward
progress and deletes the admin queue. So, now from this point onward
we are not supposed to access the admin queue resources. However the
issue here's that the nvme keep-alive thread running hw/hctx queue
dispatch operation hasn't yet finished its work and so it could still
potentially access the admin queue resource while the admin queue had
been already deleted and that causes the above crash.

This fix helps avoid the observed crash by implementing keep-alive as a
synchronous operation so that we decrement admin->q_usage_counter only
after keep-alive command finished its execution and returns the command
status back up to its caller (blk_execute_rq()). This would ensure that
fabric shutdown code path doesn't destroy the fabric admin queue until
keep-alive request finished execution and also keep-alive thread is not
running hw/hctx queue dispatch operation.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dc25d91891327..92ffeb6605618 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1231,10 +1231,9 @@ static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
 			   nvme_keep_alive_work_period(ctrl));
 }
 
-static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
-						 blk_status_t status)
+static void nvme_keep_alive_finish(struct request *rq,
+		blk_status_t status, struct nvme_ctrl *ctrl)
 {
-	struct nvme_ctrl *ctrl = rq->end_io_data;
 	unsigned long flags;
 	bool startka = false;
 	unsigned long rtt = jiffies - (rq->deadline - rq->timeout);
@@ -1252,13 +1251,11 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 		delay = 0;
 	}
 
-	blk_mq_free_request(rq);
-
 	if (status) {
 		dev_err(ctrl->device,
 			"failed nvme_keep_alive_end_io error=%d\n",
 				status);
-		return RQ_END_IO_NONE;
+		return;
 	}
 
 	ctrl->ka_last_check_time = jiffies;
@@ -1270,7 +1267,6 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 	if (startka)
 		queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
-	return RQ_END_IO_NONE;
 }
 
 static void nvme_keep_alive_work(struct work_struct *work)
@@ -1279,6 +1275,7 @@ static void nvme_keep_alive_work(struct work_struct *work)
 			struct nvme_ctrl, ka_work);
 	bool comp_seen = ctrl->comp_seen;
 	struct request *rq;
+	blk_status_t status;
 
 	ctrl->ka_last_check_time = jiffies;
 
@@ -1301,9 +1298,9 @@ static void nvme_keep_alive_work(struct work_struct *work)
 	nvme_init_request(rq, &ctrl->ka_cmd);
 
 	rq->timeout = ctrl->kato * HZ;
-	rq->end_io = nvme_keep_alive_end_io;
-	rq->end_io_data = ctrl;
-	blk_execute_rq_nowait(rq, false);
+	status = blk_execute_rq(rq, false);
+	nvme_keep_alive_finish(rq, status, ctrl);
+	blk_mq_free_request(rq);
 }
 
 static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
-- 
2.43.0


