Return-Path: <stable+bounces-65121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C02943EDB
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AB0E1F229E3
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A32B1DBB9E;
	Thu,  1 Aug 2024 00:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYD6qsuY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562EE1DBB98;
	Thu,  1 Aug 2024 00:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472501; cv=none; b=XpXRpnkN29bG3PEWJGJWTvZ+VEp3F0XKPIgiepgDTs9IZxIiKo5tWgNlYJs98Efix5o9bM/IuEKi2pjFppHRe3gvIJ6eRbhyaz3OF9O+S70v5xKtyRHn+C7o9QHxNY3069HzT89dIcAYQcY/78xVEqL42qEl+iAvohCPN4IhDgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472501; c=relaxed/simple;
	bh=8VrR6MmszBITQ5bU0YppPlCDQg0kTTWA5rw31hIURQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYhhxR7MkSIn8L9HQXuo92escxM2H+9C3NFw+5d14oWwiYKMQxXGrOSAL1QZfaF1H0ro7si7FdYpaJ5QfRa2W+A/hw1WPnU2EubqylwvZGY0F6OCg/YRK60DcVLQrBKHtga1xq6/GQ10qtYennqBOrRIztXfYvoJcIOJ37EV4zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYD6qsuY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0FDC116B1;
	Thu,  1 Aug 2024 00:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472501;
	bh=8VrR6MmszBITQ5bU0YppPlCDQg0kTTWA5rw31hIURQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WYD6qsuYEhL6pcJc4GjWyOmTCNEgcSlPSQRDIKGHgOOIjbZkmJGSuqk+fhOTe+1XS
	 3EAHNNot71/vE7gjepgG2NcwMWyvZo5N2YuALzbiMj1PEQPKxZohj9oTvMQI3Kwh6H
	 YX0jS1MXlTuajfoS7rNc0a2iBE/ji7QpihKKeFBKCfwUJG1it83q1wmyCdGzoulZPw
	 4Kkc4nd31oL+VnYEI3qKv60iD58ZXo/9X9T/4f/EWsM/yHl3CDY7WzW7k7/Xg0TFF7
	 aJVp9T6t+r1ZrDnd3Dm2qQ0QPkGjD93g4r2R+8aSfvL6jc3bPczPPMOSfKf3LYKACk
	 a5tJDfsJmBhFQ==
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
Subject: [PATCH AUTOSEL 5.15 31/47] drm/amd/display: added NULL check at start of dc_validate_stream
Date: Wed, 31 Jul 2024 20:31:21 -0400
Message-ID: <20240801003256.3937416-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index 42432af34db29..df84f3b521e22 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2872,6 +2872,9 @@ void resource_build_bit_depth_reduction_params(struct dc_stream_state *stream,
 
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


