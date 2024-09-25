Return-Path: <stable+bounces-77655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 282EE985F8E
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 16:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57F921C25D93
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C04A16D33F;
	Wed, 25 Sep 2024 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgwH7SRK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D4422667A;
	Wed, 25 Sep 2024 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266598; cv=none; b=bp+aWpo2I7qSpGVx9D2mQ7qcgwwElfKvVq1AW+5KVuTZfXFw6hspOcfB3wX5Z6AkhFCQrtr7mP35HR9tbMyX6EMDPLkDEeDMP3JLssjy10AakkO1x1oC1//1vvOp1/JpcVkqggzwsX/zYXh+IK1r3Vjf0kpNeEfJqvLcQSBMw78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266598; c=relaxed/simple;
	bh=RAGSkXWuKFUFwcxyIZ3t1x8TvDIpRJx22tAg6NSoFUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fveYhjfgGNq/LDkVRv5agQnN+2Vv/ILWvV6zyedhYnzDtyo4UUBzuBb+d1Kz3JGxQJVje+Iwxx5C0JkhW+S2aNWkPDw8k4S0pGE/Sm2A6XLRfq8D/LVm8BcBW8BCH8i6UMSyiWVFYHk4GM1iG8WovG0tVtT7qm9+VyxrSvfWCcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgwH7SRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC0EC4CEC3;
	Wed, 25 Sep 2024 12:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266597;
	bh=RAGSkXWuKFUFwcxyIZ3t1x8TvDIpRJx22tAg6NSoFUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YgwH7SRKOGhSJQc2F+mnLGOsUN4dHv7zr6GJa5/O/Lbxp1uWOPrWPQwZim0bn/NuQ
	 OYx5e1/uqQhBRMhKUphpe48iINtWqzQbhyccgez+la0ngLeMD1aH835ehTXNf1iSTY
	 ayP+hOQVYCGXR4IfAVIb6XbtffZcYI+Lp00DjgdV3KXneMtRHXMYew69ZU4YFRXOEj
	 wSlCGHkhZbTCuVBuNEnwqZky3ccLGM8YR/JViwE4RjTTvcvOWRpGfTjUsADRbnyCef
	 IHiSovyDXkvy20C5BpdiA+c4BVyHObhoqqB9byfba3YW+ahEBZa6EDUZpooRxbgHve
	 bYnD7RS5j/Fcg==
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
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 108/139] drm/amd/display: Check link_res->hpo_dp_link_enc before using it
Date: Wed, 25 Sep 2024 08:08:48 -0400
Message-ID: <20240925121137.1307574-108-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 0beca868cde8742240cd0038141c30482d2b7eb8 ]

[WHAT & HOW]
Functions dp_enable_link_phy and dp_disable_link_phy can pass link_res
without initializing hpo_dp_link_enc and it is necessary to check for
null before dereferencing.

This fixes 2 FORWARD_NULL issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c    | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c
index e1257404357b1..d0148f10dfc0a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c
@@ -28,6 +28,8 @@
 #include "dccg.h"
 #include "clk_mgr.h"
 
+#define DC_LOGGER link->ctx->logger
+
 void set_hpo_dp_throttled_vcp_size(struct pipe_ctx *pipe_ctx,
 		struct fixed31_32 throttled_vcp_size)
 {
@@ -124,6 +126,11 @@ void disable_hpo_dp_link_output(struct dc_link *link,
 		const struct link_resource *link_res,
 		enum signal_type signal)
 {
+	if (!link_res->hpo_dp_link_enc) {
+		DC_LOG_ERROR("%s: invalid hpo_dp_link_enc\n", __func__);
+		return;
+	}
+
 		link_res->hpo_dp_link_enc->funcs->link_disable(link_res->hpo_dp_link_enc);
 		link_res->hpo_dp_link_enc->funcs->disable_link_phy(
 				link_res->hpo_dp_link_enc, signal);
-- 
2.43.0


