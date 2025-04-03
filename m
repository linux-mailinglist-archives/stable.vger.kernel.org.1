Return-Path: <stable+bounces-128080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9301DA7AEFB
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802141886BD4
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A5622B587;
	Thu,  3 Apr 2025 19:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALDpoIN2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9636822AE7B;
	Thu,  3 Apr 2025 19:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707925; cv=none; b=ENrPB/Gijf+jSHyv/KEoLCiVkf7rWzuyMetk+FHpVeEO2q46UGiDgsTAkQ5oamlG/kXT2hi44kUEsUli/fUU8leCd7Kalx++nhhQYYlb9XYtZ1Nq7kLzsnJ/3GryvtauHa82NzDpO1qcvqm2CAdN7EG3ApdOdCSLuupOH+rVyJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707925; c=relaxed/simple;
	bh=mAR3N1DA9p1RenB4FLtVcyLd7Odi/j8YsFwqNJ8Zgfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cUuzQGue2DprUsg39IvLpzQ0z0wB/yJACR8tAFhAfBUc1KqABIBkwVHxCPJAfLJCr9YyPoRlQmCsQKpsU5S2kLSpvuZGVVdRwoLOzPBMwqkdB9xwDHCgWAc5PVAL8szfpWKg7c+zvKhms5PRyHDc3cDy5P3OfeaN585HqSDwAq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALDpoIN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A457CC4CEE3;
	Thu,  3 Apr 2025 19:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707924;
	bh=mAR3N1DA9p1RenB4FLtVcyLd7Odi/j8YsFwqNJ8Zgfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ALDpoIN2GXmO8UuBXdmMDS6UiIuzS1Yyh9tuIk/mE3RW1BrmD1yhyDD/JReaKLd9j
	 LMSxGa4EsqTJxWz9RP6kPMtOILMJ5RtVwnPzUuTKelFRgMStL52wduHl4BUkeispMN
	 cPJJfHH2cZHAqvsZvjvn0VnNN8cmmeiC2jx0JO5Xe3sDgxtPfjm94u4x1BiaFEQ8go
	 82B0CmZno7Mj2lk+CYNn+sraMYYSAGnctkBS0To3cTazQxFxuWefCRNkx6jjeuLIPW
	 2tIiTfO8/ljicD/CmGa0gmUeGK4sAuyivAyM4HJcwKPdkIT7boVr/OoneLey0suS+H
	 AB4uiaWNfLEwg==
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
Subject: [PATCH AUTOSEL 6.6 09/23] drm/bridge: panel: forbid initializing a panel with unknown connector type
Date: Thu,  3 Apr 2025 15:18:02 -0400
Message-Id: <20250403191816.2681439-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191816.2681439-1-sashal@kernel.org>
References: <20250403191816.2681439-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
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
index cfbe020de54e0..98df4788d096f 100644
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


