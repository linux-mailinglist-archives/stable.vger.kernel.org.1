Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224607BDFFA
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377179AbjJINgU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377194AbjJINgS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:36:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D781FC5
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:36:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2886CC433C9;
        Mon,  9 Oct 2023 13:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858576;
        bh=Gd22lmOPcMffvT+ZOZpOSbo5timP7IMd15JAXrQWfrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tQnwpkttgMn20SsLPkD4IOO8zd9FwXcitxhluNiOSKvOyBN/s0d7eMaQ7GD4GC4PV
         BoHwzgg/P72tcCiu5xbAFKsNO5SKwTaPKgnCZB1X55Zk2jaYg0ZHPFK0w+hUCPtDAq
         tFwZjN4skMX1tRGWEHSVZ7rkSfCwDuCPAedNfUxU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 026/226] netfilter: nf_tables: use correct lock to protect gc_list
Date:   Mon,  9 Oct 2023 14:59:47 +0200
Message-ID: <20231009130127.439319313@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit 8357bc946a2abc2a10ca40e5a2105d2b4c57515e upstream.

Use nf_tables_gc_list_lock spinlock, not nf_tables_destroy_list_lock to
protect the gc_list.

Fixes: 5f68718b34a5 ("netfilter: nf_tables: GC transaction API to avoid race with control plane")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 1f67931b86d8e..9fc302a6836ba 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8065,9 +8065,9 @@ static void nft_trans_gc_work(struct work_struct *work)
 	struct nft_trans_gc *trans, *next;
 	LIST_HEAD(trans_gc_list);
 
-	spin_lock(&nf_tables_destroy_list_lock);
+	spin_lock(&nf_tables_gc_list_lock);
 	list_splice_init(&nf_tables_gc_list, &trans_gc_list);
-	spin_unlock(&nf_tables_destroy_list_lock);
+	spin_unlock(&nf_tables_gc_list_lock);
 
 	list_for_each_entry_safe(trans, next, &trans_gc_list, list) {
 		list_del(&trans->list);
-- 
2.40.1



