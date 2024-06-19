Return-Path: <stable+bounces-54251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8576F90ED5B
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B8B28114C
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC17F13F435;
	Wed, 19 Jun 2024 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KCBl/lDw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C224315F;
	Wed, 19 Jun 2024 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803028; cv=none; b=YCMVyOH0fO8zMznGi9LRFSdlEWwzVGXFRBsrwJcwKfSlhNLvNWwjlzkPJGwQDB0F/yH1N2QsSj5g8JTBddv96GaPDrcN2Ox7TWNJcgOB5+dwTjrnNqblXO3BVTwYk0eyXa4H6MO0+3sAzx8vdoI+woiFcHHFxUpsOg2qNHVGkns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803028; c=relaxed/simple;
	bh=maBNDNFB0Oa7CNyDTkF4ejAESCBSW700Z5d/fC5BFhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HASfOuSoGktejDQq7L1rQ8ZfO+cM3JrqE6n8TcI5Gwk2Dh/T7m1dUOV9gbodYY3sCs7frHgggM5zjAcwff1fPwAlzjReaFPkQf1OZ6u1Bo2avbEjHJHr7qtfItWIdCHLL54lCoLWjRVejRV0JTn9r/NCeklCV/ZxtbL6VWvH3wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KCBl/lDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D43C2BBFC;
	Wed, 19 Jun 2024 13:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718803028;
	bh=maBNDNFB0Oa7CNyDTkF4ejAESCBSW700Z5d/fC5BFhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KCBl/lDwjb64GcwKtEGlDlM7J8F1b5vQgB+yY+Ry7kv8i5AeN6Ds0MvG6BVLmVi4Y
	 2yzUnK2/M0QNH2qZNGvmhLReS3a5FgY38HCbVGu54h3dY1I+Faq1NBFTFMhcttsN6+
	 6+1xRboumUlPKOsk/hYL5j6aovUNcabE8S9oO2ww=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Ni <nichen@iscas.ac.cn>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 128/281] drm/panel: sitronix-st7789v: Add check for of_drm_get_panel_orientation
Date: Wed, 19 Jun 2024 14:54:47 +0200
Message-ID: <20240619125614.770196313@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125609.836313103@linuxfoundation.org>
References: <20240619125609.836313103@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit 629f2b4e05225e53125aaf7ff0b87d5d53897128 ]

Add check for the return value of of_drm_get_panel_orientation() and
return the error if it fails in order to catch the error.

Fixes: b27c0f6d208d ("drm/panel: sitronix-st7789v: add panel orientation support")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
Acked-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Link: https://lore.kernel.org/r/20240528030832.2529471-1-nichen@iscas.ac.cn
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240528030832.2529471-1-nichen@iscas.ac.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index e8f385b9c6182..28bfc48a91272 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -643,7 +643,9 @@ static int st7789v_probe(struct spi_device *spi)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
 
-	of_drm_get_panel_orientation(spi->dev.of_node, &ctx->orientation);
+	ret = of_drm_get_panel_orientation(spi->dev.of_node, &ctx->orientation);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret, "Failed to get orientation\n");
 
 	drm_panel_add(&ctx->panel);
 
-- 
2.43.0




