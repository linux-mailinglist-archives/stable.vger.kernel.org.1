Return-Path: <stable+bounces-23635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8AC867135
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 11:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9EAB1F2DC63
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658641EB2B;
	Mon, 26 Feb 2024 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jLhirKwI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263B9EEDA
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 10:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942966; cv=none; b=IjcoxGcLXbe6puqjxudKlyX2IYDc8htCQgdQ/7mX3stCsTh5q0VclmaNM5O2rp24CRgPlItAHaOFBnaNWZWJdcu/IzPXOS80HoP8JFAE96gsOf3lazNgKrlytNZ6OaU9lStp6pg2UQG0danfGL2ImPGfSEvK6v36XW5lt8VORG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942966; c=relaxed/simple;
	bh=dJbLxgX8HG4PQdo3uf7haAj7Kyn3ttm2fBatAhsimP0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MFtH8G+oqG8aLf3jANYybxRbZBr0NY4Jbrw6GePAgpvpgCosFgXdktARCM8IIOaMscAOTVOHpdy+Epsp/z5VnDc5ll4X6etTXwWinrKN58bIe1ckyS8ih6YztpzyQXjHzmRyWKgEZzvCtpsh7d+cEzthk3BhRMqb6S9Wrks1xkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jLhirKwI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B881C433F1;
	Mon, 26 Feb 2024 10:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708942965;
	bh=dJbLxgX8HG4PQdo3uf7haAj7Kyn3ttm2fBatAhsimP0=;
	h=Subject:To:Cc:From:Date:From;
	b=jLhirKwItI8NDHukMvOfYWLirlWSbNmUKC3MAQbApbwKMRyrAEQYSDup9NVYPGw+4
	 c2uCWBqSHUJjBXnaeeWBDwfx/VGOAbS5d5JECZasQnBCdI7lzS02ZEs8VbslPI6m8J
	 3vxn+gdtGKk+audIU2SEdkWt+/AkH3SLPdYbOgtU=
Subject: FAILED: patch "[PATCH] drm/meson: Don't remove bridges which are created by other" failed to apply to 6.1-stable tree
To: martin.blumenstingl@googlemail.com,neil.armstrong@linaro.org,stable@vger.kernel.org,stevemorvai@hotmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Feb 2024 11:22:43 +0100
Message-ID: <2024022642-retool-clover-ecd7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x bd915ae73a2d78559b376ad2caf5e4ef51de2455
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024022642-retool-clover-ecd7@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

bd915ae73a2d ("drm/meson: Don't remove bridges which are created by other drivers")
42dcf15f901c ("drm/meson: add DSI encoder")
6a044642988b ("drm/meson: fix unbind path if HDMI fails to bind")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bd915ae73a2d78559b376ad2caf5e4ef51de2455 Mon Sep 17 00:00:00 2001
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Thu, 15 Feb 2024 23:04:42 +0100
Subject: [PATCH] drm/meson: Don't remove bridges which are created by other
 drivers

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

diff --git a/drivers/gpu/drm/meson/meson_encoder_cvbs.c b/drivers/gpu/drm/meson/meson_encoder_cvbs.c
index 3f73b211fa8e..3407450435e2 100644
--- a/drivers/gpu/drm/meson/meson_encoder_cvbs.c
+++ b/drivers/gpu/drm/meson/meson_encoder_cvbs.c
@@ -294,6 +294,5 @@ void meson_encoder_cvbs_remove(struct meson_drm *priv)
 	if (priv->encoders[MESON_ENC_CVBS]) {
 		meson_encoder_cvbs = priv->encoders[MESON_ENC_CVBS];
 		drm_bridge_remove(&meson_encoder_cvbs->bridge);
-		drm_bridge_remove(meson_encoder_cvbs->next_bridge);
 	}
 }
diff --git a/drivers/gpu/drm/meson/meson_encoder_dsi.c b/drivers/gpu/drm/meson/meson_encoder_dsi.c
index 3f93c70488ca..311b91630fbe 100644
--- a/drivers/gpu/drm/meson/meson_encoder_dsi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_dsi.c
@@ -168,6 +168,5 @@ void meson_encoder_dsi_remove(struct meson_drm *priv)
 	if (priv->encoders[MESON_ENC_DSI]) {
 		meson_encoder_dsi = priv->encoders[MESON_ENC_DSI];
 		drm_bridge_remove(&meson_encoder_dsi->bridge);
-		drm_bridge_remove(meson_encoder_dsi->next_bridge);
 	}
 }
diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
index 25ea76558690..c4686568c9ca 100644
--- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
@@ -474,6 +474,5 @@ void meson_encoder_hdmi_remove(struct meson_drm *priv)
 	if (priv->encoders[MESON_ENC_HDMI]) {
 		meson_encoder_hdmi = priv->encoders[MESON_ENC_HDMI];
 		drm_bridge_remove(&meson_encoder_hdmi->bridge);
-		drm_bridge_remove(meson_encoder_hdmi->next_bridge);
 	}
 }


