Return-Path: <stable+bounces-140927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FA2AAACB3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8703B5989
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB63C39E20E;
	Mon,  5 May 2025 23:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIC+jLOP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B402F419D;
	Mon,  5 May 2025 23:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486916; cv=none; b=bvoiu/eGUxjRvxx6WWIs4ae4GQdqdwq6A1yzsyLsI9ltMhjQqeJACuvy0u2dbJH7dzr5dAcORfgQO/STWM2IltZ8dRmfVseo/NVGaFkL70im46nkoKAbNbhM7ELnbc9k8C4BgMwxuL/WGOtYoU8ah5vrqywPaxuj5Z1tE8K9J0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486916; c=relaxed/simple;
	bh=caq7CBu5Lg5Kof0Mdnp7L1kax7V+jqELVJAntISz4vE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cPlCicM1AUAcM67FKUaTqwd050s8mIFkMnQosB/L0O+YKEtUNh1uJ+8d8NRUL9wZjFm2NWD2dWzEJM/iKJHPsVik1djfZmlVJQ2lTM5yYmfMmc8olVSvrF5nD3QmZ9yTyxsyge0wnO6Yn8dgpUfy68md0bPg4XtcTbXTtJseszY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIC+jLOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE60C4CEEE;
	Mon,  5 May 2025 23:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486915;
	bh=caq7CBu5Lg5Kof0Mdnp7L1kax7V+jqELVJAntISz4vE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UIC+jLOPf7dj/ydhUSHABOvsa//Y29OhZe1zWOvaH7QSzYVhWBjYhOVdytgouSFBD
	 V30Ny7HBMQLYS5sKL6Pf+G2R6pkBXreKfeAYlukoJXOjX3dTpZKeXtQYA31kng5uJj
	 2fDproEYzSN5T1b60shybbfZTsudAHAOeErJ/oX9wGZp8Xub+jV9Cq0x+QUu08tqGc
	 xCBQdzLzhQvrkgpBhU907iUhkuNp3hKZ58DBEIhoYD5rYcA9OQrPK+ruNfPrFjePp8
	 ERcp19IGQbdstkPeHrF2YlltKOxnI3a+Rx2S64ZG0yE/2wH4pKVSUFD/gqsLW7VqBj
	 cMCWe2+Bm/E1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	tmn505@gmail.com,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 056/153] arm64: tegra: p2597: Fix gpio for vdd-1v8-dis regulator
Date: Mon,  5 May 2025 19:11:43 -0400
Message-Id: <20250505231320.2695319-56-sashal@kernel.org>
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

From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>

[ Upstream commit f34621f31e3be81456c903287f7e4c0609829e29 ]

According to the board schematics the enable pin of this regulator is
connected to gpio line #9 of the first instance of the TCA9539
GPIO expander, so adjust it.

Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Link: https://lore.kernel.org/r/20250224-diogo-gpio_exp-v1-1-80fb84ac48c6@tecnico.ulisboa.pt
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
index d8409c1b43800..4abd8b14b8a5c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
@@ -1638,7 +1638,7 @@ vdd_1v8_dis: regulator@7 {
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 		regulator-always-on;
-		gpio = <&exp1 14 GPIO_ACTIVE_HIGH>;
+		gpio = <&exp1 9 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		vin-supply = <&vdd_1v8>;
 	};
-- 
2.39.5


