Return-Path: <stable+bounces-134870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB97A953E0
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 18:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AFB6167E62
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 16:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FF61E260C;
	Mon, 21 Apr 2025 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfrbXB4s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8561E25ED;
	Mon, 21 Apr 2025 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745252002; cv=none; b=rhTWCNzXMdummXETUlCryQ9027/WKk2CMnMNPSXR66xJXIgp0JAcm6V0rTMZXDd76DD0YYvKuMfgFo+6m/HSxZ4xqRm+2x01/DFizOZVpgQxE6WvcSDYwpQYfZA+q6AkJrwkLF7cYR70im751Ee/7m50CTu/RjNzJN2K/4cKppI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745252002; c=relaxed/simple;
	bh=un/wwArIfP7JErr0j3e550m4ix8Qb+8QW7iRtzJgnNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gJJakMgyCySY3w4rIhVpMTRNzSLjZ/qEufIu+z3Ii+lUgG3WWtVQqGtBmEoqyVhQPGlCzU7BDDoVxQ8kd/TF2r+ppa5SXwJn9B1PrIQJsp7/bGG3T+KzQ4VHq7JwS6rNpHiLFN/ECjZxxVc5fYAi7gSvearh+s9CT9K5PIFmcIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfrbXB4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A556C4CEE4;
	Mon, 21 Apr 2025 16:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745252002;
	bh=un/wwArIfP7JErr0j3e550m4ix8Qb+8QW7iRtzJgnNc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=cfrbXB4szIbk0vfuTA61GSiEXZ4bAIC4grzDgqrGhA9nSzZXEhYX+oy5dmZc1V3ec
	 gxC936tXnENeCIe1MSHRsUIl7MZ7rIzNC1Lol/Z8WHt5vlsGTQea7YLkMfqq7YCLvp
	 DsRAYs0SMGolELCf6MxEmZJhgkxcokrQ27B6UWH9IksJLclNAn6y36cFI6wxXaQbuv
	 sm4lm+BKBP5MFn5TKpQ7/l33RAMbwnjxsAgrq0N896r9p1EF5Kp4rQq9u1CbQtGE9+
	 s+5y/3GgUjuiUtwJOKnPWGAL6NZfd4gT4VS0MXWdyO6XJ3dAPRR5UWJ/byRW7eK0mF
	 RQWALiY6T7xLQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039E3C369D5;
	Mon, 21 Apr 2025 16:13:21 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 21 Apr 2025 11:13:05 -0500
Subject: [PATCH v2] drm/tegra: Assign plane type before registration
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250421-tegra-drm-primary-v2-1-7f740c4c2121@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJBuBmgC/32NQQqDMBBFryKz7pQkjRS76j2KiyROdKBRmYhUx
 Ls39QBdvgf//R0yCVOGR7WD0MqZp7GAuVQQBjf2hNwVBqNMraxucKFeHHaScBZOTjYMZO+RPMX
 ORSi7WSjy52y+2sID52WS7bxY9c/+q60aNfpGq9pGb/UtPvvk+H0NU4L2OI4vqbPm+LIAAAA=
X-Change-ID: 20250419-tegra-drm-primary-ce47febefdaf
To: Thierry Reding <thierry.reding@gmail.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>, 
 Aaron Kling <webgeek1234@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745252001; l=3636;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=Or7tDNWWlFSumB821skJoVUGwAK2I8ncBHMuDgkapE4=;
 b=2+gdz7hbqQdI1D615jKbm4aD/BhNq7CCHx//+FFw7ZttsjjqB7caby08sSZCdDJFDdEL1yeDq
 sX2OjpvnkKLDHCnfDKChpd8mL0k1bq9ld/T5saRYh89s0ouSp6jFrXh
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Thierry Reding <treding@nvidia.com>

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
---
Changes in v2:
- Fixed signoff in commit message
- Added fixes to commit message
- Link to v1: https://lore.kernel.org/r/20250419-tegra-drm-primary-v1-1-b91054fb413f@gmail.com
---
 drivers/gpu/drm/tegra/dc.c  | 12 ++++++++----
 drivers/gpu/drm/tegra/hub.c |  4 ++--
 drivers/gpu/drm/tegra/hub.h |  3 ++-
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 798507a8ae56d6789feb95dccdd23b2e63d9c148..56f12dbcee3e93ff5e4804e5fe9b23f160073ebf 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1321,10 +1321,16 @@ static struct drm_plane *tegra_dc_add_shared_planes(struct drm_device *drm,
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
 
@@ -1332,10 +1338,8 @@ static struct drm_plane *tegra_dc_add_shared_planes(struct drm_device *drm,
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
diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
index fa6140fc37fb16df4b150e5ae9d8148f8f446cd7..8f779f23dc0904d38b14d3f3a928a07fc9e601ad 100644
--- a/drivers/gpu/drm/tegra/hub.c
+++ b/drivers/gpu/drm/tegra/hub.c
@@ -755,9 +755,9 @@ static const struct drm_plane_helper_funcs tegra_shared_plane_helper_funcs = {
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
diff --git a/drivers/gpu/drm/tegra/hub.h b/drivers/gpu/drm/tegra/hub.h
index 23c4b2115ed1e36e8d2d6ed614a6ead97eb4c441..a66f18c4facc9df96ea8b9f54239b52f06536d12 100644
--- a/drivers/gpu/drm/tegra/hub.h
+++ b/drivers/gpu/drm/tegra/hub.h
@@ -80,7 +80,8 @@ void tegra_display_hub_cleanup(struct tegra_display_hub *hub);
 struct drm_plane *tegra_shared_plane_create(struct drm_device *drm,
 					    struct tegra_dc *dc,
 					    unsigned int wgrp,
-					    unsigned int index);
+					    unsigned int index,
+					    enum drm_plane_type type);
 
 int tegra_display_hub_atomic_check(struct drm_device *drm,
 				   struct drm_atomic_state *state);

---
base-commit: 119009db267415049182774196e3cce9e13b52ef
change-id: 20250419-tegra-drm-primary-ce47febefdaf

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



