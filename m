Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19F876154D
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbjGYL1W (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbjGYL1V (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:27:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7D018F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:27:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 185A661648
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B00FC433C8;
        Tue, 25 Jul 2023 11:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284439;
        bh=p2CWBFnGCo34fM/0P4txOYXPWhUAaxsiEODE3Lc2D34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e0i6VQuZekd2l3GgjC4AgtGd6QGpeLCGGMpPVlhXC9QKUPwFX5aQI5afjvFEeB7fu
         p2CTn6X62oyvBK93mpTtimkw4vRC3z50SlUUy7qorgLk7vJsxiKRrGyDYawU1pyRXt
         sF0DY5yHTrAvf2JPyAHro61Wqt2ebV+RXdRmhVks=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Ziyang Xuan <william.xuanziyang@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 357/509] ipv6/addrconf: fix a potential refcount underflow for idev
Date:   Tue, 25 Jul 2023 12:44:56 +0200
Message-ID: <20230725104610.075228786@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ziyang Xuan <william.xuanziyang@huawei.com>

[ Upstream commit 06a0716949c22e2aefb648526580671197151acc ]

Now in addrconf_mod_rs_timer(), reference idev depends on whether
rs_timer is not pending. Then modify rs_timer timeout.

There is a time gap in [1], during which if the pending rs_timer
becomes not pending. It will miss to hold idev, but the rs_timer
is activated. Thus rs_timer callback function addrconf_rs_timer()
will be executed and put idev later without holding idev. A refcount
underflow issue for idev can be caused by this.

	if (!timer_pending(&idev->rs_timer))
		in6_dev_hold(idev);
		  <--------------[1]
	mod_timer(&idev->rs_timer, jiffies + when);

To fix the issue, hold idev if mod_timer() return 0.

Fixes: b7b1bfce0bb6 ("ipv6: split duplicate address detection and router solicitation timer")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/addrconf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index ed1e5bfc97b31..d5d10496b4aef 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -314,9 +314,8 @@ static void addrconf_del_dad_work(struct inet6_ifaddr *ifp)
 static void addrconf_mod_rs_timer(struct inet6_dev *idev,
 				  unsigned long when)
 {
-	if (!timer_pending(&idev->rs_timer))
+	if (!mod_timer(&idev->rs_timer, jiffies + when))
 		in6_dev_hold(idev);
-	mod_timer(&idev->rs_timer, jiffies + when);
 }
 
 static void addrconf_mod_dad_work(struct inet6_ifaddr *ifp,
-- 
2.39.2



