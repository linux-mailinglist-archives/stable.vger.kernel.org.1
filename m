Return-Path: <stable+bounces-155336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D64AE3BC9
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 12:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A103A387A
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 10:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1EC238C09;
	Mon, 23 Jun 2025 10:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uHXhW5tJ"
X-Original-To: stable@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E0CB663;
	Mon, 23 Jun 2025 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750673231; cv=none; b=YPPOoPp+83CkmAWSqujWrtEGc/O5DqgMVQhbg7cWZhb6frR3EoYsYtbW2WPwL9yyGyre+9/Rf6mbtJhNeRuI9VA//6/MXoGC39Zyl/qooJDNtDVLIsYViddz5YRN4pDdGWpNK9Up87DZ9QTqPOKoLyS0hlKmphG0v8w01qfiE4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750673231; c=relaxed/simple;
	bh=7SNzWtEzSTjQEsseEgDbz7X6RIzuPeZ3qaIYWeGQgrM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IY6rU4LcJDPbvX6Ytx12/7k5WCCXD7PF1wPE1AtFneqoKhkkq6gQm+FPLMpMU3Yzy0xA6RpTCSYi61u5A2WR2Qe2dsbhe29i9GWT0E4eet0as/FqSJntHnA/7Lm4eMxst6Q+cO4FM8I0scLDoXrCDw8JANekiOWbB4Y7TRIEbCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uHXhW5tJ; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55NA72Q61451920;
	Mon, 23 Jun 2025 05:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1750673222;
	bh=43OOMOtrQdbIl0llSClmQm0cuBZtWECNSMICINWNa2E=;
	h=From:To:CC:Subject:Date;
	b=uHXhW5tJFimmz24kJt/rYj4/6sOmWDfXGQHU+FDpJ2q1vQJ+QiNkkS2LkXIhmLyYV
	 CsZZJGpBWSCovWLU5dtYQlI9BpGkKLwISceVuq687O4T0bZ4So6UsbBI4UrtozgYUf
	 r9IIrAvbuX7X4c0Lt2q/fZCKlNcdtcnQCLoOeO+g=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55NA72h03138105
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 23 Jun 2025 05:07:02 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 23
 Jun 2025 05:07:02 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 23 Jun 2025 05:07:02 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.169])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55NA6wcW3627251;
	Mon, 23 Jun 2025 05:06:58 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <rogerq@kernel.org>
CC: <stable@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j722s-evm: Fix USB gpio-hog level for Type-C
Date: Mon, 23 Jun 2025 15:36:57 +0530
Message-ID: <20250623100657.4082031-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

According to the "GPIO Expander Map / Table" section of the J722S EVM
Schematic within the Evaluation Module Design Files package [0], the
GPIO Pin P05 located on the GPIO Expander 1 (I2C0/0x23) has to be pulled
down to select the Type-C interface. Since commit under Fixes claims to
enable the Type-C interface, update the property within "p05-hog" from
"output-high" to "output-low", thereby switching from the Type-A
interface to the Type-C interface.

[0]: https://www.ti.com/lit/zip/sprr495
Cc: <stable@vger.kernel.org>
Fixes: 485705df5d5f ("arm64: dts: ti: k3-j722s: Enable PCIe and USB support on J722S-EVM")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
86731a2a651e Linux 6.16-rc3
of Mainline Linux.

Regards,
Siddharth.

 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index a47852fdca70..d0533723412a 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -634,7 +634,7 @@ p05-hog {
 			/* P05 - USB2.0_MUX_SEL */
 			gpio-hog;
 			gpios = <5 GPIO_ACTIVE_LOW>;
-			output-high;
+			output-low;
 		};
 
 		p01_hog: p01-hog {
-- 
2.34.1


