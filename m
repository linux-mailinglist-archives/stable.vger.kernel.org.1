Return-Path: <stable+bounces-180052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 183D5B7E81D
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54CEF527B9F
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128313233E1;
	Wed, 17 Sep 2025 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g2Er3XUX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C274931A7F6;
	Wed, 17 Sep 2025 12:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113227; cv=none; b=hcPg814DlaFK1Y1Ixla7JMNxSPMFrrhOg+LGGkLhavqTuVddtuTcJv+4cZIeheSbDLmlMKGMB61fI4Cu5mkSX9+IuvRFWrmPIq13KZK/XCBHo+jJy9EKT0n7jTnCGDukewlpdij9cmHIq4/jAFN9vnjP/l3gdHCthCGl20/EuLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113227; c=relaxed/simple;
	bh=Jl0jriY7xCVaO+gaCbHaLzRpNsNtsJPKxSTtNbx2IUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmgGOyNPilZQdMoKn6Q2oP/rPW1ioQ8+0zZ3gkYdRGqVfGO44PsgYPGy8IypVKajmraDGgABf2illgG+oS/0/dvqrdBI2kSttwQVaYvNW83kNnSPBd74CI/nyT1MsMesRjUq5pvzF65obVu8CW9WGz48TcZV0Wcvk5sI4zfITK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g2Er3XUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32213C4CEF0;
	Wed, 17 Sep 2025 12:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758113227;
	bh=Jl0jriY7xCVaO+gaCbHaLzRpNsNtsJPKxSTtNbx2IUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g2Er3XUXsbZIoKCJHrZJpzNF+xbXaGvVgPiBZo9+ukI0nBzsfo0/OlIlE+seinGwZ
	 72EbEGCC5d0atk5j4FaQ/kejUC6ydbePmcXumHvFuCWCtH8MKpQv0LIuZpKr/n0iZ0
	 jSmyVjosDqDPYz6HZz6pPgn1h1BkSakN/PZjlgiU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Justin Worrell <jworrell@gmail.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>,
	Scott Mayhew <smayhew@redhat.com>
Subject: [PATCH 6.12 021/140] SUNRPC: call xs_sock_process_cmsg for all cmsg
Date: Wed, 17 Sep 2025 14:33:13 +0200
Message-ID: <20250917123344.827173784@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123344.315037637@linuxfoundation.org>
References: <20250917123344.315037637@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Justin Worrell <jworrell@gmail.com>

[ Upstream commit 9559d2fffd4f9b892165eed48198a0e5cb8504e6 ]

xs_sock_recv_cmsg was failing to call xs_sock_process_cmsg for any cmsg
type other than TLS_RECORD_TYPE_ALERT (TLS_RECORD_TYPE_DATA, and other
values not handled.) Based on my reading of the previous commit
(cc5d5908: sunrpc: fix client side handling of tls alerts), it looks
like only iov_iter_revert should be conditional on TLS_RECORD_TYPE_ALERT
(but that other cmsg types should still call xs_sock_process_cmsg). On
my machine, I was unable to connect (over mtls) to an NFS share hosted
on FreeBSD. With this patch applied, I am able to mount the share again.

Fixes: cc5d59081fa2 ("sunrpc: fix client side handling of tls alerts")
Signed-off-by: Justin Worrell <jworrell@gmail.com>
Reviewed-and-tested-by: Scott Mayhew <smayhew@redhat.com>
Link: https://lore.kernel.org/r/20250904211038.12874-3-jworrell@gmail.com
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtsock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 92cec227215ae..b78f1aae9e806 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -407,9 +407,9 @@ xs_sock_recv_cmsg(struct socket *sock, unsigned int *msg_flags, int flags)
 	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &alert_kvec, 1,
 		      alert_kvec.iov_len);
 	ret = sock_recvmsg(sock, &msg, flags);
-	if (ret > 0 &&
-	    tls_get_record_type(sock->sk, &u.cmsg) == TLS_RECORD_TYPE_ALERT) {
-		iov_iter_revert(&msg.msg_iter, ret);
+	if (ret > 0) {
+		if (tls_get_record_type(sock->sk, &u.cmsg) == TLS_RECORD_TYPE_ALERT)
+			iov_iter_revert(&msg.msg_iter, ret);
 		ret = xs_sock_process_cmsg(sock, &msg, msg_flags, &u.cmsg,
 					   -EAGAIN);
 	}
-- 
2.51.0




