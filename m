Return-Path: <stable+bounces-46856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D038D0B8C
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54BA2284E98
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46C66A039;
	Mon, 27 May 2024 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YdyBcES8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C8317E90E;
	Mon, 27 May 2024 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716837030; cv=none; b=h61iLvj/juXh301+5D/eJV2aAesUyDsJ7s18j2a7nlWf3np52G1pzQfs8nQLXB/S/XpNarH4ZSTDvTZqLo/7lrDagE58IhyCV3f3oBgjJaV2oFTmaVo7cjJa3Km/8bhzqsJa9e0BDDwP7WHnwSmqajXm8P/Ac/xo2fg632fbp08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716837030; c=relaxed/simple;
	bh=S3s0rrnUrVKELBCSVo2hjmt/AIyK5RQ4yo8BjzErpVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNBIEGDkEoNM8SUulrJJ+gWidwtrineKmVyJQA9K9R0mZSs3Qe0VPeZenzC73e+ThDHNzWGz/b8PZZ5SPnv2aSxMY8pWZu/5z8+7StJ5utjmEVGjTlihVL0Fg8QjKTPU2kUBvt0PRFhViNCcQvwld8a1tRSeoNQ9dIT6fcz0neU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YdyBcES8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14627C2BBFC;
	Mon, 27 May 2024 19:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716837030;
	bh=S3s0rrnUrVKELBCSVo2hjmt/AIyK5RQ4yo8BjzErpVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YdyBcES8RYkfYFODZWvkpHqNK7J1KloEAUMaBmob1shE+uDHsSH111CxwsBsOPZMB
	 EwX/k+e0XHPt30H0oDuj9mX6rBgP/O/hSKgBhyMe6UBKch9XqeVIj9MbEHrNWh/+mE
	 LA5YQkGqjwg++GZnWIt4qvJhHZFsAjvNwng11jfE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	Charlene Liu <Charlene.Liu@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Roman Li <roman.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 284/427] drm/amd/display: Fix potential index out of bounds in color transformation function
Date: Mon, 27 May 2024 20:55:31 +0200
Message-ID: <20240527185629.035445171@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
References: <20240527185601.713589927@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 63ae548f1054a0b71678d0349c7dc9628ddd42ca ]

Fixes index out of bounds issue in the color transformation function.
The issue could occur when the index 'i' exceeds the number of transfer
function points (TRANSFER_FUNC_POINTS).

The fix adds a check to ensure 'i' is within bounds before accessing the
transfer function points. If 'i' is out of bounds, an error message is
logged and the function returns false to indicate an error.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_cm_common.c:405 cm_helper_translate_curve_to_hw_format() error: buffer overflow 'output_tf->tf_pts.red' 1025 <= s32max
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_cm_common.c:406 cm_helper_translate_curve_to_hw_format() error: buffer overflow 'output_tf->tf_pts.green' 1025 <= s32max
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_cm_common.c:407 cm_helper_translate_curve_to_hw_format() error: buffer overflow 'output_tf->tf_pts.blue' 1025 <= s32max

Fixes: b629596072e5 ("drm/amd/display: Build unity lut for shaper")
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Cc: Charlene Liu <Charlene.Liu@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
index b7e57aa273619..b0d192c6e63eb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
@@ -402,6 +402,11 @@ bool cm_helper_translate_curve_to_hw_format(struct dc_context *ctx,
 				i += increment) {
 			if (j == hw_points - 1)
 				break;
+			if (i >= TRANSFER_FUNC_POINTS) {
+				DC_LOG_ERROR("Index out of bounds: i=%d, TRANSFER_FUNC_POINTS=%d\n",
+					     i, TRANSFER_FUNC_POINTS);
+				return false;
+			}
 			rgb_resulted[j].red = output_tf->tf_pts.red[i];
 			rgb_resulted[j].green = output_tf->tf_pts.green[i];
 			rgb_resulted[j].blue = output_tf->tf_pts.blue[i];
-- 
2.43.0




