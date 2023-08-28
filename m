Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E20878AA56
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjH1KVQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjH1KVF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:21:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C315124
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:20:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CD5A638DC
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F6AC433C8;
        Mon, 28 Aug 2023 10:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218040;
        bh=ZAeSoL2+8FxpwEfSvgEBD9l+LgVRk1wyRVyfVgUjXrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V/N4SMURkLIYt1Vsv89q/r3OYbEhHQHgoqAoHQFPZhHSSg1b5qoNOwWcxri49hPWN
         CC2FZZDOr0jFI1rK8t1y3xKZniHITcyZmsVaqRB4fIICuEDnqZc2LYL/JvZJlYgkGq
         64ofH4VHcPJ0iUWgp6CUD77MCW+rT7YpLlORdX8c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 044/129] netfilter: nf_tables: flush pending destroy work before netlink notifier
Date:   Mon, 28 Aug 2023 12:12:03 +0200
Message-ID: <20230828101158.829298252@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 2c9f0293280e258606e54ed2b96fa71498432eae ]

Destroy work waits for the RCU grace period then it releases the objects
with no mutex held. All releases objects follow this path for
transactions, therefore, order is guaranteed and references to top-level
objects in the hierarchy remain valid.

However, netlink notifier might interfer with pending destroy work.
rcu_barrier() is not correct because objects are not release via RCU
callback. Flush destroy work before releasing objects from netlink
notifier path.

Fixes: d4bc8271db21 ("netfilter: nf_tables: netlink notifier might race to release objects")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 5275c4112b57d..539bc5d5c12fd 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -11084,7 +11084,7 @@ static int nft_rcv_nl_event(struct notifier_block *this, unsigned long event,
 	gc_seq = nft_gc_seq_begin(nft_net);
 
 	if (!list_empty(&nf_tables_destroy_list))
-		rcu_barrier();
+		nf_tables_trans_destroy_flush_work();
 again:
 	list_for_each_entry(table, &nft_net->tables, list) {
 		if (nft_table_has_owner(table) &&
-- 
2.40.1



