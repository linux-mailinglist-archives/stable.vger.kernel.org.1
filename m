Return-Path: <stable+bounces-16141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FE083F0F3
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F991C22A56
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A66F1E87D;
	Sat, 27 Jan 2024 22:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KEb62oeO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A21314AB4
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 22:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706395163; cv=none; b=a9Om3a2T8nXO2MUMdDLHSTiJJFZar2F7C1K50L/5ScBHBWjZ/qXfm7cy2EIa48eMvHZyDtsvsm73y5pctWBF+BybOoZSd4ivQrPOY5JbmWCxLmame7AErtiCNDaHLPUrLS0aHZ0LAEi2tCFx03rjVnesCLDdwLdSSgMZpzsHLGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706395163; c=relaxed/simple;
	bh=xGuoptJm+WAzKdn63SBf6xLRK16XkqACC/bSHBYkTVc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gvRJNZ8cga9t8iFQbSd805QS6d3RfQuwAIU5eOsuSSuHJWkcHgb9QRwG8YSC4xKwlEJ40d5b4Lkh1FoyDUYs54KfozgoRz4nP79grn5j+sZxYIByiODy/Z4+YG2npKifcHJJa8x8f1SpY+NTw+GmR/sLHLNOUwvy9hRsBl6BP60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KEb62oeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD127C43390;
	Sat, 27 Jan 2024 22:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706395162;
	bh=xGuoptJm+WAzKdn63SBf6xLRK16XkqACC/bSHBYkTVc=;
	h=Subject:To:Cc:From:Date:From;
	b=KEb62oeODdOUe2qfvxCuUAaBj+eOIH0RZLIqwMUgXovWGbEJKR+8RL0v07dMLtrU+
	 2n+AfcaIiZ4HDSC3VOjNq97T9yebPi6kDDy4bi3rEANznvDVBNOwlKFsOwuEqgGlkM
	 7wzIsE6nad/occGQSjxf6Q9cq06njyz32lPyvH8s=
Subject: FAILED: patch "[PATCH] drm/amd/display: fix ABM disablement" failed to apply to 6.1-stable tree
To: hamza.mahfooz@amd.com,alexander.deucher@amd.com,harry.wentland@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 14:39:21 -0800
Message-ID: <2024012721-lushly-eliminate-aa66@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7a6931a476d30f0d6bf70b01a925f76f92d23940
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012721-lushly-eliminate-aa66@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

7a6931a476d3 ("drm/amd/display: fix ABM disablement")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7a6931a476d30f0d6bf70b01a925f76f92d23940 Mon Sep 17 00:00:00 2001
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
Date: Wed, 22 Nov 2023 14:50:34 -0500
Subject: [PATCH] drm/amd/display: fix ABM disablement

On recent versions of DMUB firmware, if we want to completely disable
ABM we have to pass ABM_LEVEL_IMMEDIATE_DISABLE as the requested ABM
level to DMUB. Otherwise, LCD eDP displays are unable to reach their
maximum brightness levels. So, to fix this whenever the user requests an
ABM level of 0 pass ABM_LEVEL_IMMEDIATE_DISABLE to DMUB instead. Also,
to keep the user's experience consistent map ABM_LEVEL_IMMEDIATE_DISABLE
to 0 when a user tries to read the requested ABM level.

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2be64c593c87..39a4b47b6804 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6248,7 +6248,7 @@ int amdgpu_dm_connector_atomic_set_property(struct drm_connector *connector,
 		dm_new_state->underscan_enable = val;
 		ret = 0;
 	} else if (property == adev->mode_info.abm_level_property) {
-		dm_new_state->abm_level = val;
+		dm_new_state->abm_level = val ?: ABM_LEVEL_IMMEDIATE_DISABLE;
 		ret = 0;
 	}
 
@@ -6293,7 +6293,8 @@ int amdgpu_dm_connector_atomic_get_property(struct drm_connector *connector,
 		*val = dm_state->underscan_enable;
 		ret = 0;
 	} else if (property == adev->mode_info.abm_level_property) {
-		*val = dm_state->abm_level;
+		*val = (dm_state->abm_level != ABM_LEVEL_IMMEDIATE_DISABLE) ?
+			dm_state->abm_level : 0;
 		ret = 0;
 	}
 
@@ -6366,7 +6367,8 @@ void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)
 		state->pbn = 0;
 
 		if (connector->connector_type == DRM_MODE_CONNECTOR_eDP)
-			state->abm_level = amdgpu_dm_abm_level;
+			state->abm_level = amdgpu_dm_abm_level ?:
+				ABM_LEVEL_IMMEDIATE_DISABLE;
 
 		__drm_atomic_helper_connector_reset(connector, &state->base);
 	}


