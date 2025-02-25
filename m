Return-Path: <stable+bounces-119490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9EEA43E64
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 12:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ECDF168CFA
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 11:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE0C267738;
	Tue, 25 Feb 2025 11:53:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9BC266EF4
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 11:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484433; cv=none; b=X3X4BGbBngLMsfkNQBVlRY26WRi2NLuUbmIJC48UNegtasBmFZ3xyzYEf6MtO2tuzV3kSmy19Jf4mvrc9/LS4NEChaEgviDH8WK3AKynnhLxaOGpsdEZJ+tPg91SWVN70w697TNmDZYhDhmnjaO0Km1M92J9Z9RdxkJ9ygErviI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484433; c=relaxed/simple;
	bh=QJHAbSlXMItehxt6Q/gk7ZMR6FhGrF/LO/R6H6FIe8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LtM1KUXLpqlXGhyGMzVGI1YKmzL0tlK+mcgwopC0MFElVZZjhvwZrMAteUKW78F/ThRXX8amQGtcZPssUUuI+MhC3lq3j+HZF2ewhdpnfhf5AwS0xdnC5WgYb5xO4uc8es/H1o+R0mtZDvpldc2FtDcAZcwdkWzWtBkh6MkxDT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z2GGN1zmGzPp2;
	Tue, 25 Feb 2025 12:53:48 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z2GGM4bc9zCcj;
	Tue, 25 Feb 2025 12:53:47 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Tue, 25 Feb 2025 12:53:29 +0100
Subject: [PATCH v3 1/2] arm64: dts: rockchip: fix pinmux of UART0 for PX30
 Ringneck on Haikou
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250225-ringneck-dtbos-v3-1-853a9a6dd597@cherry.de>
References: <20250225-ringneck-dtbos-v3-0-853a9a6dd597@cherry.de>
In-Reply-To: <20250225-ringneck-dtbos-v3-0-853a9a6dd597@cherry.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@cherry.de>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha

From: Quentin Schulz <quentin.schulz@cherry.de>

UART0 pinmux by default configures GPIO0_B5 in its UART RTS function for
UART0. However, by default on Haikou, it is used as GPIO as UART RTS for
UART5.

Therefore, let's update UART0 pinmux to not configure the pin in that
mode, a later commit will make UART5 request the GPIO pinmux.

Fixes: c484cf93f61b ("arm64: dts: rockchip: add PX30-µQ7 (Ringneck) SoM with Haikou baseboard")
Cc: stable@vger.kernel.org
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
index eb9470a00e549fc107603be216a5f714914e7a2c..9a568f3d0a9916dff22222c59e5e0c94ce226858 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
@@ -222,6 +222,7 @@ &u2phy_otg {
 };
 
 &uart0 {
+	pinctrl-0 = <&uart0_xfer>;
 	status = "okay";
 };
 

-- 
2.48.1


