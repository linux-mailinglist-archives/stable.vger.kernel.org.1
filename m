Return-Path: <stable+bounces-169789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D23B284DE
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 19:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011DD5A1F06
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 17:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62550143756;
	Fri, 15 Aug 2025 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ticg+z4y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221F52F9C3A
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755278638; cv=none; b=cMWEM7HLEk70O3dqLRdoniSIAVoHcMgBw00Ku1pfjl+co60FEml219RAIR545LnLj3xS5VFjnK4GcuwwKKvr1UyPgS2xIGMWuFaXvZ8378FTwUzcKqj78WzmFvPBcOad7fP+xMupz+dQ+F5sxDohokE5bYfYV+0EtBxYJ6Jyl2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755278638; c=relaxed/simple;
	bh=ql/PS8M4/I1NVFiWZy6htRwC70EwNxT6G3S/vy/Dtoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOI7QOlSBcMpDv7kIYh0hnm4fTq8Gudml9Cpq0TuukWmwjQqZnaRnI3QRmPTpTQtSS+/UApt6S6U5GD0zRZQgiJXCt1z5gZN35IO2d01FcRwRWFyUi4NJMQQq0DkS7d5UsOLdzJysE+9TlpXlANtxKZRvnQF9B60GKImSZvGIIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ticg+z4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BD2C4CEF6;
	Fri, 15 Aug 2025 17:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755278636;
	bh=ql/PS8M4/I1NVFiWZy6htRwC70EwNxT6G3S/vy/Dtoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ticg+z4yzR+SOAPezhLtBYwxvGHIEXyW+3wwrcm5TxVYNHCBeHJkqQF/JMkjf1WHa
	 NDladHLFJW2tyAz5bGUm29erzWTeqJU/5hcsx0APmMdv3oT5Le6F82CwUsHe1mqex/
	 DW8AO3bK2K1M4zuiHJmYP7lcCdyqv9nYl9HpqedUagayS6z1n4/FGbV7EiYDpej3Yq
	 ELtWLIZ4mS3ru3/cexzKjrSRg+cA/EPTUO2xz3pRHLx1OpJUW38TV0t7pZhIu7RXQ2
	 +kHP+BrV0+IW55jzXzO2g3SEcreEGPmaB612PYZw4pBT5hVAW0oVJiwIzt54XPV7S2
	 NeQhfWL0HswLg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] arm64: dts: ti: k3-j722s-evm: Fix USB gpio-hog level for Type-C
Date: Fri, 15 Aug 2025 13:23:52 -0400
Message-ID: <20250815172352.165389-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815172352.165389-1-sashal@kernel.org>
References: <2025081521-dangle-drapery-9a9a@gregkh>
 <20250815172352.165389-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Siddharth Vadapalli <s-vadapalli@ti.com>

[ Upstream commit 65ba2a6e77e9e5c843a591055789050e77b5c65e ]

According to the "GPIO Expander Map / Table" section of the J722S EVM
Schematic within the Evaluation Module Design Files package [0], the
GPIO Pin P05 located on the GPIO Expander 1 (I2C0/0x23) has to be pulled
down to select the Type-C interface. Since commit under Fixes claims to
enable the Type-C interface, update the property within "p05-hog" from
"output-high" to "output-low", thereby switching from the Type-A
interface to the Type-C interface.

[0]: https://www.ti.com/lit/zip/sprr495

Cc: stable@vger.kernel.org
Fixes: 485705df5d5f ("arm64: dts: ti: k3-j722s: Enable PCIe and USB support on J722S-EVM")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Link: https://lore.kernel.org/r/20250623100657.4082031-1-s-vadapalli@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index f063e7e7fd8f..98fc1c0f86a4 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -496,7 +496,7 @@ p05-hog {
 			/* P05 - USB2.0_MUX_SEL */
 			gpio-hog;
 			gpios = <5 GPIO_ACTIVE_LOW>;
-			output-high;
+			output-low;
 		};
 
 		p01_hog: p01-hog {
-- 
2.50.1


