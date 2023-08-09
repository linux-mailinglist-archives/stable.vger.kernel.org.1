Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEB6775C88
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjHIL2R (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjHIL2P (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:28:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9AC10D2
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:28:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C06C9632AD
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CA2C433CC;
        Wed,  9 Aug 2023 11:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580494;
        bh=FWkv7CJOmSyN5OB1teJ3E6sAr+f9Pf6bp5Gf34FTrQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fjsow/rCu8iZevXx8uwg+UrZ0oXKLKi3ZNMfmJPMxEl1qhT0e7P67WN7m2jtRE/W7
         VXy3Lj/OQtQ70JSn5zpw5MPqR56F7Xfv9QRajnATO7CJADnx0qYfQEUh4xnl576Lwg
         Y2i84UlhEShcSioP3yGGt7IXxJIzBrponhNBzZYE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 044/154] benet: fix return value check in be_lancer_xmit_workarounds()
Date:   Wed,  9 Aug 2023 12:41:15 +0200
Message-ID: <20230809103638.477365338@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yuanjun Gong <ruc_gongyuanjun@163.com>

[ Upstream commit 5c85f7065718a949902b238a6abd8fc907c5d3e0 ]

in be_lancer_xmit_workarounds(), it should go to label 'tx_drop'
if an unexpected value is returned by pskb_trim().

Fixes: 93040ae5cc8d ("be2net: Fix to trim skb for padded vlan packets to workaround an ASIC Bug")
Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
Link: https://lore.kernel.org/r/20230725032726.15002-1-ruc_gongyuanjun@163.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/emulex/benet/be_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index f1cce7636722e..a7a3e2ee06768 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1140,7 +1140,8 @@ static struct sk_buff *be_lancer_xmit_workarounds(struct be_adapter *adapter,
 	    (lancer_chip(adapter) || BE3_chip(adapter) ||
 	     skb_vlan_tag_present(skb)) && is_ipv4_pkt(skb)) {
 		ip = (struct iphdr *)ip_hdr(skb);
-		pskb_trim(skb, eth_hdr_len + ntohs(ip->tot_len));
+		if (unlikely(pskb_trim(skb, eth_hdr_len + ntohs(ip->tot_len))))
+			goto tx_drop;
 	}
 
 	/* If vlan tag is already inlined in the packet, skip HW VLAN
-- 
2.39.2



