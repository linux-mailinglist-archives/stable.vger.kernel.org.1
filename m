Return-Path: <stable+bounces-118909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 439EEA41E6B
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 13:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC6437A3DC7
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC2F233719;
	Mon, 24 Feb 2025 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XgLpwm8U"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6402D13B7AE
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 12:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398459; cv=none; b=elmCRl4t7Qc83F0sx760u4cUNfrQHf4OnAK6TqVuZjGV0IXN7HNI9VgPWlGzuxOG4R8OD3Z5Ra9P5+JwDuqCn3gwI4nfA0KX80WSz9B6G34Un1WI3or5Ky0W/AeVDORrZO7rqYREy5S8ORtkJvmdNTZfPuksorXBZUG7sk2cops=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398459; c=relaxed/simple;
	bh=L+VjKsiz+6UwPYoxPHJUYz4G+KMCqeBw6KJcXlflQYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D7jzIoeHHT70Sx9daZyQ7gAWm27muvE4zor0UGW+guYhGmbY3+BUotGtBICm+CAgbc7/bsxh+JT6ALzgW3zBTTK6BbA09no8zCyi9h6uGxaFLWWtPEAzqnIwVHVJvtLh0jrfD64b8Iam5PCoCe1RaaO2iPso44BS5GxfRZ/JIDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=XgLpwm8U; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Fv2a9pphyDdE2nV3NZYvMoZ0u2nFnjPkO1k65qW56ls=; b=XgLpwm8Uy4/pa1NqIYCOcE61Kj
	Ph0FIlm77cVg6JYUhNoSREBhQkFpvPnt2lgqGlKPenoDNw3+hE8DS3yBVUUCNbWK/+vuLKlWPzxSe
	JvDdV93uTl6JqyiJOq5qkbOmbFok2F88Wnv2Y9WjUjqufTmE4WEhZFj4tKU12eJx2h6u2WqVJeAN4
	L/WSos7m/DS3OpO8dKOZAdsde5/EMNuw55oUJSsdXhFxwWPlcM0p48IZ+afEuSFsU6v3tzQeb/CXZ
	HfwKb5n+x2jguDj+v3u3fH1Z8KLv8izRo+NK4kjOuyAmPkmf+lCrZwIzDtprb+cphwGOHuLHNH3vj
	Drx2WVKg==;
Received: from 253.red-79-144-234.dynamicip.rima-tde.net ([79.144.234.253] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tmX8Y-00HSyG-SQ; Mon, 24 Feb 2025 13:00:44 +0100
From: =?utf-8?q?Ricardo_Ca=C3=B1uelo_Navarro?= <rcn@igalia.com>
Date: Mon, 24 Feb 2025 13:00:01 +0100
Subject: [PATCH 6.6 1/2] net: Reference bpf_redirect_info via task_struct
 on PREEMPT_RT.
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250224-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v1-1-de5d47556d96@igalia.com>
References: <20250224-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v1-0-de5d47556d96@igalia.com>
In-Reply-To: <20250224-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v1-0-de5d47556d96@igalia.com>
To: stable@vger.kernel.org, bigeasy@linutronix.de
Cc: revest@google.com, kernel-dev@igalia.com
X-Mailer: b4 0.14.2

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 401cb7dae8130fd34eb84648e02ab4c506df7d5e ]

The XDP redirect process is two staged:
- bpf_prog_run_xdp() is invoked to run a eBPF program which inspects the
  packet and makes decisions. While doing that, the per-CPU variable
  bpf_redirect_info is used.

- Afterwards xdp_do_redirect() is invoked and accesses bpf_redirect_info
  and it may also access other per-CPU variables like xskmap_flush_list.

At the very end of the NAPI callback, xdp_do_flush() is invoked which
does not access bpf_redirect_info but will touch the individual per-CPU
lists.

