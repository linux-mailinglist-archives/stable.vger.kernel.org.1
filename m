Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9F175CDA2
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjGUQNj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjGUQNV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:13:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652F12D51
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:12:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08CBE61D25
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB79C433C8;
        Fri, 21 Jul 2023 16:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955973;
        bh=nmE46vFbPf2qdmBnpaHtHrdwdIg+8XHi0/YDu6f58Xk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k4FH26alBkIE8xqvr6FYBb52WLxjrvSsU97krtNf/54MDBjOQVY1uuigK9pmur0v1
         nIi/pEYkRDtLEc7bTTqMgWbS1Q2p6d8LySRHBXTUzx2q2boc1kPs0lNp0LWrevQwTs
         mpIzo2Fszm5J18ausbYgiGUkNUb5cqKkicFYBTNE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 095/292] net/sched: flower: Ensure both minimum and maximum ports are specified
Date:   Fri, 21 Jul 2023 18:03:24 +0200
Message-ID: <20230721160532.880343371@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit d3f87278bcb80bd7f9519669d928b43320363d4f ]

The kernel does not currently validate that both the minimum and maximum
ports of a port range are specified. This can lead user space to think
that a filter matching on a port range was successfully added, when in
fact it was not. For example, with a patched (buggy) iproute2 that only
sends the minimum port, the following commands do not return an error:

 # tc filter add dev swp1 ingress pref 1 proto ip flower ip_proto udp src_port 100-200 action pass

 # tc filter add dev swp1 ingress pref 1 proto ip flower ip_proto udp dst_port 100-200 action pass

 # tc filter show dev swp1 ingress
 filter protocol ip pref 1 flower chain 0
 filter protocol ip pref 1 flower chain 0 handle 0x1
   eth_type ipv4
   ip_proto udp
   not_in_hw
         action order 1: gact action pass
          random type none pass val 0
          index 1 ref 1 bind 1

 filter protocol ip pref 1 flower chain 0 handle 0x2
   eth_type ipv4
   ip_proto udp
   not_in_hw
         action order 1: gact action pass
          random type none pass val 0
          index 2 ref 1 bind 1

Fix by returning an error unless both ports are specified:

 # tc filter add dev swp1 ingress pref 1 proto ip flower ip_proto udp src_port 100-200 action pass
 Error: Both min and max source ports must be specified.
 We have an error talking to the kernel

 # tc filter add dev swp1 ingress pref 1 proto ip flower ip_proto udp dst_port 100-200 action pass
 Error: Both min and max destination ports must be specified.
 We have an error talking to the kernel

Fixes: 5c72299fba9d ("net: sched: cls_flower: Classify packets using port ranges")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/cls_flower.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 815c3e416bc54..652158f612fc2 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -799,6 +799,16 @@ static int fl_set_key_port_range(struct nlattr **tb, struct fl_flow_key *key,
 		       TCA_FLOWER_KEY_PORT_SRC_MAX, &mask->tp_range.tp_max.src,
 		       TCA_FLOWER_UNSPEC, sizeof(key->tp_range.tp_max.src));
 
+	if (mask->tp_range.tp_min.dst != mask->tp_range.tp_max.dst) {
+		NL_SET_ERR_MSG(extack,
+			       "Both min and max destination ports must be specified");
+		return -EINVAL;
+	}
+	if (mask->tp_range.tp_min.src != mask->tp_range.tp_max.src) {
+		NL_SET_ERR_MSG(extack,
+			       "Both min and max source ports must be specified");
+		return -EINVAL;
+	}
 	if (mask->tp_range.tp_min.dst && mask->tp_range.tp_max.dst &&
 	    ntohs(key->tp_range.tp_max.dst) <=
 	    ntohs(key->tp_range.tp_min.dst)) {
-- 
2.39.2



