Return-Path: <stable+bounces-141725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15516AAB7E8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE541C25173
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906F234D648;
	Tue,  6 May 2025 00:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxqhYEVH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27823BBDA3;
	Mon,  5 May 2025 23:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487362; cv=none; b=CUguxMLBd7t7r6phfqU3ae7RW3fgmfDnJ6EWB3O3cXuv0al84ZfikhWM44lkJOoCMuwe1UaOiMlu4tSyB3ZK6rqmJlh6oLfkkcxk3PQ7em16DK4TkA/OwN19SKkzMDqnGHqWwQB9yjDxu3exAL1PN+Hl+7kfbcuTKfujqbHr8eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487362; c=relaxed/simple;
	bh=ZztsGYn9Zhzs7edFt/EwPOC7cIZjrhxJ3HKzmyw/HUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NQm9ERN/ngjnvYtFJYG1qy+rGhCJEIGwtRnLSEFz3YVQqcZlZeKp26icyEYPcmHCHCRe1r4GcCnLfhaj7H27Am0Y6KJXf6R7E0oFYs07no/+XXj+7VFghPXJ2h5sPXp24rl/8rrRMlyaibExLeiKJFIY4/kSNVBzNvrYcy0UjaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxqhYEVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49487C4CEEE;
	Mon,  5 May 2025 23:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487362;
	bh=ZztsGYn9Zhzs7edFt/EwPOC7cIZjrhxJ3HKzmyw/HUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jxqhYEVHx4JeC0KjvDldGg7pNJhOjaFiLSZWAdSR/gs6DSjRXUrWVHY8srGYi8Wof
	 VgiVCeDCRFB3dqfxBr92jd8ZPzuIKf81MrA0f55tRPFSbEhPW7O9QHy2ZVXWq95KGZ
	 9FqNM4FVPccaHR81uheyZLRzummLlmA3dzzGNsT7rYyjzfCTA8lEkebCPv8owmj5Zm
	 1f02m5NHStPot3aHPIL8vF0Xymo1VDxiLaWpVlJD61XEIvlJjv9YLGzrqN07ONHbWc
	 X3pvTLJ9y9CI+96SqiZtoC5q7jH1ROlhWeWh1bZjrqTulZzEyObptkIgBukdo1FuU7
	 DNuaUM9+7BY9g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Svyatoslav Ryhel <clamor95@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 30/79] ARM: tegra: Switch DSI-B clock parent to PLLD on Tegra114
Date: Mon,  5 May 2025 19:21:02 -0400
Message-Id: <20250505232151.2698893-30-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
Content-Transfer-Encoding: 8bit

From: Svyatoslav Ryhel <clamor95@gmail.com>

[ Upstream commit 2b3db788f2f614b875b257cdb079adadedc060f3 ]

PLLD is usually used as parent clock for internal video devices, like
DSI for example, while PLLD2 is used as parent for HDMI.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Link: https://lore.kernel.org/r/20250226105615.61087-3-clamor95@gmail.com
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/tegra114.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 0d7a6327e404a..fe1ebc3c5aa86 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -123,7 +123,7 @@ dsi@54400000 {
 			reg = <0x54400000 0x00040000>;
 			clocks = <&tegra_car TEGRA114_CLK_DSIB>,
 				 <&tegra_car TEGRA114_CLK_DSIBLP>,
-				 <&tegra_car TEGRA114_CLK_PLL_D2_OUT0>;
+				 <&tegra_car TEGRA114_CLK_PLL_D_OUT0>;
 			clock-names = "dsi", "lp", "parent";
 			resets = <&tegra_car 82>;
 			reset-names = "dsi";
-- 
2.39.5


