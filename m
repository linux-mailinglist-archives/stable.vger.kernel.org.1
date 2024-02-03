Return-Path: <stable+bounces-18514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD4B848306
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8A71F229E1
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA791CA9B;
	Sat,  3 Feb 2024 04:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p7E5ANjz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA06111193;
	Sat,  3 Feb 2024 04:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933855; cv=none; b=Rh7WUiysI6kNL+dZjqoYit1xcJVDnMOnC2p9PtPkMT22USN2qWUo9GuIo6K03XMaZfyZDR7l/wNEwADSN+OgZedOdm54kSvUjLNofKuokg15zdeP1mgne0xt2BqmqwcLQN9KDBu/pZpWibajiBMa7MGiecvdcO132pnBtnFZak4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933855; c=relaxed/simple;
	bh=gxhuNjXhEj1RIXAPqYIIUoow5mRZzFJ16DM5RZgTZ5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hu2TexyFxakztMbEO4cimCpjS4bmqA6n36gbkwYfljuGWYjzYE0UpTjDwaN9Gj0e0Ivu/T+U3TV2mq4kFXrmhGj4HB4qhDSPaPjKrUy6hAOetNUtHxhINdVznDkubuG2Rf+NUlw2pMJB381om/5tbFQLfaBCEMPRSrjee6iyqyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p7E5ANjz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7251FC433F1;
	Sat,  3 Feb 2024 04:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933855;
	bh=gxhuNjXhEj1RIXAPqYIIUoow5mRZzFJ16DM5RZgTZ5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p7E5ANjzFd7K538gM1AZk2PmAwWBZ28L6yALzUGRwp2M0UXifGJHxFcY13pImS84x
	 TE/F2HEgX3mS9i2jQ0KaEBjKFLp0MqsKb25qKfNMsCgtV0XttuedYyMd727UoyVc6o
	 TsgUUPdkJyprfYz6GWadzE/ZjqerqTv7xsKCDAYE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 169/353] drm/panel-edp: Add override_edid_mode quirk for generic edp
Date: Fri,  2 Feb 2024 20:04:47 -0800
Message-ID: <20240203035408.991272785@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035403.657508530@linuxfoundation.org>
References: <20240203035403.657508530@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hsin-Yi Wang <hsinyi@chromium.org>

[ Upstream commit 9f7843b515811aea6c56527eb195b622e9c01f12 ]

Generic edp gets mode from edid. However, some panels report incorrect
mode in this way, resulting in glitches on panel. Introduce a new quirk
additional_mode to the generic edid to pick a correct hardcoded mode.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20231117215056.1883314-2-hsinyi@chromium.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 48 +++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 7dc6fb7308ce..cba5a93e6082 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -203,6 +203,9 @@ struct edp_panel_entry {
 
 	/** @name: Name of this panel (for printing to logs). */
 	const char *name;
+
+	/** @override_edid_mode: Override the mode obtained by edid. */
+	const struct drm_display_mode *override_edid_mode;
 };
 
 struct panel_edp {
@@ -301,6 +304,24 @@ static unsigned int panel_edp_get_display_modes(struct panel_edp *panel,
 	return num;
 }
 
+static int panel_edp_override_edid_mode(struct panel_edp *panel,
+					struct drm_connector *connector,
+					const struct drm_display_mode *override_mode)
+{
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(connector->dev, override_mode);
+	if (!mode) {
+		dev_err(panel->base.dev, "failed to add additional mode\n");
+		return 0;
+	}
+
+	mode->type |= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+	drm_mode_set_name(mode);
+	drm_mode_probed_add(connector, mode);
+	return 1;
+}
+
 static int panel_edp_get_non_edid_modes(struct panel_edp *panel,
 					struct drm_connector *connector)
 {
@@ -568,6 +589,9 @@ static int panel_edp_get_modes(struct drm_panel *panel,
 {
 	struct panel_edp *p = to_panel_edp(panel);
 	int num = 0;
+	bool has_override_edid_mode = p->detected_panel &&
+				      p->detected_panel != ERR_PTR(-EINVAL) &&
+				      p->detected_panel->override_edid_mode;
 
 	/* probe EDID if a DDC bus is available */
 	if (p->ddc) {
@@ -575,9 +599,18 @@ static int panel_edp_get_modes(struct drm_panel *panel,
 
 		if (!p->edid)
 			p->edid = drm_get_edid(connector, p->ddc);
-
-		if (p->edid)
-			num += drm_add_edid_modes(connector, p->edid);
+		if (p->edid) {
+			if (has_override_edid_mode) {
+				/*
+				 * override_edid_mode is specified. Use
+				 * override_edid_mode instead of from edid.
+				 */
+				num += panel_edp_override_edid_mode(p, connector,
+						p->detected_panel->override_edid_mode);
+			} else {
+				num += drm_add_edid_modes(connector, p->edid);
+			}
+		}
 
 		pm_runtime_mark_last_busy(panel->dev);
 		pm_runtime_put_autosuspend(panel->dev);
@@ -1830,6 +1863,15 @@ static const struct panel_delay delay_200_500_e200 = {
 	.delay = _delay \
 }
 
+#define EDP_PANEL_ENTRY2(vend_chr_0, vend_chr_1, vend_chr_2, product_id, _delay, _name, _mode) \
+{ \
+	.name = _name, \
+	.panel_id = drm_edid_encode_panel_id(vend_chr_0, vend_chr_1, vend_chr_2, \
+					     product_id), \
+	.delay = _delay, \
+	.override_edid_mode = _mode \
+}
+
 /*
  * This table is used to figure out power sequencing delays for panels that
  * are detected by EDID. Entries here may point to entries in the
-- 
2.43.0




