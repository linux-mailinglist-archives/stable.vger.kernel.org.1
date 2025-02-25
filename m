Return-Path: <stable+bounces-119508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5E7A4416C
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 14:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA14A3AA9EE
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 13:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D10269B01;
	Tue, 25 Feb 2025 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1HhI4sM"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA17426A0D9
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491612; cv=none; b=OBdBM0Zk6y62h5jHNXW6PcgY3SG8KH69YFAHDkntvuHn7nDXg4XHx9/EmcBKDz2AFL0kK6SBvlcQVW/PgnLIeNl9uYup4VLfiM1WHbjDabDP6ahQexLuQtHA6y3nFAubJbasG7KqhrQQxZEwpbB0ElWlGLo+iJ963oHl9CXZDro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491612; c=relaxed/simple;
	bh=x/SoOsEwIXJ2I0lj9eU01Zsi70t8jH5vF9VB2AzqcGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jMNsVHxHDksGNr4bH1vGaX5ZbTa7JzAlFT5D6IvphVcK2ZEyExVB89BwEUuZ0sZdLi+/lLhpEUHvXmQr0QWRrLcyPJ0TJda0xkgt2k2bhmVIuC2fHUoksXgiXhRjKeUVlGB2C/HmOYiVUFtAqDZMU3qTTd/+weA7nV+28+Qm8Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h1HhI4sM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740491609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WH6EQRTJAnG11oWI3qxrXzca9/GHK8AUiMHw+Fd1YXc=;
	b=h1HhI4sM96sxD4FRXwLNqPGzlvCRdL41OdVnBWb+k03e3nX0Hb2voEiiOiP/qwOV/4tp+w
	BI7mNytFavn5T8D5xlfC1FUkYordqmtsIwKbONSrQyvdlM9OgExggA4JsLQt22W9NefGIB
	7PRjD3HEC3xKjB77AQWys1oQu1zccY0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-5hGb7ThvMECjZPm_zF1xEQ-1; Tue, 25 Feb 2025 08:53:28 -0500
X-MC-Unique: 5hGb7ThvMECjZPm_zF1xEQ-1
X-Mimecast-MFC-AGG-ID: 5hGb7ThvMECjZPm_zF1xEQ_1740491607
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4399d2a1331so27717565e9.1
        for <stable@vger.kernel.org>; Tue, 25 Feb 2025 05:53:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740491607; x=1741096407;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WH6EQRTJAnG11oWI3qxrXzca9/GHK8AUiMHw+Fd1YXc=;
        b=nrU6V54HFjhsQBa+2bhcxkPvl6TxcBACur4BnrsGUhEyREyYUwyx1GKd2qZvmb5WNY
         PRYXjzLj9utOrt5cxCGLqA580uEKN1tkCXcg6KE4dq4Z8Pl7WOIqIm0N07oafMHU26N8
         Z1KGCVDSHp4y4eIy68lrkGD1ONY9RQhT3gKGwtFCikGSr6qveXqa0+m1dSgBgLJNxIM9
         F+1YoX7bc8l2K6Oq5T0ixuPPTjPQwgZgyNjy8Q4KqnIUQnQaEd6t1YtHJT/ElLQum5ih
         suaZXA2y5cwQqSBko8aHQXC0EpYKFm5qrVOZQe7jhmaHV2gZxaquSDi9go2EFlY9MguS
         UO5w==
X-Forwarded-Encrypted: i=1; AJvYcCUBnsB2hAWNQ1mdqb4z6OolbOr2RR8S7UerSHQq+aKeGCMauJoHqQ3nDmO1QHnepY/5H2v314E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNMP4hYYdrUm/32Emaud6YJz4bDwlDArCqZPYoisTf9a5tv4yc
	UAlXhTJqgzAWqUzGL2V+uMUZE9/W7gLjm3uwHq/C3+w0+QpoB0wrWfDQjrDZDC67f/RHbfSfvv1
	sDd1Y9ax6mkJPHZN/dyom0t+eyLBATBn7valtyqMy/y4Mzn9UhAjNIhDpDhoz0W2p
X-Gm-Gg: ASbGncs+Vi/T+Dk30Khh88rKf7WOaPXzCgjkQdkjotRSreovq8BUtuGYDcjybyr/K51
	NYea2WwdYOjWo629+wTiHlQSRSYYBTxgGIFnK4TNy09G5EvixNX8/qbN9AhtUZuVWBtq009Q3it
	w96zeliIBJmPR0DMCt8dBLZ/iTLcAam5KYqwJ6A1f4PsOESrQH2XWyyvN4DNhp6UDfLTwbvFlTD
	kdl/yKuEskvPibjJ4Re1CSsIVkH50RRrn2WAyvIrdqbqsfY7ecwFijCCMARRi0yK964UdSjMP+O
	6Va5HNIhkmDuZwMb93LGd6eGMZMWsqw2yCiy05zVocq1G7anZ2JdKsdcZH9Jc6uarYrwL3g=
X-Received: by 2002:a05:600c:1c9d:b0:439:5b03:586d with SMTP id 5b1f17b1804b1-439a30b0150mr170223505e9.8.1740491607008;
        Tue, 25 Feb 2025 05:53:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZsVP2UNIiau/kTPlc6LMB+QMxcs5i8rv2UwsyDwm3iae2GWcDcenWQDcz1hG4lVKVdYIHHQ==
X-Received: by 2002:a05:600c:1c9d:b0:439:5b03:586d with SMTP id 5b1f17b1804b1-439a30b0150mr170223245e9.8.1740491606557;
        Tue, 25 Feb 2025 05:53:26 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86ca9csm2362323f8f.22.2025.02.25.05.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:53:26 -0800 (PST)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 25 Feb 2025 14:53:15 +0100
