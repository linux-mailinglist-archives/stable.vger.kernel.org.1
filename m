Return-Path: <stable+bounces-107694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB5DA02D15
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 17:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C46B57A2A59
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FF51DDC10;
	Mon,  6 Jan 2025 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kAyz1+Cx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA081DACBB;
	Mon,  6 Jan 2025 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736179243; cv=none; b=CoC6eYn4XhceBDmeK2ZHRmu6myn1bwbPjEkdES8QgyMqCq9Kj/f9dvEQrPLX4JjKg5fgBsDXk/zt0+H1UxDJBTwRexDIogtIOVCYny9q4+7TxJmSuWpZm9NPS208WFghy5u+2FYUw1WNeKyamDOtwiixjCxdGKGas70lMdRkCuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736179243; c=relaxed/simple;
	bh=fIxty27YL3jwC7C9SC/YNQwTvgD8OfeOVPAkl6qlfDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJ5JRfvDhXChH29Va9U2JqbslYrJINU+0EXFPDXPnf4B6Sb6WbU+9nNxZb/kNp5R6HiGCrokj1cNlKpyYdKLkIV6+/ZKSYUwRRBlAtFbJiqxVKB+C3B+3FXERg6RZUbkI1wRgDKKgdJLtreRVQIdMvP2lOPq29yrflmM/eU3sRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kAyz1+Cx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAB7C4CED2;
	Mon,  6 Jan 2025 16:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736179242;
	bh=fIxty27YL3jwC7C9SC/YNQwTvgD8OfeOVPAkl6qlfDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kAyz1+CxDBE7ox3q31nqs9NyQYtSWiEDZf58Hsnxy/SWAlIBZuHvg0k+BSNXMGPaU
	 cpwSgXI3KRUrOh+MqtBa8LCcMeFJh6LQ0uRf1mi+wXCMWhIbsITq0ohsQjGWo1teWV
	 hR6hnjPs5Dmg8i8gMnTq2XqTCMlgaA2EJLfc7yxM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 73/93] netfilter: Replace zero-length array with flexible-array member
Date: Mon,  6 Jan 2025 16:17:49 +0100
Message-ID: <20250106151131.460592311@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151128.686130933@linuxfoundation.org>
References: <20250106151128.686130933@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

[ Upstream commit 6daf14140129d30207ed6a0a69851fa6a3636bda ]

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

Lastly, fix checkpatch.pl warning
WARNING: __aligned(size) is preferred over __attribute__((aligned(size)))
in net/bridge/netfilter/ebtables.c

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: 542ed8145e6f ("netfilter: nft_set_hash: unaligned atomic read on struct nft_set_ext")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/netfilter/ipset/ip_set.h          | 2 +-
 include/linux/netfilter/x_tables.h              | 8 ++++----
 include/linux/netfilter_arp/arp_tables.h        | 2 +-
 include/linux/netfilter_bridge/ebtables.h       | 2 +-
 include/linux/netfilter_ipv4/ip_tables.h        | 2 +-
 include/linux/netfilter_ipv6/ip6_tables.h       | 2 +-
 include/net/netfilter/nf_conntrack_extend.h     | 2 +-
 include/net/netfilter/nf_conntrack_timeout.h    | 2 +-
 include/net/netfilter/nf_tables.h               | 6 +++---
 include/uapi/linux/netfilter_bridge/ebt_among.h | 2 +-
 net/bridge/netfilter/ebtables.c                 | 2 +-
 net/ipv4/netfilter/arp_tables.c                 | 4 ++--
 net/ipv4/netfilter/ip_tables.c                  | 4 ++--
 net/ipv6/netfilter/ip6_tables.c                 | 4 ++--
 net/netfilter/ipset/ip_set_bitmap_ip.c          | 2 +-
 net/netfilter/ipset/ip_set_bitmap_ipmac.c       | 2 +-
 net/netfilter/ipset/ip_set_bitmap_port.c        | 2 +-
 net/netfilter/ipset/ip_set_hash_gen.h           | 4 ++--
 net/netfilter/nfnetlink_acct.c                  | 2 +-
 net/netfilter/xt_hashlimit.c                    | 2 +-
 net/netfilter/xt_recent.c                       | 4 ++--
 21 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/include/linux/netfilter/ipset/ip_set.h b/include/linux/netfilter/ipset/ip_set.h
