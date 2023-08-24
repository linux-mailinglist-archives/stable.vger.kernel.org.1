Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4297872A6
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241883AbjHXOzo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241918AbjHXOz0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:55:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C8C1995
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:55:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D32E62248
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F32AC433C8;
        Thu, 24 Aug 2023 14:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692888923;
        bh=v0ib4EBcdhM5QR1Bg6CRdYMiLSOZJqU2t7Cu/lWLRNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w6dXDhMIl6VV6coJmCkpTK+wx9WUjyxw7d8NyUERZlCvHSm4EFZgHpGXbfEx/UvT+
         wk2uZRA32eiMAsdLNRXePOBiDQ+NvYb6KkrT/SfJPONsipdl5sRRxYxNGLOjqTDeVs
         avxjfGpgGmCZMLcVK0e+MWVUnGQtv84+uZh34ONM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, lonial con <kongln9170@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 091/139] netfilter: nf_tables: deactivate catchall elements in next generation
Date:   Thu, 24 Aug 2023 16:50:14 +0200
Message-ID: <20230824145027.560899851@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
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
index 1e84314fe334a..1e2d1e4bdb74d 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6719,6 +6719,7 @@ static int nft_set_catchall_flush(const struct nft_ctx *ctx,
 		ret = __nft_set_catchall_flush(ctx, set, &elem);
 		if (ret < 0)
 			break;
+		nft_set_elem_change_active(ctx->net, set, ext);
 	}
 
 	return ret;
-- 
2.40.1



