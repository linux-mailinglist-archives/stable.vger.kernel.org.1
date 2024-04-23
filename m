Return-Path: <stable+bounces-41293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586B48AFB0D
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7E31C214D8
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7053A14C59A;
	Tue, 23 Apr 2024 21:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PcUP6Mt7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F53C14885A;
	Tue, 23 Apr 2024 21:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908809; cv=none; b=AR+Z34FjPyDSlJNw8DUvjTrnoZIZ+vJCHuZ2qoUG2HHuaTiLaDlpmtaxMOB5YTyAZ9809DE1UEETgWSHd02DDjr50uOGSXv22+i79ao6H9wxJebw/50KKK9ShTg12BQTD5Bbwv6t0FKkNkK0haiGT38jSYipAzn6DT6SiA4RUvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908809; c=relaxed/simple;
	bh=4ZO1grQSgP8s/M27aR04lEJdweNjCOcFbiNgXCjcJcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FYH7IMOtxSqHknduCY7rr1FVHKbgtXXFxg4OgwrzBd+DLq+C1+klVWyoIiop9oIlaufYlO5hp7UubNo7QKRmpE5SsvQbxzYnCox+tTzptbMy2zyqtIVw/9HHn3jHTIRF7aLeSgC5pNOFWrjDwT93Bcm4SP5xsqX7NVJSk4dGloA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PcUP6Mt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1404C116B1;
	Tue, 23 Apr 2024 21:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908809;
	bh=4ZO1grQSgP8s/M27aR04lEJdweNjCOcFbiNgXCjcJcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PcUP6Mt7ivJPROGq3TihXGjsphDWZHFYtr7UIKqdLFJ+raoC80riwIurwmEcYhi0v
	 abWridiGWitb7o6Mf4dodXzWwe+UnV8U2fmcI4hqbRmJCWnY9ssL5bqntzmalk/soc
	 TYBVkJ6LQpmkE0GCDYxzX1ChmqEsxTe77ySBMN58=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15 70/71] net: dsa: mt7530: fix improper frames on all 25MHz and 40MHz XTAL MT7530
Date: Tue, 23 Apr 2024 14:40:23 -0700
Message-ID: <20240423213846.634482990@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213844.122920086@linuxfoundation.org>
References: <20240423213844.122920086@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arınç ÜNAL <arinc.unal@arinc9.com>

commit 5f563c31ff0c40ce395d0bae7daa94c7950dac97 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/mt7530.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2410,8 +2410,6 @@ mt7530_setup(struct dsa_switch *ds)
 		     SYS_CTRL_PHY_RST | SYS_CTRL_SW_RST |
 		     SYS_CTRL_REG_RST);
 
-	mt7530_pll_setup(priv);
-
 	/* Lower Tx driving for TRGMII path */
 	for (i = 0; i < NUM_TRGMII_CTRL; i++)
 		mt7530_write(priv, MT7530_TRGMII_TD_ODT(i),
@@ -2429,6 +2427,9 @@ mt7530_setup(struct dsa_switch *ds)
 
 	priv->p6_interface = PHY_INTERFACE_MODE_NA;
 
+	if ((val & HWTRAP_XTAL_MASK) == HWTRAP_XTAL_40MHZ)
+		mt7530_pll_setup(priv);
+
 	mt753x_trap_frames(priv);
 
 	/* Enable and reset MIB counters */



