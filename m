Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3032872C1C7
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237411AbjFLLAb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237693AbjFLK76 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:59:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE9F127F5
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:47:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09CFF6246A
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCCCC433EF;
        Mon, 12 Jun 2023 10:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566819;
        bh=eyxsqUcQA9eBSPdU414V9JAP+FvdrJaOTfy5DAyaKcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AVCjSGlCYQyxNdu8Q6gRoSHUfWlD7ZbgnV/yAQ1tRQJuvqC05FJRLoQVquR31oqyS
         hz0R4wG8XgjTNv7bmAu6IIK6jdyNctZdXjUh//pPp5NkeBIRqz54HIfvI0jJ4Il6kp
         ZxKo9rLdVUlbtieViOAeG0PMexxTYn4M7d+vJ0Ps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Tijs Van Buggenhout <tijs.van.buggenhout@axsguard.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 043/160] netfilter: conntrack: fix NULL pointer dereference in nf_confirm_cthelper
Date:   Mon, 12 Jun 2023 12:26:15 +0200
Message-ID: <20230612101717.016231910@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tijs Van Buggenhout <tijs.van.buggenhout@axsguard.com>

[ Upstream commit e1f543dc660b44618a1bd72ddb4ca0828a95f7ad ]

An nf_conntrack_helper from nf_conn_help may become NULL after DNAT.

Observed when TCP port 1720 (Q931_PORT), associated with h323 conntrack
helper, is DNAT'ed to another destination port (e.g. 1730), while
nfqueue is being used for final acceptance (e.g. snort).

This happenned after transition from kernel 4.14 to 5.10.161.

Workarounds:
 * keep the same port (1720) in DNAT
 * disable nfqueue
 * disable/unload h323 NAT helper

$ linux-5.10/scripts/decode_stacktrace.sh vmlinux < /tmp/kernel.log
BUG: kernel NULL pointer dereference, address: 0000000000000084
[..]
RIP: 0010:nf_conntrack_update (net/netfilter/nf_conntrack_core.c:2080 net/netfilter/nf_conntrack_core.c:2134) nf_conntrack
[..]
nfqnl_reinject (net/netfilter/nfnetlink_queue.c:237) nfnetlink_queue
nfqnl_recv_verdict (net/netfilter/nfnetlink_queue.c:1230) nfnetlink_queue
nfnetlink_rcv_msg (net/netfilter/nfnetlink.c:241) nfnetlink
[..]

Fixes: ee04805ff54a ("netfilter: conntrack: make conntrack userspace helpers work again")
Signed-off-by: Tijs Van Buggenhout <tijs.van.buggenhout@axsguard.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 7ba6ab9b54b56..06582f0a5393c 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -2260,6 +2260,9 @@ static int nf_confirm_cthelper(struct sk_buff *skb, struct nf_conn *ct,
 		return 0;
 
 	helper = rcu_dereference(help->helper);
+	if (!helper)
+		return 0;
+
 	if (!(helper->flags & NF_CT_HELPER_F_USERSPACE))
 		return 0;
 
-- 
2.39.2



