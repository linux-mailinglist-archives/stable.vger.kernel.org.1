Return-Path: <stable+bounces-149936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66304ACB5BB
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07BF99E2C0C
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5290232376;
	Mon,  2 Jun 2025 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J/hj2pkq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944DA231A37;
	Mon,  2 Jun 2025 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875511; cv=none; b=iywhIztRmWktp3FLLW0ym2Uw7HxYZ7ABBbP+7GrUZFbOzL6/sO+nD6PnznstIynfNqZJ3E0idujBGlzvR7EhDEoUl6CFjM2D3qhysSw1JEKqt1s0DGDEr1MSba7R1V6P+RI/lSl/mXPjJ/OMIPPGFTm68j2owTc4DZ6zoxCM0No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875511; c=relaxed/simple;
	bh=AX2ggif2TSLMwSWR8DHyWJsk/NxoMvcaccOVOaMpfBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpAJkkMUlE978vAmFPTTPOGqEDdIX04j6zznmSor/3jUUIJdeqbn0akqUXo3FcspyEet6MrCZsvHmSBpIKpTVUoz34cJUsBt/tdoh8KM2XH15SkAdzHpv+2CljT9pTmkKz/4HgfHwxKVAKd/6eG9J4h62U7AxiZVC9qWB5gcknE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J/hj2pkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBF6C4CEEB;
	Mon,  2 Jun 2025 14:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748875511;
	bh=AX2ggif2TSLMwSWR8DHyWJsk/NxoMvcaccOVOaMpfBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J/hj2pkqFTHH/jqswuNV6CtSyFwLW3EAPcOvhiXqOWW3wjMz5khtt3FcRpn1Hg816
	 izfqKfiJPORLG6KO5Ie3rLoLigh9zjhRJiz4yH1bYkgQZhhOYOueh/iiPDDlx9Bj7N
	 0cIjcyfoREkp9vC5n8qBrL1t8DiTQuQeWC8qxxS8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 156/270] tcp: bring back NUMA dispersion in inet_ehash_locks_alloc()
Date: Mon,  2 Jun 2025 15:47:21 +0200
Message-ID: <20250602134313.593319924@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134307.195171844@linuxfoundation.org>
References: <20250602134307.195171844@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 0fb5d758264fe..fea74ab2a4bec 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -934,22 +934,37 @@ int inet_ehash_locks_alloc(struct inet_hashinfo *hashinfo)
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




