Return-Path: <stable+bounces-119531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AED0A445A0
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 17:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D9E16E821
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 16:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2712F18C32C;
	Tue, 25 Feb 2025 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCh2SvmB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC47118C00B
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500024; cv=none; b=SK+6BeOgGWVlh8ppVNtoDHIepkevlfYWo7I9zSdWeO/SROi7ckcPFMNZzzCV6x4/jaGIua8wq41Q1h0cMGrWp+eur+r3RVhlA83e09D3YMrbf8pHkKcs9bV9uLnLfrJZpcZOuMvjxTkEfclX/rVmA4IC9RtPjduPBDEQd1WJjCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500024; c=relaxed/simple;
	bh=bBHOxlcswX/ZeSmEWj2PNYGba3xgTFOhM0AGIjdWGwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LAWC4Z/p+OTQwwU1hZfDLu6GJPFAG9ABDubYtTxz1Y5ChnHjH2lKZ6J2PkwdmwvDdgSjYDa4akInE2/DP3VCAh9hYwKQOZY51auCXu9+KgS+kCispR9kDqxY7HucfOfqgCjMTpTzsj2TuHaY/WIDp/k8M0N6Qc+mQeu4eRhTGH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCh2SvmB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1F4C4CEE6;
	Tue, 25 Feb 2025 16:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740500024;
	bh=bBHOxlcswX/ZeSmEWj2PNYGba3xgTFOhM0AGIjdWGwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QCh2SvmBW0OKE3p4cYr7XgIRsX0xZqX25hywrieA8iD7qF+wlxGEjZn7fqw1YmNVi
	 vskmlZyeR82Ri0n4EO/8Qf87UK9Zt67meyFYMongMOjqcAhvnK2n/GkB/33OVT1iFT
	 aIomIyCOETNMktiyB8gV5BwbYuGboqRRqLnIJVmQIzX8ORHnGPeaNN25adZA2zXqkR
	 8UHP07y8MO2fiSy2BpscNlVSuEwKlljz1rOPvA6vt+5QW/ZrrWzycTtI+qws2ZbbSv
	 guwHXn572B5E1Iej7Q/7zNErSp6G8dHlSB1m0+5yvoRUpkUQKy4rLxnO3ZHtbhNY1Z
	 ELRTS4/bbSQmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	rcn@igalia.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 v2 1/2] net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.
Date: Tue, 25 Feb 2025 11:13:43 -0500
Message-Id: <20250225105824-0afc6ed16b83d039@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250225-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v2-1-bc31173653b4@igalia.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 401cb7dae8130fd34eb84648e02ab4c506df7d5e

WARNING: Author mismatch between patch and upstream commit:
Backport author: =?utf-8?q?Ricardo_Ca=C3=B1uelo_Navarro?=<rcn@igalia.com>
Commit author: Sebastian Andrzej Siewior<bigeasy@linutronix.de>

Found fixes commits:
55e802468e1d sfc: Don't invoke xdp_do_flush() from netpoll.
157f29152b61 netkit: Assign missing bpf_net_context
fecef4cd42c6 tun: Assign missing bpf_net_context.