The per-CPU variables are only used in the NAPI callback hence disabling
bottom halves is the only protection mechanism. Users from preemptible
context (like cpu_map_kthread_run()) explicitly disable bottom halves
for protections reasons.
Without locking in local_bh_disable() on PREEMPT_RT this data structure
requires explicit locking.

PREEMPT_RT has forced-threaded interrupts enabled and every
NAPI-callback runs in a thread. If each thread has its own data
structure then locking can be avoided.

Create a struct bpf_net_context which contains struct bpf_redirect_info.
Define the variable on stack, use bpf_net_ctx_set() to save a pointer to
it, bpf_net_ctx_clear() removes it again.
The bpf_net_ctx_set() may nest. For instance a function can be used from
within NET_RX_SOFTIRQ/ net_rx_action which uses bpf_net_ctx_set() and
NET_TX_SOFTIRQ which does not. Therefore only the first invocations
updates the pointer.
Use bpf_net_ctx_get_ri() as a wrapper to retrieve the current struct
bpf_redirect_info. The returned data structure is zero initialized to
ensure nothing is leaked from stack. This is done on first usage of the
struct. bpf_net_ctx_set() sets bpf_redirect_info::kern_flags to 0 to
note that initialisation is required. First invocation of
bpf_net_ctx_get_ri() will memset() the data structure and update
bpf_redirect_info::kern_flags.
bpf_redirect_info::nh is excluded from memset because it is only used
once BPF_F_NEIGH is set which also sets the nh member. The kern_flags is
moved past nh to exclude it from memset.

The pointer to bpf_net_context is saved task's task_struct. Using
always the bpf_net_context approach has the advantage that there is
almost zero differences between PREEMPT_RT and non-PREEMPT_RT builds.

Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://patch.msgid.link/20240620132727.660738-15-bigeasy@linutronix.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/filter.h | 56 +++++++++++++++++++++++++++++++++++++++++---------
 include/linux/sched.h  |  3 +++
 kernel/bpf/cpumap.c    |  3 +++
 kernel/bpf/devmap.c    |  9 +++++++-
 kernel/fork.c          |  1 +
 net/bpf/test_run.c     | 11 +++++++++-
 net/core/dev.c         | 28 ++++++++++++++++++++++++-
 net/core/filter.c      | 41 +++++++++++-------------------------
 net/core/lwt_bpf.c     |  3 +++
 9 files changed, 113 insertions(+), 42 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 5090e940ba3e46fa9cabd8b8bcea08d719b20b51..785addc2786bde5ea9d2ae45177bf4283f5233f4 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -654,21 +654,59 @@ struct bpf_nh_params {
 	};
 };
 
+/* flags for bpf_redirect_info kern_flags */
+#define BPF_RI_F_RF_NO_DIRECT	BIT(0)	/* no napi_direct on return_frame */
+#define BPF_RI_F_RI_INIT	BIT(1)
+
 struct bpf_redirect_info {
 	u64 tgt_index;
 	void *tgt_value;
 	struct bpf_map *map;
 	u32 flags;
-	u32 kern_flags;
 	u32 map_id;
 	enum bpf_map_type map_type;
 	struct bpf_nh_params nh;
+	u32 kern_flags;
 };
 
-DECLARE_PER_CPU(struct bpf_redirect_info, bpf_redirect_info);
+struct bpf_net_context {
+	struct bpf_redirect_info ri;
+};
 
