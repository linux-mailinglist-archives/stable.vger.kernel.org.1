Return-Path: <stable+bounces-87864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 062879ACCA9
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F561F247B6
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5312B1E2617;
	Wed, 23 Oct 2024 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nC3kD5bZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD271E2604;
	Wed, 23 Oct 2024 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693865; cv=none; b=MSiMLZ0VpwENI7ZNZc38GS+DJrvN9fOqFkWg167zemlSpVKsKP1J97Wpb1jwS/mc1Q+mYDKpNYGbtfgI/m4Jy96hNkXFWf7EjKPLNYxMbxjNB7SKyVVjQ9u2Epys1PpWyfzG/G7h/ZsKZAhOayjmhjjX6Wbbcjm6h6jTqkNj+yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693865; c=relaxed/simple;
	bh=g43AfRYMdMX1ToPOcP7uPAFGnLXV5Stu3IUoyJcnHVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUTuYq43aEKPchhR8iF5hN5tUeMHO6L/NsoOY2lLItPfeplc6ISl+o9+KjX32WA6f6MyFQLep9epXGD73Xp9dQrob4ZD/XlrE3A7Y9hKKavGRvX0BnsI634/sDRMXJ4D0z46PmjYyDatmorWj/xHRe63k+swIV1OUguYiFz4y/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nC3kD5bZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8963C4CEE5;
	Wed, 23 Oct 2024 14:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693864;
	bh=g43AfRYMdMX1ToPOcP7uPAFGnLXV5Stu3IUoyJcnHVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nC3kD5bZH8bLo7fsT8IwOvcuXn065j7rZeW/1BS7sV6Vtew2R2ShtfEutJEd9inR+
	 grXRnwsWRG3cIrghqperDzGEOVl5mrTS+8938sRzpiEPDRgizvcMwsakm2GshoWFyi
	 biAp7/AWDtBiY9E2jmuFs2OfALgHLzEKfqNdm1mj4Llghtv/cZcwxpe2/NJ3AbX8Z8
	 fvEnb3Skzy8ZqDMBCStXqS7jbADVdyCmJA5EZzaxSDWTgfErf5cSD/s6T5bYswR8Uv
	 1hY17hAsG2NlxHReQATtuG/FF1SKEIqldYRufo2HtIvO14pTGa4EhrJshQy63Y2kUr
	 6u9OtcZ+NQdtA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.11 29/30] nvme-loop: flush off pending I/O while shutting down loop controller
Date: Wed, 23 Oct 2024 10:29:54 -0400
Message-ID: <20241023143012.2980728-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143012.2980728-1-sashal@kernel.org>
References: <20241023143012.2980728-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
Content-Transfer-Encoding: 8bit

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
index e32790d8fc260..a9d112d34d4f4 100644
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


