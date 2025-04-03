Return-Path: <stable+bounces-128140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A7AA7AFA4
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF4F175EB8
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50362E5DA3;
	Thu,  3 Apr 2025 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiKquAU/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63536264A89;
	Thu,  3 Apr 2025 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743708065; cv=none; b=seAJlU5Kkjhph2QGt2TgNnBvsHUS0nYUk+cHSL9jCccyGoAvB+mWpXtwdyK8iIiepd6eij3rm/pLZ2vkGXx4nj9HjPYMICD2CR2rfLaVLmU6Fd42FrZI1sEmZPYArafaOafMN76eW3IoA7YHTEBS3bRsUGw8vRtVva1Y1/lCaHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743708065; c=relaxed/simple;
	bh=WTfK9BXj9xSzt4iGE8jnqlprI74NOR9SU4X7/7XK8Ik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mfLKBEBGaYmXpah9L1eXjgvTqVxR47DlqF1WO8hrXUJCTnBmUSFzP4iVmtnmUJgSWGhyA4I8TN3sCzrqTJ4ZHW4taRlpBjktXM8lqASyuXYQBZLilDslBTkxW5ni74W3vldWV/mlHCY+YiYoAbWykZRTJI0lPlUfS4mi3Bjfd5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiKquAU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B1AC4CEE8;
	Thu,  3 Apr 2025 19:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743708065;
	bh=WTfK9BXj9xSzt4iGE8jnqlprI74NOR9SU4X7/7XK8Ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hiKquAU/yzBZuLBO7R1mnCyVmingzHp8p0m/T5Qy3oZr0gTg+jefhPDkIvSAeys2E
	 EgFKqnzqwUndLv2uK/6OsdBY7y+nqVVt1eyCZQqCpkZLKtQa8ZdtieCvjWv/RJ3A8E
	 /t/xZkIjQUBV1GaGPh2EXSYd2DS4n6qS2/qENY0gEwrdbOE+aLngJitR9HXixvUJXz
	 MQ8/yqrf4xWqWkrUCIfs/frulQRhQtzrLdr+5imBy0zN0Okd4wDT/tpSVdLY/sgzJd
	 r3KAw7rOfF4UPKW3wi4YiDrq1clO4fxcxpJuUSkgmC5k1prd27YWNnBB3CabGWGRNc
	 mv37pdNicmTrg==
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
Subject: [PATCH AUTOSEL 5.4 6/9] drm/amdkfd: Fix pqm_destroy_queue race with GPU reset
Date: Thu,  3 Apr 2025 15:20:47 -0400
Message-Id: <20250403192050.2682427-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403192050.2682427-1-sashal@kernel.org>
References: <20250403192050.2682427-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.291
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
index 7e6c3ee82f5b2..234a09b60c552 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -380,7 +380,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 			pr_err("Pasid %d destroy queue %d failed, ret %d\n",
 				pqm->process->pasid,
 				pqn->q->properties.queue_id, retval);
-			if (retval != -ETIME)
+			if (retval != -ETIME && retval != -EIO)
 				goto err_destroy_queue;
 		}
 
-- 
2.39.5


