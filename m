Return-Path: <stable+bounces-49882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2FA8FEF3E
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624551C23BA0
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F771CB32F;
	Thu,  6 Jun 2024 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MTHaG6KW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0750D1A256C;
	Thu,  6 Jun 2024 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683758; cv=none; b=odOPSIKSa5WCDWFlZ3IlayYSrdQYesJREgTfeoonKL3i9BylVqcnu8Y09GaBN5DM8vefIXcR4w4y0etNvys9GpsTA+3Ilr2dI2m+8mLl8KJDaMaXo6MCGepDi/WpCR2aCN7dQNMMThEmhqvCtAzqVihVUmogrRC/VrnX0hlHIYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683758; c=relaxed/simple;
	bh=8ybcFHCs/RDO3M0SshlkPS5Rtl6X3KQnh9Nid+k3kU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ji4+x4U2l+RQuiyddHsiKNfG0b0UhNWZSdJB3Is4AHQDVhy/61IR+JFdp09Nu849qkYcrjRQX+Wfytx1kEsQl+ywxzqQ4WZJf9TPAxF/Pdrn42uGjrPf9k84+6wZE++OWSpdmUR14HiyyM9SqhK65VtNb2ZCN+yk5P/o3PuPico=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MTHaG6KW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFBCC2BD10;
	Thu,  6 Jun 2024 14:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683757;
	bh=8ybcFHCs/RDO3M0SshlkPS5Rtl6X3KQnh9Nid+k3kU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MTHaG6KWWoIlJbeLyFZBX/c9bytzju6ITgeaWWlRTE6s2R5likoCS2bNQ8rMjOXb6
	 xS22dgVATywTqFV0memTPr+y5zAPjjzIK+QU4nd9xE236xwrDEVQJKGgPll5Irop/h
	 voJASPmdu3NfF87KhAtKlMgRM0X19HoUASu9JedA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gerald Loacker <gerald.loacker@wolfvision.net>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 732/744] drm/panel: sitronix-st7789v: fix display size for jt240mhqs_hwt_ek_e3 panel
Date: Thu,  6 Jun 2024 16:06:44 +0200
Message-ID: <20240606131755.945601686@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

From: Gerald Loacker <gerald.loacker@wolfvision.net>

[ Upstream commit b62c150c3bae72ac1910dcc588f360159eb0744a ]

This is a portrait mode display. Change the dimensions accordingly.

Fixes: 0fbbe96bfa08 ("drm/panel: sitronix-st7789v: add jasonic jt240mhqs-hwt-ek-e3 support")
Signed-off-by: Gerald Loacker <gerald.loacker@wolfvision.net>
Acked-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Link: https://lore.kernel.org/r/20240409-bugfix-jt240mhqs_hwt_ek_e3-timing-v2-3-e4821802443d@wolfvision.net
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240409-bugfix-jt240mhqs_hwt_ek_e3-timing-v2-3-e4821802443d@wolfvision.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index c7e3f1280404d..e8f385b9c6182 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -289,8 +289,8 @@ static const struct drm_display_mode jt240mhqs_hwt_ek_e3_mode = {
 	.vsync_start = 280 + 48,
 	.vsync_end = 280 + 48 + 4,
 	.vtotal = 280 + 48 + 4 + 4,
-	.width_mm = 43,
-	.height_mm = 37,
+	.width_mm = 37,
+	.height_mm = 43,
 	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
 };
 
-- 
2.43.0




