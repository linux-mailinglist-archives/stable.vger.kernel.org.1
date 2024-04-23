Return-Path: <stable+bounces-40834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E498AF940
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4672F1C22F1A
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA165144D09;
	Tue, 23 Apr 2024 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZO761nH+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87422143C47;
	Tue, 23 Apr 2024 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908494; cv=none; b=BekvWGluGBrXmsRjDBnJEILmAsuphvzBgFxTXo/+SYYky/CvtebMyNSmUuaSt7hMfIlbQshxlJwmXCvoPOEA//tdM/fdN3ATcIBf48NUtijoHGk1zjb1FJdrgLH/663hHZT5Pe9GEo74y6ia2BhNQP7mAUPduy3ltAaIShveWN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908494; c=relaxed/simple;
	bh=uhzWqBPAbGAJ3UKh0FuBd/SRKlOgqFhjDireZ5ITBGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0gdcwY2JUw8k8KPQwxwoS2HxhEkfa1mkkyzpW4tNTDSgWGlLqOZ2VWaHYhkIkWJ5HW2Vm77+UFgXq8r8eFWQ57l83XmbqPg3/U8jYA/YkGt2CSBoJ+6QoKQ0fisjzdS1wUpmMHrmODq5znqHDSafokAOVoVJ1FApqfuYLoWOrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZO761nH+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C2DC32782;
	Tue, 23 Apr 2024 21:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908494;
	bh=uhzWqBPAbGAJ3UKh0FuBd/SRKlOgqFhjDireZ5ITBGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZO761nH+Cyms8FoiDR+Om0Cv1q3lvJvtW++JJ44KGMOHKSRvkcK/XbUvRULuk5YPX
	 /I+wU5+iRPSpUdLauz4gLcll0JtCaQaDAC9Qnzvf66Zb0VLCDGaI2RIEvdAPSaU1yZ
	 h77SaHEHRuGl/iq4Erkl/7FGuhTqQbRgUWIFH9hY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 071/158] drm/panel: visionox-rm69299: dont unregister DSI device
Date: Tue, 23 Apr 2024 14:38:13 -0700
Message-ID: <20240423213858.269815504@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213855.824778126@linuxfoundation.org>
References: <20240423213855.824778126@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 9e4d3f4f34455abbaa9930bf6b7575a5cd081496 ]

The DSI device for the panel was registered by the DSI host, so it is an
error to unregister it from the panel driver. Drop the call to
mipi_dsi_device_unregister().

Fixes: c7f66d32dd43 ("drm/panel: add support for rm69299 visionox panel")
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240404-drop-panel-unregister-v1-1-9f56953c5fb9@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-visionox-rm69299.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
index 775144695283f..b15ca56a09a74 100644
--- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
+++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
@@ -253,8 +253,6 @@ static void visionox_rm69299_remove(struct mipi_dsi_device *dsi)
 	struct visionox_rm69299 *ctx = mipi_dsi_get_drvdata(dsi);
 
 	mipi_dsi_detach(ctx->dsi);
-	mipi_dsi_device_unregister(ctx->dsi);
-
 	drm_panel_remove(&ctx->panel);
 }
 
-- 
2.43.0




