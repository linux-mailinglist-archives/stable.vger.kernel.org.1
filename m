Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0CE719DC7
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjFAN0Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbjFAN0I (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:26:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB46E42
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:25:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDB52644A6
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07624C433EF;
        Thu,  1 Jun 2023 13:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625953;
        bh=fSJy66onBRiH8t3WkCjjcRMMUitvkv0d5aGzpau7ARs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uxUvCsm18X3GzY/xtOhEqqZ0EvPq/3ZYx9jXsGmJVGkzRFQIfmw4yxZ5/HGr3QIoC
         Wx4lX/ztD08myDZr2c4OSPM/V3B3aQUzRmV4d82Ed0aJTIXxcasLZm+enTdYXeQQ6E
         9spYJrgnEo4RF0TsS/UNqCTOV4tgb9pExEvvec+g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shai Amiram <samiram@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 17/45] tls: rx: strp: dont use GFP_KERNEL in softirq context
Date:   Thu,  1 Jun 2023 14:21:13 +0100
Message-Id: <20230601131939.495437952@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
References: <20230601131938.702671708@linuxfoundation.org>
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

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 74836ec828fe17b63f2006fdbf53311d691396bf ]

When receive buffer is small, or the TCP rx queue looks too
complicated to bother using it directly - we allocate a new
skb and copy data into it.

We already use sk->sk_allocation... but nothing actually
sets it to GFP_ATOMIC on the ->sk_data_ready() path.

Users of HW offload are far more likely to experience problems
due to scheduling while atomic. "Copy mode" is very rarely
triggered with SW crypto.

Fixes: 84c61fe1a75b ("tls: rx: do not use the standard strparser")
Tested-by: Shai Amiram <samiram@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tls/tls_sw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 635b8bf6b937c..6e6a7c37d685c 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2304,10 +2304,14 @@ static void tls_data_ready(struct sock *sk)
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
 	struct sk_psock *psock;
+	gfp_t alloc_save;
 
 	trace_sk_data_ready(sk);
 
+	alloc_save = sk->sk_allocation;
+	sk->sk_allocation = GFP_ATOMIC;
 	tls_strp_data_ready(&ctx->strp);
+	sk->sk_allocation = alloc_save;
 
 	psock = sk_psock_get(sk);
 	if (psock) {
-- 
2.39.2



