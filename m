Return-Path: <stable+bounces-34654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC55989403D
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E29E1F218D6
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D34446D5;
	Mon,  1 Apr 2024 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xTX2rsCE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5977C129;
	Mon,  1 Apr 2024 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711988848; cv=none; b=Hd4OxaXdwCBsuj5NMIZ/EC6Yxyh+2FveKHaZn4XH5CucT3W79pjzFBaOLv5VKifT1oADD67IIGQCbRGzPJbduUkC4F5K5n9+2PIv8kf42cXH6Z8omfFjJnlVIurYHxY2FD3rrZFFcFqS3fDhGR1w0pBtfBHcxhOqL7R+XP4qo78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711988848; c=relaxed/simple;
	bh=iLyXEqxIlNDD4ZTopjhmiZgrTESjyHwGfGhdJSa3RVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dPvtBvgVazVOnRfRGVIOFfKwpTnLSmUJoeEdDIVtEmBxADHtTGwv9aLEkJoaqHIzUu/OThNlZxdFVOyyeDDE/i/Oju5mB1IHxiPJDJ8H+4TeeqyvlDINKHBHCJ+W8uphRccm+uHRo9fEQI5FGI1akGTTVrjUgbeXzWQFfnW4xak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xTX2rsCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D1EC433C7;
	Mon,  1 Apr 2024 16:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711988848;
	bh=iLyXEqxIlNDD4ZTopjhmiZgrTESjyHwGfGhdJSa3RVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xTX2rsCEVNQR1xxOgdJaIKocEdvMi9HhtZJfmAKBa0JgZbo27I4m8A4tS91RZNi5g
	 g1xKgcEXFSp0NkuIsRPqik07vnLqGTa3xE0u4C7BamMFUom0mTSxMtuxUxgi24OwMe
	 fpTAl25Ns4q7EUTCeFLtnebKJJljrxTCL/+0DS/o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Mano=20S=C3=A9gransan?= <mano.segransan@protonmail.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.7 289/432] drm/amd/display: handle range offsets in VRR ranges
Date: Mon,  1 Apr 2024 17:44:36 +0200
Message-ID: <20240401152601.790021858@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 937844d661354bf142dc1c621396fdab10ecbacc upstream.

Need to check the offset bits for values greater than 255.

v2: also update amdgpu_dm_connector values.

Suggested-by: Mano Ségransan <mano.segransan@protonmail.com>
Tested-by: Mano Ségransan <mano.segransan@protonmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3203
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10876,14 +10876,23 @@ void amdgpu_dm_update_freesync_caps(stru
 				if (range->flags != 1)
 					continue;
 
-				amdgpu_dm_connector->min_vfreq = range->min_vfreq;
-				amdgpu_dm_connector->max_vfreq = range->max_vfreq;
-				amdgpu_dm_connector->pixel_clock_mhz =
-					range->pixel_clock_mhz * 10;
-
 				connector->display_info.monitor_range.min_vfreq = range->min_vfreq;
 				connector->display_info.monitor_range.max_vfreq = range->max_vfreq;
 
+				if (edid->revision >= 4) {
+					if (data->pad2 & DRM_EDID_RANGE_OFFSET_MIN_VFREQ)
+						connector->display_info.monitor_range.min_vfreq += 255;
+					if (data->pad2 & DRM_EDID_RANGE_OFFSET_MAX_VFREQ)
+						connector->display_info.monitor_range.max_vfreq += 255;
+				}
+
+				amdgpu_dm_connector->min_vfreq =
+					connector->display_info.monitor_range.min_vfreq;
+				amdgpu_dm_connector->max_vfreq =
+					connector->display_info.monitor_range.max_vfreq;
+				amdgpu_dm_connector->pixel_clock_mhz =
+					range->pixel_clock_mhz * 10;
+
 				break;
 			}
 



