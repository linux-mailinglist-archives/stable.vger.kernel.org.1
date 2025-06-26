Return-Path: <stable+bounces-158665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB879AE96D2
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 09:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AFF46A234D
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 07:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF61C25CC61;
	Thu, 26 Jun 2025 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Bwryadrc"
X-Original-To: stable@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1226A25BF12;
	Thu, 26 Jun 2025 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750923203; cv=none; b=CrDG2sC/+Ydu6/t5nHRpH19/AEfY7KpE1cakZVCLyfoD3hyjx6WzLL5G6nR8+LE+61mxi/TkTe+8SqQ0a+a8Jd88uAeAkA1LXF7pYyrW2fk98rBQV9kA5TlJrLb164vXg+Dnaw70OfHUymUZHQgdlWpNtW36+yyWITA67PhsRIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750923203; c=relaxed/simple;
	bh=azo+dF0/vQXfWfiOeYfh4bE+wwsnpSA8HM+IBY43R8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VrzBSU6nJDMTA2nY6H507oTNZ+0ng2JaTUh/ygONLOQwwf/4XfcxyI3JPHfIrnLXiak5dzm6Rruj4wVMxqRbO2VoJL54/AgQLvplJDJr24o25UM+wqOj+LBih/qEo1q76DnFxJ5Efvt8BmS+g0dzexwS+7DJqc0P19XdExrL4ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Bwryadrc; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 728A025F96;
	Thu, 26 Jun 2025 09:33:20 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ttrd3yj_m4ac; Thu, 26 Jun 2025 09:33:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1750923199; bh=azo+dF0/vQXfWfiOeYfh4bE+wwsnpSA8HM+IBY43R8w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BwryadrcGi3V9qOdtqjbsTAsNbxlGTkwycy6VP7YbAqFisQeViuW2pFckeIdxOWZS
	 EJVu68Kuv7kcyr+1CLW/1NVwD6HcdfPYDzg5KvXc6ureq/9L5ErRwqPAA50wq2qPiF
	 wAXTNPWuRANvl0uPJNVtqLJkiu43BVg9FySOoOFa5jImb0VP6NuEbe+5AFf7+FQzRl
	 pBMCoC4q8Abw/B0CxDUlzkmgDFMiBBEKpLiwuhFAu+AXp3tmJOWunfs5zwlfgJ4RAJ
	 lrW8UOejR/maiIYR9VZWzrA94h8lFia6EhIygqA0lFxSWuiF9lFAyZIPT/691wo2iC
	 4a1aLdsfc0n6Q==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Thu, 26 Jun 2025 13:02:58 +0530
Subject: [PATCH 3/3] arm64: dts: exynos7870-j6lte: reduce memory ranges to
 base amount
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-exynos7870-dts-fixes-v1-3-349987874d9a@disroot.org>
References: <20250626-exynos7870-dts-fixes-v1-0-349987874d9a@disroot.org>
In-Reply-To: <20250626-exynos7870-dts-fixes-v1-0-349987874d9a@disroot.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, stable@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750923181; l=1280;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=azo+dF0/vQXfWfiOeYfh4bE+wwsnpSA8HM+IBY43R8w=;
 b=6bBR/hVe24hlOvDEHg/XhfcMj1PPn1XlpC7I+O57R0KzlX7oAUaImRFbeywRHbBaGWTyQDu0/
 ca8fmbAZjOAAUkr648+JgB2wQrmbtfncfIOmIITPouAKGnb3Yl2I1GR
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

The device is available in multiple variants with differing RAM
capacities. The memory range defined in the 0x80000000 bank exceeds the
address range of the memory controller, which eventually leads to ARM
SError crashes. Reduce the bank size to a value which is available to
all devices.

The bootloader must be responsible for identifying the RAM capacity and
editing the memory node accordingly.

Fixes: d6f3a7f91fdb ("arm64: dts: exynos: add initial devicetree support for exynos7870")
Cc: stable@vger.kernel.org # v6.16
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 arch/arm64/boot/dts/exynos/exynos7870-j6lte.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos7870-j6lte.dts b/arch/arm64/boot/dts/exynos/exynos7870-j6lte.dts
index 61eec1aff32ef397c69ee3f0cba8050755f74fc6..b8ce433b93b1b488da31bbe4846f8092243611ad 100644
--- a/arch/arm64/boot/dts/exynos/exynos7870-j6lte.dts
+++ b/arch/arm64/boot/dts/exynos/exynos7870-j6lte.dts
@@ -89,7 +89,7 @@ key-volup {
 	memory@40000000 {
 		device_type = "memory";
 		reg = <0x0 0x40000000 0x3d800000>,
-		      <0x0 0x80000000 0x7d800000>;
+		      <0x0 0x80000000 0x40000000>;
 	};
 
 	pwrseq_mmc1: pwrseq-mmc1 {

-- 
2.49.0


