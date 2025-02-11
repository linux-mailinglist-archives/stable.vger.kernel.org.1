Return-Path: <stable+bounces-114767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56507A3005C
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793183A61AC
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0181EF091;
	Tue, 11 Feb 2025 01:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4yUp1FZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9F81EF085;
	Tue, 11 Feb 2025 01:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237451; cv=none; b=JLD7qWBoB5rRvIKhnIAcjSxcLnoOe+qSDClm0g32IBdUNjF4EFOvqiSdQZrg+tb5wABRIW9WmNzrtt/mHUujIoP5eqexGLWz4XTVz1iXdViNKmJIF55kOO+7DrtrgLRCEaM0X7dWRo0k5jAdUpyUDo8aP1fV32Y283BWRdrKjlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237451; c=relaxed/simple;
	bh=PQUlJNnpO+6t8wiH09FmFlHDJT5lc0E4H4RlQ2457sk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bLBcyoN2hQhgwnH0SxVbPXJsbqhdTyQ9uuATAk+7zTsMVPwoTQBWtrrd9bHa01HxTcJ2brM7B2XJqgLalu9h46Z/fUdIg8VN5a+5fw9FkGw/PUF9ZSOjngiuxZ79PgHHGhgI6+IkKV/JrRmAnfYdWYLKivGTwzyuhSmNGP3StSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4yUp1FZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C498C4CED1;
	Tue, 11 Feb 2025 01:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237451;
	bh=PQUlJNnpO+6t8wiH09FmFlHDJT5lc0E4H4RlQ2457sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l4yUp1FZVjqONyA+Wee3tP3F22C6uaZwKZhsH9QOxDd+sfUXaygWQoBuWUBGvFas2
	 GXJ4ZTlw2fbf8SB3bzLLmhDYDEb9QF4oWLJE+PsleUmAqycxCE9I4soL5yWtA6PBvd
	 d3l5EaBT3ZYvmRhxe1r//BeIkztilFpSijSUlANB8/ASpMek6yWpEu1VOgH1eLTYzV
	 /tKXJT0AO1MxAUmbYj3rn0xPfG/eBUbFAEzZrgxO8YRbNEKGuCrciIAycAPJZHTT/r
	 xco90K2QR9LIxD1rzbbZRnsKFWuT9afu0DYV03IJT7ibPeBX/tevKcS+l2vmNS6ydA
	 PXYgGXloIvQhA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 02/19] nvme-fc: do not ignore connectivity loss during connecting
Date: Mon, 10 Feb 2025 20:30:30 -0500
Message-Id: <20250211013047.4096767-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013047.4096767-1-sashal@kernel.org>
References: <20250211013047.4096767-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.13
Content-Transfer-Encoding: 8bit

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
index d45ab530ff9b7..b211a29b13f25 100644
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
@@ -2543,7 +2551,6 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 	 */
 	if (ctrl->ctrl.state == NVME_CTRL_CONNECTING) {
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


