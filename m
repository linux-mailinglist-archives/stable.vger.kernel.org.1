Return-Path: <stable+bounces-52418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C20B90AF7A
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 15:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52FC81C23688
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 13:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28E01AED2E;
	Mon, 17 Jun 2024 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+M8cqw9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6670F1AD9FE;
	Mon, 17 Jun 2024 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630525; cv=none; b=N5QqyPtXt0Q3yYV3xE2bKx4xVHd+pRPvNzKWkSPn7Xohlru4vxKZMOlvnE959aSGTL1hJxjZMoIJzP7bzYm5DuYodfMHe6viM67ZoUhStgwL3V7iOo6GhSt5XI5L+WnT8tBkTCZOYbFRJ7RlFONRJFfX7laXJ6tkNEL5XqsTuwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630525; c=relaxed/simple;
	bh=YmjootAgKlT4AUdnARxUqy73v9hCZ0Uej/RVPrjCcqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxsMvXpP8y4K2neoTK6cK6+zgeOQ1tIitcC2THzsWTV6q3zZi1sCg57OlvcHatXX33EkLow6SyxSE0dh2DOxNwcDxk60Bw5L6WANEGuUhpN0sv374wl2GzPoTiJlRG7EpM/nH0dB405uOuti9ZVkV8TjCnihZgrpUErt7m06I/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+M8cqw9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84BDC4AF1C;
	Mon, 17 Jun 2024 13:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630525;
	bh=YmjootAgKlT4AUdnARxUqy73v9hCZ0Uej/RVPrjCcqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s+M8cqw9LG2oZoXGCu+Q4ZbIOdGhCbSlh00LHUKzzt5vfzt2M7tMozAMxgMCnwUyc
	 Y12frsWyASEc7Z0yOc87bgFpyOITpOJy5wVmkG5RdYJ3o/BUFqOeVlwB3zpSzNxzKa
	 EpS4WLRm7Hh4DmUID6K9dRFQGzGxAhJJZcvVXyhI/l1fgHnAtJPythkcV4Zy6PKGkM
	 3+3pckq+Ij7O5EpEWRBhjLMWcbbuYPzUEU7/XcWPIgY+yzzWYOQSGfn8wPuxAglI6i
	 Rmkp6y2+cwo2OQ7QWHtZ1MceVnzA6cePZuc9SGIDOGEqjCmtS6k8ahnOzWxHI+r9XI
	 ZUQrtU8iHoQmQ==
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
Date: Mon, 17 Jun 2024 09:19:44 -0400
Message-ID: <20240617132046.2587008-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132046.2587008-1-sashal@kernel.org>
References: <20240617132046.2587008-1-sashal@kernel.org>
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


