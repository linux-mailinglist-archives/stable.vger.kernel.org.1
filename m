Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D94A78ABBF
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjH1KeD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjH1Kdu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:33:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2211B3
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:33:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A55B263D39
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE450C433C8;
        Mon, 28 Aug 2023 10:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218778;
        bh=WqSKMcxCM90ZkiFlsXnF/XM0kMelgjcT1eCZw/pHfYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dgP+g5/I/zSmIovJ8hu/xAgcQtu+fMXi5nBbxVuUHU7s6wNib1aNV9XiuTorneyV9
         lanA9nnIs1sDCSMmIQFgx/Ij+IuIcc+A3A35PMro6TTrnmY/v7H2Gd66Se8LLyaZa9
         bAFQGNhfpDsao18oTHrZ7IAsuOnZH+ld5ZR0+vG0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 051/122] netfilter: nf_tables: flush pending destroy work before netlink notifier
Date:   Mon, 28 Aug 2023 12:12:46 +0200
Message-ID: <20230828101158.109056640@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
References: <20230828101156.480754469@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 4c2df7af73f76..3c5cac9bd9b70 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -10509,7 +10509,7 @@ static int nft_rcv_nl_event(struct notifier_block *this, unsigned long event,
 	deleted = 0;
 	mutex_lock(&nft_net->commit_mutex);
 	if (!list_empty(&nf_tables_destroy_list))
-		rcu_barrier();
+		nf_tables_trans_destroy_flush_work();
 again:
 	list_for_each_entry(table, &nft_net->tables, list) {
 		if (nft_table_has_owner(table) &&
-- 
2.40.1



