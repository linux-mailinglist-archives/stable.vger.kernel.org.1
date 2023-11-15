Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326087ED401
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343797AbjKOU4P (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343798AbjKOU4P (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:56:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2DCB7
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:56:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2278DC4E777;
        Wed, 15 Nov 2023 20:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081771;
        bh=iEEptdKaAxxT2mX3i+qdA4Xo34lLD6JvfrX5Rm4XuYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eB277yn3804eJwXEDkOu6GeJbMkniwG808/Xvc2l6FCNwsp7x53DGdnNNauZ50DKd
         L8BPGxJTJjFTF3KF6X5h99JJn8+XYEDnZQQpJbIGBogcGo/LkHy6JxQOS+0msuFHyq
         xqc2oHP0akUbmrYQKPzszF4gGegJIde7v32pCRog=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, WangJinchao <wangjinchao@xfusion.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 115/191] padata: Fix refcnt handling in padata_free_shell()
Date:   Wed, 15 Nov 2023 15:46:30 -0500
Message-ID: <20231115204651.455695888@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: WangJinchao <wangjinchao@xfusion.com>

[ Upstream commit 7ddc21e317b360c3444de3023bcc83b85fabae2f ]

In a high-load arm64 environment, the pcrypt_aead01 test in LTP can lead
to system UAF (Use-After-Free) issues. Due to the lengthy analysis of
the pcrypt_aead01 function call, I'll describe the problem scenario
using a simplified model:

Suppose there's a user of padata named `user_function` that adheres to
the padata requirement of calling `padata_free_shell` after `serial()`
has been invoked, as demonstrated in the following code:

```c
struct request {
    struct padata_priv padata;
    struct completion *done;
};

void parallel(struct padata_priv *padata) {
    do_something();
}

void serial(struct padata_priv *padata) {
    struct request *request = container_of(padata,
    				struct request,
				padata);
    complete(request->done);
}

void user_function() {
    DECLARE_COMPLETION(done)
    padata->parallel = parallel;
    padata->serial = serial;
    padata_do_parallel();
    wait_for_completion(&done);
    padata_free_shell();
}
```

In the corresponding padata.c file, there's the following code:

```c
static void padata_serial_worker(struct work_struct *serial_work) {
    ...
    cnt = 0;

    while (!list_empty(&local_list)) {
        ...
        padata->serial(padata);
        cnt++;
    }

    local_bh_enable();

    if (refcount_sub_and_test(cnt, &pd->refcnt))
        padata_free_pd(pd);
}
```

Because of the high system load and the accumulation of unexecuted
softirq at this moment, `local_bh_enable()` in padata takes longer
to execute than usual. Subsequently, when accessing `pd->refcnt`,
`pd` has already been released by `padata_free_shell()`, resulting
in a UAF issue with `pd->refcnt`.

The fix is straightforward: add `refcount_dec_and_test` before calling
`padata_free_pd` in `padata_free_shell`.

Fixes: 07928d9bfc81 ("padata: Remove broken queue flushing")

Signed-off-by: WangJinchao <wangjinchao@xfusion.com>
Acked-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Acked-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/padata.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index dc81c756da3d9..7d500219f96bd 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -1107,12 +1107,16 @@ EXPORT_SYMBOL(padata_alloc_shell);
  */
 void padata_free_shell(struct padata_shell *ps)
 {
+	struct parallel_data *pd;
+
 	if (!ps)
 		return;
 
 	mutex_lock(&ps->pinst->lock);
 	list_del(&ps->list);
-	padata_free_pd(rcu_dereference_protected(ps->pd, 1));
+	pd = rcu_dereference_protected(ps->pd, 1);
+	if (refcount_dec_and_test(&pd->refcnt))
+		padata_free_pd(pd);
 	mutex_unlock(&ps->pinst->lock);
 
 	kfree(ps);
-- 
2.42.0



