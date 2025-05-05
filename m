Return-Path: <stable+bounces-139809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8798DAAA002
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF921A831DD
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD27628CF45;
	Mon,  5 May 2025 22:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7NYeMnd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D00F28C5D9;
	Mon,  5 May 2025 22:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483392; cv=none; b=Ga7iwTemmIY8vmBCsSS0grThCWABcw5XzHWyeMuUSc0C0En89VKtLqX3CfiaeJ4SsW+wMwcuuw6DcXEXibzoaDaGrLNkDLM59qz9MN3ZtPyaTMZOO0ZokI74j/kxltZhuElCwriXb70lCa+yGVdLRwbGhfDAWLfq8/Zdn0UzRp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483392; c=relaxed/simple;
	bh=ILjGPL7YznZaK7LmROiSM/ALmSuwjcbwF7zDM1o8V0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G4zq97anArb5dXeX6g3M2yL0nd3Zp7T/ckIngjQP+dgn/ltokjUagly2KmtXJEGQm0YuWidxC19fF2aEFm9LhCYKv74vPneGcIGxpVUouBQddS74/VjpaE5AhJzBq8nYAD8paT+pVjjKGwjm3tQSky4XFdVcmxULaqScpQUojGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7NYeMnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EFFC4CEED;
	Mon,  5 May 2025 22:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483392;
	bh=ILjGPL7YznZaK7LmROiSM/ALmSuwjcbwF7zDM1o8V0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O7NYeMndXtRemY9s35K1KQmwslz7N9fvMiP0jhxsw3aHFG7nYGeeoL1y/UrUgxgTS
	 SjP77MEy2JFZvi841Swd52CrJzvOUrcYQqa1afCx1R6H+gSOWJPX4V5g0rR7mg9FXQ
	 yhjK82Dgr4WszTJWU4Q6z22oJKRXMHP9gisGm7vClp/RmHf1P+jWR/xkz2z84JpYVY
	 XKWot4JeDplywFov+N6YTP0lsmRf37RAsOGJLh+MVCYJm3MryC8U983oFEojs7A23D
	 6c1EIy81fuhmM1vBG0IipLyWI8fVwMDaYP0f2y2wIbRJU/7FzXCvX9J8/VuaR34egw
	 uN9SAq69tr9cw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jonathan Kim <jonathan.kim@amd.com>,
	Lancelot Six <lancelot.six@amd.com>,
	Harish Kasiviswanathan <harish.kasiviswanathan@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 062/642] drm/amdkfd: set precise mem ops caps to disabled for gfx 11 and 12
Date: Mon,  5 May 2025 18:04:38 -0400
Message-Id: <20250505221419.2672473-62-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Jonathan Kim <jonathan.kim@amd.com>

[ Upstream commit f82d27dcff939d3cbecbc60e1b71e2518c37e81d ]

Clause instructions with precise memory enabled currently hang the
shader so set capabilities flag to disabled since it's unsafe to use
for debugging.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Tested-by: Lancelot Six <lancelot.six@amd.com>
Reviewed-by: Harish Kasiviswanathan <harish.kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 62a9a9ccf9bb6..334c576a75b14 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2006,10 +2006,6 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 		dev->node_props.debug_prop |= HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10 |
 					HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
 
-		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(11, 0, 0))
-			dev->node_props.capability |=
-				HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
-
 		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(12, 0, 0))
 			dev->node_props.capability |=
 				HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED;
-- 
2.39.5


