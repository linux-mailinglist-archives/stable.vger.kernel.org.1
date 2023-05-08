Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C738E6FA65E
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbjEHKSt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjEHKSp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:18:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130E9D070
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:18:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CE09624EF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6EEC433EF;
        Mon,  8 May 2023 10:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541123;
        bh=jLZ5lmXyjYZ53RR+8VrsmYC3rElvscp80gLSEjpeW38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l2UZuSzCUhTn+BZzbJDRn2JDIr7ozjM5LV07dXoy704nKM3AdgH29yBc7hGNd5mwY
         D655E78gYqjER/jILW6BYrwJYC5nJ7eB8tuy0WTTbZqf/cEH0r1C+wIiYqXdcBY6VG
         Ev8NJlZ5gfWZZAG7bh9irigoLmhpV8v4zv1D8t9M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, chowtom <chowtom@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 013/663] net: sfp: add quirk enabling 2500Base-x for HG MXPD-483II
Date:   Mon,  8 May 2023 11:37:19 +0200
Message-Id: <20230508094428.846576592@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index b224800d7db0b..10e66c89ca0fe 100644
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



