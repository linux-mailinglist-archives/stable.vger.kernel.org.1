Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535597616F7
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbjGYLoD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbjGYLna (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:43:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B694F2
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:43:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E65AF615BA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:43:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E3EC433C8;
        Tue, 25 Jul 2023 11:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285381;
        bh=WpK5JFOCiF6DwXb5P466/JraED6r5Xf2KsSaKhz7uJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yMzm2LJOGaxTpjKYdIYyrIjNscRDgr4Kv42UQTWrcmlx9GFnANg1jV7zHpZrc8Wkl
         UgqdL5+EAqc4tT5Zvwynz7B4I8mbO1PGhHl4L4fuWjA/LnCDLOrgHzr6BhV06T0ojl
         gpBt58Lqqb+UTXwjVKNKGu3wJh/wwkqJwszeZF28=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
        Simon Horman <simon.horman@corigine.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 157/313] net: dsa: tag_sja1105: fix MAC DA patching from meta frames
Date:   Tue, 25 Jul 2023 12:45:10 +0200
Message-ID: <20230725104527.767562609@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 1dcf6efd5f0c1f4496b3ef7ec5a7db104a53b38c ]

The SJA1105 manual says that at offset 4 into the meta frame payload we
have "MAC destination byte 2" and at offset 5 we have "MAC destination
byte 1". These are counted from the LSB, so byte 1 is h_dest[ETH_HLEN-2]
aka h_dest[4] and byte 2 is h_dest[ETH_HLEN-3] aka h_dest[3].

The sja1105_meta_unpack() function decodes these the other way around,
so a frame with MAC DA 01:80:c2:11:22:33 is received by the network
stack as having 01:80:c2:22:11:33.

Fixes: e53e18a6fe4d ("net: dsa: sja1105: Receive and decode meta frames")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/dsa/tag_sja1105.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index 12f3ce52e62eb..836a75030a520 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -48,8 +48,8 @@ static void sja1105_meta_unpack(const struct sk_buff *skb,
 	 * a unified unpacking command for both device series.
 	 */
 	packing(buf,     &meta->tstamp,     31, 0, 4, UNPACK, 0);
-	packing(buf + 4, &meta->dmac_byte_4, 7, 0, 1, UNPACK, 0);
-	packing(buf + 5, &meta->dmac_byte_3, 7, 0, 1, UNPACK, 0);
+	packing(buf + 4, &meta->dmac_byte_3, 7, 0, 1, UNPACK, 0);
+	packing(buf + 5, &meta->dmac_byte_4, 7, 0, 1, UNPACK, 0);
 	packing(buf + 6, &meta->source_port, 7, 0, 1, UNPACK, 0);
 	packing(buf + 7, &meta->switch_id,   7, 0, 1, UNPACK, 0);
 }
-- 
2.39.2



