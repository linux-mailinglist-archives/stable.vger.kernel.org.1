Return-Path: <stable+bounces-128132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A65E1A7AF91
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C78F23BE370
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC8D263F52;
	Thu,  3 Apr 2025 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RST1eXKD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF43263F4B;
	Thu,  3 Apr 2025 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743708045; cv=none; b=kZxywnwIFcg6TyLZLLjM+Z0ZNFXUWqI0X+0n6xBJ6cqfnU6yAfB5Qj1Bk6f+Lh47JG2LKoQHdv9p5rmxIcHGYPzNfk5HnBfY3bR0VY7FIqjrOtjObNeAlqL5CYue92EYRjvGzGmhMwf5hAMQrNpM8V2YBbNrLva5VxdoOHsiwMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743708045; c=relaxed/simple;
	bh=RqaWF5f3RgOeBVSLABuEdzf6Osq+AupEL+7ZSkE/wjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nlv02y6WZ6wX/rHS48bavq/B5HyMC9gQzVyawa8tAL++SNq+S0/XFq+FfvkxFS3KbicEqVZDW1Q7j0vyPl5YJzR88X5hShVPyz0PYHyhVcjDgEBfr4pk7p+vFpm4OFBhdRi1pxLHUNRuoXbaezG//T1eaqHgkN1LTzrF7hwTjFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RST1eXKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8450C4CEE3;
	Thu,  3 Apr 2025 19:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743708045;
	bh=RqaWF5f3RgOeBVSLABuEdzf6Osq+AupEL+7ZSkE/wjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RST1eXKDSR57dDAd24lV4xfcWgQI9BnHVSnztAkQgn2VtxSjMfmJe2/kxlf814VcI
	 iiWnNYo13cdLNo9g5ox6PASPkGDCfcPY/3anNxfBxgQPuI7WtNYQKK4RnZxHN9BVDU
	 nVBbHZT96cdrLEQ1y9iX800FKcaOI+k2Tcfjps4mdLM4L9VLZhiYVUDsf8xXDCVKbw
	 OYilsqPZL30LgdeEXJWKrqigDpgxbQhJ7Bd2HmmS9qkwIocXiZEIg+V9p+58FL5vRA
	 VPs2rqIUMQnMIIND5WhZ8jOj0mv/JaDkxUMhyWA9C5vhr8xrV43QQo7vFIQ9AZOe5s
	 RPZ7bNi0DwUgA==
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
Subject: [PATCH AUTOSEL 5.10 6/8] drm/amdkfd: Fix pqm_destroy_queue race with GPU reset
Date: Thu,  3 Apr 2025 15:20:28 -0400
Message-Id: <20250403192031.2682315-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403192031.2682315-1-sashal@kernel.org>
References: <20250403192031.2682315-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.235
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
index 43c07ac2c6fce..cabe0012ab5b1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -384,7 +384,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 			pr_err("Pasid 0x%x destroy queue %d failed, ret %d\n",
 				pqm->process->pasid,
 				pqn->q->properties.queue_id, retval);
-			if (retval != -ETIME)
+			if (retval != -ETIME && retval != -EIO)
 				goto err_destroy_queue;
 		}
 
-- 
2.39.5


