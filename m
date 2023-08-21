Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4B1783211
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjHUTzy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjHUTzx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:55:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06258FB
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:55:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9153B6350E
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C177C433C8;
        Mon, 21 Aug 2023 19:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647740;
        bh=tnBFERiDMdehr6/OoQYVHtfzTxsqVS14AlMfRlVCL5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c9hIgFeqkFkJjn7v8Z303ND8NPCP6Lir3VnYHaiQLEbJhhF3nCd6NZdWBNQwgwCc1
         U6vukRLV0TjeVjtX1D/7WgkB48g13BaS6pxEzXge/VkBJxsmFti8LezLtjfGUtTzKD
         n/0JalRRfIQRL7eZwkYk+AiHPPVEZM+jbMXcDShc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, lonial con <kongln9170@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 121/194] netfilter: nf_tables: deactivate catchall elements in next generation
Date:   Mon, 21 Aug 2023 21:41:40 +0200
Message-ID: <20230821194128.028665833@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 90e5b3462efa37b8bba82d7c4e63683856e188af ]

When flushing, individual set elements are disabled in the next
generation via the ->flush callback.

Catchall elements are not disabled.  This is incorrect and may lead to
double-deactivations of catchall elements which then results in memory
leaks:

WARNING: CPU: 1 PID: 3300 at include/net/netfilter/nf_tables.h:1172 nft_map_deactivate+0x549/0x730
CPU: 1 PID: 3300 Comm: nft Not tainted 6.5.0-rc5+ #60
RIP: 0010:nft_map_deactivate+0x549/0x730
 [..]
 ? nft_map_deactivate+0x549/0x730
 nf_tables_delset+0xb66/0xeb0

(the warn is due to nft_use_dec() detecting underflow).

Fixes: aaa31047a6d2 ("netfilter: nftables: add catch-all set element support")
Reported-by: lonial con <kongln9170@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index f6e6273838859..4c2df7af73f76 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6874,6 +6874,7 @@ static int nft_set_catchall_flush(const struct nft_ctx *ctx,
 		ret = __nft_set_catchall_flush(ctx, set, &elem);
 		if (ret < 0)
 			break;
+		nft_set_elem_change_active(ctx->net, set, ext);
 	}
 
 	return ret;
-- 
2.40.1



