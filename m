Return-Path: <stable+bounces-65053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A99C943DE0
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA061F22567
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930B28814;
	Thu,  1 Aug 2024 00:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agSbEuXu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E50913B5A5;
	Thu,  1 Aug 2024 00:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472194; cv=none; b=H3gT96pwXgVGc2YONnLMh1WCvD2EVdhEjxBOYd6lU6kGgKXujhcFbMpveUYf+94eXxHCYn2jMZB+h6asxPYv3bSrMwr4ruVCZyEDQO/qGMX7BSv5UhBIhZlmrH5oYHlfnT23pd8ULVNuZ+SYVtBG+ZVET5QEk+CS6sksXtkvbBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472194; c=relaxed/simple;
	bh=HfwLPxSnQMQpUNvWflGQhEO5wetyHsAshCLDwjhOdCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SwcViXG0XQ9q9MvywoGKSumk9i+4cjOJr/uTEyB3w9QaDiJ4COrM1TcZTup7yJ8QaSm9WIyWTiFPn3Fe82kXWLuKWoxqbnCtLh2WsF5JHOjtwT6CY3zNwZqnaTKzlouASYuRvbwRCWUrktp0Qr80FpV1t91PzDYuNcKe013VLcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agSbEuXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EC2C116B1;
	Thu,  1 Aug 2024 00:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472194;
	bh=HfwLPxSnQMQpUNvWflGQhEO5wetyHsAshCLDwjhOdCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=agSbEuXux+YnHDAEMm+pSwRR6CaONhdrTNdFHsTN+FY17GRYNy1tcz34PLVThftep
	 aqGW7eTnBLHPTLcqrTcr31DwPheWpPh+G7Ttd7a14T1JiO/rvurWnCEAEUcs01c9ZS
	 FUyXiFHDxWns9D3nfSVbYCXM/FHB+CNLN7e1Xr1k0bhwj2EmGoNHE+qneBrQCshW5N
	 HLorRa+J6DTIXQkrbtqdP5id5Fy3/3qz+9uf6fSmmZB0ZC1oqnYhtLQ7IGrQSmq5He
	 pBCsVQu+pBQ1FGEOnnirtXz2Y5mg0dN7yN8ekq2xPOYXZb9xANSvpFKg2v4goiNpA+
	 VU9tjx5KPFgDw==
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
	le.ma@amd.com,
	Likun.Gao@amd.com,
	shiwu.zhang@amd.com,
	YiPeng.Chai@amd.com,
	kevinyang.wang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 24/61] drm/amdgpu: fix the waring dereferencing hive
Date: Wed, 31 Jul 2024 20:25:42 -0400
Message-ID: <20240801002803.3935985-24-sashal@kernel.org>
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

[ Upstream commit 1940708ccf5aff76de4e0b399f99267c93a89193 ]

Check the amdgpu_hive_info *hive that maybe is NULL.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 8764ff7ed97e0..f8740ad08af41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1297,6 +1297,9 @@ static void psp_xgmi_reflect_topology_info(struct psp_context *psp,
 	uint8_t dst_num_links = node_info.num_links;
 
 	hive = amdgpu_get_xgmi_hive(psp->adev);
+	if (WARN_ON(!hive))
+		return;
+
 	list_for_each_entry(mirror_adev, &hive->device_list, gmc.xgmi.head) {
 		struct psp_xgmi_topology_info *mirror_top_info;
 		int j;
-- 
2.43.0


