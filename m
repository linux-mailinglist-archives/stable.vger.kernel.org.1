Return-Path: <stable+bounces-111426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4E3A22F15
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0078A3A3DF6
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D67B1E7C08;
	Thu, 30 Jan 2025 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ojQ7UOlp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9F21DDE9;
	Thu, 30 Jan 2025 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246703; cv=none; b=UcYxSIJzaQflxcMGQtSfNJW4uScYqw8eWYIOSr69CxeKPNj3ZKrdCH6GxTJMd8e3RmU3k5ix7hlwW13iAVhDa+8on/02OIWzVt+TtQDW//5Z9XkQ1gDeSasxmxA0HD7NaovB5dBw8fgLKeIK6eYdBxI8JYdWeS/zRuSn6G7jbik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246703; c=relaxed/simple;
	bh=ksxSYIZCgVyis6Q4/4o81gjEhTdJYsrWx7Rrkyhde+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKaEABTDdA3OAwaHphy0MaHm+rTUgxcVjnzk27ypTmyPaKrV4d/XVkWqdMbz7cB5wW9XtFdNxieveX40/MCyJoQyIjLCvL5IC9fwqe5NppLM5tOZIplB69LsyhIGdg5rLxfvUzKJm3lnpx1t2YHFOX/6LHoJE6moZzfsFtbUUls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ojQ7UOlp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9872FC4CEE0;
	Thu, 30 Jan 2025 14:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738246703;
	bh=ksxSYIZCgVyis6Q4/4o81gjEhTdJYsrWx7Rrkyhde+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ojQ7UOlptEmArQGF/+THcmjofOMLhZz7LszWy2cUcAWED1FI4YzvvOsYvmSUGfGs9
	 nmv4+y6Z+fPV17ah7Nm39c1gTPfZEfQ43Ph36H05AlGCr7fSD7Z6XiAMbRFLnD1Qk3
	 KtDyrf/VAlDOXdNFD3CiulSNEL8Dn57PFq08e3Wg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Jonker <jbx6244@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 38/91] arm64: dts: rockchip: fix defines in pd_vio node for rk3399
Date: Thu, 30 Jan 2025 15:00:57 +0100
Message-ID: <20250130140135.196028300@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130140133.662535583@linuxfoundation.org>
References: <20250130140133.662535583@linuxfoundation.org>
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

From: Johan Jonker <jbx6244@gmail.com>

[ Upstream commit 84836ded76ec9a6f25d1d0acebaad44977e0ec6f ]

A test with the command below gives for example this error:

arch/arm64/boot/dts/rockchip/rk3399-evb.dt.yaml: pd_vio@15:
'pd_tcpc0@RK3399_PD_TCPC0', 'pd_tcpc1@RK3399_PD_TCPC1'
do not match any of the regexes:
'.*-names$', '.*-supply$', '^#.*-cells$',
'^#[a-zA-Z0-9,+\\-._]{0,63}$',
'^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}$',
'^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$',
'^__.*__$', 'pinctrl-[0-9]+'

Fix error by replacing the wrong defines by the ones
mentioned in 'rk3399-power.h'.

make -k ARCH=arm64 dtbs_check

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Link: https://lore.kernel.org/r/20200428203003.3318-1-jbx6244@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Stable-dep-of: 3699f2c43ea9 ("arm64: dts: rockchip: add hevc power domain clock to rk3328")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index e5a25bc7d799..dcd989563d27 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1089,12 +1089,12 @@
 					pm_qos = <&qos_isp1_m0>,
 						 <&qos_isp1_m1>;
 				};
-				pd_tcpc0@RK3399_PD_TCPC0 {
+				pd_tcpc0@RK3399_PD_TCPD0 {
 					reg = <RK3399_PD_TCPD0>;
 					clocks = <&cru SCLK_UPHY0_TCPDCORE>,
 						 <&cru SCLK_UPHY0_TCPDPHY_REF>;
 				};
-				pd_tcpc1@RK3399_PD_TCPC1 {
+				pd_tcpc1@RK3399_PD_TCPD1 {
 					reg = <RK3399_PD_TCPD1>;
 					clocks = <&cru SCLK_UPHY1_TCPDCORE>,
 						 <&cru SCLK_UPHY1_TCPDPHY_REF>;
-- 
2.39.5




