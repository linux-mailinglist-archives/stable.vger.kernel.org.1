Return-Path: <stable+bounces-75282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578B59733DA
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51D84B25B1A
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB9E18E76F;
	Tue, 10 Sep 2024 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lKo/NzVj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577982AF15;
	Tue, 10 Sep 2024 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964279; cv=none; b=R3yFrVvpIm1Ko/cxpQGkvjpDoe+l9QsUJ4JPYO2FVaPLyUs9Ey5+GzBTtp/5cE8nmwAFqt+gja8KagS90rGiWO98Hhflq0bcPM+4juV0tkKUDyiIW4/RsAnh03MrowGTDta1r7sW9SUWpG4v5Zw4GlDqv9KBAZwy57Y8S9AacSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964279; c=relaxed/simple;
	bh=lh1tk/Bd4lHI2GH5FI+2QvTwfm1aXFE4yFQt5VvLyt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJdaeo6JPDHltvcjeEj+1+Yw4rPJTXsqW0hiK8jx6fSc7QnaGel+aeVF1VSOR+Bp5UJLkPfVi4KnLyVBv5/EbSSGwcBTnRVsh+AuS1gZ/+rgwICEZLbe2g1QLAL1iKynHzH+VoImyi4sxlZFIYcCeHfQLibJSxVdFhOtwdRrsZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lKo/NzVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33EAC4CEC3;
	Tue, 10 Sep 2024 10:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725964279;
	bh=lh1tk/Bd4lHI2GH5FI+2QvTwfm1aXFE4yFQt5VvLyt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lKo/NzVj+k9ho5gGjgNUhoDqz2Yvqbb5V4IkdFnDi2z80p0k6mvsYZakGesbrsFvD
	 oaLqygJnKcElJgJEkSijf78bbhaDD3bNDc8jtbQWqNhieQITLjn3RYxmevyqLqQadh
	 2DkWKP7DNA0IaD+kOdWbBvPfBkn3vHU605Khl3PM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Breno Leitao <leitao@debian.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 129/269] net/socket: Break down __sys_getsockopt
Date: Tue, 10 Sep 2024 11:31:56 +0200
Message-ID: <20240910092612.780013150@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
References: <20240910092608.225137854@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 0b05b0cd78c92371fdde6333d006f39eaf9e0860 ]

Split __sys_getsockopt() into two functions by removing the core
logic into a sub-function (do_sock_getsockopt()). This will avoid
code duplication when doing the same operation in other callers, for
instance.

do_sock_getsockopt() will be called by io_uring getsockopt() command
operation in the following patch.

The same was done for the setsockopt pair.

Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://lore.kernel.org/r/20231016134750.1381153-5-leitao@debian.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 33f339a1ba54 ("bpf, net: Fix a potential race in do_sock_getsockopt()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf-cgroup.h |  2 +-
 include/net/sock.h         |  4 +--
 net/core/sock.c            |  8 -----
 net/socket.c               | 64 ++++++++++++++++++++++++--------------
 4 files changed, 44 insertions(+), 34 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index ebfd3c5a776a..2aa82b7aed89 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -379,7 +379,7 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 ({									       \
 	int __ret = 0;							       \
 	if (cgroup_bpf_enabled(CGROUP_GETSOCKOPT))			       \
-		get_user(__ret, optlen);				       \
+		copy_from_sockptr(&__ret, optlen, sizeof(int));		       \
 	__ret;								       \
 })
 
diff --git a/include/net/sock.h b/include/net/sock.h
index bb010cc53b91..2a1aee503848 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1877,11 +1877,11 @@ int sock_setsockopt(struct socket *sock, int level, int op,
 		    sockptr_t optval, unsigned int optlen);
 int do_sock_setsockopt(struct socket *sock, bool compat, int level,
 		       int optname, sockptr_t optval, int optlen);
+int do_sock_getsockopt(struct socket *sock, bool compat, int level,
+		       int optname, sockptr_t optval, sockptr_t optlen);
 
 int sk_getsockopt(struct sock *sk, int level, int optname,
 		  sockptr_t optval, sockptr_t optlen);
