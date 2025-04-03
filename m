Return-Path: <stable+bounces-128050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E038DA7AEB3
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5155D189E33D
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E7722171D;
	Thu,  3 Apr 2025 19:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVd7zLFC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C470822170B;
	Thu,  3 Apr 2025 19:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707854; cv=none; b=dvEv+95uLN31/vheFadIIgn7yVP/RVH73Zfl/a1s1ruNMZtgpf6D9I6KnirwevDsf/0aAkfImfBftqWgBaeCdzwK5iU9TbIkMLP5FHy2fXbNT9g8BZWF4MjRlyQ23BY5UYlU8Yzf2yKXBkXR2zdnzIYs0FSzb6Hs+m1V2fJx5Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707854; c=relaxed/simple;
	bh=xm7sDgQav9lbbEd0kVSgwqWfivHkaFEd3qIJdAM/vPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gi9LS0nwYGYXq8wBN2dbWzD5PfiwhLONZ4u7eTcqq/uy1mEiIxFgWG15UmkPInsCHn49d/qFYWKHw5Nm9x8M6hZpiYscwVYfpGTjznua7agt8WBdZKqnAKfSzQKdH0UesNT4h05JYfyHL02+msuUMO8pnR1yDeb2DZ/zq1Z9Wjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVd7zLFC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5762C4CEE8;
	Thu,  3 Apr 2025 19:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707854;
	bh=xm7sDgQav9lbbEd0kVSgwqWfivHkaFEd3qIJdAM/vPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QVd7zLFCgSbWWThD9O5pCFo0bkT0MseJ8aRNzrbqs5vadSXxB2jWF0lMu8Ao5GDYe
	 XY2EfRnXPWDSc50Q0n/sHzqtuW3j9EFKSHhWLN2m0tiPw4m8RKKwo/+hS+8rv222Yk
	 QWajEj9inSnaDRhpsBDvojVldQscHD1PvwllO8AjK9STVEn74ZxkWU/YHoH3MeJxKA
	 W592G0CKsXo0a7k/6KMOqQOtah9sq7gWqJqqAs7fXSANE/3/M6s6qlYM5L48tXDxkX
	 zrAfs05OM4Bb+xBr9ab5VeavUlXH7yN2aP3C69dy1+2pu356yzG4Lz3zBkzpwkwEnR
	 cx4SA7MumEd4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 12/33] drm/bridge: panel: forbid initializing a panel with unknown connector type
Date: Thu,  3 Apr 2025 15:16:35 -0400
Message-Id: <20250403191656.2680995-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191656.2680995-1-sashal@kernel.org>
References: <20250403191656.2680995-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

[ Upstream commit b296955b3a740ecc8b3b08e34fd64f1ceabb8fb4 ]

Having an DRM_MODE_CONNECTOR_Unknown connector type is considered bad, and
drm_panel_bridge_add_typed() and derivatives are deprecated for this.

drm_panel_init() won't prevent initializing a panel with a
DRM_MODE_CONNECTOR_Unknown connector type. Luckily there are no in-tree
users doing it, so take this as an opportinuty to document a valid
connector type must be passed.

Returning an error if this rule is violated is not possible because
drm_panel_init() is a void function. Add at least a warning to make any
violations noticeable, especially to non-upstream drivers.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20250214-drm-assorted-cleanups-v7-5-88ca5827d7af@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 19ab0a794add3..fd8fa2e0ef6fa 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -49,7 +49,7 @@ static LIST_HEAD(panel_list);
  * @dev: parent device of the panel
  * @funcs: panel operations
  * @connector_type: the connector type (DRM_MODE_CONNECTOR_*) corresponding to
- *	the panel interface
+ *	the panel interface (must NOT be DRM_MODE_CONNECTOR_Unknown)
  *
  * Initialize the panel structure for subsequent registration with
  * drm_panel_add().
@@ -57,6 +57,9 @@ static LIST_HEAD(panel_list);
 void drm_panel_init(struct drm_panel *panel, struct device *dev,
 		    const struct drm_panel_funcs *funcs, int connector_type)
 {
+	if (connector_type == DRM_MODE_CONNECTOR_Unknown)
+		DRM_WARN("%s: %s: a valid connector type is required!\n", __func__, dev_name(dev));
+
 	INIT_LIST_HEAD(&panel->list);
 	INIT_LIST_HEAD(&panel->followers);
 	mutex_init(&panel->follower_lock);
-- 
2.39.5


