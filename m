Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1407A39C1
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbjIQTxi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbjIQTx1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:53:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F9E9F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:53:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FB7C433C7;
        Sun, 17 Sep 2023 19:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980401;
        bh=TDTadUzuQRitMOZFKaYg50zEo2lOJChy+YIKEgB/RHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1ax8oTEyHDS1ehNjYaZ1X8jFWt4+9aZysMiMjrL48UzI3+94I1ISU/NBwOT0IRabt
         MEzsiMS8F+VHma1lUU3teZlkkJNZNDsBvrHU+j8H+EjqVNM5T5lPt+z8VI43L3kkca
         rIUN8Ju1ccd0Z7pU4NCARkbMCsy0h05lJS2l4Bys=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 164/285] netfilter: nft_set_rbtree: skip sync GC for new elements in this transaction
Date:   Sun, 17 Sep 2023 21:12:44 +0200
Message-ID: <20230917191057.334514055@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

[ Upstream commit 2ee52ae94baabf7ee09cf2a8d854b990dac5d0e4 ]

New elements in this transaction might expired before such transaction
ends. Skip sync GC for such elements otherwise commit path might walk
over an already released object. Once transaction is finished, async GC
will collect such expired element.

Fixes: f6c383b8c31a ("netfilter: nf_tables: adapt set backend to use GC transaction API")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_set_rbtree.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index c6435e7092319..f250b5399344a 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -312,6 +312,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 	struct nft_rbtree_elem *rbe, *rbe_le = NULL, *rbe_ge = NULL;
 	struct rb_node *node, *next, *parent, **p, *first = NULL;
 	struct nft_rbtree *priv = nft_set_priv(set);
+	u8 cur_genmask = nft_genmask_cur(net);
 	u8 genmask = nft_genmask_next(net);
 	int d, err;
 
@@ -357,8 +358,11 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 		if (!nft_set_elem_active(&rbe->ext, genmask))
 			continue;
 
-		/* perform garbage collection to avoid bogus overlap reports. */
-		if (nft_set_elem_expired(&rbe->ext)) {
+		/* perform garbage collection to avoid bogus overlap reports
+		 * but skip new elements in this transaction.
+		 */
+		if (nft_set_elem_expired(&rbe->ext) &&
+		    nft_set_elem_active(&rbe->ext, cur_genmask)) {
 			err = nft_rbtree_gc_elem(set, priv, rbe, genmask);
 			if (err < 0)
 				return err;
-- 
2.40.1



