Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282BD7F2CCC
	for <lists+stable@lfdr.de>; Tue, 21 Nov 2023 13:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbjKUMN4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 21 Nov 2023 07:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbjKUMNz (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 21 Nov 2023 07:13:55 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 425EF12C;
        Tue, 21 Nov 2023 04:13:52 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, sashal@kernel.org,
        stable@vger.kernel.org
Subject: [PATCH -stable,5.4 19/26] netfilter: nft_set_hash: try later when GC hits EAGAIN on iteration
Date:   Tue, 21 Nov 2023 13:13:26 +0100
Message-Id: <20231121121333.294238-20-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231121121333.294238-1-pablo@netfilter.org>
References: <20231121121333.294238-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit b079155faae94e9b3ab9337e82100a914ebb4e8d upstream.

Skip GC run if iterator rewinds to the beginning with EAGAIN, otherwise GC
might collect the same element more than once.

Fixes: f6c383b8c31a ("netfilter: nf_tables: adapt set backend to use GC transaction API")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_set_hash.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index 00da952cba3f..0581d5499c5a 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -324,12 +324,9 @@ static void nft_rhash_gc(struct work_struct *work)
 
 	while ((he = rhashtable_walk_next(&hti))) {
 		if (IS_ERR(he)) {
-			if (PTR_ERR(he) != -EAGAIN) {
-				nft_trans_gc_destroy(gc);
-				gc = NULL;
-				goto try_later;
-			}
-			continue;
+			nft_trans_gc_destroy(gc);
+			gc = NULL;
+			goto try_later;
 		}
 
 		/* Ruleset has been updated, try later. */
-- 
2.30.2

