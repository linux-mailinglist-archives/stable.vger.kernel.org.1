Return-Path: <stable+bounces-110574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5A7A1CA06
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7119A1887E53
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC8A1FDA7C;
	Sun, 26 Jan 2025 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RARSzoL4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3051FDA6B;
	Sun, 26 Jan 2025 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903390; cv=none; b=n5rlgOxzclcpMXidtCP+jommVCnx+0UycoKJonZwabrdFUetHtm3ZwRD5ovPPFDgBjWk6TVc6NTpJJb/sBiVeNLV7ldH5SPIjv9riS521wTO8F5m28ps+VhIWEw2iAkgSj8Le0XiXeI4do9EukJ+Wswwzm0wt6J+SPtIAV6YYas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903390; c=relaxed/simple;
	bh=rKjdflqKaUrBhadVCes7Fb1j0AXYCBiuqJiTDLCBTzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UkaIS42TleaTmmTwlLVUHTrzjCuMw7ASDZpCyW4rYgBtjCGpNCbDibK3c0et3M4c4eLnryeC5oCiFPMl3SFCtCEAqD/5cNgeBfnej34rSZ+Nq4R+pMEe2+ezazplzdMiyhh1d38hBQspiHoCcOgsHDKQjnZu3Q3cj9R1rr6C9eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RARSzoL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA42C4CEE4;
	Sun, 26 Jan 2025 14:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903390;
	bh=rKjdflqKaUrBhadVCes7Fb1j0AXYCBiuqJiTDLCBTzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RARSzoL4upL6qGfASz69J7j0dgQoArIAz64e+S6uSLLPfpTAyvppDusXOP25nIT7X
	 1N8kP8Cfj4BHJmTuvHLn6z0xToIVwZ8GB/Oa+S6IKFmTzh+4aoxM3k4VXcL5TL4ZJi
	 k6vL0IDA6dxLSKTALcWgZF5odOlZ8m117BRbZ4RPVAmBOkp4vB1BfkzqqLkOmRJEkR
	 FWSNIhJ4MsjioZiuAvNn/eV8L7IP+72kKuQE+BSvYyWKMKhbEl8FOGYt/RyAFxeMJU
	 rvhVhNIlyRCeePUCNGP/ml2gVZ7iW0W2iBFFFj4TxVnYdsRuI3asAwwwi/EVW7Puxw
	 BbBidaYRz1GBg==
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
Subject: [PATCH AUTOSEL 6.6 07/17] drm/exynos: hdmi: use eld_mutex to protect access to connector->eld
Date: Sun, 26 Jan 2025 09:56:02 -0500
Message-Id: <20250126145612.937679-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145612.937679-1-sashal@kernel.org>
References: <20250126145612.937679-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
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
index 906133331a442..c234f9245b144 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -1643,7 +1643,9 @@ static int hdmi_audio_get_eld(struct device *dev, void *data, uint8_t *buf,
 	struct hdmi_context *hdata = dev_get_drvdata(dev);
 	struct drm_connector *connector = &hdata->connector;
 
+	mutex_lock(&connector->eld_mutex);
 	memcpy(buf, connector->eld, min(sizeof(connector->eld), len));
+	mutex_unlock(&connector->eld_mutex);
 
 	return 0;
 }
-- 
2.39.5


