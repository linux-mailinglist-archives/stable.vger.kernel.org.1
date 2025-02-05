Return-Path: <stable+bounces-113095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0779A28FF0
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E647D167C74
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBF215CD4A;
	Wed,  5 Feb 2025 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a3GR9hJe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFB1155747;
	Wed,  5 Feb 2025 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738765808; cv=none; b=YO6nJvu5umTyT5bvz/QjL+6ZpDf+P1M0FhpBuOpNZ6rTTd+Zt5AmRCki3UkBg4XtAxjArKHUArgSXIQ8C9tRi81OEsHR5SC8xFPsves2qWOQDgVx5ZW0B8LhiBbppgPoAvXNG8wsLZjlvKMOV0M5UAv7pnEW7bO51T1YTDFmd38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738765808; c=relaxed/simple;
	bh=A03w15yO+Jjq43wJ1g936j41g7mQBlgQfO+SGG4P4n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZ5pIjcOKFPF8JXsIXkjHkWHO0dbK0lZAfu56dRqeHw5aJZSB3lqLVhCXefquQgQ087uQkIrJUYxYhzLXh1iPViCWXf60LsNcTloYbMFvY4pvGUeYqfsePzCr9jpMfgb0spBSRsFmelKH7ElaNNUesSVZy9Hb02g+O5wRKWZ2Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a3GR9hJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5E8C4CED1;
	Wed,  5 Feb 2025 14:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738765807;
	bh=A03w15yO+Jjq43wJ1g936j41g7mQBlgQfO+SGG4P4n8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a3GR9hJeY20nc3NlDDLSM7TBBoASx+NGEqA86UVFujJjQ1/X7ZPi0BQg9LUeTjkkK
	 wAw1DMyznxkeIo5dM8WxUaoQ8dJ9/GiNtO5TyaimCQio3jVpkdv51xJE1h9b2QRAhI
	 CTOrVuk3PFPqQ8vt74PcdF7SkLsQTJ2mvSLVyOdc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 257/590] bpf: bpf_local_storage: Always use bpf_mem_alloc in PREEMPT_RT
Date: Wed,  5 Feb 2025 14:40:12 +0100
Message-ID: <20250205134505.111624331@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin KaFai Lau <martin.lau@kernel.org>

[ Upstream commit 8eef6ac4d70eb1f0099fff93321d90ce8fa49ee1 ]

In PREEMPT_RT, kmalloc(GFP_ATOMIC) is still not safe in non preemptible
context. bpf_mem_alloc must be used in PREEMPT_RT. This patch is
to enforce bpf_mem_alloc in the bpf_local_storage when CONFIG_PREEMPT_RT
is enabled.

[   35.118559] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
[   35.118566] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1832, name: test_progs
[   35.118569] preempt_count: 1, expected: 0
[   35.118571] RCU nest depth: 1, expected: 1
[   35.118577] INFO: lockdep is turned off.
    ...
[   35.118647]  __might_resched+0x433/0x5b0
[   35.118677]  rt_spin_lock+0xc3/0x290
[   35.118700]  ___slab_alloc+0x72/0xc40
[   35.118723]  __kmalloc_noprof+0x13f/0x4e0
[   35.118732]  bpf_map_kzalloc+0xe5/0x220
[   35.118740]  bpf_selem_alloc+0x1d2/0x7b0
[   35.118755]  bpf_local_storage_update+0x2fa/0x8b0
[   35.118784]  bpf_sk_storage_get_tracing+0x15a/0x1d0
[   35.118791]  bpf_prog_9a118d86fca78ebb_trace_inet_sock_set_state+0x44/0x66
[   35.118795]  bpf_trace_run3+0x222/0x400
[   35.118820]  __bpf_trace_inet_sock_set_state+0x11/0x20
[   35.118824]  trace_inet_sock_set_state+0x112/0x130
[   35.118830]  inet_sk_state_store+0x41/0x90
[   35.118836]  tcp_set_state+0x3b3/0x640

There is no need to adjust the gfp_flags passing to the
bpf_mem_cache_alloc_flags() which only honors the GFP_KERNEL.
The verifier has ensured GFP_KERNEL is passed only in sleepable context.

It has been an old issue since the first introduction of the
bpf_local_storage ~5 years ago, so this patch targets the bpf-next.

bpf_mem_alloc is needed to solve it, so the Fixes tag is set
to the commit when bpf_mem_alloc was first used in the bpf_local_storage.

Fixes: 08a7ce384e33 ("bpf: Use bpf_mem_cache_alloc/free in bpf_local_storage_elem")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://lore.kernel.org/r/20241218193000.2084281-1-martin.lau@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/bpf_local_storage.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index c938dea5ddbf3..050c784498abe 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -797,8 +797,12 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 	smap->elem_size = offsetof(struct bpf_local_storage_elem,
 				   sdata.data[attr->value_size]);
 
-	smap->bpf_ma = bpf_ma;
-	if (bpf_ma) {
+	/* In PREEMPT_RT, kmalloc(GFP_ATOMIC) is still not safe in non
+	 * preemptible context. Thus, enforce all storages to use
+	 * bpf_mem_alloc when CONFIG_PREEMPT_RT is enabled.
+	 */
+	smap->bpf_ma = IS_ENABLED(CONFIG_PREEMPT_RT) ? true : bpf_ma;
+	if (smap->bpf_ma) {
 		err = bpf_mem_alloc_init(&smap->selem_ma, smap->elem_size, false);
 		if (err)
 			goto free_smap;
-- 
2.39.5




