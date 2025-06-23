Return-Path: <stable+bounces-157640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25382AE54F0
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD3A1692AB
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC342218580;
	Mon, 23 Jun 2025 22:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HVCY1q7b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D841E87B;
	Mon, 23 Jun 2025 22:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716362; cv=none; b=lvJMGPZ0bU3NcGAUm4ENBUjjKxZfUwy8C1g/EaPRA7sx2s2nvvz8o6Z4uQiamcXml5+cROHm0mhWdAjLdKZrag6CIy6wVPDGBA/Jcxtpq4lfnD0PXicwnSJ4C3ucmcIRBdFpTchkcXxH2hWtmVHa9/8a+PbX532AuEcO3opEY6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716362; c=relaxed/simple;
	bh=MZCijj2h1HZHabfhy2SLsQvBVpqkoAvWLudxWAZUSS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJ/YS3G3fU3ylonvf3p0U6HJaDAwkC5fRJvNxgyB1Eq64WFSrwPViwr0Uao47owaGcazlybWDm8OiAyfUOBZq5L4ibPDCDe5FASa1YuAJouwbe1rUQeRXBDILraEKeuSeWEdYXQHUmT5r23rpEjdF8XY0h2iIpjMbYOaZH+l0Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HVCY1q7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D432C4CEEA;
	Mon, 23 Jun 2025 22:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750716362;
	bh=MZCijj2h1HZHabfhy2SLsQvBVpqkoAvWLudxWAZUSS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HVCY1q7bcSNhIjMB0E4T4VjKQr8dxl1Lew+E8G0+vKUC3HBYEtX5fwOE83cuuXIch
	 NieydDRLPI2fLAvIWSvGUF3gG7xox/Dq5o/WZXGuT5Wu4r0kEycfCiYghOR2tWSE/S
	 O8IF5yVp5KzQvFh+xBIc3ZrXXoAolvUUly2dREH4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 324/411] clk: rockchip: rk3036: mark ddrphy as critical
Date: Mon, 23 Jun 2025 15:07:48 +0200
Message-ID: <20250623130641.794368142@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130632.993849527@linuxfoundation.org>
References: <20250623130632.993849527@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Stuebner <heiko@sntech.de>

[ Upstream commit 596a977b34a722c00245801a5774aa79cec4e81d ]

The ddrphy is supplied by the dpll, but due to the limited number of PLLs
on the rk3036, the dpll also is used for other periperhals, like the GPU.

So it happened, when the Lima driver turned off the gpu clock, this in
turn also disabled the dpll and thus the ram.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20250503202532.992033-4-heiko@sntech.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/rockchip/clk-rk3036.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
index d644bc155ec6e..f5f27535087a3 100644
--- a/drivers/clk/rockchip/clk-rk3036.c
+++ b/drivers/clk/rockchip/clk-rk3036.c
@@ -431,6 +431,7 @@ static const char *const rk3036_critical_clocks[] __initconst = {
 	"hclk_peri",
 	"pclk_peri",
 	"pclk_ddrupctl",
+	"ddrphy",
 };
 
 static void __init rk3036_clk_init(struct device_node *np)
-- 
2.39.5




