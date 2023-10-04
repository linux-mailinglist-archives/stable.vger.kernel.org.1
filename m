Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0817B8823
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243762AbjJDSNC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243949AbjJDSNB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:13:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF53CE
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:12:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1145EC433C8;
        Wed,  4 Oct 2023 18:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443177;
        bh=CdaWCFqnjwPY7G0BRYShD95wtZ+4r+uHl/Ri6NeoYRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WmrlrPxleta10NWbEAXFXcCbR5R7s/6AmOpFLJtPzHkovmf6ZZRldQWCrp596Tw45
         X49fUPPoYerklX79wfQkQFZQ4S+oj8ZrlCGXPvg+DOAoGae2bJKZT3EyomoaBZ7Xtu
         1vXeoBfiCztlr/SCRjqZQie+QhmHYy6F7NiypaCI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 035/259] netfilter: nft_set_hash: try later when GC hits EAGAIN on iteration
Date:   Wed,  4 Oct 2023 19:53:28 +0200
Message-ID: <20231004175219.046374915@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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