-int sock_getsockopt(struct socket *sock, int level, int op,
-		    char __user *optval, int __user *optlen);
 int sock_gettstamp(struct socket *sock, void __user *userstamp,
 		   bool timeval, bool time32);
 struct sk_buff *sock_alloc_send_pskb(struct sock *sk, unsigned long header_len,
diff --git a/net/core/sock.c b/net/core/sock.c
index 55d85d50b3e4..bc2a4e38dcea 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2019,14 +2019,6 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 	return 0;
 }
 
-int sock_getsockopt(struct socket *sock, int level, int optname,
-		    char __user *optval, int __user *optlen)
-{
-	return sk_getsockopt(sock->sk, level, optname,
-			     USER_SOCKPTR(optval),
-			     USER_SOCKPTR(optlen));
-}
-
 /*
  * Initialize an sk_lock.
  *
diff --git a/net/socket.c b/net/socket.c
index aa563fc0cee4..d275f5f14882 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2352,6 +2352,43 @@ SYSCALL_DEFINE5(setsockopt, int, fd, int, level, int, optname,
 INDIRECT_CALLABLE_DECLARE(bool tcp_bpf_bypass_getsockopt(int level,
 							 int optname));
 
+int do_sock_getsockopt(struct socket *sock, bool compat, int level,
+		       int optname, sockptr_t optval, sockptr_t optlen)
+{
+	int max_optlen __maybe_unused;
+	const struct proto_ops *ops;
+	int err;
+
+	err = security_socket_getsockopt(sock, level, optname);
+	if (err)
+		return err;
+
+	if (!compat)
+		max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
+
+	ops = READ_ONCE(sock->ops);
+	if (level == SOL_SOCKET) {
+		err = sk_getsockopt(sock->sk, level, optname, optval, optlen);
+	} else if (unlikely(!ops->getsockopt)) {
+		err = -EOPNOTSUPP;
+	} else {
+		if (WARN_ONCE(optval.is_kernel || optlen.is_kernel,
+			      "Invalid argument type"))
+			return -EOPNOTSUPP;
+
+		err = ops->getsockopt(sock, level, optname, optval.user,
+				      optlen.user);
+	}
+
+	if (!compat)
+		err = BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock->sk, level, optname,
+						     optval, optlen, max_optlen,
+						     err);
+
+	return err;
+}
+EXPORT_SYMBOL(do_sock_getsockopt);
+
 /*
  *	Get a socket option. Because we don't know the option lengths we have
  *	to pass a user mode parameter for the protocols to sort out.
@@ -2359,37 +2396,18 @@ INDIRECT_CALLABLE_DECLARE(bool tcp_bpf_bypass_getsockopt(int level,
 int __sys_getsockopt(int fd, int level, int optname, char __user *optval,
 		int __user *optlen)
 {
-	int max_optlen __maybe_unused;
-	const struct proto_ops *ops;
 	int err, fput_needed;
 	struct socket *sock;
+	bool compat;
 
 	sock = sockfd_lookup_light(fd, &err, &fput_needed);
 	if (!sock)
 		return err;
 
-	err = security_socket_getsockopt(sock, level, optname);
-	if (err)
-		goto out_put;
+	compat = in_compat_syscall();
+	err = do_sock_getsockopt(sock, compat, level, optname,
+				 USER_SOCKPTR(optval), USER_SOCKPTR(optlen));
 
-	if (!in_compat_syscall())
-		max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
-
-	ops = READ_ONCE(sock->ops);
-	if (level == SOL_SOCKET)
-		err = sock_getsockopt(sock, level, optname, optval, optlen);
-	else if (unlikely(!ops->getsockopt))
-		err = -EOPNOTSUPP;
-	else
-		err = ops->getsockopt(sock, level, optname, optval,
-					    optlen);
-
-	if (!in_compat_syscall())
-		err = BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock->sk, level, optname,
-						     USER_SOCKPTR(optval),
-						     USER_SOCKPTR(optlen),
-						     max_optlen, err);
-out_put:
 	fput_light(sock->file, fput_needed);
 	return err;
 }
-- 
2.43.0




