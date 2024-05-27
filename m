Return-Path: <stable+bounces-46630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5308D0A8B
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5451F2266D
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA79C16132F;
	Mon, 27 May 2024 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sv78kFHO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E9915FD04;
	Mon, 27 May 2024 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716836449; cv=none; b=EuOsFPaUxgXJocZdKVXcx0Ve1XzwHyXyRMOIkxsJa2Aii4dMpqL2972v5iPCdo8Q9Cpq9pyVjdAJQTDKEOfanyYsOSQEvYuXIfIZDjfojm5zrSAu/ujp/6SUMR6LnHIXjvWanNhE+Do1h+apYvyvxGbr6qPDIzmZO42/+0BaNKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716836449; c=relaxed/simple;
	bh=NAZfd7A9l1H19ha61rj4rs/R5yevp1uyCMl8DPDEjpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkT8mpV8jLpvY8ZQ8z3xK2QcbI7ZI3BrtwA3Xvj1RWMjRQfUEbs3jRgs1qesohdyE65E3mrI0xPSGCpp1+MKf+3BzoZyH+zNzTa038OsgpJ932lf053Wlm3H4IJJuP6cGOAPygGikQDZCczQGTJ0xy6az32DKTydPIjXAjYgdIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sv78kFHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17EC2C32781;
	Mon, 27 May 2024 19:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716836449;
	bh=NAZfd7A9l1H19ha61rj4rs/R5yevp1uyCMl8DPDEjpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sv78kFHOx2TzJsVbF2OCZfQOdcbMOaA1Hd0ZQwJV7qlTlRaAmv9JOoZ2j/uUm4agH
	 P/JYygTFvSrXi9xBa3L6YhwVWfdGFMs3m0C6N4OjE/lPBvvu2sWf24JvXqtd3TKF4/
	 okqr6LpJyzJK5ikVdh2Kk8ET2ZX9wGXLnvF1M6Vg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Brown <broonie@kernel.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Maxime Ripard <mripard@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 059/427] ARM: configs: sunxi: Enable DRM_DW_HDMI
Date: Mon, 27 May 2024 20:51:46 +0200
Message-ID: <20240527185607.416466645@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
References: <20240527185601.713589927@linuxfoundation.org>
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

From: Maxime Ripard <mripard@kernel.org>

[ Upstream commit deff401b14e2d832b25b55862ad6c73378fe034e ]

Commit 4fc8cb47fcfd ("drm/display: Move HDMI helpers into display-helper
module") turned the DRM_DW_HDMI dependency of DRM_SUN8I_DW_HDMI into a
depends on which ended up disabling the driver in the defconfig. Make
sure it's still enabled.

Fixes: 4fc8cb47fcfd ("drm/display: Move HDMI helpers into display-helper module")
Reported-by: Mark Brown <broonie@kernel.org>
Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Link: https://lore.kernel.org/r/20240403-fix-dw-hdmi-kconfig-v1-5-afbc4a835c38@kernel.org
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/configs/sunxi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index bddc82f789421..a83d29fed1756 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -110,6 +110,7 @@ CONFIG_DRM_PANEL_LVDS=y
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_PANEL_EDP=y
 CONFIG_DRM_SIMPLE_BRIDGE=y
+CONFIG_DRM_DW_HDMI=y
 CONFIG_DRM_LIMA=y
 CONFIG_FB_SIMPLE=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
-- 
2.43.0




