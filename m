Return-Path: <stable+bounces-43372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 755098BF243
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B8CAB26B1E
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C088817BB0A;
	Tue,  7 May 2024 23:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhPRt/Mb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1DC17B507;
	Tue,  7 May 2024 23:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123527; cv=none; b=lA4U3EuKAox1oOZn/xU2L3ER5csS7lFBsfxTjpwy3HOED7nZzRHqRRWq+u7AnyBN6Vk4fB6/jA4HpHPrD4LyuecsOst+acUQc6aXswkWbQFiBizt3z9eQFQZuSYfpeNxeahIR6nQjw0W4K689gt7sRhgizdi3ayir8EcBeTGr0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123527; c=relaxed/simple;
	bh=NRv+u2+rO1Udn279qWJqj+iNZw2F/0IDOrjdNAD3/1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JI/Ncah0TYRWxbmgBo6fpgxOiNCq9UTeLLk+Th2zzkKDDq8zpI1fh1jtmWPtamboVhbuVzY4kEokFjensn9T1hyzsrGEWI5iFSAn5vNFtsuCMNstYgvjlrahLyTVj4m4tAuBX8QrptXmjuGUwNXMhOTUIlZG3W60ZTNVXAqrzAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhPRt/Mb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1EDC2BBFC;
	Tue,  7 May 2024 23:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123527;
	bh=NRv+u2+rO1Udn279qWJqj+iNZw2F/0IDOrjdNAD3/1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DhPRt/MbN1UeHStUP+1luNx360REF7xQpPlHxdmy2N8sMNVtF5c1cfaOZiIOnHaYE
	 edzCpYAqwdNdgOWI0jXNZCH6XKc+VnwczrkMVRW1bq9TcaW0FYpj60WyOEHFoLJS9B
	 yOkjUKi3mCxoiVqvsSOk0nlEke0sXvu4x0AygWBFAfb2TXcIAp9KQPZOl9YO1VL2Vl
	 u1Y0BrqxUmAdWgdbyCy1pk/1ICfB5NNQ9d8FC00o/WOOTguOSS6mVZgusyGyWM5SRk
	 p00d45iJZHp/DeiAf+cqXNx/u4XtpZhXorbk+xdPc5CJaTil+U9Vh57BrFq2+GAtcw
	 zmPcECJo5fwnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 40/43] nvme: cancel pending I/O if nvme controller is in terminal state
Date: Tue,  7 May 2024 19:10:01 -0400
Message-ID: <20240507231033.393285-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit

From: Nilay Shroff <nilay@linux.ibm.com>

[ Upstream commit 25bb3534ee21e39eb9301c4edd7182eb83cb0d07 ]

While I/O is running, if the pci bus error occurs then
in-flight I/O can not complete. Worst, if at this time,
user (logically) hot-unplug the nvme disk then the
nvme_remove() code path can't forward progress until
in-flight I/O is cancelled. So these sequence of events
may potentially hang hot-unplug code path indefinitely.
This patch helps cancel the pending/in-flight I/O from the
nvme request timeout handler in case the nvme controller
is in the terminal (DEAD/DELETING/DELETING_NOIO) state and
that helps nvme_remove() code path forward progress and
finish successfully.

Link: https://lore.kernel.org/all/199be893-5dfa-41e5-b6f2-40ac90ebccc4@linux.ibm.com/
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 21 ---------------------
 drivers/nvme/host/nvme.h | 21 +++++++++++++++++++++
 drivers/nvme/host/pci.c  |  8 +++++++-
 3 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 012c8b3f5f9c9..02d9d1b973494 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -587,27 +587,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 }
 EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
 
-/*
- * Returns true for sink states that can't ever transition back to live.
- */
-static bool nvme_state_terminal(struct nvme_ctrl *ctrl)
-{
-	switch (nvme_ctrl_state(ctrl)) {
-	case NVME_CTRL_NEW:
-	case NVME_CTRL_LIVE:
-	case NVME_CTRL_RESETTING:
-	case NVME_CTRL_CONNECTING:
-		return false;
-	case NVME_CTRL_DELETING:
-	case NVME_CTRL_DELETING_NOIO:
-	case NVME_CTRL_DEAD:
-		return true;
-	default:
-		WARN_ONCE(1, "Unhandled ctrl state:%d", ctrl->state);
-		return true;
-	}
-}
-
 /*
  * Waits for the controller state to be resetting, or returns false if it is
  * not possible to ever transition to that state.
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ba62d42d2a8b7..43cff851ac5ae 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -735,6 +735,27 @@ static inline bool nvme_is_aen_req(u16 qid, __u16 command_id)
 		nvme_tag_from_cid(command_id) >= NVME_AQ_BLK_MQ_DEPTH;
 }
 
+/*
+ * Returns true for sink states that can't ever transition back to live.
+ */
+static inline bool nvme_state_terminal(struct nvme_ctrl *ctrl)
+{
+	switch (nvme_ctrl_state(ctrl)) {
+	case NVME_CTRL_NEW:
+	case NVME_CTRL_LIVE:
+	case NVME_CTRL_RESETTING:
+	case NVME_CTRL_CONNECTING:
+		return false;
+	case NVME_CTRL_DELETING:
+	case NVME_CTRL_DELETING_NOIO:
+	case NVME_CTRL_DEAD:
+		return true;
+	default:
+		WARN_ONCE(1, "Unhandled ctrl state:%d", ctrl->state);
+		return true;
+	}
+}
+
 void nvme_complete_rq(struct request *req);
 void nvme_complete_batch_req(struct request *req);
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b985142fb84b9..4352206533ede 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1286,6 +1286,9 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 	struct nvme_command cmd = { };
 	u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
+	if (nvme_state_terminal(&dev->ctrl))
+		goto disable;
+
 	/* If PCI error recovery process is happening, we cannot reset or
 	 * the recovery mechanism will surely fail.
 	 */
@@ -1388,8 +1391,11 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 	return BLK_EH_RESET_TIMER;
 
 disable:
-	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
+	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
+		if (nvme_state_terminal(&dev->ctrl))
+			nvme_dev_disable(dev, true);
 		return BLK_EH_DONE;
+	}
 
 	nvme_dev_disable(dev, false);
 	if (nvme_try_sched_reset(&dev->ctrl))
-- 
2.43.0


