Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF967B8942
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244142AbjJDSYK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244147AbjJDSYK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:24:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683AADC
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:24:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B5EC433C8;
        Wed,  4 Oct 2023 18:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443846;
        bh=EuX+YYff5gTgeI9L4hVd5OEqcMjFHB8dZ6VqsK600TY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ctQu3tIkhLC8mh3eK3HZEBz73JUfBIvdO7t0ISFPZjbL/kvYYE4h3hvwBSOaHDU7T
         9uKqT7HXQue7ApYNId6vpeB//MS4WHzH0SFWYMkDxXx3ub93O79FgjE7iu6LNLHsuy
         g10gYjKkYhrcfmusTQurtu51EGpHhyrvUlMPViLc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 041/321] netfilter: nf_tables: Fix entries val in rule reset audit log
Date:   Wed,  4 Oct 2023 19:53:06 +0200
Message-ID: <20231004175231.068831891@linuxfoundation.org>
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

From: Phil Sutter <phil@nwl.cc>

[ Upstream commit 7fb818f248cff996180b7cdcdcb86b6b4f6e44e2 ]

The value in idx and the number of rules handled in that particular
__nf_tables_dump_rules() call is not identical. The former is a cursor
to pick up from if multiple netlink messages are needed, so its value is
ever increasing. Fixing this is not just a matter of subtracting s_idx
from it, though: When resetting rules in multiple chains,
__nf_tables_dump_rules() is called for each and cb->args[0] is not
adjusted in between. Introduce a dedicated counter to record the number
of rules reset in this call in a less confusing way.

While being at it, prevent the direct return upon buffer exhaustion: Any
rules previously dumped into that skb would evade audit logging
otherwise.

Fixes: 9b5ba5c9c5109 ("netfilter: nf_tables: Unbreak audit log reset")
Signed-off-by: Phil Sutter <phil@nwl.cc>
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 018cf368f6a5f..3e6839c03bccc 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3451,6 +3451,8 @@ static int __nf_tables_dump_rules(struct sk_buff *skb,
 	struct net *net = sock_net(skb->sk);
 	const struct nft_rule *rule, *prule;
 	unsigned int s_idx = cb->args[0];
+	unsigned int entries = 0;
+	int ret = 0;
 	u64 handle;
 
 	prule = NULL;
@@ -3473,9 +3475,11 @@ static int __nf_tables_dump_rules(struct sk_buff *skb,
 					NFT_MSG_NEWRULE,
 					NLM_F_MULTI | NLM_F_APPEND,
 					table->family,
-					table, chain, rule, handle, reset) < 0)
-			return 1;
-
+					table, chain, rule, handle, reset) < 0) {
+			ret = 1;
+			break;
+		}
+		entries++;
 		nl_dump_check_consistent(cb, nlmsg_hdr(skb));
 cont:
 		prule = rule;
@@ -3483,10 +3487,10 @@ static int __nf_tables_dump_rules(struct sk_buff *skb,
 		(*idx)++;
 	}
 
-	if (reset && *idx)
-		audit_log_rule_reset(table, cb->seq, *idx);
+	if (reset && entries)
+		audit_log_rule_reset(table, cb->seq, entries);
 
-	return 0;
+	return ret;
 }
 
 static int nf_tables_dump_rules(struct sk_buff *skb,
-- 
2.40.1



