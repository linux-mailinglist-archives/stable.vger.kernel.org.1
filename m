Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD2E7A38E7
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239412AbjIQTmZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239924AbjIQTmD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:42:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F74D186
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:41:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CC6C433C9;
        Sun, 17 Sep 2023 19:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979704;
        bh=dwxJiaYDVylNz7sBJ9gjj7VqR/OzouVAU62rr+id4Ew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B/6Ppux7LmUlF4JzT1Z5byQ1aDM6ukVHQNVEYVIIjodQLht4StLv437q7S8u+x9oI
         5lNeWNUYjG3B5KKDo/yre0rdSaq2lNc0Zw6qBfAUJYMS5TBQ/EdDOzwX4p8V6b6Meu
         d1rN45AyzESpLHPaKnLCA938IoL+hErFP6BTmDHc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lucas Leong <wmliang@infosec.exchange>,
        Wander Lairson Costa <wander@redhat.com>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 365/406] netfilter: nfnetlink_osf: avoid OOB read
Date:   Sun, 17 Sep 2023 21:13:39 +0200
Message-ID: <20230917191110.907686782@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wander Lairson Costa <wander@redhat.com>

[ Upstream commit f4f8a7803119005e87b716874bec07c751efafec ]

The opt_num field is controlled by user mode and is not currently
validated inside the kernel. An attacker can take advantage of this to
trigger an OOB read and potentially leak information.

BUG: KASAN: slab-out-of-bounds in nf_osf_match_one+0xbed/0xd10 net/netfilter/nfnetlink_osf.c:88
Read of size 2 at addr ffff88804bc64272 by task poc/6431

CPU: 1 PID: 6431 Comm: poc Not tainted 6.0.0-rc4 #1
Call Trace:
 nf_osf_match_one+0xbed/0xd10 net/netfilter/nfnetlink_osf.c:88
 nf_osf_find+0x186/0x2f0 net/netfilter/nfnetlink_osf.c:281
 nft_osf_eval+0x37f/0x590 net/netfilter/nft_osf.c:47
 expr_call_ops_eval net/netfilter/nf_tables_core.c:214
 nft_do_chain+0x2b0/0x1490 net/netfilter/nf_tables_core.c:264
 nft_do_chain_ipv4+0x17c/0x1f0 net/netfilter/nft_chain_filter.c:23
 [..]

Also add validation to genre, subtype and version fields.

Fixes: 11eeef41d5f6 ("netfilter: passive OS fingerprint xtables match")
Reported-by: Lucas Leong <wmliang@infosec.exchange>
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nfnetlink_osf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
index 9dbaa5ce24e51..573a372e760f4 100644
--- a/net/netfilter/nfnetlink_osf.c
+++ b/net/netfilter/nfnetlink_osf.c
@@ -316,6 +316,14 @@ static int nfnl_osf_add_callback(struct net *net, struct sock *ctnl,
 
 	f = nla_data(osf_attrs[OSF_ATTR_FINGER]);
 
+	if (f->opt_num > ARRAY_SIZE(f->opt))
+		return -EINVAL;
+
+	if (!memchr(f->genre, 0, MAXGENRELEN) ||
+	    !memchr(f->subtype, 0, MAXGENRELEN) ||
+	    !memchr(f->version, 0, MAXGENRELEN))
+		return -EINVAL;
+
 	kf = kmalloc(sizeof(struct nf_osf_finger), GFP_KERNEL);
 	if (!kf)
 		return -ENOMEM;
-- 
2.40.1



