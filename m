Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EBB7D3214
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbjJWLQc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbjJWLQ0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:16:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD44D7E
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:16:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CBAC433C9;
        Mon, 23 Oct 2023 11:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059784;
        bh=8O8DpQW3Vk/K1j40b4Krc3dbR5mpPexD9KXO2VVquLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a7xxINn63JmYko7fo7HTxfKWqYYIYWKK63C012F0/txBseuKtzJkCOWIqlGKRJa92
         LE1tkbJFAFsNdp0J4jb9MYSFP7yBOxbZO4ih0E5H0tXZV132B3GgoGgMk1GNIufpKd
         OHxhcCiFDdq/Ao0I3sa/eO61oTXCNffb4bXgw4r8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Bla=C5=BEej=20Kraj=C5=88=C3=A1k?= <krajnak@levonet.sk>,
        Florian Westphal <fw@strlen.de>
Subject: [PATCH 4.19 51/98] netfilter: nft_payload: fix wrong mac header matching
Date:   Mon, 23 Oct 2023 12:56:40 +0200
Message-ID: <20231023104815.415066188@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104813.580375891@linuxfoundation.org>
References: <20231023104813.580375891@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit d351c1ea2de3e36e608fc355d8ae7d0cc80e6cd6 upstream.

mcast packets get looped back to the local machine.
Such packets have a 0-length mac header, we should treat
this like "mac header not set" and abort rule evaluation.

As-is, we just copy data from the network header instead.

Fixes: 96518518cc41 ("netfilter: add nftables")
Reported-by: Blažej Krajňák <krajnak@levonet.sk>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nft_payload.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -84,7 +84,7 @@ static void nft_payload_eval(const struc
 
 	switch (priv->base) {
 	case NFT_PAYLOAD_LL_HEADER:
-		if (!skb_mac_header_was_set(skb))
+		if (!skb_mac_header_was_set(skb) || skb_mac_header_len(skb) == 0)
 			goto err;
 
 		if (skb_vlan_tag_present(skb)) {


