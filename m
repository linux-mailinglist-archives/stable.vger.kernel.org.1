Return-Path: <stable+bounces-68555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0779532E8
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E01CE288F79
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BDF1B151D;
	Thu, 15 Aug 2024 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ITRi8nI/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD281AD9D4;
	Thu, 15 Aug 2024 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730940; cv=none; b=G5uTXJiRh4TwLvAxgvXRuuYiaXnhFB1WJdIFq9sOG/3+tboxm0dhu6ni8KKsMTkdPT3dKG6MmXDEBGZv4K4PfgJJwwvMK4GCVSLYTb/F2MV5SFFhUOUbM0Aq6mJtEF5HZf0mbqubSN3kONm91hcGDsWxPVZE7yDW8YCg9PC0UOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730940; c=relaxed/simple;
	bh=U1NYrRgotCyeECeORQcW+Hg8u8JTyTpiHz/az2Zetco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmUFKQbI4+df4qt+0DSAzwid5TwkpTdd9ahoKpeJo1NsQvRXO0XoJHey5I7hx5bmXspMNTeaE/IAu2B0gF8eOaNEfJVxdry7eosoh+Pe1XOj90iCwgkEi8txtJB+lCuj/xcM4hrypSFoO7wje0C5W+tqNJlpVFYu44gClJZi7vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ITRi8nI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44687C32786;
	Thu, 15 Aug 2024 14:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723730940;
	bh=U1NYrRgotCyeECeORQcW+Hg8u8JTyTpiHz/az2Zetco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ITRi8nI/UQJy0+imcRjHkXQ2olV95rEP7Uiyo23Th1GYpjyiHG1n+iRqVNpSx+M+j
	 DGrBQjIf5yQ+H/tCc3ASDYn8qzvql+wMMQDpqvggSSNHmvJ7wnyYD+l/udqNJPW6dI
	 T/y7TLK+nDD49yPUMqmP0uc+23sPUz6UT2sdfoyo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Kees Cook <keescook@chromium.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 40/67] bpf: Replace bpf_lpm_trie_key 0-length array with flexible array
Date: Thu, 15 Aug 2024 15:25:54 +0200
Message-ID: <20240815131839.857882601@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131838.311442229@linuxfoundation.org>
References: <20240815131838.311442229@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 896880ff30866f386ebed14ab81ce1ad3710cfc4 ]

Replace deprecated 0-length array in struct bpf_lpm_trie_key with
flexible array. Found with GCC 13:

../kernel/bpf/lpm_trie.c:207:51: warning: array subscript i is outside array bounds of 'const __u8[0]' {aka 'const unsigned char[]'} [-Warray-bounds=]
  207 |                                        *(__be16 *)&key->data[i]);
      |                                                   ^~~~~~~~~~~~~
../include/uapi/linux/swab.h:102:54: note: in definition of macro '__swab16'
  102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
      |                                                      ^
../include/linux/byteorder/generic.h:97:21: note: in expansion of macro '__be16_to_cpu'
   97 | #define be16_to_cpu __be16_to_cpu
      |                     ^~~~~~~~~~~~~
