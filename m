Return-Path: <stable+bounces-109828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FF2A18418
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E73188C548
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 18:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306451F5439;
	Tue, 21 Jan 2025 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O1Q/uFQG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E037A1F540C;
	Tue, 21 Jan 2025 18:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482557; cv=none; b=BCUtgMV0D7K6k5irP1x7ftxTF2oNZaLT40taQUEXVqFpXfkFgR842080rJW2D0rHMvSF/EDOmqhfS3uawlORwimSJKQelEEt4x1dbbRDoaIltZHCKFXykd36K6dCfASb6ptZaB/lFTtLVBrUfesP8jBfqjkn5Vq183JZm4H6i8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482557; c=relaxed/simple;
	bh=zZ2VFekpGhy9X679mjw5vdVB2epIcEgNBH2KhyCc+BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGybby6h/KtjJR61cNp2JTnmSWHUpoUzLpUMQENgM01tQw2pldfR6C4m3qTVLc+LWNgOg6a6cGcZ1tj47+kqlawmf3BNcQiApINbG0KAwtxkB/sHsg+f7bl2k/HMmYPIqt0BiyHGhTg16Hz9Jj8sc7KiPSWHZbWc+2MjxfOkyWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O1Q/uFQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68465C4CEE0;
	Tue, 21 Jan 2025 18:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737482556;
	bh=zZ2VFekpGhy9X679mjw5vdVB2epIcEgNBH2KhyCc+BQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O1Q/uFQGKxNmNwWsAIeEudlMO0C2Z6etbS+xnx9mZwd2Oet0lgMyoK14DtQYr05fo
	 BFXwUYuCj+AmIJwdF29XuZM4Ra8Qo13tDizeQx2A3/HwzanSQB6tk0dw2j9vd15R5U
	 jnPxlm9NcfBLYe+zuH8hzqEpWaJE+3iPJCjwMyoI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sun peng Li <sunpeng.li@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Roman Li <roman.li@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12 117/122] drm/amd/display: Fix PSR-SU not support but still call the amdgpu_dm_psr_enable
Date: Tue, 21 Jan 2025 18:52:45 +0100
Message-ID: <20250121174537.566708531@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121174532.991109301@linuxfoundation.org>
References: <20250121174532.991109301@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Tom Chung <chiahsuan.chung@amd.com>

commit b0a3e840ad287c33a86b5515d606451b7df86ad4 upstream.

[Why]
The enum DC_PSR_VERSION_SU_1 of psr_version is 1 and
DC_PSR_VERSION_UNSUPPORTED is 0xFFFFFFFF.

The original code may has chance trigger the amdgpu_dm_psr_enable()
while psr version is set to DC_PSR_VERSION_UNSUPPORTED.

[How]
Modify the condition to psr->psr_version == DC_PSR_VERSION_SU_1

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit f765e7ce0417f8dc38479b4b495047c397c16902)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8922,7 +8922,7 @@ static void amdgpu_dm_enable_self_refres
 		    (current_ts - psr->psr_dirty_rects_change_timestamp_ns) > 500000000) {
 			if (pr->replay_feature_enabled && !pr->replay_allow_active)
 				amdgpu_dm_replay_enable(acrtc_state->stream, true);
-			if (psr->psr_version >= DC_PSR_VERSION_SU_1 &&
+			if (psr->psr_version == DC_PSR_VERSION_SU_1 &&
 			    !psr->psr_allow_active && !aconn->disallow_edp_enter_psr)
 				amdgpu_dm_psr_enable(acrtc_state->stream);
 		}



