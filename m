Return-Path: <stable+bounces-169788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DE7B284DD
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 19:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C74A5A1EF8
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 17:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3BC9475;
	Fri, 15 Aug 2025 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmXGSFyv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3712F9C3A
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755278636; cv=none; b=Ny7RdTibZBTLorbZGK+AIldKefBamgBL8KFl6p8EyjeCYzMQniNEdrrbvRWHBXVDVWh1rjnZeCQxNa/8aIMBmv99R0bjDgowMkLcabj5hS9w+Mg61rjZfbUlL0iXPoMPbis9UrNO54GFplZHM+V+jkDxXALE4nrAm5njElc+4rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755278636; c=relaxed/simple;
	bh=nPNAw1ebohRQbl3MWMABjupbtroIHJKkpN6/yBih19g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmNOjbDA0dxejY0ODx2lHXbaRKV1xGm/820Nd+L+p/8rgSyfQMEDAMIO3kg6AYZMm+8Vq14zmwCBn+aFz8/Yk+docGV92xZdMRbTsEA5EdKOt1PAe+H5HamzXNlzpE2HM5pGRAhz7q30eO4ntroN9xa01bF+sJWoEKUXBXX723M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmXGSFyv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2128FC4CEEB;
	Fri, 15 Aug 2025 17:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755278635;
	bh=nPNAw1ebohRQbl3MWMABjupbtroIHJKkpN6/yBih19g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RmXGSFyvS3Ecc3iDCrSMYbK1BVjyZV3LwXJ/ZaQmoZlwyd3igMO7HLSQWxegJFPIu
	 6d3cMcEju9MIjp35IGTEFUypYnXkwE5mZYXu5YSWRn3iKLsH89+3i2RHj8qYyfKfPR
	 x6eVgrq8b4VPkT5Y5u/xf96qgvNf9cCyi3CDlg040DHhPRDMF7QM0awvD75w/Yzxnp
	 OIpxPwKvS7YFCaUcfrsfNWsebIFUYgsdfWy5+QdHY8qztg4+7iBxxMgkRlwdkOBr98
	 SocRQCYm5+uP/pXAPahP7BAQGAxIkxp0midPGZ5exlsdFHiMR+N/wcRYvwT6yB1ekK
	 /bRRh4bgYA8Fg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hrushikesh Salunke <h-salunke@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] arm64: dts: ti: k3-j722s-evm: Fix USB2.0_MUX_SEL to select Type-C
Date: Fri, 15 Aug 2025 13:23:51 -0400
Message-ID: <20250815172352.165389-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081521-dangle-drapery-9a9a@gregkh>
References: <2025081521-dangle-drapery-9a9a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hrushikesh Salunke <h-salunke@ti.com>

[ Upstream commit bc8d9e6b5821c40ab5dd3a81e096cb114939de50 ]

J722S SOC has two usb controllers USB0 and USB1. USB0 is brought out on
the EVM as a stacked USB connector which has one Type-A and one Type-C
port. These Type-A and Type-C ports are connected to MUX so only
one of them can be enabled at a time.

Commit under Fixes, tries to enable the USB0 instance of USB to
interface with the Type-C port via the USB hub, by configuring the
USB2.0_MUX_SEL to GPIO_ACTIVE_HIGH. But it is observed on J722S-EVM
that Type-A port is enabled instead of Type-C port.

Fix this by setting USB2.0_MUX_SEL to GPIO_ACTIVE_LOW to enable Type-C
port.

Fixes: 485705df5d5f ("arm64: dts: ti: k3-j722s: Enable PCIe and USB support on J722S-EVM")
Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Link: https://lore.kernel.org/r/20250116125726.2549489-1-h-salunke@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Stable-dep-of: 65ba2a6e77e9 ("arm64: dts: ti: k3-j722s-evm: Fix USB gpio-hog level for Type-C")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index 710f80a14b64..f063e7e7fd8f 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -495,7 +495,7 @@ exp1: gpio@23 {
 		p05-hog {
 			/* P05 - USB2.0_MUX_SEL */
 			gpio-hog;
-			gpios = <5 GPIO_ACTIVE_HIGH>;
+			gpios = <5 GPIO_ACTIVE_LOW>;
 			output-high;
 		};
 
-- 
2.50.1


