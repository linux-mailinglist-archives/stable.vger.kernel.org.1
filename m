Return-Path: <stable+bounces-119522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 760E8A442B1
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 15:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD103BE0F3
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 14:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA85269CF0;
	Tue, 25 Feb 2025 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjKIc/GI"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE18268680
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493608; cv=none; b=DF3EF6e0MhPveniXT1thhpmSZQDEwW3Tb2gL4VDWy6Df2zrOvKVTBB37EiFxDyXK43ddmOCQhAuHklgja6Cc5ah+FYawLmVcKimhSGTysZ2TPPlh7vPm3j/7X+Y++lbJoKCRZ+XzMWKrdlZ2ICFx5IXMBpe1mBUjRpZVTibOjWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493608; c=relaxed/simple;
	bh=KYsMEXI0josYZzfKOYr/w27g4c+7aXEu3cAfJrTG3qo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eYhagQQwMqlzEWten1LREPQUVZ+BoFWKyqTWzRQIEsPJTdMv8cThFzd6JnnVu6mdxBM3Pj7xz5Np42wtuzxAzwiO7PaspWLP0K2/uQG3YIYJHcwjmrH6w6kCwgJxlju59JZRkd6maEhadUhvCA1oFVY4TEjT/p6TZgqu/hh1VxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CjKIc/GI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740493605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzwZnQkvVmHoK3Y01ZykZZIGkD5986SKjzlFteAQFnE=;
	b=CjKIc/GIuMWt6M7lzJjC+CXp1uS4dp3AArGUfhIUUPLxybB1biFEbkAnqpzZyI0HZ7ZilI
	zIx0flFWArqrB6C7uj2CYaWkTD1vhJaT/VygactL6FjC+RFdIRn4wuwgZXxMY1H+BrqC2d
	2q97MvjkIWoWNd/Yn+OHs6Z3SHfMgFI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-FX3IU8ZoPoKREMbmYjUeBw-1; Tue, 25 Feb 2025 09:26:43 -0500
X-MC-Unique: FX3IU8ZoPoKREMbmYjUeBw-1
X-Mimecast-MFC-AGG-ID: FX3IU8ZoPoKREMbmYjUeBw_1740493603
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f394f6d84so4552796f8f.1
        for <stable@vger.kernel.org>; Tue, 25 Feb 2025 06:26:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740493602; x=1741098402;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzwZnQkvVmHoK3Y01ZykZZIGkD5986SKjzlFteAQFnE=;
        b=xGcwBx9wRZKzbf3CufqAWfQwdF6N13Qqi0BNQ4k/1NtUWa8OsKT65AYh/MoGJOji/q
         BXCWGTASTHsyLp1VjvXIeyCz45avcq7SQeeH6v0V0DGu9zO26GX4A31Ti3tjp1+x1djN
         bLIO8C57/g2ynz8fSDwBJbdnoXJaTKeeb6Tf+6Es/EEuXlS/Rk+SRd3F6xtHJ2k5aGyl
         4i5VM+bf2lH2g3JCJAnXYuKAEMfwrWs9O0ZRFYPB9UYg6uJzqwPjrBFfo2AEkAvg/OnX
         HBdl0njGmXZI2+l8rXaKPzAZDFmocnN+sMRQO3Ky6uFxNS9EA972NzawVyNztZGVhhTa
         Xunw==
X-Forwarded-Encrypted: i=1; AJvYcCWoBsS1q2toiAoB7pH29buZcpLXOydurDeSEhaWa49Sg+iYQpkzKpgIPDSxjUZ98G3wVRhNbZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Tz0WkQVg2aqZEQ58KRyAC3EJ23c5ND6LBm+uKKOe55ToXw8B
	onJdw+ikEQSqFJdSSlG5ch8gNzceTVUJT6AWULVoJ/QpBQ99CMrrxj/4a2YH5cVuhDZWn/HuM7y
	kVvahqlbgF3s0O9WYAlI/3RSxsK+CK93uJSB6MfSViZNM8AXwCXY29A==
X-Gm-Gg: ASbGncsyLmtbffMjnBELPaNJC886URiAensPUAF3TFjs3RQ7hbUjsrBhUwBG+Ny6OWt
	F5Uj79FCwet9zjp+7uHEsC6tJ0F0wvOok73MdktrBzsUSVpxFUJI6f+ab/zZqYt3IR+3w+AH7p3
	aJ4bFDkaFpTHhTubdBduNigtltPYFsIBe8mPwkXTIUa2eKS2w7ROTrbSUpaJdXg5FwRtNOrclCT
	y8RTBie7y9IXO5LqEnCYZ9NHZX3XoJY0kpeBT8IswsXeKKhZ4GdRjKwOdE2TWEStYihxvcrLuSi
	ruJeQevr7eya+UDBshQXTFkVgEMJMIBcS9NhWDHhGaqxiwJIpIESXBOv0hd6B96diNz5vZo=
X-Received: by 2002:a05:6000:1f88:b0:38d:d664:67d8 with SMTP id ffacd0b85a97d-38f70783f48mr13921309f8f.11.1740493602516;
        Tue, 25 Feb 2025 06:26:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbtRf4GaAdjZ3zUPzS67+kEe6JXiiFa87GGaMEjc+vZXTE4l3KhiNazt1jYtSGcr1t6+vIoQ==
X-Received: by 2002:a05:6000:1f88:b0:38d:d664:67d8 with SMTP id ffacd0b85a97d-38f70783f48mr13921286f8f.11.1740493602084;
        Tue, 25 Feb 2025 06:26:42 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8e7108sm2494009f8f.69.2025.02.25.06.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:26:41 -0800 (PST)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 25 Feb 2025 15:26:28 +0100
Subject: [PATCH 5.10.y 1/3] bpf, vsock: Invoke proto::close on close()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-backport_fix_5_10-v1-1-055dfd7be521@redhat.com>
References: <20250225-backport_fix_5_10-v1-0-055dfd7be521@redhat.com>
In-Reply-To: <20250225-backport_fix_5_10-v1-0-055dfd7be521@redhat.com>
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
index 53a9c0a73489bad5d4d9de1d0299b7b850462204..f80b28934c4b5af11765074da8d3f6f3d92ce6ff 100644
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
@@ -767,39 +769,37 @@ static struct sock *__vsock_create(struct net *net,
 
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
-		else if (sk->sk_type == SOCK_STREAM)
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
+	else if (sk->sk_type == SOCK_STREAM)
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
@@ -853,9 +853,22 @@ s64 vsock_stream_has_space(struct vsock_sock *vsk)
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


