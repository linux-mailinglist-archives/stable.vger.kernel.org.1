Return-Path: <stable+bounces-157021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AD7AE521F
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E42443099
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800D1221FDC;
	Mon, 23 Jun 2025 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tsTHudgx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED0B19D084;
	Mon, 23 Jun 2025 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714841; cv=none; b=cK8SHTVOALFLWE+O68hmSL0S91082vyklTDKGHB89D+Hs4qtwzQZkrQ18dRosVvevSu6ua0dl7pCWEz4OclbY5u2NZjXvIJvsV1hPpdjWleogWDOb0aSMI68GlAYf71Y6U/8IjcFGK2JraVlSupRcT0cTxfrSzN7d1DRvsnRX2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714841; c=relaxed/simple;
	bh=9YVS21FZiDD8nBAKTlO6ItKCINhxl0+TsZJ/3GYU354=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXmHRj8Rv75+731O7kQPSjD120X/fsccTWHycKYqxNLM4UcJTlQMb1V7guNc3xJiik6++9oJwpy0Ke6bKcWYhwSuME4WqjHYzMSt+V74imWWjIJUqW5Hj+vCYqs57b71JQnWd7Bm75IKW+37t/3K35L/b4WXiUyXfSBNXNFn+vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tsTHudgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE7CC4CEEA;
	Mon, 23 Jun 2025 21:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750714841;
	bh=9YVS21FZiDD8nBAKTlO6ItKCINhxl0+TsZJ/3GYU354=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tsTHudgxujr1q5Fs+aKtIj25PILRurhaZatO8flZe1wtNkLcZUM+enngm+tkNi+10
	 SGHBdlNWO5RnBaTZc2XtbUuSpHWitRBJC1GE1HYFki8nAgU3bFffq6H8i7VSI/4ZHw
	 8BgvUM7mmGROTh7B3bdAzevUCfzY1FL9JKVgjW/s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 166/290] clk: rockchip: rk3036: mark ddrphy as critical
Date: Mon, 23 Jun 2025 15:07:07 +0200
Message-ID: <20250623130631.888697849@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.910356556@linuxfoundation.org>
References: <20250623130626.910356556@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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




