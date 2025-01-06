Return-Path: <stable+bounces-107623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B05A02CBA
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BAEC1887B6A
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073D6145A03;
	Mon,  6 Jan 2025 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xqaNpE9q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61DB39FCE;
	Mon,  6 Jan 2025 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736179027; cv=none; b=i1ps4FCI2fu7nMkNDXbg0yTfi9iBm8bumpSOSaW2Nn/5d7QLz0Itv15qzHRIOUECYWYfuI3gIzyso3WvhaCSRh+bG9X1rNK7G3yRROPxtre8iXC2R7Z6iPeY2pvXMA0LWULJV+b2kvdUyZbSdxnZkqSIDyYI2Z3PeYS+p+dlrAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736179027; c=relaxed/simple;
	bh=a18JzMSFTF5PRDP/xI4XCcfp/Ba+pRLl83SXEMXuseQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOXj4ssdHp47WqjmAyZ4au/a964W6Q7UkZyXhUY+jidhnP/cBa1MhlfYg/70/1GRc3+clbGRlwFOUTT8Dpy5XYf5NyB2fVCXSOkU1FB2TjQC2DNEN7iMzVNvfcPdqnwA8M3arZAd3IGC0BU/PyasFiUhSmNBCrLspTDmHptOJ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xqaNpE9q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F1EC4CED2;
	Mon,  6 Jan 2025 15:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736179027;
	bh=a18JzMSFTF5PRDP/xI4XCcfp/Ba+pRLl83SXEMXuseQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xqaNpE9qvOMGUsyD9u37Ol3nh3CiUruQiKpWzgo/yyBztMP1MmApYeJ9EVJ1LRmLR
	 EA6rBFCub2y+ZCtLuBuCWXQOgZ/+E4TaLWzEI8+ixfP8Ch7OWeKT4ghqHmrGQb/SQI
	 RcpAESuCFCsHtAnxSzSs0w6+3rv2QNmQX1q9xg9U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+b3e02953598f447d4d2a@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Martin KaFai Lau <kafai@fb.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 140/168] net: restrict SO_REUSEPORT to inet sockets
Date: Mon,  6 Jan 2025 16:17:28 +0100
Message-ID: <20250106151143.724085509@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151138.451846855@linuxfoundation.org>
References: <20250106151138.451846855@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 5b0af621c3f6ef9261cf6067812f2fd9943acb4b ]

After blamed commit, crypto sockets could accidentally be destroyed
from RCU call back, as spotted by zyzbot [1].

Trying to acquire a mutex in RCU callback is not allowed.

Restrict SO_REUSEPORT socket option to inet sockets.

v1 of this patch supported TCP, UDP and SCTP sockets,
but fcnal-test.sh test needed RAW and ICMP support.

[1]
BUG: sleeping function called from invalid context at kernel/locking/mutex.c:562
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 24, name: ksoftirqd/1
preempt_count: 100, expected: 0
RCU nest depth: 0, expected: 0
1 lock held by ksoftirqd/1/24:
  #0: ffffffff8e937ba0 (rcu_callback){....}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
  #0: ffffffff8e937ba0 (rcu_callback){....}-{0:0}, at: rcu_do_batch kernel/rcu/tree.c:2561 [inline]
  #0: ffffffff8e937ba0 (rcu_callback){....}-{0:0}, at: rcu_core+0xa37/0x17a0 kernel/rcu/tree.c:2823
Preemption disabled at:
 [<ffffffff8161c8c8>] softirq_handle_begin kernel/softirq.c:402 [inline]
 [<ffffffff8161c8c8>] handle_softirqs+0x128/0x9b0 kernel/softirq.c:537
CPU: 1 UID: 0 PID: 24 Comm: ksoftirqd/1 Not tainted 6.13.0-rc3-syzkaller-00174-ga024e377efed #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:94 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
  __might_resched+0x5d4/0x780 kernel/sched/core.c:8758
  __mutex_lock_common kernel/locking/mutex.c:562 [inline]
  __mutex_lock+0x131/0xee0 kernel/locking/mutex.c:735
  crypto_put_default_null_skcipher+0x18/0x70 crypto/crypto_null.c:179
  aead_release+0x3d/0x50 crypto/algif_aead.c:489
  alg_do_release crypto/af_alg.c:118 [inline]
  alg_sock_destruct+0x86/0xc0 crypto/af_alg.c:502
  __sk_destruct+0x58/0x5f0 net/core/sock.c:2260
  rcu_do_batch kernel/rcu/tree.c:2567 [inline]
  rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
  handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
  run_ksoftirqd+0xca/0x130 kernel/softirq.c:950
  smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
  kthread+0x2f0/0x390 kernel/kthread.c:389
  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Fixes: 8c7138b33e5c ("net: Unpublish sk from sk_reuseport_cb before call_rcu")
Reported-by: syzbot+b3e02953598f447d4d2a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6772f2f4.050a0220.2f3838.04cb.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://patch.msgid.link/20241231160527.3994168-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 046943b6efb1..dce2bf8dfd1d 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -994,7 +994,10 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 		sk->sk_reuse = (valbool ? SK_CAN_REUSE : SK_NO_REUSE);
 		break;
 	case SO_REUSEPORT:
-		sk->sk_reuseport = valbool;
+		if (valbool && !sk_is_inet(sk))
+			ret = -EOPNOTSUPP;
+		else
+			sk->sk_reuseport = valbool;
 		break;
 	case SO_TYPE:
 	case SO_PROTOCOL:
-- 
2.39.5




