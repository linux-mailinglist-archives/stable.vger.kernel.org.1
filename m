Return-Path: <stable+bounces-43424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0018BF2AA
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2351C20A63
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6128D184487;
	Tue,  7 May 2024 23:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+sdp+Ib"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF7119F0F9;
	Tue,  7 May 2024 23:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123662; cv=none; b=LmNfRS9KXjbOTeRhcB2gPAMBxSmwP/TeLqKUmPAU0oZtljMqJRsDhML7rL2ROe/vsvrf5p/ZDGD1i7yhMAcvm4q0Fl9TvXX4sDfGQOs/d9+cSpsCJ9eGQy4U0rjQGmooXvDXFhMu+lKzdfJgAmLO/U1iBegaGRddVgj8UAaec70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123662; c=relaxed/simple;
	bh=jEyNlku0t6GHW7QmWeecYZadcby2sfahyDeKzw51+lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CH9YWDitGQR21/FyQohjHt+dUgNcndyJtHBJTTSKW9vyhM7mm2zB86gFiVT/JUuXK7Ld2AVp1XDUyENJgLjKiGLAecg/wOeOWeKXZ81/pVoaOduxjhctMC8T2GvRmZ3b51yDJS+We4T7DlnuaU4sLr6FlmRZj2HJmRPhxEHBNcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+sdp+Ib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6040BC3277B;
	Tue,  7 May 2024 23:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123662;
	bh=jEyNlku0t6GHW7QmWeecYZadcby2sfahyDeKzw51+lU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K+sdp+IbqjB8HpGTgUp2RXQZBE1GBJQl5cR0c2uYOGWM2rUoMzTVJe75S58h4sDJo
	 gIWIA1UMU6atNPS8nSjxKooPgAvJUlXZecFM28xkBE4NFXN9rC1z1b4lj9OyCRWeOq
	 cvBNdQ1vb+SWKr5p8uvgY1icjmvLkJFz4Ykj2YVr4+oeeq5Vt1gh8DxspunL1AQNQR
	 q2MkfcnZAfrpSBHULqdfAt0pV9Tb5tnYXEDPLk3Rb+GV3UlYcKl/JvlBwsry4qUgwJ
	 ElNHWVERsSvnZMVZ3h4stu3SdObqRYsywVSHJoKSMcH74zHTi9KE3rihZJY3iFIahN
	 fMcQUtENWyUYA==
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
Subject: [PATCH AUTOSEL 5.10 9/9] nvme: find numa distance only if controller has valid numa id
Date: Tue,  7 May 2024 19:14:04 -0400
Message-ID: <20240507231406.395123-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231406.395123-1-sashal@kernel.org>
References: <20240507231406.395123-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.216
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
index 379d6818a0635..9f59f93b70e26 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -168,7 +168,8 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
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


