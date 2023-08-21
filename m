Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CC87832DA
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjHUUHt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjHUUHs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:07:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC96E3
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:07:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5C3C649C1
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FADC433C8;
        Mon, 21 Aug 2023 20:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648466;
        bh=rFTRGIk17xSWesq/5srjTLwD2iBgI844JJdrCME5urw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tnFR+siI18Newn2dvNOXgIgqgLsgznUUn+c/lLovf/UrVMl/8lwGvLMQv7Ei7Bt96
         Hm4RGHItndSpouVJNP0Kv++ZYkBnUXyEMJ9utKgy3gv/UrJDjLE46+QF/tSDwHI3Nr
         IdI+jNAgvYTzcFeUnArDsvEQHecfkSntp4LeF5Js=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, lonial con <kongln9170@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 158/234] netfilter: nf_tables: deactivate catchall elements in next generation
Date:   Mon, 21 Aug 2023 21:42:01 +0200
Message-ID: <20230821194135.801225765@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
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
index c6de10f458fa4..803b24eb9da99 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -7088,6 +7088,7 @@ static int nft_set_catchall_flush(const struct nft_ctx *ctx,
 		ret = __nft_set_catchall_flush(ctx, set, &elem);
 		if (ret < 0)
 			break;
+		nft_set_elem_change_active(ctx->net, set, ext);
 	}
 
 	return ret;
-- 
2.40.1



