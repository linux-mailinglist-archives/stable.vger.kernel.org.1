Return-Path: <stable+bounces-193818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C92C4AB23
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8BAB3BB849
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F181F4169;
	Tue, 11 Nov 2025 01:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vNavRHQP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139063431F8;
	Tue, 11 Nov 2025 01:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824081; cv=none; b=HLAD1jVneiUue9RACbY2JJZQ/4zC+1SkKEg4RW/yE2PBdFvoMz8ILyz/nhN1dNbMo32uvIYZjx1FHf4jFpF4JcqIcs6yXt+4EorAy8WLFg5nt5DrXfzzb8T1FUK7KYjMtRdsld9ZYoPxKDj7I2+XKgQZxs7/cATb1m3lHz9QvxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824081; c=relaxed/simple;
	bh=hVqerY9oTrkOx2lUez2sovOBpKwwI/+dzTiD93GUDoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7J3RrF9ERq5ZroHto1iGNN3gSUDcERc4zGZE4qjHw4sR9QH/prfomtjoFRsjihBGhQP6xoUWg0WXtEKZLFdmK5pAW6QxWZ6qhKtBWsL0VEJBeeu51Stk1PH0QZmh0oNWYUGeZfN+rVgczcbzZgJlYthhUeN9ZZmjro9cxVwtQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vNavRHQP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A880AC116B1;
	Tue, 11 Nov 2025 01:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762824081;
	bh=hVqerY9oTrkOx2lUez2sovOBpKwwI/+dzTiD93GUDoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vNavRHQP14yMz5rNm3/ujGq23wolj3f0hvwSsfqGsiP0z+3NeVQce1LX76aWTQYq+
	 lucf+77ANSpLqV6HusLyfzf9fKeJ/3WGDqg9vqiACdN9t/oix5/gyF3yXXoHoZ6ORK
	 4a+2cArXGW6pcvTQKxcycLYWP9G30Gsyzgc5ih9Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mauri Carvalho <mcarvalho3@lenovo.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	Ray Wu <ray.wu@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 361/565] drm/amd/display: Set up pixel encoding for YCBCR422
Date: Tue, 11 Nov 2025 09:43:37 +0900
Message-ID: <20251111004534.987216870@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004526.816196597@linuxfoundation.org>
References: <20251111004526.816196597@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <Mario.Limonciello@amd.com>

[ Upstream commit 5e76bc677cb7c92b37d8bc66bb67a18922895be2 ]

[Why]
fill_stream_properties_from_drm_display_mode() will not configure pixel
encoding to YCBCR422 when the DRM color format supports YCBCR422 but not
YCBCR420 or YCBCR4444.  Instead it will fallback to RGB.

[How]
Add support for YCBCR422 in pixel encoding mapping.

Suggested-by: Mauri Carvalho <mcarvalho3@lenovo.com>
Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Mario Limonciello <Mario.Limonciello@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fd44d011ffd2d..37307caf92999 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6161,6 +6161,9 @@ static void fill_stream_properties_from_drm_display_mode(
 			&& aconnector
 			&& aconnector->force_yuv420_output)
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
+	else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR422)
+			&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
+		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR422;
 	else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR444)
 			&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR444;
-- 
2.51.0




