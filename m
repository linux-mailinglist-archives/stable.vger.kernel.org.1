Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99E77A3A38
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240329AbjIQUAI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240357AbjIQT74 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:59:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D05EE
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:59:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED77CC433C8;
        Sun, 17 Sep 2023 19:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980791;
        bh=eza7oMwCjHMskaNEdgBCJDmdAgOP257nOqTwlN7s0QU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iJX8FzqtuQpS5zcjk/l3YD0kh/Vcr8QGlR0R6Rat1lj2P3/F1o6kz2dbbFJEkKKB2
         Fyq2bqmUTsYD1fH6Lgd1QLUQxW1NAFlMZETvMaW67/RxML275UTDyE/8Oq0OwVpmIy
         X+ZXYfZ16O9xVy+/JipeqQ9t/hKjTAeCClTFn7Rg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lars Ekman <uablrek@gmail.com>,
        Quan Tian <qtian@vmware.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.1 001/219] net/ipv6: SKB symmetric hash should incorporate transport ports
Date:   Sun, 17 Sep 2023 21:12:08 +0200
Message-ID: <20230917191041.017060998@linuxfoundation.org>
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

From: Quan Tian <qtian@vmware.com>

commit a5e2151ff9d5852d0ababbbcaeebd9646af9c8d9 upstream.

__skb_get_hash_symmetric() was added to compute a symmetric hash over
the protocol, addresses and transport ports, by commit eb70db875671
("packet: Use symmetric hash for PACKET_FANOUT_HASH."). It uses
flow_keys_dissector_symmetric_keys as the flow_dissector to incorporate
IPv4 addresses, IPv6 addresses and ports. However, it should not specify
the flag as FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL, which stops further
dissection when an IPv6 flow label is encountered, making transport
ports not being incorporated in such case.

As a consequence, the symmetric hash is based on 5-tuple for IPv4 but
3-tuple for IPv6 when flow label is present. It caused a few problems,
e.g. when nft symhash and openvswitch l4_sym rely on the symmetric hash
to perform load balancing as different L4 flows between two given IPv6
addresses would always get the same symmetric hash, leading to uneven
traffic distribution.

Removing the use of FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL makes sure the
symmetric hash is based on 5-tuple for both IPv4 and IPv6 consistently.

Fixes: eb70db875671 ("packet: Use symmetric hash for PACKET_FANOUT_HASH.")
Reported-by: Lars Ekman <uablrek@gmail.com>
Closes: https://github.com/antrea-io/antrea/issues/5457
Signed-off-by: Quan Tian <qtian@vmware.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/flow_dissector.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1738,8 +1738,7 @@ u32 __skb_get_hash_symmetric(const struc
 
 	memset(&keys, 0, sizeof(keys));
 	__skb_flow_dissect(NULL, skb, &flow_keys_dissector_symmetric,
-			   &keys, NULL, 0, 0, 0,
-			   FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
+			   &keys, NULL, 0, 0, 0, 0);
 
 	return __flow_hash_from_keys(&keys, &hashrnd);
 }