../kernel/bpf/lpm_trie.c:206:28: note: in expansion of macro 'be16_to_cpu'
  206 |                 u16 diff = be16_to_cpu(*(__be16 *)&node->data[i]
^
      |                            ^~~~~~~~~~~
In file included from ../include/linux/bpf.h:7:
../include/uapi/linux/bpf.h:82:17: note: while referencing 'data'
   82 |         __u8    data[0];        /* Arbitrary size */
      |                 ^~~~

And found at run-time under CONFIG_FORTIFY_SOURCE:

  UBSAN: array-index-out-of-bounds in kernel/bpf/lpm_trie.c:218:49
  index 0 is out of range for type '__u8 [*]'

Changing struct bpf_lpm_trie_key is difficult since has been used by
userspace. For example, in Cilium:

	struct egress_gw_policy_key {
	        struct bpf_lpm_trie_key lpm_key;
	        __u32 saddr;
	        __u32 daddr;
	};

While direct references to the "data" member haven't been found, there
are static initializers what include the final member. For example,
the "{}" here:

        struct egress_gw_policy_key in_key = {
                .lpm_key = { 32 + 24, {} },
                .saddr   = CLIENT_IP,
                .daddr   = EXTERNAL_SVC_IP & 0Xffffff,
        };

To avoid the build time and run time warnings seen with a 0-sized
trailing array for struct bpf_lpm_trie_key, introduce a new struct
that correctly uses a flexible array for the trailing bytes,
struct bpf_lpm_trie_key_u8. As part of this, include the "header"
portion (which is just the "prefixlen" member), so it can be used
by anything building a bpf_lpr_trie_key that has trailing members that
aren't a u8 flexible array (like the self-test[1]), which is named
struct bpf_lpm_trie_key_hdr.

Unfortunately, C++ refuses to parse the __struct_group() helper, so
it is not possible to define struct bpf_lpm_trie_key_hdr directly in
struct bpf_lpm_trie_key_u8, so we must open-code the union directly.

Adjust the kernel code to use struct bpf_lpm_trie_key_u8 through-out,
and for the selftest to use struct bpf_lpm_trie_key_hdr. Add a comment
to the UAPI header directing folks to the two new options.

Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Closes: https://paste.debian.net/hidden/ca500597/
Link: https://lore.kernel.org/all/202206281009.4332AA33@keescook/ [1]
Link: https://lore.kernel.org/bpf/20240222155612.it.533-kees@kernel.org
Stable-dep-of: 59f2f841179a ("bpf: Avoid kfree_rcu() under lock in bpf_lpm_trie.")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/bpf/map_lpm_trie.rst            |  2 +-
 include/uapi/linux/bpf.h                      | 19 +++++++++++++++++-
 kernel/bpf/lpm_trie.c                         | 20 +++++++++----------
 samples/bpf/map_perf_test_user.c              |  2 +-
 samples/bpf/xdp_router_ipv4_user.c            |  2 +-
 tools/include/uapi/linux/bpf.h                | 19 +++++++++++++++++-
 .../selftests/bpf/progs/map_ptr_kern.c        |  2 +-
 tools/testing/selftests/bpf/test_lpm_map.c    | 18 ++++++++---------
 8 files changed, 59 insertions(+), 25 deletions(-)

diff --git a/Documentation/bpf/map_lpm_trie.rst b/Documentation/bpf/map_lpm_trie.rst
index 74d64a30f5007..f9cd579496c9c 100644
--- a/Documentation/bpf/map_lpm_trie.rst
+++ b/Documentation/bpf/map_lpm_trie.rst
@@ -17,7 +17,7 @@ significant byte.
 
 LPM tries may be created with a maximum prefix length that is a multiple
 of 8, in the range from 8 to 2048. The key used for lookup and update
-operations is a ``struct bpf_lpm_trie_key``, extended by
+operations is a ``struct bpf_lpm_trie_key_u8``, extended by
 ``max_prefixlen/8`` bytes.
 
 - For IPv4 addresses the data length is 4 bytes
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index fb09fd1767f28..ba6e346c8d669 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -77,12 +77,29 @@ struct bpf_insn {
 	__s32	imm;		/* signed immediate constant */
 };
 
-/* Key of an a BPF_MAP_TYPE_LPM_TRIE entry */
+/* Deprecated: use struct bpf_lpm_trie_key_u8 (when the "data" member is needed for
+ * byte access) or struct bpf_lpm_trie_key_hdr (when using an alternative type for
+ * the trailing flexible array member) instead.
+ */
 struct bpf_lpm_trie_key {
 	__u32	prefixlen;	/* up to 32 for AF_INET, 128 for AF_INET6 */
 	__u8	data[0];	/* Arbitrary size */
 };
 
+/* Header for bpf_lpm_trie_key structs */
+struct bpf_lpm_trie_key_hdr {
+	__u32	prefixlen;
+};
+
+/* Key of an a BPF_MAP_TYPE_LPM_TRIE entry, with trailing byte array. */
+struct bpf_lpm_trie_key_u8 {
+	union {
+		struct bpf_lpm_trie_key_hdr	hdr;
+		__u32				prefixlen;
+	};
+	__u8	data[];		/* Arbitrary size */
+};
+
 struct bpf_cgroup_storage_key {
 	__u64	cgroup_inode_id;	/* cgroup inode id */
 	__u32	attach_type;		/* program attach type (enum bpf_attach_type) */
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index b32be680da6cd..050fe1ebf0f7d 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -164,13 +164,13 @@ static inline int extract_bit(const u8 *data, size_t index)
  */
 static size_t longest_prefix_match(const struct lpm_trie *trie,
 				   const struct lpm_trie_node *node,
-				   const struct bpf_lpm_trie_key *key)
+				   const struct bpf_lpm_trie_key_u8 *key)
 {
 	u32 limit = min(node->prefixlen, key->prefixlen);
 	u32 prefixlen = 0, i = 0;
 
 	BUILD_BUG_ON(offsetof(struct lpm_trie_node, data) % sizeof(u32));
-	BUILD_BUG_ON(offsetof(struct bpf_lpm_trie_key, data) % sizeof(u32));
+	BUILD_BUG_ON(offsetof(struct bpf_lpm_trie_key_u8, data) % sizeof(u32));
 
 #if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && defined(CONFIG_64BIT)
 
@@ -229,7 +229,7 @@ static void *trie_lookup_elem(struct bpf_map *map, void *_key)
 {
 	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
 	struct lpm_trie_node *node, *found = NULL;
-	struct bpf_lpm_trie_key *key = _key;
+	struct bpf_lpm_trie_key_u8 *key = _key;
 
 	if (key->prefixlen > trie->max_prefixlen)
 		return NULL;
@@ -309,7 +309,7 @@ static long trie_update_elem(struct bpf_map *map,
 	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
 	struct lpm_trie_node *node, *im_node = NULL, *new_node = NULL;
 	struct lpm_trie_node __rcu **slot;
-	struct bpf_lpm_trie_key *key = _key;
+	struct bpf_lpm_trie_key_u8 *key = _key;
 	unsigned long irq_flags;
 	unsigned int next_bit;
 	size_t matchlen = 0;
@@ -437,7 +437,7 @@ static long trie_update_elem(struct bpf_map *map,
 static long trie_delete_elem(struct bpf_map *map, void *_key)
 {
 	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
-	struct bpf_lpm_trie_key *key = _key;
+	struct bpf_lpm_trie_key_u8 *key = _key;
 	struct lpm_trie_node __rcu **trim, **trim2;
 	struct lpm_trie_node *node, *parent;
 	unsigned long irq_flags;
@@ -536,7 +536,7 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
 				 sizeof(struct lpm_trie_node))
 #define LPM_VAL_SIZE_MIN	1
 
-#define LPM_KEY_SIZE(X)		(sizeof(struct bpf_lpm_trie_key) + (X))
+#define LPM_KEY_SIZE(X)		(sizeof(struct bpf_lpm_trie_key_u8) + (X))
 #define LPM_KEY_SIZE_MAX	LPM_KEY_SIZE(LPM_DATA_SIZE_MAX)
 #define LPM_KEY_SIZE_MIN	LPM_KEY_SIZE(LPM_DATA_SIZE_MIN)
 
@@ -565,7 +565,7 @@ static struct bpf_map *trie_alloc(union bpf_attr *attr)
 	/* copy mandatory map attributes */
 	bpf_map_init_from_attr(&trie->map, attr);
 	trie->data_size = attr->key_size -
-			  offsetof(struct bpf_lpm_trie_key, data);
+			  offsetof(struct bpf_lpm_trie_key_u8, data);
 	trie->max_prefixlen = trie->data_size * 8;
 
 	spin_lock_init(&trie->lock);
@@ -616,7 +616,7 @@ static int trie_get_next_key(struct bpf_map *map, void *_key, void *_next_key)
 {
 	struct lpm_trie_node *node, *next_node = NULL, *parent, *search_root;
 	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
-	struct bpf_lpm_trie_key *key = _key, *next_key = _next_key;
+	struct bpf_lpm_trie_key_u8 *key = _key, *next_key = _next_key;
 	struct lpm_trie_node **node_stack = NULL;
 	int err = 0, stack_ptr = -1;
 	unsigned int next_bit;
@@ -703,7 +703,7 @@ static int trie_get_next_key(struct bpf_map *map, void *_key, void *_next_key)
 	}
 do_copy:
 	next_key->prefixlen = next_node->prefixlen;
-	memcpy((void *)next_key + offsetof(struct bpf_lpm_trie_key, data),
+	memcpy((void *)next_key + offsetof(struct bpf_lpm_trie_key_u8, data),
 	       next_node->data, trie->data_size);
 free_stack:
 	kfree(node_stack);
@@ -715,7 +715,7 @@ static int trie_check_btf(const struct bpf_map *map,
 			  const struct btf_type *key_type,
 			  const struct btf_type *value_type)
 {
-	/* Keys must have struct bpf_lpm_trie_key embedded. */
+	/* Keys must have struct bpf_lpm_trie_key_u8 embedded. */
 	return BTF_INFO_KIND(key_type->info) != BTF_KIND_STRUCT ?
 	       -EINVAL : 0;
 }
diff --git a/samples/bpf/map_perf_test_user.c b/samples/bpf/map_perf_test_user.c
index d2fbcf963cdf6..07ff471ed6aee 100644
--- a/samples/bpf/map_perf_test_user.c
+++ b/samples/bpf/map_perf_test_user.c
@@ -370,7 +370,7 @@ static void run_perf_test(int tasks)
 
 static void fill_lpm_trie(void)
 {
-	struct bpf_lpm_trie_key *key;
+	struct bpf_lpm_trie_key_u8 *key;
 	unsigned long value = 0;
 	unsigned int i;
 	int r;
diff --git a/samples/bpf/xdp_router_ipv4_user.c b/samples/bpf/xdp_router_ipv4_user.c
index 9d41db09c4800..266fdd0b025dc 100644
--- a/samples/bpf/xdp_router_ipv4_user.c
+++ b/samples/bpf/xdp_router_ipv4_user.c
@@ -91,7 +91,7 @@ static int recv_msg(struct sockaddr_nl sock_addr, int sock)
 static void read_route(struct nlmsghdr *nh, int nll)
 {
 	char dsts[24], gws[24], ifs[16], dsts_len[24], metrics[24];
-	struct bpf_lpm_trie_key *prefix_key;
+	struct bpf_lpm_trie_key_u8 *prefix_key;
 	struct rtattr *rt_attr;
 	struct rtmsg *rt_msg;
 	int rtm_family;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index fb09fd1767f28..ba6e346c8d669 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -77,12 +77,29 @@ struct bpf_insn {
 	__s32	imm;		/* signed immediate constant */
 };
 
-/* Key of an a BPF_MAP_TYPE_LPM_TRIE entry */
+/* Deprecated: use struct bpf_lpm_trie_key_u8 (when the "data" member is needed for
+ * byte access) or struct bpf_lpm_trie_key_hdr (when using an alternative type for
+ * the trailing flexible array member) instead.
+ */
 struct bpf_lpm_trie_key {
 	__u32	prefixlen;	/* up to 32 for AF_INET, 128 for AF_INET6 */
 	__u8	data[0];	/* Arbitrary size */
 };
 
+/* Header for bpf_lpm_trie_key structs */
+struct bpf_lpm_trie_key_hdr {
+	__u32	prefixlen;
+};
+
+/* Key of an a BPF_MAP_TYPE_LPM_TRIE entry, with trailing byte array. */
+struct bpf_lpm_trie_key_u8 {
+	union {
+		struct bpf_lpm_trie_key_hdr	hdr;
+		__u32				prefixlen;
+	};
+	__u8	data[];		/* Arbitrary size */
+};
+
 struct bpf_cgroup_storage_key {
 	__u64	cgroup_inode_id;	/* cgroup inode id */
 	__u32	attach_type;		/* program attach type (enum bpf_attach_type) */
diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
index 3325da17ec81a..efaf622c28dde 100644
--- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
+++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
@@ -316,7 +316,7 @@ struct lpm_trie {
 } __attribute__((preserve_access_index));
 
 struct lpm_key {
-	struct bpf_lpm_trie_key trie_key;
+	struct bpf_lpm_trie_key_hdr trie_key;
 	__u32 data;
 };
 
diff --git a/tools/testing/selftests/bpf/test_lpm_map.c b/tools/testing/selftests/bpf/test_lpm_map.c
index c028d621c744d..d98c72dc563ea 100644
--- a/tools/testing/selftests/bpf/test_lpm_map.c
+++ b/tools/testing/selftests/bpf/test_lpm_map.c
@@ -211,7 +211,7 @@ static void test_lpm_map(int keysize)
 	volatile size_t n_matches, n_matches_after_delete;
 	size_t i, j, n_nodes, n_lookups;
 	struct tlpm_node *t, *list = NULL;
-	struct bpf_lpm_trie_key *key;
+	struct bpf_lpm_trie_key_u8 *key;
 	uint8_t *data, *value;
 	int r, map;
 
@@ -331,8 +331,8 @@ static void test_lpm_map(int keysize)
 static void test_lpm_ipaddr(void)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_NO_PREALLOC);
-	struct bpf_lpm_trie_key *key_ipv4;
-	struct bpf_lpm_trie_key *key_ipv6;
+	struct bpf_lpm_trie_key_u8 *key_ipv4;
+	struct bpf_lpm_trie_key_u8 *key_ipv6;
 	size_t key_size_ipv4;
 	size_t key_size_ipv6;
 	int map_fd_ipv4;
@@ -423,7 +423,7 @@ static void test_lpm_ipaddr(void)
 static void test_lpm_delete(void)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_NO_PREALLOC);
-	struct bpf_lpm_trie_key *key;
+	struct bpf_lpm_trie_key_u8 *key;
 	size_t key_size;
 	int map_fd;
 	__u64 value;
@@ -532,7 +532,7 @@ static void test_lpm_delete(void)
 static void test_lpm_get_next_key(void)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_NO_PREALLOC);
-	struct bpf_lpm_trie_key *key_p, *next_key_p;
+	struct bpf_lpm_trie_key_u8 *key_p, *next_key_p;
 	size_t key_size;
 	__u32 value = 0;
 	int map_fd;
@@ -693,9 +693,9 @@ static void *lpm_test_command(void *arg)
 {
 	int i, j, ret, iter, key_size;
 	struct lpm_mt_test_info *info = arg;
-	struct bpf_lpm_trie_key *key_p;
+	struct bpf_lpm_trie_key_u8 *key_p;
 
-	key_size = sizeof(struct bpf_lpm_trie_key) + sizeof(__u32);
+	key_size = sizeof(*key_p) + sizeof(__u32);
 	key_p = alloca(key_size);
 	for (iter = 0; iter < info->iter; iter++)
 		for (i = 0; i < MAX_TEST_KEYS; i++) {
@@ -717,7 +717,7 @@ static void *lpm_test_command(void *arg)
 				ret = bpf_map_lookup_elem(info->map_fd, key_p, &value);
 				assert(ret == 0 || errno == ENOENT);
 			} else {
-				struct bpf_lpm_trie_key *next_key_p = alloca(key_size);
+				struct bpf_lpm_trie_key_u8 *next_key_p = alloca(key_size);
 				ret = bpf_map_get_next_key(info->map_fd, key_p, next_key_p);
 				assert(ret == 0 || errno == ENOENT || errno == ENOMEM);
 			}
@@ -752,7 +752,7 @@ static void test_lpm_multi_thread(void)
 
 	/* create a trie */
 	value_size = sizeof(__u32);
-	key_size = sizeof(struct bpf_lpm_trie_key) + value_size;
+	key_size = sizeof(struct bpf_lpm_trie_key_hdr) + value_size;
 	map_fd = bpf_map_create(BPF_MAP_TYPE_LPM_TRIE, NULL, key_size, value_size, 100, &opts);
 
 	/* create 4 threads to test update, delete, lookup and get_next_key */
-- 
2.43.0