Subject: [PATCH PATCH 5.15.y 1/3] bpf, vsock: Invoke proto::close on
 close()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-backport_fix_5_15-v1-1-479a1cce11a8@redhat.com>
References: <20250225-backport_fix_5_15-v1-0-479a1cce11a8@redhat.com>
In-Reply-To: <20250225-backport_fix_5_15-v1-0-479a1cce11a8@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Michal Luczaj <mhal@rbox.co>, 
 stable@vger.kernel.org
Cc: Luigi Leonardi <leonardi@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>
X-Mailer: b4 0.14.2

From: Michal Luczaj <mhal@rbox.co>

commit 135ffc7becc82cfb84936ae133da7969220b43b2 upstream.

vsock defines a BPF callback to be invoked when close() is called. However,
this callback is never actually executed. As a result, a closed vsock
socket is not automatically removed from the sockmap/sockhash.

Introduce a dummy vsock_close() and make vsock_release() call proto::close.

Note: changes in __vsock_release() look messy, but it's only due to indent
level reduction and variables xmas tree reorder.

Fixes: 634f1a7110b4 ("vsock: support sockmap")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Link: https://lore.kernel.org/r/20241118-vsock-bpf-poll-close-v1-3-f1b9669cacdc@rbox.co
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: John Fastabend <john.fastabend@gmail.com>
[LL: There is no sockmap support for this kernel version. This patch has
been backported because it helps reduce conflicts on future backports]
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 net/vmw_vsock/af_vsock.c | 67 +++++++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 27 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 943d58b07a559d7ff82bd6fa5770bce4f4bba86b..4fae775ce8a05714d5224ad0b13679f36dbbf0cc 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -113,12 +113,14 @@
 static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr);
 static void vsock_sk_destruct(struct sock *sk);
 static int vsock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb);
+static void vsock_close(struct sock *sk, long timeout);
 
 /* Protocol family. */
 static struct proto vsock_proto = {
 	.name = "AF_VSOCK",
 	.owner = THIS_MODULE,
 	.obj_size = sizeof(struct vsock_sock),
+	.close = vsock_close,
 };
 
 /* The default peer timeout indicates how long we will wait for a peer response
@@ -800,39 +802,37 @@ static bool sock_type_connectible(u16 type)
 
 static void __vsock_release(struct sock *sk, int level)
 {
-	if (sk) {
-		struct sock *pending;
-		struct vsock_sock *vsk;
-
-		vsk = vsock_sk(sk);
-		pending = NULL;	/* Compiler warning. */
+	struct vsock_sock *vsk;
+	struct sock *pending;
 
-		/* When "level" is SINGLE_DEPTH_NESTING, use the nested
-		 * version to avoid the warning "possible recursive locking
-		 * detected". When "level" is 0, lock_sock_nested(sk, level)
-		 * is the same as lock_sock(sk).
-		 */
-		lock_sock_nested(sk, level);
+	vsk = vsock_sk(sk);
+	pending = NULL;	/* Compiler warning. */
 
-		if (vsk->transport)
-			vsk->transport->release(vsk);
-		else if (sock_type_connectible(sk->sk_type))
-			vsock_remove_sock(vsk);
+	/* When "level" is SINGLE_DEPTH_NESTING, use the nested
+	 * version to avoid the warning "possible recursive locking
+	 * detected". When "level" is 0, lock_sock_nested(sk, level)
+	 * is the same as lock_sock(sk).
+	 */
+	lock_sock_nested(sk, level);
 
-		sock_orphan(sk);
-		sk->sk_shutdown = SHUTDOWN_MASK;
+	if (vsk->transport)
+		vsk->transport->release(vsk);
+	else if (sock_type_connectible(sk->sk_type))
+		vsock_remove_sock(vsk);
 
-		skb_queue_purge(&sk->sk_receive_queue);
+	sock_orphan(sk);
+	sk->sk_shutdown = SHUTDOWN_MASK;
 
-		/* Clean up any sockets that never were accepted. */
-		while ((pending = vsock_dequeue_accept(sk)) != NULL) {
-			__vsock_release(pending, SINGLE_DEPTH_NESTING);
-			sock_put(pending);
-		}
+	skb_queue_purge(&sk->sk_receive_queue);
 
-		release_sock(sk);
-		sock_put(sk);
+	/* Clean up any sockets that never were accepted. */
+	while ((pending = vsock_dequeue_accept(sk)) != NULL) {
+		__vsock_release(pending, SINGLE_DEPTH_NESTING);
+		sock_put(pending);
 	}
+
+	release_sock(sk);
+	sock_put(sk);
 }
 
 static void vsock_sk_destruct(struct sock *sk)
@@ -899,9 +899,22 @@ s64 vsock_stream_has_space(struct vsock_sock *vsk)
 }
 EXPORT_SYMBOL_GPL(vsock_stream_has_space);
 
+/* Dummy callback required by sockmap.
+ * See unconditional call of saved_close() in sock_map_close().
+ */
+static void vsock_close(struct sock *sk, long timeout)
+{
+}
+
 static int vsock_release(struct socket *sock)
 {
-	__vsock_release(sock->sk, 0);
+	struct sock *sk = sock->sk;
+
+	if (!sk)
+		return 0;
+
+	sk->sk_prot->close(sk, 0);
+	__vsock_release(sk, 0);
 	sock->sk = NULL;
 	sock->state = SS_FREE;
 

-- 
2.48.1


