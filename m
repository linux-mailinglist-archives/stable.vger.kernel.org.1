Return-Path: <stable+bounces-42683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D868B7421
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA44285720
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B9B12D215;
	Tue, 30 Apr 2024 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vZTczPeU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C854717592;
	Tue, 30 Apr 2024 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476448; cv=none; b=TCjs6gDyDFAh8DL+l9/6fikh7dVbn2mAGz3jhH+1+p8Laajy8shcGAbGYsh7s9jZZJp+KEAWVrJItVndQhX8klN1OwF5x8SH2owlkbvu5lG+7npza2HfpnxEGvJTDnkbw61U36islmstfX3lZbi6OrtMb770aO5yy7f9ptADMGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476448; c=relaxed/simple;
	bh=k7sA9mUqaHZwHEk/tIAomIKE+9yzsAV+0Ciaa9opk08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHsKfo1f50nADlEjdTlTtAt2lP6rKZ86vVggzwOzIO0L5FMRNfG+N3mgoM0pEdERPjksAqquw9NBK06sAllo6m4FH/fSqDN3hZ6HfW69wEHGi5l+Xfagpk4J+9zZrgwduL8cLAa8On2C9Q3qlRjaS1TWnOsepg9yl+Tr4K0tePg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vZTczPeU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E21C2BBFC;
	Tue, 30 Apr 2024 11:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714476448;
	bh=k7sA9mUqaHZwHEk/tIAomIKE+9yzsAV+0Ciaa9opk08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vZTczPeUDk9kmOYGdLo5r+EJ3SgPqTi0UrPoFoRGfvtYwGRHhB3M2r5lPjDcNgWt2
	 wVmsh8fa41rh8jTGnJcq0vXp5VjO0evXk1gji0A3MURcOYD1sXc+gXVM1/9Sb3CuSi
	 YoJiWSHzOFKZJuVUpWZhnpTFI1ExfJXNMA6RVxtE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonathan Heathcote <jonathan.heathcote@bbc.co.uk>,
	Eric Dumazet <edumazet@google.com>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 035/110] net: fix sk_memory_allocated_{add|sub} vs softirqs
Date: Tue, 30 Apr 2024 12:40:04 +0200
Message-ID: <20240430103048.604954207@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103047.561802595@linuxfoundation.org>
References: <20240430103047.561802595@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 3584718cf2ec7e79b6814f2596dcf398c5fb2eca ]

Jonathan Heathcote reported a regression caused by blamed commit
on aarch64 architecture.

x86 happens to have irq-safe __this_cpu_add_return()
and __this_cpu_sub(), but this is not generic.

I think my confusion came from "struct sock" argument,
because these helpers are called with a locked socket.
But the memory accounting is per-proto (and per-cpu after
the blamed commit). We might cleanup these helpers later
to directly accept a "struct proto *proto" argument.

Switch to this_cpu_add_return() and this_cpu_xchg()
operations, and get rid of preempt_disable()/preempt_enable() pairs.

Fast path becomes a bit faster as a result :)

Many thanks to Jonathan Heathcote for his awesome report and
investigations.

Fixes: 3cd3399dd7a8 ("net: implement per-cpu reserves for memory_allocated")
Reported-by: Jonathan Heathcote <jonathan.heathcote@bbc.co.uk>
Closes: https://lore.kernel.org/netdev/VI1PR01MB42407D7947B2EA448F1E04EFD10D2@VI1PR01MB4240.eurprd01.prod.exchangelabs.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Link: https://lore.kernel.org/r/20240421175248.1692552-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/sock.h | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 6ef6ce43a2edc..77298c74822a6 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1485,32 +1485,34 @@ sk_memory_allocated(const struct sock *sk)
 #define SK_MEMORY_PCPU_RESERVE (1 << (20 - PAGE_SHIFT))
 extern int sysctl_mem_pcpu_rsv;
 
+static inline void proto_memory_pcpu_drain(struct proto *proto)
+{
+	int val = this_cpu_xchg(*proto->per_cpu_fw_alloc, 0);
+
+	if (val)
+		atomic_long_add(val, proto->memory_allocated);
+}
+
 static inline void
-sk_memory_allocated_add(struct sock *sk, int amt)
+sk_memory_allocated_add(const struct sock *sk, int val)
 {
-	int local_reserve;
+	struct proto *proto = sk->sk_prot;
 
-	preempt_disable();
-	local_reserve = __this_cpu_add_return(*sk->sk_prot->per_cpu_fw_alloc, amt);
-	if (local_reserve >= READ_ONCE(sysctl_mem_pcpu_rsv)) {
-		__this_cpu_sub(*sk->sk_prot->per_cpu_fw_alloc, local_reserve);
-		atomic_long_add(local_reserve, sk->sk_prot->memory_allocated);
-	}
-	preempt_enable();
+	val = this_cpu_add_return(*proto->per_cpu_fw_alloc, val);
+
+	if (unlikely(val >= READ_ONCE(sysctl_mem_pcpu_rsv)))
+		proto_memory_pcpu_drain(proto);
 }
 
 static inline void
-sk_memory_allocated_sub(struct sock *sk, int amt)
+sk_memory_allocated_sub(const struct sock *sk, int val)
 {
-	int local_reserve;
+	struct proto *proto = sk->sk_prot;
 
-	preempt_disable();
-	local_reserve = __this_cpu_sub_return(*sk->sk_prot->per_cpu_fw_alloc, amt);
-	if (local_reserve <= -READ_ONCE(sysctl_mem_pcpu_rsv)) {
-		__this_cpu_sub(*sk->sk_prot->per_cpu_fw_alloc, local_reserve);
-		atomic_long_add(local_reserve, sk->sk_prot->memory_allocated);
-	}
-	preempt_enable();
+	val = this_cpu_sub_return(*proto->per_cpu_fw_alloc, val);
+
+	if (unlikely(val <= -READ_ONCE(sysctl_mem_pcpu_rsv)))
+		proto_memory_pcpu_drain(proto);
 }
 
 #define SK_ALLOC_PERCPU_COUNTER_BATCH 16
-- 
2.43.0




