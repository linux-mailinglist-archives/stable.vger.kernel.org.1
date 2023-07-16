Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD45755428
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjGPU1R (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjGPU1Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:27:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218619F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:27:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B194160EBC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:27:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC1CC433C7;
        Sun, 16 Jul 2023 20:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539235;
        bh=SMiw5nhmcl+ziqRVZigpBPT5OLgtqnIDHvVcYFSuVOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YG3xqV9Kygk5aj06I7MYpj1/PH9SGfJtEwZUooIltZLE/qXokBCtnd3OWkX4GumST
         29hMUJrLlzy3rYFAas1WMEYSZA2DTZpM6rxpmNPutrnMr78C5YC37DDauOCInwuMF4
         GBafQxmTzw9OnCm6EeS16fbjbdrMFzKuxSRqlOO8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zheng Wang <zyytlz.wz@163.com>,
        Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.4 736/800] bcache: Fix __bch_btree_node_alloc to make the failure behavior consistent
Date:   Sun, 16 Jul 2023 21:49:49 +0200
Message-ID: <20230716195006.211943353@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Zheng Wang <zyytlz.wz@163.com>

commit 80fca8a10b604afad6c14213fdfd816c4eda3ee4 upstream.

In some specific situations, the return value of __bch_btree_node_alloc
may be NULL. This may lead to a potential NULL pointer dereference in
caller function like a calling chain :
btree_split->bch_btree_node_alloc->__bch_btree_node_alloc.

Fix it by initializing the return value in __bch_btree_node_alloc.

Fixes: cafe56359144 ("bcache: A block layer cache")
Cc: stable@vger.kernel.org
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Signed-off-by: Coly Li <colyli@suse.de>
Link: https://lore.kernel.org/r/20230615121223.22502-6-colyli@suse.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/bcache/btree.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1090,10 +1090,12 @@ struct btree *__bch_btree_node_alloc(str
 				     struct btree *parent)
 {
 	BKEY_PADDED(key) k;
-	struct btree *b = ERR_PTR(-EAGAIN);
+	struct btree *b;
 
 	mutex_lock(&c->bucket_lock);
 retry:
+	/* return ERR_PTR(-EAGAIN) when it fails */
+	b = ERR_PTR(-EAGAIN);
 	if (__bch_bucket_alloc_set(c, RESERVE_BTREE, &k.key, wait))
 		goto err;
 


