Return-Path: <stable+bounces-65030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC836943DB4
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99EFA285AC7
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D13E22083;
	Thu,  1 Aug 2024 00:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHz4FHIh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E441CDFBB;
	Thu,  1 Aug 2024 00:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472087; cv=none; b=kc0psNrZO4mSeg8K6ZFBUvXyRwbIYhWX2XYsa4H7PnIzvgkvj+f8uzax1wz+lDUhZMRZxjs3yD4PnUz8KBqa9BhAbbCKp5ud30t/kK+m5eOl0xMInrCMA+/tYBXcUGKNJlBc3yo4XIRIjPMP1t7INaMCBw6qqrNCjZ672cvNdTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472087; c=relaxed/simple;
	bh=pUBR1QWDT08E5K3mB/u9woZWpO0aCccMX7kMoA80YaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y2MT3tAiKsH0M61HJqLLE5sBHn1nD8oNZ+54NumxuYTRAUa1kyYe7wXRviiUwVnSF0yMLeq8t8EW/N/aus2fXJaRZWQK7Vu0H2k/siGnCwhQsnTbkm3alp27bOXxBOGWgUT6UAQHQ2wWpTe+Xel9qRlgOvoxaPWVClsEKYL+sRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHz4FHIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF48CC116B1;
	Thu,  1 Aug 2024 00:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472087;
	bh=pUBR1QWDT08E5K3mB/u9woZWpO0aCccMX7kMoA80YaM=;
	h=From:To:Cc:Subject:Date:From;
	b=iHz4FHIhHgEHkc+n0vZJ67K8yfaYzP2LF8wdURnfoim41qNrkzHVBGBPUxzATjQEE
	 AZBLO552R4hXYv1ig6pyxpLs6uS7FK1fVvc01vzh11NkJuVt8V03fuYe3Bhp/2swMo
	 3Xx98gb+irlu3S1//DT/k/71Y2Q/CjYC1iM+zAta3hOlYvrL6iE2XL/dELe53ZaZxz
	 J+RW99zNXZpyJt7xqPQ3atl8F3nxwL5zl6eVnJFQf6kuuCPkfXsE+BaXQsHQ8lQwcW
	 WNPIGQXA5dVFdiT2upgFQNzdb7Hy39SuiKbdSxh2DuGUVnHtcUY/cDA+crTYa876SH
	 yVIiCBInSU18g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alvin Lee <alvin.lee2@amd.com>,
	Sohaib Nadeem <sohaib.nadeem@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	wenjing.liu@amd.com,
	alex.hung@amd.com,
	aurabindo.pillai@amd.com,
	dillon.varone@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 01/61] drm/amd/display: Assign linear_pitch_alignment even for VM
Date: Wed, 31 Jul 2024 20:25:19 -0400
Message-ID: <20240801002803.3935985-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
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

From: Alvin Lee <alvin.lee2@amd.com>

[ Upstream commit 984debc133efa05e62f5aa1a7a1dd8ca0ef041f4 ]

[Description]
Assign linear_pitch_alignment so we don't cause a divide by 0
error in VM environments

Reviewed-by: Sohaib Nadeem <sohaib.nadeem@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f415733f1a979..d7bca680805d3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1265,6 +1265,7 @@ struct dc *dc_create(const struct dc_init_data *init_params)
 		return NULL;
 
 	if (init_params->dce_environment == DCE_ENV_VIRTUAL_HW) {
+		dc->caps.linear_pitch_alignment = 64;
 		if (!dc_construct_ctx(dc, init_params))
 			goto destruct_dc;
 	} else {
-- 
2.43.0


