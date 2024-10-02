Return-Path: <stable+bounces-79674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999F798D9A6
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9228B2243C
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A661D0491;
	Wed,  2 Oct 2024 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1oSgEHsN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA11E1D079C;
	Wed,  2 Oct 2024 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878132; cv=none; b=IOzQMljlLtob+qh+fN5qwE7fw9XHUfAcHP1ysgJGrbDTNk4jE792bwAHdVZ0CgA6Hsu6rLpmmfhrJI0QtyDHWthAAIDFjN7xnTGMh37SlmaURGSaTlGIXupnwZE6k8eKyBrrp896G7mNAvQYYfnJiTYC62/vdCBFr2JrqEAH+tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878132; c=relaxed/simple;
	bh=nkP+nYx7XaDefkYQWf5CyEmYolCMf9IMekO5dUt83NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1LIqlDx/Ff7VJ5v4yKzjD6c3yyVUCaRSNJs5OwdazGQdl0ucarEiFhocZjJUDVDX9wMeYP21hMAWtgkhf/uwwwHP3Pm7tuUvGE69fxHfxbq+32VB3YFwJ8QxxaGkKT/Qjx9eW6MYWMBocEnXbDtkkBF4+jPz6/ebDeqLSPuNtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1oSgEHsN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15838C4CEC2;
	Wed,  2 Oct 2024 14:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727878132;
	bh=nkP+nYx7XaDefkYQWf5CyEmYolCMf9IMekO5dUt83NE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1oSgEHsN6iV93y6WxJXw1BOyz6RusQemZf+q4Cvl7tHqW3TVx2KkJz6ab2OTyyevI
	 cbZitBoM5BjrPME5uALxLTnvwEr735QJRyF6WnnFINmzd+21QATp/l+Yn1bl7DrnEd
	 f1dQ/G4+X+Zun6iqUv+zr47t0X7vMh5hmXLO3RgA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pengfei Li <pengfei.li_1@nxp.com>,
	Jacky Bai <ping.bai@nxp.com>,
	Peng Fan <peng.fan@nxp.com>,
	Abel Vesa <abel.vesa@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 313/634] clk: imx: fracn-gppll: fix fractional part of PLL getting lost
Date: Wed,  2 Oct 2024 14:56:53 +0200
Message-ID: <20241002125823.460416936@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pengfei Li <pengfei.li_1@nxp.com>

[ Upstream commit 7622f888fca125ae46f695edf918798ebc0506c5 ]

Fractional part of PLL gets lost after re-enabling the PLL. the
MFN can NOT be automatically loaded when doing frac PLL enable/disable,
So when re-enable PLL, configure mfn explicitly.

Fixes: 1b26cb8a77a4 ("clk: imx: support fracn gppll")
Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Link: https://lore.kernel.org/r/20240607133347.3291040-5-peng.fan@oss.nxp.com
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-fracn-gppll.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index 44462ab50e513..1becba2b62d0b 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -291,6 +291,10 @@ static int clk_fracn_gppll_prepare(struct clk_hw *hw)
 	if (val & POWERUP_MASK)
 		return 0;
 
+	if (pll->flags & CLK_FRACN_GPPLL_FRACN)
+		writel_relaxed(readl_relaxed(pll->base + PLL_NUMERATOR),
+			       pll->base + PLL_NUMERATOR);
+
 	val |= CLKMUX_BYPASS;
 	writel_relaxed(val, pll->base + PLL_CTRL);
 
-- 
2.43.0




