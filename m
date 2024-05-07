Return-Path: <stable+bounces-43395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5132E8BF266
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9F828727C
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563871C8FD8;
	Tue,  7 May 2024 23:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aeqz4a1A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138761C8FD2;
	Tue,  7 May 2024 23:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123597; cv=none; b=kwHqd2bJhHQEZGuz3iXNeVChU9coENgwXqMCjrch2ZVWZMjSBfWNME8rlJawsBKY1nyzhelzgjyDbR62lV9hCRdzNJLwdkUnlfZRBR5ZIyrcphMm77DMBVO0RbF8h8kLFL9nxHZ3WOuWJDtpJA4cppr5zPVBmndU4JthXIRFSLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123597; c=relaxed/simple;
	bh=EKN08DW9s7MzrLgAqdyreXAk1J29WVSlpid6Z3QJLFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1ykx203yeE9ByQ0yPoPrigNU34GMFYdNltimbXGlnTEaqxaSxRgye9MepcpAQwjeXcc/z0Vrpvy05/o6A4/zXs/cbJo/cGTLl2bWKGPAsjl5YNwEAtSpIG3vUQpDIMIkAV0oKqEfV42sNHiAqEFkQw7IVigswQFZwMafnGMAvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aeqz4a1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1BEC3277B;
	Tue,  7 May 2024 23:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123596;
	bh=EKN08DW9s7MzrLgAqdyreXAk1J29WVSlpid6Z3QJLFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aeqz4a1AC2PlBWWpEFEPn6C6yH6g5cQFAPkVWP6olQB84fa0O1Dl57AUNRX7xc1XR
	 zkUTI89BpwyHRzKHYD0FBvGmGMKoGrfJHz1C7+ePfe3z5ObuV43ctXeX+zDqVUEYH+
	 tctnmr2ialhB1wDL7KflApXOu3zeNjFlTlAt4IhCYbuATmIqwPtI0s4jrZvg1EsxyI
	 AFwsLcbsAYJ0SOABH/8w4/JbzQ4aFT3ZqsLnrPbjhmGO1iF/VyDXCWbHyT6PfXGdV+
	 pM6JlE4bVJEwmMzdpp/vI7UmZWyWSLCOp1vQWcYmk8dlU7oCPjx/RWIbFwyjk+iN7D
	 pumfViqVZ9KrA==
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
Subject: [PATCH AUTOSEL 6.1 20/25] nvme: find numa distance only if controller has valid numa id
Date: Tue,  7 May 2024 19:12:07 -0400
Message-ID: <20240507231231.394219-20-sashal@kernel.org>
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
index f96d330d39641..6cf0ce7aff678 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -213,7 +213,8 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
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


