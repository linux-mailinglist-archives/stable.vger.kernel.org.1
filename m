Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CC27B88FC
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbjJDSVs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244162AbjJDSVe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:21:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C5298
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:21:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E4AC433C9;
        Wed,  4 Oct 2023 18:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443690;
        bh=DzssuuLuMP67r1VLWOuJriOGEQVLcjpLHnelWy0wFhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kKz7vTlGCs/txrQ1G6GWK84u86LuvQJdy8gfC8ZdLsPewm/w2cJVwEhWy9CssgGFg
         W11DnLnrG1c0rr+6xPWMww6cSeGhZJ3kKswzqpuR/x3Urrg1ADp07iQFKwtoPE/W0S
         QzAO39eso6acZRoiWQVkBL4teppd/22SeETzD/NU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alex Balcanquall <alex@alexbal.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Jiri Pirko <jiri@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.1 245/259] net: thunderbolt: Fix TCPv6 GSO checksum calculation
Date:   Wed,  4 Oct 2023 19:56:58 +0200
Message-ID: <20231004175228.624107879@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
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

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit e0b65f9b81fef180cf5f103adecbe5505c961153 upstream.

Alex reported that running ssh over IPv6 does not work with
Thunderbolt/USB4 networking driver. The reason for that is that driver
should call skb_is_gso() before calling skb_is_gso_v6(), and it should
not return false after calculates the checksum successfully. This probably
was a copy paste error from the original driver where it was done properly.

Reported-by: Alex Balcanquall <alex@alexbal.com>
Fixes: e69b6c02b4c3 ("net: Add support for networking over Thunderbolt cable")
Cc: stable@vger.kernel.org
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/thunderbolt.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/thunderbolt.c
+++ b/drivers/net/thunderbolt.c
@@ -1005,12 +1005,11 @@ static bool tbnet_xmit_csum_and_map(stru
 		*tucso = ~csum_tcpudp_magic(ip_hdr(skb)->saddr,
 					    ip_hdr(skb)->daddr, 0,
 					    ip_hdr(skb)->protocol, 0);
-	} else if (skb_is_gso_v6(skb)) {
+	} else if (skb_is_gso(skb) && skb_is_gso_v6(skb)) {
 		tucso = dest + ((void *)&(tcp_hdr(skb)->check) - data);
 		*tucso = ~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
 					  &ipv6_hdr(skb)->daddr, 0,
 					  IPPROTO_TCP, 0);
-		return false;
 	} else if (protocol == htons(ETH_P_IPV6)) {
 		tucso = dest + skb_checksum_start_offset(skb) + skb->csum_offset;
 		*tucso = ~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,


