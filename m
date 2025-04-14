Return-Path: <stable+bounces-132467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D46A8823C
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E6317A38C
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CF9252294;
	Mon, 14 Apr 2025 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dC9pCLHE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4172741DD;
	Mon, 14 Apr 2025 13:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637198; cv=none; b=ekFu1/tz3PArpDg4Ip7WtVmKE2xvXnTLrB59ZoLuvBXEpyC+8LsW1N/orO7L8c929J5PThTjZtZtwBQKtanNRsbnSOB6B/nvmY2d6moUFprRxwbB4W0PutKAIwu3IL2PVR1GlD6S1gnTSa3tBgTKYYKNI5sSQWCnuVm/kfHeiAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637198; c=relaxed/simple;
	bh=YeSZBQwpzzR8hUTOOoinsaNOw85bh8mrv3KK45BX5BI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hEvkb5VI5BWCDLfDRK81TFr2APrvYUftZungNWTfx5z4zW6QI9qIidtJcTsKIFdcLEYoVGwut09Lc/l/6oXXvqYBXr2uOG+RCv0gQpYm9UToUaGsJ3cIvJuLm9t1S1BmEdGGAdwonm4pNSQoBc7b9X+pdtpy0Iqo+xycomE9M+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dC9pCLHE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABBCC4CEE2;
	Mon, 14 Apr 2025 13:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637198;
	bh=YeSZBQwpzzR8hUTOOoinsaNOw85bh8mrv3KK45BX5BI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dC9pCLHEusy96A4zHAuzVw6++C/ZFbEhKnK8+u6Ss2nijav2WJOBlT7dZZoU0IBjr
	 EV1DC/Qtc2CcvFbn0UzIiGTkTEJRYrm5gs2kO5qMg5DgIQcizMLFX5YEnpzF1fmw19
	 G40y4/vV79Eig5gD57EBTUCL2ZhBTMqV+mJl6r5zh+C2SDHi0wm1I8g7x5u4dJSOCi
	 uvqkOxEyDS8rkIjM5oeB8A0rED3goFA/hHN5KWDjGH4V7p7sYnVssPr3LFRN1848zI
	 uysnl5AoydcP7iCdknOsOa6GioEPigKsTICEeF1p/q5hgaw2v1gaTKUKmVPZTmJezF
	 93U0Dd7krIfcQ==
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
Subject: [PATCH AUTOSEL 6.14 13/34] drm/amdkfd: sriov doesn't support per queue reset
Date: Mon, 14 Apr 2025 09:25:49 -0400
Message-Id: <20250414132610.677644-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132610.677644-1-sashal@kernel.org>
References: <20250414132610.677644-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.2
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
index ceb9fb475ef13..62a9a9ccf9bb6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2000,7 +2000,8 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
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


