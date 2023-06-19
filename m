Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57D27352ED
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjFSKkW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjFSKjm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:39:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09824E60
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:39:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 923A460B0D
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:39:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E5BC433C0;
        Mon, 19 Jun 2023 10:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171175;
        bh=WPIb16hqrlz61l0FQA8ADKcKMCDqMZD1I8OUcKmMBzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LeFzhQb5veau3G/OHXQANCcMkEfWxSHwf90k2dB90mLOETwO+zVvh2sTa64OM1934
         Gn99PF3l9KDyKcH0GIaIVmc2oesejc5jaJtmDwvLeAaXjuaRLd1I9rbGKLqDFWVUw/
         jvJOVryAGYHzAfH7w3JgJyohcDg5IhpKUD/FxUsM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
        Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 174/187] net: dsa: felix: fix taprio guard band overflow at 10Mbps with jumbo frames
Date:   Mon, 19 Jun 2023 12:29:52 +0200
Message-ID: <20230619102206.094132849@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 6ac7a27a8b07588497ed53dfd885df9c72bc67e0 ]

The DEV_MAC_MAXLEN_CFG register contains a 16-bit value - up to 65535.
Plus 2 * VLAN_HLEN (4), that is up to 65543.

The picos_per_byte variable is the largest when "speed" is lowest -
SPEED_10 = 10. In that case it is (1000000L * 8) / 10 = 800000.

Their product - 52434400000 - exceeds 32 bits, which is a problem,
because apparently, a multiplication between two 32-bit factors is
evaluated as 32-bit before being assigned to a 64-bit variable.
In fact it's a problem for any MTU value larger than 5368.

Cast one of the factors of the multiplication to u64 to force the
multiplication to take place on 64 bits.

Issue found by Coverity.

Fixes: 55a515b1f5a9 ("net: dsa: felix: drop oversized frames with tc-taprio instead of hanging the port")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/20230613170907.2413559-1-vladimir.oltean@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/ocelot/felix_vsc9959.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index dddb28984bdfc..841c5ebc1afaa 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -1263,7 +1263,7 @@ static void vsc9959_tas_guard_bands_update(struct ocelot *ocelot, int port)
 	/* Consider the standard Ethernet overhead of 8 octets preamble+SFD,
 	 * 4 octets FCS, 12 octets IFG.
 	 */
-	needed_bit_time_ps = (maxlen + 24) * picos_per_byte;
+	needed_bit_time_ps = (u64)(maxlen + 24) * picos_per_byte;
 
 	dev_dbg(ocelot->dev,
 		"port %d: max frame size %d needs %llu ps at speed %d\n",
-- 
2.39.2



