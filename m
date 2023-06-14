Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9766713D87
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjE1T0T (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjE1T0T (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:26:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD14E1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:26:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65DF461C2F
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D2BC433EF;
        Sun, 28 May 2023 19:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301976;
        bh=G4vI9UCc8ia5rsVYBUOB4i9tikUZWSpYNvl207i+JUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qK31wEMDqLn5i7vxKFfsXqJItKoU5jUeXsgtOYv0Gjpm9bxLTg+7emmigVtJqzpLV
         0dLbC+IBVB1s8phsZTqqYz7AOv6MLioDg/NCGk7eyj3r1IpKIe/QNTUnkdlFFBQEk2
         jxNQX0OmKTMzT1H1zavxPZOkMFL5/lU5rhisaGrY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 112/161] netfilter: nf_tables: hold mutex on netns pre_exit path
Date:   Sun, 28 May 2023 20:10:36 +0100
Message-Id: <20230528190840.637411577@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ 3923b1e4406680d57da7e873da77b1683035d83f ]

clean_net() runs in workqueue while walking over the lists, grab mutex.

Fixes: 767d1216bff8 ("netfilter: nftables: fix possible UAF over chains from packet path in netns")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index e4eef4947cc75..909076ef157e8 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -7866,7 +7866,9 @@ static int __net_init nf_tables_init_net(struct net *net)
 
 static void __net_exit nf_tables_pre_exit_net(struct net *net)
 {
+	mutex_lock(&net->nft.commit_mutex);
 	__nft_release_hooks(net);
+	mutex_unlock(&net->nft.commit_mutex);
 }
 
 static void __net_exit nf_tables_exit_net(struct net *net)
-- 
2.39.2



