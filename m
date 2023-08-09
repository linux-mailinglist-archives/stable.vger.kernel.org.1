Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA0777579A
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjHIKr7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjHIKr7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:47:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D7A1BCF
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:47:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6A596283F
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EFFC433C7;
        Wed,  9 Aug 2023 10:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578077;
        bh=lOyYFobJKLrU5tiBeBXzcvtpMsoLwWKVIGMv2NwkLbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U+ojGLifsQFj7eeK3KcwZX3nu2cFPf9N1rodQ9HkrvfRQ8tA8R/jG5XgnFvZbXonz
         ZNZ+2R5l6cdVRSvcfFFcuSig6CEBncHDKs+9zTsxZ+zo2bFmQUufgL01yqcYFJ48d0
         KS+4x7oCJ1Vj8UNfgzFU8dhHzBRlKvmLmlhh4a08=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 068/165] bpf: Centralize permissions checks for all BPF map types
Date:   Wed,  9 Aug 2023 12:39:59 +0200
Message-ID: <20230809103645.037033895@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
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

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 6c3eba1c5e283fd2bb1c076dbfcb47f569c3bfde ]

This allows to do more centralized decisions later on, and generally
makes it very explicit which maps are privileged and which are not
(e.g., LRU_HASH and LRU_PERCPU_HASH, which are privileged HASH variants,
as opposed to unprivileged HASH and HASH_PERCPU; now this is explicit
and easy to verify).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Stanislav Fomichev <sdf@google.com>
Link: https://lore.kernel.org/bpf/20230613223533.3689589-4-andrii@kernel.org
Stable-dep-of: 640a604585aa ("bpf, cpumap: Make sure kthread is running before map update returns")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/bloom_filter.c                     |  3 --
 kernel/bpf/bpf_local_storage.c                |  3 --
 kernel/bpf/bpf_struct_ops.c                   |  3 --
 kernel/bpf/cpumap.c                           |  4 --
 kernel/bpf/devmap.c                           |  3 --
 kernel/bpf/hashtab.c                          |  6 ---
 kernel/bpf/lpm_trie.c                         |  3 --
 kernel/bpf/queue_stack_maps.c                 |  4 --
 kernel/bpf/reuseport_array.c                  |  3 --
 kernel/bpf/stackmap.c                         |  3 --
 kernel/bpf/syscall.c                          | 47 +++++++++++++++++++
 net/core/sock_map.c                           |  4 --
 net/xdp/xskmap.c                              |  4 --
 .../bpf/prog_tests/unpriv_bpf_disabled.c      |  6 ++-
 14 files changed, 52 insertions(+), 44 deletions(-)

diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
index 540331b610a97..addf3dd57b59b 100644
--- a/kernel/bpf/bloom_filter.c
+++ b/kernel/bpf/bloom_filter.c
@@ -86,9 +86,6 @@ static struct bpf_map *bloom_map_alloc(union bpf_attr *attr)
 	int numa_node = bpf_map_attr_numa_node(attr);
 	struct bpf_bloom_filter *bloom;
 
-	if (!bpf_capable())
-		return ERR_PTR(-EPERM);
-
 	if (attr->key_size != 0 || attr->value_size == 0 ||
 	    attr->max_entries == 0 ||
 	    attr->map_flags & ~BLOOM_CREATE_FLAG_MASK ||
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 47d9948d768f0..b5149cfce7d4d 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -723,9 +723,6 @@ int bpf_local_storage_map_alloc_check(union bpf_attr *attr)
 	    !attr->btf_key_type_id || !attr->btf_value_type_id)
 		return -EINVAL;
 
-	if (!bpf_capable())
-		return -EPERM;
-
 	if (attr->value_size > BPF_LOCAL_STORAGE_MAX_VALUE_SIZE)
 		return -E2BIG;
 
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index d3f0a4825fa61..116a0ce378ecd 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -655,9 +655,6 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	const struct btf_type *t, *vt;
 	struct bpf_map *map;
 
-	if (!bpf_capable())
-		return ERR_PTR(-EPERM);
-
 	st_ops = bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id);
 	if (!st_ops)
 		return ERR_PTR(-ENOTSUPP);
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 3da63be602d1c..6ae02be7a48e3 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -28,7 +28,6 @@
 #include <linux/sched.h>
 #include <linux/workqueue.h>
 #include <linux/kthread.h>
-#include <linux/capability.h>
 #include <trace/events/xdp.h>
 #include <linux/btf_ids.h>
 
@@ -89,9 +88,6 @@ static struct bpf_map *cpu_map_alloc(union bpf_attr *attr)
 	u32 value_size = attr->value_size;
 	struct bpf_cpu_map *cmap;
 
