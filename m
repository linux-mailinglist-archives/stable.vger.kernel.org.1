Return-Path: <stable+bounces-132501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81671A8829E
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4795C1898AFC
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757B82BEC5E;
	Mon, 14 Apr 2025 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Urp0phb3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ABE29899D;
	Mon, 14 Apr 2025 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637277; cv=none; b=rwHAq9Z9F8oVsZFD2FFt+bh0TiZ+S+xrOnhD6TTZpJKFqIbGd9Len6bjF6ZtRR1G7t3LHQDU4h4quqhUWz2mkL0q9AbP5ycerIch2JgAWxhlmhi2tkKIwFSwKH4cR3+NZFUMfKZpCdIcH9wOGY6WniaukTvOG3SNiBzDMb8o+fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637277; c=relaxed/simple;
	bh=PNaP345gDSSlxLCmwD5j7Q5zUx3k3pb511nj8ViwC28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=drAz2KyyTbHzD3rJzy0EfagQ6QM/QrmeL3gTYoAqxvbcidkbQtw2ErezGyvjDy1bmeaLrC8l91bECaIl72q67FcrjyvT8iG0M23cHzLMSOTHFg+hlIBYcJjGj/yxj0rL2cOcm3AzulpGvYdKF4/J2vgsVoXpGW00AQYxLQT8Em8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Urp0phb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0185CC4CEEB;
	Mon, 14 Apr 2025 13:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637276;
	bh=PNaP345gDSSlxLCmwD5j7Q5zUx3k3pb511nj8ViwC28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Urp0phb3LQJBjCnNWZ0Rmx3qlgewZXlnRKfflWGQkjqw0gh/YKhbaZ05t6Vh1iywo
	 N+EnhRaUPpE2ZMqXhwHD2dGbVntu7pwKE3gk21JG5ZtutEFP9BWYgeN40nvX08Q6x5
	 QsMzDo+vzrKnqC1ybTurlFohoupT899kD6KMR8jOUVJnRPCPXlqQC59YAnWeWff+Qc
	 WkXWkyQlNuhp3V0pv/v1MaZ/qr7yV7jZjwcGR73kEstnfuWYfjgkOd1AWtxAKflnPE
	 POgpnusFSjXi56UMqFJ2m5bJJNgN+IeKDC0cF+Jo7u4oDM+f+xVbte/EhIaQKABuyb
	 1IKYQIM/3dGDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Emily Deng <Emily.Deng@amd.com>,
	Jonathan Kim <jonathan.kim@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.13 13/34] drm/amdkfd: sriov doesn't support per queue reset
Date: Mon, 14 Apr 2025 09:27:07 -0400
Message-Id: <20250414132729.679254-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132729.679254-1-sashal@kernel.org>
References: <20250414132729.679254-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.11
Content-Transfer-Encoding: 8bit

From: Emily Deng <Emily.Deng@amd.com>

[ Upstream commit ba6d8f878d6180d4d0ed0574479fc1e232928184 ]

Disable per queue reset for sriov.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 9476e30d6baa1..f45fb81cacd2f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1999,7 +1999,8 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 			dev->node_props.capability |=
 				HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
 
-		dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
+		if (!amdgpu_sriov_vf(dev->gpu->adev))
+			dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
 	} else {
 		dev->node_props.debug_prop |= HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10 |
 					HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
-- 
2.39.5


