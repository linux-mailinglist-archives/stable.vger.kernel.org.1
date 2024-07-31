Return-Path: <stable+bounces-64870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6594F943B4B
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24FD72835A3
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9270C143884;
	Thu,  1 Aug 2024 00:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkuS71ff"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE72143871;
	Thu,  1 Aug 2024 00:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471226; cv=none; b=mEOsyOxpc6dHWxuEO2ezb9Lu7sYA3pb4vclWfJVRab0V47xj7zmOD4F3P7jNaTvT3BeC27FkzOyK0kd6Ujvqkmgnsn4TYuArYN8+c6euUNC8hjEvvvt4evPO21lLB/d7OPVk68UBjCABb3h6CRvgFKHMRxAAkzIYzAzXCnmVYXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471226; c=relaxed/simple;
	bh=E11NoQtMWvw9g841WtLwQ9Dl6yQseE7DaZT9UW5opmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5JEwoXI0jvmE/eNV9/LZM7QxNqGaYodC0ips4P920K+j1zy/STRhdWWv5apyU9EouUjnJApgRWd8j9S5kzmxI1Vo28/rC/XIIcqsQlnRZcgOL0e+KUxF0Pv197yp/+yNo1G/USBSnvkOuDjqv6KaSLyEAbJXFzz7ozWIpJlpvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkuS71ff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3048C4AF0C;
	Thu,  1 Aug 2024 00:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471226;
	bh=E11NoQtMWvw9g841WtLwQ9Dl6yQseE7DaZT9UW5opmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RkuS71ffpIswoSEa0OCP9y3YQWw/8HuMtaBimce/QMWs6n2kxC7awKJiQTj9FFF6J
	 yd/GLKMcCdUhJJ2mfAnKstGCcQUMlxCBeUlWgzdcjrj3QWf72n0N+g/EZsCq0T52rg
	 g2NVgMruD6J1ITCzEnlIPKSqoSbPu6z5uUy4E1Zm+6E6rF5FUeHV0tIyj9mGxHjUTx
	 qVYjUdsJ3yIRdhMJ0E0uKjQ/RXKV87mAdJWru9YtoqQCTqbwcMLJbdP5MwaYfHvHmJ
	 NdAsopYlVEzjiXHcQ3po0Tqe1MrXoUctXepw8IGnBQ+5LXY7t4vGJXkP06nKMALEhC
	 aSVizFQksNthA==
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
Subject: [PATCH AUTOSEL 6.10 045/121] drm/amdgpu: fix dereference after null check
Date: Wed, 31 Jul 2024 19:59:43 -0400
Message-ID: <20240801000834.3930818-45-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index b151effc55dab..0829a264007c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5726,7 +5726,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 * to put adev in the 1st position.
 	 */
 	INIT_LIST_HEAD(&device_list);
-	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1)) {
+	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1) && hive) {
 		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
 			list_add_tail(&tmp_adev->reset_list, &device_list);
 			if (adev->shutdown)
-- 
2.43.0


