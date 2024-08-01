Return-Path: <stable+bounces-64978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEE2943D2E
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C35F1C2135E
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EAE1C2D8C;
	Thu,  1 Aug 2024 00:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwAK49si"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AA91C2D89;
	Thu,  1 Aug 2024 00:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471830; cv=none; b=A9W8NnpjwgR3NGGU3FWbUq21XX3C8+eL2JD8LFL+yU1djqE/IJ61Cj2chN7cNiVsM/875BFQf0FDs0sQiBQKctYcPqKhzEF+23/DZejTiLp4J3lXTVaxly0ROC0Z6S41GyN52YO7Fk018JsF53cMhvUjOz/XsnOspIDrJWIrbRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471830; c=relaxed/simple;
	bh=ufgo8Cg+bR5g5yVNC4jst1HFJiRNbn1MW/fSPxbEjK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VipI4HEZgNTNWnvabusT+Uq6GOX1vyRr3BZi4Nabix4OEh8iLkF3k4OuJh7jWyY0gk43Ok0JLMWw7IEneTALNAlNIEzpQ9htdQgX5icFyGP3DxbrlFbasTaYS598l9kLQ0Y0TXvyxmyhS5XfoGc6IOoOSokFlHSpkEV2hE9RMQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwAK49si; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDEDC4AF0C;
	Thu,  1 Aug 2024 00:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471829;
	bh=ufgo8Cg+bR5g5yVNC4jst1HFJiRNbn1MW/fSPxbEjK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BwAK49sim6a9gyud3w/4n1JQzLeVzLHWEHJPxpTSifqiwkm8anWkNp/p4RLQRnbvZ
	 ZOH9iI1vL8s1GEc23aYmuOTYWJJbTioegHPd4uT0zs+ufptUF19uxwLhs5I7MBxhC5
	 E7t08CpUzJFpwOLADjuZbCbheXAkk3zcD3KrTQyC6y3yCIphrMhiC38xnBpvHRfs+5
	 zpOEhfi+KI1sj/cXu41R7L6rzGlZ4DYV7UNtEpIYrg6chjrS/t4lFE1CRCR7zNuuZN
	 sBcp5bQ0hQ0XfpIAqQW8RwyD6d63mQInOgtgDaPN3e7d+UQlIIfY++syRy1kW7oh6t
	 zapsaQGX+eMxw==
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
Subject: [PATCH AUTOSEL 6.6 32/83] drm/amdgpu: fix dereference after null check
Date: Wed, 31 Jul 2024 20:17:47 -0400
Message-ID: <20240801002107.3934037-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index 8c95b877155a3..b1ad0ef484655 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5235,7 +5235,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
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


