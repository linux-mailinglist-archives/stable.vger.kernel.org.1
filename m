Return-Path: <stable+bounces-141690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE58AAB5AD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178D63A4A27
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5481F4A173A;
	Tue,  6 May 2025 00:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFQiUJEo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BAE2F7C4C;
	Mon,  5 May 2025 23:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487176; cv=none; b=qEqR+e44xKnYCC7Ortn0kYbg2m4mWG9oRXp/rEtui0irEaROKg5GTdZcV13N9R0dVUWSjKIscyvdSikNJ2hmIOKqvjF1xdPbmDa71/s8lSxCGbuETTg6z6QbhYe6wUiQSoDB7o0QRTvVpbm13e08JRzTJQySZZRhuu2PqJu5bqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487176; c=relaxed/simple;
	bh=pxt1vUwyhbVDVIH4B45gFvaUMGnvP+TYbfp1Y6nmaow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NglIW0yZyY5ZdJZB5gfMoEQN79t3sJSc/bMDLpccQv6InjTIKnhLWmomr5GL0m4caCBjuBZ/ue9kFXQtqV+d7mQaUDhCWO5W94rxd43we0Ks4bghgJQE6OQAueLG3RBAig6HCR4TeyKBbxh9PppiXLW5pxtcgMQkFybIyfnpuXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFQiUJEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF450C4CEEE;
	Mon,  5 May 2025 23:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487176;
	bh=pxt1vUwyhbVDVIH4B45gFvaUMGnvP+TYbfp1Y6nmaow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IFQiUJEo+yQ8etA2ruA466psTfeh5IeOXRr7cqsR2lHm7ANGgoZU/ZmofmBuUTtQ2
	 np61feDcrma3OSFUpVbC7nk4aa17O17kabvbiFHkgXcZtiDg0XUzcGGWlmpj2Z86wn
	 b2M9zaqsHQ72ogiB+omPBAFuBH0t6TMNFCARuuSRd0r6NcR8Z/SmlvPfnkjUbIM4kx
	 rAWI6WHP/Id28ykpgRzbW7FVszWQZRWmR/a2YmXu2+2ov9TLUkVL4X4hLal3xJHjkD
	 kIzwUfkqogDceOuFQYDoWMCVOtHvKCwsmkqaEwt9HRmPC2/NO+Zp1FXDoQgj5B6E6U
	 lGlDNng+tZ8kw==
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
Subject: [PATCH AUTOSEL 5.10 042/114] ARM: tegra: Switch DSI-B clock parent to PLLD on Tegra114
Date: Mon,  5 May 2025 19:17:05 -0400
Message-Id: <20250505231817.2697367-42-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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


