Return-Path: <stable+bounces-158663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF026AE96CA
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 09:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8E3170BA9
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 07:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C518823E33A;
	Thu, 26 Jun 2025 07:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="eXhojVre"
X-Original-To: stable@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF53A1662E7;
	Thu, 26 Jun 2025 07:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750923199; cv=none; b=YKuJTucOcoanlRrQwVJE11lLbWNojdjaAyba5Vyr3kWwNjd0OA7Is4/uo5fxmUQ5pkAtNYxs/c1wg1c9fhl2nXxwIDtWzv3NNKSk47M+Dc4QkoFjpBu+IgGrEYebDwqVNn8wmIp2ejT2vZdutRsS8Sk/2KPUrDcJVtnoB762gAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750923199; c=relaxed/simple;
	bh=VimxYiXgfisgElanUh5f+frPH3YNE9qoTKNe16RL7vo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A+QVQbiNdYHgqiww5XO5ats2TXPvejlNNuYJhTMavP7ctbtFZktJK7vmNrECuX1s1QAwRzsAgSxFNMistdk8/Ux/mRECUsc209jIZhXcskK+ieb8gMIIsq7VqaWy7v6NYfM//mO4UZzXPzIl3gcpGfA6xHIczmal+J7d5WUSyeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=eXhojVre; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 0215D25F96;
	Thu, 26 Jun 2025 09:33:16 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GlF9J5AHqZAt; Thu, 26 Jun 2025 09:33:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1750923195; bh=VimxYiXgfisgElanUh5f+frPH3YNE9qoTKNe16RL7vo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eXhojVren3B5MpIXLOtS4iLWlCb6nC8hBzgfvJJt7Ryyyc3AXo/pgSlVidj+hmby5
	 k+x0XRafTcmjiVbFz53cSW3HN7JdKbdhkAwJ6zbBXeACE2U46GPMAok/2TfAFr4MYf
	 QV91HVQulPMWCKZRtFZWSEFTJ1xcJu24e/dq3FmZ6hZSIBhTKEWt//mSqmZTrta/PI
	 AyxguCScX7tocTRaVpVjCKLcZcOO8KY2hJzMiSfJrrprYI+bN4jur6kWQ/7iwNz1pb
	 Dgaa6xbJrdmY7k9YJm/4PzS4Lsy3k2htYA9B+1RTZrh5Iqu/cqGB9hKIWJcHWUvfxx
	 6iZxRla+cb69A==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Thu, 26 Jun 2025 13:02:57 +0530
Subject: [PATCH 2/3] arm64: dts: exynos7870-on7xelte: reduce memory ranges
 to base amount
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-exynos7870-dts-fixes-v1-2-349987874d9a@disroot.org>
References: <20250626-exynos7870-dts-fixes-v1-0-349987874d9a@disroot.org>
In-Reply-To: <20250626-exynos7870-dts-fixes-v1-0-349987874d9a@disroot.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, stable@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750923181; l=1295;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=VimxYiXgfisgElanUh5f+frPH3YNE9qoTKNe16RL7vo=;
 b=OhZIEH3niapUpqaSeCChzbwN1Dn8AXEv9OYQ/YE3FiYYgqGhZg3X6CmLj5GQSZIJkrFQ1oxpq
 7932NrXeomWDdXLsPb9sR9PrpuegZ/S0v47z3zDbvrqKpe3SU/YcOEA
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
 arch/arm64/boot/dts/exynos/exynos7870-on7xelte.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos7870-on7xelte.dts b/arch/arm64/boot/dts/exynos/exynos7870-on7xelte.dts
index eb97dcc415423f405d7df9b9869b2db3432fb483..b1d9eff5a82702cd7c9797b2124486207e03ad89 100644
--- a/arch/arm64/boot/dts/exynos/exynos7870-on7xelte.dts
+++ b/arch/arm64/boot/dts/exynos/exynos7870-on7xelte.dts
@@ -78,7 +78,7 @@ key-volup {
 	memory@40000000 {
 		device_type = "memory";
 		reg = <0x0 0x40000000 0x3e400000>,
-		      <0x0 0x80000000 0xbe400000>;
+		      <0x0 0x80000000 0x80000000>;
 	};
 
 	pwrseq_mmc1: pwrseq-mmc1 {

-- 
2.49.0


