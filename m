Return-Path: <stable+bounces-132729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846A1A89BB9
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 13:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71F067AA191
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 11:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E082918E2;
	Tue, 15 Apr 2025 11:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="j4Fsu2ZE"
X-Original-To: stable@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35DF294A1F;
	Tue, 15 Apr 2025 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715689; cv=none; b=QUk7GxxuyabJf8XTMDPzRO7ZbkPcEGktvmzESQaFI7ed9NACLpw5pxm++Ft52ki35RK2eYZXbRGhAQy1L473BVq017o4QVBiD/GuJnnJ1Kxk1/4F0Fcg6fRq5tie0Ea6BIXcJxWed4DBieCL5HtECOt6RL92dFN/k8L3RZj/Y+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715689; c=relaxed/simple;
	bh=V4Fl3YJrEBruW3OF0+lQZh92V9COByt2CTZFPTXJ3HM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gU8cgEZdPv2TvYMluDfRmlp+81i8KMD9icWlAi2sf9YdFrPlFStTDlnbqSpHRAal/2CA6C+d2WQ7eJ+4LCJmwQPPREDJU+O/OR6pAlGtm7uwy0mkX+J4wUzN2igyyUiJANkrzaPJ2SjNNKmPTHu+xejIHwpe6pSF4l0fFXqSA+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=j4Fsu2ZE; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53FBEZIt2458082
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 06:14:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744715675;
	bh=em3SeE6tnf9P/kC4q4sTzl1vkOtEYJo1ZKScnx50GAE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=j4Fsu2ZExnGC7uxT75ZNfzZGNYmUTqkot3mp7CR4lZ6jBTM8cVvwpD3ZVf6jOJasp
	 c3ScSq6Qi/KZ28szvXBWYYM52wnL8cAjfb2gf7QCHf3HfgGDol5drfNujGyi+OfW50
	 /Zk9m/GD1rNU9CXu/pMMUkuYozgxMxohFvigTGt4=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53FBEZQ9061261
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Apr 2025 06:14:35 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 15
 Apr 2025 06:14:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 15 Apr 2025 06:14:34 -0500
Received: from abhilash-HP.dhcp.ti.com (abhilash-hp.dhcp.ti.com [172.24.227.115])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53FBDqIB051431;
	Tue, 15 Apr 2025 06:14:30 -0500
From: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <vaishnav.a@ti.com>, <jai.luthra@linux.dev>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <imx@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, Yemike Abhilash Chandra <y-abhilashchandra@ti.com>,
        <stable@vger.kernel.org>, Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH v3 6/7] arm64: dts: ti: k3-am62x: Rename I2C switch to I2C mux in IMX219 overlay
Date: Tue, 15 Apr 2025 16:43:27 +0530
Message-ID: <20250415111328.3847502-7-y-abhilashchandra@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415111328.3847502-1-y-abhilashchandra@ti.com>
References: <20250415111328.3847502-1-y-abhilashchandra@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The IMX219 device tree overlay incorrectly defined an I2C switch instead
of an I2C mux. According to the DT bindings, the correct terminology and
node definition should use "i2c-mux" instead of "i2c-switch". Hence,
update the same to avoid dtbs_check warnings.

Fixes: 4111db03dc05 ("arm64: dts: ti: k3-am62x: Add overlay for IMX219")
Cc: stable@vger.kernel.org
Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Reviewed-by: Jai Luthra <jai.luthra@linux.dev>
---
 arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso
index 7a0d35eb04d3..dd090813a32d 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso
@@ -22,7 +22,7 @@ &main_i2c2 {
 	#size-cells = <0>;
 	status = "okay";
 
-	i2c-switch@71 {
+	i2c-mux@71 {
 		compatible = "nxp,pca9543";
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.34.1


