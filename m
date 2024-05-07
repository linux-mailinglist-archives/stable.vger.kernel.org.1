Return-Path: <stable+bounces-43414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8CF8BF291
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEE8FB21033
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234C719D410;
	Tue,  7 May 2024 23:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkZWDC8z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E8719D409;
	Tue,  7 May 2024 23:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123642; cv=none; b=LxDf2/Biff8l5zzxkRB6UU/YieRT23pPh4FLbCgnSy7IEk5VE2Ggay1qAy9Ts1A1jn5LRD8v1H+Qatx+kIjPy3GozZws9HTfJCdOY8XYYKU5zs4b9miZTlUIMZr5pfOtn/qnJH1d+OINo9j+HKQGHcQeMDTUGqAswOABdNU3Zag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123642; c=relaxed/simple;
	bh=Hs3S7Bam/o6E7QCw9UqHc74qAk572AAnODzDEDVeXjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNRGKj5kyvDieOxUvlKrDFp1xwfBkAvrGtjMWnOvcMPoBdg1U2bLtHSaDPt0DDpiHxmrr/RV4XWeBUbH3qk0HvnmOTzIVP28ATHdvI5v4n+jxrKkp0y96JcVW0a3y+CBYjjQ9eKZRAKWmJPF9W3Uo4T2Omhc4MVPqcZ2Ls7UziE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkZWDC8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A45C3277B;
	Tue,  7 May 2024 23:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123642;
	bh=Hs3S7Bam/o6E7QCw9UqHc74qAk572AAnODzDEDVeXjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pkZWDC8z74R2b1n3eR2l8MG9dZvWmeo9XP3/ACMLmPbGGslvmPDBGt8WBQqRz7e9P
	 vaeZmKK5SZVhpxNb9LI7jRvX/pbOzA19eOrY/f2ugIDlK5Bjhi3rYAB9b3XyEVGglu
	 YKyuvXpJf/jrTNlt5M7UY+9NFPB/lVC7esiNnBJffEDUqIjTl4VeitR07BHogdtyNi
	 gKWNHeW/2gCO1zVHl1t25uUltChcpNE5604GVOPrAzhsKyQ09vGmKEuu6R2L2PZtpg
	 SwjYSnEcIr/UQ+lcrQU58nj5CiTM/8tDV823c92fda772WUFqzqP+vYCwS3lIcy9IY
	 BRvrwzYl4RywA==
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
Subject: [PATCH AUTOSEL 5.15 14/15] nvme: find numa distance only if controller has valid numa id
Date: Tue,  7 May 2024 19:13:23 -0400
Message-ID: <20240507231333.394765-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231333.394765-1-sashal@kernel.org>
References: <20240507231333.394765-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.158
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
index 73eddb67f0d24..f8ad43b5f0690 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -190,7 +190,8 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
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


