Return-Path: <stable+bounces-40341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F22F68ABC50
	for <lists+stable@lfdr.de>; Sat, 20 Apr 2024 18:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A8C2817C6
	for <lists+stable@lfdr.de>; Sat, 20 Apr 2024 16:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88CC39AD5;
	Sat, 20 Apr 2024 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fD4diPWb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FA02DF84
	for <stable@vger.kernel.org>; Sat, 20 Apr 2024 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713628813; cv=none; b=NWT841ll0TZa8ZtwSsWijJTyZfseYpBNmqzgZgzd3rM3/sNbRHqahZTfJKhsycc04m9iL8PlmgtStwPakOX0nhK2FbQlcGbepk58AxPVvjM0usjeuwDXLQcqaBSSWx090Lc/bKTFBMoLHAxI8yQTnoY2QGW97U4jmo0dtQ5sNqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713628813; c=relaxed/simple;
	bh=QaD4RqDk7QjvGD6qphZ/L8nlDIjKMcNX4SUmUt+fw68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d24y4K80+/h5/4d3vaZaPQKG6+uKwKYuOBAsdwra5Hb7bQpfboXdpxFipHhnMGnx8oKJxCDIVatNMn1JR9wIUyCeZ59alEd/OOXzp6Oi1lHPir4b2LwX4JuVw5Haxbp1ljWIb1htw6qYeJq79g6CyrRVTsYokMDsTpMgN9j2BCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fD4diPWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38A30C32783;
	Sat, 20 Apr 2024 16:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713628813;
	bh=QaD4RqDk7QjvGD6qphZ/L8nlDIjKMcNX4SUmUt+fw68=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fD4diPWbPKEvQSGooGMG7Zs/m67INUcWTA5Q4WU7Qiz8WOLPqbfRPg8fLygtCYCQy
	 +3dh/GuunpAJDv53taiRdPPHnCgTpVaPzrZOCczNlRqi5BJ6u2vaHnf0LPKU9nAj+l
	 eU8lXEH6BevPv5Lb6gRINiclerNuX9UEF/wnO/NjuD+/dzpVm6mGU+KWjJX31ciglr
	 giHMZclJQUsqIibsxmoDb4ZcuGUAmqwTBvdSOHiSXg7Zyyt47Pa7Cj2gcimO2UIdjX
	 2sN/kOKlATb8OcLWnQBuR+xBWjsXoIhOqzgxuzB5gku3VnTWA43wTDnm+Fa6/luQAN
	 RRIMDL+SKdi7g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3121DC07E8E;
	Sat, 20 Apr 2024 16:00:13 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Sat, 20 Apr 2024 18:59:52 +0300
Subject: [PATCH 3/4] net: dsa: mt7530: fix improper frames on all 25MHz and
 40MHz XTAL MT7530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240420-for-stable-6-1-backports-v1-3-0c50ca4324ea@arinc9.com>
References: <20240420-for-stable-6-1-backports-v1-0-0c50ca4324ea@arinc9.com>
In-Reply-To: <20240420-for-stable-6-1-backports-v1-0-0c50ca4324ea@arinc9.com>
To: stable@vger.kernel.org
Cc: Daniel Golle <daniel@makrotopia.org>, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713628810; l=3020;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=3642U/KZOAuTlmX6OGi60TTFWG6kgJLAiaIcJqX0Jsw=;
 b=zZ8jiwJZk3RzYSpxb0mA35CvusvctgVuAFKphJp8gn4DGG1q03siIE+UTErK22Hd3zqGrM3as
 Pk8Kk6UGYcnC8EOj4LKPaYfWxyMqxxyMiyIWSdoJpOHzINZRAhTIGGq
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

[ Upstream commit 5f563c31ff0c40ce395d0bae7daa94c7950dac97 ]

The MT7530 switch after reset initialises with a core clock frequency that
works with a 25MHz XTAL connected to it. For 40MHz XTAL, the core clock
frequency must be set to 500MHz.

The mt7530_pll_setup() function is responsible of setting the core clock
frequency. Currently, it runs on MT7530 with 25MHz and 40MHz XTAL. This
causes MT7530 switch with 25MHz XTAL to egress and ingress frames
improperly.

Introduce a check to run it only on MT7530 with 40MHz XTAL.

The core clock frequency is set by writing to a switch PHY's register.
Access to the PHY's register is done via the MDIO bus the switch is also
on. Therefore, it works only when the switch makes switch PHYs listen on
the MDIO bus the switch is on. This is controlled either by the state of
the ESW_P1_LED_1 pin after reset deassertion or modifying bit 5 of the
modifiable trap register.

When ESW_P1_LED_1 is pulled high, PHY indirect access is used. That means
accessing PHY registers via the PHY indirect access control register of the
switch.

When ESW_P1_LED_1 is pulled low, PHY direct access is used. That means
accessing PHY registers via the MDIO bus the switch is on.

For MT7530 switch with 40MHz XTAL on a board with ESW_P1_LED_1 pulled high,
the core clock frequency won't be set to 500MHz, causing the switch to
egress and ingress frames improperly.

Run mt7530_pll_setup() after PHY direct access is set on the modifiable
trap register.

With these two changes, all MT7530 switches with 25MHz and 40MHz, and
P1_LED_1 pulled high or low, will egress and ingress frames properly.

Link: https://github.com/BPI-SINOVOIP/BPI-R2-bsp/blob/4a5dd143f2172ec97a2872fa29c7c4cd520f45b5/linux-mt/drivers/net/ethernet/mediatek/gsw_mt7623.c#L1039
Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Link: https://lore.kernel.org/r/20240320-for-net-mt7530-fix-25mhz-xtal-with-direct-phy-access-v1-1-d92f605f1160@arinc9.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 7a70695d1182..a917ad56191b 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2434,8 +2434,6 @@ mt7530_setup(struct dsa_switch *ds)
 		     SYS_CTRL_PHY_RST | SYS_CTRL_SW_RST |
 		     SYS_CTRL_REG_RST);
 
-	mt7530_pll_setup(priv);
-
 	/* Lower Tx driving for TRGMII path */
 	for (i = 0; i < NUM_TRGMII_CTRL; i++)
 		mt7530_write(priv, MT7530_TRGMII_TD_ODT(i),
@@ -2453,6 +2451,9 @@ mt7530_setup(struct dsa_switch *ds)
 
 	priv->p6_interface = PHY_INTERFACE_MODE_NA;
 
+	if ((val & HWTRAP_XTAL_MASK) == HWTRAP_XTAL_40MHZ)
+		mt7530_pll_setup(priv);
+
 	mt753x_trap_frames(priv);
 
 	/* Enable and reset MIB counters */

-- 
2.40.1



