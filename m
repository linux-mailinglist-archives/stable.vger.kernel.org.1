Return-Path: <stable+bounces-88040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B489AE5B4
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 15:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB151F24DD6
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 13:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEC21DD9D1;
	Thu, 24 Oct 2024 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="geEXMPWH"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7454F1DD0E6;
	Thu, 24 Oct 2024 13:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775225; cv=none; b=fYlVSLmPbnYX9It1x1NqN+yGEVHQ38Ah63oGJgi13f3WjT+Dd1wjjHhzs96lZEk1+3u82qvpS4JynCUk5rMBFV+dgP7ii/632D1jUwNCvBy+iC8nkiZe7o108051YBTYBy+qwbH6Tm5NCAMVCt1Fmgd9aPIITjgV266AmSgsSmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775225; c=relaxed/simple;
	bh=R3pA8ojsMDNT1XdCtiG0vsOjX/BIQQ3XMMeNIDGpxkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m7y9JjChBII/QT76WFYz/cJlFvDnRaDgYUw8xb4GWtr+OBRBvxaBnn6nN+Kkm59YTzdRh6JFIDi8Jl/Ijq5qpbDK3jYvDy9gOMopBALAvnmEeUCY+7gzhHe9cMGH2LNDxSqk/7TxR/8YKcGWwkhmcEfTjQGKvxmrVXuQu3f9qaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=geEXMPWH; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 9F08C1F9BA;
	Thu, 24 Oct 2024 15:06:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1729775220;
	bh=OaWYCbKne0jIgmMCGe5IUHjDjae7PV5dOPwFEy5t4e8=; h=From:To:Subject;
	b=geEXMPWHAE7ALD9fcu+awGzVuukhe+61VmA8Fn/O/hZZEfrNyK6HRkVwg9sP7bHxz
	 woLrzvxLyL1R9nVlcF1EjLb5VU71l5OcW4pZfZg9irJJaTCBR9ut3XRaUPOo8AYG5+
	 NY1NrfZwkTu7MGRg+R9ZUxXKSwSKT5FvIiKudUfOpxyLHO4VfztblIT5pNOTIkF8kr
	 nIkscfqJLUcZVDLoiVy+WTkmF1o/ru7WN/TXWxNXiF6dV9pWYE5YrGy6bVMFZkjGBF
	 Dx2CvbTkwi3ZaFT1iMSz53LGmOf3R9QgATPomoBfr+wgburCOgLBuka+lSst8vkHt4
	 w+ymp5oZKEsxg==
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
Subject: [PATCH v1 2/2] arm64: dts: freescale: imx8mp-verdin: Fix SD regulator startup delay
Date: Thu, 24 Oct 2024 15:06:51 +0200
Message-Id: <20241024130651.49718-3-francesco@dolcini.it>
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

Fixes: a39ed23bdf6e ("arm64: dts: freescale: add initial support for verdin imx8m plus")
Cc: <stable@vger.kernel.org>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index e9518b7c7aa8..b8c24fe228fa 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -175,7 +175,7 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 		regulator-max-microvolt = <3300000>;
 		regulator-min-microvolt = <3300000>;
 		regulator-name = "+V3.3_SD";
-		startup-delay-us = <2000>;
+		startup-delay-us = <20000>;
 	};
 
 	reserved-memory {
-- 
2.39.5


