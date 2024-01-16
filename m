Return-Path: <stable+bounces-11469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C84982F743
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 21:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39BB81C2483C
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 20:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB23E7FBC8;
	Tue, 16 Jan 2024 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twXVq/PD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636A17FBBF;
	Tue, 16 Jan 2024 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434429; cv=none; b=C4pAoDbYkNOn6WdD/R27Y5o6dNq/XsMbtICz5n3DxzU8HFGEGkXEy4oCRxQB5s51bvNGMMQxXRUWdDOEIq5ZztArBaXWesBqKsw8PBcAUfZfWQu7SBKW8IBwPI8/oWlq2H5V6fZVbaI1jmMbFYmbq+tDGrSDblbx4kLpvrpu2Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434429; c=relaxed/simple;
	bh=ImwsUSJ4sDJoPPMy6FyHLHga57K6HRPtG7DKT4WNcJ4=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=V8PFDBcS6iob+gfoAz/8voFQtCzDq3bv7Bs7AtfKqKdHJkdO92XNTAgboNt9o+UDsWfgQ28VbBx4hbSRUAfoxPPGD+PO5JuewWETBRtiozqo7F/V8d2HUbCBK84oP1BZW4oxafD/wTLXwX3k+OF8xVtM25HMqB7MuspIfkSe5U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twXVq/PD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68A8C433B2;
	Tue, 16 Jan 2024 19:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434429;
	bh=ImwsUSJ4sDJoPPMy6FyHLHga57K6HRPtG7DKT4WNcJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=twXVq/PDAhvx2n8YlILwdGB2YF0Hu7Aninfztdyh7gj/yQK2hzwx+G0XzIUsZGJgZ
	 yLMxrKxn2f6IzOtrGvsclXLM64tSZZCf9OyALgx+bS7n9H6tBOKDet/1SctjidDJgv
	 tmTgqiuVBrYUjMH0gg17X2gm20MoNmDD9/Fy4rSLTiaFyKIb0aitPkkR6viMmCHrnw
	 U9ts/uZxpaYA/1S/vK6kscruemrseNs7PJL3XHdzlUlPXbfCCWCeL+tr2pbWoKs3K3
	 bRjfAyTC22dU4eDvYa7jqe9FDqdoYJTjTTNkgL+L5S0MR8LmcmHSdzCpehOMAV+iTA
	 pOctnMmiJ86Kg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>,
	linusw@kernel.org,
	kaloz@openwrt.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 108/108] ARM: dts: usr8200: Fix phy registers
Date: Tue, 16 Jan 2024 14:40:14 -0500
Message-ID: <20240116194225.250921-108-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 18a1ee9d716d355361da2765f87dbbadcdea03bf ]

The MV88E6060 switch has internal PHY registers at MDIO
addresses 0x00..0x04. Tie each port to the corresponding
PHY.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20231020-ixp4xx-usr8200-dtsfix-v1-1-3a8591dea259@linaro.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ixp/intel-ixp42x-usrobotics-usr8200.dts   | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/intel/ixp/intel-ixp42x-usrobotics-usr8200.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-usrobotics-usr8200.dts
index 90fd51b36e7d..2c89db34c8d8 100644
--- a/arch/arm/boot/dts/intel/ixp/intel-ixp42x-usrobotics-usr8200.dts
+++ b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-usrobotics-usr8200.dts
@@ -165,6 +165,24 @@ mdio {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
+				/*
+				 * PHY 0..4 are internal to the MV88E6060 switch but appear
+				 * as independent devices.
+				 */
+				phy0: ethernet-phy@0 {
+					reg = <0>;
+				};
+				phy1: ethernet-phy@1 {
+					reg = <1>;
+				};
+				phy2: ethernet-phy@2 {
+					reg = <2>;
+				};
+				phy3: ethernet-phy@3 {
+					reg = <3>;
+				};
+
+				/* Altima AMI101L used by the WAN port */
 				phy9: ethernet-phy@9 {
 					reg = <9>;
 				};
@@ -181,21 +199,25 @@ ports {
 						port@0 {
 							reg = <0>;
 							label = "lan1";
+							phy-handle = <&phy0>;
 						};
 
 						port@1 {
 							reg = <1>;
 							label = "lan2";
+							phy-handle = <&phy1>;
 						};
 
 						port@2 {
 							reg = <2>;
 							label = "lan3";
+							phy-handle = <&phy2>;
 						};
 
 						port@3 {
 							reg = <3>;
 							label = "lan4";
+							phy-handle = <&phy3>;
 						};
 
 						port@5 {
-- 
2.43.0


