Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8D76FA3AA
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjEHJu1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbjEHJuX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE30D1A10E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74E5E621B8
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8672BC433D2;
        Mon,  8 May 2023 09:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539421;
        bh=lRyEp21ivqA7xxJxOtPPLEey0PPmDNTJezzDb5FDAUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=laAkD3SJ+JrwNHwWx2kkR2kMXeEkGeYWyJlTEveEqsZRI0WC+vbV5vSencDmI7Piz
         PMjt8Ad0k88SrW1UUOsH0h6Kmdcp3uaCLlo8m8k0hR3c+UdYsYKJKRbQBV0obwM84f
         nH8RoY9TszQ4jN1fM67k4JdDjLXWtcE4uVlbvQdk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, chowtom <chowtom@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 012/611] net: sfp: add quirk enabling 2500Base-x for HG MXPD-483II
Date:   Mon,  8 May 2023 11:37:34 +0200
Message-Id: <20230508094422.054196002@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Daniel Golle <daniel@makrotopia.org>

[ Upstream commit ad651d68cee75e9ac20002254c4e5d09ee67a84b ]

The HG MXPD-483II 1310nm SFP module is meant to operate with 2500Base-X,
however, in their EEPROM they incorrectly specify:
    Transceiver type                          : Ethernet: 1000BASE-LX
    ...
    BR, Nominal                               : 2600MBd

Use sfp_quirk_2500basex for this module to allow 2500Base-X mode anyway.

https://forum.banana-pi.org/t/bpi-r3-sfp-module-compatibility/14573/60

Reported-by: chowtom <chowtom@gmail.com>
Tested-by: chowtom <chowtom@gmail.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/sfp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 5663a184644d5..766f86bdc4a09 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -395,6 +395,10 @@ static const struct sfp_quirk sfp_quirks[] = {
 
 	SFP_QUIRK_F("HALNy", "HL-GSFP", sfp_fixup_halny_gsfp),
 
+	// HG MXPD-483II-F 2.5G supports 2500Base-X, but incorrectly reports
+	// 2600MBd in their EERPOM
+	SFP_QUIRK_M("HG GENUINE", "MXPD-483II", sfp_quirk_2500basex),
+
 	// Huawei MA5671A can operate at 2500base-X, but report 1.2GBd NRZ in
 	// their EEPROM
 	SFP_QUIRK("HUAWEI", "MA5671A", sfp_quirk_2500basex,
-- 
2.39.2



