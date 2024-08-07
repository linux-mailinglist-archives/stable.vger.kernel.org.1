Return-Path: <stable+bounces-65589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6576594AAD3
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 16:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CE951C215D6
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 14:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525957B3F3;
	Wed,  7 Aug 2024 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x6mFyBBQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109B883A09
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723042653; cv=none; b=Uy3iZxdi8nEsGHvBZSVFk+bs7IMruTLXPCfy92doudxAfnpAkGvhxDNS8rLhEtXVPqF6Nd3yIm4XHaZZbJhXNU+0kgINKt6GsMMozZiiENeHWKFsapfPFBLp8Ib+M1BC1iGmy8S7vDjq9nNsJYr4aIR8qfw3lbMUXy89GvqC7tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723042653; c=relaxed/simple;
	bh=+asPg7zOr5hXbd26vyzS4riMaFM0DqQZxWmi6t7eogM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fO5+AitLtUBjQ6VZgjuhirKtQnqn0TyWohm07VMs+Q6iwF28sV6uoJyxz42JgkteX1d18p35CzcrjvbWHI0M0Ov8LR6SgyQJZjLVN9Xf8TAnMv5zwuSLfKLh7FjNScpFKns4imfjtU8SI/XmShKyBsiI5EKNqYtCP6lrXHH0fy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x6mFyBBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515ADC32781;
	Wed,  7 Aug 2024 14:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723042652;
	bh=+asPg7zOr5hXbd26vyzS4riMaFM0DqQZxWmi6t7eogM=;
	h=Subject:To:Cc:From:Date:From;
	b=x6mFyBBQi7VZ1oDYoLRNkEEeyGlh+udQ9aPpNH8QPBnxJSqpS81fM8sye92TaeJi/
	 PMMdGhBI7FtNA2vW6QD7TBnYwI0UNZtbq7L+gU7doXLi7kyNUonqZZOOe5RrYSouqS
	 Cyh4sqEsE1th8Q4jD1sQH2lDY/XU61Rf+gMnbX1k=
Subject: FAILED: patch "[PATCH] drm/ast: astdp: Wake up during connector status detection" failed to apply to 6.6-stable tree
To: tzimmermann@suse.de,airlied@redhat.com,jfalempe@redhat.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 07 Aug 2024 16:57:30 +0200
Message-ID: <2024080729-overlord-gala-fe40@gregkh>
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
git cherry-pick -x 0ce91928ec62d189b5c51816e325f02587b53118
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024080729-overlord-gala-fe40@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

0ce91928ec62 ("drm/ast: astdp: Wake up during connector status detection")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0ce91928ec62d189b5c51816e325f02587b53118 Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed, 17 Jul 2024 16:24:16 +0200
Subject: [PATCH] drm/ast: astdp: Wake up during connector status detection

Power up the ASTDP connector for connection status detection if the
connector is not active. Keep it powered if a display is attached.

This fixes a bug where the connector does not come back after
disconnecting the display. The encoder's atomic_disable turns off
power on the physical connector. Further HPD reads will fail,
thus preventing the driver from detecting re-connected displays.

For connectors that are actively used, only test the HPD flag without
touching power.

Fixes: f81bb0ac7872 ("drm/ast: report connection status on Display Port.")
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.6+
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240717143319.104012-2-tzimmermann@suse.de

diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
index 1e9259416980..e6c7f0d64e99 100644
--- a/drivers/gpu/drm/ast/ast_dp.c
+++ b/drivers/gpu/drm/ast/ast_dp.c
@@ -158,7 +158,14 @@ void ast_dp_launch(struct drm_device *dev)
 			       ASTDP_HOST_EDID_READ_DONE);
 }
 
+bool ast_dp_power_is_on(struct ast_device *ast)
+{
+	u8 vgacre3;
 
+	vgacre3 = ast_get_index_reg(ast, AST_IO_VGACRI, 0xe3);
+
+	return !(vgacre3 & AST_DP_PHY_SLEEP);
+}
 
 void ast_dp_power_on_off(struct drm_device *dev, bool on)
 {
diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_drv.h
index ba3d86973995..47bab5596c16 100644
--- a/drivers/gpu/drm/ast/ast_drv.h
+++ b/drivers/gpu/drm/ast/ast_drv.h
@@ -472,6 +472,7 @@ void ast_init_3rdtx(struct drm_device *dev);
 bool ast_astdp_is_connected(struct ast_device *ast);
 int ast_astdp_read_edid(struct drm_device *dev, u8 *ediddata);
 void ast_dp_launch(struct drm_device *dev);
+bool ast_dp_power_is_on(struct ast_device *ast);
 void ast_dp_power_on_off(struct drm_device *dev, bool no);
 void ast_dp_set_on_off(struct drm_device *dev, bool no);
 void ast_dp_set_mode(struct drm_crtc *crtc, struct ast_vbios_mode_info *vbios_mode);
diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index dc8f639e82fd..049ee1477c33 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -28,6 +28,7 @@
  * Authors: Dave Airlie <airlied@redhat.com>
  */
 
+#include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/pci.h>
 
@@ -1687,11 +1688,35 @@ static int ast_astdp_connector_helper_detect_ctx(struct drm_connector *connector
 						 struct drm_modeset_acquire_ctx *ctx,
 						 bool force)
 {
+	struct drm_device *dev = connector->dev;
 	struct ast_device *ast = to_ast_device(connector->dev);
+	enum drm_connector_status status = connector_status_disconnected;
+	struct drm_connector_state *connector_state = connector->state;
+	bool is_active = false;
+
+	mutex_lock(&ast->modeset_lock);
+
+	if (connector_state && connector_state->crtc) {
+		struct drm_crtc_state *crtc_state = connector_state->crtc->state;
+
+		if (crtc_state && crtc_state->active)
+			is_active = true;
+	}
+
+	if (!is_active && !ast_dp_power_is_on(ast)) {
+		ast_dp_power_on_off(dev, true);
+		msleep(50);
+	}
 
 	if (ast_astdp_is_connected(ast))
-		return connector_status_connected;
-	return connector_status_disconnected;
+		status = connector_status_connected;
+
+	if (!is_active && status == connector_status_disconnected)
+		ast_dp_power_on_off(dev, false);
+
+	mutex_unlock(&ast->modeset_lock);
+
+	return status;
 }
 
 static const struct drm_connector_helper_funcs ast_astdp_connector_helper_funcs = {


