Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DC273E915
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjFZSch (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjFZScV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:32:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406562723
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:32:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2182660F39
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5A6C433C8;
        Mon, 26 Jun 2023 18:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804324;
        bh=Girculq8WNjdGq0XvLOlu4PytQvEU9ZgR4wgY9fPMog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KoZsrUhpRJgcsaLH/P4/WyX5vwAaduYmZjA9Wewz8sT1yoaJ37jMuPM8P2KyQ/MMe
         jWxyTZhOI+boP/c1hmNWLK9/bMMk7O/BZ5nwSAEKRY/8c2JVpvl2XJ4wgPay5FVlh8
         i/5FR/4+qoCAxg/2gXdKownFHGZb2JR+1EVOIT1s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 118/170] netfilter: nfnetlink_osf: fix module autoload
Date:   Mon, 26 Jun 2023 20:11:27 +0200
Message-ID: <20230626180805.856215838@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
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

[ Upstream commit 62f9a68a36d4441a6c412b81faed102594bc6670 ]

Move the alias from xt_osf to nfnetlink_osf.

Fixes: f9324952088f ("netfilter: nfnetlink_osf: extract nfnetlink_subsystem code from xt_osf.c")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nfnetlink_osf.c | 1 +
 net/netfilter/xt_osf.c        | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
index ee6840bd59337..8f1bfa6ccc2d9 100644
--- a/net/netfilter/nfnetlink_osf.c
+++ b/net/netfilter/nfnetlink_osf.c
@@ -439,3 +439,4 @@ module_init(nfnl_osf_init);
 module_exit(nfnl_osf_fini);
 
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_NFNL_SUBSYS(NFNL_SUBSYS_OSF);
diff --git a/net/netfilter/xt_osf.c b/net/netfilter/xt_osf.c
index e1990baf3a3b7..dc9485854002a 100644
--- a/net/netfilter/xt_osf.c
+++ b/net/netfilter/xt_osf.c
@@ -71,4 +71,3 @@ MODULE_AUTHOR("Evgeniy Polyakov <zbr@ioremap.net>");
 MODULE_DESCRIPTION("Passive OS fingerprint matching.");
 MODULE_ALIAS("ipt_osf");
 MODULE_ALIAS("ip6t_osf");
-MODULE_ALIAS_NFNL_SUBSYS(NFNL_SUBSYS_OSF);
-- 
2.39.2



