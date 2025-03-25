Return-Path: <stable+bounces-126405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07351A700A9
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C0B1794A5
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1AF26A1B1;
	Tue, 25 Mar 2025 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZpmH+Cdc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295FC25BAD9;
	Tue, 25 Mar 2025 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906163; cv=none; b=IBYaHgvAGbOhu9+9Q/zTh9SqVwAfgUssO2eWH1mEx6t/npvGnqPGEjImJrKjQT517LfSbjXZvHHd5g6OvCipbqLbg6SX41Wbwk/Pqg0ToJMldWDvg41N8fqziXhOWY0lOUaerN41O8hV3/wy84ZQqCW/ryc+2M4A85AUVxi0pFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906163; c=relaxed/simple;
	bh=/cTDJ93EEJ3wxSlHJW/+Hhzsobg4DGbLIuIAvur1BjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ufwPgLiCqSfE507Lmjx/HwZF7/AJQOWbmTDAeC+l4gYaAXAbSajZ7RkZ58je5v5HLdSguJqdrg17dTecPK8DAV/GxIzEEE0NYBe/CUafXjUbGu1W7zra+g8FTifInHj7cJwmqmHQX4bikkuFcn1yxH/C82lxFFju/ddmyATK5Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZpmH+Cdc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63A9C4CEE4;
	Tue, 25 Mar 2025 12:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742906163;
	bh=/cTDJ93EEJ3wxSlHJW/+Hhzsobg4DGbLIuIAvur1BjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZpmH+CdcLTOfGiTVqEOi02YgejmrzH7ofLUsrrJa7cDIvHXIiqtLF+ufzalqTSp+r
	 vMg0jrC0gpC8C1dhTf4HDAkYfGYjbJhY0+QS+KQv7lFV0WNk5rPZ5+edXjwqbz9ekv
	 Elfp5RdwKlN1H+XSrwhb0EBeF3MaoXDVMnPZubv0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 6.6 49/77] ARM: dts: imx6qdl-apalis: Fix poweroff on Apalis iMX6
Date: Tue, 25 Mar 2025 08:22:44 -0400
Message-ID: <20250325122145.636029035@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122144.259256924@linuxfoundation.org>
References: <20250325122144.259256924@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

commit 83964a29379cb08929a39172780a4c2992bc7c93 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
@@ -101,6 +101,11 @@
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
@@ -220,10 +225,6 @@
 	status = "disabled";
 };
 
-&clks {
-	fsl,pmic-stby-poweroff;
-};
-
 /* Apalis SPI1 */
 &ecspi1 {
 	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>;
@@ -511,7 +512,6 @@
 
 	pmic: pmic@8 {
 		compatible = "fsl,pfuze100";
-		fsl,pmic-stby-poweroff;
 		reg = <0x08>;
 
 		regulators {



