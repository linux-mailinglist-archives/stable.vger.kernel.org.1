Return-Path: <stable+bounces-127979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21497A7ADD5
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 770E417E546
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC30294155;
	Thu,  3 Apr 2025 19:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJwkXZha"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5E529414D;
	Thu,  3 Apr 2025 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707666; cv=none; b=UwbBrOjF30VhK764o70qmuBkr0AAns7djNfPeeryfSx+eBLT6GCJ2Qy4S7CIhPnlwmNvVIWdxUDbU+atiu/sgpEQHkOTapv+t1dLCi5f8Y1a8aRWKaHhIo/nYf3xtQ+EvsuMkfQfXkyZKGSL8a5RANUe+f55sdq3DGOrm3Pgsl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707666; c=relaxed/simple;
	bh=5/vN0YwXwBmhXrE7YQuXllpcuXpi8NiaIFvIuMQez/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p4jL46pTpONxUAYGH9TXNUzMG1RBf0oD3DFjt5GpJNgOetcl1QbaXH34RcZAuP2Rq2YuWIKOMP1xOXPNK3dvPSgCgo8ot+GbYihvGb1xG6WQB0cs9FjVZxHR3zG1jUqHE5wNQmArj1PTZk+V5uazpuR6NY+uUTUxZ5FZIrJNplo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJwkXZha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD35C4CEE8;
	Thu,  3 Apr 2025 19:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707666;
	bh=5/vN0YwXwBmhXrE7YQuXllpcuXpi8NiaIFvIuMQez/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eJwkXZhaKXSRk7ZonwZGnk7uhg+3wzbFGldGOGD0QBeksTDOMI7NK4sGErz38iyaO
	 5XkZLQq29jYdhuSe0iaF0ItmpuUt7xJLIWwcMb1Gn7BxOl6C4BaSuXjBbkqA4GX/hX
	 pBqdwrGuqcneJwGPPeGsl+Cc9fLZ3oUlVrRDymobAV1BLY5+CRrv5UhTYLuc0eqKmS
	 TgnwGAKY/3paj5vBPXVE5G3H9+VBsJB8HOSVWnZ/Z/AQp1luzskel4IseK10VXWXFZ
	 pz5d+jwyx6H36EZPb+Cc3eqxv9Bsfd8msCBzgIBeO6StRwzF4mA2ohDceg1dxxgkKZ
	 A3/19ALB8tpDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Philip Yang <Philip.Yang@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 24/44] drm/amdkfd: Fix pqm_destroy_queue race with GPU reset
Date: Thu,  3 Apr 2025 15:12:53 -0400
Message-Id: <20250403191313.2679091-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191313.2679091-1-sashal@kernel.org>
References: <20250403191313.2679091-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit 7919b4cad5545ed93778f11881ceee72e4dbed66 ]

If GPU in reset, destroy_queue return -EIO, pqm_destroy_queue should
delete the queue from process_queue_list and free the resource.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index bd36a75309e12..863979531835b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -532,7 +532,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 			pr_err("Pasid 0x%x destroy queue %d failed, ret %d\n",
 				pqm->process->pasid,
 				pqn->q->properties.queue_id, retval);
-			if (retval != -ETIME)
+			if (retval != -ETIME && retval != -EIO)
 				goto err_destroy_queue;
 		}
 		kfd_procfs_del_queue(pqn->q);
-- 
2.39.5


