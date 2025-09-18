Return-Path: <stable+bounces-168123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF41DB23383
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC31F1B61E6C
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EBD2F5481;
	Tue, 12 Aug 2025 18:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="afnZqVps"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7652F745D;
	Tue, 12 Aug 2025 18:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023124; cv=none; b=UtW5ce/zyYQMoxvdBigYNkvT2gWzQq4pA5BCslgoV1dor0nCjrEr9DtXs0qC6ET8/S/gDhkHEBH9CiqAzUHH8zduSEcEV9yl9tBLVvToKLADm5y8mCcsz0ZKZwDMM0sYD2dIlEEcTM70PHujAdB1vt1jVEaHPRbcatO1Tgr4sLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023124; c=relaxed/simple;
	bh=ybPfW3UwYcNMjdU/9/E6EIbx4C4wTyGzaSWEiguMAA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwxVDxlRxLsV8yatPcfEfqzxf4b984VEpgp0mBFX8SFK39tvJs++V3B8X/Zpm2wdOmQswoj97jyi6bhF6kSQXyFKtkw7breZgSuUdKMORccXXOser6aZIo+vfJnJZI11F2n238layTZRepfpirHgfMNKUBPQtE/IWad6pwLDofY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=afnZqVps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB90C4CEF0;
	Tue, 12 Aug 2025 18:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755023123;
	bh=ybPfW3UwYcNMjdU/9/E6EIbx4C4wTyGzaSWEiguMAA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=afnZqVpsbLxEf4veqBZ+NQoy82QNIwF9w6SueJnNohd2eSG5R+fM7QhvvUMPXiDt1
	 o2nQ1oeHBaGSSgmXyCrho9KoB/uMxSy9FujZkXMM30GxdfI3N4J4yqaxYiv+BvNixa
	 Jfg5dl4qOaqtkIqLOwrNwp+c4RjF+glDqU46IBbU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Scott Mayhew <smayhew@redhat.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.12 323/369] sunrpc: fix handling of server side tls alerts
Date: Tue, 12 Aug 2025 19:30:20 +0200
Message-ID: <20250812173028.868311113@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
References: <20250812173014.736537091@linuxfoundation.org>
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

From: Olga Kornievskaia <okorniev@redhat.com>

commit bee47cb026e762841f3faece47b51f985e215edb upstream.

Scott Mayhew discovered a security exploit in NFS over TLS in
tls_alert_recv() due to its assumption it can read data from
the msg iterator's kvec..

kTLS implementation splits TLS non-data record payload between
the control message buffer (which includes the type such as TLS
aler or TLS cipher change) and the rest of the payload (say TLS
alert's level/description) which goes into the msg payload buffer.

This patch proposes to rework how control messages are setup and
used by sock_recvmsg().

If no control message structure is setup, kTLS layer will read and
process TLS data record types. As soon as it encounters a TLS control
message, it would return an error. At that point, NFS can setup a
kvec backed msg buffer and read in the control message such as a
TLS alert. Msg iterator can advance the kvec pointer as a part of
the copy process thus we need to revert the iterator before calling
into the tls_alert_recv.

Reported-by: Scott Mayhew <smayhew@redhat.com>
Fixes: 5e052dda121e ("SUNRPC: Recognize control messages in server-side TCP socket code")
Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
Cc: stable@vger.kernel.org
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sunrpc/svcsock.c |   43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -257,20 +257,47 @@ svc_tcp_sock_process_cmsg(struct socket
 }
 
 static int
-svc_tcp_sock_recv_cmsg(struct svc_sock *svsk, struct msghdr *msg)
+svc_tcp_sock_recv_cmsg(struct socket *sock, unsigned int *msg_flags)
 {
 	union {
 		struct cmsghdr	cmsg;
 		u8		buf[CMSG_SPACE(sizeof(u8))];
 	} u;
-	struct socket *sock = svsk->sk_sock;
+	u8 alert[2];
+	struct kvec alert_kvec = {
+		.iov_base = alert,
+		.iov_len = sizeof(alert),
+	};
+	struct msghdr msg = {
+		.msg_flags = *msg_flags,
+		.msg_control = &u,
+		.msg_controllen = sizeof(u),
+	};
+	int ret;
+
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &alert_kvec, 1,
+		      alert_kvec.iov_len);
+	ret = sock_recvmsg(sock, &msg, MSG_DONTWAIT);
+	if (ret > 0 &&
+	    tls_get_record_type(sock->sk, &u.cmsg) == TLS_RECORD_TYPE_ALERT) {
+		iov_iter_revert(&msg.msg_iter, ret);
+		ret = svc_tcp_sock_process_cmsg(sock, &msg, &u.cmsg, -EAGAIN);
+	}
+	return ret;
+}
+
+static int
+svc_tcp_sock_recvmsg(struct svc_sock *svsk, struct msghdr *msg)
+{
 	int ret;
+	struct socket *sock = svsk->sk_sock;
 
-	msg->msg_control = &u;
-	msg->msg_controllen = sizeof(u);
 	ret = sock_recvmsg(sock, msg, MSG_DONTWAIT);
-	if (unlikely(msg->msg_controllen != sizeof(u)))
-		ret = svc_tcp_sock_process_cmsg(sock, msg, &u.cmsg, ret);
+	if (msg->msg_flags & MSG_CTRUNC) {
+		msg->msg_flags &= ~(MSG_CTRUNC | MSG_EOR);
+		if (ret == 0 || ret == -EIO)
+			ret = svc_tcp_sock_recv_cmsg(sock, &msg->msg_flags);
+	}
 	return ret;
 }
 
@@ -321,7 +348,7 @@ static ssize_t svc_tcp_read_msg(struct s
 		iov_iter_advance(&msg.msg_iter, seek);
 		buflen -= seek;
 	}
-	len = svc_tcp_sock_recv_cmsg(svsk, &msg);
+	len = svc_tcp_sock_recvmsg(svsk, &msg);
 	if (len > 0)
 		svc_flush_bvec(bvec, len, seek);
 
@@ -1019,7 +1046,7 @@ static ssize_t svc_tcp_read_marker(struc
 		iov.iov_base = ((char *)&svsk->sk_marker) + svsk->sk_tcplen;
 		iov.iov_len  = want;
 		iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, want);
-		len = svc_tcp_sock_recv_cmsg(svsk, &msg);
+		len = svc_tcp_sock_recvmsg(svsk, &msg);
 		if (len < 0)
 			return len;
 		svsk->sk_tcplen += len;



