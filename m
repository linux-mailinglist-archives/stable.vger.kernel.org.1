Return-Path: <stable+bounces-11616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A533382F9BC
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 22:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEB42B2350B
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 21:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C036560879;
	Tue, 16 Jan 2024 19:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPxBCWF+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBCF60871;
	Tue, 16 Jan 2024 19:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435014; cv=none; b=ZzuGbkewNn+yqICvcs9X4gSi04QbbC6otQu1NxUZPWany/Ik4wNWbL5ZVsPiWDBJ7bn3moLfofEw5wovTRY5FG8taIIz2S/jtrPXCWG/CNMZQZoB8bY9WVsBiLLTGDw9b2Sq3EGzZjE7FaloNjlNmJSYkxZGE0Qm+iqYB/E3vG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435014; c=relaxed/simple;
	bh=+0dGaX1WomVTx+JiBsBfua71kEuDLYrscLBuSIfB700=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=St2X/g/lFifSxg0AULxt7wgYZ/Cf2G0EqCNmLltgD9YIvzQgVxVeoXNGda6/6ze2TeMhqTw6JnaaXc6V4EphP3aOIK0c1t6qmBtmLjvOfCT7Iaw8gUNEEK6YFx6Y9XLCtAmjhG01nBgvXi/Edyd1E0/jXzbvXcDFgwnu3dqUWHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPxBCWF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB39C433C7;
	Tue, 16 Jan 2024 19:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435014;
	bh=+0dGaX1WomVTx+JiBsBfua71kEuDLYrscLBuSIfB700=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lPxBCWF+RTYY5WbcJhmfbjnBJ060q+y+nN3A2yEjpQAX0nOQfVOgUG1v+s5sJmf/R
	 LPo+hs91zVYwxXwjK54mpmbm3DIMmzMvETOmJG8f/ebKyynfi2nqqu6mzhRC9bdM33
	 oYgcy7rU6ErENgu7ys5+u2V2P8rnAsKRXQz4YHXH5RqBBgFALDH/sEN4Xaj/srbwUr
	 g9RPVd3e4OajRpd6hF/t/W6l4n7BdvMHcKlEZToZmfhizZWRZCcdWqYMLK1Eqb+ucT
	 Emj+BTRQxEqHNsfNfh11rFnfcWfr7R4zXNWX6Sq69yM8RMobZ2ocggpg8HKMNHhYIm
	 4c2jSHUJeNqjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fabio Estevam <festevam@denx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 42/68] ARM: dts: imx27-apf27dev: Fix LED name
Date: Tue, 16 Jan 2024 14:53:41 -0500
Message-ID: <20240116195511.255854-42-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit dc35e253d032b959d92e12f081db5b00db26ae64 ]

Per leds-gpio.yaml, the led names should start with 'led'.

Change it to fix the following dt-schema warning:

imx27-apf27dev.dtb: leds: 'user' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/leds/leds-gpio.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx27-apf27dev.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx27-apf27dev.dts b/arch/arm/boot/dts/imx27-apf27dev.dts
index 68fcb5ce9a9e..3d9bb7fc3be2 100644
--- a/arch/arm/boot/dts/imx27-apf27dev.dts
+++ b/arch/arm/boot/dts/imx27-apf27dev.dts
@@ -47,7 +47,7 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		user {
+		led-user {
 			label = "Heartbeat";
 			gpios = <&gpio6 14 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
-- 
2.43.0


