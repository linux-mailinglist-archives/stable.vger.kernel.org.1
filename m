Return-Path: <stable+bounces-65068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E8D943E05
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC3B28620C
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871891D2F76;
	Thu,  1 Aug 2024 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiFg6IWB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431B81D2F73;
	Thu,  1 Aug 2024 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472234; cv=none; b=QlH78/cMMRHpGnwYlT3rZ6UhlYXhxtB+uweXVxGtFuoxE0d+pxwr8Rc47+AkCGXH7UiBMjd19sBUOo7hqDFVLGOEksMLpShwjcJaCI8FRcYVNuu+UNW9zMV8MtdpAQyw6PwmFFZJmauEJJbv88ZC+nd4paMEizTK2b798KCrC2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472234; c=relaxed/simple;
	bh=SQkQmydCD1MKuQ5o8AkQ1Z69JZ27Zuhdu2bvkrd+gqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TghCpJXSZVMejDiu8ocww4//ReuicYcCdlx5V9v211vnO8yAff821fIfVW+5rrBrkh2nvhFX9UcKxXXdNtgmYPOuTBAU5zBTqodZXfL0D3TZ/ln3GigAZOW2Ny2Kd11cEJfkzhpaOB41JUTOn6a7PN0sLk5SGcItBCs/GfcCnYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiFg6IWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27C2C32786;
	Thu,  1 Aug 2024 00:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472234;
	bh=SQkQmydCD1MKuQ5o8AkQ1Z69JZ27Zuhdu2bvkrd+gqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fiFg6IWBowEredYkFK2dZb/iKmO7TaI0VHd5NlcIARu0qIHctYbRYSWyuiaZQncgS
	 QwGPcAhuD1eOHBVKZOJhMp7t0qJxo7lwxHVib498Y+IMoItQZ7CWbBR4JUmG6Lf7lw
	 9ZUPjukd2sMpf1cGQMvik537STlLxnmmqECAcm7FgoMUD4skK5hOZkZTUyZwoqS/+/
	 TFwvL5RJTclzFXf6oVosTL7zG2XUec0MMBr3vw3qudDqn7wIzB0HkhivEkExgX+P0p
	 oLBiGWWpSc1MFyb7HJVCP1MyetdffxktdnAF3ekSHwmMF2v0bdWNhAPUHtJiA8bz7d
	 CEY26JeoMMhcQ==
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
	jun.lei@amd.com,
	alex.hung@amd.com,
	hamza.mahfooz@amd.com,
	george.shen@amd.com,
	dillon.varone@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 39/61] drm/amd/display: added NULL check at start of dc_validate_stream
Date: Wed, 31 Jul 2024 20:25:57 -0400
Message-ID: <20240801002803.3935985-39-sashal@kernel.org>
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
index 83898e46bcadf..29400db42bb2d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3629,6 +3629,9 @@ void resource_build_bit_depth_reduction_params(struct dc_stream_state *stream,
 
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


