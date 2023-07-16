Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6AC7556A5
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjGPUwd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjGPUwd (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:52:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B419E9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:52:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3EBE60DFD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58A7C433C8;
        Sun, 16 Jul 2023 20:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540751;
        bh=oNcKor8YxzGCcaFkm4zYjmsdqphe2u6l+7pp4eimGvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YOrg/M5L4JNIP0XSUMC5najH59sx6D0oqWPOlgsy37l4o5I0pGyEXpBXUatKny9x8
         HEl5ymCocAacoNm8SbFcou480oXCjp0KQktlc4mrGOxNaToad83XkkjqqOwgLZ5zcK
         xVd5sT6STzdZK91qs8H9Go7InDm23ftHqBtjseEk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 475/591] net: mscc: ocelot: dont report that RX timestamping is enabled by default
Date:   Sun, 16 Jul 2023 21:50:14 +0200
Message-ID: <20230716194936.192827557@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 4fd44b82b7aceaa35c2901c6546d2c4198e0799d ]

PTP RX timestamping should be enabled when the user requests it, not by
default. If it is enabled by default, it can be problematic when the
ocelot driver is a DSA master, and it sidesteps what DSA tries to avoid
through __dsa_master_hwtstamp_validate().

Additionally, after the change which made ocelot trap PTP packets only
to the CPU at ocelot_hwtstamp_set() time, it is no longer even true that
RX timestamping is enabled by default, because until ocelot_hwtstamp_set()
is called, the PTP traps are actually not set up. So the rx_filter field
of ocelot->hwtstamp_config reflects an incorrect reality.

Fixes: 96ca08c05838 ("net: mscc: ocelot: set up traps for PTP packets")
Fixes: 4e3b0468e6d7 ("net: mscc: PTP Hardware Clock (PHC) support")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mscc/ocelot_ptp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_ptp.c b/drivers/net/ethernet/mscc/ocelot_ptp.c
index 2180ae94c7447..673bfd70867a6 100644
--- a/drivers/net/ethernet/mscc/ocelot_ptp.c
+++ b/drivers/net/ethernet/mscc/ocelot_ptp.c
@@ -824,11 +824,6 @@ int ocelot_init_timestamp(struct ocelot *ocelot,
 
 	ocelot_write(ocelot, PTP_CFG_MISC_PTP_EN, PTP_CFG_MISC);
 
-	/* There is no device reconfiguration, PTP Rx stamping is always
-	 * enabled.
-	 */
-	ocelot->hwtstamp_config.rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
-
 	return 0;
 }
 EXPORT_SYMBOL(ocelot_init_timestamp);
-- 
2.39.2