index 35342fb48866..ef6a9d082c2c 100644
--- a/include/linux/netfilter/ipset/ip_set.h
+++ b/include/linux/netfilter/ipset/ip_set.h
@@ -98,7 +98,7 @@ struct ip_set_counter {
 
 struct ip_set_comment_rcu {
 	struct rcu_head rcu;
-	char str[0];
+	char str[];
 };
 
 struct ip_set_comment {
diff --git a/include/linux/netfilter/x_tables.h b/include/linux/netfilter/x_tables.h
index 04e7f5630509..e66ef9bf6ff3 100644
--- a/include/linux/netfilter/x_tables.h
+++ b/include/linux/netfilter/x_tables.h
@@ -264,7 +264,7 @@ struct xt_table_info {
 	unsigned int stacksize;
 	void ***jumpstack;
 
-	unsigned char entries[0] __aligned(8);
+	unsigned char entries[] __aligned(8);
 };
 
 int xt_register_target(struct xt_target *target);
@@ -464,7 +464,7 @@ struct compat_xt_entry_match {
 		} kernel;
 		u_int16_t match_size;
 	} u;
-	unsigned char data[0];
+	unsigned char data[];
 };
 
 struct compat_xt_entry_target {
@@ -480,7 +480,7 @@ struct compat_xt_entry_target {
 		} kernel;
 		u_int16_t target_size;
 	} u;
-	unsigned char data[0];
+	unsigned char data[];
 };
 
 /* FIXME: this works only on 32 bit tasks
@@ -494,7 +494,7 @@ struct compat_xt_counters {
 struct compat_xt_counters_info {
 	char name[XT_TABLE_MAXNAMELEN];
 	compat_uint_t num_counters;
-	struct compat_xt_counters counters[0];
+	struct compat_xt_counters counters[];
 };
 
 struct _compat_xt_align {
diff --git a/include/linux/netfilter_arp/arp_tables.h b/include/linux/netfilter_arp/arp_tables.h
index 6988cf9ffe3a..26a13294318c 100644
--- a/include/linux/netfilter_arp/arp_tables.h
+++ b/include/linux/netfilter_arp/arp_tables.h
@@ -68,7 +68,7 @@ struct compat_arpt_entry {
 	__u16 next_offset;
 	compat_uint_t comefrom;
 	struct compat_xt_counters counters;
-	unsigned char elems[0];
+	unsigned char elems[];
 };
 
 static inline struct xt_entry_target *
diff --git a/include/linux/netfilter_bridge/ebtables.h b/include/linux/netfilter_bridge/ebtables.h
index f0d846df3a42..a18fb73a2b77 100644
--- a/include/linux/netfilter_bridge/ebtables.h
+++ b/include/linux/netfilter_bridge/ebtables.h
@@ -85,7 +85,7 @@ struct ebt_table_info {
 	/* room to maintain the stack used for jumping from and into udc */
 	struct ebt_chainstack **chainstack;
 	char *entries;
