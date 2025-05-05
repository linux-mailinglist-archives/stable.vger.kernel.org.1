Return-Path: <stable+bounces-140931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CB3AAAC8D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE38467465
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465DD28C2B3;
	Mon,  5 May 2025 23:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUUzTdPH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0D53A0133;
	Mon,  5 May 2025 23:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486924; cv=none; b=DTrCrLjCwtaHjxd32ZaQ0Yf/J4GPDjrlhyPdZlmqMLPDElDjvjXuUmYEEIjZV3BqkLFOTxYlG1MWWkkUbGy5v0pIbJoHLmc7lSepNyjnxBjReA/0QcBXkAlJQ4CXxIQFuUGzF3Knf0Acuhh55XvEMVQN5u3zXWbk0bi7HCOebRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486924; c=relaxed/simple;
	bh=pxt1vUwyhbVDVIH4B45gFvaUMGnvP+TYbfp1Y6nmaow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C4sl0si8UNBEyvggTVC8C0dlO3hog3WpR+OtQrIsfFPk0Xy1QEJdzBdHFU9RW7mvUou+LAEvowkapqspjbqDch2oPJm3FJWsV+TVEcAycCWj7M69T1Waf4kBBEO8ZMuKtBFtLTJHIQvUe+4gp85hbchaP8lZCIQ6hPoqFcIceOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUUzTdPH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CECC4CEEF;
	Mon,  5 May 2025 23:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486923;
	bh=pxt1vUwyhbVDVIH4B45gFvaUMGnvP+TYbfp1Y6nmaow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GUUzTdPHxqIYjMUoo2lC+IuRVftpzQjY3AW0K3uMJ665YedfRZlD/bOXqnDETFe4E
	 U5jkMZY8Oje5MQg4DRcmdlcxOyvBHjCf3ialHB9W3K5zEh8yoIFLybtvKdJwdNh2Jg
	 w5P8D3HGxzLIGh64Mif2A4U/40QL3C95SVqDeYCv7XrWzBho+iYbiWEykc6EC048RM
	 WvnLCN4qCPMbQiW0pi3tGYVMACeT3OH+hfF5QGTjD7GnsnbqcTpzJOby87K/2tvOxU
	 0E1s76eRaZW3obwPCguWDxa98Nql/eUDV/KTOegyCaA4zDG4sWqYZY0jhLiVZ6WXnQ
	 1xmN2xG3BnbIg==
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
Subject: [PATCH AUTOSEL 5.15 061/153] ARM: tegra: Switch DSI-B clock parent to PLLD on Tegra114
Date: Mon,  5 May 2025 19:11:48 -0400
Message-Id: <20250505231320.2695319-61-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index fb99b3e971c3b..c00097794dab1 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -126,7 +126,7 @@ dsi@54400000 {
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


