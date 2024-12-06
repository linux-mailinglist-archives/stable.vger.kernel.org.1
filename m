Return-Path: <stable+bounces-99553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 506D99E7236
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8CD418849A4
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81A21537D4;
	Fri,  6 Dec 2024 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZlHw1zrF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AA953A7;
	Fri,  6 Dec 2024 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497570; cv=none; b=dSICxBb2BdpJvGlekOO71hFU9Pz6jTBLJ6UlnoQFLACza5AaXYCDMh0nidkGLYnnwjs8nJHiOP6tHd+FoBj0VtVHzffGGafjK4/Nl6SflLBzcWCoXbxNbzggbiQfkps5N+qCbH4hxrB1CoYQ31oKDQeVHvocrpHIklCZn2i+GA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497570; c=relaxed/simple;
	bh=Zv6o6wHYoylwoBKkKbkNI8Vyfafvgi21Y1bEqrI8utw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oD2Ak+RShvNVSIb59GSmslE+RW8N1l5CLry/XpRlFLCDmJDCQMdUZvNL3gy4D2r1hISHpKAQBuY50vNZ2AywLrpEa6+tUw/PB17/2GxQrXKeOnTUvkmPclbZXFIE+9bdf/CU1qXaCM6Sglzpv6TtXzSBy9NhPgJ+hJibY9GODTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZlHw1zrF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADF7C4CED1;
	Fri,  6 Dec 2024 15:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733497570;
	bh=Zv6o6wHYoylwoBKkKbkNI8Vyfafvgi21Y1bEqrI8utw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZlHw1zrFbdKwdjeD6jr3FXAzRK/UGs0i7a9OHJqp1FtqqAgCfRRhvca+gZB4LTGmP
	 ds7/OdrT+Pfa7FrDY8Xn2ARh8sDauhIr3PW5nHosWTF888ciOgtbNFHVg/KiJC4lY6
	 jGgWpk0tW8gOKS7H0ES3r/Yjq3tbU3WTzMjAel5k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 328/676] clk: ralink: mtmips: fix clocks probe order in oldest ralink SoCs
Date: Fri,  6 Dec 2024 15:32:27 +0100
Message-ID: <20241206143706.157326526@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
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

From: Sergio Paracuellos <sergio.paracuellos@gmail.com>

[ Upstream commit d34db686a3d74bd564bfce2ada15011c556269fc ]

Base clocks are the first in being probed and are real dependencies of the
rest of fixed, factor and peripheral clocks. For old ralink SoCs RT2880,
RT305x and RT3883 'xtal' must be defined first since in any other case,
when fixed clocks are probed they are delayed until 'xtal' is probed so the
following warning appears:

 WARNING: CPU: 0 PID: 0 at drivers/clk/ralink/clk-mtmips.c:499 rt3883_bus_recalc_rate+0x98/0x138
 Modules linked in:
 CPU: 0 PID: 0 Comm: swapper Not tainted 6.6.43 #0
 Stack : 805e58d0 00000000 00000004 8004f950 00000000 00000004 00000000 00000000
 80669c54 80830000 80700000 805ae570 80670068 00000001 80669bf8 00000000
 00000000 00000000 805ae570 80669b38 00000020 804db7dc 00000000 00000000
 203a6d6d 80669b78 80669e48 70617773 00000000 805ae570 00000000 00000009
 00000000 00000001 00000004 00000001 00000000 00000000 83fe43b0 00000000
 ...
 Call Trace:
 [<800065d0>] show_stack+0x64/0xf4
 [<804bca14>] dump_stack_lvl+0x38/0x60
 [<800218ac>] __warn+0x94/0xe4
 [<8002195c>] warn_slowpath_fmt+0x60/0x94
 [<80259ff8>] rt3883_bus_recalc_rate+0x98/0x138
 [<80254530>] __clk_register+0x568/0x688
 [<80254838>] of_clk_hw_register+0x18/0x2c
 [<8070b910>] rt2880_clk_of_clk_init_driver+0x18c/0x594
 [<8070b628>] of_clk_init+0x1c0/0x23c
 [<806fc448>] plat_time_init+0x58/0x18c
 [<806fdaf0>] time_init+0x10/0x6c
 [<806f9bc4>] start_kernel+0x458/0x67c

 ---[ end trace 0000000000000000 ]---

When this driver was mainlined we could not find any active users of old
ralink SoCs so we cannot perform any real tests for them. Now, one user
of a Belkin f9k1109 version 1 device which uses RT3883 SoC appeared and
reported some issues in openWRT:
- https://github.com/openwrt/openwrt/issues/16054

