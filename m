Return-Path: <stable+bounces-62158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5860D93E63C
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 17:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B575BB20FF4
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 15:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47855745CB;
	Sun, 28 Jul 2024 15:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHWLKxio"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F7174E09;
	Sun, 28 Jul 2024 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181433; cv=none; b=EtH9eH7jwRcT4YQfMp1XZdZMb+GT56oSsjPZq8mxFQRa9m9nqRXRYqLbezizSbycydp3fvC3wpUIH//o3YEfRUiimW/0LNX81EiJn5AN6tGAzSJl0y37wpM3TFqEcdBGzJrD98dPIO2BAumgKdb4weovDKVnC+30vnS/Z6sQWBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181433; c=relaxed/simple;
	bh=4VFj1C+cmOKvrfeeMQBQMf8ONB392pwCRvakOWRT6mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAHFV4TNBz454KYrYhKXh+eFOJ9Z0Bb8t6sfHe1CRhLIyCrU/qsTrHLd51bV0A+Es6De6pt6+kQsRbyN8jdOh36VkwKCFN2NhCuRmtiFGfPNg0yL+pHTRpnIqZGQtIsB4+9KJ7bt3C7xVJfpeo5BeJOZWZTMs6ra3dBTOnLvAkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHWLKxio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90A2C32782;
	Sun, 28 Jul 2024 15:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181432;
	bh=4VFj1C+cmOKvrfeeMQBQMf8ONB392pwCRvakOWRT6mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CHWLKxiov2VxaGqfBMSbsvXfQiblHJXgbftygYA55kH0AM8vx/rngjC3flHmq39HV
	 PjDoXqtVhRGIh3Xohr+C4yhvBnPvFyuFm090hiaC8nU9HpohDfQJvlgB4/TglzNOoy
	 1qHOp5dWu3A5+sWyy2lrzuGvqHGwb6jq2wKN4yOOX3PGhiyhSr7xVIp47CieXbAwLm
	 uYfdjL1UI02tb6RYyxIrFBnWjgL3cPy3NoJakVmwmVKFi39cYp2JhCMA11d2Ju6HV0
	 j0I/loTXfwdiUwZocHiGbb46dRI6ts++Dm2+swYP4TUUEn+wDfoDIDKh9oh6S/oMY+
	 YBTW5QMlZOP2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Roman Li <roman.li@amd.com>,
	Hersen Wu <hersenxs.wu@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	wayne.lin@amd.com,
	mwen@igalia.com,
	alvin.lee2@amd.com,
	dillon.varone@amd.com,
	hanghong.ma@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 14/34] drm/amd/display: Add null checks for 'stream' and 'plane' before dereferencing
Date: Sun, 28 Jul 2024 11:40:38 -0400
Message-ID: <20240728154230.2046786-14-sashal@kernel.org>
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

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 15c2990e0f0108b9c3752d7072a97d45d4283aea ]

This commit adds null checks for the 'stream' and 'plane' variables in
the dcn30_apply_idle_power_optimizations function. These variables were
previously assumed to be null at line 922, but they were used later in
the code without checking if they were null. This could potentially lead
to a null pointer dereference, which would cause a crash.

The null checks ensure that 'stream' and 'plane' are not null before
they are used, preventing potential crashes.

Fixes the below static smatch checker:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn30/dcn30_hwseq.c:938 dcn30_apply_idle_power_optimizations() error: we previously assumed 'stream' could be null (see line 922)
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn30/dcn30_hwseq.c:940 dcn30_apply_idle_power_optimizations() error: we previously assumed 'plane' could be null (see line 922)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index ed9141a67db37..5b09d95cc5b8f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -919,6 +919,9 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 			stream = dc->current_state->streams[0];
 			plane = (stream ? dc->current_state->stream_status[0].plane_states[0] : NULL);
 
+			if (!stream || !plane)
+				return false;
+
 			if (stream && plane) {
 				cursor_cache_enable = stream->cursor_position.enable &&
 						plane->address.grph.cursor_cache_addr.quad_part;
-- 
2.43.0


