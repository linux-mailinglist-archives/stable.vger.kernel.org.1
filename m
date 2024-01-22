Return-Path: <stable+bounces-15159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 944F2838424
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4264A298127
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A35867E69;
	Tue, 23 Jan 2024 02:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FRR0YUQL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC24D67E81;
	Tue, 23 Jan 2024 02:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975313; cv=none; b=dAxvI6gu0AcOtRl+ZGf7L7407a0HzM1yh84PZgVt69wsedS1pPw2fs+3ZdApKdgcORVDKyfQNUbr1wqo/gxypkq3eYuJ0EZj1Jmrhq4Gz5M00KA5KPudPKoMl1fYQtErUXep6Jfu1N1TkxGnLWM8SbqsHtRmbPOE5IMyHUgc1es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975313; c=relaxed/simple;
	bh=pfjLIvadHTNTfKQKHSYTcOlvEAzBSeEWPgUcA+b567Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lul7546yRLUrk1m6FfwUFoO82QHjqpt4kRp4RhJu3svfRaB0335ZiwTkHrb/DdCCu/sixh+QDQL+MbcmYivzLQg6ddORiYRqVAEfqntGCz6O0fLAvis/sdCcfoC2x+icY6l98m8A8Fz7owLlN2JbS7bTjkuzoeFrZwNkcbfwMg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FRR0YUQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0D7C433C7;
	Tue, 23 Jan 2024 02:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975312;
	bh=pfjLIvadHTNTfKQKHSYTcOlvEAzBSeEWPgUcA+b567Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FRR0YUQL7/vZzGfwH+i3SNMmAX2hWHoWdEXprK2iw4GJoVqCf4y9AeGxgyRTQTqHs
	 w5gq7Ln89ZKizzKtXuWGKWee5Ppy1eq9ITn2KLeOmCcAOHlGsXfpBhqWCha3HtozDa
	 9M99N4r/JOHc0WkqsebkaikN13DSbFovP/P2szro=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 253/583] drm/drv: propagate errors from drm_modeset_register_all()
Date: Mon, 22 Jan 2024 15:55:04 -0800
Message-ID: <20240122235819.745022369@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 5f8dec200923a76dc57187965fd59c1136f5d085 ]

In case the drm_modeset_register_all() function fails, its error code
will be ignored. Instead make the drm_dev_register() bail out in case of
such an error.

Fixes: 79190ea2658a ("drm: Add callbacks for late registering")
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20231202225552.1283638-1-dmitry.baryshkov@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_drv.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 3eda026ffac6..71bb8806dc5f 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -940,8 +940,11 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
 			goto err_minors;
 	}
 
-	if (drm_core_check_feature(dev, DRIVER_MODESET))
-		drm_modeset_register_all(dev);
+	if (drm_core_check_feature(dev, DRIVER_MODESET)) {
+		ret = drm_modeset_register_all(dev);
+		if (ret)
+			goto err_unload;
+	}
 
 	DRM_INFO("Initialized %s %d.%d.%d %s for %s on minor %d\n",
 		 driver->name, driver->major, driver->minor,
@@ -951,6 +954,9 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
 
 	goto out_unlock;
 
+err_unload:
+	if (dev->driver->unload)
+		dev->driver->unload(dev);
 err_minors:
 	remove_compat_control_link(dev);
 	drm_minor_unregister(dev, DRM_MINOR_ACCEL);
-- 
2.43.0




