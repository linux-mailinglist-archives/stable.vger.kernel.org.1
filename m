Return-Path: <stable+bounces-128122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC92A7AF75
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 588E93B32BA
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB1E25FA2A;
	Thu,  3 Apr 2025 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNOILNGI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662CA25FA04;
	Thu,  3 Apr 2025 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743708022; cv=none; b=A6Nl1GR7uTCN+dlHxDYF3ocIZd/6ygx6Q1gqQqv1/+y6wHfqrXygDyQkA543/jQUqL7AcdFtert35ABvBnZDbTpWo5ulHiov9RI7AeePyqZu+OWp/bgBNy6SseyagsTh2YSEatEvra2nt4RAPyAUxrUfx4vh6bYQMY0VvnPyp40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743708022; c=relaxed/simple;
	bh=n4B88VHlunu5YI/4JvYHzG5RGiUvxA9A5zq3LCDfcnw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QnjtSjZaVuc/Mt4wNfZG+5GVZ3nbIz/E5kSknGBBiGCfDIKSOZiIjQn1QHnQ6F7WE1iI24gMLblI6iEKOHmUwlxnJ+YI/uByhOjfRn5l0IBBA1sAR79qk9w5TR7tk/FgcsatYjsKL+07EnSF8uC7c7v8IJ3a5MFkq3Vm7Omiy8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNOILNGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5CAC4CEE3;
	Thu,  3 Apr 2025 19:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743708022;
	bh=n4B88VHlunu5YI/4JvYHzG5RGiUvxA9A5zq3LCDfcnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cNOILNGIgE3WENJGaAJApmNc3i+osbv9JAwMJfjdImV6sKJs4kGNYP9KC3GHa0Bee
	 Ap3eLZfybLCTnLjlvDh+/iMm0qYMPCid8VgsfuS5d82XQocP9rPUmHFoiU3Ogv90uL
	 YEGu4yjMEdPFXE1fq/BfOdx+sw7WTUx8jndd08UZjrcfevbnx/TXTXveviIPDFuYNW
	 iJmEqy3JOIjD9p0m/2pnqZhknoIY3KX1FTYtSd4JncJ6Dzk5hICHasbmUNGNGXi4CO
	 VU64WDiohEThcAI4QqKojkkt6V03UW3Wv6uToib3O+tDiP7aWvs71AX0obFYznc3Ns
	 WcOWOx7Sg7S7g==
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
Subject: [PATCH AUTOSEL 5.15 08/12] drm/amdkfd: Fix pqm_destroy_queue race with GPU reset
Date: Thu,  3 Apr 2025 15:19:57 -0400
Message-Id: <20250403192001.2682149-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403192001.2682149-1-sashal@kernel.org>
References: <20250403192001.2682149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
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
index 243dd1efcdbf5..7a298158ed11a 100644
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


