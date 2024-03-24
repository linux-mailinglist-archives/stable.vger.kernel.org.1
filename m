Return-Path: <stable+bounces-30483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B927F8890AB
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 07:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738B82949B0
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 06:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D272418BC2C;
	Sun, 24 Mar 2024 23:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjdpmCtg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA224238F1F;
	Sun, 24 Mar 2024 23:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322328; cv=none; b=OzNNpMKTZpnZyUAaYGm5e5+TpCnXfiQ5dN9ktfTtwy6M0gsaTNcU6TdjiqSaWfBW8uiMW+vqEmtF/dxbzZCLFTv1xhN/sqe/KCULc+KEDye9rDk1nVjfKuS6A5bBWnNVZv2SmugTrIUPJpdRYi3acdFthuqaLOm5pBCg6pITcxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322328; c=relaxed/simple;
	bh=NHOVg9Wt8Q8qQd/3bLj5eFPcQMFrrz+ujue+JYbi8ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DETl18A+36kvQ8l/s/Wkqw6LxtIPX0mwy/SbMMuxmIZy//B9wtp2ZQ0EUtsgjxmMW6pZqOzBUNYe5qpwm0facTDloyQhL2SibNy/1DDvmLm84vKkmlTtxL48F92PpyZFRbajy+BO6AjlmZDrs5oF53JGiTza6yTtvcH9hKLj9v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjdpmCtg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D450CC43394;
	Sun, 24 Mar 2024 23:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322327;
	bh=NHOVg9Wt8Q8qQd/3bLj5eFPcQMFrrz+ujue+JYbi8ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hjdpmCtgH8oRa+aTivI1OO9vxV/A5iS+Sg7tSE9wzawUGlm3/ZGmmBrxfLHvbgQxz
	 L78A7PUmMuJdBWbvGrMC6yhaJhdDn5XevO3v5Y7t7sl90Jbc3zLq5wjCvv269HNcez
	 xc8StFh7CpL/msf5knXR99DdPwdokyMLpQBm80XZEvj7yqZ1EFbgVNJgqIPNyC83zW
	 nR0+u2W/m+lg8ccROq2IL4x0HghDHu2eI0z3RnikOMxMZzzJohjSA8F0zwFmdvca5f
	 9cVJq8WbKEftAysYQWVtPqMDxYb3X+tTo2S4nSa2H38DW/W8LQf/euG8YQuRD83yWG
	 XxguQgoOAsUNg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 410/451] nvme: only set reserved_tags in nvme_alloc_io_tag_set for fabrics controllers
Date: Sun, 24 Mar 2024 19:11:26 -0400
Message-ID: <20240324231207.1351418-411-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit b794d1c2ad6d7921f2867ce393815ad31b5b5a83 ]

The reserved_tags are only needed for fabrics controllers.  Right now only
fabrics drivers call this helper, so this is harmless, but we'll use it
in the PCIe driver soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Stable-dep-of: de105068fead ("nvme: fix reconnection fail due to reserved tag allocation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0c088db944706..98a8d90feb37d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5029,7 +5029,8 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	memset(set, 0, sizeof(*set));
 	set->ops = ops;
 	set->queue_depth = ctrl->sqsize + 1;
-	set->reserved_tags = NVMF_RESERVED_TAGS;
+	if (ctrl->ops->flags & NVME_F_FABRICS)
+		set->reserved_tags = NVMF_RESERVED_TAGS;
 	set->numa_node = ctrl->numa_node;
 	set->flags = BLK_MQ_F_SHOULD_MERGE;
 	if (ctrl->ops->flags & NVME_F_BLOCKING)
-- 
2.43.0


