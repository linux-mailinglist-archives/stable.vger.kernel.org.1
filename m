Return-Path: <stable+bounces-24071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 409B8869322
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12FB9B2DC41
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5128A13B295;
	Tue, 27 Feb 2024 13:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vSGxrR13"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8BC1E534;
	Tue, 27 Feb 2024 13:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040953; cv=none; b=dTPd4RBTFKM8fRcgicM5V/aBBlH13WNgQj1xASGpVVoR62zQ+ezT371Rt/g14N/rlH664hSLJlMv7g50mfU73U/6FdgBJbfjAirAuvwv7yOv4yaXIgmEjwfX69Ig04x0RWAsaqw9LeA0UcwD4BCof5Wq9iJVTVTyPAtJTc9hkZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040953; c=relaxed/simple;
	bh=BTCsDAy9rL1CgMN1yJVlaLUW8vvUW0Lcf9DW6Q6d7GE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNUaH2KqZwwF/qujCwa+Z3WIBOc+JyBJTzKJruSIULreljq/TgrOIFWZ2VvhTjwJACZHa59s37sXXHqjI5awfbNmUA8R/Eu8Nb5wvisBRoQuwh/PxXpsLvoGHFb1/ldwreI8rMPKXMto3fxn3DRCuvxdkLwY23KgfesFM4PBYRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vSGxrR13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9093CC433C7;
	Tue, 27 Feb 2024 13:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709040952;
	bh=BTCsDAy9rL1CgMN1yJVlaLUW8vvUW0Lcf9DW6Q6d7GE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vSGxrR13tSZLMpqUfnNPvIfch0dwFjo6HWvnxC0+Hm6SxjLr0QR8sgCc3L2Fo6Kqh
	 TVzvhjCzr4gzeWftsYG5xsp6crjl55BpQdashbeHj7uqfzYJegUAO4SGHJDlZW1oh8
	 1WzGK81kSv+KSrfZ15R5fvkgHjMfPUfTFcFH78Ns=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steve Morvai <stevemorvai@hotmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 6.7 149/334] drm/meson: Dont remove bridges which are created by other drivers
Date: Tue, 27 Feb 2024 14:20:07 +0100
Message-ID: <20240227131635.260335900@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
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

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

commit bd915ae73a2d78559b376ad2caf5e4ef51de2455 upstream.

Stop calling drm_bridge_remove() for bridges allocated/managed by other
drivers in the remove paths of meson_encoder_{cvbs,dsi,hdmi}.
drm_bridge_remove() unregisters the bridge so it cannot be used
anymore. Doing so for bridges we don't own can lead to the video
pipeline not being able to come up after -EPROBE_DEFER of the VPU
because we're unregistering a bridge that's managed by another driver.
The other driver doesn't know that we have unregistered it's bridge
and on subsequent .probe() we're not able to find those bridges anymore
(since nobody re-creates them).

This fixes probe errors on Meson8b boards with the CVBS outputs enabled.

Fixes: 09847723c12f ("drm/meson: remove drm bridges at aggregate driver unbind time")
Fixes: 42dcf15f901c ("drm/meson: add DSI encoder")
Cc:  <stable@vger.kernel.org>
Reported-by: Steve Morvai <stevemorvai@hotmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Steve Morvai <stevemorvai@hotmail.com>
Link: https://lore.kernel.org/r/20240215220442.1343152-1-martin.blumenstingl@googlemail.com
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240215220442.1343152-1-martin.blumenstingl@googlemail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/meson/meson_encoder_cvbs.c |    1 -
 drivers/gpu/drm/meson/meson_encoder_dsi.c  |    1 -
 drivers/gpu/drm/meson/meson_encoder_hdmi.c |    1 -
 3 files changed, 3 deletions(-)

--- a/drivers/gpu/drm/meson/meson_encoder_cvbs.c
+++ b/drivers/gpu/drm/meson/meson_encoder_cvbs.c
@@ -294,6 +294,5 @@ void meson_encoder_cvbs_remove(struct me
 	if (priv->encoders[MESON_ENC_CVBS]) {
 		meson_encoder_cvbs = priv->encoders[MESON_ENC_CVBS];
 		drm_bridge_remove(&meson_encoder_cvbs->bridge);
-		drm_bridge_remove(meson_encoder_cvbs->next_bridge);
 	}
 }
--- a/drivers/gpu/drm/meson/meson_encoder_dsi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_dsi.c
@@ -168,6 +168,5 @@ void meson_encoder_dsi_remove(struct mes
 	if (priv->encoders[MESON_ENC_DSI]) {
 		meson_encoder_dsi = priv->encoders[MESON_ENC_DSI];
 		drm_bridge_remove(&meson_encoder_dsi->bridge);
-		drm_bridge_remove(meson_encoder_dsi->next_bridge);
 	}
 }
--- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
@@ -474,6 +474,5 @@ void meson_encoder_hdmi_remove(struct me
 	if (priv->encoders[MESON_ENC_HDMI]) {
 		meson_encoder_hdmi = priv->encoders[MESON_ENC_HDMI];
 		drm_bridge_remove(&meson_encoder_hdmi->bridge);
-		drm_bridge_remove(meson_encoder_hdmi->next_bridge);
 	}
 }



