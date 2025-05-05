Return-Path: <stable+bounces-139981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFF9AAA344
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A59463DA8
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB4E2F1540;
	Mon,  5 May 2025 22:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwgDwiFY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51F12F1535;
	Mon,  5 May 2025 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483822; cv=none; b=Yx39xrUgqz6OxbrV/TUXXb3ch5yfyvv0diDija6t0xLUfvP39VjVFUreR3p19cV2a8YxRNShq776LODGe24aIADNUfqY2ju4Y0tn6xOQfHR8SF1Fil1GwOTZUlWy3mb8V4ZIEKElGmuSj2EWYJeZb+Qn7hKVX0wNJbPOJRm9+RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483822; c=relaxed/simple;
	bh=o2nRDv428v4MvnR0vHSeeoTJRiIo3h6mJurHS12K5IQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=POxUH7MlF60A4DssHLBzMgqJgaa074lna6I+q69xVnOWnI5ij3+Polnspy4jksjJOXoKa/ghiX2k/eMvCfr4tkEFP2KofF24ADEC13OYnF8UbIa64+uCPGzrlSjDcU/5b8WWlZBR1mo7MUdrZseRD4TaHkChtBeJN3KTQgWKsOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwgDwiFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299E7C4CEE4;
	Mon,  5 May 2025 22:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483821;
	bh=o2nRDv428v4MvnR0vHSeeoTJRiIo3h6mJurHS12K5IQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BwgDwiFYhVzPpKEIrq/Abp7OOaGY1TGW0FAuPw0dLG8DZCguDTlSeGn3FZWfaEO5K
	 IPLAGYQ5IdrFCIPfUvP1oIqJb6Qg8gpzsKoEyB/V33foGRUq0XE36AF/d/c6Y0Qihr
	 9S/+RXqfFmDBz15VaacW5UYXhFNx6mPgeN4DooMyxkpAlcpJ7mZvwnL7tmLGR7KJ9E
	 aQ5qera25xMipbslLVYp/A5REw2uIV6wHh4TVJbTe1Aghacl33e087b29/PgbGF3EK
	 Q6Bf7YrBK840r2dX4ziwE/s9t/cQtzXocqgc6HFyoqy3fpLvK2WAZ7637v1AOcBPzs
	 otCaGEVJBbVnA==
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
Subject: [PATCH AUTOSEL 6.14 234/642] ARM: tegra: Switch DSI-B clock parent to PLLD on Tegra114
Date: Mon,  5 May 2025 18:07:30 -0400
Message-Id: <20250505221419.2672473-234-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
 arch/arm/boot/dts/nvidia/tegra114.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi b/arch/arm/boot/dts/nvidia/tegra114.dtsi
index 86f14e2fd29f3..6c057b5069514 100644
--- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
@@ -139,7 +139,7 @@ dsib: dsi@54400000 {
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