Thus, define a 'rt2880_xtal_recalc_rate()' just returning the expected
frequency 40Mhz and use it along the old ralink SoCs to have a correct
boot trace with no warnings and a working clock plan from the beggining.

Fixes: 6f3b15586eef ("clk: ralink: add clock and reset driver for MTMIPS SoCs")
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Link: https://lore.kernel.org/r/20240910044024.120009-3-sergio.paracuellos@gmail.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/ralink/clk-mtmips.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/ralink/clk-mtmips.c b/drivers/clk/ralink/clk-mtmips.c
index 62f9801ecd3a4..76285fbbdeaa2 100644
--- a/drivers/clk/ralink/clk-mtmips.c
+++ b/drivers/clk/ralink/clk-mtmips.c
@@ -263,10 +263,6 @@ static int mtmips_register_pherip_clocks(struct device_node *np,
 		.rate = _rate		 \
 	}
 
-static struct mtmips_clk_fixed rt305x_fixed_clocks[] = {
-	CLK_FIXED("xtal", NULL, 40000000)
-};
-
 static struct mtmips_clk_fixed rt3883_fixed_clocks[] = {
 	CLK_FIXED("xtal", NULL, 40000000),
 	CLK_FIXED("periph", "xtal", 40000000)
@@ -371,6 +367,12 @@ static inline struct mtmips_clk *to_mtmips_clk(struct clk_hw *hw)
 	return container_of(hw, struct mtmips_clk, hw);
 }
 
+static unsigned long rt2880_xtal_recalc_rate(struct clk_hw *hw,
+					     unsigned long parent_rate)
+{
+	return 40000000;
+}
+
 static unsigned long rt5350_xtal_recalc_rate(struct clk_hw *hw,
 					     unsigned long parent_rate)
 {
@@ -682,10 +684,12 @@ static unsigned long mt76x8_cpu_recalc_rate(struct clk_hw *hw,
 }
 
 static struct mtmips_clk rt2880_clks_base[] = {
+	{ CLK_BASE("xtal", NULL, rt2880_xtal_recalc_rate) },
 	{ CLK_BASE("cpu", "xtal", rt2880_cpu_recalc_rate) }
 };
 
 static struct mtmips_clk rt305x_clks_base[] = {
+	{ CLK_BASE("xtal", NULL, rt2880_xtal_recalc_rate) },
 	{ CLK_BASE("cpu", "xtal", rt305x_cpu_recalc_rate) }
 };
 
@@ -695,6 +699,7 @@ static struct mtmips_clk rt3352_clks_base[] = {
 };
 
 static struct mtmips_clk rt3883_clks_base[] = {
+	{ CLK_BASE("xtal", NULL, rt2880_xtal_recalc_rate) },
 	{ CLK_BASE("cpu", "xtal", rt3883_cpu_recalc_rate) },
 	{ CLK_BASE("bus", "cpu", rt3883_bus_recalc_rate) }
 };
@@ -751,8 +756,8 @@ static int mtmips_register_clocks(struct device_node *np,
 static const struct mtmips_clk_data rt2880_clk_data = {
 	.clk_base = rt2880_clks_base,
 	.num_clk_base = ARRAY_SIZE(rt2880_clks_base),
-	.clk_fixed = rt305x_fixed_clocks,
-	.num_clk_fixed = ARRAY_SIZE(rt305x_fixed_clocks),
+	.clk_fixed = NULL,
+	.num_clk_fixed = 0,
 	.clk_factor = rt2880_factor_clocks,
 	.num_clk_factor = ARRAY_SIZE(rt2880_factor_clocks),
 	.clk_periph = rt2880_pherip_clks,
@@ -762,8 +767,8 @@ static const struct mtmips_clk_data rt2880_clk_data = {
 static const struct mtmips_clk_data rt305x_clk_data = {
 	.clk_base = rt305x_clks_base,
 	.num_clk_base = ARRAY_SIZE(rt305x_clks_base),
-	.clk_fixed = rt305x_fixed_clocks,
-	.num_clk_fixed = ARRAY_SIZE(rt305x_fixed_clocks),
+	.clk_fixed = NULL,
+	.num_clk_fixed = 0,
 	.clk_factor = rt305x_factor_clocks,
 	.num_clk_factor = ARRAY_SIZE(rt305x_factor_clocks),
 	.clk_periph = rt305x_pherip_clks,
-- 
2.43.0




