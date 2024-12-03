Return-Path: <stable+bounces-97494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA149E24C2
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D2816F027
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC411F893D;
	Tue,  3 Dec 2024 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bgOXFRO9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9AB1F76BC;
	Tue,  3 Dec 2024 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240703; cv=none; b=H6tf30NWP/NL+iuVg6iP025WJcRoSRK3HOSzUgaoL/cLCKZmQ8nF6fKpxnszBvWmYNkx4+o3XqedczK1dHIBuHRqZZxdcxGhjKINKfwImaR39qHsBhjW3ruO38q/SvdKt25/gGkwWI8KsSFWgs2aOVySjxeZDtwC2qu7tyvWuok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240703; c=relaxed/simple;
	bh=3PZQ9IbYp5s8WjFRIwfWwnfpbD321GI4EgHqSXPQnhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8xFTORreUvvaJJ4lAOW/nEc+78E8FqWY2fzWzA6U0wlefIBmq9CAiXTknOzK3zrKEJBFL85UT0tdveFqG5qOg0TMhbQvS9yWrj8Oy4XZt18sMnnKoLBX+Kfpcx2qUcPPNUWKlyMCx/NR9JtihtBCe6qVfnswpqGW/nFIQR0RDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bgOXFRO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F935C4CECF;
	Tue,  3 Dec 2024 15:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733240702;
	bh=3PZQ9IbYp5s8WjFRIwfWwnfpbD321GI4EgHqSXPQnhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bgOXFRO9Qfm7ne2q4Dv3JlxrDO+FWluaQSOc/sHp2bb34/you29D7j2x0Jb61Y5ap
	 XAVb8H5mMHVnE3gFXWRY9R1nADLshJsDxzZR1W1mCTjemZinkD1dNMouUaxIZWzS/R
	 uRJDqtfCZiL/oSsOws12JbbhObYTOf5fTmZShrtc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 204/826] drm/imx: Add missing DRM_BRIDGE_CONNECTOR dependency
Date: Tue,  3 Dec 2024 15:38:51 +0100
Message-ID: <20241203144751.705871287@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit f673055a46784ccea04465b9213e999f7bc5187e ]

When drm/bridge-connector was moved to DRM_DISPLAY_HELPER not all
users were updated. Add missing Kconfig selections.

Fixes: 9da7ec9b19d8 ("drm/bridge-connector: move to DRM_DISPLAY_HELPER module")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20240906063857.2223442-1-alexander.stein@ew.tq-group.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/imx/ipuv3/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/imx/ipuv3/Kconfig b/drivers/gpu/drm/imx/ipuv3/Kconfig
index f083d313d1d3a..7a427551f4341 100644
--- a/drivers/gpu/drm/imx/ipuv3/Kconfig
+++ b/drivers/gpu/drm/imx/ipuv3/Kconfig
@@ -13,6 +13,7 @@ config DRM_IMX_PARALLEL_DISPLAY
 	tristate "Support for parallel displays"
 	depends on DRM_IMX
 	select DRM_BRIDGE
+	select DRM_BRIDGE_CONNECTOR
 	select DRM_PANEL_BRIDGE
 	select VIDEOMODE_HELPERS
 
@@ -31,6 +32,7 @@ config DRM_IMX_LDB
 	depends on COMMON_CLK
 	select MFD_SYSCON
 	select DRM_BRIDGE
+	select DRM_BRIDGE_CONNECTOR
 	select DRM_PANEL_BRIDGE
 	help
 	  Choose this to enable the internal LVDS Display Bridge (LDB)
-- 
2.43.0




