Return-Path: <stable+bounces-65200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32004943FA7
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11972810D3
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBA01A9CF3;
	Thu,  1 Aug 2024 00:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SECNhltC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BD71A9CEE;
	Thu,  1 Aug 2024 00:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472849; cv=none; b=mKMymAa39V2hMqn/8NxfM03Na4hHnE5Md8c8YNeUlIOrlkxk61focdidb8dXkaprMGLszTZn6NrOamg9tRm/fL7a3neKxGwXePlC95eXHZs5wtZzsb0R8QBjJAWO0drloVPNlDV6V3AyPuV3qHeBBxcxXTWcvjFrTyv8bJ/OGW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472849; c=relaxed/simple;
	bh=+zcVXVCnppyr6fPvDpDtko6lLdUHrBlBMKrvM3JSnOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BjP+rh2DkHmO0CZiJCtsnOL+Xe91Mra97QoMjCBEVL+K6etMKZ5yB0mAc6at4mdX7S+0DSrUPU5eBMkz4DBw2pApaZw1YS3E0/wnmPrCTXtuHj42VaWLMg3+UrdrQJEziWchrOpnMAAzLdLdkjBZReQV+rfBnJVhZIqa4h8gYM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SECNhltC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C603C32786;
	Thu,  1 Aug 2024 00:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472848;
	bh=+zcVXVCnppyr6fPvDpDtko6lLdUHrBlBMKrvM3JSnOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SECNhltCAmqBchASyUj5u6aucANcmw79o4qCL0hs4CzOjL95Lwmaei4GYEdLGbkQm
	 uM2hu6j//PxzhZBqPyiECtdYK/ThCCuNepTaJtAQNcG6VSO8h1/qIMlMgNnkvkjskb
	 LIR8o5oQgbbF9M+q3PekAHfRKnf6qJdZTdOSHqOlvhi3VfEms+pZrVFG5LuPME0aA3
	 RGm48+vL9icfO09IdH64AIJoALqtS5YPFb5df3qKgbxiKFcpRCR898Z27UoKMqLY5q
	 RMoZEwpox89zRiBfY36RuvQZfromYTVciVVGn8iWWBY5zhcvjH+uwHS3n7+w7p4yUH
	 fjgRmyT+aPBIA==
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
	lijo.lazar@amd.com,
	Hawking.Zhang@amd.com,
	electrodeyt@gmail.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 03/14] drm/amdgpu: fix mc_data out-of-bounds read warning
Date: Wed, 31 Jul 2024 20:40:11 -0400
Message-ID: <20240801004037.3939932-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801004037.3939932-1-sashal@kernel.org>
References: <20240801004037.3939932-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.319
Content-Transfer-Encoding: 8bit

From: Tim Huang <Tim.Huang@amd.com>

[ Upstream commit 51dfc0a4d609fe700750a62f41447f01b8c9ea50 ]

Clear warning that read mc_data[i-1] may out-of-bounds.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 95f7bb22402f0..fe01df99445dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1625,6 +1625,8 @@ int amdgpu_atombios_init_mc_reg_table(struct amdgpu_device *adev,
 										(u32)le32_to_cpu(*((u32 *)reg_data + j));
 									j++;
 								} else if ((reg_table->mc_reg_address[i].pre_reg_data & LOW_NIBBLE_MASK) == DATA_EQU_PREV) {
+									if (i == 0)
+										continue;
 									reg_table->mc_reg_table_entry[num_ranges].mc_data[i] =
 										reg_table->mc_reg_table_entry[num_ranges].mc_data[i - 1];
 								}
-- 
2.43.0


