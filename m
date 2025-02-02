Return-Path: <stable+bounces-111948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9D6A24CF8
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 08:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F72A7A3C48
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 07:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80BF1D9A70;
	Sun,  2 Feb 2025 07:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="l6J6yGXu"
X-Original-To: stable@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9751D90AC
	for <stable@vger.kernel.org>; Sun,  2 Feb 2025 07:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738482638; cv=none; b=HL2F2F8FOX7PyXOxiIVrMHdmJBWls4IBd6fh+0C8DvGlv/BK+pyu1sbZLo3NDSsiAqDRn7WLVhzkhEVRpUunJPbAWqJUe9kuY50P+IkkEL5hPrb4sA+WMFZ+tzlsmkDsPTavD4ETiuN+r5d4SiijhUQnROKkIhoTSWRGdpnSVr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738482638; c=relaxed/simple;
	bh=iS5FENTRHCeErs805y4F7W7cpBpY4MI+F+t9xDGefGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYHyof5C1YnTz5q3wrGPlKIp3XIBsjkL5Bbbj5LNa46o9OFiclK1Aqp4rHq9+0JHbzvUeMLQ8fAtFclgTkh9/QvcqtTlCYCqOdkf3h1zv3T1/yeL6eL89su3aRNRxd8T/oxq3JSRhtabCGIZ9ivrTwsF17lmfUXKF+WwRLRGR6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=l6J6yGXu; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 943661C2434
	for <stable@vger.kernel.org>; Sun,  2 Feb 2025 10:50:34 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:to:from:from; s=
	dkim; t=1738482634; x=1739346635; bh=iS5FENTRHCeErs805y4F7W7cpBp
	Y4MI+F+t9xDGefGA=; b=l6J6yGXu6JNqeEBCkvjjk2vaxzbDxxT5Vv5a+1P062H
	TdNBm48jB6LtEN1lE3bDDMx/5WiB+BUdpKsBZIHHMBTZ5h4fKr7YXVzCD5OglaJY
	CNEAfLRKkb9hFdgwUAJtKkP7k2/M7/YTx0TbGpg6NYMRJgxahm5sRBJZN+TMAdIA
	=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JKBhD3FQ1Ehb for <stable@vger.kernel.org>;
	Sun,  2 Feb 2025 10:50:34 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id 6048B1C2418;
	Sun,  2 Feb 2025 10:50:20 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Hou Tao <houtao1@huawei.com>
Subject: [PATCH 6.1 09/16] bpf: Change bpf_mem_cache draining process.
Date: Sun,  2 Feb 2025 07:46:46 +0000
Message-ID: <20250202074709.932174-10-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250202074709.932174-1-sdl@nppct.ru>
References: <20250202074709.932174-1-sdl@nppct.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

commit d114dde245f9115b73756203b03a633a6fc1b36a upstream.

The next patch will introduce cross-cpu llist access and existing
irq_work_sync() + drain_mem_cache() + rcu_barrier_tasks_trace() mechanism will
not be enough, since irq_work_sync() + drain_mem_cache() on cpu A won't
guarantee that llist on cpu A are empty. The free_bulk() on cpu B might add
objects back to llist of cpu A. Add 'bool draining' flag.
The modified sequence looks like:
for_each_cpu:
  WRITE_ONCE(c->draining, true); // do_call_rcu_ttrace() won't be doing call_rcu() any more
  irq_work_sync(); // wait for irq_work callback (free_bulk) to finish
  drain_mem_cache(); // free all objects
rcu_barrier_tasks_trace(); // wait for RCU callbacks to execute

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/bpf/20230706033447.54696-8-alexei.starovoitov@gmail.com
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 kernel/bpf/memalloc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index bbd3fa2bf119..16a57cc4992c 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -98,6 +98,7 @@ struct bpf_mem_cache {
 	int free_cnt;
 	int low_watermark, high_watermark, batch;
 	int percpu_size;
+	bool draining;
 
 	/* list of objects to be freed after RCU tasks trace GP */
 	struct llist_head free_by_rcu_ttrace;
@@ -301,6 +302,12 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 		 * from __free_rcu() and from drain_mem_cache().
 		 */
 		__llist_add(llnode, &c->waiting_for_gp_ttrace);
+
+	if (unlikely(READ_ONCE(c->draining))) {
+		__free_rcu(&c->rcu_ttrace);
+		return;
+	}
+
 	/* Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
 	 * If RCU Tasks Trace grace period implies RCU grace period, free
 	 * these elements directly, else use call_rcu() to wait for normal
@@ -538,15 +545,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 		rcu_in_progress = 0;
 		for_each_possible_cpu(cpu) {
 			c = per_cpu_ptr(ma->cache, cpu);
-			/*
-			 * refill_work may be unfinished for PREEMPT_RT kernel
-			 * in which irq work is invoked in a per-CPU RT thread.
-			 * It is also possible for kernel with
-			 * arch_irq_work_has_interrupt() being false and irq
-			 * work is invoked in timer interrupt. So waiting for
-			 * the completion of irq work to ease the handling of
-			 * concurrency.
-			 */
+			WRITE_ONCE(c->draining, true);
 			irq_work_sync(&c->refill_work);
 			drain_mem_cache(c);
 			rcu_in_progress += atomic_read(&c->call_rcu_ttrace_in_progress);
@@ -562,6 +561,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 			cc = per_cpu_ptr(ma->caches, cpu);
 			for (i = 0; i < NUM_CACHES; i++) {
 				c = &cc->cache[i];
+				WRITE_ONCE(c->draining, true);
 				irq_work_sync(&c->refill_work);
 				drain_mem_cache(c);
 				rcu_in_progress += atomic_read(&c->call_rcu_ttrace_in_progress);
-- 
2.43.0


