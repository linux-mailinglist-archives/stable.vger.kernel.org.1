Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702FE775D3A
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbjHILfK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbjHILfJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:35:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E941FD7
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:35:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CCC160D24
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:35:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0F7C433C9;
        Wed,  9 Aug 2023 11:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580903;
        bh=AnT4vH8zRzmhHFQ3W+4lIrqyOqjGQ22EeCVD2dnM+bA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wTw8PZsUHf0DAXB3oR+DCpM4aOnKlqJ/FlYIzstqQOT4ZD43J4LttFVnCIcASvjBH
         EZU4VNys1v98LXcFolq6TW6Yho+8sQ/iagnFXh/24oIuuxUEDXm72/qABz45TczwKJ
         95CCkSMVxqKG8Y42vXovlo8cCZcE7TQI9HiE6DEA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiri Pirko <jiri@resnulli.us>,
        Xiao Ma <xiaom@google.com>,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 036/201] ipv6 addrconf: fix bug where deleting a mngtmpaddr can create a new temporary address
Date:   Wed,  9 Aug 2023 12:40:38 +0200
Message-ID: <20230809103645.050924717@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Maciej Żenczykowski <maze@google.com>

[ Upstream commit 69172f0bcb6a09110c5d2a6d792627f5095a9018 ]

currently on 6.4 net/main:

  # ip link add dummy1 type dummy
  # echo 1 > /proc/sys/net/ipv6/conf/dummy1/use_tempaddr
  # ip link set dummy1 up
  # ip -6 addr add 2000::1/64 mngtmpaddr dev dummy1
  # ip -6 addr show dev dummy1

  11: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
      inet6 2000::44f3:581c:8ca:3983/64 scope global temporary dynamic
         valid_lft 604800sec preferred_lft 86172sec
      inet6 2000::1/64 scope global mngtmpaddr
         valid_lft forever preferred_lft forever
      inet6 fe80::e8a8:a6ff:fed5:56d4/64 scope link
         valid_lft forever preferred_lft forever

  # ip -6 addr del 2000::44f3:581c:8ca:3983/64 dev dummy1

  (can wait a few seconds if you want to, the above delete isn't [directly] the problem)

  # ip -6 addr show dev dummy1

  11: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
      inet6 2000::1/64 scope global mngtmpaddr
         valid_lft forever preferred_lft forever
      inet6 fe80::e8a8:a6ff:fed5:56d4/64 scope link
         valid_lft forever preferred_lft forever

  # ip -6 addr del 2000::1/64 mngtmpaddr dev dummy1
  # ip -6 addr show dev dummy1

  11: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
      inet6 2000::81c9:56b7:f51a:b98f/64 scope global temporary dynamic
         valid_lft 604797sec preferred_lft 86169sec
      inet6 fe80::e8a8:a6ff:fed5:56d4/64 scope link
         valid_lft forever preferred_lft forever

This patch prevents this new 'global temporary dynamic' address from being
created by the deletion of the related (same subnet prefix) 'mngtmpaddr'
(which is triggered by there already being no temporary addresses).

Cc: Jiri Pirko <jiri@resnulli.us>
Fixes: 53bd67491537 ("ipv6 addrconf: introduce IFA_F_MANAGETEMPADDR to tell kernel to manage temporary addresses")
Reported-by: Xiao Ma <xiaom@google.com>
Signed-off-by: Maciej Żenczykowski <maze@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/r/20230720160022.1887942-1-maze@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/addrconf.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index d5d10496b4aef..9b414681500a5 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2555,12 +2555,18 @@ static void manage_tempaddrs(struct inet6_dev *idev,
 			ipv6_ifa_notify(0, ift);
 	}
 
-	if ((create || list_empty(&idev->tempaddr_list)) &&
-	    idev->cnf.use_tempaddr > 0) {
+	/* Also create a temporary address if it's enabled but no temporary
+	 * address currently exists.
+	 * However, we get called with valid_lft == 0, prefered_lft == 0, create == false
+	 * as part of cleanup (ie. deleting the mngtmpaddr).
+	 * We don't want that to result in creating a new temporary ip address.
+	 */
+	if (list_empty(&idev->tempaddr_list) && (valid_lft || prefered_lft))
+		create = true;
+
+	if (create && idev->cnf.use_tempaddr > 0) {
 		/* When a new public address is created as described
 		 * in [ADDRCONF], also create a new temporary address.
-		 * Also create a temporary address if it's enabled but
-		 * no temporary address currently exists.
 		 */
 		read_unlock_bh(&idev->lock);
 		ipv6_create_tempaddr(ifp, false);
-- 
2.39.2



