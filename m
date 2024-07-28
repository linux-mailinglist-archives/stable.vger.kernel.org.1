Return-Path: <stable+bounces-62163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0248693E651
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 17:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF2A281A46
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 15:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C1D80623;
	Sun, 28 Jul 2024 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYWTuo68"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4029378C63;
	Sun, 28 Jul 2024 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181467; cv=none; b=aZd8hHsLUmRHfoiav20t+p+bg70VGiSzxve9FzTfw44iiPC0SWoxaodAy2/DI2YnkSu52d9dnrmzhYWIUhlNWwL2sjLMycdwNZHBfnnc7xsobbmediq+pJy4DkQ4ZpsXSEx2UuXTLgeHkVhlQIuqgPalFc3AzqCKGYkbNIz5IIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181467; c=relaxed/simple;
	bh=HCiyyTk+fYVJuNT17/mU8KRklt1r7jud0B/vUVSoIzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5R9fRfsXy6Q9yEoTZBwM6GeAEC6g2pjqDnYRaY7FwkmlIfCw1Tvu3rBNuHQRif8Ru+WZXxhEyDAF8LvY9tCOmW6+UMBaZvlLr0myf2Zqp3VMniuIRva8/uu9KOJawafvpfpfaRek38mC/N/rU4k65uZBJO/HLF3Cy/WVQOZEkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYWTuo68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3333CC32782;
	Sun, 28 Jul 2024 15:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181466;
	bh=HCiyyTk+fYVJuNT17/mU8KRklt1r7jud0B/vUVSoIzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BYWTuo68AgMhdkoqKLti+ywrFTjNRXjZbLqA0J15dWhZegVcV7IqYOELpgWnlxKdd
	 PDBc7rkzVA74gtmYAtIzaDzzoN2U512HbzNF/dR+SA7bOojv+vXplhK/z91lPmt5b2
	 5MZeFHWkXn5wboUimsz5FeXn2hZc6wjt4PCw56IhKXPuvM4EZu4x4tj4xnYRvHwdVo
	 oum/vE+jqwRWW77QnbumDyU8bW5PgVA+LLEktyrViIsbK8x4LK1HpFGSPI+ePC7670
	 kWeyV9cDRVnCpC9C9YfJCngapyIKBn1qHKnYJLb9cjsBfjpTqw5R+RTCjJ+sWpla1r
	 aRxr1n9KYcT2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wayne Lin <wayne.lin@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
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
	alex.hung@amd.com,
	roman.li@amd.com,
	hersenxs.wu@amd.com,
	mario.limonciello@amd.com,
	agustin.gutierrez@amd.com,
	hamza.mahfooz@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 19/34] drm/amd/display: Don't refer to dc_sink in is_dsc_need_re_compute
Date: Sun, 28 Jul 2024 11:40:43 -0400
Message-ID: <20240728154230.2046786-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154230.2046786-1-sashal@kernel.org>
References: <20240728154230.2046786-1-sashal@kernel.org>
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

From: Wayne Lin <wayne.lin@amd.com>

[ Upstream commit fcf6a49d79923a234844b8efe830a61f3f0584e4 ]

[Why]
When unplug one of monitors connected after mst hub, encounter null pointer dereference.

It's due to dc_sink get released immediately in early_unregister() or detect_ctx(). When
commit new state which directly referring to info stored in dc_sink will cause null pointer
dereference.

[how]
Remove redundant checking condition. Relevant condition should already be covered by checking
if dsc_aux is null or not. Also reset dsc_aux to NULL when the connector is disconnected.

Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c  | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index a5e1a93ddaea2..025938409145a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -182,6 +182,8 @@ amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector)
 		dc_sink_release(dc_sink);
 		aconnector->dc_sink = NULL;
 		aconnector->edid = NULL;
+		aconnector->dsc_aux = NULL;
+		port->passthrough_aux = NULL;
 	}
 
 	aconnector->mst_status = MST_STATUS_DEFAULT;
@@ -494,6 +496,8 @@ dm_dp_mst_detect(struct drm_connector *connector,
 		dc_sink_release(aconnector->dc_sink);
 		aconnector->dc_sink = NULL;
 		aconnector->edid = NULL;
+		aconnector->dsc_aux = NULL;
+		port->passthrough_aux = NULL;
 
 		amdgpu_dm_set_mst_status(&aconnector->mst_status,
 			MST_REMOTE_EDID | MST_ALLOCATE_NEW_PAYLOAD | MST_CLEAR_ALLOCATED_PAYLOAD,
@@ -1233,14 +1237,6 @@ static bool is_dsc_need_re_compute(
 		if (!aconnector || !aconnector->dsc_aux)
 			continue;
 
-		/*
-		 *	check if cached virtual MST DSC caps are available and DSC is supported
-		 *	as per specifications in their Virtual DPCD registers.
-		*/
-		if (!(aconnector->dc_sink->dsc_caps.dsc_dec_caps.is_dsc_supported ||
-			aconnector->dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_PASSTHROUGH_SUPPORT))
-			continue;
-
 		stream_on_link[new_stream_on_link_num] = aconnector;
 		new_stream_on_link_num++;
 
-- 
2.43.0


