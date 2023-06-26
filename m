Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DE073EA45
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjFZSpQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjFZSpP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:45:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFA5B9
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:45:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEB0560F30
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFE3C433C0;
        Mon, 26 Jun 2023 18:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687805114;
        bh=KVPShYAaCqWaqBIzp8kFNJgddeo+w+oTuVnoYHA2/+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DUdJoVczGkQOSOqjv+EACJhPXjIm8/CzXAWUG+ahbP6GWxOQaw/Gaenf0xmAPFx/1
         L790khGFOxvW3+chl/qqmY9VU44zSsH6Pgh8CnFKIR9sWEoPvxLa3x91OytdwQA4uf
         EabnMLuyRgPdf5p9tALAQH+ZwolJ9Zp8xFufiyds=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 54/81] netfilter: nf_tables: disallow element updates of bound anonymous sets
Date:   Mon, 26 Jun 2023 20:12:36 +0200
Message-ID: <20230626180746.663684389@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180744.453069285@linuxfoundation.org>
References: <20230626180744.453069285@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit c88c535b592d3baeee74009f3eceeeaf0fdd5e1b ]

Anonymous sets come with NFT_SET_CONSTANT from userspace. Although API
allows to create anonymous sets without NFT_SET_CONSTANT, it makes no
sense to allow to add and to delete elements for bound anonymous sets.

Fixes: 96518518cc41 ("netfilter: add nftables")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index fe51cedd9cc3c..92ea3332cdda3 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5460,7 +5460,8 @@ static int nf_tables_newsetelem(struct net *net, struct sock *nlsk,
 	if (IS_ERR(set))
 		return PTR_ERR(set);
 
-	if (!list_empty(&set->bindings) && set->flags & NFT_SET_CONSTANT)
+	if (!list_empty(&set->bindings) &&
+	    (set->flags & (NFT_SET_CONSTANT | NFT_SET_ANONYMOUS)))
 		return -EBUSY;
 
 	nla_for_each_nested(attr, nla[NFTA_SET_ELEM_LIST_ELEMENTS], rem) {
@@ -5666,7 +5667,9 @@ static int nf_tables_delsetelem(struct net *net, struct sock *nlsk,
 	set = nft_set_lookup(ctx.table, nla[NFTA_SET_ELEM_LIST_SET], genmask);
 	if (IS_ERR(set))
 		return PTR_ERR(set);
-	if (!list_empty(&set->bindings) && set->flags & NFT_SET_CONSTANT)
+
+	if (!list_empty(&set->bindings) &&
+	    (set->flags & (NFT_SET_CONSTANT | NFT_SET_ANONYMOUS)))
 		return -EBUSY;
 
 	if (nla[NFTA_SET_ELEM_LIST_ELEMENTS] == NULL) {
-- 
2.39.2



