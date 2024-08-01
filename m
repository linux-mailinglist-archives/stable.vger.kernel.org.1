Return-Path: <stable+bounces-65181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78504943F7A
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EEE11F2848B
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4511E611B;
	Thu,  1 Aug 2024 00:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0i2TaxI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061431E610C;
	Thu,  1 Aug 2024 00:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472785; cv=none; b=ONIXyG6rNt7B/sq6gRWSvu/Zjsi3jqTnQT9u5DyYURkNEIFKjSesAwBDA3KIcrTf8V43ukARnfccbF8NNwooWxR1x/5N5/xIKMvFDKMRmbUPXmtoyrNyfBal2c4zeEYBOtiJqG10ILQc31/Aw+VizAYY4eQg5tQ3xM0K8TCoYmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472785; c=relaxed/simple;
	bh=atNubreEBQf70aZTsf9AVjLY0EgPIK7HUliNHwQ7INY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8PXbBsZaTgvh3o3ItoMjWQ9Ijk4BextnJiZwhvCSdtcEVuDsfgzqMVR7ob0QlaFO8A58Uds6wKLjsdIhkD7e5VTo2JM1y0GYizty9vymD+UuqDvJkNeZCrZYvTnk6iDAPzuqKG6QzBSeGQh1ThUET+hrnc6wWA1Zq+80+xKg94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0i2TaxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2429BC4AF0F;
	Thu,  1 Aug 2024 00:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472784;
	bh=atNubreEBQf70aZTsf9AVjLY0EgPIK7HUliNHwQ7INY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T0i2TaxIs1dzn01FEqFPN9enf8OmZGfqpzxO2o2EsNECHStOUYwITxHh0nPHUsOkK
	 xuXKpY4KrBQstL7uU+h4Y+A+QNwC3z+HuEqurmz/Uj15SLqq/bMOW14t+0P6BHZTRS
	 S14VPoePJ7kdeqPSBuoxfqxyPt+wVXeSVrQ5vFckF3FLZxHCVEdyqzk2xXa4fsTR64
	 Bl6MkBmEvSuugoTA+azovEytVelH6Gq2Dma6lb1ayJiT1PbvOE1A5xMIFyFSVqkMlY
	 LYFZIr0yolm2bWWmzMo1ClHYMqNuXPQQZQyGqnLAdQRSQmQa4xg2kwd2r4j+fJCa3f
	 E5pV4zr4VcQtA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	srinivasan.shanmugam@amd.com,
	guchun.chen@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 06/22] drm/amdgpu: fix ucode out-of-bounds read warning
Date: Wed, 31 Jul 2024 20:38:35 -0400
Message-ID: <20240801003918.3939431-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003918.3939431-1-sashal@kernel.org>
References: <20240801003918.3939431-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
Content-Transfer-Encoding: 8bit

From: Tim Huang <Tim.Huang@amd.com>

[ Upstream commit 8944acd0f9db33e17f387fdc75d33bb473d7936f ]

Clear warning that read ucode[] may out-of-bounds.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
index 031b094607bdd..3ce4447052b9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -213,6 +213,9 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
 		struct amdgpu_firmware_info *ucode;
 
 		id = fw_type_convert(cgs_device, type);
+		if (id >= AMDGPU_UCODE_ID_MAXIMUM)
+			return -EINVAL;
+
 		ucode = &adev->firmware.ucode[id];
 		if (ucode->fw == NULL)
 			return -EINVAL;
-- 
2.43.0


