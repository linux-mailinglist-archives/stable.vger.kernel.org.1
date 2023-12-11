Return-Path: <stable+bounces-5491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E1580CCC4
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 15:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDFD2281ACA
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EC448799;
	Mon, 11 Dec 2023 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKNyHxF5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992AA482F3;
	Mon, 11 Dec 2023 14:03:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1290DC433C8;
	Mon, 11 Dec 2023 14:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702303402;
	bh=55IWi7q/c+xuk9m4sVnI8Kz2vIQE5t0toHxv97SDJPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DKNyHxF5vxGsKeVNkXbvEBYlQ00ah88OIApFAJvyTD+qohhND8Y/A24OTNUxrkam6
	 zkoaVG8F5RvTxpIY0sWrHp+qlenBlyhFPsRfAZJ2soOQ6rvuODdEFQh8H7CwAHzUPU
	 UvAgGfwILKJDZx6xe6yIZdoFbeeOkegSqY+a07XsG+7cWDbesAkSXf2uXIYEcYWzuw
	 xk+BgSa1VmFzetV6m8L26p66oXkQmy1a2UVDoeQfCjd4Fp6c/N2KGqFxZKcmedpFcD
	 zHA75qwRDqpaIuxZKXeezt4NXsg0Lwj7DqLFsIw40d9FKmmFWp+9uyDZlnkvI9GMay
	 CGieNieVSmG/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiang Yang <xiangyang3@huawei.com>,
	Inki Dae <inki.dae@samsung.com>,
	Sasha Levin <sashal@kernel.org>,
	sw0312.kim@samsung.com,
	kyungmin.park@samsung.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	krzysztof.kozlowski@linaro.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 5/5] drm/exynos: fix a potential error pointer dereference
Date: Mon, 11 Dec 2023 09:03:10 -0500
Message-ID: <20231211140311.392827-5-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211140311.392827-1-sashal@kernel.org>
References: <20231211140311.392827-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.332
Content-Transfer-Encoding: 8bit

From: Xiang Yang <xiangyang3@huawei.com>

[ Upstream commit 73bf1c9ae6c054c53b8e84452c5e46f86dd28246 ]

Smatch reports the warning below:
drivers/gpu/drm/exynos/exynos_hdmi.c:1864 hdmi_bind()
error: 'crtc' dereferencing possible ERR_PTR()

The return value of exynos_drm_crtc_get_by_type maybe ERR_PTR(-ENODEV),
which can not be used directly. Fix this by checking the return value
before using it.

Signed-off-by: Xiang Yang <xiangyang3@huawei.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/exynos/exynos_hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 0109ff40b1db2..3d79a7af8c862 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -1722,6 +1722,8 @@ static int hdmi_bind(struct device *dev, struct device *master, void *data)
 		return ret;
 
 	crtc = exynos_drm_crtc_get_by_type(drm_dev, EXYNOS_DISPLAY_TYPE_HDMI);
+	if (IS_ERR(crtc))
+		return PTR_ERR(crtc);
 	crtc->pipe_clk = &hdata->phy_clk;
 
 	ret = hdmi_create_connector(encoder);
-- 
2.42.0


