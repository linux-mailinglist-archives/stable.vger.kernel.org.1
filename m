Return-Path: <stable+bounces-16140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0230283F0F2
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350CC1C2255C
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DF51E537;
	Sat, 27 Jan 2024 22:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZnV7Iz3v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2923518EA1
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706395162; cv=none; b=ooGdJ7+13OsmFB4VwPXcMmmoyUnMnscq8qwAs+x+7mYxWFmmQnpZCy4oMgiYxr66gLW6wUIUngK7PkuEJ6XEVfUvIqaR40ncFXlT1GtI/ZT0U3VE3otHqdeh6s1vIn5pUIzKVBFKXOTEMpXbeHsYgEnE5fZERekI2xWHsYOpfJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706395162; c=relaxed/simple;
	bh=VWGjq1D1LFrfqGyyD33nF4QY5GLSml7v9SPPIHbsiYI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sLH38HV6lO8HQ3On8B00gvwYhSyAkVMkZbA+ugH9KUCQSHw7qvW+r6Zn/6aLcbP6nZ37zBnw7gv7TjK/Lt3UO/nhkNZIJ7GfE34vwfEWVfFPGg8Oz5LSPRrGnjX3hJpCCAw0rfjrM/uxMjJcAJMZqwEW182VdEXS5HRIT6mvSnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZnV7Iz3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC5DC433F1;
	Sat, 27 Jan 2024 22:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706395161;
	bh=VWGjq1D1LFrfqGyyD33nF4QY5GLSml7v9SPPIHbsiYI=;
	h=Subject:To:Cc:From:Date:From;
	b=ZnV7Iz3vpwjCfZt9/fcSY9GiTHdwnDl314ehISBEen8Xt/eGDJJ5SrZbEo0Ncy2R0
	 QgD1DkvKbaccOGcD8EJcG0zwb2Qx5xWR1f+2nqe9TKeU+vg9dY8/jIcwtSAdrs4TLr
	 xdDC+ysbB0mh6RpSY+4pfYTebhnqZ/BzkMn/31wk=
Subject: FAILED: patch "[PATCH] drm/amd/display: fix ABM disablement" failed to apply to 6.6-stable tree
To: hamza.mahfooz@amd.com,alexander.deucher@amd.com,harry.wentland@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 14:39:20 -0800
Message-ID: <2024012720-walnut-proofs-101c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7a6931a476d30f0d6bf70b01a925f76f92d23940
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012720-walnut-proofs-101c@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


