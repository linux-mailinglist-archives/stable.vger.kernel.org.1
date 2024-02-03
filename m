Return-Path: <stable+bounces-18439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263F98482BA
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFF23285DC4
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15FF4D5BD;
	Sat,  3 Feb 2024 04:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P2v7m0LM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF85E1BF24;
	Sat,  3 Feb 2024 04:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933799; cv=none; b=cWTsZk9XoEHWRXKc0h0d7R8diNukyEdSItuY9DFuBLMZ/feS4A4oq8H5/nP75vK4Fl3W85OQ34HUSDAW3Gj6Bz+1khXAHrgK39Tu0KNpN8Vo2XFdoa+WPF77zBcycXi7X70EQLI1tEGpDbr1mClgEj8QydnCUpU+6W7u0gRvm5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933799; c=relaxed/simple;
	bh=0J4wLIG4OAtIoXkfhJUvaDWUX1flcmeGZmEoz4NVx4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSU18JfjujdwuHUVVu8sSb9fgZI6+uysMRPEjnbSlWrk2FlHQZQXmVFhc3vf+PlHsbNgxkmyjMSilRLM814PLxkWnZNiAjlgxLEAdW1neArJVZd3LNOiA1F91qLOiTbDgnSQ8Ck7xlvxEpOma6t5hqZGcow1hyxA5cov2c7UopU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P2v7m0LM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7824FC43390;
	Sat,  3 Feb 2024 04:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933799;
	bh=0J4wLIG4OAtIoXkfhJUvaDWUX1flcmeGZmEoz4NVx4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P2v7m0LMX1QAuDpfKpEgs2kb7XsaZT1G0qNu+yhVtVFSRvArQXotGCYY7qbunyvFq
	 UbWNsfM4CVMZzwr/UtH0A9T6NL6i8/afIcLjI7ENdb8jizR7+jU7aRVzjvrerla/Kd
	 GQykqK+UTFwPl647k5vLVgtRCQXeDTUknaG4Hxmk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fabio Estevam <festevam@denx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 111/353] ARM: dts: imx: Use flash@0,0 pattern
Date: Fri,  2 Feb 2024 20:03:49 -0800
Message-ID: <20240203035407.273283297@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035403.657508530@linuxfoundation.org>
References: <20240203035403.657508530@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit 1e1d7cc478fb16816de09740e3c323c0c188d58f ]

Per mtd-physmap.yaml, 'nor@0,0' is not a valid node pattern.

Change it to 'flash@0,0' to fix the following dt-schema warning:

imx1-ads.dtb: nor@0,0: $nodename:0: 'nor@0,0' does not match '^(flash|.*sram|nand)(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mtd/mtd-physmap.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx1-ads.dts                  | 2 +-
 arch/arm/boot/dts/nxp/imx/imx1-apf9328.dts              | 2 +-
 arch/arm/boot/dts/nxp/imx/imx27-eukrea-cpuimx27.dtsi    | 2 +-
 arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-som.dtsi | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx1-ads.dts b/arch/arm/boot/dts/nxp/imx/imx1-ads.dts
index 5833fb6f15d8..2c817c4a4c68 100644
--- a/arch/arm/boot/dts/nxp/imx/imx1-ads.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx1-ads.dts
@@ -65,7 +65,7 @@
 	pinctrl-0 = <&pinctrl_weim>;
 	status = "okay";
 
-	nor: nor@0,0 {
+	nor: flash@0,0 {
 		compatible = "cfi-flash";
 		reg = <0 0x00000000 0x02000000>;
 		bank-width = <4>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx1-apf9328.dts b/arch/arm/boot/dts/nxp/imx/imx1-apf9328.dts
index 1f11e9542a72..e66eef87a7a4 100644
--- a/arch/arm/boot/dts/nxp/imx/imx1-apf9328.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx1-apf9328.dts
@@ -45,7 +45,7 @@
 	pinctrl-0 = <&pinctrl_weim>;
 	status = "okay";
 
-	nor: nor@0,0 {
+	nor: flash@0,0 {
 		compatible = "cfi-flash";
 		reg = <0 0x00000000 0x02000000>;
 		bank-width = <2>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx27-eukrea-cpuimx27.dtsi b/arch/arm/boot/dts/nxp/imx/imx27-eukrea-cpuimx27.dtsi
index 4b83e2918b55..c7e923584878 100644
--- a/arch/arm/boot/dts/nxp/imx/imx27-eukrea-cpuimx27.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx27-eukrea-cpuimx27.dtsi
@@ -90,7 +90,7 @@
 &weim {
 	status = "okay";
 
-	nor: nor@0,0 {
+	nor: flash@0,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "cfi-flash";
diff --git a/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-som.dtsi
index 7b2ea4cdae58..8d428c844666 100644
--- a/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-som.dtsi
@@ -314,7 +314,7 @@
 &weim {
 	status = "okay";
 
-	nor: nor@0,0 {
+	nor: flash@0,0 {
 		compatible = "cfi-flash";
 		reg = <0 0x00000000 0x02000000>;
 		bank-width = <2>;
-- 
2.43.0




