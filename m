Return-Path: <stable+bounces-141685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68662AAB59C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5703A9854
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A513A34987F;
	Tue,  6 May 2025 00:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgdmIlaK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753CE272E51;
	Mon,  5 May 2025 23:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487168; cv=none; b=aXN7ga6rNJX5gv7axiBD+P5aG4z0qoAosqYSxYc9Kok5Sr7qge/Nv4wq+xAfv2k1kDfeCSTkoAvUuHr69eomQeknG3EDSbXynKMIw71hvwJYuix/j2Lj/eXSUuxDpx6ZK2HshQ9ULr0HnQ+FrpoZ4YKYhdmHwWlYggOxDg/vsEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487168; c=relaxed/simple;
	bh=Wn/M93AwaZkmc/psVLwJu5hWcPDVyYQStzZWQ0sbA/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GJ561/a6yYEt/OxEOYK6vAPzkySujNH6czCOTecHPJAWgJRNn+iqzg/8ufr6mqFdbbNa9ojrViDUkg2xpeD40WHSIV5K04p8o89D64n5sguvBu0ZqKjjT57V0iQ794p4A0j2wMzA3r8LEd8G3RgNklYxMjOK/PnoYuDh0/tmxuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgdmIlaK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69BAC4CEEF;
	Mon,  5 May 2025 23:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487167;
	bh=Wn/M93AwaZkmc/psVLwJu5hWcPDVyYQStzZWQ0sbA/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mgdmIlaK7A1guFpHzYBVEcv/kTcAMyUPWGY2kmYk1NpjhI1dHwC2UCfNwGmEinn2O
	 pLn+3hgdXM+UHivkEcY1c5YNHyFxodfH2rl+kjd2Rm4RMjM5oGAoW5UUwZaubjQ4+p
	 5RGiKAkPU3XRBIgyEtjp3TBuFAmB2O+ODNgTmkQRrJBkVdppbNQfhI6Qb+D4282UX0
	 B+6/KDD+acbi5hZFEfqruEsgieQVCZJLp6sDXLUD2e32hddSBNAwR10TaPhS/QR9Up
	 6T8zhCl1WlhZ+vipG3qZIWWfgtCrbaePvu/36r24IWVnA449N5IHM8JAztlxcXBXLb
	 37ZCJO1Z1BLzA==
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
Subject: [PATCH AUTOSEL 5.10 037/114] arm64: tegra: p2597: Fix gpio for vdd-1v8-dis regulator
Date: Mon,  5 May 2025 19:17:00 -0400
Message-Id: <20250505231817.2697367-37-sashal@kernel.org>
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
index a9caaf7c0d67e..c04772a9740ec 100644
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


