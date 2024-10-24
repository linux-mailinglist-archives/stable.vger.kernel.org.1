Return-Path: <stable+bounces-88039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DE99AE5B0
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 15:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4436EB25392
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 13:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243991DD0FB;
	Thu, 24 Oct 2024 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="G06owoBc"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9081D9350;
	Thu, 24 Oct 2024 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775224; cv=none; b=PrZZB8YTomaXyKeVrWNJDyvIayjnleWSrQQevLTVjOmJjN8hclUebHkNXdYvjQV9COyB5TQD20J2dqOjdSJya1Y8mGxM8842nGkkjPhWfhx8gnZpNOFXGjrx8UNpJ/zwjE08uF2jVTuwwEKhVpNHoA5YgLLBoQwVtk+g7c8aKzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775224; c=relaxed/simple;
	bh=BBDjABK+NGvwu0A5Wp0Occ1V3XhledEZehxNROX48ho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qj+W9JeepxB37sdGtpx1I3QrMANCmNkTsb/Ox7khzhU7vlxiT2Swe3P8YOaKHIMzALCteHCcPSHuw/UbdwL93wCZpXl7EoK0xITOVmnLoCr7Yp5Q8Qx5bQUoJBIZ6TRMkavq4YPPkYoUvQYPLfjgM53xU3Yy2ZMjN9owdCCbeV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=G06owoBc; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 0AC181F9B2;
	Thu, 24 Oct 2024 15:06:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1729775219;
	bh=081XwwT3SpMBjNjgf6iNtj/s3WBFhspA1TJEtsraTTY=; h=From:To:Subject;
	b=G06owoBc4B57W43v3eIlBbGmIsD5pHkC4J5ScyvVQx3JaohBWEAahWOPJy5dMsKaY
	 ejh0ciq7dzNuNnStK/JvmPn5mTA+c/oLPLtUIcWDYkDPUVQ6W6UCENv7YRcAf0wgWP
	 uRTgaP8wlLZDBXqAkRZdzMCl+FMmSrxb59b6oFP5kvBwV6fYN9kqNmQhjOj+bBffU3
	 53ZVBM2ydbGhSd2GYWIJlQzKOiEv+JjvNPoTgD/L8Sn9S7zXXo/Sg71zB6Ol7Mnj+0
	 KovtEa/fRJG5ULSYC/q4DoAFYKMEn9m3RSTaJgZPT3xwagFb8mh38rDrylgYSYJYmt
	 QgGxSBt4UtodA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1 1/2] arm64: dts: freescale: imx8mm-verdin: Fix SD regulator startup delay
Date: Thu, 24 Oct 2024 15:06:50 +0200
Message-Id: <20241024130651.49718-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024130651.49718-1-francesco@dolcini.it>
References: <20241024130651.49718-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

The power switch used to power the SD card interface might have
more than 2ms turn-on time, increase the startup delay to 20ms to
prevent failures.

Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial support for verdin imx8m mini")
Cc: <stable@vger.kernel.org>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index c20c2da17524..01042c1e9e7d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -162,7 +162,7 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 		regulator-max-microvolt = <3300000>;
 		regulator-min-microvolt = <3300000>;
 		regulator-name = "+V3.3_SD";
-		startup-delay-us = <2000>;
+		startup-delay-us = <20000>;
 	};
 
 	reserved-memory {
-- 
2.39.5


