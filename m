Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC52A775BCD
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbjHILVO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbjHILVN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:21:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0735FFA
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:21:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A87E631EA
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD11C433C8;
        Wed,  9 Aug 2023 11:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580072;
        bh=Ca2xW03CkZsnqK+E76VYFr7uIFkOOdn/ahPLoWva4HY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yT7MJttbKoSQPsjB6OoUeKyJQjCCLTOtYz1Hm2syjgTEZFcNn90kJZoTyh5k3e9Q3
         DRQW+/cf/IixUEtME/xTJNvNvA128QHNXRBz2X/pN+kJHicZ/sAjxSaaI6kAmAhG0e
         I5NVL4Lzm3P4XqV75ZlGv8oGpj0Q5yOI/p1n+dWA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shenghui Wang <shhuiw@foxmail.com>,
        Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 218/323] bcache: use MAX_CACHES_PER_SET instead of magic number 8 in __bch_bucket_alloc_set
Date:   Wed,  9 Aug 2023 12:40:56 +0200
Message-ID: <20230809103708.083779483@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Shenghui Wang <shhuiw@foxmail.com>

[ Upstream commit 8792099f9ad487cf381f4e8199ff2158ba0f6eb5 ]

Current cache_set has MAX_CACHES_PER_SET caches most, and the macro
is used for
"
	struct cache *cache_by_alloc[MAX_CACHES_PER_SET];
"
in the define of struct cache_set.

Use MAX_CACHES_PER_SET instead of magic number 8 in
__bch_bucket_alloc_set.

Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 80fca8a10b60 ("bcache: Fix __bch_btree_node_alloc to make the failure behavior consistent")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index 46794cac167e7..a1df0d95151c6 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -497,7 +497,7 @@ int __bch_bucket_alloc_set(struct cache_set *c, unsigned int reserve,
 		return -1;
 
 	lockdep_assert_held(&c->bucket_lock);
-	BUG_ON(!n || n > c->caches_loaded || n > 8);
+	BUG_ON(!n || n > c->caches_loaded || n > MAX_CACHES_PER_SET);
 
 	bkey_init(k);
 
-- 
2.39.2



