Return-Path: <stable+bounces-150357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D054ACB6E6
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03F281C238A5
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964DE22ACD1;
	Mon,  2 Jun 2025 15:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VZQiMGaD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B1422A7EF;
	Mon,  2 Jun 2025 15:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876865; cv=none; b=pd6d3ch0NDIRHJMnaGGTkzHCxOoqidmcB2Wn6J3U52UB+7XSq/DbYp0PkeGEQjK+wl5GpDjQJ46u2HIq+QaY/R2rxgiQqIcuRe9RGUY8tcrscFFrSumZOR0U8RJAKA04HIckwuh81m8W1d3dBAU2P536RL7RsNEUYZflelH4Rkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876865; c=relaxed/simple;
	bh=B4uVyAdUdi/NOffxVqWGtZlLl/8Ab70jI2MjsK5X4Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rRxw6F3f1boxcxGtNw8ebXKRk0tSTevowK2qehDliUBJGYU77j5sU+gMWK2jMpXO9NGGGyIWOA1fOisa+DsavwXUvPFG2nw4XTKpBwIztvT9HfVcdlzd5uGJ0LbwukagEEVNZ9kO/MDlZw7IuwREIjgKn7yISqe32A2dMIe/FoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VZQiMGaD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77AAC4CEEE;
	Mon,  2 Jun 2025 15:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748876865;
	bh=B4uVyAdUdi/NOffxVqWGtZlLl/8Ab70jI2MjsK5X4Is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VZQiMGaDCAsAuBlxhrqJvXPQroaGC7hFjFSU0Ip3DjXB7Y0h3c41VdHS8qyJwDEpa
	 2eUoTAq5dZn88RMU4l1P3Le6WOAwsakpitYTmdVRXMPJnNDV5D07Tua5xe9JQdTEvU
	 zwMM2AKJgJvbSamrC+LBY9ZFgqsWOEGszJPec0BU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 098/325] tcp: bring back NUMA dispersion in inet_ehash_locks_alloc()
Date: Mon,  2 Jun 2025 15:46:14 +0200
Message-ID: <20250602134323.766608208@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134319.723650984@linuxfoundation.org>
References: <20250602134319.723650984@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit f8ece40786c9342249aa0a1b55e148ee23b2a746 ]

We have platforms with 6 NUMA nodes and 480 cpus.

inet_ehash_locks_alloc() currently allocates a single 64KB page
to hold all ehash spinlocks. This adds more pressure on a single node.

Change inet_ehash_locks_alloc() to use vmalloc() to spread
the spinlocks on all online nodes, driven by NUMA policies.

At boot time, NUMA policy is interleave=all, meaning that
tcp_hashinfo.ehash_locks gets hash dispersion on all nodes.

Tested:

lack5:~# grep inet_ehash_locks_alloc /proc/vmallocinfo
0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_locks_alloc+0x90/0x100 pages=16 vmalloc N0=2 N1=3 N2=3 N3=3 N4=3 N5=2

lack5:~# echo 8192 >/proc/sys/net/ipv4/tcp_child_ehash_entries
lack5:~# numactl --interleave=all unshare -n bash -c "grep inet_ehash_locks_alloc /proc/vmallocinfo"
0x000000004e99d30c-0x00000000763f3279   36864 inet_ehash_locks_alloc+0x90/0x100 pages=8 vmalloc N0=1 N1=2 N2=2 N3=1 N4=1 N5=1
0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_locks_alloc+0x90/0x100 pages=16 vmalloc N0=2 N1=3 N2=3 N3=3 N4=3 N5=2

lack5:~# numactl --interleave=0,5 unshare -n bash -c "grep inet_ehash_locks_alloc /proc/vmallocinfo"
0x00000000fd73a33e-0x0000000004b9a177   36864 inet_ehash_locks_alloc+0x90/0x100 pages=8 vmalloc N0=4 N5=4
0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_locks_alloc+0x90/0x100 pages=16 vmalloc N0=2 N1=3 N2=3 N3=3 N4=3 N5=2

lack5:~# echo 1024 >/proc/sys/net/ipv4/tcp_child_ehash_entries
lack5:~# numactl --interleave=all unshare -n bash -c "grep inet_ehash_locks_alloc /proc/vmallocinfo"
0x00000000db07d7a2-0x00000000ad697d29    8192 inet_ehash_locks_alloc+0x90/0x100 pages=1 vmalloc N2=1
0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_locks_alloc+0x90/0x100 pages=16 vmalloc N0=2 N1=3 N2=3 N3=3 N4=3 N5=2

Signed-off-by: Eric Dumazet <edumazet@google.com>
Tested-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://patch.msgid.link/20250305130550.1865988-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/inet_hashtables.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 321f509f23473..5e7cdcebd64f8 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -1218,22 +1218,37 @@ int inet_ehash_locks_alloc(struct inet_hashinfo *hashinfo)
 {
 	unsigned int locksz = sizeof(spinlock_t);
 	unsigned int i, nblocks = 1;
+	spinlock_t *ptr = NULL;
 
-	if (locksz != 0) {
-		/* allocate 2 cache lines or at least one spinlock per cpu */
-		nblocks = max(2U * L1_CACHE_BYTES / locksz, 1U);
-		nblocks = roundup_pow_of_two(nblocks * num_possible_cpus());
+	if (locksz == 0)
+		goto set_mask;
 
-		/* no more locks than number of hash buckets */
-		nblocks = min(nblocks, hashinfo->ehash_mask + 1);
+	/* Allocate 2 cache lines or at least one spinlock per cpu. */
+	nblocks = max(2U * L1_CACHE_BYTES / locksz, 1U) * num_possible_cpus();
 
-		hashinfo->ehash_locks = kvmalloc_array(nblocks, locksz, GFP_KERNEL);
-		if (!hashinfo->ehash_locks)
-			return -ENOMEM;
+	/* At least one page per NUMA node. */
+	nblocks = max(nblocks, num_online_nodes() * PAGE_SIZE / locksz);
+
+	nblocks = roundup_pow_of_two(nblocks);
+
+	/* No more locks than number of hash buckets. */
+	nblocks = min(nblocks, hashinfo->ehash_mask + 1);
 
-		for (i = 0; i < nblocks; i++)
-			spin_lock_init(&hashinfo->ehash_locks[i]);
+	if (num_online_nodes() > 1) {
+		/* Use vmalloc() to allow NUMA policy to spread pages
+		 * on all available nodes if desired.
+		 */
+		ptr = vmalloc_array(nblocks, locksz);
+	}
+	if (!ptr) {
+		ptr = kvmalloc_array(nblocks, locksz, GFP_KERNEL);
+		if (!ptr)
+			return -ENOMEM;
 	}
+	for (i = 0; i < nblocks; i++)
+		spin_lock_init(&ptr[i]);
+	hashinfo->ehash_locks = ptr;
+set_mask:
 	hashinfo->ehash_locks_mask = nblocks - 1;
 	return 0;
 }
-- 
2.39.5




