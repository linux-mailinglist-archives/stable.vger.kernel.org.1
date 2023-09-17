Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AFA7A3B8E
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240728AbjIQUTP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240838AbjIQUTM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:19:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF1710C
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:19:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0465C433C8;
        Sun, 17 Sep 2023 20:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981944;
        bh=OypeOCBdb00GVPIarUCSZ2/qz0tpEDx1L248ctVpXxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BQod3f5pacFUoXwL/CF4x9h6V/BdGMPdgVcFNhnUxcTlP6O+HCC69wK/Em7uZEIXd
         9fvNdl110yjqQFsnM5PG+ZQOssPHx+p2dcFSsvAqc1gReQsz0j5BUPIXTNpPUvcqaV
         6asSLDvWDWC3Fgk12oq3rsNSaa8CGYOpBGS+li7E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 196/219] net: dsa: sja1105: hide all multicast addresses from "bridge fdb show"
Date:   Sun, 17 Sep 2023 21:15:23 +0200
Message-ID: <20230917191048.026103586@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 02c652f5465011126152bbd93b6a582a1d0c32f1 ]

Commit 4d9423549501 ("net: dsa: sja1105: offload bridge port flags to
device") has partially hidden some multicast entries from showing up in
the "bridge fdb show" output, but it wasn't enough. Addresses which are
added through "bridge mdb add" still show up. Hide them all.

Fixes: 291d1e72b756 ("net: dsa: sja1105: Add support for FDB and MDB management")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index ff94c5996fafb..f8228a81234fe 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -1875,13 +1875,14 @@ static int sja1105_fdb_dump(struct dsa_switch *ds, int port,
 		if (!(l2_lookup.destports & BIT(port)))
 			continue;
 
-		/* We need to hide the FDB entry for unknown multicast */
-		if (l2_lookup.macaddr == SJA1105_UNKNOWN_MULTICAST &&
-		    l2_lookup.mask_macaddr == SJA1105_UNKNOWN_MULTICAST)
-			continue;
-
 		u64_to_ether_addr(l2_lookup.macaddr, macaddr);
 
+		/* Hardware FDB is shared for fdb and mdb, "bridge fdb show"
+		 * only wants to see unicast
+		 */
+		if (is_multicast_ether_addr(macaddr))
+			continue;
+
 		/* We need to hide the dsa_8021q VLANs from the user. */
 		if (vid_is_dsa_8021q(l2_lookup.vlanid))
 			l2_lookup.vlanid = 0;
-- 
2.40.1



