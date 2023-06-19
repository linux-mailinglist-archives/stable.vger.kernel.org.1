Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AD4735525
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 13:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjFSLBt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 07:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjFSLBd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 07:01:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF2630EC
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 04:00:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6936E60B78
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 11:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80960C433C8;
        Mon, 19 Jun 2023 11:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172438;
        bh=ry/3wrTq4NfdsFJUOZxLBB2BeANMNny2fFTz6vO4Dxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OGcZUuBZoyCY032uqqlJGQaxf6UWCC+t6LlHoE+GGVAXralszBw4GgV3GWV7vGzTP
         DSgSNzHAjK4INq0UUwaA4gFiJzvTliLSDPpMm9q8SLAlrmiV9RnQkrbkQk2QXoqNPo
         Mn1fmDJNUenwiStJMJsnzpc8jro8j9Ib6XqkJsbk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Max Tottenham <mtottenh@akamai.com>,
        Josh Hunt <johunt@akamai.com>,
        kernel test robot <lkp@intel.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 069/107] net/sched: act_pedit: Parse L3 Header for L4 offset
Date:   Mon, 19 Jun 2023 12:30:53 +0200
Message-ID: <20230619102144.756427284@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102141.541044823@linuxfoundation.org>
References: <20230619102141.541044823@linuxfoundation.org>
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

From: Max Tottenham <mtottenh@akamai.com>

[ Upstream commit 6c02568fd1ae53099b4ab86365c5be1ff15f586b ]

Instead of relying on skb->transport_header being set correctly, opt
instead to parse the L3 header length out of the L3 headers for both
IPv4/IPv6 when the Extended Layer Op for tcp/udp is used. This fixes a
bug if GRO is disabled, when GRO is disabled skb->transport_header is
set by __netif_receive_skb_core() to point to the L3 header, it's later
fixed by the upper protocol layers, but act_pedit will receive the SKB
before the fixups are completed. The existing behavior causes the
following to edit the L3 header if GRO is disabled instead of the UDP
header:

    tc filter add dev eth0 ingress protocol ip flower ip_proto udp \
 dst_ip 192.168.1.3 action pedit ex munge udp set dport 18053

Also re-introduce a rate-limited warning if we were unable to extract
the header offset when using the 'ex' interface.

Fixes: 71d0ed7079df ("net/act_pedit: Support using offset relative to
the conventional network headers")
Signed-off-by: Max Tottenham <mtottenh@akamai.com>
Reviewed-by: Josh Hunt <johunt@akamai.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202305261541.N165u9TZ-lkp@intel.com/
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_pedit.c | 48 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index e3bc5bb6c60ef..e77da0545b553 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -13,7 +13,10 @@
 #include <linux/rtnetlink.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
 #include <linux/slab.h>
+#include <net/ipv6.h>
 #include <net/netlink.h>
 #include <net/pkt_sched.h>
 #include <linux/tc_act/tc_pedit.h>
@@ -313,28 +316,58 @@ static bool offset_valid(struct sk_buff *skb, int offset)
 	return true;
 }
 
-static void pedit_skb_hdr_offset(struct sk_buff *skb,
+static int pedit_l4_skb_offset(struct sk_buff *skb, int *hoffset, const int header_type)
+{
+	const int noff = skb_network_offset(skb);
+	int ret = -EINVAL;
+	struct iphdr _iph;
+
+	switch (skb->protocol) {
+	case htons(ETH_P_IP): {
+		const struct iphdr *iph = skb_header_pointer(skb, noff, sizeof(_iph), &_iph);
+
+		if (!iph)
+			goto out;
+		*hoffset = noff + iph->ihl * 4;
+		ret = 0;
+		break;
+	}
+	case htons(ETH_P_IPV6):
+		ret = ipv6_find_hdr(skb, hoffset, header_type, NULL, NULL) == header_type ? 0 : -EINVAL;
+		break;
+	}
+out:
+	return ret;
+}
+
+static int pedit_skb_hdr_offset(struct sk_buff *skb,
 				 enum pedit_header_type htype, int *hoffset)
 {
+	int ret = -EINVAL;
 	/* 'htype' is validated in the netlink parsing */
 	switch (htype) {
 	case TCA_PEDIT_KEY_EX_HDR_TYPE_ETH:
-		if (skb_mac_header_was_set(skb))
+		if (skb_mac_header_was_set(skb)) {
 			*hoffset = skb_mac_offset(skb);
+			ret = 0;
+		}
 		break;
 	case TCA_PEDIT_KEY_EX_HDR_TYPE_NETWORK:
 	case TCA_PEDIT_KEY_EX_HDR_TYPE_IP4:
 	case TCA_PEDIT_KEY_EX_HDR_TYPE_IP6:
 		*hoffset = skb_network_offset(skb);
+		ret = 0;
 		break;
 	case TCA_PEDIT_KEY_EX_HDR_TYPE_TCP:
+		ret = pedit_l4_skb_offset(skb, hoffset, IPPROTO_TCP);
+		break;
 	case TCA_PEDIT_KEY_EX_HDR_TYPE_UDP:
-		if (skb_transport_header_was_set(skb))
-			*hoffset = skb_transport_offset(skb);
+		ret = pedit_l4_skb_offset(skb, hoffset, IPPROTO_UDP);
 		break;
 	default:
 		break;
 	}
+	return ret;
 }
 
 static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
@@ -369,6 +402,7 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 		int hoffset = 0;
 		u32 *ptr, hdata;
 		u32 val;
+		int rc;
 
 		if (tkey_ex) {
 			htype = tkey_ex->htype;
@@ -377,7 +411,11 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 			tkey_ex++;
 		}
 
-		pedit_skb_hdr_offset(skb, htype, &hoffset);
+		rc = pedit_skb_hdr_offset(skb, htype, &hoffset);
+		if (rc) {
+			pr_info_ratelimited("tc action pedit unable to extract header offset for header type (0x%x)\n", htype);
+			goto bad;
+		}
 
 		if (tkey->offmask) {
 			u8 *d, _d;
-- 
2.39.2



