Return-Path: <stable+bounces-59309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A79A931219
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 12:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037FD284009
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 10:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A021187351;
	Mon, 15 Jul 2024 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pyiP/bli"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A521862A2
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038585; cv=none; b=JNmqpsDaN+W0XrDLHUopVSug61sm4qAl+NJuMQWfqf449/PEVtV3tN021/EOoBvbm7EYS3nJ2NOvHd05hNile+7IArQKSLtIrlvPFu20RT38uh/SDJes9OYWaPwDcyypBUgPd4BZl2ikUEMOKUZ/X27eniG2NjNwoOTjv14Or8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038585; c=relaxed/simple;
	bh=H1kNEXM3pfJbvWsbkHeYvfOZYpPdPA4donbvQJZ3esU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AbOQzsbqRl7fqDrAF1rw0JPvOFN8pQHsGjDBPvKXuxoMMLeAaG9dmh4jvmOZBHzGvYyZX4kA1Mylm81l8S5KY76HGG7jql3vLtN6vf+5zqNN2L+0VuwxlhN6SKxMYQOxFtBZa8vJ9VNi4YhFPJlD62bs5/3yP1ucl/UWAzfAwfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pyiP/bli; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C495C4AF0A;
	Mon, 15 Jul 2024 10:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721038584;
	bh=H1kNEXM3pfJbvWsbkHeYvfOZYpPdPA4donbvQJZ3esU=;
	h=Subject:To:Cc:From:Date:From;
	b=pyiP/bliQePG3y1XIqkyWG25TVda0hV/mZ+ryVqtll/2OTw624gAtlqzh6lgrdngE
	 TF6z+EDG1YnrSbv7is1PkHmeA/7GJazgWZjs53t3vKxr/Q/iIjeNsvBi1mVCpsnJYy
	 9NSCvQDxAUC0WrG7HAzJ7G6K5u28jAejMa+9JgfI=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: sc8280xp-x13s: fix touchscreen power on" failed to apply to 6.1-stable tree
To: johan+linaro@kernel.org,andersson@kernel.org,steev@kali.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jul 2024 12:16:22 +0200
Message-ID: <2024071521-python-duller-bb70@gregkh>
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
git cherry-pick -x 7bfb6a4289b0a63d67ec7d4ce3018cb4a7442f6a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024071521-python-duller-bb70@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

7bfb6a4289b0 ("arm64: dts: qcom: sc8280xp-x13s: fix touchscreen power on")
b01899cb1865 ("arm64: dts: qcom: sc8280xp-x13s: add hid 1.8V supplies")
31e62e862a1e ("arm64: dts: qcom: sc8280xp: rename qup0_i2c4 to i2c4")
6e1569ddfa64 ("arm64: dts: qcom: sc8280xp: rename qup2_i2c5 to i2c21")
71bc1b42844f ("arm64: dts: qcom: sc8280xp: rename qup2_uart17 to uart17")
f48c70b111b4 ("arm64: dts: qcom: sc8280xp-x13s: enable eDP display")
4a883a8d80b5 ("arm64: dts: qcom: sc8280xp-crd: Enable EDP")
e1deaa8437c4 ("arm64: dts: qcom: sa8295p-adp: use sa8540p-pmics")
2eb4cdcd5aba ("arm64: dts: qcom: sa8540p-ride: enable pcie2a node")
f29077d86652 ("arm64: dts: qcom: sc8280xp-x13s: Add soundcard support")
b8bf63f8eb72 ("arm64: dts: qcom: sa8540p-ride: enable PCIe support")
6be310347c9c ("arm64: dts: qcom: add SA8540P ride(Qdrive-3)")
30d70ec8f7fd ("arm64: dts: qcom: sa8295p-adp: Add RTC node")
123b30a75623 ("arm64: dts: qcom: sc8280xp-x13s: enable WiFi controller")
176d54acd5d9 ("arm64: dts: qcom: sc8280xp-x13s: enable modem")
b4bb952e6cfc ("arm64: dts: qcom: sc8280xp-x13s: enable NVMe SSD")
d907fe5acbf1 ("arm64: dts: qcom: sc8280xp-crd: enable WiFi controller")
17e2ccaf65d1 ("arm64: dts: qcom: sc8280xp-crd: enable SDX55 modem")
6a1ec5eca73c ("arm64: dts: qcom: sc8280xp-crd: enable NVMe SSD")
a607fe5ea213 ("arm64: dts: qcom: sc8280xp-x13s: Add LID switch")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7bfb6a4289b0a63d67ec7d4ce3018cb4a7442f6a Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Tue, 7 May 2024 16:48:19 +0200
Subject: [PATCH] arm64: dts: qcom: sc8280xp-x13s: fix touchscreen power on

The Elan eKTH5015M touch controller on the X13s requires a 300 ms delay
before sending commands after having deasserted reset during power on.

Switch to the Elan specific binding so that the OS can determine the
required power-on sequence and make sure that the controller is always
detected during boot.

Note that the always-on 1.8 V supply (s10b) is not used by the
controller directly and should not be described.

Fixes: 32c231385ed4 ("arm64: dts: qcom: sc8280xp: add Lenovo Thinkpad X13s devicetree")
Cc: stable@vger.kernel.org	# 6.0
Tested-by: Steev Klimaszewski <steev@kali.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20240507144821.12275-6-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index e937732abede..4bf99b6b6e5f 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -655,15 +655,16 @@ &i2c4 {
 
 	status = "okay";
 
-	/* FIXME: verify */
 	touchscreen@10 {
-		compatible = "hid-over-i2c";
+		compatible = "elan,ekth5015m", "elan,ekth6915";
 		reg = <0x10>;
 
-		hid-descr-addr = <0x1>;
 		interrupts-extended = <&tlmm 175 IRQ_TYPE_LEVEL_LOW>;
-		vdd-supply = <&vreg_misc_3p3>;
-		vddl-supply = <&vreg_s10b>;
+		reset-gpios = <&tlmm 99 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
+		no-reset-on-power-off;
+
+		vcc33-supply = <&vreg_misc_3p3>;
+		vccio-supply = <&vreg_misc_3p3>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&ts0_default>;
@@ -1496,8 +1497,8 @@ int-n-pins {
 		reset-n-pins {
 			pins = "gpio99";
 			function = "gpio";
-			output-high;
-			drive-strength = <16>;
+			drive-strength = <2>;
+			bias-disable;
 		};
 	};
 


