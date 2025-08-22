Return-Path: <stable+bounces-172420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1AEB31B22
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468A7580655
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C165C2561AB;
	Fri, 22 Aug 2025 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcSV8PKC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CA93054EB
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872180; cv=none; b=IAMQL4vkyRW7d9M57xsyLgWgJ4cSjxP//mrHw7D1oXzQbic5fRmKL/zeN7F+5imjgX1bsteB7lLA0fqulZd6X0e2uqBZsdNEDtZTzl0QoBruMOV00z1HxrvkrpZJex+KZkX4T3jV77NRNtqXiUXJNNiUwasFOgvWCMcViYcKZIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872180; c=relaxed/simple;
	bh=ftPct6eQuh/T8guY+u9kNm4gaUF6pUJVrI6fLpwT1tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YP0n2+DzoLEUPx1fBvivcNHEymS5jnJ+PA287Pl52ZQWTE3nHdrKF7r4OXF7j0rJO8TpbnpWY0rJ/Gj+xCvvQXh81ATyQdFD93YXP2gSrc4G1WRdvOhcGwoI/XvtF+yoTLAT1XTSoCzGwwYz3NBjUsmvtC8o86H/qQX95Gw0GE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcSV8PKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78938C113CF;
	Fri, 22 Aug 2025 14:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872180;
	bh=ftPct6eQuh/T8guY+u9kNm4gaUF6pUJVrI6fLpwT1tI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OcSV8PKC7lRSEZaUnlB/4E+LJZcUqWwQV/X4N7VRbsk+nZHv+V2sq+fmdZZ0ahIKc
	 kIiwJM06jXxCLXH2rdSJuQSjuYs+sg0u4/5bJCr53tnlRB/6u5sBadh7JG1ae3XPFm
	 pL15HoqQkrU7ERpXCyQUNO/bPwW3JgchSQz9rqA0Js/RN13lAPwHynfCfn0KutlpIo
	 3Jx7iIeZCizRMgyki7PTojJt8Jz/j0JVbf/rz9vcwImDv2LiKxsOaDrnfL6Vke9dQD
	 yXRVaz2Bg+r6OfNWCu1Xw6FeGncn2HateRSpOoe6VY2HxLkHY7HF3LdLH6vpiW9z5Y
	 Vb6AqDrOz1RPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Judith Mendez <jm@ti.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Nishanth Menon <nm@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] arm64: dts: ti: k3-am62*: Add non-removable flag for eMMC
Date: Fri, 22 Aug 2025 10:16:13 -0400
Message-ID: <20250822141615.1255693-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822141615.1255693-1-sashal@kernel.org>
References: <2025082104-undermost-dispute-929c@gregkh>
 <20250822141615.1255693-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Judith Mendez <jm@ti.com>

[ Upstream commit d16e7d34352c4107a81888e9aab4ea4748076e70 ]

EMMC device is non-removable so add 'non-removable' DT
property to avoid having to redetect the eMMC after
suspend/resume.

Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Link: https://lore.kernel.org/r/20250429151454.4160506-3-jm@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>
Stable-dep-of: a0b8da04153e ("arm64: dts: ti: k3-am62*: Move eMMC pinmux to top level board file")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 1 +
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts        | 1 +
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index a1cd47d7f5e3..163dca41e23c 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -818,6 +818,7 @@ &main_spi2 {
 
 &sdhci0 {
 	bootph-all;
+	non-removable;
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_pins_default>;
 	disable-wp;
diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index 3efa12bb7254..df989a5260c5 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -444,6 +444,7 @@ &main_i2c2 {
 
 &sdhci0 {
 	status = "okay";
+	non-removable;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
 	bootph-all;
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 44ff67b6bf1e..56d4584b7e24 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -416,6 +416,7 @@ &main_i2c2 {
 &sdhci0 {
 	bootph-all;
 	status = "okay";
+	non-removable;
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc0_pins_default>;
 	disable-wp;
-- 
2.50.1


