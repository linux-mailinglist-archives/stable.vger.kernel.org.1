Return-Path: <stable+bounces-148919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F3FACABE8
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 11:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD9C3AE71B
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 09:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C721E8329;
	Mon,  2 Jun 2025 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f7yvMNw5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9488D1E3790
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748857725; cv=none; b=HrczjFdQe8ROrkkdzhxlB7XrgXUe0UiWfq1/ryY3a/XSFkKUclMce+AwzqWX4BJwIl1P4wqTY/MNXl3F5nYOqdkYYcwvGVL5g4BPCLsXK+y/iS/2evdbnCfRHXUDfqbpDIaaF4dOC8wxkPzp1e/eo5RKqS9QtsI2jA1r4JWLjnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748857725; c=relaxed/simple;
	bh=0SavNUYORPjBgyyxSlFzCb57JdsHpGXZ2lKI3rlOUb8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qak9m8qjqwEjwEs0JAfhKEMKe+854U+YMV1RIK3eTsjwQTnciduHRyzWElrFNHsPdc3xwFMcyePjAFTHgbUxif6JupRf/sI9WskwbzO0XYI5Y0n+XpFrYuKph/7nvAGdT8F8nJhyyq3xTwtcMaJOh+/X0Fdx+wHE1gXT/3jG9D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f7yvMNw5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36F9C4CEED;
	Mon,  2 Jun 2025 09:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748857724;
	bh=0SavNUYORPjBgyyxSlFzCb57JdsHpGXZ2lKI3rlOUb8=;
	h=Subject:To:Cc:From:Date:From;
	b=f7yvMNw5h3S0gJK93TsLAUq9b3kqZNHiGpWskfkmhJUDeKgquDcVEhGJk05QxuFdl
	 5BsCkDSomlk4acYcOtFTgN/ONT8ndSomD8hebb5pWWCKFB4RDYvH78YlDsSi26bUf8
	 H+HJR30HhyTX3Oh2NZsj4carHxG27nng4uYAW7Wg=
Subject: FAILED: patch "[PATCH] arm64: dts: ti: k3-j721e-sk: Add DT nodes for power" failed to apply to 6.6-stable tree
To: y-abhilashchandra@ti.com,nm@ti.com,u-kumar1@ti.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Jun 2025 11:48:41 +0200
Message-ID: <2025060241-numbly-remarry-d1a6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 97b67cc102dc2cc8aa39a569c22a196e21af5a21
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025060241-numbly-remarry-d1a6@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 97b67cc102dc2cc8aa39a569c22a196e21af5a21 Mon Sep 17 00:00:00 2001
From: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Date: Tue, 15 Apr 2025 16:43:22 +0530
Subject: [PATCH] arm64: dts: ti: k3-j721e-sk: Add DT nodes for power
 regulators

Add device tree nodes for two power regulators on the J721E SK board.
vsys_5v0: A fixed regulator representing the 5V supply output from the
LM61460 and vdd_sd_dv: A GPIO-controlled TLV71033 regulator.

J721E-SK schematics: https://www.ti.com/lit/zip/sprr438

Fixes: 1bfda92a3a36 ("arm64: dts: ti: Add support for J721E SK")
Cc: stable@vger.kernel.org
Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Link: https://lore.kernel.org/r/20250415111328.3847502-2-y-abhilashchandra@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 440ef57be294..ffef3d1cfd55 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -184,6 +184,17 @@ vsys_3v3: fixedregulator-vsys3v3 {
 		regulator-boot-on;
 	};
 
+	vsys_5v0: fixedregulator-vsys5v0 {
+		/* Output of LM61460 */
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vusb_main>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	vdd_mmc1: fixedregulator-sd {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -211,6 +222,20 @@ vdd_sd_dv_alt: gpio-regulator-tps659411 {
 			 <3300000 0x1>;
 	};
 
+	vdd_sd_dv: gpio-regulator-TLV71033 {
+		compatible = "regulator-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vdd_sd_dv_pins_default>;
+		regulator-name = "tlv71033";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		vin-supply = <&vsys_5v0>;
+		gpios = <&main_gpio0 118 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x0>,
+			 <3300000 0x1>;
+	};
+
 	transceiver1: can-phy1 {
 		compatible = "ti,tcan1042";
 		#phy-cells = <0>;
@@ -613,6 +638,12 @@ J721E_WKUP_IOPAD(0xd4, PIN_OUTPUT, 7) /* (G26) WKUP_GPIO0_9 */
 		>;
 	};
 
+	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x1dc, PIN_OUTPUT, 7) /* (Y1) SPI1_CLK.GPIO0_118 */
+		>;
+	};
+
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0xa0, PIN_INPUT, 0) /* (J29) WKUP_UART0_RXD */


