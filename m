Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08A2735465
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjFSKzf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjFSKzH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:55:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC8C3ABD
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:53:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E71BB6068B
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA070C433C8;
        Mon, 19 Jun 2023 10:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172012;
        bh=YEu0zxcwSPXjWpA1BIB3QESyTgEDlZx/dc+LDrko9hM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y3wEiV93/onVR/7+j8SDbxpTryWTKK6+tsULxQWSxIQVBHYaoGk4eytMIT/tM5Jqb
         H/enH47L/ZFQgN42B5MueMCSD0R5X6JvqojeiF8+Lxxmzq9VMf2Fh2OOE7rLCvLSkk
         +5iwhFFCsptaVpmizaUFNIvuCbhSNED9oyQuMTrw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lin Ma <linma@zju.edu.cn>,
        Florian Westphal <fw@strlen.de>,
        Tung Nguyen <tung.q.nguyen@dektech.com.au>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 57/64] net: tipc: resize nlattr array to correct size
Date:   Mon, 19 Jun 2023 12:30:53 +0200
Message-ID: <20230619102135.780629312@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102132.808972458@linuxfoundation.org>
References: <20230619102132.808972458@linuxfoundation.org>
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

From: Lin Ma <linma@zju.edu.cn>

[ Upstream commit 44194cb1b6045dea33ae9a0d54fb7e7cd93a2e09 ]

According to nla_parse_nested_deprecated(), the tb[] is supposed to the
destination array with maxtype+1 elements. In current
tipc_nl_media_get() and __tipc_nl_media_set(), a larger array is used
which is unnecessary. This patch resize them to a proper size.

Fixes: 1e55417d8fc6 ("tipc: add media set to new netlink api")
Fixes: 46f15c6794fb ("tipc: add media get/dump to new netlink api")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Reviewed-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Tung Nguyen <tung.q.nguyen@dektech.com.au>
Link: https://lore.kernel.org/r/20230614120604.1196377-1-linma@zju.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/bearer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 577f71dd63fb4..ca26c41396f74 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -1195,7 +1195,7 @@ int tipc_nl_media_get(struct sk_buff *skb, struct genl_info *info)
 	struct tipc_nl_msg msg;
 	struct tipc_media *media;
 	struct sk_buff *rep;
-	struct nlattr *attrs[TIPC_NLA_BEARER_MAX + 1];
+	struct nlattr *attrs[TIPC_NLA_MEDIA_MAX + 1];
 
 	if (!info->attrs[TIPC_NLA_MEDIA])
 		return -EINVAL;
@@ -1244,7 +1244,7 @@ int __tipc_nl_media_set(struct sk_buff *skb, struct genl_info *info)
 	int err;
 	char *name;
 	struct tipc_media *m;
-	struct nlattr *attrs[TIPC_NLA_BEARER_MAX + 1];
+	struct nlattr *attrs[TIPC_NLA_MEDIA_MAX + 1];
 
 	if (!info->attrs[TIPC_NLA_MEDIA])
 		return -EINVAL;
-- 
2.39.2



