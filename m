Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF9073532A
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjFSKmT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjFSKmC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:42:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483F9E9
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:42:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFEA260B0D
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EF0C433C8;
        Mon, 19 Jun 2023 10:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171320;
        bh=mDHQl2fzf6LF6MB2xqHKJZ/VQI5LQYAYQ5VVNRFni0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kldz/6gdmSWk373w7Tus0esm//zXwES1Po7cqnteyog6Ns6VUnzztrEby9eQdoiCs
         PLvjvrfmPfW20vM7T3yS2+/qADE24+DNJLd2oJnbC/Ja0zIfvQKq5w4u17378IFFQK
         XFTzSjryltocGZOfa5/CbwFd+hbrzT8w/Mto6FBQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lyude Paul <lyude@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 39/49] drm/nouveau/kms: Dont change EDID when it hasnt actually changed
Date:   Mon, 19 Jun 2023 12:30:17 +0200
Message-ID: <20230619102131.968584952@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102129.856988902@linuxfoundation.org>
References: <20230619102129.856988902@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Lyude Paul <lyude@redhat.com>

[ Upstream commit f28e32d3906eac2e1cb3291b448f0d528ec93996 ]

Currently in nouveau_connector_ddc_detect() and
nouveau_connector_detect_lvds(), we start the connector probing process
by releasing the previous EDID and informing DRM of the change. However,
since commit 5186421cbfe2 ("drm: Introduce epoch counter to
drm_connector") drm_connector_update_edid_property() actually checks
whether the new EDID we've specified is different from the previous one,
and updates the connector's epoch accordingly if it is. But, because we
always set the EDID to NULL first in nouveau_connector_ddc_detect() and
nouveau_connector_detect_lvds() we end up making DRM think that the EDID
changes every single time we do a connector probe - which isn't needed.

So, let's fix this by not clearing the EDID at the start of the
connector probing process, and instead simply changing or removing it
once near the end of the probing process. This will help prevent us from
sending unneeded hotplug events to userspace when nothing has actually
changed.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Ben Skeggs <bskeggs@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200826182456.322681-19-lyude@redhat.com
Stable-dep-of: 55b94bb8c424 ("drm/nouveau: add nv_encoder pointer check for NULL")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 54 ++++++++++-----------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 0327456913e11..c6d6ce9af2565 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -521,6 +521,17 @@ nouveau_connector_set_encoder(struct drm_connector *connector,
 	}
 }
 
