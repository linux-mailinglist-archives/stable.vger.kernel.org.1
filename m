Return-Path: <stable+bounces-154834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A87DAE0F1B
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 23:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E47E53AF73A
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 21:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699DB21C9EB;
	Thu, 19 Jun 2025 21:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6QgQkvl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245A230E85D
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 21:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750369812; cv=none; b=ji2Gy89evbjDt2a++sxKIP83680qcHyC+B2pgPmaaEFhTev93pji2tuu8IdLiWOt4WBswJwU2t2ytoR6rw/IhE55ZHhiA9vw/RRarmksyDYyGHj3OUiABFut9tsTGsmKfuiFTL5b0iuHv4tOej7BL4l3dP66s+54r9wU7Ee32pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750369812; c=relaxed/simple;
	bh=YsgWAgK51Ou8rpQ+xYoQhLvKzW2q0UBdHnkSqBJQuOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SuWoZUR0783LmcPdWVanf0QxR8w2dVRWtmlpv2vPO/cBVRVvV0emrM0aNAkuKyOkIEQADRkvKD+CPFrB3VjMkJIDQa/QEfqs35t8YWlVYbkSJFKqXuRcKZclplYtH89+UqbXNdGykl1QKzBPPyyjzgpl3z8i7ZTzWTW11OHZj4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6QgQkvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175E9C4CEEA;
	Thu, 19 Jun 2025 21:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750369810;
	bh=YsgWAgK51Ou8rpQ+xYoQhLvKzW2q0UBdHnkSqBJQuOM=;
	h=From:To:Cc:Subject:Date:From;
	b=G6QgQkvlo4e7kGb5zi1ABxctSuYlbEjSvZ+7qMgpQJvogmzv02Tt6C0LZGzbHipS9
	 Fwd8OKDpwFlJqGv2GebZVIIiAjTz8CxkGlDrCzvMgPVXxooKkjBPw8ll0W4v823AiX
	 IbwuelJRsb+WLNnJxUshLu94jSW6nMesHJyCNk6FQ3OgvSxfaQnROhoPjeAs/kK1Z1
	 igZXdDjbQIAHDRUE0Ijoqt87P6bI7N9YEPbzvE+9FJmCqYascJm95LSdW3qlBoE1Og
	 FsasDhohTLvDyDYA8YtBncCLSgyr2hg/gniL/3bV7YYFHOkKj8LfaSlJ1UCAfj7ZC5
	 Q78t6gHEGLw8Q==
From: Mario Limonciello <superm1@kernel.org>
To: stable@vger.kernel.org
Cc: "David (Ming Qiang) Wu" <David.Wu3@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Ruijing Dong <ruijing.dong@amd.com>
Subject: [PATCH 6.12.y] drm/amdgpu: read back register after written for VCN v4.0.5
Date: Thu, 19 Jun 2025 16:50:07 -0500
Message-ID: <20250619215007.2453681-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>

On VCN v4.0.5 there is a race condition where the WPTR is not
updated after starting from idle when doorbell is used. Adding
register read-back after written at function end is to ensure
all register writes are done before they can be used.

Closes: https://gitlab.freedesktop.org/mesa/mesa/-/issues/12528
Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
(cherry picked from commit ee7360fc27d6045510f8fe459b5649b2af27811a)
Hand modified for contextual changes where there is a for loop
in 6.12 that was dropped later on.
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index e0b02bf1c563..3d114ea7049f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -985,6 +985,10 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
 			VCN_RB1_DB_CTRL__EN_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done, otherwise
+	 * it may introduce race conditions */
+	RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
+
 	return 0;
 }
 
@@ -1167,6 +1171,10 @@ static int vcn_v4_0_5_start(struct amdgpu_device *adev)
 		tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
 		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
 		fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
+
+		/* Keeping one read-back to ensure all register writes are done, otherwise
+		 * it may introduce race conditions */
+		RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
 	}
 
 	return 0;
-- 
2.43.0


