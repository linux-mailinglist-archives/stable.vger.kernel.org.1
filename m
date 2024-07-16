Return-Path: <stable+bounces-59431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E71932891
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B09282FA9
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395A919D881;
	Tue, 16 Jul 2024 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdWzXq5D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF99B19CD1B;
	Tue, 16 Jul 2024 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139981; cv=none; b=PAgQfyO/ZWVj+sdfgw+J8pQJqPBXtj8MW1l6enFyerBQni6HpzPC32+6/x6Ap8pXyScqOhSZMayapZFFmj+o4pc6JIZtPUS8xjoz0Q4eV4Vn4Q8wOQC8gNVUtcLmtIKPo/v2TP+4hw4mPJo57oyqjvV04LQurR+Xc69vp/EXpsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139981; c=relaxed/simple;
	bh=t7Wz9HROynNdxtMwYgCw79VXqZmMaUv6AhN+H0/OzYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXOAkaEfBbx7NBc2xkFUFdHAIQZRm0YWtxkE9Xgq0MIkv2t2nsrCLHKTC17sDREfGIUT0PNQT0yM+m7j2FOWHBKpzGJoGI8SiNZEKZhD4HkiF1vf9UK4bpPYDzczNeRROsDYIwaoo0SGBuZhqI+/fqzLVGBYK7/6K73JcPoiI9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdWzXq5D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033A5C4AF09;
	Tue, 16 Jul 2024 14:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721139980;
	bh=t7Wz9HROynNdxtMwYgCw79VXqZmMaUv6AhN+H0/OzYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fdWzXq5DYYn4IaQl+xeXM3qnsRI6Uj5dqXhO1Ic9s1gxIRpqTXnYGF9obDPQFARmN
	 7r3waqUxEJYIE05VM2YAwpSEPeeqCj5nF9fgPWwuKdSNREJV95/fPZ/RZyWySpaBPL
	 WWLJMdJK/+tbTFH2IuuFkMogiUcYtlcUxwzsbIlDBiPWQSdHkRbu9IhDGFNi4MOssG
	 IsV/EuypHCXkEUW6ODA0yw2dCYJpdMgLpbd+MpCbwodnNdndHbRGNESdZQFP2EgIy5
	 YLfjDFdqtJrlojWoP2NBnMahnrAfLOYSz5BZVMKMzZQLvQ8nicSC9FLvhwrmG1cxyq
	 uN7G81Ew1YD2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
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
	charlene.liu@amd.com,
	hamza.mahfooz@amd.com,
	nicholas.kazlauskas@amd.com,
	sungkim@amd.com,
	syed.hassan@amd.com,
	xi.liu@amd.com,
	Qingqing.Zhuo@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.9 15/22] drm/amd/display: Update efficiency bandwidth for dcn351
Date: Tue, 16 Jul 2024 10:24:22 -0400
Message-ID: <20240716142519.2712487-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142519.2712487-1-sashal@kernel.org>
References: <20240716142519.2712487-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.9
Content-Transfer-Encoding: 8bit

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

[ Upstream commit 7ae37db29a8bc4d3d116a409308dd98fc3a0b1b3 ]

Fix 4k240 underflow on dcn351

Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index a20f28a5d2e7b..3af759dca6ebf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -233,6 +233,7 @@ void dml2_init_socbb_params(struct dml2_context *dml2, const struct dc *in_dc, s
 		out->round_trip_ping_latency_dcfclk_cycles = 106;
 		out->smn_latency_us = 2;
 		out->dispclk_dppclk_vco_speed_mhz = 3600;
+		out->pct_ideal_dram_bw_after_urgent_pixel_only = 65.0;
 		break;
 
 	}
-- 
2.43.0


