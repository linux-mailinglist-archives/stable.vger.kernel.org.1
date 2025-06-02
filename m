Return-Path: <stable+bounces-149525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD451ACB33E
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C791116D40A
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C14221DBD;
	Mon,  2 Jun 2025 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DhLKSf8w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3A42C327E;
	Mon,  2 Jun 2025 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874220; cv=none; b=oppVW/FjAS602l3WJ4Z+kWLWFP2ZPr9XWOhfdiaBJwP7qmtCf3b2KbHg5Z3xEgX+wWpHZeFbwYVKsET22Cjd8tYSzkoNx3AlaSJTTzFcbzG2yRtzYSVoeTwBPpp1NRwJ5IQmXSYOqQ3aDX+eMZjSdtLfHXxd2/yuGFOT7wJOuZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874220; c=relaxed/simple;
	bh=vYXK32JRZfuo1cvsIeSEol1A+a+suxjH0ukM8rxpspw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XswQReabaSkCCL21whyaULywFo9HhgP6X5FsV6y42VCfX9zOJcvhzHQz7A4Lp91dyWEYl8K76nqp2qpJAKuR020hDEi1bOGVqqloKEkkSAmttswueBKMfzeOypvXXQtXnI+38hN6HAcP+kD/CzcaK49g8UkyWcvd40nUqOeowh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DhLKSf8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFE7C4CEEB;
	Mon,  2 Jun 2025 14:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748874220;
	bh=vYXK32JRZfuo1cvsIeSEol1A+a+suxjH0ukM8rxpspw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DhLKSf8wpSVFVwQLR3Uz8MTfVr33nThPD6Zo447vdjgIzj7LytKAoRJBt28ut8zWf
	 EbDYREf4DQpKFMPli2A3TN9iXuY2CKvlcOGrrWh3BMIWPnCjHiMC9H8cZ3mc6L8ZJF
	 1BTPlHRxEkdLndgk9TcXKrSpfYBCMhKeApImHUTM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH 6.6 397/444] af_unix: Try to run GC async.
Date: Mon,  2 Jun 2025 15:47:41 +0200
Message-ID: <20250602134357.021554375@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
References: <20250602134340.906731340@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

commit d9f21b3613337b55cc9d4a6ead484dca68475143 upstream.

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
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/af_unix.h |   12 ++++++++++--
 include/net/scm.h     |    1 +
 net/core/scm.c        |    5 +++++
 net/unix/af_unix.c    |    6 ++++--
 net/unix/garbage.c    |   10 +++++++++-
 5 files changed, 29 insertions(+), 5 deletions(-)

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
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -24,6 +24,7 @@ struct scm_creds {
 
 struct scm_fp_list {
 	short			count;
+	short			count_unix;
 	short			max;
 	struct user_struct	*user;
 	struct file		*fp[SCM_MAX_FD];
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -36,6 +36,7 @@
 #include <net/compat.h>
 #include <net/scm.h>
 #include <net/cls_cgroup.h>
+#include <net/af_unix.h>
 
 
 /*
@@ -85,6 +86,7 @@ static int scm_fp_copy(struct cmsghdr *c
 			return -ENOMEM;
 		*fplp = fpl;
 		fpl->count = 0;
+		fpl->count_unix = 0;
 		fpl->max = SCM_MAX_FD;
 		fpl->user = NULL;
 	}
@@ -109,6 +111,9 @@ static int scm_fp_copy(struct cmsghdr *c
 			fput(file);
 			return -EINVAL;
 		}
+		if (unix_get_socket(file))
+			fpl->count_unix++;
+
 		*fpp++ = file;
 		fpl->count++;
 	}
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1885,11 +1885,12 @@ static int unix_dgram_sendmsg(struct soc
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
@@ -2157,11 +2158,12 @@ static int unix_stream_sendmsg(struct so
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



