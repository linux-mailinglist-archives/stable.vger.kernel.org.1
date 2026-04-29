Return-Path: <stable+bounces-241836-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABk0CIu48WngjwEAu9opvQ
	(envelope-from <stable+bounces-241836-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 09:51:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EC53E490C7A
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 09:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F0D73007A66
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 07:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33151396587;
	Wed, 29 Apr 2026 07:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UCkhjA8J"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F039288AD;
	Wed, 29 Apr 2026 07:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777449093; cv=none; b=LclgiCXPL3LoQEo+VOiwUk2IyVnwJk4Hclh/Fx/wMfxgeri9lzWihh+U+glo0n8B9O5p2tXeZG3AG0W5ZEqEeUqkRwX/s6nYAMpNkSgPuoHFeQ5xdJUS5Uqr74UlNkXc9v3EYPHy75fNDOxZhQb/yOOVzX4MOtwFeB6On5JBpsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777449093; c=relaxed/simple;
	bh=CFZ5uMBKSrGu7JAvCGEzeeRZBxCKOCNIMeeQ3EVVpx0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W2CPD7f+L+UnJHyy8sX4rJ1eIDGFmwp137NaILuFpop0b4/N6Ari5PFvqFdsaKEz26Ba/dndUtN5qd5JlNZFutCC1E/Tu5IZiyzc1S24PaKLUBb0q0Od2YFKCdc+1TpK4kLibLy+hxnXxOo8dh0VTTltCcov1veLBcXaDTjmEnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UCkhjA8J; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Rn
	FBQCpgoJYGqHjOv7EfoGIdH2jJ4SYUqml+NyqGTBA=; b=UCkhjA8JougnFVw925
	5nvkYv13V+JKM9fG+pK8ZxcV/4KEUUtQcNuO2ZoSWa3LqgLBZIIoOV9ZGZCgTJCW
	dVlEmYwHgVLvBTcwHzMpyUrB8TH4FkBsxtfgaIqLe/he/x7m9rFhaNBHaI+J4X0L
	SKp+6Zp3h4AS+3uwET5VOUxMA=
Received: from pek-lpg-core5.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAn3cdJuPFpvSa8CQ--.6606S2;
	Wed, 29 Apr 2026 15:50:34 +0800 (CST)
From: Robert Garcia <rob_garcia@163.com>
To: stable@vger.kernel.org,
	Tung Nguyen <tung.q.nguyen@dektech.com.au>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Robert Garcia <rob_garcia@163.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.15.y] tipc: fix kernel warning when sending SYN message
Date: Wed, 29 Apr 2026 15:50:33 +0800
Message-Id: <20260429075033.234885-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAn3cdJuPFpvSa8CQ--.6606S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF1kAFyfGryruw4fJw13urg_yoW5Xw48pF
	1YgasxAr1rKr4UWa95XF4q9a4Ikan7tFyIg34kKF15urZ0g3ZxtayjqF4UuF18WrZxAFWF
	qanFgF97KF1Fk37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_ku4UUUUUU=
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbC5QoXgmnxuEoUtAAA3w
X-Rspamd-Queue-Id: EC53E490C7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241836-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,davemloft.net,163.com,zeniv.linux.org.uk,vger.kernel.org,lists.sourceforge.net];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob_garcia@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Tung Nguyen <tung.q.nguyen@dektech.com.au>

[ Upstream commit 11a4d6f67cf55883dc78e31c247d1903ed7feccc ]

When sending a SYN message, this kernel stack trace is observed:

...
[   13.396352] RIP: 0010:_copy_from_iter+0xb4/0x550
...
[   13.398494] Call Trace:
[   13.398630]  <TASK>
[   13.398630]  ? __alloc_skb+0xed/0x1a0
[   13.398630]  tipc_msg_build+0x12c/0x670 [tipc]
[   13.398630]  ? shmem_add_to_page_cache.isra.71+0x151/0x290
[   13.398630]  __tipc_sendmsg+0x2d1/0x710 [tipc]
[   13.398630]  ? tipc_connect+0x1d9/0x230 [tipc]
[   13.398630]  ? __local_bh_enable_ip+0x37/0x80
[   13.398630]  tipc_connect+0x1d9/0x230 [tipc]
[   13.398630]  ? __sys_connect+0x9f/0xd0
[   13.398630]  __sys_connect+0x9f/0xd0
[   13.398630]  ? preempt_count_add+0x4d/0xa0
[   13.398630]  ? fpregs_assert_state_consistent+0x22/0x50
[   13.398630]  __x64_sys_connect+0x16/0x20
[   13.398630]  do_syscall_64+0x42/0x90
[   13.398630]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

It is because commit a41dad905e5a ("iov_iter: saner checks for attempt
to copy to/from iterator") has introduced sanity check for copying
from/to iov iterator. Lacking of copy direction from the iterator
viewpoint would lead to kernel stack trace like above.

This commit fixes this issue by initializing the iov iterator with
the correct copy direction when sending SYN or ACK without data.

Fixes: f25dcc7687d4 ("tipc: tipc ->sendmsg() conversion")
Reported-by: syzbot+d43608d061e8847ec9f3@syzkaller.appspotmail.com
Acked-by: Jon Maloy <jmaloy@redhat.com>
Signed-off-by: Tung Nguyen <tung.q.nguyen@dektech.com.au>
Link: https://lore.kernel.org/r/20230214012606.5804-1-tung.q.nguyen@dektech.com.au
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Use WRITE instead of ITER_SOURCE. ]
Signed-off-by: Robert Garcia <rob_garcia@163.com>
---
 net/tipc/socket.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index eccb97b530b7..addf8e107485 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -2616,6 +2616,7 @@ static int tipc_connect(struct socket *sock, struct sockaddr *dest,
 		/* Send a 'SYN-' to destination */
 		m.msg_name = dest;
 		m.msg_namelen = destlen;
+		iov_iter_kvec(&m.msg_iter, WRITE, NULL, 0, 0);
 
 		/* If connect is in non-blocking case, set MSG_DONTWAIT to
 		 * indicate send_msg() is never blocked.
@@ -2778,6 +2779,7 @@ static int tipc_accept(struct socket *sock, struct socket *new_sock, int flags,
 		__skb_queue_head(&new_sk->sk_receive_queue, buf);
 		skb_set_owner_r(buf, new_sk);
 	}
+	iov_iter_kvec(&m.msg_iter, WRITE, NULL, 0, 0);
 	__tipc_sendstream(new_sock, &m, 0);
 	release_sock(new_sk);
 exit:
-- 
2.34.1


