Return-Path: <stable+bounces-128106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 393F1A7AF47
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4BCC189C976
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF0A23E23F;
	Thu,  3 Apr 2025 19:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFFnwdDQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0977623E220;
	Thu,  3 Apr 2025 19:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707982; cv=none; b=KrskI090DOL7zrnQh7W3oq7T25OO1LpeP1F20h1sEco7IbRcCWCm2tSR77IEl1U3bXLCSpOyVJDpWM+umJ6b0L7No4IB9Q9fE4bN4+GKLjHjdMZF3uZ7h6kKD6yv294eDfmZQG+oPpPmI+yVVl607mkneeFMmadFRa8SDgpRFjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707982; c=relaxed/simple;
	bh=KdIfbpcRyecjOA55IM9hfeKdATnG6oEBPAHcpLycQDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dStRBcHEJOeHUgbAe78RzL5OYAHm98fhvJKzO3JBSvmqfX2C9yYXXL5AwW93PuWprV9DOGNFiRa/XjBPO5nujny0NekpZyGJuQPg841T3FuT0GPc4osR8xeNe6yOdhjH+MWnM6T+VBnqN4WU9UBSwiWOxw1L0iK4Ugv2MkUteCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFFnwdDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D59CC4CEE8;
	Thu,  3 Apr 2025 19:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707981;
	bh=KdIfbpcRyecjOA55IM9hfeKdATnG6oEBPAHcpLycQDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uFFnwdDQW/VJC2uge3yUFAlj6XTAVv7Wk8yT5xPuslLBqQbCDbHZ/tIgSpctGgaas
	 AtXkgJYMLQa9B6ax2rrFW4yad583RhYkjpEtbJ9EF45iPaawyoxXhVuwm2BQLhzfqj
	 kAO3CcfqZ6Y27tcz8UzNDyP01D60s+6ghSYDB9WS3e73AjEgYDJSr24g72KuqxxVDS
	 Ms4Vl7eu7FWFq/v7SRKcYL1d43H96gDOhm7xrVpGUrwc+K0393OoawQaYt+MNQaYQA
	 wgi5Jx9StZ149qucqgd3LcG9D1vQxAZ/fPlq6hKT7RD6ykd+Uh8eP7Lnoe4tXrson7
	 vhAu30zhpcCDg==
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
Subject: [PATCH AUTOSEL 6.1 12/20] drm/amdkfd: Fix pqm_destroy_queue race with GPU reset
Date: Thu,  3 Apr 2025 15:19:05 -0400
Message-Id: <20250403191913.2681831-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191913.2681831-1-sashal@kernel.org>
References: <20250403191913.2681831-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.132
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
index 1918a3c06ac86..a15bf1e382767 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -429,7 +429,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 			pr_err("Pasid 0x%x destroy queue %d failed, ret %d\n",
 				pqm->process->pasid,
 				pqn->q->properties.queue_id, retval);
-			if (retval != -ETIME)
+			if (retval != -ETIME && retval != -EIO)
 				goto err_destroy_queue;
 		}
 
-- 
2.39.5


