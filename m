Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195987A7E81
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbjITMSX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbjITMSV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:18:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD6E92
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:18:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959FCC433C7;
        Wed, 20 Sep 2023 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212295;
        bh=UEp8yshibGkhwR0pMp7cbOHvuuDGqos8213cwuErxZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rq0i9/pfnLOTy/oFzsJMPQMb4tWgt8F4XziY8shPz474bFFM4nLRwQjP9zHcUulo6
         G0cuR89+eAmvsuW/moxQZmy08QWhVNnFmmUEb/Mq/VHBMYZENaOqfwRT+mj3Q35yBy
         4Xv7KekcG4Cvkh5svp5jMdzkFOWfeJFvUAOPJrsw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lucas Leong <wmliang@infosec.exchange>,
        Wander Lairson Costa <wander@redhat.com>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 223/273] netfilter: nfnetlink_osf: avoid OOB read
Date:   Wed, 20 Sep 2023 13:31:03 +0200
Message-ID: <20230920112853.304823477@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 21e4554c76955..f3676238e64f2 100644
--- a/net/netfilter/nfnetlink_osf.c
+++ b/net/netfilter/nfnetlink_osf.c
@@ -318,6 +318,14 @@ static int nfnl_osf_add_callback(struct net *net, struct sock *ctnl,
 
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



