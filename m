Return-Path: <stable+bounces-140701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC74DAAAEC3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2053F189D37A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A2D3991BA;
	Mon,  5 May 2025 23:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRzk+bqM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A1338094B;
	Mon,  5 May 2025 23:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486012; cv=none; b=Nr1ApOKs+gdx57WfzAp/lln1Qu3ye5/CfwXFka3oeNBZtU6pgUkbZ2n3tfhNiw/OusHf6CzZ/ESm5nOVZc45ccSqDcE5vYriX8fCA2lTB9CoJp6pf5YRR6O56e92hU8oeVlDFDuyavVJlvTArvqbKKeU2y8agkWMDArw/jLrQOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486012; c=relaxed/simple;
	bh=QQIXp7hbqbjPEumCt3kAXcAYUhfy4oRS2t8Xd1ElWJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oZtqHDBiW2XiFsj8mmnwRhkZCUKkE6k8mMOuiWCORMShgDDdYvXMnVPC8r/k9jf4G7EA0oeXXKO+6jY4EBwXo2PPhJrXtyoF3xc1VLuYP9pp7XLWoBHko5Av2g0dKsqmvuAgxWabjsjXP8Afz56sOZ5V0jB1yO8egPcT0TdapcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRzk+bqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947CAC4CEEF;
	Mon,  5 May 2025 23:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486010;
	bh=QQIXp7hbqbjPEumCt3kAXcAYUhfy4oRS2t8Xd1ElWJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VRzk+bqMARJEkxYl7RfVZFgwuvvFQV63TcQPDMaM8KiGjEkOGJA2AVv5nM6Df+TjG
	 U3FpKhp7om4Rp28Ygwvlp8RJLd5tqVLgzkj4s3l92xetwcjl1Y0/beajDXaKzu5KCs
	 +ICtpS3Tig7snywcfCc5zIdR5+1tTbeg/53uAei/W9XATm/GXuC3EA/YRhNSqwm7V5
	 fUM/hjkCITVd0BhSMMxjkvhols6eqxOpJZP2ZxXODc/rlRgRBRIdS6b6E4DRdJsSAb
	 JkhiFscmgMapzaBoHVeVxU0ObNzWb4BnSUuSMfeqB/0yHEewWqA1r+poeNQlmLADfA
	 cPIbN/pH9zloQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ncardwell@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 108/294] tcp: bring back NUMA dispersion in inet_ehash_locks_alloc()
Date: Mon,  5 May 2025 18:53:28 -0400
Message-Id: <20250505225634.2688578-108-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

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
index 7967ff7e02f79..60e81f6b1c6d4 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -1231,22 +1231,37 @@ int inet_ehash_locks_alloc(struct inet_hashinfo *hashinfo)
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


