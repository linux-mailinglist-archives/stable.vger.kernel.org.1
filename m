Return-Path: <stable+bounces-160383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5B3AFB94E
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 18:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFAB87AC290
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 16:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77A32882A3;
	Mon,  7 Jul 2025 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AWuU6+aZ"
X-Original-To: stable@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B212F28751E;
	Mon,  7 Jul 2025 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751907373; cv=none; b=ovlYLJsEZ8L3wCDb8nwtm/a9GZ7GgCGJyR3i9G+lz8tsm1y5bLCKSxxvb3qybHJdos5fLnSSmcUArIHIn7A7+MDpuzGQZureSPhpe2P18qscyVHWiS1+fBrVHyWyBwZ3EaThz733O9Apf7kvcb3f66tJVgCDrm6uB+qWQ9iCGV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751907373; c=relaxed/simple;
	bh=FuhQRwae2dk7G2AhenzzCQyoD4r0rqCJ8I0IX1Jo0Hs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Xho9xutw61BSthU9KTshd9b/xhnN+7H0RNWdzz0H7bthWiXMWhkxxGV3k5eRIrKweZP6cZ+La0nRxAcVIRJqr0/kuoT4JxS989SltWt5/P4IU1+H9Mcx45ysSoMEeZhk7fz7t6numdvZOHO7YCaPhzPavzaX6EbpkNpCi1nGF5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AWuU6+aZ; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 567Gu44A908297;
	Mon, 7 Jul 2025 11:56:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1751907364;
	bh=b36WFNYgCnf2wZ3ZE31CeZaXfFAr68TP9LxpTPxnTN8=;
	h=From:Date:Subject:To:CC;
	b=AWuU6+aZDmyZEWFiNoNHmuH+UerIrQMyF4PqYVqsLnbIx/t2boirOZGOTxUlQzuP8
	 2COK1J3yEfREu/Ew6DTdUBmcJx2sMJdVJAqTl4IryyRmHfEHSmZ/rpkuM7hba55lK+
	 sSj5NYzxYMGZ1HZ6c7GvSzBOd+Zovawb1abc2uh0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 567Gu42U2402220
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 7 Jul 2025 11:56:04 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 7
 Jul 2025 11:56:04 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 7 Jul 2025 11:56:04 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 567Gu4gR547055;
	Mon, 7 Jul 2025 11:56:04 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 7 Jul 2025 11:55:13 -0500
Subject: [PATCH] arm64: dts: ti: k3-am62a7-sk: fix pinmux for main_uart1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250707-uart-fixes-v1-1-8164147218b0@ti.com>
X-B4-Tracking: v=1; b=H4sIAPD7a2gC/x2LQQqAIBQFrxJ/naBSCV0lWkg9628stCIQ796n5
 TAzhTISI9PYFEp4OPMRBUzb0LL7uEHxKkxW21477dTt06UCv8hqQIB13viAjmQ4E34h/TTX+gG
 xEitPXAAAAA==
X-Change-ID: 20250707-uart-fixes-6efe27a1afe4
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Hong Guan <hguan@ti.com>,
        <stable@vger.kernel.org>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1598; i=bb@ti.com;
 h=from:subject:message-id; bh=ky+qAaXdZ2TyedNW6YBu3RSJ2GrAWRzNmuzuYfCVs1E=;
 b=owNCWmg5MUFZJlNZgbBUjAAAaH////dv/z93P/vY72H6OOtvO7l/3d+93eejRbuK/Vjx+fewA
 RsYGKAHqAAA0DRoDTQD1AAaD1AAAA0HqAAA0aAAepoaA09T1PJBppgyjeiiBkaDQAPSMg00BiZG
 QBkBpo0aNAwRhHpBo00aNAyNGQMQ0ANAMnpNMTRmUCAeiD0QNAxMjEwhoyGBNGgaaZGmQ0ZGmRh
 NDIDEMQAAaaBiBiaMgAAYAANBtwQuRiJwsyXl5sOWRahGUMvwa6siTQE+IvJCDAjtX5kWq9Op4y
 OmXiR/M9WvLEjDaWQEsdM+KA4QXx408bJBhCFaIUGJRq3bU5D48/wV1V1pYGcp+CtgdVSHCl/es
 XNA+vYqyVzpx57PLN448CMX2uI5r0L7BByG3THPGCH3k4PkxCufmoIMQwUFbGntA+1H9FuTvaSI
 7c0BcC9E+8zk2rjDdEj40i7fizPc5CfuNWDS75NIhe5hqYlaoBzQh5aZITGc6c54VwYukx8lzkM
 Ur+1Oott3cdr7+lUoWTedMVIiUZeR9bYaVFDCbLZIEsovWsLxSCjGhlwwiNCSNkxDO1rgOw7Mdk
 iTsHU0Oarl4f4UKBcBnvZbQZUEEjh9+li/4mRbCnex3FIHkPiAJQ+OLVB3SPB5bxkpCAaxPikMO
 P/xdyRThQkIGwVIwA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Hong Guan <hguan@ti.com>

The &main_uart1, which is reserved for TIFS firmware traces, is routed
to the onboard FT4232 via a FET swich which is connected to pin A21 and
B21 of the SoC and not E17 and C17. Fix it.

Fixes: cf39ff15cc01a ("arm64: dts: ti: k3-am62a7-sk: Describe main_uart1 and wkup_uart")
Cc: stable@vger.kernel.org
Signed-off-by: Hong Guan <hguan@ti.com>
[bb@ti.com: expanded commit message]
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index 3a8b45272526037b364e6e39886fcc9199114105..f11284b3fe8e23b4c48d8d2f3a7202e80dc57370 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -301,8 +301,8 @@ AM62AX_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (D15) UART0_TXD */
 
 	main_uart1_pins_default: main-uart1-default-pins {
 		pinctrl-single,pins = <
-			AM62AX_IOPAD(0x01e8, PIN_INPUT, 1) /* (C17) I2C1_SCL.UART1_RXD */
-			AM62AX_IOPAD(0x01ec, PIN_OUTPUT, 1) /* (E17) I2C1_SDA.UART1_TXD */
+			AM62AX_IOPAD(0x01ac, PIN_INPUT, 2) /* (B21) MCASP0_AFSR.UART1_RXD */
+			AM62AX_IOPAD(0x01b0, PIN_OUTPUT, 2) /* (A21) MCASP0_ACLKR.UART1_TXD */
 			AM62AX_IOPAD(0x0194, PIN_INPUT, 2) /* (C19) MCASP0_AXR3.UART1_CTSn */
 			AM62AX_IOPAD(0x0198, PIN_OUTPUT, 2) /* (B19) MCASP0_AXR2.UART1_RTSn */
 		>;

---
base-commit: 036cc33070b35754f45da50d81f8c3c85191c8b7
change-id: 20250707-uart-fixes-6efe27a1afe4

Best regards,
-- 
Bryan Brattlof <bb@ti.com>


