Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBC77556AA
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjGPUws (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjGPUwr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:52:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F97D109
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:52:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2AFE60EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:52:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09692C433C7;
        Sun, 16 Jul 2023 20:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540765;
        bh=FOQOEFcuSzgNjGAZPn1nOWIwBt3ImZzTz39Bmy7khPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qsbNRu1NSWDqXoQOsDsnAjJKdyvQHWBeCUjf+ZVnKfzu6RkU6kQrmIizHaReJu80n
         MAIdar7uyIbttwxg5sHmYEiwIaRdnpvVtIBduXXRbteH5AwWtaxuUMsAQFZgV2kr0Z
         S9yezfkCUdDyoOFpfRSbjAtDPd9KhZYXjsbLP62Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
        Simon Horman <simon.horman@corigine.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 479/591] net: dsa: tag_sja1105: always prefer source port information from INCL_SRCPT
Date:   Sun, 16 Jul 2023 21:50:18 +0200
Message-ID: <20230716194936.294304138@linuxfoundation.org>
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

[ Upstream commit c1ae02d876898b1b8ca1e12c6f84d7b406263800 ]

Currently the sja1105 tagging protocol prefers using the source port
information from the VLAN header if that is available, falling back to
the INCL_SRCPT option if it isn't. The VLAN header is available for all
frames except for META frames initiated by the switch (containing RX
timestamps), and thus, the "if (is_link_local)" branch is practically
dead.

The tag_8021q source port identification has become more loose
("imprecise") and will report a plausible rather than exact bridge port,
when under a bridge (be it VLAN-aware or VLAN-unaware). But link-local
traffic always needs to know the precise source port. With incorrect
source port reporting, for example PTP traffic over 2 bridged ports will
all be seen on sockets opened on the first such port, which is incorrect.

Now that the tagging protocol has been changed to make link-local frames
always contain source port information, we can reverse the order of the
checks so that we always give precedence to that information (which is
always precise) in lieu of the tag_8021q VID which is only precise for a
standalone port.

Fixes: d7f9787a763f ("net: dsa: tag_8021q: add support for imprecise RX based on the VBID")
Fixes: 91495f21fcec ("net: dsa: tag_8021q: replace the SVL bridging with VLAN-unaware IVL bridging")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/dsa/tag_sja1105.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index 1a85125bda6da..731dc3a111ef3 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -540,10 +540,7 @@ static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
 	is_link_local = sja1105_is_link_local(skb);
 	is_meta = sja1105_is_meta_frame(skb);
 
-	if (sja1105_skb_has_tag_8021q(skb)) {
-		/* Normal traffic path. */
-		sja1105_vlan_rcv(skb, &source_port, &switch_id, &vbid, &vid);
-	} else if (is_link_local) {
+	if (is_link_local) {
 		/* Management traffic path. Switch embeds the switch ID and
 		 * port ID into bytes of the destination MAC, courtesy of
 		 * the incl_srcpt options.
@@ -557,16 +554,39 @@ static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
 		sja1105_meta_unpack(skb, &meta);
 		source_port = meta.source_port;
 		switch_id = meta.switch_id;
-	} else {
+	}
+
+	/* Normal data plane traffic and link-local frames are tagged with
+	 * a tag_8021q VLAN which we have to strip
+	 */
+	if (sja1105_skb_has_tag_8021q(skb)) {
+		int tmp_source_port = -1, tmp_switch_id = -1;
+
+		sja1105_vlan_rcv(skb, &tmp_source_port, &tmp_switch_id, &vbid,
+				 &vid);
+		/* Preserve the source information from the INCL_SRCPT option,
+		 * if available. This allows us to not overwrite a valid source
+		 * port and switch ID with zeroes when receiving link-local
+		 * frames from a VLAN-unaware bridged port (non-zero vbid) or a
+		 * VLAN-aware bridged port (non-zero vid).
+		 */
+		if (source_port == -1)
+			source_port = tmp_source_port;
+		if (switch_id == -1)
+			switch_id = tmp_switch_id;
+	} else if (source_port == -1 && switch_id == -1) {
+		/* Packets with no source information have no chance of
+		 * getting accepted, drop them straight away.
+		 */
 		return NULL;
 	}
 
-	if (vbid >= 1)
+	if (source_port != -1 && switch_id != -1)
+		skb->dev = dsa_master_find_slave(netdev, switch_id, source_port);
+	else if (vbid >= 1)
 		skb->dev = dsa_tag_8021q_find_port_by_vbid(netdev, vbid);
-	else if (source_port == -1 || switch_id == -1)
-		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
 	else
-		skb->dev = dsa_master_find_slave(netdev, switch_id, source_port);
+		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
 	if (!skb->dev) {
 		netdev_warn(netdev, "Couldn't decode source port\n");
 		return NULL;
-- 
2.39.2



