Return-Path: <stable+bounces-118429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EF2A3D9C9
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 13:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC9919C01C7
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 12:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702F41F55FA;
	Thu, 20 Feb 2025 12:20:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C706E1F4635
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054046; cv=none; b=MaUoTEqi92CjD9EjyHVnQ+MIJ9qY4JfTjRIbIZeHa8bMlXzhiY0EQCqQChQxTu8AiQElLKXFeJQ4vT8TbwNdXvx1KGIv7oe68eUGzqrNJWNqKzIZcE3jzKk/jsHjfesf69LTTGg8uoQ1G96OWf8eeHbIoelpT87dsyu/JKBemcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054046; c=relaxed/simple;
	bh=RXAxhxVzfrqG1qHIsuf8PzuIRfypisrlFp/ZVrBCPRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XKZQkDvRoqf0sMunICPS40CJQurg1Fl2ZOYxACW79e76HvHHlMB3cN5LmOLRnfhnKkubb0oGre/t6i4u1tCKyNLB3gQtIaBnd9XHXfCR4MG4D2FyXr+3W3mXAR+m+h09j2g9sLHSJ2dGFCPVQl7vQlliQuSuYhn2XOxYOissgGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YzC5b6L7Zzpd8;
	Thu, 20 Feb 2025 13:20:35 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YzC5b11GfzGGs;
	Thu, 20 Feb 2025 13:20:35 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Thu, 20 Feb 2025 13:20:10 +0100
Subject: [PATCH 1/5] arm64: dts: rockchip: fix pinmux of UART0 for PX30
 Ringneck on Haikou
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250220-ringneck-dtbos-v1-1-25c97f2385e6@cherry.de>
References: <20250220-ringneck-dtbos-v1-0-25c97f2385e6@cherry.de>
In-Reply-To: <20250220-ringneck-dtbos-v1-0-25c97f2385e6@cherry.de>
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
mode, a later commit will make UART5 to request the GPIO pinmux.

Fixes: c484cf93f61b ("arm64: dts: rockchip: add PX30-µQ7 (Ringneck) SoM with Haikou baseboard")
Cc: stable@vger.kernel.org
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
index e4517f47d519cc08ec9ee705a6f51a740687f6df..2321536c553fed20bc02d91f40a5d5a6dc20892c 100644
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


