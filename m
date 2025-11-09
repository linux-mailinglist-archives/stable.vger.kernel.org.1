Return-Path: <stable+bounces-192850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CB1C4433D
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 18:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF1C188CBE7
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 17:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4443043D7;
	Sun,  9 Nov 2025 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="mbp3x7HN"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1658D3043BC
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762707970; cv=none; b=RvkdJNiGFX7OgpHlseLiFAwb23AQ6kk7B8UlI5zjEybS2asXwfpV+JhFoMqnEWK1/Ewb3wqq2WShC4Qw/I0K2qFylg6ofdO2McDGjc07HR6NXxxf2cXM3XYfhQZLSe46icP0TVuipenC5Yz6eeSNmw6dcCuiQj2nba0pBbahyRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762707970; c=relaxed/simple;
	bh=RhBkr40435qqQR7ennySLZHbqJD8qlvK6xOZ8kA4q/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lrHf30kczzMD49LiXYCMPsCoV4+c6vq7HK8b7GMbFchwWY0Ri24TZrQIo8ClQWIOcyWm3sD8Y+v8XfN+l7uukpFAT6W1Td65tFOy0VMwllI+kJNy6NzdzLuPKznJHj7Y2GkmiwxvGOdUNTme67G0FDKRTVVBTAPYEwEx1ISf26w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=mbp3x7HN; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1762707965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8+c2slFEzvpnuvBcD3m7Q9rIW5GkW6bzoQAArBwQCS8=;
	b=mbp3x7HNQaUSE3tE8uuKBbakcDwLBufkUi3KvKZ96eOfRvOEvr1SMAq/aw+GpWfufFKohC
	tnBVGD74pj3pgNji84zBhj5FgdFbSS20wUjFA++wdW9Ch/PRG/6YGQa2FLB0OjhDA6T3EF
	jWDdAIh5076hTOJvyvoUOF8nqiP48m7TgN6jJslczwnSpzaEKynsj0Oegg+tN51CQRnRhV
	iSrlnA8RrP08AHrq82oLIVjULKBAvykaeJJ+sTgUjyKdd9HfLA1X6sQ1a7riFeLZSyzn9Z
	fQ/ppQp6PGIZUuBXXeHrckP483ZxmhSd7GYOXExVdF1TVLYpLG3OGEgAuvI2NA==
From: Diederik de Haas <diederik@cknow-tech.com>
Date: Sun, 09 Nov 2025 18:05:27 +0100
Subject: [PATCH 2/2] arm64: dts: rockchip: Move otg-port to controller on
 rk3566-pinenote
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-rk3566-pinenote-dt-fixes-upstream-v1-2-ed38d200cc04@cknow-tech.com>
References: <20251109-rk3566-pinenote-dt-fixes-upstream-v1-0-ed38d200cc04@cknow-tech.com>
In-Reply-To: <20251109-rk3566-pinenote-dt-fixes-upstream-v1-0-ed38d200cc04@cknow-tech.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Samuel Holland <samuel@sholland.org>
Cc: hrdl <git@hrdl.eu>, phantomas <phantomas@phantomas.xyz>, 
 Dragan Simic <dsimic@manjaro.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Diederik de Haas <diederik@cknow-tech.com>, 
 stable@vger.kernel.org
X-Migadu-Flow: FLOW_OUT

The 'rockchip,inno-usb2phy' binding's otg-port node does not have a port
node, so the current definition causes this DT validation issue:

  usb2phy@fe8a0000 (rockchip,rk3568-usb2phy): otg-port:
    'port' does not match any of the regexes: '^pinctrl-[0-9]+$'

Its purpose was to define the other endpoint for the USB-C connector
port. The 'snps,dwc3-common.yaml' DT binding does have a port node to
connect the dwc3 to type C connector with the 'usb-role-switch'
property. Therefore move the port node to the dwc3 node and add the
'usb-role-switch' property to it.
This fixes the above mention DT validation issue.

The incorrect definition also caused these kernel errors:

  rockchip-usb2phy fe8a0000.usb2phy: Failed to create device link (0x180) with supplier port0 for /usb2phy@fe8a0000/otg-port
  rockchip-usb2phy fe8a0000.usb2phy: Failed to create device link (0x180) with supplier 3-0060 for /usb2phy@fe8a0000/otg-port

With the changed definition, those errors are now also gone.

While at it, remove the 'dr_mode' property as that's already defined in
rk356x-base.dtsi and there's no point in redefining it.

Fixes: 87a267b4af09 ("arm64: dts: rockchip: Add USB and TCPC to rk3566-pinenote")
Cc: stable@vger.kernel.org
Signed-off-by: Diederik de Haas <diederik@cknow-tech.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
index 7c65fe4900be..be8076a8e30c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
@@ -694,8 +694,14 @@ &uart2 {
 };
 
 &usb_host0_xhci {
-	dr_mode = "otg";
+	usb-role-switch;
 	status = "okay";
+
+	port {
+		usb2phy0_typec_hs: endpoint {
+			remote-endpoint = <&typec_hs_usb2phy0>;
+		};
+	};
 };
 
 &usb2phy0 {
@@ -704,10 +710,4 @@ &usb2phy0 {
 
 &usb2phy0_otg {
 	status = "okay";
-
-	port {
-		usb2phy0_typec_hs: endpoint {
-			remote-endpoint = <&typec_hs_usb2phy0>;
-		};
-	};
 };

-- 
2.51.0


