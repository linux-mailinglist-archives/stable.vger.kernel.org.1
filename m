Return-Path: <stable+bounces-65161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8FF943F4D
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD321C2130B
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1AA1E2F29;
	Thu,  1 Aug 2024 00:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKq+Rf8K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0191E2F25;
	Thu,  1 Aug 2024 00:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472698; cv=none; b=Tfv7ze+VlEs8pbffzDbeQ2qcRoTz5W9eHqoVMzZICzZDfhrZQ9LLzi9/Uj1b17HKkg09vo5/vfDDQBRHAuIBq/Vl9PdGrKhvwG1ipcL9RoERN2OZxFLnNlUWzJ3aZ0OtIAM6NjojVA6pjPezoDHwp9Fq6mGeic+SgPBagD02UAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472698; c=relaxed/simple;
	bh=iPtXXTOTTCYO9TZk2WP4rJQlnMKoQ1qRcUuwJj8voEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abhCeQiXZgUVtI90NysIafRukXkE0ZX/tB5HTRabkyeYSgaGrO/8rnaNQT1ci95uiOucoUCFdrv4IEqbfddYHOja3UZ2U2uKP7UCSN0TAPIDSswJOV2dm7PGTg0T6RvfF1+iDY8bfKeNEd1ogUQBWHWVHsWgqVQLml35vGDkvio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKq+Rf8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054E8C116B1;
	Thu,  1 Aug 2024 00:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472698;
	bh=iPtXXTOTTCYO9TZk2WP4rJQlnMKoQ1qRcUuwJj8voEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nKq+Rf8KUuPnzFW/EWyzmSbDQSqLlpYY9cVN5e6wcXNZ75cw/c5qNajQM0lqLBhYr
	 tQc2sFgMh7ekjLHOpL69Erkj3OofznA5mrzlSgWxZBkgtBYILCFSc08OkAjILweusK
	 dyZvZxpyVJaIfChSDeQ4g6Y3Y5CXumW7XU9VN4cEJ9HrXDwrJACoXyvaqs6oaWdPOX
	 WCWCxS+RWqPR1qQcLKQX2Bztgs5/oBKp+vEPTrwEkMNn+152nEX7pYFmpg+ztgOUm0
	 jS3Fb008Qfbar/xhnHtniS3Y6AdCvlUid8hz2ROYkFLeN47otam9yIFBQhElG5L3ol
	 Jnv37VHHl9aYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: winstang <winstang@amd.com>,
	Alvin Lee <alvin.lee2@amd.com>,
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
	wenjing.liu@amd.com,
	alex.hung@amd.com,
	jun.lei@amd.com,
	hamza.mahfooz@amd.com,
	george.shen@amd.com,
	dillon.varone@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 24/38] drm/amd/display: added NULL check at start of dc_validate_stream
Date: Wed, 31 Jul 2024 20:35:30 -0400
Message-ID: <20240801003643.3938534-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003643.3938534-1-sashal@kernel.org>
References: <20240801003643.3938534-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
Content-Transfer-Encoding: 8bit

From: winstang <winstang@amd.com>

[ Upstream commit 26c56049cc4f1705b498df013949427692a4b0d5 ]

[Why]
prevent invalid memory access

[How]
check if dc and stream are NULL

Co-authored-by: winstang <winstang@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: winstang <winstang@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 0a13c06eea447..6a993cdb101ee 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2914,6 +2914,9 @@ void resource_build_bit_depth_reduction_params(struct dc_stream_state *stream,
 
 enum dc_status dc_validate_stream(struct dc *dc, struct dc_stream_state *stream)
 {
+	if (dc == NULL || stream == NULL)
+		return DC_ERROR_UNEXPECTED;
+
 	struct dc_link *link = stream->link;
 	struct timing_generator *tg = dc->res_pool->timing_generators[0];
 	enum dc_status res = DC_OK;
-- 
2.43.0


