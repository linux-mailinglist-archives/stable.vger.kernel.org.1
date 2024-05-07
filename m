Return-Path: <stable+bounces-43369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD068BF227
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3D61F21F20
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADF51708AD;
	Tue,  7 May 2024 23:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCgL8TLt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B421708A7;
	Tue,  7 May 2024 23:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123523; cv=none; b=VuO3Vbtu1IwAWHHdDwnl3LAdgSJJ46TdWprGM58eHaiBlwhYpGJATOXfTzbG4kRI7MRmmJ9vj61Dt2wYjk7MwDcMe1RCl4RFHhFqGnNldFGYVbGoCaKeI7x5CjZO8M+EmstNhgkQgr54GohmDUgS3UQLZg7msDUhhHQYrP0pEFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123523; c=relaxed/simple;
	bh=BW3sS1jeUTOlQ8ybavzsM9YtTj8gFtolCcVVBcb4G0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DgslZDmuyj5hvyzNEC8Girv969B1gOBVUs725fB+ZqdRxvhjns9BUFC3nYb4EFe0hDMwzdGIt5gmRBF2+lhg7c1ZMMPmyMWb1ajT9OydZSU+4uAZM8iahER/Gk8ceZnO7uoglEIi8/6LY0VZCF8+JryvJBnZNE3iwzoSYxFDPbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCgL8TLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB164C4AF67;
	Tue,  7 May 2024 23:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123522;
	bh=BW3sS1jeUTOlQ8ybavzsM9YtTj8gFtolCcVVBcb4G0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sCgL8TLt9qi2S4jyu7/OFC26vDQH4FJivgTaMqRQQ8UisrgI8lqD/bRXifuSXIO27
	 3UgYtT+w3KkWE3S1TNbaLTx9Ope5px33iGcdy6UB0d5AJkPtL557RG1uwmbDrq3iSl
	 yNBb1u5rU+pvopne/OHxs60swidLzmdE2GkIIzoTdSbTeQGz7Ykv415sAQp93rkHuG
	 rDW6nxa4V/LhBi8ZX0Fu4S0MkogumRc4r45Le0jRwtCgVIBzts9zE5qpeo4YCqrxsZ
	 aLNI2UYIkqaQRAYprRhl0RlG7deLUP2sqVxzd13keXMTKvH/h4eNPwEhHsL5AnpMkL
	 OZRWoDNwf/Quw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 37/43] nvme: find numa distance only if controller has valid numa id
Date: Tue,  7 May 2024 19:09:58 -0400
Message-ID: <20240507231033.393285-37-sashal@kernel.org>
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

[ Upstream commit 863fe60ed27f2c85172654a63c5b827e72c8b2e6 ]

On system where native nvme multipath is configured and iopolicy
is set to numa but the nvme controller numa node id is undefined
or -1 (NUMA_NO_NODE) then avoid calculating node distance for
finding optimal io path. In such case we may access numa distance
table with invalid index and that may potentially refer to incorrect
memory. So this patch ensures that if the nvme controller numa node
id is -1 then instead of calculating node distance for finding optimal
io path, we set the numa node distance of such controller to default 10
(LOCAL_DISTANCE).

Link: https://lore.kernel.org/all/20240413090614.678353-1-nilay@linux.ibm.com/
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0a88d7bdc5e37..b39553b8378b5 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -246,7 +246,8 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 		if (nvme_path_is_disabled(ns))
 			continue;
 
-		if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
+		if (ns->ctrl->numa_node != NUMA_NO_NODE &&
+		    READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
 			distance = node_distance(node, ns->ctrl->numa_node);
 		else
 			distance = LOCAL_DISTANCE;
-- 
2.43.0


