Return-Path: <stable+bounces-145850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51765ABF835
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 16:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13CB4E7378
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9C31E25F8;
	Wed, 21 May 2025 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qy2FSQdP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A851E2307;
	Wed, 21 May 2025 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747838989; cv=none; b=u2cZ2dUdTXhGkFnPQmYYGTbt3EFpwzHRo7ZEunwR7hG2BWsDB7xh9WOUQymWsP+WDJ8/fhbIeCuhjFJUHTdhS68fP1JnkCKCYvI4HbElgngH6+lA54rPT/fShN0rXJkgY5FVTShn6Wkjrg1vQTcKo5MRzNwrIhzZfNRp8Ql23LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747838989; c=relaxed/simple;
	bh=LacymBk3OdyXuOFQL42AbgxdTK7d0Kz4CzSFY4FvTDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdkGvbBjB5pLpqTIMUja+xWH0YrWagKvk49DINeWAUdBrks//AITEsYt35dE+hoAGcG3dSMU5wN2z6oIhmtulECHAmL4DxVDVIAjOS5320VtFRPH0Mni5oZ9BpkF3t+qWKocVvZmTllKQa9dPRaw+e+a5xrnGCP1PBAz+Qp8LUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qy2FSQdP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CB8C4CEEB;
	Wed, 21 May 2025 14:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747838988;
	bh=LacymBk3OdyXuOFQL42AbgxdTK7d0Kz4CzSFY4FvTDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qy2FSQdP+Tghz5uXIboLeO3TFJqmc4W0V2mrFw6Y/R60t+RkNRwH/JOgW5y0CdLeP
	 lbwFHo3V3mc0Y9+WPBd2Sd4p6tYIJEbBVUTDQt/PM+a935XdHc8VqOLs8qweBaXJlv
	 jYaBRpd3AE5aZnMqoLJa7j/e3CFZvT948r6iTJ37wuSlJu8jXv8U57pMda0jjW91oC
	 vZzqmoLdlUApjxW3VIKiSsa4ivbmd5vw/UpLhrZ+3DgTjJlsrp/77At/yAUKF1n0ZH
	 YXDvlP7eTpWHZ9wtg5PIt25lne2GmuBRCqCTGaFy7RfmJZ+O/+RnsxChcKV/f9Bq0D
	 gFTJf4N5e9Qqg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	Rao Shoaib <Rao.Shoaib@oracle.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v6.6 03/26] af_unix: Try to run GC async.
Date: Wed, 21 May 2025 14:45:11 +0000
Message-ID: <20250521144803.2050504-4-lee@kernel.org>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
In-Reply-To: <20250521144803.2050504-1-lee@kernel.org>
References: <20250521144803.2050504-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit d9f21b3613337b55cc9d4a6ead484dca68475143 ]

If more than 16000 inflight AF_UNIX sockets exist and the garbage
collector is not running, unix_(dgram|stream)_sendmsg() call unix_gc().
Also, they wait for unix_gc() to complete.

In unix_gc(), all inflight AF_UNIX sockets are traversed at least once,
and more if they are the GC candidate.  Thus, sendmsg() significantly
slows down with too many inflight AF_UNIX sockets.

However, if a process sends data with no AF_UNIX FD, the sendmsg() call
does not need to wait for GC.  After this change, only the process that
meets the condition below will be blocked under such a situation.

  1) cmsg contains AF_UNIX socket
  2) more than 32 AF_UNIX sent by the same user are still inflight

Note that even a sendmsg() call that does not meet the condition but has
AF_UNIX FD will be blocked later in unix_scm_to_skb() by the spinlock,
but we allow that as a bonus for sane users.

The results below are the time spent in unix_dgram_sendmsg() sending 1
byte of data with no FD 4096 times on a host where 32K inflight AF_UNIX
sockets exist.

Without series: the sane sendmsg() needs to wait gc unreasonably.

  $ sudo /usr/share/bcc/tools/funclatency -p 11165 unix_dgram_sendmsg
  Tracing 1 functions for "unix_dgram_sendmsg"... Hit Ctrl-C to end.
  ^C
       nsecs               : count     distribution
  [...]
      524288 -> 1048575    : 0        |                                        |
     1048576 -> 2097151    : 3881     |****************************************|
     2097152 -> 4194303    : 214      |**                                      |
     4194304 -> 8388607    : 1        |                                        |

  avg = 1825567 nsecs, total: 7477526027 nsecs, count: 4096

