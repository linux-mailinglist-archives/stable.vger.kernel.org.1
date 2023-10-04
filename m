Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BA07B88B0
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjJDSS0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbjJDSSY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:18:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5CCA6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:18:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B0DC433C8;
        Wed,  4 Oct 2023 18:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443500;
        bh=EqrZdcmIsgmqMsBuJi4VvhzlepSBPEnWovavgUlFtWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x3I/d0NjeM3dJBWWvBsFpbvSJasDMcqMmOZUmQd07JaM7hEW3NMdOu3X5ZVNDk/Av
         FUzzGB4uYA13h1B/SIM0T4iCdj9Et00VGuwcalpjFQyaoqS3YLIznH3G0SYdAOZF7i
         LvJzPivxgXdFmoLqPryfzAaxAR8UMosSn2XMw8ew=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
        Hou Tao <houtao1@huawei.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 178/259] bpf: Ensure unit_size is matched with slab cache object size
Date:   Wed,  4 Oct 2023 19:55:51 +0200
Message-ID: <20231004175225.461580264@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit c930472552022bd09aab3cd946ba3f243070d5c7 ]

Add extra check in bpf_mem_alloc_init() to ensure the unit_size of
bpf_mem_cache is matched with the object_size of underlying slab cache.
If these two sizes are unmatched, print a warning once and return
-EINVAL in bpf_mem_alloc_init(), so the mismatch can be found early and
the potential issue can be prevented.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/r/20230908133923.2675053-4-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/memalloc.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index ace303a220ae8..f66a081195ac1 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -347,6 +347,24 @@ static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
 	alloc_bulk(c, c->unit_size <= 256 ? 4 : 1, cpu_to_node(cpu));
 }
 
+static int check_obj_size(struct bpf_mem_cache *c, unsigned int idx)
+{
+	struct llist_node *first;
+	unsigned int obj_size;
+
+	first = c->free_llist.first;
+	if (!first)
+		return 0;
+
+	obj_size = ksize(first);
+	if (obj_size != c->unit_size) {
+		WARN_ONCE(1, "bpf_mem_cache[%u]: unexpected object size %u, expect %u\n",
+			  idx, obj_size, c->unit_size);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 /* When size != 0 bpf_mem_cache for each cpu.
  * This is typical bpf hash map use case when all elements have equal size.
  *
@@ -357,10 +375,10 @@ static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
 int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 {
 	static u16 sizes[NUM_CACHES] = {96, 192, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096};
+	int cpu, i, err, unit_size, percpu_size = 0;
 	struct bpf_mem_caches *cc, __percpu *pcc;
 	struct bpf_mem_cache *c, __percpu *pc;
 	struct obj_cgroup *objcg = NULL;
-	int cpu, i, unit_size, percpu_size = 0;
 
 	if (size) {
 		pc = __alloc_percpu_gfp(sizeof(*pc), 8, GFP_KERNEL);
@@ -395,6 +413,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 	pcc = __alloc_percpu_gfp(sizeof(*cc), 8, GFP_KERNEL);
 	if (!pcc)
 		return -ENOMEM;
+	err = 0;
 #ifdef CONFIG_MEMCG_KMEM
 	objcg = get_obj_cgroup_from_current();
 #endif
@@ -405,10 +424,20 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c->unit_size = sizes[i];
 			c->objcg = objcg;
 			prefill_mem_cache(c, cpu);
+			err = check_obj_size(c, i);
+			if (err)
+				goto out;
 		}
 	}
+
+out:
 	ma->caches = pcc;
-	return 0;
+	/* refill_work is either zeroed or initialized, so it is safe to
+	 * call irq_work_sync().
+	 */
+	if (err)
+		bpf_mem_alloc_destroy(ma);
+	return err;
 }
 
 static void drain_mem_cache(struct bpf_mem_cache *c)
-- 
2.40.1



