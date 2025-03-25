Return-Path: <stable+bounces-126467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A381A700DC
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 055F917C825
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E5C25C710;
	Tue, 25 Mar 2025 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WI5zea3Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38EB2586E0;
	Tue, 25 Mar 2025 12:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906278; cv=none; b=HLE45lkdqsMbV131BT+y9x0rn/btRFYNgntjlWeuv2m+xHfh6v+60vUxg+34ut2a4MTcEbJWPdn5JhsY4UgGKgqoSyGv1QhIAThJ+fVapk1yh1zOX+hupFKAtdzrjrt2XJ9aBz8DJbQW0RVuQq8fprJEQL10ZvsC5y1s5xLJih8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906278; c=relaxed/simple;
	bh=w+8OCPbMnFOT1I43CsXAVE03TbeC5hY0dXr0n9Pd/K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsAod1mKHbMM5XZqAQNiXoQcq9AXkr3THMi8r+NAXbOeT7+KNjwMv4mHd//QyhENTv3Sc5c3LGJozHuAh6couqqCGSMBsHejB+te9wOnTYswv9yru4fgKj4zCvYsPxgy7ApxQu32bxfZ2mT/E8cxSGV+8b8RSwkhiZ0cqqHSDVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WI5zea3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65684C4CEE4;
	Tue, 25 Mar 2025 12:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742906278;
	bh=w+8OCPbMnFOT1I43CsXAVE03TbeC5hY0dXr0n9Pd/K0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WI5zea3ZjCZqBDGetiltyf6LxTWMOeymTQK1fCwXFes2tpQkwTsKwCEEu62ujoCk1
	 MUlFNVuqhPObxAfHRoOqDguf1Xb4HA68geGYAbyeU4m5pfXpiVcFjcoj3EOSXdD2GB
	 H8roHWVfhXrYNAhp5Ymk2eR7E/7Mq/5tqmzAGjFM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 004/116] arm64: dts: rockchip: remove supports-cqe from rk3588 jaguar
Date: Tue, 25 Mar 2025 08:21:31 -0400
Message-ID: <20250325122149.321041230@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122149.207086105@linuxfoundation.org>
References: <20250325122149.207086105@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Stuebner <heiko.stuebner@cherry.de>

[ Upstream commit 304b0a60d38dc24bfbfc9adc7d254d1cf8f98317 ]

The sdhci controller supports cqe it seems and necessary code also is in
place - in theory.

At this point Jaguar and Tiger are the only boards enabling cqe support
on the rk3588 and we are seeing reliability issues under load.

This can be caused by either a controller-, hw- or driver-issue and
definitly needs more investigation to work properly it seems.

So disable cqe support on Jaguar for now.

Fixes: d1b8b36a2cc5 ("arm64: dts: rockchip: add Theobroma Jaguar SBC")
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Link: https://lore.kernel.org/r/20250219093303.2320517-1-heiko@sntech.de
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
index 31d2f8994f851..e61c5731fb99f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
@@ -455,7 +455,6 @@ &sdhci {
 	non-removable;
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_bus8 &emmc_cmd &emmc_clk &emmc_data_strobe>;
-	supports-cqe;
 	vmmc-supply = <&vcc_3v3_s3>;
 	vqmmc-supply = <&vcc_1v8_s3>;
 	status = "okay";
-- 
2.39.5




