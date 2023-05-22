Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5597E70C9B0
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbjEVTuo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbjEVTum (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:50:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC91C102
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:50:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6675162AFA
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:50:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8360BC4339C;
        Mon, 22 May 2023 19:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785035;
        bh=zCkeMoQYaZSK3g+MQsHJxfqpCL+dh4JwrfE7xTCi+Hk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UiCcTqEdTxhP2w9t4Puo1yiwExSCblDxnOxSP3LGS8E2hp/X/ZjBpXvepwMf9oTsw
         ahNDc1g9r4uGus56b0lsq2vfzMnBToDrSlqS2vsuTQg+emqA1ux4owFOp8xicAHpNP
         PXHBPDb0wSGrQq67FZk/65ZmImdUSWm2fMFu/R1s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xin Long <lucien.xin@gmail.com>,
        Jon Maloy <jmaloy@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 258/364] tipc: check the bearer min mtu properly when setting it by netlink
Date:   Mon, 22 May 2023 20:09:23 +0100
Message-Id: <20230522190419.153465564@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 35a089b5d793d2bfd2cc7cfa6104545184de2ce7 ]

Checking the bearer min mtu with tipc_udp_mtu_bad() only works for
IPv4 UDP bearer, and IPv6 UDP bearer has a different value for the
min mtu. This patch checks with encap_hlen + TIPC_MIN_BEARER_MTU
for min mtu, which works for both IPv4 and IPv6 UDP bearer.

Note that tipc_udp_mtu_bad() is still used to check media min mtu
in __tipc_nl_media_set(), as m->mtu currently is only used by the
IPv4 UDP bearer as its default mtu value.

Fixes: 682cd3cf946b ("tipc: confgiure and apply UDP bearer MTU on running links")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Jon Maloy <jmaloy@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/bearer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 0e9a29e1536b7..53881406e2006 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -1151,8 +1151,8 @@ int __tipc_nl_bearer_set(struct sk_buff *skb, struct genl_info *info)
 				return -EINVAL;
 			}
 #ifdef CONFIG_TIPC_MEDIA_UDP
-			if (tipc_udp_mtu_bad(nla_get_u32
-					     (props[TIPC_NLA_PROP_MTU]))) {
+			if (nla_get_u32(props[TIPC_NLA_PROP_MTU]) <
+			    b->encap_hlen + TIPC_MIN_BEARER_MTU) {
 				NL_SET_ERR_MSG(info->extack,
 					       "MTU value is out-of-range");
 				return -EINVAL;
-- 
2.39.2



