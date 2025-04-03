Return-Path: <stable+bounces-128138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F5DA7AF8B
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E321E3BFC39
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8CD2E5680;
	Thu,  3 Apr 2025 19:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtilNI3B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF452E5676;
	Thu,  3 Apr 2025 19:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743708061; cv=none; b=RGBzXAurGgWgcRaNnHdGEP/Ha/ZUfSXGY008Jw54TVFBqGaMyvvyv80iNPlsPc3gAx/hG2XIjzdDPxUlVgrXkrDm45lxgIkjzD988c6IofRefWwE7pG9qcPm+0lZPKSAIII73CkgfmL3DsjLG+oaQdoY516XcSNQCYiXG4z3FcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743708061; c=relaxed/simple;
	bh=0ppqdJpg4KC7Ap1Vpy/8hlHSfTjr7LQJi83E3R+Yf+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AukVzAVIw1wqFhRMMLXUNrOgeYv7Tiwo3Vn/jLq8IQFr73wkz6oqKlk8rJ4ym80xvSQgMdjZN7lf/aN4eEKlvpmFPB1fsHbHCE+XzcHmiZxtZHjotOvfgHQDjqzA2cRduX/laBuCBuI06zFm6e2FVoquHD1F+JRng6g/83dydaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtilNI3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4906AC4CEE3;
	Thu,  3 Apr 2025 19:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743708061;
	bh=0ppqdJpg4KC7Ap1Vpy/8hlHSfTjr7LQJi83E3R+Yf+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AtilNI3BbSWIfGmyG3Gg3cDwt+LSQqB6Sa4Rv3RAQVDpGNSKG33v88EfXer8sZwu4
	 RrvzPJ81xe4umgV7rDRSI++1yWhUozR9AtQD4kU8kzykgow/RG3aUwfdKcNQp5Qqbm
	 Zmmy4AJ3MFuFo8/B6qbIT0MPMxBi8oD9ebWiUrxfT6ZdTx2bLdRlJlX4sHv21soBWL
	 RTazrNBxOuef4WV5Sltb+njZJKOlCO1qFZnwyWzpSmgBSInTxftlE1E63pqhvSjjo5
	 dsQ1HTeWcsDNxhfjEN2Oz+KviC2vTG69A8oQlnoEPrW65r+pHoC9gV/L9uLtvZgepm
	 ZetEJ4ccW8WeQ==
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
Subject: [PATCH AUTOSEL 5.4 4/9] drm/bridge: panel: forbid initializing a panel with unknown connector type
Date: Thu,  3 Apr 2025 15:20:45 -0400
Message-Id: <20250403192050.2682427-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403192050.2682427-1-sashal@kernel.org>
References: <20250403192050.2682427-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.291
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
index ed7985c0535a2..b81c57267a408 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -47,7 +47,7 @@ static LIST_HEAD(panel_list);
  * @dev: parent device of the panel
  * @funcs: panel operations
  * @connector_type: the connector type (DRM_MODE_CONNECTOR_*) corresponding to
- *	the panel interface
+ *	the panel interface (must NOT be DRM_MODE_CONNECTOR_Unknown)
  *
  * Initialize the panel structure for subsequent registration with
  * drm_panel_add().
@@ -55,6 +55,9 @@ static LIST_HEAD(panel_list);
 void drm_panel_init(struct drm_panel *panel, struct device *dev,
 		    const struct drm_panel_funcs *funcs, int connector_type)
 {
+	if (connector_type == DRM_MODE_CONNECTOR_Unknown)
+		DRM_WARN("%s: %s: a valid connector type is required!\n", __func__, dev_name(dev));
+
 	INIT_LIST_HEAD(&panel->list);
 	panel->dev = dev;
 	panel->funcs = funcs;
-- 
2.39.5


