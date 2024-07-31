Return-Path: <stable+bounces-64833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A551943A8E
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246AF1F2271F
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA8814B96D;
	Thu,  1 Aug 2024 00:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJWMJZgQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEC9136E27;
	Thu,  1 Aug 2024 00:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470954; cv=none; b=SPQy+9jlI2NIUjwhG/SN2fRQM67aReut+SeOyCEI1vNjGrpTuqNVCSsqa/2HiqdAj5VRkoupSdMnEpEYstYQaBMoHLlQkbdTDMCuwJblwI4P+YWnkR0MgJ1IcIOtgGNl86h2SH1o/nmiY2x9sPE2T6sT9zO5W2yv4+RFQklXjgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470954; c=relaxed/simple;
	bh=XwiusGyHFFWVp25IovLAQaq2emO6knPkUhXJV+qlmy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBJzVjO94gteeaiTEsEm3oLbTVg2BvQ1sR1hQAVIyZYuwti+jkZ1UUkTMgu81wFMF8R3v/MqBtO26jm5KRIxtg+AjlM/bTppgsZsz8lxeJrLJxMLxI0yDfXhdrmfeVGNE/XR+tFS2kPNKHHKum/4HXe24UBkdIsZhzZ/Tmi1qRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJWMJZgQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F645C116B1;
	Thu,  1 Aug 2024 00:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470953;
	bh=XwiusGyHFFWVp25IovLAQaq2emO6knPkUhXJV+qlmy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IJWMJZgQhSQbrOcjFmgdjGDqvBGxxedoHyOLrDW5y+5qSEOtdIuju1fT7N8j8OpzH
	 baLWFe7rAgodUVQzqzJXRbeDBPj5SFktQjvCuIl2784EQG27JbLYuNApGjcES1WmAy
	 4xgBdldHIp/laaO22VbfeAOMFulAU0ZBafCbH6H7hgEelL55mDNz1N2NizXHG6TMzO
	 rP9zNpyNNTXMDNbZzQkJLb+LyjqN8YSyrmSGCHTlAB1j+jgB4ZP+8IyaYAOalsZIS2
	 bfFRcymo3n8eTLcpPZRZ/jXDf//OSuL4Wr+Zj3kJbiJJrfIHdWasGacsrio1wqolMY
	 mscCgKvff5nLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tim Huang <Tim.Huang@amd.com>,
	Yang Wang <kevinyang.wang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	lijo.lazar@amd.com,
	Zhigang.Luo@amd.com,
	Hawking.Zhang@amd.com,
	victorchengchi.lu@amd.com,
	victor.skvortsov@amd.com,
	Yunxiang.Li@amd.com,
	Vignesh.Chander@amd.com,
	surbhi.kakarya@amd.com,
	danijel.slivka@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 008/121] drm/amdgpu: fix uninitialized scalar variable warning
Date: Wed, 31 Jul 2024 19:59:06 -0400
Message-ID: <20240801000834.3930818-8-sashal@kernel.org>
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

From: Tim Huang <Tim.Huang@amd.com>

[ Upstream commit 0fa4c25db8b791f79bc0d5a0cd58aff9ad85186b ]

Clear warning that field bp is uninitialized when
calling amdgpu_virt_ras_add_bps.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 54ab51a4ada77..b5fc0e1ad4357 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -395,6 +395,8 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
 	else
 		vram_usage_va = adev->mman.drv_vram_usage_va;
 
+	memset(&bp, 0, sizeof(bp));
+
 	if (bp_block_size) {
 		bp_cnt = bp_block_size / sizeof(uint64_t);
 		for (bp_idx = 0; bp_idx < bp_cnt; bp_idx++) {
-- 
2.43.0


