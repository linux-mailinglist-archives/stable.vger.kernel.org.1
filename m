Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D056F72366B
	for <lists+stable@lfdr.de>; Tue,  6 Jun 2023 06:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjFFEmp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 6 Jun 2023 00:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjFFEmo (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Jun 2023 00:42:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C499619C
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 21:42:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 470D960FB2
        for <stable@vger.kernel.org>; Tue,  6 Jun 2023 04:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DABC433EF;
        Tue,  6 Jun 2023 04:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686026562;
        bh=1CnCxiGLwqYsaGLRUYtITSmAPKTUl51Wc4ayYPpICNc=;
        h=From:To:Cc:Subject:Date:From;
        b=qJTlHp0+0+7HXMOlvPPTQ9oH96kZIMubZW8jsAGLM4gcp78d3moYcR3U2Nqn/lIVY
         uPF5QqgH57MSkCrRM/6unv100+1ZmPb4XI5CDMXMsyn53PEX+XoNXizX2RrHcc8XaY
         Q3PwdqD43lwXNAuEESeEgYrts7N2EJEl5tclqMZGVy28QHu3IrEONxEaMleZTzl3sa
         CCNvp7XyxZF5Dv1CKplyp4lVzpVF4EFRgW+JVGqrof7H2UnSqo57bHovxJ/05xfdNb
         czXjMH0m1kQdz4SYEt/9iEnEbzRIRl8s04rlIpnXTgQMC3aOOPkkU7X/8gtGfChLWb
         uJkUXD5IVESkQ==
From:   Jakub Kicinski <kuba@kernel.org>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, kuba@kernel.org
Subject: [PATCH 6.1] tls: rx: strp: don't use GFP_KERNEL in softirq context
Date:   Mon,  5 Jun 2023 21:42:41 -0700
Message-Id: <20230606044241.877280-1-kuba@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
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
---
 net/tls/tls_sw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 992092aeebad..3a08cf1258b5 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2287,8 +2287,12 @@ static void tls_data_ready(struct sock *sk)
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
 	struct sk_psock *psock;
+	gfp_t alloc_save;
 
+	alloc_save = sk->sk_allocation;
+	sk->sk_allocation = GFP_ATOMIC;
 	tls_strp_data_ready(&ctx->strp);
+	sk->sk_allocation = alloc_save;
 
 	psock = sk_psock_get(sk);
 	if (psock) {
-- 
2.34.1

