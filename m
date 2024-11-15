Return-Path: <stable+bounces-93144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A128F9CD78F
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A6CEB226A9
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FF61885BF;
	Fri, 15 Nov 2024 06:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XBVaQu78"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CCD1632DA;
	Fri, 15 Nov 2024 06:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731652952; cv=none; b=PVtCFcXnzH/SPx+T3ihWfB1zBs02aCHhxpu+ciGK2oIjaR+GIktosnyNyIkTwB6MYCld1qDjND1gNLOAPzmSEOOD+AcC0WhDXBqBdp6nzOagJU0DjcFrcEvMYczUup35qUu5Uslt6rnJAbkgn1TAnvwqT733d17XDsbLBrSOYyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731652952; c=relaxed/simple;
	bh=5UciyeNiH0DWOe7c58C32sY1Z8AS/pEWo6AO6lFXBAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLI5tn76poS7fZlkVQK5qwB/fmBuDBMdF2VZv9ZJfxJ9JWrs3WeueHE3PJZ7BuYt7Ry3riRNS48+xeZl/wBFwnnklaI7DMHjh3lqJQD/OGpfhkBIkLLC1eZgmi7qcRS+2Y19N7Q67iRfnwMkd12UVC8URiMo/N/kEFYK8NFwPUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XBVaQu78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270D7C4CECF;
	Fri, 15 Nov 2024 06:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731652952;
	bh=5UciyeNiH0DWOe7c58C32sY1Z8AS/pEWo6AO6lFXBAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XBVaQu78HIASwedIiGLRR52ouwn8eRC1oz4/5MChvwzQ4G6tNFXgdlUdNLFD2KElu
	 7cfNBNmFWGC79Na3yv4t9PYwkyInXVhA2lWUvIFY92A7sKnCz+77oha2wPfMNo1z5o
	 Bmo87jLLFt0BLWhdM5hbTMah9Z10iSOscfF2K+Ik=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 03/66] arm64: dts: rockchip: Fix bluetooth properties on Rock960 boards
Date: Fri, 15 Nov 2024 07:37:12 +0100
Message-ID: <20241115063722.962568283@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063722.834793938@linuxfoundation.org>
References: <20241115063722.834793938@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Stuebner <heiko@sntech.de>

[ Upstream commit ea74528aaea5a1dfc8e3de09ef2af37530eca526 ]

The expected clock-name is different, and extclk also is deprecated
in favor of txco for clocks that are not crystals.

So fix it to match the binding.

Fixes: c72235c288c8 ("arm64: dts: rockchip: Add on-board WiFi/BT support for Rock960 boards")
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20241008203940.2573684-5-heiko@sntech.de
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
index c7d48d41e184e..f5ad0a5399204 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
@@ -557,7 +557,7 @@
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
 		clocks = <&rk808 1>;
-		clock-names = "ext_clock";
+		clock-names = "txco";
 		device-wakeup-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
 		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
 		shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
-- 
2.43.0




