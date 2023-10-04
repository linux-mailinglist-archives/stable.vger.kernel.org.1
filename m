Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105A87B8959
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244162AbjJDSZG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244166AbjJDSZG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:25:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51B9A6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:25:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBECFC433C8;
        Wed,  4 Oct 2023 18:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443902;
        bh=QWrQe9BPPDA+itUuw+PfqeDCzWDbKsxRvG4L51ssKzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gj7WrrrfQS5LgRI5NSahitWoXLyrzY8g6VotD1nsECIrqc6q4++JO7PWM4xterQCy
         BMGgCoBLk1jQOgO3eeLuIlwKyw8QpJn1NOBBjjq19Z3vKBGo3y7OM8xqD+PHf/mhNX
         GQEy9NPNOpIlQCxivJXa5EgYFCTMLRvNTaTZ3lpw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 022/321] netfilter: nft_set_hash: try later when GC hits EAGAIN on iteration
Date:   Wed,  4 Oct 2023 19:52:47 +0200
Message-ID: <20231004175230.201090118@linuxfoundation.org>
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

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit b079155faae94e9b3ab9337e82100a914ebb4e8d upstream.

Skip GC run if iterator rewinds to the beginning with EAGAIN, otherwise GC
might collect the same element more than once.

Fixes: f6c383b8c31a ("netfilter: nf_tables: adapt set backend to use GC transaction API")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_set_hash.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index eca20dc601384..2013de934cef0 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -338,12 +338,9 @@ static void nft_rhash_gc(struct work_struct *work)
 
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
2.40.1