+static void
+nouveau_connector_set_edid(struct nouveau_connector *nv_connector,
+			   struct edid *edid)
+{
+	struct edid *old_edid = nv_connector->edid;
+
+	drm_connector_update_edid_property(&nv_connector->base, edid);
+	kfree(old_edid);
+	nv_connector->edid = edid;
+}
+
 static enum drm_connector_status
 nouveau_connector_detect(struct drm_connector *connector, bool force)
 {
@@ -534,13 +545,6 @@ nouveau_connector_detect(struct drm_connector *connector, bool force)
 	int ret;
 	enum drm_connector_status conn_status = connector_status_disconnected;
 
-	/* Cleanup the previous EDID block. */
-	if (nv_connector->edid) {
-		drm_connector_update_edid_property(connector, NULL);
-		kfree(nv_connector->edid);
-		nv_connector->edid = NULL;
-	}
-
 	/* Outputs are only polled while runtime active, so resuming the
 	 * device here is unnecessary (and would deadlock upon runtime suspend
 	 * because it waits for polling to finish). We do however, want to
@@ -553,22 +557,23 @@ nouveau_connector_detect(struct drm_connector *connector, bool force)
 		ret = pm_runtime_get_sync(dev->dev);
 		if (ret < 0 && ret != -EACCES) {
 			pm_runtime_put_autosuspend(dev->dev);
+			nouveau_connector_set_edid(nv_connector, NULL);
 			return conn_status;
 		}
 	}
 
 	nv_encoder = nouveau_connector_ddc_detect(connector);
 	if (nv_encoder && (i2c = nv_encoder->i2c) != NULL) {
+		struct edid *new_edid;
+
 		if ((vga_switcheroo_handler_flags() &
 		     VGA_SWITCHEROO_CAN_SWITCH_DDC) &&
 		    nv_connector->type == DCB_CONNECTOR_LVDS)
-			nv_connector->edid = drm_get_edid_switcheroo(connector,
-								     i2c);
+			new_edid = drm_get_edid_switcheroo(connector, i2c);
 		else
-			nv_connector->edid = drm_get_edid(connector, i2c);
+			new_edid = drm_get_edid(connector, i2c);
 
-		drm_connector_update_edid_property(connector,
-							nv_connector->edid);
+		nouveau_connector_set_edid(nv_connector, new_edid);
 		if (!nv_connector->edid) {
 			NV_ERROR(drm, "DDC responded, but no EDID for %s\n",
 				 connector->name);
@@ -601,6 +606,8 @@ nouveau_connector_detect(struct drm_connector *connector, bool force)
 		nouveau_connector_set_encoder(connector, nv_encoder);
 		conn_status = connector_status_connected;
 		goto out;
+	} else {
+		nouveau_connector_set_edid(nv_connector, NULL);
 	}
 
 	nv_encoder = nouveau_connector_of_detect(connector);
@@ -643,18 +650,12 @@ nouveau_connector_detect_lvds(struct drm_connector *connector, bool force)
 	struct nouveau_drm *drm = nouveau_drm(dev);
 	struct nouveau_connector *nv_connector = nouveau_connector(connector);
 	struct nouveau_encoder *nv_encoder = NULL;
+	struct edid *edid = NULL;
 	enum drm_connector_status status = connector_status_disconnected;
 
-	/* Cleanup the previous EDID block. */
-	if (nv_connector->edid) {
-		drm_connector_update_edid_property(connector, NULL);
-		kfree(nv_connector->edid);
-		nv_connector->edid = NULL;
-	}
-
 	nv_encoder = find_encoder(connector, DCB_OUTPUT_LVDS);
 	if (!nv_encoder)
-		return connector_status_disconnected;
+		goto out;
 
 	/* Try retrieving EDID via DDC */
 	if (!drm->vbios.fp_no_ddc) {
@@ -673,7 +674,8 @@ nouveau_connector_detect_lvds(struct drm_connector *connector, bool force)
 	 * valid - it's not (rh#613284)
 	 */
 	if (nv_encoder->dcb->lvdsconf.use_acpi_for_edid) {
-		if ((nv_connector->edid = nouveau_acpi_edid(dev, connector))) {
+		edid = nouveau_acpi_edid(dev, connector);
+		if (edid) {
 			status = connector_status_connected;
 			goto out;
 		}
@@ -693,12 +695,10 @@ nouveau_connector_detect_lvds(struct drm_connector *connector, bool force)
 	 * stored for the panel stored in them.
 	 */
 	if (!drm->vbios.fp_no_ddc) {
-		struct edid *edid =
-			(struct edid *)nouveau_bios_embedded_edid(dev);
+		edid = (struct edid *)nouveau_bios_embedded_edid(dev);
 		if (edid) {
-			nv_connector->edid =
-					kmemdup(edid, EDID_LENGTH, GFP_KERNEL);
-			if (nv_connector->edid)
+			edid = kmemdup(edid, EDID_LENGTH, GFP_KERNEL);
+			if (edid)
 				status = connector_status_connected;
 		}
 	}
@@ -711,7 +711,7 @@ nouveau_connector_detect_lvds(struct drm_connector *connector, bool force)
 		status = connector_status_unknown;
 #endif
 
-	drm_connector_update_edid_property(connector, nv_connector->edid);
+	nouveau_connector_set_edid(nv_connector, edid);
 	nouveau_connector_set_encoder(connector, nv_encoder);
 	return status;
 }
-- 
2.39.2



