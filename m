Return-Path: <stable+bounces-64827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD88943A5C
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183B1282A93
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B166A33C;
	Thu,  1 Aug 2024 00:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8BSwUKb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38D2143C4E;
	Thu,  1 Aug 2024 00:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470926; cv=none; b=ds+UI1+bQMDMY+qePWtvPcgCpHuwoQDo2GkIUX5nb0CgpB4l6/H4CZYSIrmB6CpYwEIglhRHlYAhwf/1D0P5tUAL09Rjs72BZlt2W7VsXXQWSOGQfTXv7D6jZBITPIxjkkVrevwFMpmU3+fbiT0foCR4vQCTQQbUC4SfmXKOR2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470926; c=relaxed/simple;
	bh=BnGl+S9DPQCf1fZ+mW44vIcrSAsnmWOpuVFMqSXfzqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idhQXpJ8fAmqcNNWMTL0fg/l/UwQadlq05i6VsNqHr5c3T87nIFHLLyHRjfdxhOXgq5M7n77FTVKlpSbxCcTXAQdO2Qu0JVaId5R1Pvzl2O5mydtaabsTRX+Z7dc345Ak0K4LPDXGmgLwscyHIfD2UeISx0+33TSYgwCiyl65yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8BSwUKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0F6C116B1;
	Thu,  1 Aug 2024 00:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470925;
	bh=BnGl+S9DPQCf1fZ+mW44vIcrSAsnmWOpuVFMqSXfzqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U8BSwUKbj22N5EtYrQXhOnTwSLs1St2oC17Hc1M+i0Jc+oW9B84ZSRTYAus87q8lc
	 JJDVhbbqp63/U06uPlZsctFeTM8CIomnZ+nU9oOF9WgvoldWb+sdmouYCOBmxAwOPP
	 rtrXW76xckqi1JKvh9McNRrhuGjfddx64uHHtS/aiPv4I3lv56i/U669g+rwfE7Mly
	 bO35sPj+xsyF4AdCJBNSbzUkeVGZGflWCGsF1n0CrP3oMl4A6yfx9JsR3046if9DaO
	 OG4vjGfWrk5g1cknPmAlbZqTgAgb8hmkPQUegHfQ+gBzXaxUBtLl+NkGIVpi8LYTC7
	 he23CQroMprcg==
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
Subject: [PATCH AUTOSEL 6.10 002/121] drm/amd/display: Assign linear_pitch_alignment even for VM
Date: Wed, 31 Jul 2024 19:59:00 -0400
Message-ID: <20240801000834.3930818-2-sashal@kernel.org>
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
index 236876d95185b..da237f718dbdd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1421,6 +1421,7 @@ struct dc *dc_create(const struct dc_init_data *init_params)
 		return NULL;
 
 	if (init_params->dce_environment == DCE_ENV_VIRTUAL_HW) {
+		dc->caps.linear_pitch_alignment = 64;
 		if (!dc_construct_ctx(dc, init_params))
 			goto destruct_dc;
 	} else {
-- 
2.43.0


