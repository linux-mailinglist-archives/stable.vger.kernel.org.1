Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A0675CD85
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjGUQMb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjGUQML (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:12:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F393C04
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:11:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C3BE61D3D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BCFC433C7;
        Fri, 21 Jul 2023 16:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955886;
        bh=58dp7sY0aS9MKjRjQbfa6+xHaV/2QSvfNNYteMtSJvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xe2SzElY0sRPRHwN8WbsT/oCuYpQw4si7IVxKqyaFP8FvSmqTin0CVbFlg5QT7FSR
         jGLYyPblhKkyga9ZiNOW9sHp5YfpPDC9Y+i7VMqZ6QBOZfYFP6L5Cs4y1Oapw9jNUH
         yvdnhpvz5q60Wwyg27v7R7iXYWPo1B9vVamwFkMc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Ziyang Xuan <william.xuanziyang@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 064/292] ipv6/addrconf: fix a potential refcount underflow for idev
Date:   Fri, 21 Jul 2023 18:02:53 +0200
Message-ID: <20230721160531.540922421@linuxfoundation.org>
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
index 3797917237d03..5affca8e2f53a 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -318,9 +318,8 @@ static void addrconf_del_dad_work(struct inet6_ifaddr *ifp)
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



