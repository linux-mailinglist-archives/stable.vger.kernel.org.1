Return-Path: <stable+bounces-125933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23ACFA6DEDD
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E77188A276
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 15:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7F8261377;
	Mon, 24 Mar 2025 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ycgqm0K9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA50261368
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830521; cv=none; b=osi1uMZONLYwpwfco+EtWcnC0dcWGcnHaOYaJuwDYEZRVQqfUEnwLtxC/EWmajJS4LCIPnZrZeOdyJjGHM6W/DEV+w8fS5Gs4GXa2puQFqXzs2bxqRhvjYZiq2WAyCuUFDWI/qC4n8NcMjZ6250NQnVXF2FegyU+wWvBZiPAS9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830521; c=relaxed/simple;
	bh=AWKLfHyMevsZCgQ3YgI8xFg6COcDSirXTHacJAZc+Ps=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=b/Vl5fteVFb3shOV+pbrsK4OpAMy+Smflgnr3NB5g4zAohZ3qmKmKoEpIfEueVl2oGlNlm+9Xl35KjVfU6+EzDo9NUwmOatOXsBJ8SaP+ILS6YkVusJvFeUEmtio3zPbDF8MNeovD97fsnbZ025wg4t5D13E+ewC3DC6q4QO2uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ycgqm0K9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371C9C4CEDD;
	Mon, 24 Mar 2025 15:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742830521;
	bh=AWKLfHyMevsZCgQ3YgI8xFg6COcDSirXTHacJAZc+Ps=;
	h=Subject:To:Cc:From:Date:From;
	b=ycgqm0K9j2lqqRxraPUH+4IFjdCVI7WKxZcbmbeMsCNiHy/x9gziLgKBO4vGBUETu
	 YOEEBwfuZHmzPdzg0fxn+oEDJAlU7Tz0gB3zvjgyahFdxzOX46elg0cXyxpJFM6Vsh
	 7E0DTwTz4o+nmZPOS4fwhiAVcn+Z27Lgyz2b20Pw=
Subject: FAILED: patch "[PATCH] ARM: dts: imx6qdl-apalis: Fix poweroff on Apalis iMX6" failed to apply to 6.1-stable tree
To: stefan.eichenberger@toradex.com,shawnguo@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Mar 2025 08:33:59 -0700
Message-ID: <2025032458-hammock-twitter-2596@gregkh>
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
git cherry-pick -x 83964a29379cb08929a39172780a4c2992bc7c93
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025032458-hammock-twitter-2596@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 83964a29379cb08929a39172780a4c2992bc7c93 Mon Sep 17 00:00:00 2001
From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Date: Fri, 10 Jan 2025 16:18:29 +0100
Subject: [PATCH] ARM: dts: imx6qdl-apalis: Fix poweroff on Apalis iMX6

The current solution for powering off the Apalis iMX6 is not functioning
as intended. To resolve this, it is necessary to power off the
vgen2_reg, which will also set the POWER_ENABLE_MOCI signal to a low
state. This ensures the carrier board is properly informed to initiate
its power-off sequence.

The new solution uses the regulator-poweroff driver, which will power
off the regulator during a system shutdown.

Cc: <stable@vger.kernel.org>
Fixes: 4eb56e26f92e ("ARM: dts: imx6q-apalis: Command pmic to standby for poweroff")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
index dffab5aa8b9c..88be29166c1a 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
@@ -108,6 +108,11 @@ lvds_panel_in: endpoint {
 		};
 	};
 
+	poweroff {
+		compatible = "regulator-poweroff";
+		cpu-supply = <&vgen2_reg>;
+	};
+
 	reg_module_3v3: regulator-module-3v3 {
 		compatible = "regulator-fixed";
 		regulator-always-on;
@@ -236,10 +241,6 @@ &can2 {
 	status = "disabled";
 };
 
-&clks {
-	fsl,pmic-stby-poweroff;
-};
-
 /* Apalis SPI1 */
 &ecspi1 {
 	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>;
@@ -527,7 +528,6 @@ &i2c2 {
 
 	pmic: pmic@8 {
 		compatible = "fsl,pfuze100";
-		fsl,pmic-stby-poweroff;
 		reg = <0x08>;
 
 		regulators {


