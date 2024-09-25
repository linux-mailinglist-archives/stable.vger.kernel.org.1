Return-Path: <stable+bounces-77495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F089985DCA
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A70528656B
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1823318C911;
	Wed, 25 Sep 2024 12:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+aRThUN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9F6204912;
	Wed, 25 Sep 2024 12:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266023; cv=none; b=Vo554BvlJUKsTsSpZbDSjhA9lSQKlqkRazF4QLN7FwO5aG+qNJug3R/7ulqnEyUfVCytwMEiKGh7vecNwkmylKnSz7Tv9tnskQewdd2XSwXJtF+J7vSNYS4P3ZnezUwqR5uHqx9d0flbL5icIrozM6tdxcBCed8ZvMYs0EbDhII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266023; c=relaxed/simple;
	bh=GLBkVFJMocNWbJmnLGDZmufdouoDvRRi2bm8n9wa8fA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWB9rPtyM20jQzj9rjx+BCY4MIi3M20dcfLP8QNG9oH18sCKfbah3IcfGW3JUqWh/qUJu6yXhLOt2/m1Pp/kQazI9xV6EnJu2I7mTibTUNqmSvSNto4xTm9YvpuF6sawIINx1CTFRyeGszRo0OlRbvgmsUdmeDN1gd2PxBbyqa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+aRThUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B0DC4CEC3;
	Wed, 25 Sep 2024 12:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266023;
	bh=GLBkVFJMocNWbJmnLGDZmufdouoDvRRi2bm8n9wa8fA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X+aRThUNcUnSqh2/nWMZaGmCC7Dv3iGeIB47/z75HNSqI5+K9y+RSWoSJXrMZKFeF
	 /5jh0cUa4CN/ip8zPoDCirkxs9zCPPySZMnCAyDCORxQ0OKmvTEI9KWEosrymK2UrB
	 FkTMaEMo03iGRpwYwC4thX3CQOkmcd2s9RGeHN/EKAP+IjNDKsK51elz67+e4S6SRA
	 CkhjxksXriIuecyf0pe1wKf67wSf6vXzkSW20zMnboIgRwB9dzx0kD4/Np9mVqG6bA
	 DdNyyPlT/X5RlGOPIXxSx52YP7PVxNJgvUgE/EjlfcHvnT0X4irlMBYWgHRLueZQFO
	 A/C2aS3P50jQg==
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
	dillon.varone@amd.com,
	moadhuri@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 150/197] drm/amd/display: Check phantom_stream before it is used
Date: Wed, 25 Sep 2024 07:52:49 -0400
Message-ID: <20240925115823.1303019-150-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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
index 9209bcad699a8..55fbe86383c04 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1714,6 +1714,9 @@ void dcn32_add_phantom_pipes(struct dc *dc, struct dc_state *context,
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


