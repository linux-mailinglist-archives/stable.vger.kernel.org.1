Return-Path: <stable+bounces-17039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E2F840F92
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9751C23214
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BCF6F08F;
	Mon, 29 Jan 2024 17:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PiJJgX3u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A746F079;
	Mon, 29 Jan 2024 17:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548464; cv=none; b=cL4ccSyuwlsCYsQ+s27bzuds3+caU7dtiwOLTjsoNQlYwRyKKrS6AIovRBxvKj7oxQO7C/BLAhEq0+jVn3zLItXmMnWQBSDE+Hwgj/QKHTadsOahsvmf7CywUGK3GYl089UlzScAIghpliJh3+ft483LI8YXVU9NXJJlbXMekSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548464; c=relaxed/simple;
	bh=izmW7QZI9JrUGTmjnYxAv0pi8B3HW8UYiRXpPzwCqK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0ecE7bcF8x/T8MagWrn9ytrfKLlkgT7kHGFYb0frBH1k7bQzIBvBUJv09WIMUWMStQ+YCUNsVZ7fyLgYsyt6qJseXtV2EdEpdEmJqG6StU+L/Cik/lgCIC0kr7PNuKIZzVwMWoEa7mlE/pifrPXkLY2zNbZwEkgNSSu+33A9rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PiJJgX3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43304C433F1;
	Mon, 29 Jan 2024 17:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548464;
	bh=izmW7QZI9JrUGTmjnYxAv0pi8B3HW8UYiRXpPzwCqK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PiJJgX3uNB8+scyPW92sL2hAdjols8TD1xq6WqIEBkILeR1gOAODSoy+9MgO0o0H4
	 XgO0ZHRnbKlxkytwpDTgxTjQMSl15hhYa2hxbgWc7gfDVd3ww2Sl02JE59fzI+lcM/
	 S2S7eajjMxqcjxnn3WNL7BLbmPPh8h2BVJrvYGrc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tianling Shen <cnsztl@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 6.6 078/331] arm64: dts: rockchip: configure eth pad driver strength for orangepi r1 plus lts
Date: Mon, 29 Jan 2024 09:02:22 -0800
Message-ID: <20240129170017.207123169@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
References: <20240129170014.969142961@linuxfoundation.org>
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

From: Tianling Shen <cnsztl@gmail.com>

commit fc5a80a432607d05e85bba37971712405f75c546 upstream.

The default strength is not enough to provide stable connection
under 3.3v LDO voltage.

Fixes: 387b3bbac5ea ("arm64: dts: rockchip: Add Xunlong OrangePi R1 Plus LTS")
Cc: stable@vger.kernel.org # 6.6+
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
Link: https://lore.kernel.org/r/20231216040723.17864-1-cnsztl@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
index 5d7d567283e5..4237f2ee8fee 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
@@ -26,9 +26,11 @@ yt8531c: ethernet-phy@0 {
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <0>;
 
+			motorcomm,auto-sleep-disabled;
 			motorcomm,clk-out-frequency-hz = <125000000>;
 			motorcomm,keep-pll-enabled;
-			motorcomm,auto-sleep-disabled;
+			motorcomm,rx-clk-drv-microamp = <5020>;
+			motorcomm,rx-data-drv-microamp = <5020>;
 
 			pinctrl-0 = <&eth_phy_reset_pin>;
 			pinctrl-names = "default";
-- 
2.43.0




