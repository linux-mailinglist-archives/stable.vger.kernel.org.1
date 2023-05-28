Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9568713FD9
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjE1Tto (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjE1Ttn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:49:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E941B9C
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:49:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8758E62023
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6970C433EF;
        Sun, 28 May 2023 19:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303382;
        bh=wZpaknrifFmpdgcrU9hAWsssO5BucnPYkxKGun6C7qM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0SL4iluaLR2osWo4tT/EtMH9WTLficsgf3U8dk8MkvQQWHccqN/xC8ad80R0pQDB0
         PLlHagm21BtLDOZ6g3jCW5EBFTMVx5sOcSjM3FSqFslEq9lvC9Wtsdv3AYi5DOFtzY
         Yl6FtZAYg2DAonGsqURdgRHf9Bbi9MF5gACzBz8I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pratyush Yadav <ptyadav@amazon.de>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 36/69] net: fix skb leak in __skb_tstamp_tx()
Date:   Sun, 28 May 2023 20:11:56 +0100
Message-Id: <20230528190829.709700506@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190828.358612414@linuxfoundation.org>
References: <20230528190828.358612414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pratyush Yadav <ptyadav@amazon.de>

commit 8a02fb71d7192ff1a9a47c9d937624966c6e09af upstream.

Commit 50749f2dd685 ("tcp/udp: Fix memleaks of sk and zerocopy skbs with
TX timestamp.") added a call to skb_orphan_frags_rx() to fix leaks with
zerocopy skbs. But it ended up adding a leak of its own. When
skb_orphan_frags_rx() fails, the function just returns, leaking the skb
it just cloned. Free it before returning.

This bug was discovered and resolved using Coverity Static Analysis
Security Testing (SAST) by Synopsys, Inc.

Fixes: 50749f2dd685 ("tcp/udp: Fix memleaks of sk and zerocopy skbs with TX timestamp.")
Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://lore.kernel.org/r/20230522153020.32422-1-ptyadav@amazon.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/skbuff.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4961,8 +4961,10 @@ void __skb_tstamp_tx(struct sk_buff *ori
 	} else {
 		skb = skb_clone(orig_skb, GFP_ATOMIC);
 
-		if (skb_orphan_frags_rx(skb, GFP_ATOMIC))
+		if (skb_orphan_frags_rx(skb, GFP_ATOMIC)) {
+			kfree_skb(skb);
 			return;
+		}
 	}
 	if (!skb)
 		return;


