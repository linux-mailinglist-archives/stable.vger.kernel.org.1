Return-Path: <stable+bounces-17286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 735E0841092
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F05D28713F
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8CB76C66;
	Mon, 29 Jan 2024 17:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PfSUoI42"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B83176C62;
	Mon, 29 Jan 2024 17:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548647; cv=none; b=g1SedZCQJWYlyQ0Q1FgI4W9gaT+rnBWKYusrF5MXhAtndn3y4KzhdxGaSHwglec9lemYRpTFCYx1U20OffhFUzHJtkFUw1bO33XzdRIADsy5QqvvPwYgjhqMD8k1Awj6rckfXgXDHVcLMXF7rd+Uq6AY0l7Ds23qmQAhIgy4IB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548647; c=relaxed/simple;
	bh=S3pZbW/ex1O8SR4Qx9ZRT5V3z2r9BHAY/omvmbGlR+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EU+fTBQWd6hXnTSTQyabKdv8XbjSO1SfwvbIhua4nrCUX/NEeJ4skxlSToUiTJ8c/nwaEtV629N63sfvMl/FrpyzGPBBbMisHTMhMqDxabmkQDADv0Bp/udvKw7xIOll3m6a3zmAlMzqlt/ADHQE1aokMe8bLWaVANgLOw+iFf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PfSUoI42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7686C433F1;
	Mon, 29 Jan 2024 17:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548646;
	bh=S3pZbW/ex1O8SR4Qx9ZRT5V3z2r9BHAY/omvmbGlR+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PfSUoI42E8V06+0hYpM2fOmlSDj1jzvPu4UKnf1qXL4vGRNVtZIH3FlGh56hCOtc3
	 4ywcoS+o0qJ2QgmaEOr837OjIEXQ9j5i9O84rag91E/dJm+Y8VYKDrldVmyPV0giTG
	 yZyas4snZBFmiACpMI6qgbE0SyVv/IlKX0dqYBPM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 301/331] drm: panel-simple: add missing bus flags for Tianma tm070jvhg[30/33]
Date: Mon, 29 Jan 2024 09:06:05 -0800
Message-ID: <20240129170023.680438066@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
References: <20240129170014.969142961@linuxfoundation.org>
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

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

[ Upstream commit 45dd7df26cee741b31c25ffdd44fb8794eb45ccd ]

The DE signal is active high on this display, fill in the missing
bus_flags. This aligns panel_desc with its display_timing.

Fixes: 9a2654c0f62a ("drm/panel: Add and fill drm_panel type field")
Fixes: b3bfcdf8a3b6 ("drm/panel: simple: add Tianma TM070JVHG33")

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://lore.kernel.org/r/20231012084208.2731650-1-alexander.stein@ew.tq-group.com
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20231012084208.2731650-1-alexander.stein@ew.tq-group.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 6e46e55d29a9..51f838befb32 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -3782,6 +3782,7 @@ static const struct panel_desc tianma_tm070jdhg30 = {
 	},
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
 };
 
 static const struct panel_desc tianma_tm070jvhg33 = {
@@ -3794,6 +3795,7 @@ static const struct panel_desc tianma_tm070jvhg33 = {
 	},
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
 };
 
 static const struct display_timing tianma_tm070rvhg71_timing = {
-- 
2.43.0




