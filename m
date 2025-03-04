Return-Path: <stable+bounces-120199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0DAA4D1DF
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 04:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED88B1895158
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 03:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C592D18A6D4;
	Tue,  4 Mar 2025 03:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="r0VeZ6e7"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E6115CD46;
	Tue,  4 Mar 2025 03:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741057350; cv=none; b=JXXKYpOG83AkLtFYlmNQwtIb4X7dBlRzX3nI2QDRQFymsfZq/foGW+nZk5icxUe0ZHlrevGQspmT1ZpRrwdwKsXAYO+g7eUDGwU+jBs26m9aoregHhefn7LJy14/SYFJVjzJN/k+BqFdMI7XgCfEbKt1pOz3y66uGWLdVDtE/wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741057350; c=relaxed/simple;
	bh=jhtUwae5t31G2OBfai1QRLwyF8+nzgoh14a+TSS25dY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XfUquJWuthzoJJ+RZiDTvMmnojE41jhR/jCIZRYzfGZbd+8xDbjviqdjyHzpTgtmfxfUFboV8y3UgOtkd2Uh7CL9g/rL2Z+2AMktLQy937wf21W69QRoKsBIdypfLhDfygeZ8UTX924F4DjAU1utTvHPNyFR4uRWSIi48M+KFJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=r0VeZ6e7; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741057349; x=1772593349;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/OEAcRSkJZfV4Q28pUHxvrsDryz1R9qQDAfgB1t/ZTg=;
  b=r0VeZ6e7Ju6HvVTRa5NHI44J9nOwT1gVEZ9KTjk3C3W1B2yC3aPIaVed
   THGz0LHA48hbJRCrq3UUrBiMFUFXf0uQe8YuD63GnBRPx3dWinxtFbzR1
   /tCAYYgF1WzgaY5m1Aqq49AbVFo4FnN4wSbXTXq/2JSJU3tZr4uNBCLHh
   A=;
X-IronPort-AV: E=Sophos;i="6.13,331,1732579200"; 
   d="scan'208";a="471729838"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 03:02:25 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:24866]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.238:2525] with esmtp (Farcaster)
 id 203de75f-fc09-432f-a81b-2a0dbf886bfe; Tue, 4 Mar 2025 03:02:11 +0000 (UTC)
X-Farcaster-Flow-ID: 203de75f-fc09-432f-a81b-2a0dbf886bfe
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 4 Mar 2025 03:02:10 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 4 Mar 2025 03:02:08 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<sashal@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <stable@vger.kernel.org>, <netdev@vger.kernel.org>,
	"Lei Lu" <llfamsec@gmail.com>
Subject: [PATCH stable 5.15/6.1/6.6] af_unix: Clear oob_skb in scan_inflight().
Date: Mon, 3 Mar 2025 19:01:49 -0800
Message-ID: <20250304030149.82265-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Embryo socket is not queued in gc_candidates, so we can't drop
a reference held by its oob_skb.

Let's say we create listener and embryo sockets, send the
listener's fd to the embryo as OOB data, and close() them
without recv()ing the OOB data.

There is a self-reference cycle like

  listener -> embryo.oob_skb -> listener

, so this must be cleaned up by GC.  Otherwise, the listener's
refcnt is not released and sockets are leaked:

  # unshare -n
  # cat /proc/net/protocols | grep UNIX-STREAM
  UNIX-STREAM 1024      0      -1   NI       0   yes  kernel ...

  # python3
  >>> from array import array
  >>> from socket import *
  >>>
  >>> s = socket(AF_UNIX, SOCK_STREAM)
  >>> s.bind('\0test\0')
  >>> s.listen()
  >>>
  >>> c = socket(AF_UNIX, SOCK_STREAM)
  >>> c.connect(s.getsockname())
  >>> c.sendmsg([b'x'], [(SOL_SOCKET, SCM_RIGHTS, array('i', [s.fileno()]))], MSG_OOB)
  1
  >>> quit()

  # cat /proc/net/protocols | grep UNIX-STREAM
  UNIX-STREAM 1024      3      -1   NI       0   yes  kernel ...
                        ^^^
                        3 sockets still in use after FDs are close()d

Let's drop the embryo socket's oob_skb ref in scan_inflight().

This also fixes a racy access to oob_skb that commit 9841991a446c
("af_unix: Update unix_sk(sk)->oob_skb under sk_receive_queue
lock.") fixed for the new Tarjan's algo-based GC.

Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Reported-by: Lei Lu <llfamsec@gmail.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
This has no upstream commit because I replaced the entire GC in
6.10 and the new GC does not have this bug, and this fix is only
applicable to the old GC (<= 6.9), thus for 5.15/6.1/6.6.
---
---
 net/unix/garbage.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 2a758531e102..b3fbdf129944 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -102,13 +102,14 @@ static void scan_inflight(struct sock *x, void (*func)(struct unix_sock *),
 			/* Process the descriptors of this socket */
 			int nfd = UNIXCB(skb).fp->count;
 			struct file **fp = UNIXCB(skb).fp->fp;
+			struct unix_sock *u;
 
 			while (nfd--) {
 				/* Get the socket the fd matches if it indeed does so */
 				struct sock *sk = unix_get_socket(*fp++);
 
 				if (sk) {
-					struct unix_sock *u = unix_sk(sk);
+					u = unix_sk(sk);
 
 					/* Ignore non-candidates, they could
 					 * have been added to the queues after
@@ -122,6 +123,13 @@ static void scan_inflight(struct sock *x, void (*func)(struct unix_sock *),
 				}
 			}
 			if (hit && hitlist != NULL) {
+#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+				u = unix_sk(x);
+				if (u->oob_skb) {
+					WARN_ON_ONCE(skb_unref(u->oob_skb));
+					u->oob_skb = NULL;
+				}
+#endif
 				__skb_unlink(skb, &x->sk_receive_queue);
 				__skb_queue_tail(hitlist, skb);
 			}
@@ -299,17 +307,9 @@ void unix_gc(void)
 	 * which are creating the cycle(s).
 	 */
 	skb_queue_head_init(&hitlist);
-	list_for_each_entry(u, &gc_candidates, link) {
+	list_for_each_entry(u, &gc_candidates, link)
 		scan_children(&u->sk, inc_inflight, &hitlist);
 
-#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
-		if (u->oob_skb) {
-			kfree_skb(u->oob_skb);
-			u->oob_skb = NULL;
-		}
-#endif
-	}
-
 	/* not_cycle_list contains those sockets which do not make up a
 	 * cycle.  Restore these to the inflight list.
 	 */
-- 
2.39.5 (Apple Git-154)


