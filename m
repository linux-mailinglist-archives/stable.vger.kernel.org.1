Return-Path: <stable+bounces-88305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2659B255C
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFB12820BE
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE3718E049;
	Mon, 28 Oct 2024 06:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cw18Kcom"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A93018CC1F;
	Mon, 28 Oct 2024 06:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730096898; cv=none; b=kfKgkldLzmBhz95cwjjCtMZ58snOJZjfNjen7ajzxg656OCs4euJs0ZqT5mPfpJkFQfd1oTfHzv6koqNge7P2v21NEVB0INDF6bzYnM8kwP4CyKSIBF7PEvcc/jczurbbsHaBclAL3eU4LXCHmUy2Obo7cqfGNUENzcdYLu4gyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730096898; c=relaxed/simple;
	bh=Yr6DWXQBVtdHrMHD5FwVR/siImqdBSYt+GuRshyycRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXL78MUN93+PFUMLVUAUuEYxu4RiyHD0Bo8wcQDqC2DOH/2UMG1XDKx24sdcyJM3kqxD1n00fNOOD19GkgBIFdOf2afrSaVqPvuwxuVvtkJX7jevFhTdspC79uAEIEEcjyT+AxdpKuBhqChONrnETa1VH1NY3pgCqqQzE3GL3BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cw18Kcom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19F7C4CEC3;
	Mon, 28 Oct 2024 06:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730096897;
	bh=Yr6DWXQBVtdHrMHD5FwVR/siImqdBSYt+GuRshyycRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cw18KcomZ4wCkoJMfpEO/Ww0o93+lX59/zwfbAjbPnomvfwrqo2rwvr3w988utm8P
	 64s3qvFpuAUV/FTiT4cezuXLDGTLn9/1Y8kBpkGIg6RvWlvZULTVDiaTjqFmMfbC62
	 Y4rp4DX7rkJ6ysGB84WT/V8tG6ZowcnB1jvzlbzE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Klink <flokli@flokli.de>,
	Stefan Wahren <wahrenst@gmx.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 06/80] ARM: dts: bcm2837-rpi-cm3-io3: Fix HDMI hpd-gpio pin
Date: Mon, 28 Oct 2024 07:24:46 +0100
Message-ID: <20241028062252.797327256@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062252.611837461@linuxfoundation.org>
References: <20241028062252.611837461@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Klink <flokli@flokli.de>

[ Upstream commit dc7785e4723510616d776862ddb4c08857a1bdb2 ]

HDMI_HPD_N_1V8 is connected to GPIO pin 0, not 1.

This fixes HDMI hotplug/output detection.

See https://datasheets.raspberrypi.com/cm/cm3-schematics.pdf

Signed-off-by: Florian Klink <flokli@flokli.de>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Link: https://lore.kernel.org/r/20240715230311.685641-1-flokli@flokli.de
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Fixes: a54fe8a6cf66 ("ARM: dts: add Raspberry Pi Compute Module 3 and IO board")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts b/arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts
index 3dfce4312dfc4..a2ef43c2105aa 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts
@@ -77,7 +77,7 @@
 };
 
 &hdmi {
-	hpd-gpios = <&expgpio 1 GPIO_ACTIVE_LOW>;
+	hpd-gpios = <&expgpio 0 GPIO_ACTIVE_LOW>;
 	power-domains = <&power RPI_POWER_DOMAIN_HDMI>;
 	status = "okay";
 };
-- 
2.43.0




