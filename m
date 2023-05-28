Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506DE713E25
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjE1Tc2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjE1Tc1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:32:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77901A8
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:32:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A97961DB0
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D7AC433D2;
        Sun, 28 May 2023 19:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302345;
        bh=8ZVBg6KYRguqBsxtRugMsE4FJebH+PCCH6wdn1uvnQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xPtzd3l+Qk4JkPnFI3f0waHlVmSDluhG/WNB14RDfVbt+ra67cgAh13/rNsvz/Bqk
         RJE/ORObz2VPbaabaO8IH/HVXGYYj3Du7PFO5j1lEGHD832BlMIzAhc8DhkJxYi1+b
         Db74+tjM0zfWeEvIbhSs+3gAanNcbkxn0ramzOZ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sunil Goutham <sgoutham@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.3 071/127] octeontx2-pf: Fix TSOv6 offload
Date:   Sun, 28 May 2023 20:10:47 +0100
Message-Id: <20230528190838.700690331@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sunil Goutham <sgoutham@marvell.com>

commit de678ca38861f2eb58814048076dcf95ed1b5bf9 upstream.

HW adds segment size to the payload length
in the IPv6 header. Fix payload length to
just TCP header length instead of 'TCP header
size + IPv6 header size'.

Fixes: 86d7476078b8 ("octeontx2-pf: TCP segmentation offload support")
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -652,9 +652,7 @@ static void otx2_sqe_add_ext(struct otx2
 				htons(ext->lso_sb - skb_network_offset(skb));
 		} else if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6) {
 			ext->lso_format = pfvf->hw.lso_tsov6_idx;
-
-			ipv6_hdr(skb)->payload_len =
-				htons(ext->lso_sb - skb_network_offset(skb));
+			ipv6_hdr(skb)->payload_len = htons(tcp_hdrlen(skb));
 		} else if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
 			__be16 l3_proto = vlan_get_protocol(skb);
 			struct udphdr *udph = udp_hdr(skb);


