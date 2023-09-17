Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF54B7A3A18
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240270AbjIQT62 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240328AbjIQT6T (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:58:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAD4101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:58:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAB8C433C8;
        Sun, 17 Sep 2023 19:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980694;
        bh=AhU7LtrBHg72XaDGIf+LuFusXWOUnhZKgskNOJg62Xc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SwrU+RbWAqbax1IyWgGT28E/6ofS5H/TBPsJy89Zb3gVcrIZOvGfO8Us8goSQk5zq
         5IhDadySk9Axw1wX/JOOMONvbO22ORPgJXTn0+R9bZMeL20GH5RKF7LUMwRZGoDjbc
         UGZWq1vXMS6pl914gXCbhGTk0Kp1bIw7GEyhDZSQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ciprian Regus <ciprian.regus@analog.com>,
        Simon Horman <horms@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 259/285] net:ethernet:adi:adin1110: Fix forwarding offload
Date:   Sun, 17 Sep 2023 21:14:19 +0200
Message-ID: <20230917191100.222135649@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ciprian Regus <ciprian.regus@analog.com>

[ Upstream commit 32530dba1bd48da4437d18d9a8dbc9d2826938a6 ]

Currently, when a new fdb entry is added (with both ports of the
ADIN2111 bridged), the driver configures the MAC filters for the wrong
port, which results in the forwarding being done by the host, and not
actually hardware offloaded.

The ADIN2111 offloads the forwarding by setting filters on the
destination MAC address of incoming frames. Based on these, they may be
routed to the other port. Thus, if a frame has to be forwarded from port
1 to port 2, the required configuration for the ADDR_FILT_UPRn register
should set the APPLY2PORT1 bit (instead of APPLY2PORT2, as it's
currently the case).

Fixes: bc93e19d088b ("net: ethernet: adi: Add ADIN1110 support")
Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/adi/adin1110.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
index 1c009b485188d..ca66b747b7c5d 100644
--- a/drivers/net/ethernet/adi/adin1110.c
+++ b/drivers/net/ethernet/adi/adin1110.c
@@ -1385,7 +1385,7 @@ static int adin1110_fdb_add(struct adin1110_port_priv *port_priv,
 		return -ENOMEM;
 
 	other_port = priv->ports[!port_priv->nr];
-	port_rules = adin1110_port_rules(port_priv, false, true);
+	port_rules = adin1110_port_rules(other_port, false, true);
 	eth_broadcast_addr(mask);
 
 	return adin1110_write_mac_address(other_port, mac_nr, (u8 *)fdb->addr,
-- 
2.40.1



