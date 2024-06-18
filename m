Return-Path: <stable+bounces-52703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9501B90CC2D
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 14:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C98D1C22D88
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 12:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6046015CD65;
	Tue, 18 Jun 2024 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQo9RbKC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174A715CD49;
	Tue, 18 Jun 2024 12:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714249; cv=none; b=ejtxGhi6eQv46UgzTo9yP4N+/WbdtDD429PJj2pjK9VGfYUW9x1aTb/7/GUev6vgrFSpw2GypRorGlZbJFoa2meIctvz09blNafOpocTyT48g8FGy8H1HI/EA/nEGtxvuVwIzqvZ4CE5OXYHsq7k0XGzJBIOVnXehQf0DjF6G48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714249; c=relaxed/simple;
	bh=YmjootAgKlT4AUdnARxUqy73v9hCZ0Uej/RVPrjCcqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQrZ7wt+vqlFAVF322RveFIknSt1iHVQIiLe5PCPa4TkOkbmOdMhlLq68FmfsJw4hpng2h7CflUL8Ecj6tybEX7eRJgINPyiUyjORxOSH9PcxUq/0sS25mqymGNtv8Pzwm5u8gBt+XFNtxOXltjiYBAFMBeI6jc9uDDhekUbzho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQo9RbKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8202EC4AF1D;
	Tue, 18 Jun 2024 12:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714248;
	bh=YmjootAgKlT4AUdnARxUqy73v9hCZ0Uej/RVPrjCcqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KQo9RbKCg2KShCcMqiYFKKoIujxAyaHUz8j33qvnJIkUhLAVulz/3I8wRrFG1JYk1
	 DJyI2RZgRYCuJm27wlswXTAmAeoXzO6L/tAuzzVFsdHNvfEx8dlbq9yfsr9D8z/KzJ
	 F8GCkbPKvwWQJ0c9ozGnXcoSG2ou3IytW7//Pwc5ibq5bCOOvLpplIBKY56ete9Mum
	 +5gyfeGBZful7RTlw91CbA+Rsc7doDnwQJfCPW02pCsUaCI30DkT05L0M9xlBKHcNm
	 5TpJtn6J0Q542ev/lWswmyuyz1AUZQiPiYHlchuJAMcn0jnD8Eh8+tSj27XOhvBB57
	 i/ROyiO6J0TxA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	chenhuacai@kernel.org,
	devicetree@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.9 31/44] LoongArch: Fix GMAC's phy-mode definitions in dts
Date: Tue, 18 Jun 2024 08:35:12 -0400
Message-ID: <20240618123611.3301370-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123611.3301370-1-sashal@kernel.org>
References: <20240618123611.3301370-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
Content-Transfer-Encoding: 8bit

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit eb36e520f4f1b690fd776f15cbac452f82ff7bfa ]

The GMAC of Loongson chips cannot insert the correct 1.5-2ns delay. So
we need the PHY to insert internal delays for both transmit and receive
data lines from/to the PHY device. Fix this by changing the "phy-mode"
from "rgmii" to "rgmii-id" in dts.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/boot/dts/loongson-2k0500-ref.dts | 4 ++--
 arch/loongarch/boot/dts/loongson-2k1000-ref.dts | 4 ++--
 arch/loongarch/boot/dts/loongson-2k2000-ref.dts | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/boot/dts/loongson-2k0500-ref.dts b/arch/loongarch/boot/dts/loongson-2k0500-ref.dts
index 8aefb0c126722..a34734a6c3ce8 100644
--- a/arch/loongarch/boot/dts/loongson-2k0500-ref.dts
+++ b/arch/loongarch/boot/dts/loongson-2k0500-ref.dts
@@ -44,14 +44,14 @@ linux,cma {
 &gmac0 {
 	status = "okay";
 
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	bus_id = <0x0>;
 };
 
 &gmac1 {
 	status = "okay";
 
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	bus_id = <0x1>;
 };
 
diff --git a/arch/loongarch/boot/dts/loongson-2k1000-ref.dts b/arch/loongarch/boot/dts/loongson-2k1000-ref.dts
index ed4d324340411..aaf41b565805a 100644
--- a/arch/loongarch/boot/dts/loongson-2k1000-ref.dts
+++ b/arch/loongarch/boot/dts/loongson-2k1000-ref.dts
@@ -43,7 +43,7 @@ linux,cma {
 &gmac0 {
 	status = "okay";
 
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&phy0>;
 	mdio {
 		compatible = "snps,dwmac-mdio";
@@ -58,7 +58,7 @@ phy0: ethernet-phy@0 {
 &gmac1 {
 	status = "okay";
 
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&phy1>;
 	mdio {
 		compatible = "snps,dwmac-mdio";
diff --git a/arch/loongarch/boot/dts/loongson-2k2000-ref.dts b/arch/loongarch/boot/dts/loongson-2k2000-ref.dts
index 74b99bd234cc3..ea9e6985d0e9f 100644
--- a/arch/loongarch/boot/dts/loongson-2k2000-ref.dts
+++ b/arch/loongarch/boot/dts/loongson-2k2000-ref.dts
@@ -92,7 +92,7 @@ phy1: ethernet-phy@1 {
 &gmac2 {
 	status = "okay";
 
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&phy2>;
 	mdio {
 		compatible = "snps,dwmac-mdio";
-- 
2.43.0


