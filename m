Return-Path: <stable+bounces-170332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED16B2A384
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91EB95E2D42
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1819C3218D6;
	Mon, 18 Aug 2025 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UYcIjxLs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4FA2E22A6;
	Mon, 18 Aug 2025 13:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522293; cv=none; b=esgrofwZ1hgLGSy563ABlT5cd/HGG7sPb+AnVEnE+jN0IBblyJI87pPVBZ6uBtmR3mtq3vSVGGIrTj44ny9PPMULiwFoTqojPF1z+alBMWjDaavd/n3EvBAhRuL4DkiFsaHMJ9n4ZioihQumbrJ93tOgpWxNqKR0TRfKViTblJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522293; c=relaxed/simple;
	bh=p/Wz3eu5iEa5qVVQryxY1Y8niEZx9GPIx3bOylPrBNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZrV7ungW2aYlnuj0+Ix1wdjcoTuV/lc4MuMuByKhNR0XoU1lR50t/VD3sRGos6e2pGtjllLnP03TpPMfyxladKsvjLHocHObn+xK1z5+X9xudbTUewqFxfIsxGChSmz6Hibbb8QGznWBQVJ9chaoGNVqcn1l92p0x+g1XLfEF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UYcIjxLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D6FC113D0;
	Mon, 18 Aug 2025 13:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755522293;
	bh=p/Wz3eu5iEa5qVVQryxY1Y8niEZx9GPIx3bOylPrBNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UYcIjxLs/6Gundy809E7kAsv40RCP4JV+IZgrT62b5zS7PmM9FOLKXawpswL4Q4Wa
	 EwmTHanilByM9Q98Wn4qlwqssQZkJlBdYn+9bxotR150kTbdCnv/CeUQeba+Ofx8Kn
	 BfPyviOXYYHMgy2MqS0Ui3foyZBYXlXFnTBAwkoc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Harry Wentland <harry.wentland@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Ivan Lipski <ivan.lipski@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 273/444] drm/amd/display: Only finalize atomic_obj if it was initialized
Date: Mon, 18 Aug 2025 14:44:59 +0200
Message-ID: <20250818124459.210240299@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
References: <20250818124448.879659024@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit b174084b3fe15ad1acc69530e673c1535d2e4f85 ]

[Why]
If amdgpu_dm failed to initalize before amdgpu_dm_initialize_drm_device()
completed then freeing atomic_obj will lead to list corruption.

[How]
Check if atomic_obj state is initialized before trying to free.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 084d9ed325af..33a3e5e28fbc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5223,7 +5223,8 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
 static void amdgpu_dm_destroy_drm_device(struct amdgpu_display_manager *dm)
 {
-	drm_atomic_private_obj_fini(&dm->atomic_obj);
+	if (dm->atomic_obj.state)
+		drm_atomic_private_obj_fini(&dm->atomic_obj);
 }
 
 /******************************************************************************
-- 
2.39.5




