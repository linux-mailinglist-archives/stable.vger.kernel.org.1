Return-Path: <stable+bounces-87887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B439ACCEC
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427CC1C21996
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CBC208231;
	Wed, 23 Oct 2024 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/zaDNmQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F32207A3B;
	Wed, 23 Oct 2024 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693913; cv=none; b=FBe+Q3GBMR7VKhgrEeFklL1T3VqcuJ81Uq/sBM0V5yu5KpsmVEv7lJ2EG4aslmWvSvI9c408WBO/SUvgOrqbezR/E3SqZMjXpJ75i4Llw9DBwvVWvokoyNqTJUt1rLgJAvb/l8N+JD1N6QSKdgsDMtn9eJkS+HFve9y4pm4ordo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693913; c=relaxed/simple;
	bh=Nt2IQe3cEkYs4dGfixs/VEPyhmJBULF20D33p93h7WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHm7/Q4TliVOeM7fs1wptJhx7f8l+T3ZUUya2mq9Pq97pz1ZsMN/u+aReo4Z0AYA/TWsQi0XOUvErnNx3takK8WyDaZFUnd97OPCQg1ZGf4EIjrwkS2AyfulwKduY+LnXMuq5p6dlzJcZENVuUNqVN6amcI9lWFN6oLx63rY2b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/zaDNmQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7887BC4CEE7;
	Wed, 23 Oct 2024 14:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693913;
	bh=Nt2IQe3cEkYs4dGfixs/VEPyhmJBULF20D33p93h7WE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G/zaDNmQwLohcYVgqNguqm5XZrP4lSySxgZ0yheK3N2ophd9Sx/8iNaSjmbwnliTu
	 xPaHU/Q5osrm51/mTcJnck86i+AdAKMQn1Xnv6QHBdEikedkXBZ4roIHgxLwStcyUE
	 33hmmXDrEkWuErdaf3uXRjZpo31kpXp5oxR9r5rPRKFrjQPXRvB6BSLqKLNmwbmPD/
	 5KDS+gC5wGRrzEkA3eEQeKji5wgl5YtQlxMvXtEAiVPhx79UzqhDIYuDTpkmkEvnAm
	 M+XFj7PLiKo7wblo36SJdDsT0ug6BeMziMJVx+MFUc0XNd0qMDHpn5NE2zZFjIv1fP
	 GB+jm3NRAJ9+w==
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
Subject: [PATCH AUTOSEL 6.6 22/23] nvme-loop: flush off pending I/O while shutting down loop controller
Date: Wed, 23 Oct 2024 10:31:06 -0400
Message-ID: <20241023143116.2981369-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143116.2981369-1-sashal@kernel.org>
References: <20241023143116.2981369-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.58
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


