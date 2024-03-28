Return-Path: <stable+bounces-26279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4FE870DDD
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED74B288E06
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B1878B69;
	Mon,  4 Mar 2024 21:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MPzKwmKs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C2F10A35;
	Mon,  4 Mar 2024 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588307; cv=none; b=sBEj4T8prr58I+fHrtDIcHpnhPqN1IC28vwfIW7zDC+o6RJtTcmHrVwgV8DcLgsCxtgHhqzXtxhDYmy2HMSqmFgCRlfOOqlW1UD/OPDOrsh5Chv+6kwaUuyMO800znCdgEY3cFs9gh1EmwbwD3/UEad7dgtBk+4h9CDO+pyy+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588307; c=relaxed/simple;
	bh=4E65vfBBwmo6mUT2PSlZX5jz52v9C0GnIDqsKnJHM28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQdsRAUwovauuVXLwHXN/6ZI2qcCRTzHxqh+r5ZxZuLjD8V6Ey1wC1eNSDs8VcmL5tqRtggpr2ik5uI0D+JQLqC4QOdYYt32HJPf6HAfU4XlBuKxRKWMZS5XNLOwhpdDUcU7kZCpsLn+gs7/+K/aH5HETWFMtEDcRm8IL1zE43E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MPzKwmKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47503C433C7;
	Mon,  4 Mar 2024 21:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588307;
	bh=4E65vfBBwmo6mUT2PSlZX5jz52v9C0GnIDqsKnJHM28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MPzKwmKskUJVaBfxshYsfMik7KcRHBjdhYLcP2XZr6wh8hNAdUKEjgDvArtPfJxFD
	 0q5zWt/nvPMrf636yYvUyhWTkA7tP+Ta8xqWaUEdcd8WtQuVwstUue+gUL0wDM5D+k
	 0anjwepDK2+ycGGYawhA4LSYiN+FJUhSP0acjofY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thierry Reding <treding@nvidia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Robert Foss <rfoss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 058/143] drm/tegra: Remove existing framebuffer only if we support display
Date: Mon,  4 Mar 2024 21:22:58 +0000
Message-ID: <20240304211551.780301252@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211549.876981797@linuxfoundation.org>
References: <20240304211549.876981797@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thierry Reding <treding@nvidia.com>

[ Upstream commit 86bf8cfda6d2a6720fa2e6e676c98f0882c9d3d7 ]

Tegra DRM doesn't support display on Tegra234 and later, so make sure
not to remove any existing framebuffers in that case.

v2: - add comments explaining how this situation can come about
    - clear DRIVER_MODESET and DRIVER_ATOMIC feature bits

Fixes: 6848c291a54f ("drm/aperture: Convert drivers to aperture interfaces")
Signed-off-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240223150333.1401582-1-thierry.reding@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/drm.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index ff36171c8fb70..373bcd79257e0 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -1242,9 +1242,26 @@ static int host1x_drm_probe(struct host1x_device *dev)
 
 	drm_mode_config_reset(drm);
 
-	err = drm_aperture_remove_framebuffers(&tegra_drm_driver);
-	if (err < 0)
-		goto hub;
+	/*
+	 * Only take over from a potential firmware framebuffer if any CRTCs
+	 * have been registered. This must not be a fatal error because there
+	 * are other accelerators that are exposed via this driver.
+	 *
+	 * Another case where this happens is on Tegra234 where the display
+	 * hardware is no longer part of the host1x complex, so this driver
+	 * will not expose any modesetting features.
+	 */
+	if (drm->mode_config.num_crtc > 0) {
+		err = drm_aperture_remove_framebuffers(&tegra_drm_driver);
+		if (err < 0)
+			goto hub;
+	} else {
+		/*
+		 * Indicate to userspace that this doesn't expose any display
+		 * capabilities.
+		 */
+		drm->driver_features &= ~(DRIVER_MODESET | DRIVER_ATOMIC);
+	}
 
 	err = drm_dev_register(drm, 0);
 	if (err < 0)
-- 
2.43.0




