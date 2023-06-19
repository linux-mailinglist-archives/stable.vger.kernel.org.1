Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DE07353EA
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjFSKtg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjFSKtT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:49:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9E510E4
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:49:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C250460B8D
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA104C433BA;
        Mon, 19 Jun 2023 10:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171757;
        bh=T8krhA0H0tKmOqzEK0bDP1WGS860NE/THjs7/34GRjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U0RJDSUGmf2VzK9hwFKFti/o9tS7pGRiiRxWDNMG6CB83pbhNjVDVTosdbot/o7iz
         uhGH+vRIK96muLY13Tix5j2SvPWr9Nkv9Ceh60cANekOlZbjG6dYP5Q5QLaFsWkWyY
         +IzP1LMQkvW5UovkOg0meFvEXBIKP6qE8ZlYMOlY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
        Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 146/166] net: dsa: felix: fix taprio guard band overflow at 10Mbps with jumbo frames
Date:   Mon, 19 Jun 2023 12:30:23 +0200
Message-ID: <20230619102201.801633894@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
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
index cc89cff029e1f..5f6af0870dfd6 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -1253,7 +1253,7 @@ static void vsc9959_tas_guard_bands_update(struct ocelot *ocelot, int port)
 	/* Consider the standard Ethernet overhead of 8 octets preamble+SFD,
 	 * 4 octets FCS, 12 octets IFG.
 	 */
-	needed_bit_time_ps = (maxlen + 24) * picos_per_byte;
+	needed_bit_time_ps = (u64)(maxlen + 24) * picos_per_byte;
 
 	dev_dbg(ocelot->dev,
 		"port %d: max frame size %d needs %llu ps at speed %d\n",
-- 
2.39.2



