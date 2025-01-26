Return-Path: <stable+bounces-110520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3192AA1C9AA
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 093DA1685EA
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B870C1E9B08;
	Sun, 26 Jan 2025 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBrwsYS4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7156C1A8401;
	Sun, 26 Jan 2025 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903251; cv=none; b=iCB3Lub/jI/ZiQjPQws78vxVCOeeWFJ8oppbuWU3hYX8YYNnldqycXSbVmIGmLgFqJOI6gxc7ykgmnHpIF2CKhSOMrwOszhKTZ4e5XtJKykF2Z09d0uwsFUTO6xBxHb3H+Z1+O6HNrfZYUcLkzIGjZl2oB1CK4eIWVF0VkxedEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903251; c=relaxed/simple;
	bh=B0wrpQlu9nAlfQPUKDXq1MRbTpeLW/jQYSjWlMnwgA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cUE5s/e9gUwQB9NhMAREOEyRawODCrW/vJJ8M+mLrTAJXxpQNnbDp2HsNVr3nRHLSqN2wNmH87SiQXrQEqDTg4sg6TrzKg2FZns/gDQ+bKFJBOAwk22daY6ND7xwCWu+PbUCQ2opnE0NIT5lEvxelCapi7/s2wseuSZbPLcosss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBrwsYS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B84C4CEE2;
	Sun, 26 Jan 2025 14:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903250;
	bh=B0wrpQlu9nAlfQPUKDXq1MRbTpeLW/jQYSjWlMnwgA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZBrwsYS4N3lK00xVAJjpnqJ2071KCjNXLCYB/2fFf2aOWmQAG/Zy2/ms6sW+0ALgN
	 66kU0tTwMepP9kauXLmhUWDD6v7MgaU0/SP4z5N9k+RRhQ1nQlIxdKnpj1sksESU4k
	 mCW5tgWbCd6lDrKtCuF+9mYRwnW31wPaWxt8tceaXnt3LmGJyELDWeGwQ0IhLBvRjO
	 jo81UJ0nJJViWLgW+DRLaIWPC2HevnpXTwC9whTxCvMk+iGNX1GJR36xTUGLVHDTRa
	 BTpMSfGGgk/dWplie05TkZcZVAvIBfEydgzOQL9oB8AyA7q9x11HaWllsABnmPlD8c
	 vzw+ozn0ktYdg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	inki.dae@samsung.com,
	sw0312.kim@samsung.com,
	kyungmin.park@samsung.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	krzk@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 18/34] drm/exynos: hdmi: use eld_mutex to protect access to connector->eld
Date: Sun, 26 Jan 2025 09:52:54 -0500
Message-Id: <20250126145310.926311-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145310.926311-1-sashal@kernel.org>
References: <20250126145310.926311-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 5e8436d334ed7f6785416447c50b42077c6503e0 ]

Reading access to connector->eld can happen at the same time the
drm_edid_to_eld() updates the data. Take the newly added eld_mutex in
order to protect connector->eld from concurrent access.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20241206-drm-connector-eld-mutex-v2-5-c9bce1ee8bea@linaro.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/exynos/exynos_hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 466a9e514aa1c..7a57d4a23e410 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -1648,7 +1648,9 @@ static int hdmi_audio_get_eld(struct device *dev, void *data, uint8_t *buf,
 	struct hdmi_context *hdata = dev_get_drvdata(dev);
 	struct drm_connector *connector = &hdata->connector;
 
+	mutex_lock(&connector->eld_mutex);
 	memcpy(buf, connector->eld, min(sizeof(connector->eld), len));
+	mutex_unlock(&connector->eld_mutex);
 
 	return 0;
 }
-- 
2.39.5


