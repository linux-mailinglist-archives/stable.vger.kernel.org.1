Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA2273E83A
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjFZSXy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjFZSXd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:23:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741FD2718
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:23:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D441060F5B
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF125C433C8;
        Mon, 26 Jun 2023 18:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803723;
        bh=OMnyraduHxudQPvlaJnTe+F8p6SEBtqJgaZ+pMX6ZWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nVd3YD4SuXUHs6rpBnn8dTrrToNPdlsziZy/lR/axUmqwKpKNsgBABSTpwTFxP5mh
         +qBt9rg9vNmlAr0uZqAfthgSY0aXwFKr0sR+asyUdWEkCTy+QfMcQjehdJp1pfqq/M
         qzyLh5C1Ez+Od8jMvHNOsMdmy3/Ft6r+shAYpFeQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 127/199] be2net: Extend xmit workaround to BE3 chip
Date:   Mon, 26 Jun 2023 20:10:33 +0200
Message-ID: <20230626180811.229898060@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ross Lagerwall <ross.lagerwall@citrix.com>

[ Upstream commit 7580e0a78eb29e7bb1a772eba4088250bbb70d41 ]

We have seen a bug where the NIC incorrectly changes the length in the
IP header of a padded packet to include the padding bytes. The driver
already has a workaround for this so do the workaround for this NIC too.
This resolves the issue.

The NIC in question identifies itself as follows:

[    8.828494] be2net 0000:02:00.0: FW version is 10.7.110.31
[    8.834759] be2net 0000:02:00.0: Emulex OneConnect(be3): PF FLEX10 port 1

02:00.0 Ethernet controller: Emulex Corporation OneConnect 10Gb NIC (be3) (rev 01)

Fixes: ca34fe38f06d ("be2net: fix wrong usage of adapter->generation")
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Link: https://lore.kernel.org/r/20230616164549.2863037-1-ross.lagerwall@citrix.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/emulex/benet/be_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 46fe3d74e2e98..7236c4f70cf51 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1136,8 +1136,8 @@ static struct sk_buff *be_lancer_xmit_workarounds(struct be_adapter *adapter,
 	eth_hdr_len = ntohs(skb->protocol) == ETH_P_8021Q ?
 						VLAN_ETH_HLEN : ETH_HLEN;
 	if (skb->len <= 60 &&
-	    (lancer_chip(adapter) || skb_vlan_tag_present(skb)) &&
-	    is_ipv4_pkt(skb)) {
+	    (lancer_chip(adapter) || BE3_chip(adapter) ||
+	     skb_vlan_tag_present(skb)) && is_ipv4_pkt(skb)) {
 		ip = (struct iphdr *)ip_hdr(skb);
 		pskb_trim(skb, eth_hdr_len + ntohs(ip->tot_len));
 	}
-- 
2.39.2



