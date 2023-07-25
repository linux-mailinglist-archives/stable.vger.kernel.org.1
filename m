Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BA87614F6
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbjGYLYL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbjGYLYL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:24:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8BEA6
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:24:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BFE86167D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15934C433C7;
        Tue, 25 Jul 2023 11:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284249;
        bh=SMiw5nhmcl+ziqRVZigpBPT5OLgtqnIDHvVcYFSuVOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qctgnC2/rpx6xKGVUk0Dn6TyKJ83uz7Zltjdsj2iTMo68MPVjH6lRL6PyagEC5eB2
         PdZ0RtWGMldryMhkd+flPxIlC8dKa/yDkbvHlcKF5fXAwFeqy7H+isKVxMW1tFr7Ac
         i4DMHiYYPpPQYGe6PHgMml/Q+aWFP0LlcCBJGuT8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zheng Wang <zyytlz.wz@163.com>,
        Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.10 289/509] bcache: Fix __bch_btree_node_alloc to make the failure behavior consistent
Date:   Tue, 25 Jul 2023 12:43:48 +0200
Message-ID: <20230725104606.970329375@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 


