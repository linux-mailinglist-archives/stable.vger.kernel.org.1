Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60341703654
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243719AbjEORJE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243518AbjEORIp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:08:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7808EA24B
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:07:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82EA462B00
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A32AC433D2;
        Mon, 15 May 2023 17:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170410;
        bh=QvjgrH+y2vLc0AhT7caYSTcJFXe7vPf44F1G2K7c7Ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P5QZruTgjjScOhg+2plzOSst5yLXUBU14xZGm3niITSveX93ITv8O4z1S9iyOizzt
         DBxnvi9hwLOie0isbsiYVSz8mtvOvYueScjQ4YHGQPYnE1vrAKxgPvPJoBv5Mpb6Gr
         NogqPd92oxdW0nR0wItWVnIasVlom2MVWwkSwWws=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 083/239] net: dsa: mt7530: fix corrupt frames using trgmii on 40 MHz XTAL MT7621
Date:   Mon, 15 May 2023 18:25:46 +0200
Message-Id: <20230515161724.169366001@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arınç ÜNAL <arinc.unal@arinc9.com>

[ Upstream commit 37c218d8021e36e226add4bab93d071d30fe0704 ]

The multi-chip module MT7530 switch with a 40 MHz oscillator on the
MT7621AT, MT7621DAT, and MT7621ST SoCs forwards corrupt frames using
trgmii.

This is caused by the assumption that MT7621 SoCs have got 150 MHz PLL,
hence using the ncpo1 value, 0x0780.

My testing shows this value works on Unielec U7621-06, Bartel's testing
shows it won't work on Hi-Link HLK-MT7621A and Netgear WAC104. All devices
tested have got 40 MHz oscillators.

Using the value for 125 MHz PLL, 0x0640, works on all boards at hand. The
definitions for 125 MHz PLL exist on the Banana Pi BPI-R2 BSP source code
whilst 150 MHz PLL don't.

Forwarding frames using trgmii on the MCM MT7530 switch with a 25 MHz
oscillator on the said MT7621 SoCs works fine because the ncpo1 value
defined for it is for 125 MHz PLL.

Change the 150 MHz PLL comment to 125 MHz PLL, and use the 125 MHz PLL
ncpo1 values for both oscillator frequencies.

Link: https://github.com/BPI-SINOVOIP/BPI-R2-bsp/blob/81d24bbce7d99524d0771a8bdb2d6663e4eb4faa/u-boot-mt/drivers/net/rt2880_eth.c#L2195
Fixes: 7ef6f6f8d237 ("net: dsa: mt7530: Add MT7621 TRGMII mode support")
Tested-by: Bartel Eerdekens <bartel.eerdekens@constell8.be>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mt7530.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 38bf760b5b5ee..3ef92ac7815c1 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -446,9 +446,9 @@ mt7530_pad_clk_setup(struct dsa_switch *ds, phy_interface_t interface)
 		else
 			ssc_delta = 0x87;
 		if (priv->id == ID_MT7621) {
-			/* PLL frequency: 150MHz: 1.2GBit */
+			/* PLL frequency: 125MHz: 1.0GBit */
 			if (xtal == HWTRAP_XTAL_40MHZ)
-				ncpo1 = 0x0780;
+				ncpo1 = 0x0640;
 			if (xtal == HWTRAP_XTAL_25MHZ)
 				ncpo1 = 0x0a00;
 		} else { /* PLL frequency: 250MHz: 2.0Gbit */
-- 
2.39.2



