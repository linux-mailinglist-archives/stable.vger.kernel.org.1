Return-Path: <stable+bounces-128084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF30A7AF02
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF821B60278
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6587D22CBE9;
	Thu,  3 Apr 2025 19:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esCYX6BH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2352D22CBE2;
	Thu,  3 Apr 2025 19:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707931; cv=none; b=ECPrZOGa0dZ8SVDz3r1EvYY8BoXufdp9PXgJqB7kj55OCehL9eslDxIFCc5Cgdk88u/RMZHFaeM2ff0gpkYF9+HtdIgmP9LlksjYsCQkdR7qe5z3CP6Hlu6+kFZRg4Aj+oFvA3AdEXuSBwDxMjLqJEZquaS0Jv6WZTnQSgDgBzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707931; c=relaxed/simple;
	bh=xSrKWh5YqCq9yzXG+Vv51PmpUeJjbNU7Cjx0TVTJB48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GkJkiAddJll2qBgo+j33RKTMEymdoziWepyjvke+ZSByZ3l1jELbU/r05iHAmW5uhGd/Y1hccp94/qdVJ9uXBNBtnSC8KhnyySL+FKhpU1z2JM5jYT+OMKVS+fqB3vcMgMXNrb3zqRu/x5YG7nDp7zBOGu9DdHGn7uKwsGVyMac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esCYX6BH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA912C4CEE3;
	Thu,  3 Apr 2025 19:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707931;
	bh=xSrKWh5YqCq9yzXG+Vv51PmpUeJjbNU7Cjx0TVTJB48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=esCYX6BHxgNJAjuVnzQbLazXuIdrHQDyAQerGshaldohygl/EOY8fpNgZ5+MmYeqt
	 /cmRctLjY5k/w2Jtn+RzisjbcUgzL6d0HJAdrzcN69IeYt6S0RCGeMYm96oXXDaR8x
	 GMMBDmqxDgDCJF6vzqdAJiQVS2sTIvP2XfQ7WUd7WRL5HDkIeSkTrFciQvYellzRCo
	 UpA5eXi+ChmqGMnGnosu9HeHOwQQQ+e3gS3lBAiUIfCybf+7wuiwxULTa50p1yAPnu
	 fbF24fxy46pGyWhoGYFM6UHa/fVHuk2i3G1tujQY0zAcAytc+IblgrSXe149q8wxGX
	 /8Xlj/70KWijA==
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
Subject: [PATCH AUTOSEL 6.6 13/23] drm/amdkfd: Fix pqm_destroy_queue race with GPU reset
Date: Thu,  3 Apr 2025 15:18:06 -0400
Message-Id: <20250403191816.2681439-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191816.2681439-1-sashal@kernel.org>
References: <20250403191816.2681439-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
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
index a02777694d995..8cf6017e8c3d0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -494,7 +494,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 			pr_err("Pasid 0x%x destroy queue %d failed, ret %d\n",
 				pqm->process->pasid,
 				pqn->q->properties.queue_id, retval);
-			if (retval != -ETIME)
+			if (retval != -ETIME && retval != -EIO)
 				goto err_destroy_queue;
 		}
 
-- 
2.39.5


