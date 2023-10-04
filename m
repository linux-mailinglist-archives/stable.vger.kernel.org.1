Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09427B89BE
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244274AbjJDS2w (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244264AbjJDS2v (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:28:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9066103
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:28:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AB1C433C7;
        Wed,  4 Oct 2023 18:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444126;
        bh=XW29GKVbWhaaAyPpFPOP15NKFhfhtjQZCsUybsRDoQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HNFMD4NbH6WVQx4/dnytzNBglym++46CzF3ar8dBhwwr912iC9ZSDFW+4OMtuzpiw
         VhXyIsaQxgiEsVXtjq5tyV6q4rzPZAMOHcW36OkMq7CxZ//7uHtY9ehPPr6qb1Y708
         UGd38wXkBfVsGeAFa6oNNm678ckLcfmAXzznshY0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 139/321] xtensa: iss/network: make functions static
Date:   Wed,  4 Oct 2023 19:54:44 +0200
Message-ID: <20231004175235.684937793@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 1b59efeb59851277266318f4e0132aa61ce3455e ]

Make 2 functions static to prevent build warnings:

arch/xtensa/platforms/iss/network.c:204:16: warning: no previous prototype for 'tuntap_protocol' [-Wmissing-prototypes]
  204 | unsigned short tuntap_protocol(struct sk_buff *skb)
arch/xtensa/platforms/iss/network.c:444:6: warning: no previous prototype for 'iss_net_user_timer_expire' [-Wmissing-prototypes]
  444 | void iss_net_user_timer_expire(struct timer_list *unused)

Fixes: 7282bee78798 ("xtensa: Architecture support for Tensilica Xtensa Part 8")
Fixes: d8479a21a98b ("xtensa: Convert timers to use timer_setup()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Message-Id: <20230920052139.10570-14-rdunlap@infradead.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/xtensa/platforms/iss/network.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/platforms/iss/network.c b/arch/xtensa/platforms/iss/network.c
index 85c82cd42188a..e89f27f2bb18d 100644
--- a/arch/xtensa/platforms/iss/network.c
+++ b/arch/xtensa/platforms/iss/network.c
@@ -201,7 +201,7 @@ static int tuntap_write(struct iss_net_private *lp, struct sk_buff **skb)
 	return simc_write(lp->tp.info.tuntap.fd, (*skb)->data, (*skb)->len);
 }
 
-unsigned short tuntap_protocol(struct sk_buff *skb)
+static unsigned short tuntap_protocol(struct sk_buff *skb)
 {
 	return eth_type_trans(skb, skb->dev);
 }
@@ -441,7 +441,7 @@ static int iss_net_change_mtu(struct net_device *dev, int new_mtu)
 	return -EINVAL;
 }
 
-void iss_net_user_timer_expire(struct timer_list *unused)
+static void iss_net_user_timer_expire(struct timer_list *unused)
 {
 }
 
-- 
2.40.1



