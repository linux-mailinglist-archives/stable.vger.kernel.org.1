Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0404C7BDF94
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377081AbjJINbc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377077AbjJINbb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:31:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D5BB9
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:31:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD49BC433C8;
        Mon,  9 Oct 2023 13:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858290;
        bh=zKGL3RVIboiZMfOo5Lirthiy1Ggr8qyrIOoy7NKU2u4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AUIIqhpOX97GLHAYh3LtTgZOxjwwj/iRxFOn2CWWnN3BHQcN6h31gE0eYp9cibzwQ
         Yyweq45JT3CmkumR1EKlR81UxcJHn0AqM+UXNmYW8Da1iZrGRxBUgVgwmObn45QGPE
         o3yd0ZwbTL4tPO47hH0j5TkbW+jKB3k84UjWvumE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 048/131] xtensa: iss/network: make functions static
Date:   Mon,  9 Oct 2023 15:01:28 +0200
Message-ID: <20231009130117.778676629@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index cbca91bb5334a..d54bcaa194d46 100644
--- a/arch/xtensa/platforms/iss/network.c
+++ b/arch/xtensa/platforms/iss/network.c
@@ -204,7 +204,7 @@ static int tuntap_write(struct iss_net_private *lp, struct sk_buff **skb)
 	return simc_write(lp->tp.info.tuntap.fd, (*skb)->data, (*skb)->len);
 }
 
-unsigned short tuntap_protocol(struct sk_buff *skb)
+static unsigned short tuntap_protocol(struct sk_buff *skb)
 {
 	return eth_type_trans(skb, skb->dev);
 }
@@ -477,7 +477,7 @@ static int iss_net_change_mtu(struct net_device *dev, int new_mtu)
 	return -EINVAL;
 }
 
-void iss_net_user_timer_expire(struct timer_list *unused)
+static void iss_net_user_timer_expire(struct timer_list *unused)
 {
 }
 
-- 
2.40.1



