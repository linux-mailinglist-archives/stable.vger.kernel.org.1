Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9275726B53
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjFGUY3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbjFGUYO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:24:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AFE2D5B
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:23:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1CEC643CF
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24EFC4339B;
        Wed,  7 Jun 2023 20:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169421;
        bh=s1gTX63/2eY2Hs3kTNTNsK+hdMBfjy05I6UyI/oaRUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lc0d8/AYLsZPMz/ZnXH0zEc14rfTrV4/MCusydj16XtEKgF72xmlJ2S3EdpO6N6Ht
         vsa+wtZGhT+eThd6YkhEBoaiqmPhzje3AlAhWld3iWCn5juMS8UFFaFlDvWFRhhBrl
         nBWAjN7hxpiuQuM7ZMD7RirVCGtFB/UY6Q9X6ALs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xin Long <lucien.xin@gmail.com>,
        Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 075/286] rtnetlink: call validate_linkmsg in rtnl_create_link
Date:   Wed,  7 Jun 2023 22:12:54 +0200
Message-ID: <20230607200925.530464136@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
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

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit b0ad3c179059089d809b477a1d445c1183a7b8fe ]

validate_linkmsg() was introduced by commit 1840bb13c22f5b ("[RTNL]:
Validate hardware and broadcast address attribute for RTM_NEWLINK")
to validate tb[IFLA_ADDRESS/BROADCAST] for existing links. The same
check should also be done for newly created links.

This patch adds validate_linkmsg() call in rtnl_create_link(), to
avoid the invalid address set when creating some devices like:

  # ip link add dummy0 type dummy
  # ip link add link dummy0 name mac0 address 01:02 type macsec

Fixes: 0e06877c6fdb ("[RTNETLINK]: rtnl_link: allow specifying initial device address")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/rtnetlink.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 6e44e92ebdf5d..f37deb18dd02e 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3282,6 +3282,7 @@ struct net_device *rtnl_create_link(struct net *net, const char *ifname,
 	struct net_device *dev;
 	unsigned int num_tx_queues = 1;
 	unsigned int num_rx_queues = 1;
+	int err;
 
 	if (tb[IFLA_NUM_TX_QUEUES])
 		num_tx_queues = nla_get_u32(tb[IFLA_NUM_TX_QUEUES]);
@@ -3317,13 +3318,18 @@ struct net_device *rtnl_create_link(struct net *net, const char *ifname,
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
 
+	err = validate_linkmsg(dev, tb, extack);
+	if (err < 0) {
+		free_netdev(dev);
+		return ERR_PTR(err);
+	}
+
 	dev_net_set(dev, net);
 	dev->rtnl_link_ops = ops;
 	dev->rtnl_link_state = RTNL_LINK_INITIALIZING;
 
 	if (tb[IFLA_MTU]) {
 		u32 mtu = nla_get_u32(tb[IFLA_MTU]);
-		int err;
 
 		err = dev_validate_mtu(dev, mtu, extack);
 		if (err) {
-- 
2.39.2



