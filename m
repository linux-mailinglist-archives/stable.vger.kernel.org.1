Return-Path: <stable+bounces-125340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DD3A69124
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C831B67F7E
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF831E8354;
	Wed, 19 Mar 2025 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="un0HK9c4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6B71DD0E1;
	Wed, 19 Mar 2025 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395119; cv=none; b=TlLk83Nuf8zkKw6D63saJuElm9nA08uwsyU8kntsWBofHF37EB5iZBZGNaiXcSUQ90KD9V+FdY9WIqFq3uN1KqzBALpZMuCcgIhxzmKDbqAVX9kBM/YtX099M5MR30FhxlQr5dlVwex2D9Pmm8kHuMoWRS++UpYtUTnSEpU44io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395119; c=relaxed/simple;
	bh=wKSJP4mARFGQ59JvU0/X1vaDTd1Ip7n+MeX2ekxxy30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhpgVn6nJDQM9nf8RyY9+s3gFlElYYUZAR7OPktTT5jClVxTOHPlhJe80+oCq4OwzLeMFBiuFLdAvRouS4wDVM/5IrHiLhGk4tbo71Y44UrmttC9Gnw+l4BbtvGtBs8fc0uNX5xwJFIfxrCDUUGvqbBfgcwMxiaFzy/n3VTJZU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=un0HK9c4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6E2C4CEE8;
	Wed, 19 Mar 2025 14:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742395119;
	bh=wKSJP4mARFGQ59JvU0/X1vaDTd1Ip7n+MeX2ekxxy30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=un0HK9c49h8Av1ma7O2tvWBfSxA8QvTCCiAzqxqUatn1q1nP3USirLDC5G9c1GXfm
	 48MbI06AMafBLpS6byCgCbx91elp197sq48sxDDV1hg0gAUEfQlLwn2UU98dxrjKjI
	 PcqZ/bwjJ4khBSSb+6oeBFCEmDbJzIhjpWjov1Yc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wayne Lin <Wayne.Lin@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12 180/231] drm/amd/display: Restore correct backlight brightness after a GPU reset
Date: Wed, 19 Mar 2025 07:31:13 -0700
Message-ID: <20250319143031.284856784@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143026.865956961@linuxfoundation.org>
References: <20250319143026.865956961@linuxfoundation.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

commit 5760388d9681ac743038b846b9082b9023969551 upstream.

[Why]
GPU reset will attempt to restore cached state, but brightness doesn't
get restored. It will come back at 100% brightness, but userspace thinks
it's the previous value.

[How]
When running resume sequence if GPU is in reset restore brightness
to previous value.

Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 5e19e2b57b6bb640d68dfc7991e1e182922cf867)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -243,6 +243,10 @@ static int amdgpu_dm_atomic_check(struct
 static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector);
 static void handle_hpd_rx_irq(void *param);
 
+static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
+					 int bl_idx,
+					 u32 user_brightness);
+
 static bool
 is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
 				 struct drm_crtc_state *new_crtc_state);
@@ -3295,6 +3299,12 @@ static int dm_resume(void *handle)
 
 		mutex_unlock(&dm->dc_lock);
 
+		/* set the backlight after a reset */
+		for (i = 0; i < dm->num_of_edps; i++) {
+			if (dm->backlight_dev[i])
+				amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
+		}
+
 		return 0;
 	}
 	/* Recreate dc_state - DC invalidates it when setting power state to S3. */



