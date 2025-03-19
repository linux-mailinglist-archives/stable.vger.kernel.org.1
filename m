Return-Path: <stable+bounces-125470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FD5A69181
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825DE3BFBBF
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F6A207A2A;
	Wed, 19 Mar 2025 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PzNDoGjc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C5B1DEFE6;
	Wed, 19 Mar 2025 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395210; cv=none; b=liA3NZ2upBKzhMe/5oOZzU8aDOcY9Ds277zb1TutmJRTLk2/rOCa4NTTzJYe0PqtCgiFYrApHGBJM7evz96YrUHyVr/8uq3Lu9MCSEvKa33pB3S6mq1MR0AKkK7MAKcnn3gUyriQUzf35Z+n5gnTFxF6nAEQ/Ub5oSSYIA5F2Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395210; c=relaxed/simple;
	bh=cp05/xXOUNJL9E8VoDMMpkXclWI4dTYkp7fg1mP+UyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahH2FHBAccq5O4ytbD9eFF2qv7RPatVIGT06WnQbwrRK4L57CxhhdSclfZctBArr+SV+hhH13BYsC6wJw+nul0cq4C/qojGhSOcQvElW6s+XH4epXJcbdJMCxHJl/pVlfLv5t6ze1UnSEsMD+aud8fjmw3yG2TJuZjPGNQIfT/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PzNDoGjc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05DAC4CEE4;
	Wed, 19 Mar 2025 14:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742395209;
	bh=cp05/xXOUNJL9E8VoDMMpkXclWI4dTYkp7fg1mP+UyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PzNDoGjcGUllCd9wgwNMoyfLEMqC03NEy+661Mu+WjwfuuedOH73teZ6B+FNAUVJZ
	 95R7wxpHCnWEC/g5qQxvd8Ox6TGBA3LwoUEI3uO7WR4JIaZfVZPTAcOaEEYaBTYQ00
	 13oxmoLbbv2ZCqSjqZhljlDylmoyFOgiH8bsWi5w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Wagner <wagi@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 037/166] nvme-fc: do not ignore connectivity loss during connecting
Date: Wed, 19 Mar 2025 07:30:08 -0700
Message-ID: <20250319143020.996078786@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143019.983527953@linuxfoundation.org>
References: <20250319143019.983527953@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Wagner <wagi@kernel.org>

[ Upstream commit ee59e3820ca92a9f4307ae23dfc7229dc8b8d400 ]

When a connectivity loss occurs while nvme_fc_create_assocation is
being executed, it's possible that the ctrl ends up stuck in the LIVE
state:

  1) nvme nvme10: NVME-FC{10}: create association : ...
  2) nvme nvme10: NVME-FC{10}: controller connectivity lost.
                  Awaiting Reconnect
     nvme nvme10: queue_size 128 > ctrl maxcmd 32, reducing to maxcmd
  3) nvme nvme10: Could not set queue count (880)
     nvme nvme10: Failed to configure AEN (cfg 900)
  4) nvme nvme10: NVME-FC{10}: controller connect complete
  5) nvme nvme10: failed nvme_keep_alive_end_io error=4

A connection attempt starts 1) and the ctrl is in state CONNECTING.
Shortly after the LLDD driver detects a connection lost event and calls
nvme_fc_ctrl_connectivity_loss 2). Because we are still in CONNECTING
state, this event is ignored.

nvme_fc_create_association continues to run in parallel and tries to
communicate with the controller and these commands will fail. Though
these errors are filtered out, e.g in 3) setting the I/O queues numbers
fails which leads to an early exit in nvme_fc_create_io_queues. Because
the number of IO queues is 0 at this point, there is nothing left in
nvme_fc_create_association which could detected the connection drop.
Thus the ctrl enters LIVE state 4).

Eventually the keep alive handler times out 5) but because nothing is
being done, the ctrl stays in LIVE state.

There is already the ASSOC_FAILED flag to track connectivity loss event
but this bit is set too late in the recovery code path. Move this into
the connectivity loss event handler and synchronize it with the state
change. This ensures that the ASSOC_FAILED flag is seen by
nvme_fc_create_io_queues and it does not enter the LIVE state after a
connectivity loss event. If the connectivity loss event happens after we
entered the LIVE state the normal error recovery path is executed.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fc.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 0641050f590f3..66c4c411ebe04 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -782,11 +782,19 @@ nvme_fc_abort_lsops(struct nvme_fc_rport *rport)
 static void
 nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
 {
+	enum nvme_ctrl_state state;
+	unsigned long flags;
+
 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: controller connectivity lost. Awaiting "
 		"Reconnect", ctrl->cnum);
 
-	switch (nvme_ctrl_state(&ctrl->ctrl)) {
+	spin_lock_irqsave(&ctrl->lock, flags);
+	set_bit(ASSOC_FAILED, &ctrl->flags);
+	state = nvme_ctrl_state(&ctrl->ctrl);
+	spin_unlock_irqrestore(&ctrl->lock, flags);
+
+	switch (state) {
 	case NVME_CTRL_NEW:
 	case NVME_CTRL_LIVE:
 		/*
@@ -2546,7 +2554,6 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 	 */
 	if (state == NVME_CTRL_CONNECTING) {
 		__nvme_fc_abort_outstanding_ios(ctrl, true);
-		set_bit(ASSOC_FAILED, &ctrl->flags);
 		dev_warn(ctrl->ctrl.device,
 			"NVME-FC{%d}: transport error during (re)connect\n",
 			ctrl->cnum);
@@ -3168,12 +3175,18 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 		else
 			ret = nvme_fc_recreate_io_queues(ctrl);
 	}
-	if (!ret && test_bit(ASSOC_FAILED, &ctrl->flags))
-		ret = -EIO;
 	if (ret)
 		goto out_term_aen_ops;
 
-	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
+	spin_lock_irqsave(&ctrl->lock, flags);
+	if (!test_bit(ASSOC_FAILED, &ctrl->flags))
+		changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
+	else
+		ret = -EIO;
+	spin_unlock_irqrestore(&ctrl->lock, flags);
+
+	if (ret)
+		goto out_term_aen_ops;
 
 	ctrl->ctrl.nr_reconnects = 0;
 
-- 
2.39.5




