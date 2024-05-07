Return-Path: <stable+bounces-43398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC16C8BF26B
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6DAA2863DA
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01451CB31A;
	Tue,  7 May 2024 23:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2DyyH8w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC291C9ED4;
	Tue,  7 May 2024 23:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123601; cv=none; b=J0YwchCqljfngDkrCoO1z/c0Kk6w5KstL5uAUlB/9R+eSRschKMY3mXC1yGTeR6TpAZLGMW2ORMbHxVpLmX+axAxwwKdpvprMjEWdpHTdnkrV9e9HNDP3eZPuLvSqnFL0ulMghVu0xizkZP4FZEHi1dJhU1Xe9STSkRVH00WwiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123601; c=relaxed/simple;
	bh=HOFK1k5/G3H5LG+wE2AHumQWNVSavEuXqzk8rzQ3Irc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAg1uRennCEXXeQ+Yxv5o23iqkDHP0vcGck7aI9DLe/GnTRjyGplphyNGwspzdeg3vPHvXF2TevnhkroO6QPLq8+VjhyVJmk/Gcd++iL3KHRLy3e+UuKstNoGttWkW5u0IPWnJnWVzLoa1QQtqevRySS5L+XLUaaOlbrmZYfMIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2DyyH8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427CFC3277B;
	Tue,  7 May 2024 23:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123601;
	bh=HOFK1k5/G3H5LG+wE2AHumQWNVSavEuXqzk8rzQ3Irc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r2DyyH8wtRKhSNcbpKzmnKN3v6WTYhJsBAhETEWZzDHYwv+qArb0owarFqfAD+JEm
	 sYXCGlmdvJQZndemdPvebK4nV1ApDXLr7Aq4JnxrSkBn5G+LeV7ckBwGnt9e2t1SXP
	 Lr2AX+R+6QVn5PWHbwMgrZLnpYicBZQZlEg1zGXQBplAT03QjjJraQwJ5ymsjEQw3n
	 zYUrLUBeQRysQ+GJd6Kt6hhHZhu4L51J086tLCqPRuFzXhgW/0trGxIhr1ZKh4UnlC
	 x+v/NU5IX1qq5YGOXiBTaqmIH5qye0laPTZopMdB3dEEMpTtnJT91gBn8YGBkNLFSt
	 gFp3uFzcovbyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Yi Zhang <yi.zhang@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 23/25] nvmet-tcp: fix possible memory leak when tearing down a controller
Date: Tue,  7 May 2024 19:12:10 -0400
Message-ID: <20240507231231.394219-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231231.394219-1-sashal@kernel.org>
References: <20240507231231.394219-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.90
Content-Transfer-Encoding: 8bit

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 6825bdde44340c5a9121f6d6fa25cc885bd9e821 ]

When we teardown the controller, we wait for pending I/Os to complete
(sq->ref on all queues to drop to zero) and then we go over the commands,
and free their command buffers in case they are still fetching data from
the host (e.g. processing nvme writes) and have yet to take a reference
on the sq.

However, we may miss the case where commands have failed before executing
and are queued for sending a response, but will never occur because the
queue socket is already down. In this case we may miss deallocating command
buffers.

Solve this by freeing all commands buffers as nvmet_tcp_free_cmd_buffers is
idempotent anyways.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 3480768274699..5556f55880411 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -297,6 +297,7 @@ static int nvmet_tcp_check_ddgst(struct nvmet_tcp_queue *queue, void *pdu)
 	return 0;
 }
 
+/* If cmd buffers are NULL, no operation is performed */
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd)
 {
 	kfree(cmd->iov);
@@ -1437,13 +1438,9 @@ static void nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue *queue)
 	struct nvmet_tcp_cmd *cmd = queue->cmds;
 	int i;
 
-	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
-		if (nvmet_tcp_need_data_in(cmd))
-			nvmet_tcp_free_cmd_buffers(cmd);
-	}
-
-	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect))
-		nvmet_tcp_free_cmd_buffers(&queue->connect);
+	for (i = 0; i < queue->nr_cmds; i++, cmd++)
+		nvmet_tcp_free_cmd_buffers(cmd);
+	nvmet_tcp_free_cmd_buffers(&queue->connect);
 }
 
 static void nvmet_tcp_release_queue_work(struct work_struct *w)
-- 
2.43.0