-/* flags for bpf_redirect_info kern_flags */
-#define BPF_RI_F_RF_NO_DIRECT	BIT(0)	/* no napi_direct on return_frame */
+static inline struct bpf_net_context *bpf_net_ctx_set(struct bpf_net_context *bpf_net_ctx)
+{
+	struct task_struct *tsk = current;
+
+	if (tsk->bpf_net_context != NULL)
+		return NULL;
+	bpf_net_ctx->ri.kern_flags = 0;
+
+	tsk->bpf_net_context = bpf_net_ctx;
+	return bpf_net_ctx;
+}
+
+static inline void bpf_net_ctx_clear(struct bpf_net_context *bpf_net_ctx)
+{
+	if (bpf_net_ctx)
+		current->bpf_net_context = NULL;
+}
+
+static inline struct bpf_net_context *bpf_net_ctx_get(void)
+{
+	return current->bpf_net_context;
+}
+
+static inline struct bpf_redirect_info *bpf_net_ctx_get_ri(void)
+{
+	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
+
+	if (!(bpf_net_ctx->ri.kern_flags & BPF_RI_F_RI_INIT)) {
+		memset(&bpf_net_ctx->ri, 0, offsetof(struct bpf_net_context, ri.nh));
+		bpf_net_ctx->ri.kern_flags |= BPF_RI_F_RI_INIT;
+	}
+
+	return &bpf_net_ctx->ri;
+}
 
 /* Compute the linear packet data range [data, data_end) which
  * will be accessed by various program types (cls_bpf, act_bpf,
@@ -929,25 +967,23 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 				       const struct bpf_insn *patch, u32 len);
 int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt);
 
-void bpf_clear_redirect_map(struct bpf_map *map);
-
 static inline bool xdp_return_frame_no_direct(void)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 
 	return ri->kern_flags & BPF_RI_F_RF_NO_DIRECT;
 }
 
 static inline void xdp_set_return_frame_no_direct(void)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 
 	ri->kern_flags |= BPF_RI_F_RF_NO_DIRECT;
 }
 
 static inline void xdp_clear_return_frame_no_direct(void)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 
 	ri->kern_flags &= ~BPF_RI_F_RF_NO_DIRECT;
 }
@@ -1503,7 +1539,7 @@ static __always_inline long __bpf_xdp_redirect_map(struct bpf_map *map, u64 inde
 						   u64 flags, const u64 flag_mask,
 						   void *lookup_elem(struct bpf_map *map, u32 key))
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	const u64 action_mask = XDP_ABORTED | XDP_DROP | XDP_PASS | XDP_TX;
 
 	/* Lower bits of the flags are used as return code on lookup failure */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2af0a8859d6473e1a4b06a64a3fe7f5017447a32..f905d771703aaf4a9957dd589f3337b23a1a8654 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -45,6 +45,7 @@ struct bio_list;
 struct blk_plug;
 struct bpf_local_storage;
 struct bpf_run_ctx;
+struct bpf_net_context;
 struct capture_control;
 struct cfs_rq;
 struct fs_struct;
