Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D38755622
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjGPUry (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjGPUrx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:47:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C45E41
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:47:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EABC60E65
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C779C433C9;
        Sun, 16 Jul 2023 20:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540470;
        bh=bZ4mPcvZXM0pZba6TbjXQQu+FGoZKOLzIyV/qR0Xkwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YnczRrMclu046+5QtgJv1cPH+Dj0HfUTn07n12X97QvUeD9lJf4DI+jQnYK9/7tEI
         VYC6G7YHFdKaxVDlEfRLxLnvrCXA0nA9bUnobQSthneCm1GBLbtvKGwrVN1yhbdO2R
         1rcK5V10BofYlvAV4/qB7HFhtggIRIk3/ZSg/sVE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qi Zheng <zhengqi.arch@bytedance.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 347/591] NFSv4.2: fix wrong shrinker_id
Date:   Sun, 16 Jul 2023 21:48:06 +0200
Message-ID: <20230716194932.888087036@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Qi Zheng <zhengqi.arch@bytedance.com>

[ Upstream commit 7f7ab336898f281e58540ef781a8fb375acc32a9 ]

Currently, the list_lru::shrinker_id corresponding to the nfs4_xattr
shrinkers is wrong:

>>> prog["nfs4_xattr_cache_lru"].shrinker_id
(int)0
>>> prog["nfs4_xattr_entry_lru"].shrinker_id
(int)0
>>> prog["nfs4_xattr_large_entry_lru"].shrinker_id
(int)0
>>> prog["nfs4_xattr_cache_shrinker"].id
(int)18
>>> prog["nfs4_xattr_entry_shrinker"].id
(int)19
>>> prog["nfs4_xattr_large_entry_shrinker"].id
(int)20

This is not what we expect, which will cause these shrinkers
not to be found in shrink_slab_memcg().

We should assign shrinker::id before calling list_lru_init_memcg(),
so that the corresponding list_lru::shrinker_id will be assigned
the correct value like below:

>>> prog["nfs4_xattr_cache_lru"].shrinker_id
(int)16
>>> prog["nfs4_xattr_entry_lru"].shrinker_id
(int)17
>>> prog["nfs4_xattr_large_entry_lru"].shrinker_id
(int)18
>>> prog["nfs4_xattr_cache_shrinker"].id
(int)16
>>> prog["nfs4_xattr_entry_shrinker"].id
(int)17
>>> prog["nfs4_xattr_large_entry_shrinker"].id
(int)18

So just do it.

Fixes: 95ad37f90c33 ("NFSv4.2: add client side xattr caching.")
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs42xattr.c | 79 +++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 35 deletions(-)

diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
index 76ae118342066..911f634ba3da7 100644
--- a/fs/nfs/nfs42xattr.c
+++ b/fs/nfs/nfs42xattr.c
@@ -991,6 +991,29 @@ static void nfs4_xattr_cache_init_once(void *p)
 	INIT_LIST_HEAD(&cache->dispose);
 }
 
+static int nfs4_xattr_shrinker_init(struct shrinker *shrinker,
+				    struct list_lru *lru, const char *name)
+{
+	int ret = 0;
+
+	ret = register_shrinker(shrinker, name);
+	if (ret)
+		return ret;
+
+	ret = list_lru_init_memcg(lru, shrinker);
+	if (ret)
+		unregister_shrinker(shrinker);
+
+	return ret;
+}
+
+static void nfs4_xattr_shrinker_destroy(struct shrinker *shrinker,
+					struct list_lru *lru)
+{
+	unregister_shrinker(shrinker);
+	list_lru_destroy(lru);
+}
+
 int __init nfs4_xattr_cache_init(void)
 {
 	int ret = 0;
@@ -1002,44 +1025,30 @@ int __init nfs4_xattr_cache_init(void)
 	if (nfs4_xattr_cache_cachep == NULL)
 		return -ENOMEM;
 
-	ret = list_lru_init_memcg(&nfs4_xattr_large_entry_lru,
-	    &nfs4_xattr_large_entry_shrinker);
-	if (ret)
-		goto out4;
-
-	ret = list_lru_init_memcg(&nfs4_xattr_entry_lru,
-	    &nfs4_xattr_entry_shrinker);
-	if (ret)
-		goto out3;
-
-	ret = list_lru_init_memcg(&nfs4_xattr_cache_lru,
-	    &nfs4_xattr_cache_shrinker);
-	if (ret)
-		goto out2;
-
-	ret = register_shrinker(&nfs4_xattr_cache_shrinker, "nfs-xattr_cache");
+	ret = nfs4_xattr_shrinker_init(&nfs4_xattr_cache_shrinker,
+				       &nfs4_xattr_cache_lru,
+				       "nfs-xattr_cache");
 	if (ret)
 		goto out1;
 
-	ret = register_shrinker(&nfs4_xattr_entry_shrinker, "nfs-xattr_entry");
+	ret = nfs4_xattr_shrinker_init(&nfs4_xattr_entry_shrinker,
+				       &nfs4_xattr_entry_lru,
+				       "nfs-xattr_entry");
 	if (ret)
-		goto out;
+		goto out2;
 
-	ret = register_shrinker(&nfs4_xattr_large_entry_shrinker,
-				"nfs-xattr_large_entry");
+	ret = nfs4_xattr_shrinker_init(&nfs4_xattr_large_entry_shrinker,
+				       &nfs4_xattr_large_entry_lru,
+				       "nfs-xattr_large_entry");
 	if (!ret)
 		return 0;
 
-	unregister_shrinker(&nfs4_xattr_entry_shrinker);
-out:
-	unregister_shrinker(&nfs4_xattr_cache_shrinker);
-out1:
-	list_lru_destroy(&nfs4_xattr_cache_lru);
+	nfs4_xattr_shrinker_destroy(&nfs4_xattr_entry_shrinker,
+				    &nfs4_xattr_entry_lru);
 out2:
-	list_lru_destroy(&nfs4_xattr_entry_lru);
-out3:
-	list_lru_destroy(&nfs4_xattr_large_entry_lru);
-out4:
+	nfs4_xattr_shrinker_destroy(&nfs4_xattr_cache_shrinker,
+				    &nfs4_xattr_cache_lru);
+out1:
 	kmem_cache_destroy(nfs4_xattr_cache_cachep);
 
 	return ret;
@@ -1047,11 +1056,11 @@ int __init nfs4_xattr_cache_init(void)
 
 void nfs4_xattr_cache_exit(void)
 {
-	unregister_shrinker(&nfs4_xattr_large_entry_shrinker);
-	unregister_shrinker(&nfs4_xattr_entry_shrinker);
-	unregister_shrinker(&nfs4_xattr_cache_shrinker);
-	list_lru_destroy(&nfs4_xattr_large_entry_lru);
-	list_lru_destroy(&nfs4_xattr_entry_lru);
-	list_lru_destroy(&nfs4_xattr_cache_lru);
+	nfs4_xattr_shrinker_destroy(&nfs4_xattr_large_entry_shrinker,
+				    &nfs4_xattr_large_entry_lru);
+	nfs4_xattr_shrinker_destroy(&nfs4_xattr_entry_shrinker,
+				    &nfs4_xattr_entry_lru);
+	nfs4_xattr_shrinker_destroy(&nfs4_xattr_cache_shrinker,
+				    &nfs4_xattr_cache_lru);
 	kmem_cache_destroy(nfs4_xattr_cache_cachep);
 }
-- 
2.39.2



