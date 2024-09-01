Return-Path: <stable+bounces-71703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF189675B9
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 11:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61831F212AE
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 09:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C83D13B2B8;
	Sun,  1 Sep 2024 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RxJic0/S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3574A94B
	for <stable@vger.kernel.org>; Sun,  1 Sep 2024 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725182489; cv=none; b=NejtZXQO/LihPFmNdkBRAZd8BbTevyDFziB6MgTydJSUiRwEzE4FgVqzOSQun9h/MdEgRsxHsSNLM+t876BuMVXuBaqm1WLQW+J+UbCUApdKYGODpXs/QisaYqruDRQHJr6do3DJi728i2ds2COn75IC985fUak1JQj7z0r4kxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725182489; c=relaxed/simple;
	bh=m3N54/IOYQcWBjDe80OPV8SXEiTR9AImpWDl8/7z7BY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=u7j+Earqt1uO3rrmO8tn4qe1tPk1UU8W421RXagBd5NC6pE2Yq3NV5Kmcmu8GRDlETr33ikU7gID6k7oGhENEUmU1+XEbupIUv0P8UjyZd5hpLOP8Ryi/jENw9Qk2VP7k1thErFrmGFNjA6wze993xVj0XTgxYLgA64sdQAOAq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RxJic0/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BE0C4CEC3;
	Sun,  1 Sep 2024 09:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725182489;
	bh=m3N54/IOYQcWBjDe80OPV8SXEiTR9AImpWDl8/7z7BY=;
	h=Subject:To:Cc:From:Date:From;
	b=RxJic0/SP1tqKs7UOO1sykiQjjLhuOucnp9Hqr77somoGVuhoooKhgPJjAD6SS7jk
	 fYKvteAuzOLzIifr7BcRdJcZWGMbPz4mhv0K8RAR58UZoC6SQVg0EB0YuAJd6gSVth
	 /tw07FNpfDb22/2U9BIrtI9A9vUIglX7KG9z2dK4=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: x1e80100-crd: fix missing PCIe4 gpios" failed to apply to 6.10-stable tree
To: johan+linaro@kernel.org,andersson@kernel.org,konrad.dybcio@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 01 Sep 2024 11:21:25 +0200
Message-ID: <2024090124-chaffing-curable-eb92@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 42b33ad188466292eaac9825544b8be8deddb3cb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090124-chaffing-curable-eb92@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

42b33ad18846 ("arm64: dts: qcom: x1e80100-crd: fix missing PCIe4 gpios")
6e3902c49954 ("arm64: dts: qcom: x1e80100-crd: fix up PCIe6a pinctrl node")
eb57cbe730d1 ("arm64: dts: qcom: x1e80100: Describe the PCIe 6a resources")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 42b33ad188466292eaac9825544b8be8deddb3cb Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Mon, 22 Jul 2024 11:42:47 +0200
Subject: [PATCH] arm64: dts: qcom: x1e80100-crd: fix missing PCIe4 gpios

Add the missing PCIe4 perst, wake and clkreq GPIOs and pin config.

Fixes: d7e03cce0400 ("arm64: dts: qcom: x1e80100-crd: Enable more support")
Cc: stable@vger.kernel.org	# 6.9
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20240722094249.26471-7-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index aeb279b1a0cc..d65a22172006 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -756,6 +756,12 @@ &mdss_dp3_phy {
 };
 
 &pcie4 {
+	perst-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
+
+	pinctrl-0 = <&pcie4_default>;
+	pinctrl-names = "default";
+
 	status = "okay";
 };
 
@@ -931,6 +937,29 @@ nvme_reg_en: nvme-reg-en-state {
 		bias-disable;
 	};
 
+	pcie4_default: pcie4-default-state {
+		clkreq-n-pins {
+			pins = "gpio147";
+			function = "pcie4_clk";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-n-pins {
+			pins = "gpio146";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		wake-n-pins {
+			pins = "gpio148";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
 	pcie6a_default: pcie6a-default-state {
 		clkreq-n-pins {
 			pins = "gpio153";


