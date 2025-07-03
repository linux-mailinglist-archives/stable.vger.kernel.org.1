Return-Path: <stable+bounces-160044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B551AF7C2B
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75F16E65AA
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1F22EF656;
	Thu,  3 Jul 2025 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FilvV8iM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E0422B8AB;
	Thu,  3 Jul 2025 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556190; cv=none; b=KZ/vCPIYWnGJ4xqm0TPl33AGqvrqO4c6vXU0rL3etPHOJVSyMPqbgJ0D8bVlmLkc0NZt9RQhLSvuQB4iZmWlijGmFjE6q2c1rGZReP4PCge0DmJHh+enuDBR07TXfqTVsTH0ttmAJoJ/Xhlq5Uclzr99iueWFLb0w9OQ1Ap6dtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556190; c=relaxed/simple;
	bh=bZd717Ah/HhSqsd1OgOJz/NnKMh6TVXNHciSEEXTZXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrZuun6cF8DX1xB9QYdYVt0DK0KC/AkHlX9n+qn9fxuZWzrcDxpWem1N0fSS23W1KaDJAFnAkSVwD2SmfiurvrFQ/o8FfWrHuooYkjphDlVI7E/o/fgYFchWI2H76TivQkjDbV7K1QXEj0e/jnlfhiH6TRVsKZM3D40g+SREC28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FilvV8iM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0A6C4CEE3;
	Thu,  3 Jul 2025 15:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751556190;
	bh=bZd717Ah/HhSqsd1OgOJz/NnKMh6TVXNHciSEEXTZXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FilvV8iMA3fw7QZgwvzvfzHzEU4NFP+vGvIMPlZDznm21f4bkcn6QeKZDIUzQCB/J
	 aCODqPnY00bJXsDVWAiA3RuN/e/lMAgqw/7tY6/SfmU+snnt1dCQjEH499oao4Dtyx
	 83iVDMp2/T/CzwsYTe42Lirqf8TRnYiFxu5vsDHM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aaron Kling <webgeek1234@gmail.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH 6.1 103/132] drm/tegra: Assign plane type before registration
Date: Thu,  3 Jul 2025 16:43:12 +0200
Message-ID: <20250703143943.436014428@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143939.370927276@linuxfoundation.org>
References: <20250703143939.370927276@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thierry Reding <treding@nvidia.com>

commit 9ff4fdf4f44b69237c0afc1d3a8dac916ce66f3e upstream.

Changes to a plane's type after it has been registered aren't propagated
to userspace automatically. This could possibly be achieved by updating
the property, but since we can already determine which type this should
be before the registration, passing in the right type from the start is
a much better solution.

Suggested-by: Aaron Kling <webgeek1234@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Cc: stable@vger.kernel.org
Fixes: 473079549f27 ("drm/tegra: dc: Add Tegra186 support")
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://lore.kernel.org/r/20250421-tegra-drm-primary-v2-1-7f740c4c2121@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/tegra/dc.c  |   12 ++++++++----
 drivers/gpu/drm/tegra/hub.c |    4 ++--
 drivers/gpu/drm/tegra/hub.h |    3 ++-
 3 files changed, 12 insertions(+), 7 deletions(-)

--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1319,10 +1319,16 @@ static struct drm_plane *tegra_dc_add_sh
 		if (wgrp->dc == dc->pipe) {
 			for (j = 0; j < wgrp->num_windows; j++) {
 				unsigned int index = wgrp->windows[j];
+				enum drm_plane_type type;
+
+				if (primary)
+					type = DRM_PLANE_TYPE_OVERLAY;
+				else
+					type = DRM_PLANE_TYPE_PRIMARY;
 
 				plane = tegra_shared_plane_create(drm, dc,
 								  wgrp->index,
-								  index);
+								  index, type);
 				if (IS_ERR(plane))
 					return plane;
 
@@ -1330,10 +1336,8 @@ static struct drm_plane *tegra_dc_add_sh
 				 * Choose the first shared plane owned by this
 				 * head as the primary plane.
 				 */
-				if (!primary) {
-					plane->type = DRM_PLANE_TYPE_PRIMARY;
+				if (!primary)
 					primary = plane;
-				}
 			}
 		}
 	}
--- a/drivers/gpu/drm/tegra/hub.c
+++ b/drivers/gpu/drm/tegra/hub.c
@@ -756,9 +756,9 @@ static const struct drm_plane_helper_fun
 struct drm_plane *tegra_shared_plane_create(struct drm_device *drm,
 					    struct tegra_dc *dc,
 					    unsigned int wgrp,
-					    unsigned int index)
+					    unsigned int index,
+					    enum drm_plane_type type)
 {
-	enum drm_plane_type type = DRM_PLANE_TYPE_OVERLAY;
 	struct tegra_drm *tegra = drm->dev_private;
 	struct tegra_display_hub *hub = tegra->hub;
 	struct tegra_shared_plane *plane;
--- a/drivers/gpu/drm/tegra/hub.h
+++ b/drivers/gpu/drm/tegra/hub.h
@@ -80,7 +80,8 @@ void tegra_display_hub_cleanup(struct te
 struct drm_plane *tegra_shared_plane_create(struct drm_device *drm,
 					    struct tegra_dc *dc,
 					    unsigned int wgrp,
-					    unsigned int index);
+					    unsigned int index,
+					    enum drm_plane_type type);
 
 int tegra_display_hub_atomic_check(struct drm_device *drm,
 				   struct drm_atomic_state *state);



