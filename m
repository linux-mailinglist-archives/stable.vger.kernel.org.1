Return-Path: <stable+bounces-71704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A2F9675BA
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 11:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87405B20F8A
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 09:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2A713C66A;
	Sun,  1 Sep 2024 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cNpFWqMn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D4BA94B
	for <stable@vger.kernel.org>; Sun,  1 Sep 2024 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725182496; cv=none; b=PLXwCg72mcpgaNr5utMnowmYTsYKNSHajDj1FC2Wy7D1aCPtECg5UC5hB6bHgsNq8Wl23oXZN9bUkEuLRo1eHEJSplcSCwCEcIKg8yh3c0Nkmodaun4uE+eSq2scUef8jzLuXqSkkkLVUZg6rWPmDLftbqM/bzfr+ovc6KnZf2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725182496; c=relaxed/simple;
	bh=FSf+Tfb9dvx0AjxIolsaCVCkYONorz74LPajT+/OpCI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BGIkt1ZsfWDEJRCbvoSPEpnZkQH9Wq9vMbuOujFSQUBXkTx5yD21AurGl/O2Ed36CedWXOK8clQ+bLfhl+omaolglAjE5EwS3h5Gfknj32MiFex7ULLx+BnHFTtIWxpzdy7Kgo5k/9vJa2zCkvcXPUGY1lH4nb2fPKqNt2O3XS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cNpFWqMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BEB3C4CEC3;
	Sun,  1 Sep 2024 09:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725182495;
	bh=FSf+Tfb9dvx0AjxIolsaCVCkYONorz74LPajT+/OpCI=;
	h=Subject:To:Cc:From:Date:From;
	b=cNpFWqMnDYbEsAoejrRvwL2DtZvBumJVKMQZGHp+ktgF9sVpylwKlHuhk9XQATpsS
	 H2E098e8xKtxqJCbb6jZWEkLLCcv6pDJTTvTQ4HGYAY/RXP7qYhwfuWw1yqQv8UKfC
	 GgygnU+iw+ssOnyg4bdKu++UHGtjHRcmCkhHzvDI=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: x1e80100-qcp: fix missing PCIe4 gpios" failed to apply to 6.10-stable tree
To: johan+linaro@kernel.org,andersson@kernel.org,konrad.dybcio@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 01 Sep 2024 11:21:31 +0200
Message-ID: <2024090131-caviar-jubilant-3f17@gregkh>
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
git cherry-pick -x 2ac90e4d2b6d6823ca10642ef39595ff1181c3fa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090131-caviar-jubilant-3f17@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

2ac90e4d2b6d ("arm64: dts: qcom: x1e80100-qcp: fix missing PCIe4 gpios")
0aab6eaac72a ("arm64: dts: qcom: x1e80100-qcp: fix up PCIe6a pinctrl node")
eb57cbe730d1 ("arm64: dts: qcom: x1e80100: Describe the PCIe 6a resources")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2ac90e4d2b6d6823ca10642ef39595ff1181c3fa Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Mon, 22 Jul 2024 11:54:51 +0200
Subject: [PATCH] arm64: dts: qcom: x1e80100-qcp: fix missing PCIe4 gpios

Add the missing PCIe4 perst, wake and clkreq GPIOs and pin config.

Fixes: f9a9c11471da ("arm64: dts: qcom: x1e80100-qcp: Enable more support")
Cc: stable@vger.kernel.org	# 6.9
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240722095459.27437-5-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
index 653673e423bf..2dcf2a17511d 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
@@ -660,6 +660,12 @@ &mdss_dp3_phy {
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
 
@@ -804,6 +810,29 @@ nvme_reg_en: nvme-reg-en-state {
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


