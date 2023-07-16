Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1237553E3
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjGPUYJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjGPUYG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:24:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3428FBC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:24:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4A6E60EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67C2C433C8;
        Sun, 16 Jul 2023 20:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539044;
        bh=2ISJhy1RPwVrHQ5L+W5GHrJMWJ5qw92udeM5B/UO4wY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xq7Ey8izkZklCzfXCr7LQhgV1B2md/zQD9LHSKLu83sUDkd9h+go3kHLy0NGacvCm
         Xso18lgS1K27IorfdXGYa/ye6njTDd4/C0cWHCfKsTvRntvI60aHT7v8pKANoTOQyZ
         WHzy53HjhBoOHVuVLLd76xLg+USyyPLcDFpFf1H4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 668/800] net: dsa: felix: dont drop PTP frames with tag_8021q when RX timestamping is disabled
Date:   Sun, 16 Jul 2023 21:48:41 +0200
Message-ID: <20230716195004.627556754@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

[ Upstream commit 2edcfcbb3c5946609be1d8875473a240b170673b ]

The driver implements a workaround for the fact that it doesn't have an
IRQ source to tell it whether PTP frames are available through the
extraction registers, for those frames to be processed and passed
towards the network stack. That workaround is to configure the switch,
through felix_hwtstamp_set() -> felix_update_trapping_destinations(),
to create two copies of PTP packets: one sent over Ethernet to the DSA
master, and one to be consumed through the aforementioned CPU extraction
queue registers.

The reason why we want PTP packets to be consumed through the CPU
extraction registers in the first place is because we want to see their
hardware RX timestamp. With tag_8021q, that is only visible that way,
and it isn't visible with the copy of the packet that's transmitted over
Ethernet.

The problem with the workaround implementation is that it drops the
packet received over Ethernet, in expectation of its copy being present
in the CPU extraction registers. However, if felix_hwtstamp_set() hasn't
run (aka PTP RX timestamping is disabled), the driver will drop the
original PTP frame and there will be no copy of it in the CPU extraction
registers. So, the network stack will simply not see any PTP frame.

Look at the port's trapping configuration to see whether the driver has
previously enabled the CPU extraction registers. If it hasn't, just
don't RX timestamp the frame and let it be passed up the stack by DSA,
which is perfectly fine.

Fixes: 0a6f17c6ae21 ("net: dsa: tag_ocelot_8021q: add support for PTP timestamping")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/ocelot/felix.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 80861ac090ae3..70c0e2b1936b3 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -1725,6 +1725,18 @@ static bool felix_rxtstamp(struct dsa_switch *ds, int port,
 	u32 tstamp_hi;
 	u64 tstamp;
 
+	switch (type & PTP_CLASS_PMASK) {
+	case PTP_CLASS_L2:
+		if (!(ocelot->ports[port]->trap_proto & OCELOT_PROTO_PTP_L2))
+			return false;
+		break;
+	case PTP_CLASS_IPV4:
+	case PTP_CLASS_IPV6:
+		if (!(ocelot->ports[port]->trap_proto & OCELOT_PROTO_PTP_L4))
+			return false;
+		break;
+	}
+
 	/* If the "no XTR IRQ" workaround is in use, tell DSA to defer this skb
 	 * for RX timestamping. Then free it, and poll for its copy through
 	 * MMIO in the CPU port module, and inject that into the stack from
-- 
2.39.2



