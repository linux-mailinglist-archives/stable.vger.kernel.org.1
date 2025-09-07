Return-Path: <stable+bounces-178457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92430B47EBF
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D56A1B20594
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1788021FF3B;
	Sun,  7 Sep 2025 20:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UmBVdmJO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C351E5B94;
	Sun,  7 Sep 2025 20:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757276897; cv=none; b=F88ZxxZte2AlvvJupv9jnDGupdimA9Lkb21+eOxDFFrmtzle3ObmiX9SK0apEf50ac40d0lQyTapftMHxJiwYORYNO025Q/ebBS6GVyUefmDYFxCWM73RohcCFI2QQ1eJFtRK8/bfUQAgRWFycn8OpWhpnlj9XxcW1ALFYgxDI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757276897; c=relaxed/simple;
	bh=4teLLkNqYjR45W48J/MBabPceEotyERSaoiZUDasUN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVJluM77YGny2CXmO0Ze/F5YkoV8uRsXNAmypgxD4ggDjJ5UjbXhS1UUVxqve/PYVOpwBTP1TSnlnsFiHBQoQgsUx5CTVIgdllC1p6VZCJaueLvc8iCyFt2ovlQgL0HzDKBHZxUjGlrQS0xg+ItPAoGNuX3SvluluKrtDA6ROCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UmBVdmJO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A25C4CEF0;
	Sun,  7 Sep 2025 20:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757276896;
	bh=4teLLkNqYjR45W48J/MBabPceEotyERSaoiZUDasUN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UmBVdmJOapEoPuL0wzeEHj04zxb2kVvxFPd0HMMrkRLGKMNgx+L+6WYlOQ07y08OG
	 bFSUCVHDF7QuKgqpQq9GOY/2AzIosdvyxCmzEGhkbiG7FpCYqgzNsySa+tfuI6FLIL
	 UqGfwYtqffP6y6XfG6G9RP/bAh2XEpGE1BlFzcvc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marek Vasut <marek.vasut@mailbox.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 022/175] arm64: dts: imx8mp: Fix missing microSD slot vqmmc on Data Modul i.MX8M Plus eDM SBC
Date: Sun,  7 Sep 2025 21:56:57 +0200
Message-ID: <20250907195615.406370213@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195614.892725141@linuxfoundation.org>
References: <20250907195614.892725141@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index d0fc5977258fb..16078ff60ef08 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
@@ -555,6 +555,7 @@ &usdhc2 {
 	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
 	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
 	vmmc-supply = <&reg_usdhc2_vmmc>;
+	vqmmc-supply = <&ldo5>;
 	bus-width = <4>;
 	status = "okay";
 };
-- 
2.50.1




