Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BEC73EA5E
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjFZSqa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjFZSq3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:46:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5C4E3
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:46:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A41A660F30
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A45C433C8;
        Mon, 26 Jun 2023 18:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687805188;
        bh=abBPlFVTqCTG5P8wNMRRvd/+M/+7kCkrbNZuVHjnFcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cCEns9B7ZB5cPEja77JI0HS3Kwp0+Dwo2CKp5PStk4wmYK41bnXlpm+HxCYz/omP8
         rYYjGbseIBIkLwkzX7SpH8bH91ow8Pu5dR6pJe3PoTZ95qXzqSXjv5LMTWVWViEfUu
         7ttjNIInojpLuUJCugOlV6eWcziNoJegWkBgw0Uc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.10 80/81] netfilter: nf_tables: hold mutex on netns pre_exit path
Date:   Mon, 26 Jun 2023 20:13:02 +0200
Message-ID: <20230626180747.655975102@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180744.453069285@linuxfoundation.org>
References: <20230626180744.453069285@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit 3923b1e4406680d57da7e873da77b1683035d83f upstream.

clean_net() runs in workqueue while walking over the lists, grab mutex.

Fixes: 767d1216bff8 ("netfilter: nftables: fix possible UAF over chains from packet path in netns")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_tables_api.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8983,7 +8983,9 @@ static int __net_init nf_tables_init_net
 
 static void __net_exit nf_tables_pre_exit_net(struct net *net)
 {
+	mutex_lock(&net->nft.commit_mutex);
 	__nft_release_hooks(net);
+	mutex_unlock(&net->nft.commit_mutex);
 }
 
 static void __net_exit nf_tables_exit_net(struct net *net)


