Return-Path: <stable+bounces-158664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 318CAAE96CE
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 09:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D8937A2EAF
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 07:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6562586EA;
	Thu, 26 Jun 2025 07:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ArFG9big"
X-Original-To: stable@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CC817A5BE;
	Thu, 26 Jun 2025 07:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750923200; cv=none; b=ZXDRyCOlngkEsHhRQkylnFXzwR6VmzbewnH07K48tTMcZQkf0+OI5vVGkN6Vh1o/059kPw7yv9ZLWW0qvmNm0w6q17XgJ8jKYbOn6AdWeDf7BPkzzjRb4ti3RDtG3dtbTwLjImvl0kzCQCMacKAmE7uj9A/XQKOulowIqSoVYAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750923200; c=relaxed/simple;
	bh=TmZI+dJjqSOEASAovjfXP+gAUAtkuQbCG5e7pb7o0IQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ns/y1H/0/brfycN4B1M9vdnnA6MKggupR6eCLOQ7nkmHivkR6JyESCTCX4BD1nI60afNABL8jdGaGqmD+UV98QcQjbOViy1mJEA4xrEm7T/Q0pD8YApDfFZvA6nOmBwgPxFCY45X4UR2/Sizoukt4fMyvYq9q1CCEdGSTd3nzRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ArFG9big; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 83370260DE;
	Thu, 26 Jun 2025 09:33:11 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SXotwWpGQbff; Thu, 26 Jun 2025 09:33:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1750923190; bh=TmZI+dJjqSOEASAovjfXP+gAUAtkuQbCG5e7pb7o0IQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ArFG9bigjBmicupBq48TjipjwZXRV2KB8Hlty6N6rrSiih7jNxte1b+K+FRtKGiQX
	 Zkv9Wlql4Fwy+XP3vifZwmsZ/nClj0SvGdr8kt3ZeVfIVjkVVkAetXCLeRdNFs3X9U
	 ImIU6X4cK7JhMApg0JXFhrDpZMUc8k0Rz/dYP0MS2EoPgPWTRG0hXIVwp4I6+avRZn
	 fVn/jwleOFZZ+A2b3svj0g7bf6MrdqinBLX2lxRrRLXzFwP0ayRuwn7qva9woReZCN
	 bUwGwsgwE03Bp6jNuIUznqV6NOEnc46VWxgl5832l5a4Y/VhW+J1qQgMNblI50KSh1
	 iBpMqFMGCJwBQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Thu, 26 Jun 2025 13:02:56 +0530
Subject: [PATCH 1/3] arm64: dts: exynos7870: add quirk to disable USB2 LPM
 in gadget mode
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-exynos7870-dts-fixes-v1-1-349987874d9a@disroot.org>
References: <20250626-exynos7870-dts-fixes-v1-0-349987874d9a@disroot.org>
In-Reply-To: <20250626-exynos7870-dts-fixes-v1-0-349987874d9a@disroot.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, stable@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750923181; l=1090;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=TmZI+dJjqSOEASAovjfXP+gAUAtkuQbCG5e7pb7o0IQ=;
 b=G0kQn22NK2ihs5Tr+HK01RrY6Cc/upBoIeYSQkqR1+XW+Kz7qLP0eb7ZLT50LTe4pRBgbLfsb
 fLAXBaGWFWsCw3DuxpYOoYkZgEkhmK3y1iSApZ03jVLmqZXk38xt83H
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

In gadget mode, USB connections are sluggish. The device won't send
packets to the host unless the host sends packets to the device. For
instance, SSH-ing through the USB network would apparently not work
unless you're flood-pinging the device's IP.

Add the property snps,usb2-gadget-lpm-disable to the dwc3 node, which
seems to solve this issue.

Fixes: d6f3a7f91fdb ("arm64: dts: exynos: add initial devicetree support for exynos7870")
Cc: stable@vger.kernel.org # v6.16
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 arch/arm64/boot/dts/exynos/exynos7870.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos7870.dtsi b/arch/arm64/boot/dts/exynos/exynos7870.dtsi
index 5cba8c9bb403405b2d9721ab8cf9d61e3d5faf95..d5d347623b9038b71da55dccdc9084aeaf71618c 100644
--- a/arch/arm64/boot/dts/exynos/exynos7870.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7870.dtsi
@@ -327,6 +327,7 @@ usb@0 {
 				phys = <&usbdrd_phy 0>;
 
 				usb-role-switch;
+				snps,usb2-gadget-lpm-disable;
 			};
 		};
 

-- 
2.49.0


