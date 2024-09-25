Return-Path: <stable+bounces-77279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6985985B63
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137B11C2154A
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF7E192D8F;
	Wed, 25 Sep 2024 11:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4jndXn5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB39A155742;
	Wed, 25 Sep 2024 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264924; cv=none; b=I5KBok+aqyhoNs70pkKxeO9RbTh2JPUx4TvFIOYXrA66I3j7dSdUD5ssf77bofFLRU1wJyPw11c4RKt7E2AQHwL7/rsd7nW0uHMyt5NCHW9tuYpyXUv78Qj/YsNXHrjN3U+4ptOg2+0tABM7nEFHGPiHTqbi/U/RFH1Ux9Q6OU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264924; c=relaxed/simple;
	bh=AFwXJOkgoMGCltayCnMYAJh12Xq5EMKdHXXNNaJxk8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljpnELzcy4cbMmG8G27usoJTrtVcIPVadWTvdWiKTv4I3vkb8bo4yhWKG6On8+wB35LcVM0BQ7hrwuOe7xqQGipYZKkxfrHt+UMFFNSK2JfY8klEH78RpAr8KrGYxaEr6wZZ1s3SZGmRucM/jeJFF88N/uQA+puAB0TPyIEujC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4jndXn5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F76C4CEC7;
	Wed, 25 Sep 2024 11:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264924;
	bh=AFwXJOkgoMGCltayCnMYAJh12Xq5EMKdHXXNNaJxk8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X4jndXn5jtJ0sskEmkQfiKHZMLlcLsaIiWFnmLBDLXXdFmsRvKvq18olm7NhNmUma
	 cNzbc3eeqbld0D+Tz0OFY/CgR8+M0u02f1a0fZ6CVadhEVXPMxCkEFz/R0OwQDj+R4
	 7f/kgcBRcMSYAj5/8HP2o7lqmn3ZKpuSkINq1XkAGjGQCOf4rMRpTaYutKMf1GkQ63
	 55WvAWsgUDRKaFoqBDwV3zo+d64CfZ3G0Yi9xCLs9GewD10OEWcBWs95bFLYjt+mdm
	 mrXRE3RtlsozsM8/Pct0+bxEePfWZeQ1hLYHD+8ylUnRUzezwjZ1ISvMAQxdVBxKM8
	 ZW83/QQz6akVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
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
	alvin.lee2@amd.com,
	wenjing.liu@amd.com,
	chaitanya.dhere@amd.com,
	dillon.varone@amd.com,
	joshua.aberback@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 181/244] drm/amd/display: Check phantom_stream before it is used
Date: Wed, 25 Sep 2024 07:26:42 -0400
Message-ID: <20240925113641.1297102-181-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 3718a619a8c0a53152e76bb6769b6c414e1e83f4 ]

dcn32_enable_phantom_stream can return null, so returned value
must be checked before used.

This fixes 1 NULL_RETURNS issue reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 6e2a08a9572b8..8bacff23c3563 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1720,6 +1720,9 @@ void dcn32_add_phantom_pipes(struct dc *dc, struct dc_state *context,
 	// be a valid candidate for SubVP (i.e. has a plane, stream, doesn't
 	// already have phantom pipe assigned, etc.) by previous checks.
 	phantom_stream = dcn32_enable_phantom_stream(dc, context, pipes, pipe_cnt, index);
+	if (!phantom_stream)
+		return;
+
 	dcn32_enable_phantom_plane(dc, context, phantom_stream, index);
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-- 
2.43.0


