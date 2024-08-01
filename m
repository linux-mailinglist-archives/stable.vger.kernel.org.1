Return-Path: <stable+bounces-65052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A170E943DDD
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4130F1F22538
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C9218E059;
	Thu,  1 Aug 2024 00:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9yojU2z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6BF16C695;
	Thu,  1 Aug 2024 00:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472189; cv=none; b=qs26BScGp0DxFZM29gEbHsjk4hBMjWUoLOYw7E4XyZx0RkVTY4IDXYUrsw2+YCLSmMaEwJFtvtiqFEpV+5u0E3/fsyaOTjNQWZIDgirAdFk8CsKt6T7qbygaC3D8r0g/ZhHTm0Ez7isIhW7swBijQHvWs67fYo4X2C2zKnDYKLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472189; c=relaxed/simple;
	bh=rWMDJJ742n99uxKa6jUDYnFaQNv1BbRTSwUpX+tRzQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPbHbSuc5duRgsU0WCQ9/0OrNvKjN2b5sYAGmF9nptnoYq9h+t3gwbKHp54Ic8hn4o0wWcRPuH28yoV0chLMFbQccb7jN+3OjAdaoMbdq4UYpLRioNe3R1St5dcx5Z+0OHdASly6gHU1pnGo5FU943/Z0iBrTIaEwSwwd1Y16XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9yojU2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B3EC32786;
	Thu,  1 Aug 2024 00:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472189;
	bh=rWMDJJ742n99uxKa6jUDYnFaQNv1BbRTSwUpX+tRzQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n9yojU2zsyjBQdXkbC0AufV5PYl84dtKCo5IAR8yJjSmiOjReyVmPoGKZkLVPjUhn
	 9UDW8Y98nN6MQd1sv54RkjQ0ylKcabQyw71+c44VBNtjsy9Z9RysAQmXTG6c/QK4vi
	 8AtUIIqTeUR9A8MhhmQo2ANlX09eaFjjZF6Wjo0cezlmJ/by8vOCuWnOyRBJMwZadq
	 ieJgNGxTUY9zw7kuQ94hCav8SCiD1fN/W8F8wncRn0wV42tSF3wBF7+vDjLy7/wYqG
	 5uKEhpvSEqaeWILpLoMljrY/9Rus2/wZAZwosppPGoCfEB0uPLnaQyjGCHqkS6Rb8v
	 PaTzInFNx3r+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jesse Zhang <jesse.zhang@amd.com>,
	Jesse Zhang <Jesse.Zhang@amd.com>,
	Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Hawking.Zhang@amd.com,
	lijo.lazar@amd.com,
	mario.limonciello@amd.com,
	candice.li@amd.com,
	Jun.Ma2@amd.com,
	victorchengchi.lu@amd.com,
	andrealmeid@igalia.com,
	hamza.mahfooz@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 23/61] drm/amdgpu: fix dereference after null check
Date: Wed, 31 Jul 2024 20:25:41 -0400
Message-ID: <20240801002803.3935985-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Jesse Zhang <jesse.zhang@amd.com>

[ Upstream commit b1f7810b05d1950350ac2e06992982974343e441 ]

check the pointer hive before use.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 98ed116b5a48e..1334e540bb67a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5390,7 +5390,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 * to put adev in the 1st position.
 	 */
 	INIT_LIST_HEAD(&device_list);
-	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1)) {
+	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1) && hive) {
 		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
 			list_add_tail(&tmp_adev->reset_list, &device_list);
 			if (gpu_reset_for_dev_remove && adev->shutdown)
-- 
2.43.0


