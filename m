Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAF4775762
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjHIKpY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjHIKpX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:45:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EEC10F3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:45:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27C8463123
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35221C433C7;
        Wed,  9 Aug 2023 10:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691577920;
        bh=hEypWzpdw9hCJJSZvGFciHBhDT/I5aM5aI1Z89mnejU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QYnLar2qyOy7HYgZmRDFfZdMn2Akuxz/9BzLuI8gHqvXDp3VGemVJgssFCxPAv/Q+
         xfoRO2wIbVSOG/JlJst/sN4rotQykZ8kkLO0kh3RjFyk8KgN60qqYB8qisxdUiC5Kk
         s6D5pdQFyA+Fdp7cvgDwMQQyOjxxGKnIOpP3CMnE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
        Lin Ma <linma@zju.edu.cn>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 042/165] rtnetlink: let rtnl_bridge_setlink checks IFLA_BRIDGE_MODE length
Date:   Wed,  9 Aug 2023 12:39:33 +0200
Message-ID: <20230809103644.193083308@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Lin Ma <linma@zju.edu.cn>

[ Upstream commit d73ef2d69c0dba5f5a1cb9600045c873bab1fb7f ]

There are totally 9 ndo_bridge_setlink handlers in the current kernel,
which are 1) bnxt_bridge_setlink, 2) be_ndo_bridge_setlink 3)
i40e_ndo_bridge_setlink 4) ice_bridge_setlink 5)
ixgbe_ndo_bridge_setlink 6) mlx5e_bridge_setlink 7)
nfp_net_bridge_setlink 8) qeth_l2_bridge_setlink 9) br_setlink.

By investigating the code, we find that 1-7 parse and use nlattr
IFLA_BRIDGE_MODE but 3 and 4 forget to do the nla_len check. This can
lead to an out-of-attribute read and allow a malformed nlattr (e.g.,
length 0) to be viewed as a 2 byte integer.

To avoid such issues, also for other ndo_bridge_setlink handlers in the
future. This patch adds the nla_len check in rtnl_bridge_setlink and
does an early error return if length mismatches. To make it works, the
break is removed from the parsing for IFLA_BRIDGE_FLAGS to make sure
this nla_for_each_nested iterates every attribute.

Fixes: b1edc14a3fbf ("ice: Implement ice_bridge_getlink and ice_bridge_setlink")
Fixes: 51616018dd1b ("i40e: Add support for getlink, setlink ndo ops")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Link: https://lore.kernel.org/r/20230726075314.1059224-1-linma@zju.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/rtnetlink.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 2fe6a3379aaed..aa1743b2b770b 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -5139,13 +5139,17 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	br_spec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
 	if (br_spec) {
 		nla_for_each_nested(attr, br_spec, rem) {
-			if (nla_type(attr) == IFLA_BRIDGE_FLAGS) {
+			if (nla_type(attr) == IFLA_BRIDGE_FLAGS && !have_flags) {
 				if (nla_len(attr) < sizeof(flags))
 					return -EINVAL;
 
 				have_flags = true;
 				flags = nla_get_u16(attr);
-				break;
+			}
+
+			if (nla_type(attr) == IFLA_BRIDGE_MODE) {
+				if (nla_len(attr) < sizeof(u16))
+					return -EINVAL;
 			}
 		}
 	}
-- 
2.40.1



