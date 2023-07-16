Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75847556C1
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjGPUxn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjGPUxn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:53:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FE2109
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:53:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 020A760DD4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:53:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE67C433C8;
        Sun, 16 Jul 2023 20:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540821;
        bh=Wum8CCZf59RSHLYAjqTHc39A80Z2ijpkI0+RZtmY6NE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=trnsgArllY94W0IHwlQ5o7U+kVejEERzrvdlmQ2ZUsfiPwtJQ0x9yFqjTtw3KVht5
         aDLhz5e/DQsEFxto4N5NmiYIlpL6oZ7W29KKij6RW9fOEu3ifJ+JqsZwaEkwpD1ZAL
         3avHVX0vimmKT3MEynQrqlINeBeItOVwygmxeFlY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 500/591] net: dsa: tag_sja1105: fix source port decoding in vlan_filtering=0 bridge mode
Date:   Sun, 16 Jul 2023 21:50:39 +0200
Message-ID: <20230716194936.828248534@linuxfoundation.org>
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

[ Upstream commit a398b9ea0c3b791b7a0f4c6029a62cf628f97f22 ]

There was a regression introduced by the blamed commit, where pinging to
a VLAN-unaware bridge would fail with the repeated message "Couldn't
decode source port" coming from the tagging protocol driver.

When receiving packets with a bridge_vid as determined by
dsa_tag_8021q_bridge_join(), dsa_8021q_rcv() will decode:
- source_port = 0 (which isn't really valid, more like "don't know")
- switch_id = 0 (which isn't really valid, more like "don't know")
- vbid = value in range 1-7

Since the blamed patch has reversed the order of the checks, we are now
going to believe that source_port != -1 and switch_id != -1, so they're
valid, but they aren't.

The minimal solution to the problem is to only populate source_port and
switch_id with what dsa_8021q_rcv() came up with, if the vbid is zero,
i.e. the source port information is trustworthy.

Fixes: c1ae02d87689 ("net: dsa: tag_sja1105: always prefer source port information from INCL_SRCPT")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/dsa/tag_sja1105.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index 731dc3a111ef3..6e3699d859dbd 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -568,11 +568,14 @@ static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
 		 * if available. This allows us to not overwrite a valid source
 		 * port and switch ID with zeroes when receiving link-local
 		 * frames from a VLAN-unaware bridged port (non-zero vbid) or a
-		 * VLAN-aware bridged port (non-zero vid).
+		 * VLAN-aware bridged port (non-zero vid). Furthermore, the
+		 * tag_8021q source port information is only of trust when the
+		 * vbid is 0 (precise port). Otherwise, tmp_source_port and
+		 * tmp_switch_id will be zeroes.
 		 */
-		if (source_port == -1)
+		if (vbid == 0 && source_port == -1)
 			source_port = tmp_source_port;
-		if (switch_id == -1)
+		if (vbid == 0 && switch_id == -1)
 			switch_id = tmp_switch_id;
 	} else if (source_port == -1 && switch_id == -1) {
 		/* Packets with no source information have no chance of
-- 
2.39.2



