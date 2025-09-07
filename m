Return-Path: <stable+bounces-178330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCAFB47E39
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D9A189F4C0
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583A11D88D0;
	Sun,  7 Sep 2025 20:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bzl8QqaL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C3A212560;
	Sun,  7 Sep 2025 20:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757276494; cv=none; b=jd3BhjyFP+aJHMIN/PgT6lM81ey8yxj/jTanBOrjYPBWD3AK1LLq2uL/W+EPiJsJ2xyfwm8PrMR4bZckZ697wFgZGz2dlItTe49czeXmFGLr+WWKmE2VKoBUySKnS5/E2PvqAmJgse452ROj4Mh6mMGG9ppvl0kVlnhlsO+06i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757276494; c=relaxed/simple;
	bh=F0e2xUmkabh+LrMd4wZ6L5xO2DHOCbm/+k1ggbIqPpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRB5g8cO91i0mBZ3NgZDvLUkUqIKHqG4wGGT+K5IkXF83+X1hNq5N1zyk3HjpjDVUnTK7bCqrQvOSgS13Jcpa3BzvZpjb/B3vu9C6Dd8KyaiNWkBkqTpENkbBbkTqgivx8ZS42jOhQk3muhEmD018ljHYokPhq/oQbPcy6pgQrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bzl8QqaL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924A3C4CEF0;
	Sun,  7 Sep 2025 20:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757276494;
	bh=F0e2xUmkabh+LrMd4wZ6L5xO2DHOCbm/+k1ggbIqPpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bzl8QqaLbxq0ckisTaaHysYtdPgyicLCqYDU5QXUny/We4eTlo/7j4xDZrMJqRFMw
	 Msbv+bOsQKm+SSt863mVMowC9jEt4XKImpD3M5dgbfrOx67NdDbRqOk1r1TNaZqZIf
	 BvMFsVm/GHdkupmBPHR+QNzX1Q3uKLs5X2rQZ7rk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marek Vasut <marek.vasut@mailbox.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 018/121] arm64: dts: imx8mp: Fix missing microSD slot vqmmc on Data Modul i.MX8M Plus eDM SBC
Date: Sun,  7 Sep 2025 21:57:34 +0200
Message-ID: <20250907195610.283954544@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195609.817339617@linuxfoundation.org>
References: <20250907195609.817339617@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marek.vasut@mailbox.org>

[ Upstream commit 80733306290f6d2e05f0632e5d3e98cd16105c3c ]

Add missing microSD slot vqmmc-supply property, otherwise the kernel
might shut down LDO5 regulator and that would power off the microSD
card slot, possibly while it is in use. Add the property to make sure
the kernel is aware of the LDO5 regulator which supplies the microSD
slot and keeps the LDO5 enabled.

Fixes: 562d222f23f0 ("arm64: dts: imx8mp: Add support for Data Modul i.MX8M Plus eDM SBC")
Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts b/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
index cd44bf83745ca..678ecc9f81dbb 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
@@ -442,6 +442,7 @@ &usdhc2 {
 	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
 	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
 	vmmc-supply = <&reg_usdhc2_vmmc>;
+	vqmmc-supply = <&ldo5>;
 	bus-width = <4>;
 	status = "okay";
 };
-- 
2.50.1