-	if (!bpf_capable())
-		return ERR_PTR(-EPERM);
-
 	/* check sanity of attributes */
 	if (attr->max_entries == 0 || attr->key_size != 4 ||
 	    (value_size != offsetofend(struct bpf_cpumap_val, qsize) &&
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 802692fa3905c..49cc0b5671c61 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -160,9 +160,6 @@ static struct bpf_map *dev_map_alloc(union bpf_attr *attr)
 	struct bpf_dtab *dtab;
 	int err;
 
-	if (!capable(CAP_NET_ADMIN))
-		return ERR_PTR(-EPERM);
-
 	dtab = bpf_map_area_alloc(sizeof(*dtab), NUMA_NO_NODE);
 	if (!dtab)
 		return ERR_PTR(-ENOMEM);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 9901efee4339d..56d3da7d0bc66 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -422,12 +422,6 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 	BUILD_BUG_ON(offsetof(struct htab_elem, fnode.next) !=
 		     offsetof(struct htab_elem, hash_node.pprev));
 
-	if (lru && !bpf_capable())
-		/* LRU implementation is much complicated than other
-		 * maps.  Hence, limit to CAP_BPF.
-		 */
-		return -EPERM;
-
 	if (zero_seed && !capable(CAP_SYS_ADMIN))
 		/* Guard against local DoS, and discourage production use. */
 		return -EPERM;
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index e0d3ddf2037ab..17c7e7782a1f7 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -544,9 +544,6 @@ static struct bpf_map *trie_alloc(union bpf_attr *attr)
 {
 	struct lpm_trie *trie;
 
-	if (!bpf_capable())
-		return ERR_PTR(-EPERM);
-
 	/* check sanity of attributes */
 	if (attr->max_entries == 0 ||
 	    !(attr->map_flags & BPF_F_NO_PREALLOC) ||
diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index 601609164ef34..8d2ddcb7566b7 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -7,7 +7,6 @@
 #include <linux/bpf.h>
 #include <linux/list.h>
 #include <linux/slab.h>
-#include <linux/capability.h>
 #include <linux/btf_ids.h>
 #include "percpu_freelist.h"
 
@@ -46,9 +45,6 @@ static bool queue_stack_map_is_full(struct bpf_queue_stack *qs)
 /* Called from syscall */
 static int queue_stack_map_alloc_check(union bpf_attr *attr)
 {
-	if (!bpf_capable())
-		return -EPERM;
-
 	/* check sanity of attributes */
 	if (attr->max_entries == 0 || attr->key_size != 0 ||
 	    attr->value_size == 0 ||
diff --git a/kernel/bpf/reuseport_array.c b/kernel/bpf/reuseport_array.c
index cbf2d8d784b89..4b4f9670f1a9a 100644
--- a/kernel/bpf/reuseport_array.c
+++ b/kernel/bpf/reuseport_array.c
@@ -151,9 +151,6 @@ static struct bpf_map *reuseport_array_alloc(union bpf_attr *attr)
 	int numa_node = bpf_map_attr_numa_node(attr);
 	struct reuseport_array *array;
 
-	if (!bpf_capable())
-		return ERR_PTR(-EPERM);
-
 	/* allocate all map elements and zero-initialize them */
 	array = bpf_map_area_alloc(struct_size(array, ptrs, attr->max_entries), numa_node);
 	if (!array)
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index b25fce425b2c6..458bb80b14d57 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -74,9 +74,6 @@ static struct bpf_map *stack_map_alloc(union bpf_attr *attr)
 	u64 cost, n_buckets;
 	int err;
 
-	if (!bpf_capable())
-		return ERR_PTR(-EPERM);
-
 	if (attr->map_flags & ~STACK_CREATE_FLAG_MASK)
 		return ERR_PTR(-EINVAL);
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8fddf0eea9bf2..f715ec5d541ad 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1156,6 +1156,53 @@ static int map_create(union bpf_attr *attr)
 	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
 		return -EPERM;
 
+	/* check privileged map type permissions */
+	switch (map_type) {
+	case BPF_MAP_TYPE_ARRAY:
+	case BPF_MAP_TYPE_PERCPU_ARRAY:
+	case BPF_MAP_TYPE_PROG_ARRAY:
+	case BPF_MAP_TYPE_PERF_EVENT_ARRAY:
+	case BPF_MAP_TYPE_CGROUP_ARRAY:
+	case BPF_MAP_TYPE_ARRAY_OF_MAPS:
+	case BPF_MAP_TYPE_HASH:
+	case BPF_MAP_TYPE_PERCPU_HASH:
+	case BPF_MAP_TYPE_HASH_OF_MAPS:
+	case BPF_MAP_TYPE_RINGBUF:
+	case BPF_MAP_TYPE_USER_RINGBUF:
+	case BPF_MAP_TYPE_CGROUP_STORAGE:
+	case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
+		/* unprivileged */
+		break;
+	case BPF_MAP_TYPE_SK_STORAGE:
+	case BPF_MAP_TYPE_INODE_STORAGE:
+	case BPF_MAP_TYPE_TASK_STORAGE:
+	case BPF_MAP_TYPE_CGRP_STORAGE:
+	case BPF_MAP_TYPE_BLOOM_FILTER:
+	case BPF_MAP_TYPE_LPM_TRIE:
+	case BPF_MAP_TYPE_REUSEPORT_SOCKARRAY:
+	case BPF_MAP_TYPE_STACK_TRACE:
+	case BPF_MAP_TYPE_QUEUE:
+	case BPF_MAP_TYPE_STACK:
+	case BPF_MAP_TYPE_LRU_HASH:
+	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
+	case BPF_MAP_TYPE_STRUCT_OPS:
+	case BPF_MAP_TYPE_CPUMAP:
+		if (!bpf_capable())
+			return -EPERM;
+		break;
+	case BPF_MAP_TYPE_SOCKMAP:
+	case BPF_MAP_TYPE_SOCKHASH:
+	case BPF_MAP_TYPE_DEVMAP:
+	case BPF_MAP_TYPE_DEVMAP_HASH:
+	case BPF_MAP_TYPE_XSKMAP:
+		if (!capable(CAP_NET_ADMIN))
+			return -EPERM;
+		break;
+	default:
+		WARN(1, "unsupported map type %d", map_type);
+		return -EPERM;
+	}
+
 	map = ops->map_alloc(attr);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 00afb66cd0950..19538d6287144 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -32,8 +32,6 @@ static struct bpf_map *sock_map_alloc(union bpf_attr *attr)
 {
 	struct bpf_stab *stab;
 
-	if (!capable(CAP_NET_ADMIN))
-		return ERR_PTR(-EPERM);
 	if (attr->max_entries == 0 ||
 	    attr->key_size    != 4 ||
 	    (attr->value_size != sizeof(u32) &&
@@ -1085,8 +1083,6 @@ static struct bpf_map *sock_hash_alloc(union bpf_attr *attr)
 	struct bpf_shtab *htab;
 	int i, err;
 
-	if (!capable(CAP_NET_ADMIN))
-		return ERR_PTR(-EPERM);
 	if (attr->max_entries == 0 ||
 	    attr->key_size    == 0 ||
 	    (attr->value_size != sizeof(u32) &&
diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
index 2c1427074a3bb..e1c526f97ce31 100644
--- a/net/xdp/xskmap.c
+++ b/net/xdp/xskmap.c
@@ -5,7 +5,6 @@
 
 #include <linux/bpf.h>
 #include <linux/filter.h>
-#include <linux/capability.h>
 #include <net/xdp_sock.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
@@ -68,9 +67,6 @@ static struct bpf_map *xsk_map_alloc(union bpf_attr *attr)
 	int numa_node;
 	u64 size;
 
-	if (!capable(CAP_NET_ADMIN))
-		return ERR_PTR(-EPERM);
-
 	if (attr->max_entries == 0 || attr->key_size != 4 ||
 	    attr->value_size != 4 ||
 	    attr->map_flags & ~(BPF_F_NUMA_NODE | BPF_F_RDONLY | BPF_F_WRONLY))
diff --git a/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c b/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
index 8383a99f610fd..0adf8d9475cb2 100644
--- a/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
+++ b/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
@@ -171,7 +171,11 @@ static void test_unpriv_bpf_disabled_negative(struct test_unpriv_bpf_disabled *s
 				prog_insns, prog_insn_cnt, &load_opts),
 		  -EPERM, "prog_load_fails");
 
-	for (i = BPF_MAP_TYPE_HASH; i <= BPF_MAP_TYPE_BLOOM_FILTER; i++)
+	/* some map types require particular correct parameters which could be
+	 * sanity-checked before enforcing -EPERM, so only validate that
+	 * the simple ARRAY and HASH maps are failing with -EPERM
+	 */
+	for (i = BPF_MAP_TYPE_HASH; i <= BPF_MAP_TYPE_ARRAY; i++)
 		ASSERT_EQ(bpf_map_create(i, NULL, sizeof(int), sizeof(int), 1, NULL),
 			  -EPERM, "map_create_fails");
 
-- 
2.40.1



