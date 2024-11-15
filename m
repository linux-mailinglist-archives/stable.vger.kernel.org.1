Return-Path: <stable+bounces-93294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA5D9CD86B
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4466B283BA8
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6193187848;
	Fri, 15 Nov 2024 06:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eTSiU72x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AFF185924;
	Fri, 15 Nov 2024 06:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653439; cv=none; b=dtxl6AwBKFHqcmHB58Ovg3WVz5TcQrrJYBlbowxg2/78AzaYy/IWRVgrM0A9CH/bF05Jv9pEpOmXW9lE5IKplqqvHT36SSqlVv9eO5I6Ib5LGO7vAyaLIhHWz06EJJ0aysvIDFEXy2W+hxkAd/NHpz6m7kr2t7kh/j+o0kJZreo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653439; c=relaxed/simple;
	bh=z+AvLwOFUoyXOJxpiY86p0Ujhp8/4HBoY09e3sg+Jr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/QpCt+nJTXI5V9yrNXsVbou5Kr4KK6lus6Nw6SLL+/mI9yFZztsFGqokloK+8wu8g75825M5DA4yxTK9OH2XV65NGtyDLX2MfbcRjj6+oJYThip+Df68aIB7knCMJUmvbKfeRlP+7bzKu5mMv68vDeMm4QKTqiRRTr4dhk9aWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eTSiU72x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D16C4CECF;
	Fri, 15 Nov 2024 06:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731653439;
	bh=z+AvLwOFUoyXOJxpiY86p0Ujhp8/4HBoY09e3sg+Jr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eTSiU72xJmb0e3rWa8knAUJ1ERVU5TzHVXQBOsGkFaKuxiYBGj7QmwwBRndcZ5DPo
	 NIS/xckHJpJCbT3Hc7zyR3+hufon+pAKdfL/qxEEiUNACROaEW9CiIHrGxhFRTKvOZ
	 LOh8cYFpqYJy5HoRvUWbSm/VgaGmygrNSPAP5F5s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 22/48] nvme-loop: flush off pending I/O while shutting down loop controller
Date: Fri, 15 Nov 2024 07:38:11 +0100
Message-ID: <20241115063723.766025173@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063722.962047137@linuxfoundation.org>
References: <20241115063722.962047137@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nilay Shroff <nilay@linux.ibm.com>

[ Upstream commit c199fac88fe7c749f88a0653e9f621b9f5a71cf1 ]

While shutting down loop controller, we first quiesce the admin/IO queue,
delete the admin/IO tag-set and then at last destroy the admin/IO queue.
However it's quite possible that during the window between quiescing and
destroying of the admin/IO queue, some admin/IO request might sneak in
and if that happens then we could potentially encounter a hung task
because shutdown operation can't forward progress until any pending I/O
is flushed off.

This commit helps ensure that before destroying the admin/IO queue, we
unquiesce the admin/IO queue so that any outstanding requests, which are
added after the admin/IO queue is quiesced, are now flushed to its
completion.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/loop.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 48d5df054cd02..bd61a1b82c4cd 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -265,6 +265,13 @@ static void nvme_loop_destroy_admin_queue(struct nvme_loop_ctrl *ctrl)
 {
 	if (!test_and_clear_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[0].flags))
 		return;
+	/*
+	 * It's possible that some requests might have been added
+	 * after admin queue is stopped/quiesced. So now start the
+	 * queue to flush these requests to the completion.
+	 */
+	nvme_unquiesce_admin_queue(&ctrl->ctrl);
+
 	nvmet_sq_destroy(&ctrl->queues[0].nvme_sq);
 	nvme_remove_admin_tag_set(&ctrl->ctrl);
 }
@@ -297,6 +304,12 @@ static void nvme_loop_destroy_io_queues(struct nvme_loop_ctrl *ctrl)
 		nvmet_sq_destroy(&ctrl->queues[i].nvme_sq);
 	}
 	ctrl->ctrl.queue_count = 1;
+	/*
+	 * It's possible that some requests might have been added
+	 * after io queue is stopped/quiesced. So now start the
+	 * queue to flush these requests to the completion.
+	 */
+	nvme_unquiesce_io_queues(&ctrl->ctrl);
 }
 
 static int nvme_loop_init_io_queues(struct nvme_loop_ctrl *ctrl)
-- 
2.43.0




