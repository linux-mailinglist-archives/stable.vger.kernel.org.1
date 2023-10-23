Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CFD7D3125
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjJWLGH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbjJWLGH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:06:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E378D10C0
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:06:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346B4C433C7;
        Mon, 23 Oct 2023 11:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059165;
        bh=ur6fzPJUXA3cwOvnwVqf0N3RpjI4nxgevupeYYffsjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CIhrNE5yh4eB4Ts9ZxnGCB+kSzfc+xEZYpfeNq8eJz06wYtHBGIEvErR1Sy9fqRO+
         vPUrL8WHf3hfwoRBrHBKzZE75xyBtCrHsJ9AC855Eg1+U2ngZMbkkldwcWvira4PEx
         Nms/Xijns7KqW6XfPbHpH1K0YdUoFr/uDe2YH34k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xingyuan Mo <hdthky0@gmail.com>,
        Florian Westphal <fw@strlen.de>
Subject: [PATCH 6.5 085/241] nf_tables: fix NULL pointer dereference in nft_inner_init()
Date:   Mon, 23 Oct 2023 12:54:31 +0200
Message-ID: <20231023104835.960359290@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xingyuan Mo <hdthky0@gmail.com>

commit 52177bbf19e6e9398375a148d2e13ed492b40b80 upstream.

We should check whether the NFTA_INNER_NUM netlink attribute is present
before accessing it, otherwise a null pointer deference error will occur.

Call Trace:
 dump_stack_lvl+0x4f/0x90
 print_report+0x3f0/0x620
 kasan_report+0xcd/0x110
 __asan_load4+0x84/0xa0
 nft_inner_init+0x128/0x2e0
 nf_tables_newrule+0x813/0x1230
 nfnetlink_rcv_batch+0xec3/0x1170
 nfnetlink_rcv+0x1e4/0x220
 netlink_unicast+0x34e/0x4b0
 netlink_sendmsg+0x45c/0x7e0
 __sys_sendto+0x355/0x370
 __x64_sys_sendto+0x84/0xa0
 do_syscall_64+0x3f/0x90
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Fixes: 3a07327d10a0 ("netfilter: nft_inner: support for inner tunnel header matching")
Signed-off-by: Xingyuan Mo <hdthky0@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nft_inner.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nft_inner.c b/net/netfilter/nft_inner.c
index 28e2873ba24e..928312d01eb1 100644
--- a/net/netfilter/nft_inner.c
+++ b/net/netfilter/nft_inner.c
@@ -298,6 +298,7 @@ static int nft_inner_init(const struct nft_ctx *ctx,
 	int err;
 
 	if (!tb[NFTA_INNER_FLAGS] ||
+	    !tb[NFTA_INNER_NUM] ||
 	    !tb[NFTA_INNER_HDRSIZE] ||
 	    !tb[NFTA_INNER_TYPE] ||
 	    !tb[NFTA_INNER_EXPR])
-- 
2.42.0



