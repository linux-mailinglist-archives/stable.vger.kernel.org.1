Return-Path: <stable+bounces-77500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88788985DD5
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BF21289484
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB0F2056EC;
	Wed, 25 Sep 2024 12:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JepnREdl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8312056E8;
	Wed, 25 Sep 2024 12:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266045; cv=none; b=VOnl8w1hBiaMbrJP0ViuKm3ezVbvzg2uqbZ8AP7uTJbE2/ZOYAG3UHvLDJmpjShdQbEih2hq+SruTNbFIqNBfiEAFYamtp3fo+AV049XwKL8Z72BI+qRX06LFUBt2cDnheTxv2GHxrNkGK8GGC3EY8Vj6qudWOsO6iSQgfj4sN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266045; c=relaxed/simple;
	bh=bxM/3bIOkkjTIets2DwQJY2+fk7h8rmncMBHNXUXJfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0mBwOz0DnMgypphOTayIuB32tpeYkuMqv05dbrn84GILyj0vVuoOBVjqSYClVnOHOxy8FS0zFy2JVHW00t1H+arLLsMJ9sAzMEvqWJgLyK7bjZwN1j4gVZbl26CEH3YjYV7GZHtfxb1pbMJvd6uHskOZwrHSRd3NdVxydpau7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JepnREdl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2E7C4CEC3;
	Wed, 25 Sep 2024 12:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266045;
	bh=bxM/3bIOkkjTIets2DwQJY2+fk7h8rmncMBHNXUXJfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JepnREdlgpBmfvh8F3gjvyl97W45NTvx6Fq8v2VZ/Nmh7hXM7AXfiF4TqgyiWWpoU
	 cveVep0drcc4rlkdsw60H2am5fusGzcU2zZyQbA8F2C4LHZQ6UAjW5FlkqALqvTtpv
	 78RI2iMg+KAQY0yX9m0yJN8PWxX49laITh1yNE3/myIhTHMpJYESeNuQxb24haks1z
	 jkLm0AaJpUI8zkpylh3x4nVaOwPU0bA7w4GTizH2sOObQk6xLMIGE8x6nAhQy9oob6
	 vyfBmBr1VQ121y5l+hAbCa0cI8OeWUkC61jDLFN8iCZHF0q1/PQHiiE66h6GpewpO6
	 WTokzXEz0kelQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	harikrishna.revalla@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 155/197] drm/amd/display: Fix index out of bounds in DCN30 color transformation
Date: Wed, 25 Sep 2024 07:52:54 -0400
Message-ID: <20240925115823.1303019-155-sashal@kernel.org>
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

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit d81873f9e715b72d4f8d391c8eb243946f784dfc ]

This commit addresses a potential index out of bounds issue in the
`cm3_helper_translate_curve_to_hw_format` function in the DCN30 color
management module. The issue could occur when the index 'i' exceeds the
number of transfer function points (TRANSFER_FUNC_POINTS).

The fix adds a check to ensure 'i' is within bounds before accessing the
transfer function points. If 'i' is out of bounds, the function returns
false to indicate an error.

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_cm_common.c:180 cm3_helper_translate_curve_to_hw_format() error: buffer overflow 'output_tf->tf_pts.red' 1025 <= s32max
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_cm_common.c:181 cm3_helper_translate_curve_to_hw_format() error: buffer overflow 'output_tf->tf_pts.green' 1025 <= s32max
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_cm_common.c:182 cm3_helper_translate_curve_to_hw_format() error: buffer overflow 'output_tf->tf_pts.blue' 1025 <= s32max

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
index edc77615d0973..0433f6b5dac78 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
@@ -177,6 +177,8 @@ bool cm3_helper_translate_curve_to_hw_format(
 				i += increment) {
 			if (j == hw_points)
 				break;
+			if (i >= TRANSFER_FUNC_POINTS)
+				return false;
 			rgb_resulted[j].red = output_tf->tf_pts.red[i];
 			rgb_resulted[j].green = output_tf->tf_pts.green[i];
 			rgb_resulted[j].blue = output_tf->tf_pts.blue[i];
-- 
2.43.0


