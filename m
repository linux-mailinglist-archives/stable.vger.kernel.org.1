Return-Path: <stable+bounces-13939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31275837EE4
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6516A1C283CE
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790CA568D;
	Tue, 23 Jan 2024 00:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RmyMkTbD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3934D5384;
	Tue, 23 Jan 2024 00:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970810; cv=none; b=CmgE4r5kuelBV58Yka5krp/wAA6xbGZ7YkL9bhAIHHeiU/pYRfYu2d04SydvOiT9trmCKphiEGP1qVW9ztRJFYNLVZT/GsQKyi8CmUN3znQ1K4JrUoEgRj+TOmk7ukaMypd+RmWrvhZYm89IRp33oGY8O6kbsUzcd4PlpI9kMgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970810; c=relaxed/simple;
	bh=wBaD62AKbqe8sIB9a9kvEhIS5fefZ1v8Ub42dOBaHuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5k+Z+VIptyoaPoinOdUxTvNbzQw1KdL9qtoDJq0lc/HoolV3rZW0oQC7fotJOgXH/MJwLDymzi9npGlHwCWhahTD0o2lAZeHbOJuM3EIm/3+kn1i5SInj7gUscca+sC0ijG+kDz8nMRR44uUQCheS7tLWsWJf15l3jTBAH1CPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RmyMkTbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87249C433F1;
	Tue, 23 Jan 2024 00:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705970809;
	bh=wBaD62AKbqe8sIB9a9kvEhIS5fefZ1v8Ub42dOBaHuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RmyMkTbD1X2Ju3UAv4oVLXmUp+4MWI7cwglccHNXN+hjHrZ+RXhs71xKTSN1A94yN
	 s7BCr8jJNLi5OwEtaN3aMx4evojJ2fY31jaFQuA8KYrHkljfoJOx/uJ5gPZmavVQGQ
	 OlOXBNwcl3eEJwjSb2lHS4JEZ5Ba+r1+qS7M11xY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Weihao Li <cn.liweihao@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 021/286] clk: rockchip: rk3128: Fix HCLK_OTG gate register
Date: Mon, 22 Jan 2024 15:55:27 -0800
Message-ID: <20240122235732.842237409@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235732.009174833@linuxfoundation.org>
References: <20240122235732.009174833@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Weihao Li <cn.liweihao@gmail.com>

[ Upstream commit c6c5a5580dcb6631aa6369dabe12ef3ce784d1d2 ]

The HCLK_OTG gate control is in CRU_CLKGATE5_CON, not CRU_CLKGATE3_CON.

Signed-off-by: Weihao Li <cn.liweihao@gmail.com>
Link: https://lore.kernel.org/r/20231031111816.8777-1-cn.liweihao@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/rockchip/clk-rk3128.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3128.c b/drivers/clk/rockchip/clk-rk3128.c
index 4b1122e98e16..ddfe1c402e80 100644
--- a/drivers/clk/rockchip/clk-rk3128.c
+++ b/drivers/clk/rockchip/clk-rk3128.c
@@ -489,7 +489,7 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 	GATE(HCLK_I2S_2CH, "hclk_i2s_2ch", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 2, GFLAGS),
 	GATE(0, "hclk_usb_peri", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(9), 13, GFLAGS),
 	GATE(HCLK_HOST2, "hclk_host2", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 3, GFLAGS),
-	GATE(HCLK_OTG, "hclk_otg", "hclk_peri", 0, RK2928_CLKGATE_CON(3), 13, GFLAGS),
+	GATE(HCLK_OTG, "hclk_otg", "hclk_peri", 0, RK2928_CLKGATE_CON(5), 13, GFLAGS),
 	GATE(0, "hclk_peri_ahb", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(9), 14, GFLAGS),
 	GATE(HCLK_SPDIF, "hclk_spdif", "hclk_peri", 0, RK2928_CLKGATE_CON(10), 9, GFLAGS),
 	GATE(HCLK_TSP, "hclk_tsp", "hclk_peri", 0, RK2928_CLKGATE_CON(10), 12, GFLAGS),
-- 
2.43.0