Note: The patch differs from the upstream commit:
---
1:  401cb7dae8130 ! 1:  936f37f3f2662 net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.
    @@ Metadata
      ## Commit message ##
         net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.
     
    +    [ Upstream commit 401cb7dae8130fd34eb84648e02ab4c506df7d5e ]
    +
         The XDP redirect process is two staged:
         - bpf_prog_run_xdp() is invoked to run a eBPF program which inspects the
           packet and makes decisions. While doing that, the per-CPU variable
    @@ Commit message
         Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
         Link: https://patch.msgid.link/20240620132727.660738-15-bigeasy@linutronix.de
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    [rcn: the backport addresses the differences in
    +    net/core/dev.c:napi_threaded_poll(), busy_poll_stop(), napi_busy_loop()
    +    and net_rx_action() between upstream and stable. This allows the patch
    +    to be applied without bringing additional dependencies, such as
    +    dad6b9770263 ("net: Allow to use SMP threads for backlog NAPI."). These
    +    changes allow applying the patch on stable without bringing the whole
    +    related series.
    +    The rest of the changes are made to adapt context lines and are
    +    unrelated to the purpose of the patch.]
    +    Signed-off-by: Ricardo Cañuelo Navarro <rcn@igalia.com>
     
      ## include/linux/filter.h ##
     @@ include/linux/filter.h: struct bpf_nh_params {
    @@ net/bpf/test_run.c: static int bpf_test_run(struct bpf_prog *prog, void *ctx, u3
     
      ## net/core/dev.c ##
     @@ net/core/dev.c: sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
    + 		   struct net_device *orig_dev, bool *another)
      {
      	struct bpf_mprog_entry *entry = rcu_dereference_bh(skb->dev->tcx_ingress);
    - 	enum skb_drop_reason drop_reason = SKB_DROP_REASON_TC_INGRESS;
     +	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
      	int sch_ret;
      
    @@ net/core/dev.c: sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_
     +		bpf_net_ctx_clear(bpf_net_ctx);
      		return NULL;
      	case TC_ACT_SHOT:
    - 		kfree_skb_reason(skb, drop_reason);
    + 		kfree_skb_reason(skb, SKB_DROP_REASON_TC_INGRESS);
      		*ret = NET_RX_DROP;
     +		bpf_net_ctx_clear(bpf_net_ctx);
      		return NULL;
    @@ net/core/dev.c: sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_
      
      	return skb;
      }
    -@@ net/core/dev.c: sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
    +@@ net/core/dev.c: static __always_inline struct sk_buff *
    + sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
      {
      	struct bpf_mprog_entry *entry = rcu_dereference_bh(dev->tcx_egress);
    - 	enum skb_drop_reason drop_reason = SKB_DROP_REASON_TC_EGRESS;
     +	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
      	int sch_ret;
      
    @@ net/core/dev.c: sch_handle_egress(struct sk_buff *skb, int *ret, struct net_devi
     +		bpf_net_ctx_clear(bpf_net_ctx);
      		return NULL;
      	case TC_ACT_SHOT:
    - 		kfree_skb_reason(skb, drop_reason);
    + 		kfree_skb_reason(skb, SKB_DROP_REASON_TC_EGRESS);
      		*ret = NET_XMIT_DROP;
     +		bpf_net_ctx_clear(bpf_net_ctx);
      		return NULL;
    @@ net/core/dev.c: sch_handle_egress(struct sk_buff *skb, int *ret, struct net_devi
      
      	return skb;
      }
    -@@ net/core/dev.c: enum {
    - static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
    - 			   unsigned flags, u16 budget)
    +@@ net/core/dev.c: static void __busy_poll_stop(struct napi_struct *napi, bool skip_schedule)
    + static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock, bool prefer_busy_poll,
    + 			   u16 budget)
      {
     +	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
      	bool skip_schedule = false;
      	unsigned long timeout;
      	int rc;
    -@@ net/core/dev.c: static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
    +@@ net/core/dev.c: static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock, bool
      	clear_bit(NAPI_STATE_IN_BUSY_POLL, &napi->state);
      
      	local_bh_disable();
     +	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
      
    - 	if (flags & NAPI_F_PREFER_BUSY_POLL) {
    + 	if (prefer_busy_poll) {
      		napi->defer_hard_irqs_count = READ_ONCE(napi->dev->napi_defer_hard_irqs);
    -@@ net/core/dev.c: static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
    +@@ net/core/dev.c: static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock, bool
      	netpoll_poll_unlock(have_poll_lock);
      	if (rc == budget)
      		__busy_poll_stop(napi, skip_schedule);
    @@ net/core/dev.c: static void busy_poll_stop(struct napi_struct *napi, void *have_
      	local_bh_enable();
      }
      
    -@@ net/core/dev.c: static void __napi_busy_loop(unsigned int napi_id,
    +@@ net/core/dev.c: void napi_busy_loop(unsigned int napi_id,
      {
      	unsigned long start_time = loop_end ? busy_loop_current_time() : 0;
      	int (*napi_poll)(struct napi_struct *napi, int budget);
    @@ net/core/dev.c: static void __napi_busy_loop(unsigned int napi_id,
      	void *have_poll_lock = NULL;
      	struct napi_struct *napi;
      
    -@@ net/core/dev.c: static void __napi_busy_loop(unsigned int napi_id,
    +@@ net/core/dev.c: void napi_busy_loop(unsigned int napi_id,
      		int work = 0;
      
      		local_bh_disable();
    @@ net/core/dev.c: static void __napi_busy_loop(unsigned int napi_id,
      		if (!napi_poll) {
      			unsigned long val = READ_ONCE(napi->state);
      
    -@@ net/core/dev.c: static void __napi_busy_loop(unsigned int napi_id,
    +@@ net/core/dev.c: void napi_busy_loop(unsigned int napi_id,
    + 		if (work > 0)
      			__NET_ADD_STATS(dev_net(napi->dev),
      					LINUX_MIB_BUSYPOLLRXPACKETS, work);
    - 		skb_defer_free_flush(this_cpu_ptr(&softnet_data));
     +		bpf_net_ctx_clear(bpf_net_ctx);
      		local_bh_enable();
      
      		if (!loop_end || loop_end(loop_end_arg, start_time))
    -@@ net/core/dev.c: static int napi_thread_wait(struct napi_struct *napi)
    +@@ net/core/dev.c: static void skb_defer_free_flush(struct softnet_data *sd)
      
    - static void napi_threaded_poll_loop(struct napi_struct *napi)
    + static int napi_threaded_poll(void *data)
      {
     +	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
    + 	struct napi_struct *napi = data;
      	struct softnet_data *sd;
    - 	unsigned long last_qs = jiffies;
    - 
    -@@ net/core/dev.c: static void napi_threaded_poll_loop(struct napi_struct *napi)
    - 		void *have;
    - 
    - 		local_bh_disable();
    -+		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
    -+
    - 		sd = this_cpu_ptr(&softnet_data);
    - 		sd->in_napi_threaded_poll = true;
    - 
    -@@ net/core/dev.c: static void napi_threaded_poll_loop(struct napi_struct *napi)
    - 			net_rps_action_and_irq_enable(sd);
    - 		}
    - 		skb_defer_free_flush(sd);
    -+		bpf_net_ctx_clear(bpf_net_ctx);
    - 		local_bh_enable();
    - 
    - 		if (!repoll)
    + 	void *have;
    +@@ net/core/dev.c: static int napi_threaded_poll(void *data)
    + 			bool repoll = false;
    + 
    + 			local_bh_disable();
    ++			bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
    + 			sd = this_cpu_ptr(&softnet_data);
    + 			sd->in_napi_threaded_poll = true;
    + 
    +@@ net/core/dev.c: static int napi_threaded_poll(void *data)
    + 				net_rps_action_and_irq_enable(sd);
    + 			}
    + 			skb_defer_free_flush(sd);
    ++			bpf_net_ctx_clear(bpf_net_ctx);
    + 			local_bh_enable();
    + 
    + 			if (!repoll)
     @@ net/core/dev.c: static __latent_entropy void net_rx_action(struct softirq_action *h)
      	struct softnet_data *sd = this_cpu_ptr(&softnet_data);
      	unsigned long time_limit = jiffies +
    - 		usecs_to_jiffies(READ_ONCE(net_hotdata.netdev_budget_usecs));
    + 		usecs_to_jiffies(READ_ONCE(netdev_budget_usecs));
     +	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
    - 	int budget = READ_ONCE(net_hotdata.netdev_budget);
    + 	int budget = READ_ONCE(netdev_budget);
      	LIST_HEAD(list);
      	LIST_HEAD(repoll);
      
    @@ net/core/filter.c: static const struct bpf_func_proto bpf_clone_redirect_proto =
     -DEFINE_PER_CPU(struct bpf_redirect_info, bpf_redirect_info);
     -EXPORT_PER_CPU_SYMBOL_GPL(bpf_redirect_info);
     -
    - static struct net_device *skb_get_peer_dev(struct net_device *dev)
    - {
    - 	const struct net_device_ops *ops = dev->netdev_ops;
    -@@ net/core/filter.c: static struct net_device *skb_get_peer_dev(struct net_device *dev)
    - 
      int skb_do_redirect(struct sk_buff *skb)
      {
     -	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
    @@ net/core/filter.c: static const struct bpf_func_proto bpf_redirect_peer_proto =
      
      	if (unlikely((plen && plen < sizeof(*params)) || flags))
      		return TC_ACT_SHOT;
    -@@ net/core/filter.c: void xdp_do_check_flushed(struct napi_struct *napi)
    +@@ net/core/filter.c: void xdp_do_flush(void)
      }
    - #endif
    + EXPORT_SYMBOL_GPL(xdp_do_flush);
      
     -void bpf_clear_redirect_map(struct bpf_map *map)
     -{
    @@ net/core/lwt_bpf.c: static inline struct bpf_lwt *bpf_lwt_lwtunnel(struct lwtunn
     +	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
      	int ret;
      
    - 	/* Disabling BH is needed to protect per-CPU bpf_redirect_info between
    - 	 * BPF prog and skb_do_redirect().
    + 	/* Migration disable and BH disable are needed to protect per-cpu
    +@@ net/core/lwt_bpf.c: static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
      	 */
    + 	migrate_disable();
      	local_bh_disable();
     +	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
      	bpf_compute_data_pointers(skb);
    @@ net/core/lwt_bpf.c: static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_p
      
     +	bpf_net_ctx_clear(bpf_net_ctx);
      	local_bh_enable();
    + 	migrate_enable();
      
    - 	return ret;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

