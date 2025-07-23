Return-Path: <stable+bounces-164505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FA9B0FA7D
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 20:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5214E13CE
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 18:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1C72253A9;
	Wed, 23 Jul 2025 18:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXBSp1Z7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8131E9B2A
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 18:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753296569; cv=none; b=oZXjEVvq4gEPeq34Zpphdbx4l60GRc+gsgcDL7YJEg7YImo6tTDdnpgKzJ3ckezUKWhbwwFhTE61YQ/RWIorS44kTkPCewTmKFHruTR7B6OH+cEsJhT8OfJnIiZI1UWs3mwrfvm5zXYnaZEwJFtj3VfeRcUVyQr7vFHgZd+Tleg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753296569; c=relaxed/simple;
	bh=zy1Xnsj5w/EykV7vKf5+ECiztd8qkv6FdtXpsqOBTas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zk0IwRfrMto6ALfIXu2CZ1hioDIyDztzWLtFEvYZ/hqmInqx91H1GlJ2+NG2NkPMNNl6WKKuRjzmMGS6WJL2VtbE7uLnhIH+iUZjfxyTFkg9Nn7siY33dVDbdHZyKnDDVYaMw9+c57oepdlwD60wSAFpyXlWT2WpuaqeCEYOuHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXBSp1Z7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2700AC4CEE7;
	Wed, 23 Jul 2025 18:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753296569;
	bh=zy1Xnsj5w/EykV7vKf5+ECiztd8qkv6FdtXpsqOBTas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aXBSp1Z7res2URTd6QJyvEHQ4nkHQnPQbKKWJmdsKB2o4VRZuohHiUMDS/d2iNlxB
	 tV+1QnsU8++LdYWJEzSsNJweIMAoTlbubRrShwEw0vdPKv2Eobh/PclfkD7mEKNqop
	 BTvm6kBf5HUiJgPu6jo6etYMQ3e2E2GhulkGHtdBPM3pWXtLt9b53UUkCXtX2W4VoY
	 pmXZOz67RLO98fhMOhxE/U0Xi3TSI6qftlWJnxxmNJbvJqDuoM6+T4i7Nm4hG1NyPy
	 7r1pRaFWwws2QvTWt6PrTZaKBrWPxsQ9uarZP8NkoSOJDZLIcIrlOxslFA9dH03zgR
	 ZHVxnMsaN8z7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <jesse.zhang@amd.com>,
	Jonathan Kim <jonathan.kim@amd.com>,
	Jesse Zhang <Jesse.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15.y 3/3] drm/amdgpu: Fix SDMA engine reset with logical instance ID
Date: Wed, 23 Jul 2025 14:42:42 -0400
Message-Id: <20250723184242.1098689-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250723184242.1098689-1-sashal@kernel.org>
References: <2025063022-wham-parachute-8574@gregkh>
 <20250723184242.1098689-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jesse Zhang <jesse.zhang@amd.com>

[ Upstream commit 09b585592fa481384597c81388733aed4a04dd05 ]

This commit makes the following improvements to SDMA engine reset handling:

1. Clarifies in the function documentation that instance_id refers to a logical ID
2. Adds conversion from logical to physical instance ID before performing reset
   using GET_INST(SDMA0, instance_id) macro
3. Improves error messaging to indicate when a logical instance reset fails
4. Adds better code organization with blank lines for readability

The change ensures proper SDMA engine reset by using the correct physical
instance ID while maintaining the logical ID interface for callers.

V2: Remove harvest_config check and convert directly to physical instance (Lijo)

Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 5efa6217c239ed1ceec0f0414f9b6f6927387dfc)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index b80e80d7ff557..c2242bd5ecc4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -572,8 +572,10 @@ static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instance_id)
 	case IP_VERSION(4, 4, 2):
 	case IP_VERSION(4, 4, 4):
 	case IP_VERSION(4, 4, 5):
-		/* For SDMA 4.x, use the existing DPM interface for backward compatibility */
-		r = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
+		/* For SDMA 4.x, use the existing DPM interface for backward compatibility,
+		 * we need to convert the logical instance ID to physical instance ID before reset.
+		 */
+		r = amdgpu_dpm_reset_sdma(adev, 1 << GET_INST(SDMA0, instance_id));
 		break;
 	case IP_VERSION(5, 0, 0):
 	case IP_VERSION(5, 0, 1):
@@ -600,7 +602,7 @@ static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instance_id)
 /**
  * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
  * @adev: Pointer to the AMDGPU device
- * @instance_id: ID of the SDMA engine instance to reset
+ * @instance_id: Logical ID of the SDMA engine instance to reset
  *
  * This function performs the following steps:
  * 1. Calls all registered pre_reset callbacks to allow KFD and AMDGPU to save their state.
@@ -649,7 +651,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 	/* Perform the SDMA reset for the specified instance */
 	ret = amdgpu_sdma_soft_reset(adev, instance_id);
 	if (ret) {
-		dev_err(adev->dev, "Failed to reset SDMA instance %u\n", instance_id);
+		dev_err(adev->dev, "Failed to reset SDMA logical instance %u\n", instance_id);
 		goto exit;
 	}
 
-- 
2.39.5


