Return-Path: <stable+bounces-162380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F299B05D91
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D3175002CD
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3882E7F3B;
	Tue, 15 Jul 2025 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bRxDDzdE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2602E49B2;
	Tue, 15 Jul 2025 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586404; cv=none; b=qEltY9IR/3k4jJnMMwsy32Cipy2MQqAlWFgovGVHM9aFKie7gtxbboWG49vR7Nxs3bQDx+2DaQzb99czcp0rGKjPtNeqk9ygUf+c2WKp0VtGVfuirJefaMyjGmCxjVN3F77jP/V4pJK6UL56PY3X7nB5nnBFj1agHIZBy+WQR4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586404; c=relaxed/simple;
	bh=t1bw5iyAO4j6wIdrkupswNda9qWO8d1KeX6k9tow1q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ma3uLfhwXD7fgra1MvG7/rqW+nPWiYdpJaD0akCqSO0SXv3FnmoFQNgRufGUj5POKKoKPfbUX2QTMi3u3uzvLyk4Rlw9N/E36cAIeZiFVbdgCqKarEbXmqLQvD2GCtV0logEhzYW4EI60Rrw5n1xWUkMBWSewpc6fMimWDLeVhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bRxDDzdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA7AC4CEE3;
	Tue, 15 Jul 2025 13:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752586404;
	bh=t1bw5iyAO4j6wIdrkupswNda9qWO8d1KeX6k9tow1q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bRxDDzdEAcCCoMYwvEsjmk6hI0EtxmQqbV815YTCm0y9I8tt7CYp+nV1E1BWvFCzh
	 diSAPzLhhUhyZvRlQa4bTiD+ujyEMCpzmm76xB9GMZiIWyLeBA+oscUwjGn3cdxniA
	 ch0YMhIrnDiO+vWlvQ4/E8ArCvVKGCWg2AWlgeTU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Aradhya Bhatia <aradhya.bhatia@linux.dev>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 5.4 052/148] drm/bridge: cdns-dsi: Check return value when getting default PHY config
Date: Tue, 15 Jul 2025 15:12:54 +0200
Message-ID: <20250715130802.407597231@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130800.293690950@linuxfoundation.org>
References: <20250715130800.293690950@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aradhya Bhatia <a-bhatia1@ti.com>

commit c6a7ef0d4856b9629df390e9935d7fd67fe39f81 upstream.

Check for the return value of the phy_mipi_dphy_get_default_config()
call, and in case of an error, return back the same.

Fixes: fced5a364dee ("drm/bridge: cdns: Convert to phy framework")
Cc: stable@vger.kernel.org
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
Signed-off-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
Link: https://lore.kernel.org/r/20250329113925.68204-5-aradhya.bhatia@linux.dev
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/bridge/cdns-dsi.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/bridge/cdns-dsi.c
+++ b/drivers/gpu/drm/bridge/cdns-dsi.c
@@ -616,9 +616,11 @@ static int cdns_dsi_check_conf(struct cd
 	if (ret)
 		return ret;
 
-	phy_mipi_dphy_get_default_config(mode_clock * 1000,
-					 mipi_dsi_pixel_format_to_bpp(output->dev->format),
-					 nlanes, phy_cfg);
+	ret = phy_mipi_dphy_get_default_config(mode_clock * 1000,
+					       mipi_dsi_pixel_format_to_bpp(output->dev->format),
+					       nlanes, phy_cfg);
+	if (ret)
+		return ret;
 
 	ret = cdns_dsi_adjust_phy_config(dsi, dsi_cfg, phy_cfg, mode, mode_valid_check);
 	if (ret)