With series: the sane sendmsg() can finish much faster.

  $ sudo /usr/share/bcc/tools/funclatency -p 8702  unix_dgram_sendmsg
  Tracing 1 functions for "unix_dgram_sendmsg"... Hit Ctrl-C to end.
  ^C
       nsecs               : count     distribution
  [...]
         128 -> 255        : 0        |                                        |
         256 -> 511        : 4092     |****************************************|
         512 -> 1023       : 2        |                                        |
        1024 -> 2047       : 0        |                                        |
        2048 -> 4095       : 0        |                                        |
        4096 -> 8191       : 1        |                                        |
        8192 -> 16383      : 1        |                                        |

  avg = 410 nsecs, total: 1680510 nsecs, count: 4096

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20240123170856.41348-6-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit d9f21b3613337b55cc9d4a6ead484dca68475143)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 include/net/af_unix.h | 12 ++++++++++--
 include/net/scm.h     |  1 +
 net/core/scm.c        |  5 +++++
 net/unix/af_unix.c    |  6 ++++--
 net/unix/garbage.c    | 10 +++++++++-
 5 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 7a00d7ed527b6..865e2f7bd67cf 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -8,13 +8,21 @@
 #include <linux/refcount.h>
 #include <net/sock.h>
 
+#if IS_ENABLED(CONFIG_UNIX)
+struct unix_sock *unix_get_socket(struct file *filp);
+#else
+static inline struct unix_sock *unix_get_socket(struct file *filp)
+{
+	return NULL;
+}
+#endif
+
 void unix_inflight(struct user_struct *user, struct file *fp);
 void unix_notinflight(struct user_struct *user, struct file *fp);
 void unix_destruct_scm(struct sk_buff *skb);
 void io_uring_destruct_scm(struct sk_buff *skb);
 void unix_gc(void);
-void wait_for_unix_gc(void);
-struct unix_sock *unix_get_socket(struct file *filp);
+void wait_for_unix_gc(struct scm_fp_list *fpl);
 struct sock *unix_peer_get(struct sock *sk);
 
 #define UNIX_HASH_MOD	(256 - 1)
diff --git a/include/net/scm.h b/include/net/scm.h
index e8c76b4be2fe7..1ff6a28550644 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -24,6 +24,7 @@ struct scm_creds {
 
 struct scm_fp_list {
 	short			count;
+	short			count_unix;
 	short			max;
 	struct user_struct	*user;
 	struct file		*fp[SCM_MAX_FD];
diff --git a/net/core/scm.c b/net/core/scm.c
index 737917c7ac627..574607b1c2d96 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -36,6 +36,7 @@
 #include <net/compat.h>
 #include <net/scm.h>
 #include <net/cls_cgroup.h>
+#include <net/af_unix.h>
 
 
 /*
@@ -85,6 +86,7 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 			return -ENOMEM;
 		*fplp = fpl;
 		fpl->count = 0;
+		fpl->count_unix = 0;
 		fpl->max = SCM_MAX_FD;
 		fpl->user = NULL;
 	}
@@ -109,6 +111,9 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 			fput(file);
 			return -EINVAL;
 		}
+		if (unix_get_socket(file))
+			fpl->count_unix++;
+
 		*fpp++ = file;
 		fpl->count++;
 	}
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index ab23c8d72122b..bb92b1ed94aaf 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1885,11 +1885,12 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	long timeo;
 	int err;
 
-	wait_for_unix_gc();
 	err = scm_send(sock, msg, &scm, false);
 	if (err < 0)
 		return err;
 
+	wait_for_unix_gc(scm.fp);
+
 	err = -EOPNOTSUPP;
 	if (msg->msg_flags&MSG_OOB)
 		goto out;
@@ -2157,11 +2158,12 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 	bool fds_sent = false;
 	int data_len;
 
-	wait_for_unix_gc();
 	err = scm_send(sock, msg, &scm, false);
 	if (err < 0)
 		return err;
 
+	wait_for_unix_gc(scm.fp);
+
 	err = -EOPNOTSUPP;
 	if (msg->msg_flags & MSG_OOB) {
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index a2a8543613a52..96cc6b7674333 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -335,8 +335,9 @@ void unix_gc(void)
 }
 
 #define UNIX_INFLIGHT_TRIGGER_GC 16000
+#define UNIX_INFLIGHT_SANE_USER (SCM_MAX_FD * 8)
 
-void wait_for_unix_gc(void)
+void wait_for_unix_gc(struct scm_fp_list *fpl)
 {
 	/* If number of inflight sockets is insane,
 	 * force a garbage collect right now.
@@ -348,6 +349,13 @@ void wait_for_unix_gc(void)
 	    !READ_ONCE(gc_in_progress))
 		unix_gc();
 
+	/* Penalise users who want to send AF_UNIX sockets
+	 * but whose sockets have not been received yet.
+	 */
+	if (!fpl || !fpl->count_unix ||
+	    READ_ONCE(fpl->user->unix_inflight) < UNIX_INFLIGHT_SANE_USER)
+		return;
+
 	if (READ_ONCE(gc_in_progress))
 		flush_work(&unix_gc_work);
 }
-- 
2.49.0.1112.g889b7c5bd8-goog


