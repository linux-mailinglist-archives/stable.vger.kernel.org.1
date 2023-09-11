Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D5A79AE08
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239285AbjIKWjE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240061AbjIKOfT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:35:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F173F2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:35:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0441C433C8;
        Mon, 11 Sep 2023 14:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442914;
        bh=aE7fASXhDPDw/UVu0VYlqZvqkDFY7GvtKUsvOeqnwB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=to03pe4c32yQGfsvVdyBjoL7jGyf1MK77/giUvz2m0SJf640WjaFzB08rCeQX3IZX
         ZcLYt2iulDoY6VoM5Cdyw08kU23IDZYeA1NIPE9OI3SqBFWOXUe8wBqT84Hd+fqoAZ
         n3ptaS4qku0xZVBUv0ZFNEWW8Y1bW0bomwFzCM4A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florent Revest <revest@chromium.org>,
        syzbot+d769eed29cc42d75e2a3@syzkaller.appspotmail.com,
        syzbot+610ec0671f51e838436e@syzkaller.appspotmail.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 193/737] crypto: api - Use work queue in crypto_destroy_instance
Date:   Mon, 11 Sep 2023 15:40:52 +0200
Message-ID: <20230911134655.984733737@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit 9ae4577bc077a7e32c3c7d442c95bc76865c0f17 ]

The function crypto_drop_spawn expects to be called in process
context.  However, when an instance is unregistered while it still
has active users, the last user may cause the instance to be freed
in atomic context.

Fix this by delaying the freeing to a work queue.

Fixes: 6bfd48096ff8 ("[CRYPTO] api: Added spawns")
Reported-by: Florent Revest <revest@chromium.org>
Reported-by: syzbot+d769eed29cc42d75e2a3@syzkaller.appspotmail.com
Reported-by: syzbot+610ec0671f51e838436e@syzkaller.appspotmail.com
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Tested-by: Florent Revest <revest@chromium.org>
Acked-by: Florent Revest <revest@chromium.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/algapi.c         | 16 ++++++++++++++--
 include/crypto/algapi.h |  3 +++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index 5e7cd603d489c..4fe95c4480473 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -17,6 +17,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/workqueue.h>
 
 #include "internal.h"
 
@@ -74,15 +75,26 @@ static void crypto_free_instance(struct crypto_instance *inst)
 	inst->alg.cra_type->free(inst);
 }
 
-static void crypto_destroy_instance(struct crypto_alg *alg)
+static void crypto_destroy_instance_workfn(struct work_struct *w)
 {
-	struct crypto_instance *inst = (void *)alg;
+	struct crypto_instance *inst = container_of(w, struct crypto_instance,
+						    free_work);
 	struct crypto_template *tmpl = inst->tmpl;
 
 	crypto_free_instance(inst);
 	crypto_tmpl_put(tmpl);
 }
 
+static void crypto_destroy_instance(struct crypto_alg *alg)
+{
+	struct crypto_instance *inst = container_of(alg,
+						    struct crypto_instance,
+						    alg);
+
+	INIT_WORK(&inst->free_work, crypto_destroy_instance_workfn);
+	schedule_work(&inst->free_work);
+}
+
 /*
  * This function adds a spawn to the list secondary_spawns which
  * will be used at the end of crypto_remove_spawns to unregister
diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
index 016d5a302b84a..bd3a99b0106bf 100644
--- a/include/crypto/algapi.h
+++ b/include/crypto/algapi.h
@@ -12,6 +12,7 @@
 #include <linux/cache.h>
 #include <linux/crypto.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 
 /*
  * Maximum values for blocksize and alignmask, used to allocate
@@ -83,6 +84,8 @@ struct crypto_instance {
 		struct crypto_spawn *spawns;
 	};
 
+	struct work_struct free_work;
+
 	void *__ctx[] CRYPTO_MINALIGN_ATTR;
 };
 
-- 
2.40.1



