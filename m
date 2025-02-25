Return-Path: <stable+bounces-119512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C23EA441A8
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 15:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03DA3BA9EA
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 13:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C1226E631;
	Tue, 25 Feb 2025 13:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Df+tnUKE"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF122641CA
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491784; cv=none; b=FfxKu66zHlwOc1Uea96Ror5RY+uAnOehebR46M4qEMmblJ08UtPSCKqfBe8lDA0YT76oLZi1qRLJ2GHuIOB3IoV5f2tEqFuNPxl2WSB8DPs1N8AOIZXb9v3BFiZEWi8Ken+Q+dZWq18BpH9oJ2j2sj7yJQj2aVYQ0+yrQQjNvpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491784; c=relaxed/simple;
	bh=IZ6MefQL8fZKGw7FWgB7qeuMsKYxcXafHazvVH2nZ3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u+DAr6xzpSxvhm7iSeREgBj6CCWox6kGvCa8MxvxN6uHMRmpEFuVTwAJV3i0gj7x6lX6umifcLjcx1nVr7EdwQ4fOlZxCSSlRpb0e6IWGSMlNP2V+GTiD8u1QBeX4DBj9kC5Si5/F73fi1rElozd2i9i4LfZDjx+JJ0S94W4xz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Df+tnUKE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740491782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJKwJaZP8mzwz/0WH1tadSz36syYHJsvHFtSV2yAjwI=;
	b=Df+tnUKEqUdvzGy9dtO02frqQPjySRlkUf3x3mQSeHPssGXQHLbJIECjOxg3uLIYdBoUBg
	SsBFkQNIGdfa1/7H74PkodXaQnC3f1U0EBCIuyOSijxe/UIa8RyXlHnTYcFkBbxUn7kCWx
	x5fkBmwAC8dCwuN/8FnZ0ox1J4JX6ww=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-XmOxiFglMG6nN5PAkN6V_Q-1; Tue, 25 Feb 2025 08:56:20 -0500
X-MC-Unique: XmOxiFglMG6nN5PAkN6V_Q-1
X-Mimecast-MFC-AGG-ID: XmOxiFglMG6nN5PAkN6V_Q_1740491779
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4399a5afcb3so53395505e9.3
        for <stable@vger.kernel.org>; Tue, 25 Feb 2025 05:56:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740491779; x=1741096579;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJKwJaZP8mzwz/0WH1tadSz36syYHJsvHFtSV2yAjwI=;
        b=aEkVIjFbJV5p8Xq16RQSDc4ZyQCeXzsJBjR049PdZA03CrNlo01NPi10AmBG9S7PSt
         d5DKkuXYOXhgU+CmqewkwuaejzdN2U/jQWCr4dm5Zzji1ob2hVIG0c3QhOOylE8q0U5D
         9YYdTIicbcBAQdaZNHKa9HYa0+eBIoEytqW0uK88NzjkvfozpUHiAUvh1oALN4AApZt0
         vQHcFMOfbZ9LK96fj8dej4tfMdkZOfABLVzK4MYiAvaCuixpipa4i6eb1tYFwibxdm0R
         uaonrNks7o9Zgm1Iu+zJOy6P+OWvXLaXcZ785fYx0X3tKsP0X+A9/Mh2hwhuJEnONMVp
         HNHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/wEbB1c5iIO2fXLSXF/kxNxN3eGnq9WZO1dqJRf2TF0Y+dvM6MeBVO4r/4LmLvgnTza0rG3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW1yS+vyb5xZwhcjMEmUb9GpwHZ2JrMZ13fKlRtLGpMLKYiY/q
	pOiHzBXuoTQQv6T7aTTFsnS1nCuxq/JZ1NOXCZw5p2GfiY8QQ2ndNe+jYqdDzqtXxPtZCwxqXk5
	+J+rXjp/mxF6Fk7jTJ+BVz4remSKdB3YL2eEUZue9jh1mpjBRhgsSB4ckMbHUJnEt
X-Gm-Gg: ASbGnctGNWz5O7MS4MQ1lUBqMGxSH/rkC5PBBGPyyWOZjpBLl6vg4cqKR+FZKe5Gf5c
	cHjm0aRyQ2l+9Cx8bjiN9Vbwj6GQ8agTvao7ie26ceVfAtJU41hRjPaJroRAj2xR3P4eeZG/Vpp
	STomzJ65sRNppEOrdFFHslR3fch+feZpJcYiUFJjsrlrwfMFiCt9nQ8F+G5k/mXv/h7ewIwG3Vc
	If5emCscrnMeLvGTwyBPOJbCfZcDt61K+5gjMHALw0NI1+WoDQ91hQ56bue2Bjuz+GZqlzjBxZR
	rEleiOiyPdZoBPNmMnb5C+oKYmkDx+lA2l85rbnAyUIDKSR0tVeH2i3UkOXwE2CM01GKf4o=
X-Received: by 2002:adf:f391:0:b0:38d:e3d4:4468 with SMTP id ffacd0b85a97d-390cc63c3d9mr2777595f8f.51.1740491779339;
        Tue, 25 Feb 2025 05:56:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnNdz2nlzlKXKrCYsWPkQCh1vEU6F6Gl7UHyggkUNM+pJTrpbbRsCVLhVUXhREU1nWmqlAWw==
X-Received: by 2002:adf:f391:0:b0:38d:e3d4:4468 with SMTP id ffacd0b85a97d-390cc63c3d9mr2777573f8f.51.1740491778901;
        Tue, 25 Feb 2025 05:56:18 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86cd10sm2424181f8f.37.2025.02.25.05.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:56:18 -0800 (PST)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 25 Feb 2025 14:56:13 +0100
Subject: [PATCH PATCH 6.1.y 1/3] bpf, vsock: Invoke proto::close on close()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-backport_fix-v1-1-71243c63da05@redhat.com>
References: <20250225-backport_fix-v1-0-71243c63da05@redhat.com>
In-Reply-To: <20250225-backport_fix-v1-0-71243c63da05@redhat.com>
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
index 88b5702a0a47c65fe78b1c5594c6e4d9e9842b38..32bc7fcb31165f9500e44b9629549f0e24305ca9 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -116,12 +116,14 @@
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
@@ -803,39 +805,37 @@ static bool sock_type_connectible(u16 type)
 
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
@@ -912,9 +912,22 @@ void vsock_data_ready(struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(vsock_data_ready);
 
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


