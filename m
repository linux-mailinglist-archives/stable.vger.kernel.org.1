Return-Path: <stable+bounces-168827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84005B236E6
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3923E7BC694
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06C01C1AAA;
	Tue, 12 Aug 2025 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NC7JyGSd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7132A26FA77;
	Tue, 12 Aug 2025 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025466; cv=none; b=d/VdEFD5HFvUYymla1MPz/JpOvOpaijXveeCcjiUzWDICOsnx90EYIkBwwL1k58zU1UBnna/XYtz4Plu7XMonduk6hp82ITtEzEbQsTfU5i9z5ls7jC/VswU/vYqpEyB4L+almMTAm5828Z8vsAf+8dbL+UK3FdeCpatinsu9xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025466; c=relaxed/simple;
	bh=x8HqbRPLKTww+8stjIMBQNsPSd2nQasEMwQpKCnjGdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Safa28/KaUS74z/fu5MR4qjhjkNQPTbZLgjDQ7aWrtjjmMOIPDB08UcK18W+Xrji4af3i7WcNmUlT+Wdwt/F61XKUfAaZI07AIuPQgQDyu9+UWjXqeTs9ydkLrEWkDNQ9p/SXD70OrbAqGRNCN7m4VvhO8WOLwsnUlCtQlBjnbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NC7JyGSd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A4BC4CEF0;
	Tue, 12 Aug 2025 19:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755025466;
	bh=x8HqbRPLKTww+8stjIMBQNsPSd2nQasEMwQpKCnjGdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NC7JyGSd/s6YvFtOaoSAx/qeb7zgaA9J6elHfOP9hh4Fo4vsczfy4969GCpKwIawa
	 tZLgRBxEp25w7Tj0Wflw/YhKaRMdtODZIw7XTEdu59/C/FTNLM5tdm/akW2HO3T3Xy
	 trzbsGLTqgfVMnhXI8TiI45eUdHDaMYxg3QhKo1I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryan Wanner <Ryan.Wanner@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 050/480] ARM: dts: microchip: sam9x7: Add clock name property
Date: Tue, 12 Aug 2025 19:44:18 +0200
Message-ID: <20250812174359.463755963@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ryan Wanner <Ryan.Wanner@microchip.com>

[ Upstream commit 2e24723492b28ffdccb0e3e68725673e299e3823 ]

Add clock-output-names to the xtal nodes, so the driver can correctly
register the main and slow xtal.

This fixes the issue of the SoC clock driver not being able to find
the main xtal and slow xtal correctly causing a bad clock tree.

Fixes: 41af45af8bc3 ("ARM: dts: at91: sam9x7: add device tree for SoC")
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Link: https://lore.kernel.org/r/036518968ac657b93e315bb550b822b59ae6f17c.1750175453.git.Ryan.Wanner@microchip.com
Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/microchip/sam9x7.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sam9x7.dtsi b/arch/arm/boot/dts/microchip/sam9x7.dtsi
index b217a908f525..114449e90720 100644
--- a/arch/arm/boot/dts/microchip/sam9x7.dtsi
+++ b/arch/arm/boot/dts/microchip/sam9x7.dtsi
@@ -45,11 +45,13 @@ cpu@0 {
 	clocks {
 		slow_xtal: clock-slowxtal {
 			compatible = "fixed-clock";
+			clock-output-names = "slow_xtal";
 			#clock-cells = <0>;
 		};
 
 		main_xtal: clock-mainxtal {
 			compatible = "fixed-clock";
+			clock-output-names = "main_xtal";
 			#clock-cells = <0>;
 		};
 	};
-- 
2.39.5




