Return-Path: <stable+bounces-168856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 228BDB236F0
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD4BD7AC22B
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3968F27781E;
	Tue, 12 Aug 2025 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W+S/jhNT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB45626FA77;
	Tue, 12 Aug 2025 19:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025562; cv=none; b=A6WYxk81OxPwCvB1tzgOeZ5OgTQoZEqULcQhA1sv4PmD5cnzroQSZ0d40r3+XETE6y91Qvt7ltDdwx8F4T5XArAh8mhQHaA6qOCtdOjnA6iK5GYkHDtda2m9GPid1JPCPcPR93zIL0VubLTlUCsTt5UoYSLKPXbIiewHMMU80sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025562; c=relaxed/simple;
	bh=VlO3fJm+Q016VMbBm3bAQTyVLIg0wVaONNUMRhGiaww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLyr+2vWWP+ISAy6naFNjYaCd4JZuDlKv36vjS8UxWqFw1Sd8nF634/ep/g/N6bemcVWfoJ1UWuiHLmX5XCN3Ypnn2HdxTTkP7MhPNvmigYzT6ZlKYGkLtNCiVkVIBEWVbxAZtSogVPqD65PdPA2Ix67M3cMxF+CSAPu7VpsEvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W+S/jhNT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA709C4CEF0;
	Tue, 12 Aug 2025 19:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755025561;
	bh=VlO3fJm+Q016VMbBm3bAQTyVLIg0wVaONNUMRhGiaww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W+S/jhNTKxASdGTpBTB+QIrkWHVmKu58m1uo+lmnNcB/ySphFwVNU1LN8pD7Ido2T
	 ATLXR7levruB8wTi5x50BXvnwjGnRzU2ZFumyH2YsleiF2AQPl30OCE8pdWo41mSet
	 XRix0sB+B3G2gJurJZE1AG0270gXD3iXDTvIZxAg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 044/480] ARM: dts: vfxxx: Correctly use two tuples for timer address
Date: Tue, 12 Aug 2025 19:44:12 +0200
Message-ID: <20250812174359.217541547@linuxfoundation.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit f3440dcf8b994197c968fbafe047ce27eed226e8 ]

Address and size-cells are 1 and the ftm timer node takes two address
spaces in "reg" property, so this should be in two <> tuples.  Change
has no functional impact, but original code is confusing/less readable.

Fixes: 07513e1330a9 ("ARM: dts: vf610: Add Freescale FlexTimer Module timer node.")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/nxp/vf/vfxxx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/vf/vfxxx.dtsi b/arch/arm/boot/dts/nxp/vf/vfxxx.dtsi
index 597f20be82f1..62e555bf6a71 100644
--- a/arch/arm/boot/dts/nxp/vf/vfxxx.dtsi
+++ b/arch/arm/boot/dts/nxp/vf/vfxxx.dtsi
@@ -603,7 +603,7 @@ usbmisc1: usb@400b4800 {
 
 			ftm: ftm@400b8000 {
 				compatible = "fsl,ftm-timer";
-				reg = <0x400b8000 0x1000 0x400b9000 0x1000>;
+				reg = <0x400b8000 0x1000>, <0x400b9000 0x1000>;
 				interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
 				clock-names = "ftm-evt", "ftm-src",
 					"ftm-evt-counter-en", "ftm-src-counter-en";
-- 
2.39.5




