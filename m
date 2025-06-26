Return-Path: <stable+bounces-158662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0C4AE96C8
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 09:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C42A16FAC1
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 07:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB40123BCEE;
	Thu, 26 Jun 2025 07:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="DGykVyZn"
X-Original-To: stable@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF4C33993;
	Thu, 26 Jun 2025 07:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750923199; cv=none; b=VM52ELH87lZvPvtmpNCdD9BEGLy0ybsq5qQxW+E1i+eCyzl8iDFL6ijXgwtsVkBBOIsmIyygczlaPBkIlbP5X1feR6EKNu9diNUD2kGu2wwSlv5fZtyy/38eL5e2WvlfLFMY8MhBRQdOOFcclq1+vhcXgzUvkrUT8/5huJaxJxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750923199; c=relaxed/simple;
	bh=Z99aNcXqaaS4SQlpIEbclMo5h6ka62mxFrYm2osbZKs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SBZWo/4sBJjx8d9n0jV8pPPN9w6f0ttYLC3A7RgV44Ky7FxI+iFWMm6uoosVkYEAljFt15K0dm+MNrXGamCxVafusc7USQlkAaoq9EpBCrUexkP/g0rrjyM7tfP2gt5mZ/s4qXABt8NIIsNLhGuo2JwnX855sAcs56vLg1sOSr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=DGykVyZn; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 53C5F22E3A;
	Thu, 26 Jun 2025 09:33:07 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lA0oNzrxne4X; Thu, 26 Jun 2025 09:33:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1750923186; bh=Z99aNcXqaaS4SQlpIEbclMo5h6ka62mxFrYm2osbZKs=;
	h=From:Subject:Date:To:Cc;
	b=DGykVyZnSgU7L8FuWvFz4dE7oQADIL3db9sS12sHuUSmJ7hL1ECX9KDicnMk+LrpA
	 tETM6jewN1vUr6eVFWjzudVD1y6v8gugGxNPQih+ADsmDCv03a+29zvsgSmG7mHOJU
	 JO2ShhpNyPibY9KsateFM5llJDeIVmAwMqtlQPmqWp7yIH/veKLylfP7d9vVQ9trxh
	 ZuaqaKL7J1X/TqQIGDBiraZoP9uDIQSKHE/WEBKxcoSaDpjguvQPNTo7F4ww4dAt4z
	 D8+nyc3ekMg01KAeTEQtohdNgtmyeZdRldmKLFP/VcnBF95zb9i2yJygdqQD7GBCSn
	 5LJxPuVmSzuTg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH 0/3] Various devicetree fixes for Exynos7870 devices
Date: Thu, 26 Jun 2025 13:02:55 +0530
Message-Id: <20250626-exynos7870-dts-fixes-v1-0-349987874d9a@disroot.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKf3XGgC/x3LMQqAMAxA0atIZgOxYlu8ijiIjZqllUZEEe9uc
 Xx8/gPKWVihrx7IfIpKigVNXcG8TXFllFAMhkxH1ljk645JnXeE4VBc5GJFdi0tjrwNYYay7pn
 /UM5hfN8PlUgOzGYAAAA=
X-Change-ID: 20250626-exynos7870-dts-fixes-e730f7086ddc
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, stable@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750923181; l=1265;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=Z99aNcXqaaS4SQlpIEbclMo5h6ka62mxFrYm2osbZKs=;
 b=gpI29wz7F38DO8rebomTMbfIBORH6VaFkBhC5ETvLNG6NyrNcG/DIgfYlkqsHiYc9tCbQbeO4
 GAkOSnkgr9nC1dUZxNRTo0cT6zVcwTX8Htuvqg9kgpW/SPAjjNVYhT7
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

This patch series introduces a few minor fixes on Exynos7870 devices.
These fix USB gadget problems and serious crashes on certain variants of
devices. More information is provided in respective commits.

This series has no dependencies. Would be nice to get them merged in
6.16 itself. I assume it's okay to cc stable as the -rc releases are
also owned by the "Stable Group" in git.kernel.org... [1] [2]

[1] https://git.kernel.org/?q=Stable+Group
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Kaustabh Chakraborty (3):
      arm64: dts: exynos7870: add quirk to disable USB2 LPM in gadget mode
      arm64: dts: exynos7870-on7xelte: reduce memory ranges to base amount
      arm64: dts: exynos7870-j6lte: reduce memory ranges to base amount

 arch/arm64/boot/dts/exynos/exynos7870-j6lte.dts    | 2 +-
 arch/arm64/boot/dts/exynos/exynos7870-on7xelte.dts | 2 +-
 arch/arm64/boot/dts/exynos/exynos7870.dtsi         | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)
---
base-commit: 1b152eeca84a02bdb648f16b82ef3394007a9dcf
change-id: 20250626-exynos7870-dts-fixes-e730f7086ddc

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>


