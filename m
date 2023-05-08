Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C080C6FAB4F
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjEHLLv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjEHLLp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:11:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45544360C4
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:11:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1E6362B7A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75CDC433D2;
        Mon,  8 May 2023 11:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544300;
        bh=J0AVg/uf7HvKLSP5qA0FqS+lOcbwpYbKePc9gVTodQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iAERC81CoNmkj8zubd2mnSk7XbXWwfrJcD9edEoGQhgeyEODaQK5B9TW5WyCFju3Q
         vyxJ95/UyBRjCtCwAX00qqWdDbJBKtmJbNOHd/UNbeWnFp8T0yuDKow73e7pv5Hhoq
         9CofedVvRqtEuEvprX5o8kK4QDH0htP2aAwWjQdc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hou Tao <houtao1@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 348/694] bpf: Only allocate one bpf_mem_cache for bpf_cpumask_ma
Date:   Mon,  8 May 2023 11:43:03 +0200
Message-Id: <20230508094443.868579289@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit 5d5de3a431d87ac51d43da8d796891d014975ab7 ]

The size of bpf_cpumask is fixed, so there is no need to allocate many
bpf_mem_caches for bpf_cpumask_ma, just one bpf_mem_cache is enough.
Also add comments for bpf_mem_alloc_init() in bpf_mem_alloc.h to prevent
future miuse.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/r/20230216024821.2202916-1-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: 77473d1a962f ("bpf: Free struct bpf_cpumask in call_rcu handler")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf_mem_alloc.h | 7 +++++++
 kernel/bpf/cpumask.c          | 6 +++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
index 3e164b8efaa92..a7104af61ab4d 100644
--- a/include/linux/bpf_mem_alloc.h
+++ b/include/linux/bpf_mem_alloc.h
@@ -14,6 +14,13 @@ struct bpf_mem_alloc {
 	struct work_struct work;
 };
 
+/* 'size != 0' is for bpf_mem_alloc which manages fixed-size objects.
+ * Alloc and free are done with bpf_mem_cache_{alloc,free}().
+ *
+ * 'size = 0' is for bpf_mem_alloc which manages many fixed-size objects.
+ * Alloc and free are done with bpf_mem_{alloc,free}() and the size of
+ * the returned object is given by the size argument of bpf_mem_alloc().
+ */
 int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu);
 void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma);
 
diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 52b981512a351..2b3fbbfebdc5f 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -55,7 +55,7 @@ __bpf_kfunc struct bpf_cpumask *bpf_cpumask_create(void)
 	/* cpumask must be the first element so struct bpf_cpumask be cast to struct cpumask. */
 	BUILD_BUG_ON(offsetof(struct bpf_cpumask, cpumask) != 0);
 
-	cpumask = bpf_mem_alloc(&bpf_cpumask_ma, sizeof(*cpumask));
+	cpumask = bpf_mem_cache_alloc(&bpf_cpumask_ma);
 	if (!cpumask)
 		return NULL;
 
@@ -123,7 +123,7 @@ __bpf_kfunc void bpf_cpumask_release(struct bpf_cpumask *cpumask)
 
 	if (refcount_dec_and_test(&cpumask->usage)) {
 		migrate_disable();
-		bpf_mem_free(&bpf_cpumask_ma, cpumask);
+		bpf_mem_cache_free(&bpf_cpumask_ma, cpumask);
 		migrate_enable();
 	}
 }
@@ -468,7 +468,7 @@ static int __init cpumask_kfunc_init(void)
 		},
 	};
 
-	ret = bpf_mem_alloc_init(&bpf_cpumask_ma, 0, false);
+	ret = bpf_mem_alloc_init(&bpf_cpumask_ma, sizeof(struct bpf_cpumask), false);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &cpumask_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &cpumask_kfunc_set);
 	return  ret ?: register_btf_id_dtor_kfuncs(cpumask_dtors,
-- 
2.39.2



