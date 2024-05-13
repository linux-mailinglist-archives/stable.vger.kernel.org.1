Return-Path: <stable+bounces-43709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CE28C4403
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 17:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B891DB23FB6
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F369C4C84;
	Mon, 13 May 2024 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W3FjHsPp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB566AC0
	for <stable@vger.kernel.org>; Mon, 13 May 2024 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715613449; cv=none; b=hRsmtuxe43AnkpL0cwzXGWKfkHo2g/PNxkXkXjCZabcNJzB/WWbp1Jd7EQr+LWOgNqMHbhRRyfILpjmtIJH3lTxnQTdsh9o+uuOLXjE4/QzGzXlhF+Spk9PlYSWaKWs4xcQ3hWfMrDxAGecE22EE8xv00jZSW/ERFfCnr2vstS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715613449; c=relaxed/simple;
	bh=X11teEcvZJI1t+Is9d98nGFItyibwLdUHu9mmuLUq2I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=X3Br7ykO1/D0pUIhTgVsz39BiWBXPXtalzLJccE/v3tkphubhMuHamXTDqIMN4KcTGiWVrgU9L5XJWMGMVesdedsbaQSmYl2+6HFwyZoNiidZr8ONsWJdO5kOReca5Xh3usb91ee9hC6aQioF2a0Xnvt/CLVkXDKYI1NkhH+lMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W3FjHsPp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF1AC113CC;
	Mon, 13 May 2024 15:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715613449;
	bh=X11teEcvZJI1t+Is9d98nGFItyibwLdUHu9mmuLUq2I=;
	h=Subject:To:Cc:From:Date:From;
	b=W3FjHsPplT9EjhwW03eCXAo8pZklw+tc6PYp9pilOtPHNqq3VgS3eD+M3AWR/JTmw
	 PmgRlu4qX8oxH06ftceIeTWYk6NZkH3DcBelD4ePL0T8cqfNFnXBEFIgQutp7XZfpA
	 vfyPEHjtJALzAgQ7p0cxa4PthVkglbvd+z+oJuiQ=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: sa8155p-adp: fix SDHC2 CD pin configuration" failed to apply to 6.1-stable tree
To: Volodymyr_Babchuk@epam.com,andersson@kernel.org,stephan@gerhold.net,volodymyr_babchuk@epam.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 17:17:26 +0200
Message-ID: <2024051326-filter-stoplight-c8cc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 819fe8c96a5172dfd960e5945e8f00f8fed32953
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051326-filter-stoplight-c8cc@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

819fe8c96a51 ("arm64: dts: qcom: sa8155p-adp: fix SDHC2 CD pin configuration")
028fe09cda0a ("arm64: dts: qcom: sm8150: align TLMM pin configuration with DT schema")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 819fe8c96a5172dfd960e5945e8f00f8fed32953 Mon Sep 17 00:00:00 2001
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Date: Fri, 12 Apr 2024 19:03:25 +0000
Subject: [PATCH] arm64: dts: qcom: sa8155p-adp: fix SDHC2 CD pin configuration

There are two issues with SDHC2 configuration for SA8155P-ADP,
which prevent use of SDHC2 and causes issues with ethernet:

- Card Detect pin for SHDC2 on SA8155P-ADP is connected to gpio4 of
  PMM8155AU_1, not to SoC itself. SoC's gpio4 is used for DWMAC
  TX. If sdhc driver probes after dwmac driver, it reconfigures
  gpio4 and this breaks Ethernet MAC.

- pinctrl configuration mentions gpio96 as CD pin. It seems it was
  copied from some SM8150 example, because as mentioned above,
  correct CD pin is gpio4 on PMM8155AU_1.

This patch fixes both mentioned issues by providing correct pin handle
and pinctrl configuration.

Fixes: 0deb2624e2d0 ("arm64: dts: qcom: sa8155p-adp: Add support for uSD card")
Cc: stable@vger.kernel.org
Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
Link: https://lore.kernel.org/r/20240412190310.1647893-1-volodymyr_babchuk@epam.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
index 5e4287f8c8cd..b2cf2c988336 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
@@ -367,6 +367,16 @@ queue0 {
 	};
 };
 
+&pmm8155au_1_gpios {
+	pmm8155au_1_sdc2_cd: sdc2-cd-default-state {
+		pins = "gpio4";
+		function = "normal";
+		input-enable;
+		bias-pull-up;
+		power-source = <0>;
+	};
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
@@ -384,10 +394,10 @@ &remoteproc_cdsp {
 &sdhc_2 {
 	status = "okay";
 
-	cd-gpios = <&tlmm 4 GPIO_ACTIVE_LOW>;
+	cd-gpios = <&pmm8155au_1_gpios 4 GPIO_ACTIVE_LOW>;
 	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_on>;
-	pinctrl-1 = <&sdc2_off>;
+	pinctrl-0 = <&sdc2_on &pmm8155au_1_sdc2_cd>;
+	pinctrl-1 = <&sdc2_off &pmm8155au_1_sdc2_cd>;
 	vqmmc-supply = <&vreg_l13c_2p96>; /* IO line power */
 	vmmc-supply = <&vreg_l17a_2p96>;  /* Card power line */
 	bus-width = <4>;
@@ -505,13 +515,6 @@ data-pins {
 			bias-pull-up;		/* pull up */
 			drive-strength = <16>;	/* 16 MA */
 		};
-
-		sd-cd-pins {
-			pins = "gpio96";
-			function = "gpio";
-			bias-pull-up;		/* pull up */
-			drive-strength = <2>;	/* 2 MA */
-		};
 	};
 
 	sdc2_off: sdc2-off-state {
@@ -532,13 +535,6 @@ data-pins {
 			bias-pull-up;		/* pull up */
 			drive-strength = <2>;	/* 2 MA */
 		};
-
-		sd-cd-pins {
-			pins = "gpio96";
-			function = "gpio";
-			bias-pull-up;		/* pull up */
-			drive-strength = <2>;	/* 2 MA */
-		};
 	};
 
 	usb2phy_ac_en1_default: usb2phy-ac-en1-default-state {


