Return-Path: <stable+bounces-140843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3850AAAABF5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24FF1A86B09
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B671037F942;
	Mon,  5 May 2025 23:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIdM5hwz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B474837F0BF;
	Mon,  5 May 2025 23:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486541; cv=none; b=TF2YYIsCEpfwYa0ShGGuPqbdYGAUjZyt/vE9WvSJCho9S7BegHKE9qambydzaNrGkkFyGTRaj44i5JljmstKo/FlxsbgXY2eaJstCC6x98uChB/ZnnIFEqaqrlYh+pRRfJmoBT0oYSF2DCPuE472zQpwtw1a1DRwK3PMPSHETTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486541; c=relaxed/simple;
	bh=otf3s4N0RZUh+MpY/D9yLl+SuE9qqAD+ne/e7haR7Po=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e4jL4I5/FMe6QBLNe8iYS6c9orbHekVteXfXoUEu46TfFqylTVtudfYOxvt+QBOEkZV8kLx84DxvYuVgqlmZjQkqZ+DlQHeqqgpIzGLRU8qX6RefAjaqiONVvRt5dwbEtXoI+rt7uWAkOXqGwJv7XpC875pvTekaIeVC7UuqcjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIdM5hwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D94C4CEED;
	Mon,  5 May 2025 23:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486540;
	bh=otf3s4N0RZUh+MpY/D9yLl+SuE9qqAD+ne/e7haR7Po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IIdM5hwzrfJYggwigp1jXXB77+S974h51jBm28N3nGwEYEDZ/AbeyLrl18OPDzKXH
	 lbzcc19Pkvamf0rHQO+MmQ33EirluNsWfjwJ45Vw+8d6XdwkQYrcFisTyJ+uvBFNqk
	 laMtGP+85WGLn7G3EwakB43/sWiZXPW3AmYUBtLZuLhepmZxNCEIQJyk31lz7XqgSo
	 B/Tz0RJ/QaHSN0G6EzzL7FJKWAYF6epBQiD56ixcoWDdhwzYHZyOkDm2f3rPnYBj+y
	 fZ5NibUr01WljZvBpF6+YY6vR5wHG+GUIOLksPAk15GwUr2Hkr2OEIxtk3j7FNjWj6
	 +w6kRcgVoVUVg==
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
Subject: [PATCH AUTOSEL 6.1 080/212] arm64: tegra: p2597: Fix gpio for vdd-1v8-dis regulator
Date: Mon,  5 May 2025 19:04:12 -0400
Message-Id: <20250505230624.2692522-80-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 634373a423ef6..481a88d83a650 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
@@ -1631,7 +1631,7 @@ vdd_1v8_dis: regulator-vdd-1v8-dis {
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


