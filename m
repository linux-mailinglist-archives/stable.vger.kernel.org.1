Return-Path: <stable+bounces-136002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC55A991B1
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA22922DE8
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C4A28D823;
	Wed, 23 Apr 2025 15:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Qt1poLkj"
X-Original-To: stable@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBA527F4D9;
	Wed, 23 Apr 2025 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421399; cv=none; b=fjLGImTuNUNzcGhpF07THl7dp8a5798VoG/B7Vgdb3IL8qmnrXoDEtJ4+adNK0AKFzmqojijMoZt22ELQshjNv1zHXp0emfAx9u0kz5oBp49N54PV9WsI7wK3VsG6hHN7WhWJBiLOdgqzyAyQpVhyGO5SMOZwzBW1/r3eetnEls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421399; c=relaxed/simple;
	bh=h6jFwir1+BY5QpSiHUHq+V3ew0/c4upu4QIUqWo/SE0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fz7wMdPhV1mYDnhtxgUVd1p0k1qjj6nYFlt5fvFBTno/JjiTPHO69YLJNF8EAqMTLQLzHzcrZiHCazDta3k4Np4ze7D9RpXwDehZgvmNIrSlZrkoSAnmEUu1SFE5LJ45yJAAm5uVKolauc44M1ZNuvLIGtNCnxMeZR8SV2DcBXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Qt1poLkj; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53NFGHuX1596406
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 10:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745421377;
	bh=8nMTuVmbBgWriHBNOl7VHKOPtN40UiBF8UiV+4nGdFg=;
	h=From:To:CC:Subject:Date;
	b=Qt1poLkjHGkgp2MmkrXKhMJ47nD9EN6Sqp9HYM+sPGjtgkthHLWc6Rd7jO3yz3EZp
	 WAQuaKNihZDDQ2nPJeNGrpVixv0KS8gv3LKiSevYVRlSx0kRL1Z1KvEA3TfidteDcd
	 weQbHDP1L0CYVMrXFYDjxwQ/9cK8Cwlv/iY56NUc=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53NFGH6N030028
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Apr 2025 10:16:17 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Apr 2025 10:16:16 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Apr 2025 10:16:16 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53NFGClF054303;
	Wed, 23 Apr 2025 10:16:13 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <stable@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j784s4-j742s2-main-common: fix length of serdes_ln_ctrl
Date: Wed, 23 Apr 2025 20:46:12 +0530
Message-ID: <20250423151612.48848-1-s-vadapalli@ti.com>
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

Commit under Fixes corrected the "mux-reg-masks" property but did not
update the "length" field of the "reg" property to account for the newly
added register offsets which extend the region. Fix this.

Fixes: 38e7f9092efb ("arm64: dts: ti: k3-j784s4-j742s2-main-common: Fix serdes_ln_ctrl reg-masks")
Cc: stable@vger.kernel.org
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
bc3372351d0c Merge tag 'for-6.15-rc3-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
of Mainline Linux.

Regards,
Siddharth.

 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
index 1944616ab357..1fc0a11c5ab4 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
@@ -77,7 +77,7 @@ pcie1_ctrl: pcie1-ctrl@4074 {
 
 		serdes_ln_ctrl: mux-controller@4080 {
 			compatible = "reg-mux";
-			reg = <0x00004080 0x30>;
+			reg = <0x00004080 0x50>;
 			#mux-control-cells = <1>;
 			mux-reg-masks = <0x0 0x3>, <0x4 0x3>, /* SERDES0 lane0/1 select */
 					<0x8 0x3>, <0xc 0x3>, /* SERDES0 lane2/3 select */
-- 
2.34.1


