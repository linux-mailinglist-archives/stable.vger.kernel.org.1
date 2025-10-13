Return-Path: <stable+bounces-185232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AEABD4931
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B5B18A5534
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0611630F95B;
	Mon, 13 Oct 2025 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k4ATA7Rd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86EF30C357;
	Mon, 13 Oct 2025 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369708; cv=none; b=Jszsb3q1T6+LAZmvz+yu3SIk5dtP9NL5vilQ13hJBJs1RAc2B2/cRFvVlzp7Pja6OmJ9FaZfxl56LPiXSdmyWwyHBj/KeM7lBHds7OFL8yG5pkpVAGTGeJvrBpdzffLTqL3hSlZ8zulg6dNSzbYPDWX47TaTbBPPODEroXT7Z/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369708; c=relaxed/simple;
	bh=uAuSLoMFaEgTntYgbbpR1rTOtk2rXqI/Tfe0vGkankI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwdqzOhFrXXNCOJsrP/Ll+EbeaaZ9Q0jrem9sYFqjTirdmSnPFCqe+srAEgo6lzKHdB/fp9thW5qa1DOqvyb+jklI1rwJ/SzKbwaubqu45fVoZS5cetiwMK/lVhTRj0bd3isAbqlL1xX43BHjsljRqp5qh/9z3LNBqZMHqNmduI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k4ATA7Rd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9CFC4CEE7;
	Mon, 13 Oct 2025 15:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760369708;
	bh=uAuSLoMFaEgTntYgbbpR1rTOtk2rXqI/Tfe0vGkankI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k4ATA7Rd2cupxWqFgJo4eD6Iu38F4WQDYatmmiWXrpabT6z2A9cA3D3xRFZ3HyKq8
	 IPenndH/yqqDC7y+aM7/ldIunueQBQGn+wvEZ6yldpxoD4bCLvdq+VRRlhBzsegCkW
	 mzu2sn6xrqi7v+f0/xwoOkQwVEjoKeqSyYuUtRKY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 307/563] drm/amd/pm: Disable MCLK switching with non-DC at 120 Hz+ (v2)
Date: Mon, 13 Oct 2025 16:42:48 +0200
Message-ID: <20251013144422.385736781@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
References: <20251013144411.274874080@linuxfoundation.org>
User-Agent: quilt/0.69
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit ed3803533c7bf7df88bc3fc9f70bd317e1228ea8 ]

According to pp_pm_compute_clocks the non-DC display code
has "issues with mclk switching with refresh rates over 120 hz".
The workaround is to disable MCLK switching in this case.

Do the same for legacy DPM.

Fixes: 6ddbd37f1074 ("drm/amd/pm: optimize the amdgpu_pm_compute_clocks() implementations")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
index 42efe838fa85c..2d2d2d5e67634 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
@@ -66,6 +66,13 @@ u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev)
 					(amdgpu_crtc->v_border * 2));
 
 				vblank_time_us = vblank_in_pixels * 1000 / amdgpu_crtc->hw_mode.clock;
+
+				/* we have issues with mclk switching with
+				 * refresh rates over 120 hz on the non-DC code.
+				 */
+				if (drm_mode_vrefresh(&amdgpu_crtc->hw_mode) > 120)
+					vblank_time_us = 0;
+
 				break;
 			}
 		}
-- 
2.51.0




