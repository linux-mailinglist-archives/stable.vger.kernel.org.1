Return-Path: <stable+bounces-5423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FAC80CBFC
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DAD2282096
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953D947A65;
	Mon, 11 Dec 2023 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aROXTfs2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EE847A4D;
	Mon, 11 Dec 2023 13:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A18C433C8;
	Mon, 11 Dec 2023 13:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302989;
	bh=YTJmHBrqPg0CR8GZDuwnak/WMVKO84fw0wkyiKcQrjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aROXTfs2TLlDV4JrqqJ8v4jA790ey6S0LG5zk+fgz2gyk2nhrFt0vPxjIsQxTqPyu
	 9f9NBBfkZFPAicKpMCWMbTqVV/Plgn7zBpq2ppxpHr5glYphpHlrtSxDq2lmmi53lL
	 is+jECNQfktBNhD1H+ttn49ae5bD4okBJopINUifMQRvCMGYMNsmYAx7nIROY8J07P
	 awgIwWpTEz3ZqaYdiBpwLd1jXNxksw0Njv0mfrVWf35bSt4cVktH1ldGvbW0XUHbXE
	 drkDSn/qUqqO9xpzJmrEl7pyC/1ORmcIiOFTYTfcMw5KK3jG9EA6HIJahM7FtgPFJA
	 PDCGIsJ/QwbRw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	javierm@redhat.com,
	briannorris@chromium.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 21/29] arm64: dts: rockchip: Fix PCI node addresses on rk3399-gru
Date: Mon, 11 Dec 2023 08:54:05 -0500
Message-ID: <20231211135457.381397-21-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135457.381397-1-sashal@kernel.org>
References: <20231211135457.381397-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.66
Content-Transfer-Encoding: 8bit

From: Rob Herring <robh@kernel.org>

[ Upstream commit c13c823a78b77ea0e5f1f73112d910e259911101 ]

The rk3399-gru PCI node addresses are wrong.

In rk3399-gru-scarlet, the bus number in the address should be 0. This is
because bus number assignment is dynamic and not known up front. For FDT,
the bus number is simply ignored.

In rk3399-gru-chromebook, the addresses are simply invalid. The first
"reg" entry must be the configuration space for the device. The entry
should be all 0s except for device/slot and function numbers. The existing
64-bit memory space (0x83000000) entries are not valid because they must
have the BAR address in the lower byte of the first cell.

Warnings for these are enabled by adding the missing 'device_type = "pci"'
for the root port node.

Signed-off-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20231130191830.2424361-1-robh@kernel.org
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi  | 3 +--
 arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dts | 4 ++--
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi             | 1 +
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
index ee6095baba4d3..7d9b8064ad2ec 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
@@ -510,8 +510,7 @@ wacky_spi_audio: spi2@0 {
 &pci_rootport {
 	mvl_wifi: wifi@0,0 {
 		compatible = "pci1b4b,2b42";
-		reg = <0x83010000 0x0 0x00000000 0x0 0x00100000
-		       0x83010000 0x0 0x00100000 0x0 0x00100000>;
+		reg = <0x0000 0x0 0x0 0x0 0x0>;
 		interrupt-parent = <&gpio0>;
 		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dts
index 853e88455e750..9e4b12ed62cbe 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dts
@@ -34,8 +34,8 @@ &mipi_panel {
 &pci_rootport {
 	wifi@0,0 {
 		compatible = "qcom,ath10k";
-		reg = <0x00010000 0x0 0x00000000 0x0 0x00000000>,
-		      <0x03010010 0x0 0x00000000 0x0 0x00200000>;
+		reg = <0x00000000 0x0 0x00000000 0x0 0x00000000>,
+		      <0x03000010 0x0 0x00000000 0x0 0x00200000>;
 		qcom,ath10k-calibration-variant = "GO_DUMO";
 	};
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 23bfba86daabe..7ba25315dd9ab 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -489,6 +489,7 @@ pci_rootport: pcie@0,0 {
 		#address-cells = <3>;
 		#size-cells = <2>;
 		ranges;
+		device_type = "pci";
 	};
 };
 
-- 
2.42.0


