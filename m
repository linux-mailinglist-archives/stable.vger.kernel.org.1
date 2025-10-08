Return-Path: <stable+bounces-183608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C60FBC557B
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 16:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D87A4F4A11
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 14:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0072028B4FE;
	Wed,  8 Oct 2025 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="QUlT0w9n"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D232853F3;
	Wed,  8 Oct 2025 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932161; cv=none; b=Z4VfOw+r68LeHYn95hph52HeJ178HoPFwYaC1xsMDeHx7hXZ3lHtzLDYqPfgIx5oh2rp8SMamxKCYZ0ti/H3Q6k+SF6dL11Y16jCAW/a1IT3/Abxu79qWGzQYpYrditAaUkh/NMxPEnmZMy45pokxkNv4wnSBuxYz5fBz+NUuh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932161; c=relaxed/simple;
	bh=7FneiLEF1k6K414Cx/x7uqrXKf2wqtsYD1RT9uHtFrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HhvCEknHKydKH7ds69l4J9mdbhX5zHXR2tU+5ex6cmRj7pNyW72+bzLDU674JpMAaKJL9syBjsslL/XhEmUvfjnsA+G0hcaamuo0NgoQ4oyx0mqC7KuWZGbHrdV40dvLIiJtWerjtAhXP7Vdin9GJuo8fZof1l7CTaBetVuyhi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=QUlT0w9n; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=NOYL0uD62hKk28WG4gpRQ/Og2WNGiOzJLp810Y1iXv0=; b=QUlT0w9nR/T9hYkLxnW0QicOxh
	gjEb+c/9oV8pUlTT0b6Wyf+ooTwWWZZZg32QDTbMDXNhjW88OJoZxCcaJkP2fEqNw9t5TjXNCKGnQ
	TFBoeebPG9qGqDLWIPvpyyrt/FHAW91+Dzs3iTD1O7kIypK4p8Bvz6itB5iMpeQuZwecR8TKM9P/E
	9gh/trrYJpJNEkKXP+e8JhDYHPa7CM0sMJyTUs/OfRvcDLSnJbG0KFSjKb4XG7SKIapNbwzSz+ICA
	xurFyZPzPSOesXSOpCNzcVDFJj97I8GMljL0qDUeA+nA20GFimqQYSjiQq59z34ukRzmoj22WnVZj
	JpGdSUUQ==;
Received: from i53875a0d.versanet.de ([83.135.90.13] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v6UGt-0002uq-S4; Wed, 08 Oct 2025 15:31:59 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: mturquette@baylibre.com,
	sboyd@kernel.org,
	zhangqing@rock-chips.com,
	sebastian.reichel@collabora.com,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de,
	stable@vger.kernel.org
Subject: [PATCH] clk: rockchip: rk3588: Don't change PLL rates when setting dclk_vop2_src
Date: Wed,  8 Oct 2025 15:31:35 +0200
Message-ID: <20251008133135.3745785-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dclk_vop2_src currently has CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT
flags set, which is vastly different than dclk_vop0_src or dclk_vop1_src,
which have none of those.

With these flags in dclk_vop2_src, actually setting the clock then results
in a lot of other peripherals breaking, because setting the rate results
in the PLL source getting changed:

[   14.898718] clk_core_set_rate_nolock: setting rate for dclk_vop2 to 152840000
[   15.155017] clk_change_rate: setting rate for pll_gpll to 1680000000
[ clk adjusting every gpll user ]

This includes possibly the other vops, i2s, spdif and even the uarts.
Among other possible things, this breaks the uart console on a board
I use. Sometimes it recovers later on, but there will be a big block
of garbled output for a while at least.

Shared PLLs should not be changed by individual users, so drop these
flags from dclk_vop2_src and make the flags the same as on dclk_vop0
and dclk_vop1.

Fixes: f1c506d152ff ("clk: rockchip: add clock controller for the RK3588")
Cc: stable@vger.kernel.org
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-rk3588.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3588.c b/drivers/clk/rockchip/clk-rk3588.c
index 1694223f4f84..cf83242d1726 100644
--- a/drivers/clk/rockchip/clk-rk3588.c
+++ b/drivers/clk/rockchip/clk-rk3588.c
@@ -2094,7 +2094,7 @@ static struct rockchip_clk_branch rk3588_early_clk_branches[] __initdata = {
 	COMPOSITE(DCLK_VOP1_SRC, "dclk_vop1_src", gpll_cpll_v0pll_aupll_p, 0,
 			RK3588_CLKSEL_CON(111), 14, 2, MFLAGS, 9, 5, DFLAGS,
 			RK3588_CLKGATE_CON(52), 11, GFLAGS),
-	COMPOSITE(DCLK_VOP2_SRC, "dclk_vop2_src", gpll_cpll_v0pll_aupll_p, CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
+	COMPOSITE(DCLK_VOP2_SRC, "dclk_vop2_src", gpll_cpll_v0pll_aupll_p, 0,
 			RK3588_CLKSEL_CON(112), 5, 2, MFLAGS, 0, 5, DFLAGS,
 			RK3588_CLKGATE_CON(52), 12, GFLAGS),
 	COMPOSITE_NODIV(DCLK_VOP0, "dclk_vop0", dclk_vop0_p,
-- 
2.47.2