-	struct ebt_counter counters[0] ____cacheline_aligned;
+	struct ebt_counter counters[] ____cacheline_aligned;
 };
 
 struct ebt_table {
diff --git a/include/linux/netfilter_ipv4/ip_tables.h b/include/linux/netfilter_ipv4/ip_tables.h
index e9e1ed74cdf1..b394bd4f68a3 100644
--- a/include/linux/netfilter_ipv4/ip_tables.h
+++ b/include/linux/netfilter_ipv4/ip_tables.h
@@ -76,7 +76,7 @@ struct compat_ipt_entry {
 	__u16 next_offset;
 	compat_uint_t comefrom;
 	struct compat_xt_counters counters;
-	unsigned char elems[0];
+	unsigned char elems[];
 };
 
 /* Helper functions */
diff --git a/include/linux/netfilter_ipv6/ip6_tables.h b/include/linux/netfilter_ipv6/ip6_tables.h
index 78ab959c4575..8225f7821a29 100644
--- a/include/linux/netfilter_ipv6/ip6_tables.h
+++ b/include/linux/netfilter_ipv6/ip6_tables.h
@@ -43,7 +43,7 @@ struct compat_ip6t_entry {
 	__u16 next_offset;
 	compat_uint_t comefrom;
 	struct compat_xt_counters counters;
-	unsigned char elems[0];
+	unsigned char elems[];
 };
 
 static inline struct xt_entry_target *
diff --git a/include/net/netfilter/nf_conntrack_extend.h b/include/net/netfilter/nf_conntrack_extend.h
index 112a6f40dfaf..d0e87120d2f4 100644
--- a/include/net/netfilter/nf_conntrack_extend.h
+++ b/include/net/netfilter/nf_conntrack_extend.h
@@ -46,7 +46,7 @@ struct nf_ct_ext {
 	struct rcu_head rcu;
 	u8 offset[NF_CT_EXT_NUM];
 	u8 len;
-	char data[0];
+	char data[];
 };
 
 static inline bool __nf_ct_ext_exist(const struct nf_ct_ext *ext, u8 id)
diff --git a/include/net/netfilter/nf_conntrack_timeout.h b/include/net/netfilter/nf_conntrack_timeout.h
index 6dd72396f534..659b0ea25b4d 100644
--- a/include/net/netfilter/nf_conntrack_timeout.h
+++ b/include/net/netfilter/nf_conntrack_timeout.h
@@ -14,7 +14,7 @@
 struct nf_ct_timeout {
 	__u16			l3num;
 	const struct nf_conntrack_l4proto *l4proto;
-	char			data[0];
+	char			data[];
 };
 
 struct ctnl_timeout {
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 648aac42dfec..c50dee30a70c 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -226,7 +226,7 @@ int nft_parse_register_store(const struct nft_ctx *ctx,
  */
 struct nft_userdata {
 	u8			len;
-	unsigned char		data[0];
+	unsigned char		data[];
 };
 
 /**
@@ -578,7 +578,7 @@ struct nft_set_ext_tmpl {
 struct nft_set_ext {
 	u8	genmask;
 	u8	offset[NFT_SET_EXT_NUM];
-	char	data[0];
+	char	data[];
 };
 
 static inline void nft_set_ext_prepare(struct nft_set_ext_tmpl *tmpl)
@@ -1357,7 +1357,7 @@ struct nft_trans {
 	int				msg_type;
 	bool				put_net;
 	struct nft_ctx			ctx;
-	char				data[0];
+	char				data[];
 };
 
 struct nft_trans_rule {
diff --git a/include/uapi/linux/netfilter_bridge/ebt_among.h b/include/uapi/linux/netfilter_bridge/ebt_among.h
index 9acf757bc1f7..73b26a280c4f 100644
--- a/include/uapi/linux/netfilter_bridge/ebt_among.h
+++ b/include/uapi/linux/netfilter_bridge/ebt_among.h
@@ -40,7 +40,7 @@ struct ebt_mac_wormhash_tuple {
 struct ebt_mac_wormhash {
 	int table[257];
 	int poolsize;
-	struct ebt_mac_wormhash_tuple pool[0];
+	struct ebt_mac_wormhash_tuple pool[];
 };
 
 #define ebt_mac_wormhash_size(x) ((x) ? sizeof(struct ebt_mac_wormhash) \
diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index f6853fc0fcc0..9d07cf277759 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1581,7 +1581,7 @@ struct compat_ebt_entry_mwt {
 		compat_uptr_t ptr;
 	} u;
 	compat_uint_t match_size;
-	compat_uint_t data[0] __attribute__ ((aligned (__alignof__(struct compat_ebt_replace))));
+	compat_uint_t data[] __aligned(__alignof__(struct compat_ebt_replace));
 };
 
 /* account for possible padding between match_size and ->data */
diff --git a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_tables.c
index a6f2e5bf7045..c62c9713e7dd 100644
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -1057,7 +1057,7 @@ struct compat_arpt_replace {
 	u32				underflow[NF_ARP_NUMHOOKS];
 	u32				num_counters;
 	compat_uptr_t			counters;
-	struct compat_arpt_entry	entries[0];
+	struct compat_arpt_entry	entries[];
 };
 
 static inline void compat_release_entry(struct compat_arpt_entry *e)
@@ -1385,7 +1385,7 @@ static int compat_copy_entries_to_user(unsigned int total_size,
 struct compat_arpt_get_entries {
 	char name[XT_TABLE_MAXNAMELEN];
 	compat_uint_t size;
-	struct compat_arpt_entry entrytable[0];
+	struct compat_arpt_entry entrytable[];
 };
 
 static int compat_get_entries(struct net *net,
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index 0076449eea35..c21ba5e62fff 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -1211,7 +1211,7 @@ struct compat_ipt_replace {
 	u32			underflow[NF_INET_NUMHOOKS];
 	u32			num_counters;
 	compat_uptr_t		counters;	/* struct xt_counters * */
-	struct compat_ipt_entry	entries[0];
+	struct compat_ipt_entry	entries[];
 };
 
 static int
@@ -1564,7 +1564,7 @@ compat_do_ipt_set_ctl(struct sock *sk,	int cmd, void __user *user,
 struct compat_ipt_get_entries {
 	char name[XT_TABLE_MAXNAMELEN];
 	compat_uint_t size;
-	struct compat_ipt_entry entrytable[0];
+	struct compat_ipt_entry entrytable[];
 };
 
 static int
diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_tables.c
index 41268612bdd4..010a70402828 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -1228,7 +1228,7 @@ struct compat_ip6t_replace {
 	u32			underflow[NF_INET_NUMHOOKS];
 	u32			num_counters;
 	compat_uptr_t		counters;	/* struct xt_counters * */
-	struct compat_ip6t_entry entries[0];
+	struct compat_ip6t_entry entries[];
 };
 
 static int
@@ -1574,7 +1574,7 @@ compat_do_ip6t_set_ctl(struct sock *sk, int cmd, void __user *user,
 struct compat_ip6t_get_entries {
 	char name[XT_TABLE_MAXNAMELEN];
 	compat_uint_t size;
-	struct compat_ip6t_entry entrytable[0];
+	struct compat_ip6t_entry entrytable[];
 };
 
 static int
diff --git a/net/netfilter/ipset/ip_set_bitmap_ip.c b/net/netfilter/ipset/ip_set_bitmap_ip.c
index e758b8120020..8fb170c7327f 100644
--- a/net/netfilter/ipset/ip_set_bitmap_ip.c
+++ b/net/netfilter/ipset/ip_set_bitmap_ip.c
@@ -46,7 +46,7 @@ struct bitmap_ip {
 	u8 netmask;		/* subnet netmask */
 	struct timer_list gc;	/* garbage collection */
 	struct ip_set *set;	/* attached to this ip_set */
-	unsigned char extensions[0]	/* data extensions */
+	unsigned char extensions[]	/* data extensions */
 		__aligned(__alignof__(u64));
 };
 
diff --git a/net/netfilter/ipset/ip_set_bitmap_ipmac.c b/net/netfilter/ipset/ip_set_bitmap_ipmac.c
index ae7cdc0d0f29..ebbcb9a16fe9 100644
--- a/net/netfilter/ipset/ip_set_bitmap_ipmac.c
+++ b/net/netfilter/ipset/ip_set_bitmap_ipmac.c
@@ -49,7 +49,7 @@ struct bitmap_ipmac {
 	size_t memsize;		/* members size */
 	struct timer_list gc;	/* garbage collector */
 	struct ip_set *set;	/* attached to this ip_set */
-	unsigned char extensions[0]	/* MAC + data extensions */
+	unsigned char extensions[]	/* MAC + data extensions */
 		__aligned(__alignof__(u64));
 };
 
diff --git a/net/netfilter/ipset/ip_set_bitmap_port.c b/net/netfilter/ipset/ip_set_bitmap_port.c
index d4a14750f5c4..1993f2783774 100644
--- a/net/netfilter/ipset/ip_set_bitmap_port.c
+++ b/net/netfilter/ipset/ip_set_bitmap_port.c
@@ -37,7 +37,7 @@ struct bitmap_port {
 	size_t memsize;		/* members size */
 	struct timer_list gc;	/* garbage collection */
 	struct ip_set *set;	/* attached to this ip_set */
-	unsigned char extensions[0]	/* data extensions */
+	unsigned char extensions[]	/* data extensions */
 		__aligned(__alignof__(u64));
 };
 
diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
index 4346cae25a4a..30b8b3fad150 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -76,7 +76,7 @@ struct hbucket {
 	DECLARE_BITMAP(used, AHASH_MAX_TUNED);
 	u8 size;		/* size of the array */
 	u8 pos;			/* position of the first free entry */
-	unsigned char value[0]	/* the array of the values */
+	unsigned char value[]	/* the array of the values */
 		__aligned(__alignof__(u64));
 };
 
@@ -109,7 +109,7 @@ struct htable {
 	u8 htable_bits;		/* size of hash table == 2^htable_bits */
 	u32 maxelem;		/* Maxelem per region */
 	struct ip_set_region *hregion;	/* Region locks and ext sizes */
-	struct hbucket __rcu *bucket[0]; /* hashtable buckets */
+	struct hbucket __rcu *bucket[]; /* hashtable buckets */
 };
 
 #define hbucket(h, i)		((h)->bucket[i])
diff --git a/net/netfilter/nfnetlink_acct.c b/net/netfilter/nfnetlink_acct.c
index 4b46421c5e17..ed4bde3c8850 100644
--- a/net/netfilter/nfnetlink_acct.c
+++ b/net/netfilter/nfnetlink_acct.c
@@ -33,7 +33,7 @@ struct nf_acct {
 	refcount_t		refcnt;
 	char			name[NFACCT_NAME_MAX];
 	struct rcu_head		rcu_head;
-	char			data[0];
+	char			data[];
 };
 
 struct nfacct_filter {
diff --git a/net/netfilter/xt_hashlimit.c b/net/netfilter/xt_hashlimit.c
index 8c835ad63729..9c5cfd74a0ee 100644
--- a/net/netfilter/xt_hashlimit.c
+++ b/net/netfilter/xt_hashlimit.c
@@ -132,7 +132,7 @@ struct xt_hashlimit_htable {
 	const char *name;
 	struct net *net;
 
-	struct hlist_head hash[0];	/* hashtable itself */
+	struct hlist_head hash[];	/* hashtable itself */
 };
 
 static int
diff --git a/net/netfilter/xt_recent.c b/net/netfilter/xt_recent.c
index 6fc0deb11aff..dae284e0ed15 100644
--- a/net/netfilter/xt_recent.c
+++ b/net/netfilter/xt_recent.c
@@ -71,7 +71,7 @@ struct recent_entry {
 	u_int8_t		ttl;
 	u_int8_t		index;
 	u_int16_t		nstamps;
-	unsigned long		stamps[0];
+	unsigned long		stamps[];
 };
 
 struct recent_table {
@@ -82,7 +82,7 @@ struct recent_table {
 	unsigned int		entries;
 	u8			nstamps_max_mask;
 	struct list_head	lru_list;
-	struct list_head	iphash[0];
+	struct list_head	iphash[];
 };
 
 struct recent_net {
-- 
2.39.5




