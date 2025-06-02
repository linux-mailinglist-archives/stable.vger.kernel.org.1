Return-Path: <stable+bounces-149004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F4AACAFB0
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 493057AEE65
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 13:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2DD221FC9;
	Mon,  2 Jun 2025 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vIshPvcL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6B9221F06;
	Mon,  2 Jun 2025 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872235; cv=none; b=LDl7FPtDr2UG6O6czvabMhAfuOil9Jctt3tepFQjpI+QqNN3c31sMUBrj5AvHuwK9FTgCYiqEp6reObaQMVx8Kpqjg0ST3jUv4jubrRdQUDR2pVDhGgnpnXXVSExqArM9IcFfjcVWYyIcLdjIfsd4aYYjFxrSdVHS0wR+YNWoNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872235; c=relaxed/simple;
	bh=pZIIdLujbcRO0FAlcsWnBAwXeUOs+YCz2QrckTHcx88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VI8/HvB9tMsI9dQbXH+4DB4pP8VOoOFtoO67qF3VLxmtbDLvrQznDMHZdXCrXctinIADZBbcLfGCDpmPxdLBaPzu7ddoB8ZIZ1nZTM/aUFTskCLU/rNCAw12lyVtyvcbM/OIsJpoa8MeIjOMd4JOuYfwnBO6N3jt9Ws1Ps6gNc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vIshPvcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC03C4CEEB;
	Mon,  2 Jun 2025 13:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748872235;
	bh=pZIIdLujbcRO0FAlcsWnBAwXeUOs+YCz2QrckTHcx88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vIshPvcLZIlVrG5hdeD/KPuT6pFacbRJykJr3F5qBakUVU7zpi14xQ/mDxYWSYiGl
	 HF01rHf+9zsIFoaK+odKSTuKIFq/8xVoEiwNNSItWsw9E4jBF0/XPtC0KSa7pltQPf
	 pJsWw1+jskzEA0JM6tjwICrHMhKe8JYIMDD2xc7w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yemike Abhilash Chandra <y-abhilashchandra@ti.com>,
	Neha Malcom Francis <n-francis@ti.com>,
	Jai Luthra <jai.luthra@linux.dev>,
	Nishanth Menon <nm@ti.com>
Subject: [PATCH 6.15 31/49] arm64: dts: ti: k3-am62x: Rename I2C switch to I2C mux in IMX219 overlay
Date: Mon,  2 Jun 2025 15:47:23 +0200
Message-ID: <20250602134239.167321575@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134237.940995114@linuxfoundation.org>
References: <20250602134237.940995114@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>

commit 7b75dd2029ee01a8c11fcf4d97f3ccebbef9f8eb upstream.

The IMX219 device tree overlay incorrectly defined an I2C switch
instead of an I2C mux. According to the DT bindings, the correct
terminology and node definition should use "i2c-mux" instead of
"i2c-switch". Hence, update the same to avoid dtbs_check warnings.

Fixes: 4111db03dc05 ("arm64: dts: ti: k3-am62x: Add overlay for IMX219")
Cc: stable@vger.kernel.org
Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Reviewed-by: Jai Luthra <jai.luthra@linux.dev>
Link: https://lore.kernel.org/r/20250415111328.3847502-7-y-abhilashchandra@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso
@@ -22,7 +22,7 @@
 	#size-cells = <0>;
 	status = "okay";
 
-	i2c-switch@71 {
+	i2c-mux@71 {
 		compatible = "nxp,pca9543";
 		#address-cells = <1>;
 		#size-cells = <0>;



