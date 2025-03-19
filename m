Return-Path: <stable+bounces-125557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AFCA691DA
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7EE28A24F1
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA6220B808;
	Wed, 19 Mar 2025 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SUcbnwcX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2C41DF258;
	Wed, 19 Mar 2025 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395273; cv=none; b=n/740T99pz4fHxA6QMPOMISxIj1vIjvwLRVN9HbRZ0XSmT91+1y/ay+6Rw9C2VUwKsvUEpycP8IZ03Ya4y9dwvK75Z8ZVOzzsJJsJofL8LKhMAhnmZ3W+MS3fyCcq953F8Uq/1uuJzb7Bc4Rq8L1rzLcXRJPNmSRQB/FmxtoOno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395273; c=relaxed/simple;
	bh=YJGDwV+a5WPnS6iVXmxIDaFIkTu+nVCIM8mo77Xvsf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lfZ5Z+9EVmE6CSPRtbzrZFnl63/zJqlvZxBFT2XoPj9Zk37TU3+T33zpYOnHmZUl4Ti5DZ+vTJT+Zn7m1N6tdTJI3nVhheGqnjoXgKpLNj8oVGfYlI1GhcPNiYX7az+fpCWTRUBHBw8DTgAZYnRpw8J9ntK62T5/L+PwybartpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SUcbnwcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40626C4CEE4;
	Wed, 19 Mar 2025 14:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742395273;
	bh=YJGDwV+a5WPnS6iVXmxIDaFIkTu+nVCIM8mo77Xvsf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SUcbnwcXMx+6h8cbEU2aifdubLB/90oNGUDea5p9dYeCoouyzxmKJtETlSEQMWBU+
	 KxTBaY3ElSQIEnL8NTHrO4mHYO870bitC+R+SJGE+eex3ZX/9/l26xZ9RjWM7uDygw
	 ZBDldufOFwlavd17a/CWa+XD9o5NdCOreoAuKTQc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wayne Lin <Wayne.Lin@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.6 124/166] drm/amd/display: Restore correct backlight brightness after a GPU reset
Date: Wed, 19 Mar 2025 07:31:35 -0700
Message-ID: <20250319143023.373005397@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143019.983527953@linuxfoundation.org>
References: <20250319143019.983527953@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -227,6 +227,10 @@ static int amdgpu_dm_atomic_check(struct
 static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector);
 static void handle_hpd_rx_irq(void *param);
 
+static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
+					 int bl_idx,
+					 u32 user_brightness);
+
 static bool
 is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
 				 struct drm_crtc_state *new_crtc_state);
@@ -2879,6 +2883,12 @@ static int dm_resume(void *handle)
 
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



