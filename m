Return-Path: <stable+bounces-43430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB768BF2B6
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3D61F22695
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799851A123D;
	Tue,  7 May 2024 23:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNN2dBaM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36851A122C;
	Tue,  7 May 2024 23:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123675; cv=none; b=hqkZm+mn5rjxPg6HWt1Rx723K/0TLA8LJ40gAAQFZTYKHk9xxiNWTjZo6PaL6Ey4un4IUM6nRdlEmWq+2yru7SfpWELoJSIDrfuSifdDVliumguWPC+CRUOuLQggPFRMId6wTzuMJPbl0vKxNcvYLgQTqPMrg1PXkSjk5oJgQ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123675; c=relaxed/simple;
	bh=NaNESS57i+/Yb9mqNOeglTPm9x3q0vcCjPQtoo5La+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkfIraIdpmxUcbjd+beElLQi/aWJuGJ8g5n0Afi97w93J7feJqZAiqv/GLWvbnbZu+0VmmqrskuF9THjTwTR45+rV7/3fgRHCslYD9osswhagu9aDTfOzY0OlW2l2J3ehikdzCI/bAnGQTx4fnZ6RwK0AyJ1EuCFRMzzkjGbQnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNN2dBaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F126BC2BBFC;
	Tue,  7 May 2024 23:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123675;
	bh=NaNESS57i+/Yb9mqNOeglTPm9x3q0vcCjPQtoo5La+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gNN2dBaMXXvRFR0tLNzVWbfjXeC3CtTAgpIIBLRLOD6nUXhNtNGxvdYcUmrDS+lfL
	 CJ7aqLT6IQUByyjdrzSVvL95jHaCRgW0tE9cJYrNrIDpw2cSGE1CtJ0rfHor2Simuh
	 tWtZ5oPxDQ7x0oVBHOxMFArd8eByz8QN54fZG/UWVAmK92Awjy6V0+K+8O3Hqa8zFt
	 wLA4HomT/r7VUxB36FMdPbn6zjd6MXIlTKaY2fnV0GhVhm/TgKX8hx1iFfYBK0elOy
	 LoyKhpcC7UWo+tTcnpYJTUgueHvhvvBtc0zdhnlhdb56DxwWQrakke/oNK9bxfJ4em
	 lmkiBduPvp6sg==
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
Subject: [PATCH AUTOSEL 5.4 6/6] nvme: find numa distance only if controller has valid numa id
Date: Tue,  7 May 2024 19:14:22 -0400
Message-ID: <20240507231424.395315-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231424.395315-1-sashal@kernel.org>
References: <20240507231424.395315-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.275
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
index 811f7b96b5517..4f3220aef7c47 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -180,7 +180,8 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
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


