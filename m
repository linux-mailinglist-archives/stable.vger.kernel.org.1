Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39BB7A7ABF
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbjITLpp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbjITLpg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:45:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C065ACF
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:45:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050EAC433C7;
        Wed, 20 Sep 2023 11:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210330;
        bh=J61lUdGXu7LgeUX9BMTlUKoeFIUbL6UTZJQGCi9A0cI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XpasHRMW+jUQ8eH+6he5SInjALC5FuYgkwFBkamnNArECfCX+h+zBEiLetg5N52+E
         lzXhaY7vDGCt1twYdrR4RU58mxeo9DdhoVeFw3LYf0EGcoxBq1RNlObiI1JUXWn4pf
         5K4sMYHnQVaYUBzqPUD/BIu5BkWP4hLALEV3kY5U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, xu xin <xu.xin16@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>, Si Hao <si.hao@zte.com.cn>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 038/211] net/ipv4: return the real errno instead of -EINVAL
Date:   Wed, 20 Sep 2023 13:28:02 +0200
Message-ID: <20230920112846.973958706@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: xu xin <xu.xin16@zte.com.cn>

[ Upstream commit c67180efc507e04a87f22aa68bd7dd832db006b7 ]

For now, No matter what error pointer ip_neigh_for_gw() returns,
ip_finish_output2() always return -EINVAL, which may mislead the upper
users.

For exemple, an application uses sendto to send an UDP packet, but when the
neighbor table overflows, sendto() will get a value of -EINVAL, and it will
cause users to waste a lot of time checking parameters for errors.

Return the real errno instead of -EINVAL.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
Cc: Si Hao <si.hao@zte.com.cn>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Link: https://lore.kernel.org/r/20230807015408.248237-1-xu.xin16@zte.com.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ip_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 6935d07a60c35..a8d2e8b1ff415 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -236,7 +236,7 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
 	net_dbg_ratelimited("%s: No header cache and no neighbour!\n",
 			    __func__);
 	kfree_skb_reason(skb, SKB_DROP_REASON_NEIGH_CREATEFAIL);
-	return -EINVAL;
+	return PTR_ERR(neigh);
 }
 
 static int ip_finish_output_gso(struct net *net, struct sock *sk,
-- 
2.40.1