@@ -1494,6 +1495,8 @@ struct task_struct {
 	/* Used for BPF run context */
 	struct bpf_run_ctx		*bpf_ctx;
 #endif
+	/* Used by BPF for per-TASK xdp storage */
+	struct bpf_net_context		*bpf_net_context;
 
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 	unsigned long			lowest_stack;
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index df03e66a687c1c5629c73e5d096629369b73d831..34700eb6a853bdb3f4b5f8ddae652caf94f54de3 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -239,12 +239,14 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
 				int xdp_n, struct xdp_cpumap_stats *stats,
 				struct list_head *list)
 {
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	int nframes;
 
 	if (!rcpu->prog)
 		return xdp_n;
 
 	rcu_read_lock_bh();
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 
 	nframes = cpu_map_bpf_prog_run_xdp(rcpu, frames, xdp_n, stats);
 
@@ -254,6 +256,7 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
 	if (unlikely(!list_empty(list)))
 		cpu_map_bpf_prog_run_skb(rcpu, list, stats);
 
+	bpf_net_ctx_clear(bpf_net_ctx);
 	rcu_read_unlock_bh(); /* resched point, may call do_softirq() */
 
 	return nframes;
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 5f2356b47b2ddc9aba5680082721bbbadb86bb47..3d8d6d07df73b7b59a102bcfe291d5cf1007f13a 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -196,7 +196,14 @@ static void dev_map_free(struct bpf_map *map)
 	list_del_rcu(&dtab->list);
 	spin_unlock(&dev_map_lock);
 
-	bpf_clear_redirect_map(map);
+	/* bpf_redirect_info->map is assigned in __bpf_xdp_redirect_map()
+	 * during NAPI callback and cleared after the XDP redirect. There is no
+	 * explicit RCU read section which protects bpf_redirect_info->map but
+	 * local_bh_disable() also marks the beginning an RCU section. This
+	 * makes the complete softirq callback RCU protected. Thus after
+	 * following synchronize_rcu() there no bpf_redirect_info->map == map
+	 * assignment.
+	 */
 	synchronize_rcu();
 
 	/* Make sure prior __dev_map_entry_free() have completed. */
diff --git a/kernel/fork.c b/kernel/fork.c
index 23efaa2c42e4f8144310435d929de4edaee9c69f..bb8019683edc809cb84404f4a17baa49967b4936 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2466,6 +2466,7 @@ __latent_entropy struct task_struct *copy_process(
 	RCU_INIT_POINTER(p->bpf_storage, NULL);
 	p->bpf_ctx = NULL;
 #endif
+	p->bpf_net_context =  NULL;
 
 	/* Perform scheduler related setup. Assign this task to a CPU. */
 	retval = sched_fork(clone_flags, p);
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 905de361f8623f90e1594532300d458b3e480a86..ddbbba4861923fa877f07fb8b0c86847771e3392 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -282,9 +282,10 @@ static int xdp_recv_frames(struct xdp_frame **frames, int nframes,
 static int xdp_test_run_batch(struct xdp_test_data *xdp, struct bpf_prog *prog,
 			      u32 repeat)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	int err = 0, act, ret, i, nframes = 0, batch_sz;
 	struct xdp_frame **frames = xdp->frames;
+	struct bpf_redirect_info *ri;
 	struct xdp_page_head *head;
 	struct xdp_frame *frm;
 	bool redirect = false;
@@ -294,6 +295,8 @@ static int xdp_test_run_batch(struct xdp_test_data *xdp, struct bpf_prog *prog,
 	batch_sz = min_t(u32, repeat, xdp->batch_size);
 
 	local_bh_disable();
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
+	ri = bpf_net_ctx_get_ri();
 	xdp_set_return_frame_no_direct();
 
 	for (i = 0; i < batch_sz; i++) {
@@ -358,6 +361,7 @@ static int xdp_test_run_batch(struct xdp_test_data *xdp, struct bpf_prog *prog,
 	}
 
 	xdp_clear_return_frame_no_direct();
+	bpf_net_ctx_clear(bpf_net_ctx);
 	local_bh_enable();
 	return err;
 }
@@ -393,6 +397,7 @@ static int bpf_test_run_xdp_live(struct bpf_prog *prog, struct xdp_buff *ctx,
 static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
 			u32 *retval, u32 *time, bool xdp)
 {
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	struct bpf_prog_array_item item = {.prog = prog};
 	struct bpf_run_ctx *old_ctx;
 	struct bpf_cg_run_ctx run_ctx;
@@ -418,10 +423,14 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
 	do {
 		run_ctx.prog_item = &item;
 		local_bh_disable();
+		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
+
 		if (xdp)
 			*retval = bpf_prog_run_xdp(prog, ctx);
 		else
 			*retval = bpf_prog_run(prog, ctx);
+
+		bpf_net_ctx_clear(bpf_net_ctx);
 		local_bh_enable();
 	} while (bpf_test_timer_continue(&t, 1, repeat, &ret, time));
 	bpf_reset_run_ctx(old_ctx);
diff --git a/net/core/dev.c b/net/core/dev.c
index 479a3892f98c3cc174859e75efd87043cd290fc2..24460c630d3cdfa2490d15969b7ab62b6ce42003 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4019,10 +4019,13 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
 		   struct net_device *orig_dev, bool *another)
 {
 	struct bpf_mprog_entry *entry = rcu_dereference_bh(skb->dev->tcx_ingress);
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	int sch_ret;
 
 	if (!entry)
 		return skb;
+
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 	if (*pt_prev) {
 		*ret = deliver_skb(skb, *pt_prev, orig_dev);
 		*pt_prev = NULL;
@@ -4051,10 +4054,12 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
 			break;
 		}
 		*ret = NET_RX_SUCCESS;
+		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	case TC_ACT_SHOT:
 		kfree_skb_reason(skb, SKB_DROP_REASON_TC_INGRESS);
 		*ret = NET_RX_DROP;
+		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	/* used by tc_run */
 	case TC_ACT_STOLEN:
@@ -4064,8 +4069,10 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
 		fallthrough;
 	case TC_ACT_CONSUMED:
 		*ret = NET_RX_SUCCESS;
+		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	}
+	bpf_net_ctx_clear(bpf_net_ctx);
 
 	return skb;
 }
@@ -4074,11 +4081,14 @@ static __always_inline struct sk_buff *
 sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 {
 	struct bpf_mprog_entry *entry = rcu_dereference_bh(dev->tcx_egress);
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	int sch_ret;
 
 	if (!entry)
 		return skb;
 
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
+
 	/* qdisc_skb_cb(skb)->pkt_len & tcx_set_ingress() was
 	 * already set by the caller.
 	 */
@@ -4094,10 +4104,12 @@ sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 		/* No need to push/pop skb's mac_header here on egress! */
 		skb_do_redirect(skb);
 		*ret = NET_XMIT_SUCCESS;
+		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	case TC_ACT_SHOT:
 		kfree_skb_reason(skb, SKB_DROP_REASON_TC_EGRESS);
 		*ret = NET_XMIT_DROP;
+		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	/* used by tc_run */
 	case TC_ACT_STOLEN:
@@ -4107,8 +4119,10 @@ sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 		fallthrough;
 	case TC_ACT_CONSUMED:
 		*ret = NET_XMIT_SUCCESS;
+		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	}
+	bpf_net_ctx_clear(bpf_net_ctx);
 
 	return skb;
 }
@@ -6211,6 +6225,7 @@ static void __busy_poll_stop(struct napi_struct *napi, bool skip_schedule)
 static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock, bool prefer_busy_poll,
 			   u16 budget)
 {
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	bool skip_schedule = false;
 	unsigned long timeout;
 	int rc;
@@ -6228,6 +6243,7 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock, bool
 	clear_bit(NAPI_STATE_IN_BUSY_POLL, &napi->state);
 
 	local_bh_disable();
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 
 	if (prefer_busy_poll) {
 		napi->defer_hard_irqs_count = READ_ONCE(napi->dev->napi_defer_hard_irqs);
@@ -6250,6 +6266,7 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock, bool
 	netpoll_poll_unlock(have_poll_lock);
 	if (rc == budget)
 		__busy_poll_stop(napi, skip_schedule);
+	bpf_net_ctx_clear(bpf_net_ctx);
 	local_bh_enable();
 }
 
@@ -6259,6 +6276,7 @@ void napi_busy_loop(unsigned int napi_id,
 {
 	unsigned long start_time = loop_end ? busy_loop_current_time() : 0;
 	int (*napi_poll)(struct napi_struct *napi, int budget);
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	void *have_poll_lock = NULL;
 	struct napi_struct *napi;
 
@@ -6277,6 +6295,7 @@ void napi_busy_loop(unsigned int napi_id,
 		int work = 0;
 
 		local_bh_disable();
+		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 		if (!napi_poll) {
 			unsigned long val = READ_ONCE(napi->state);
 
@@ -6306,6 +6325,7 @@ void napi_busy_loop(unsigned int napi_id,
 		if (work > 0)
 			__NET_ADD_STATS(dev_net(napi->dev),
 					LINUX_MIB_BUSYPOLLRXPACKETS, work);
+		bpf_net_ctx_clear(bpf_net_ctx);
 		local_bh_enable();
 
 		if (!loop_end || loop_end(loop_end_arg, start_time))
@@ -6694,6 +6714,7 @@ static void skb_defer_free_flush(struct softnet_data *sd)
 
 static int napi_threaded_poll(void *data)
 {
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	struct napi_struct *napi = data;
 	struct softnet_data *sd;
 	void *have;
@@ -6705,6 +6726,7 @@ static int napi_threaded_poll(void *data)
 			bool repoll = false;
 
 			local_bh_disable();
+			bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 			sd = this_cpu_ptr(&softnet_data);
 			sd->in_napi_threaded_poll = true;
 
@@ -6720,6 +6742,7 @@ static int napi_threaded_poll(void *data)
 				net_rps_action_and_irq_enable(sd);
 			}
 			skb_defer_free_flush(sd);
+			bpf_net_ctx_clear(bpf_net_ctx);
 			local_bh_enable();
 
 			if (!repoll)
@@ -6737,10 +6760,12 @@ static __latent_entropy void net_rx_action(struct softirq_action *h)
 	struct softnet_data *sd = this_cpu_ptr(&softnet_data);
 	unsigned long time_limit = jiffies +
 		usecs_to_jiffies(READ_ONCE(netdev_budget_usecs));
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	int budget = READ_ONCE(netdev_budget);
 	LIST_HEAD(list);
 	LIST_HEAD(repoll);
 
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 start:
 	sd->in_net_rx_action = true;
 	local_irq_disable();
@@ -6793,7 +6818,8 @@ static __latent_entropy void net_rx_action(struct softirq_action *h)
 		sd->in_net_rx_action = false;
 
 	net_rps_action_and_irq_enable(sd);
-end:;
+end:
+	bpf_net_ctx_clear(bpf_net_ctx);
 }
 
 struct netdev_adjacent {
diff --git a/net/core/filter.c b/net/core/filter.c
index 84992279f4b10e5513cbe6a77fc7dbb77271ec4e..7589a6bd852114fe9b52f828f8ce70af3e831a6c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2476,7 +2476,7 @@ EXPORT_PER_CPU_SYMBOL_GPL(bpf_redirect_info);
 
 int skb_do_redirect(struct sk_buff *skb)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	struct net *net = dev_net(skb->dev);
 	struct net_device *dev;
 	u32 flags = ri->flags;
@@ -2512,7 +2512,7 @@ int skb_do_redirect(struct sk_buff *skb)
 
 BPF_CALL_2(bpf_redirect, u32, ifindex, u64, flags)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 
 	if (unlikely(flags & (~(BPF_F_INGRESS) | BPF_F_REDIRECT_INTERNAL)))
 		return TC_ACT_SHOT;
@@ -2533,7 +2533,7 @@ static const struct bpf_func_proto bpf_redirect_proto = {
 
 BPF_CALL_2(bpf_redirect_peer, u32, ifindex, u64, flags)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 
 	if (unlikely(flags))
 		return TC_ACT_SHOT;
@@ -2555,7 +2555,7 @@ static const struct bpf_func_proto bpf_redirect_peer_proto = {
 BPF_CALL_4(bpf_redirect_neigh, u32, ifindex, struct bpf_redir_neigh *, params,
 	   int, plen, u64, flags)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 
 	if (unlikely((plen && plen < sizeof(*params)) || flags))
 		return TC_ACT_SHOT;
@@ -4297,30 +4297,13 @@ void xdp_do_flush(void)
 }
 EXPORT_SYMBOL_GPL(xdp_do_flush);
 
-void bpf_clear_redirect_map(struct bpf_map *map)
-{
-	struct bpf_redirect_info *ri;
-	int cpu;
-
-	for_each_possible_cpu(cpu) {
-		ri = per_cpu_ptr(&bpf_redirect_info, cpu);
-		/* Avoid polluting remote cacheline due to writes if
-		 * not needed. Once we pass this test, we need the
-		 * cmpxchg() to make sure it hasn't been changed in
-		 * the meantime by remote CPU.
-		 */
-		if (unlikely(READ_ONCE(ri->map) == map))
-			cmpxchg(&ri->map, map, NULL);
-	}
-}
-
 DEFINE_STATIC_KEY_FALSE(bpf_master_redirect_enabled_key);
 EXPORT_SYMBOL_GPL(bpf_master_redirect_enabled_key);
 
 u32 xdp_master_redirect(struct xdp_buff *xdp)
 {
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	struct net_device *master, *slave;
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
 
 	master = netdev_master_upper_dev_get_rcu(xdp->rxq->dev);
 	slave = master->netdev_ops->ndo_xdp_get_xmit_slave(master, xdp);
@@ -4392,7 +4375,7 @@ static __always_inline int __xdp_do_redirect_frame(struct bpf_redirect_info *ri,
 			map = READ_ONCE(ri->map);
 
 			/* The map pointer is cleared when the map is being torn
-			 * down by bpf_clear_redirect_map()
+			 * down by dev_map_free()
 			 */
 			if (unlikely(!map)) {
 				err = -ENOENT;
@@ -4437,7 +4420,7 @@ static __always_inline int __xdp_do_redirect_frame(struct bpf_redirect_info *ri,
 int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
 		    struct bpf_prog *xdp_prog)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	enum bpf_map_type map_type = ri->map_type;
 
 	if (map_type == BPF_MAP_TYPE_XSKMAP)
@@ -4451,7 +4434,7 @@ EXPORT_SYMBOL_GPL(xdp_do_redirect);
 int xdp_do_redirect_frame(struct net_device *dev, struct xdp_buff *xdp,
 			  struct xdp_frame *xdpf, struct bpf_prog *xdp_prog)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	enum bpf_map_type map_type = ri->map_type;
 
 	if (map_type == BPF_MAP_TYPE_XSKMAP)
@@ -4468,7 +4451,7 @@ static int xdp_do_generic_redirect_map(struct net_device *dev,
 				       enum bpf_map_type map_type, u32 map_id,
 				       u32 flags)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	struct bpf_map *map;
 	int err;
 
@@ -4480,7 +4463,7 @@ static int xdp_do_generic_redirect_map(struct net_device *dev,
 			map = READ_ONCE(ri->map);
 
 			/* The map pointer is cleared when the map is being torn
-			 * down by bpf_clear_redirect_map()
+			 * down by dev_map_free()
 			 */
 			if (unlikely(!map)) {
 				err = -ENOENT;
@@ -4522,7 +4505,7 @@ static int xdp_do_generic_redirect_map(struct net_device *dev,
 int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
 			    struct xdp_buff *xdp, struct bpf_prog *xdp_prog)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	enum bpf_map_type map_type = ri->map_type;
 	void *fwd = ri->tgt_value;
 	u32 map_id = ri->map_id;
@@ -4558,7 +4541,7 @@ int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
 
 BPF_CALL_2(bpf_xdp_redirect, u32, ifindex, u64, flags)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 
 	if (unlikely(flags))
 		return XDP_ABORTED;
diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index 4a0797f0a154b29ec9d89d1ea7c7461efd4332eb..5350dce2e52d68b1bf133178474230090a856cff 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -38,6 +38,7 @@ static inline struct bpf_lwt *bpf_lwt_lwtunnel(struct lwtunnel_state *lwt)
 static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
 		       struct dst_entry *dst, bool can_redirect)
 {
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	int ret;
 
 	/* Migration disable and BH disable are needed to protect per-cpu
@@ -45,6 +46,7 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
 	 */
 	migrate_disable();
 	local_bh_disable();
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 	bpf_compute_data_pointers(skb);
 	ret = bpf_prog_run_save_cb(lwt->prog, skb);
 
@@ -77,6 +79,7 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
 		break;
 	}
 
+	bpf_net_ctx_clear(bpf_net_ctx);
 	local_bh_enable();
 	migrate_enable();
 

-- 
2.48.1


