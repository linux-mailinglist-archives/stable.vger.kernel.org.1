Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD1E7BDDC3
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376990AbjJINNN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376936AbjJINNB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:13:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9924510E2
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:11:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1680AC433CD;
        Mon,  9 Oct 2023 13:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857116;
        bh=zrvGML7J33AOGo32p60FVf5SURyxoyU8e3upnXHpDKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ziFo/SZrAfgLkb0I4nm6ipwWLXf6e3vHXa060C8bKFlBn2jfnZVPYIhX5P9dfxCuC
         zgDQDvnlRN9yqk/D8WhP6YHSdqqP6qo3q678N/p3JNB7+2awMKSgOaaI3+j8QIfOsK
         gWrDu+aJHa7sxv5Cwp423jiZQc1AH+YbQhXXaNKc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Simon Horman <horms@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 102/163] net: fix possible store tearing in neigh_periodic_work()
Date:   Mon,  9 Oct 2023 15:01:06 +0200
Message-ID: <20231009130126.846794667@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 25563b581ba3a1f263a00e8c9a97f5e7363be6fd ]

While looking at a related syzbot report involving neigh_periodic_work(),
I found that I forgot to add an annotation when deleting an
RCU protected item from a list.

Readers use rcu_deference(*np), we need to use either
rcu_assign_pointer() or WRITE_ONCE() on writer side
to prevent store tearing.

I use rcu_assign_pointer() to have lockdep support,
this was the choice made in neigh_flush_dev().

Fixes: 767e97e1e0db ("neigh: RCU conversion of struct neighbour")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/neighbour.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index ddd0f32de20ef..b57d3ea3ccc9e 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -988,7 +988,9 @@ static void neigh_periodic_work(struct work_struct *work)
 			    (state == NUD_FAILED ||
 			     !time_in_range_open(jiffies, n->used,
 						 n->used + NEIGH_VAR(n->parms, GC_STALETIME)))) {
-				*np = n->next;
+				rcu_assign_pointer(*np,
+					rcu_dereference_protected(n->next,
+						lockdep_is_held(&tbl->lock)));
 				neigh_mark_dead(n);
 				write_unlock(&n->lock);
 				neigh_cleanup_and_release(n);
-- 
2.40.1



