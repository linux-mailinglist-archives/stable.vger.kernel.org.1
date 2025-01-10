Return-Path: <stable+bounces-108174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5876A08A6D
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 09:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E05343A4632
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 08:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF0020897C;
	Fri, 10 Jan 2025 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZanrMgX"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC75E20ADD7
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736498138; cv=none; b=a0/sxv3w++LxZqy6M/VsO0qJXuW22/g/p0WfO7kLkUmxMsG5gM+D3BXAUdSc9pzTWnjRO7nNut50inhfvSHf4BzGCpeg/DqUiHEzpUMbBsqnt0h/p+BCLnS8MIcj/V4zg3tMiVW0IDIQWKhHImhbuqRd1fcCpo3IBzYfATBV+MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736498138; c=relaxed/simple;
	bh=QjfOQgTaUWrmSTlG/geSr55nIlTbnhvRsiGytk5OSls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEoNmfYhQOHP3qd0iA7t/QDX+tMByP0kzm9Rr+H5+QK0eIP2t/GL+OtyG1N+VGg39SStdRwqGvCQ4CASARk7GzJRHPXRYvrjpjIpwZsT0lOiwiLpfTsNLyYnTQVS/gpKhoku7WAGb00EqQdRZk194RNfdIPYlsE29fL/XA4pSKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NZanrMgX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736498135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sBLDY4DTw2zaWMjga9j81VUizG/Z+zQDnv2kJoLZ4eU=;
	b=NZanrMgXpBV3R/3XasJAoMyv8/AGj9S10YT3QUZA08R85lje4u7gEfPIZbSz3jY1U+wFnR
	aTXmpXDawB5sO0OK14rsTiJoh8E+c7gyclXOi4jo6JzhnCK2Wf3UUCUwKqe92emg+d8phA
	nV+gnEzSrMP2R67HvesGkg+A5vPmCJ8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-7VJ2oj5qPviGaFVUoF5akQ-1; Fri, 10 Jan 2025 03:35:34 -0500
X-MC-Unique: 7VJ2oj5qPviGaFVUoF5akQ-1
X-Mimecast-MFC-AGG-ID: 7VJ2oj5qPviGaFVUoF5akQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43619b135bcso9151375e9.1
        for <stable@vger.kernel.org>; Fri, 10 Jan 2025 00:35:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736498133; x=1737102933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBLDY4DTw2zaWMjga9j81VUizG/Z+zQDnv2kJoLZ4eU=;
        b=mBWMnZ8imfdIl65KhJgbjkT5mBEalJlHVpRLu+qifMxfft/NIBX6BcF2v0iIJ6v9mo
         E05om56Ps37ijHSE6IfBOH84RRGaRtQBAv6shVr0PXAT2MRQ49le7pYQjhzZit9foJCH
         OHj41zCQAuPM074UTAnakH8ZYHweWwNug7kyW8L1f05hs5nqDkdE9Xz/ARKqnfIT/tck
         tVn5U7XgvP4uEgG6xzwOONk/2KanAgdEkxQjob0zYguz9AglZ60C0zBZ0IVqbExF7Sih
         iZZQX79JES8P1TS+lHQnb4ohzwpEPasEE5ZGjLy0bDbx7cmgmW2toLCdUdINJghlwZRr
         Hw9g==
X-Forwarded-Encrypted: i=1; AJvYcCVvPq4m7f7W//F+w1UtLUW0LZcH5ybAsTh1o5AgcBFEZqVd7wvHkAjZFNhABZf2IuT3xcu6Fzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsZzcUFX7YUtKk9AV5LTw84MYUUlq+eFcZvYSeo0LPPuKiBDdm
	DlXSfTcbBMIue60EDUbY++xBXb8zjLYh6IEJQWeT/I4dCDBDmpLzCQl905DQXODJw5K/qxFV4aW
	vXK3wq0AKiZUPRpX9GwA6fH6v0UvOFUUqHEzBk8d8L4yAkJtMQKtdgw==
X-Gm-Gg: ASbGncvrJkRS8cw9mhM6Hc7IGvXqKWnb8N0OG11AtEzzZJq/lYDgo4UVEhyKPRkl8Ap
	RkxdHnCo4pSwQhX2ShbnK/GStyS8uE7cQPdYuVDw2fR66GAqjypP2kPLnX0ir7oWq3NOspZHxkv
	qbWT0S2EXJPNpOPNeXO8eQmribYNHji9+Ym5afMomTdRAuo+Ax/FxUQPG310zW8WqwUGjIM7pkW
	tlbhOxVkpNu7LmpmAvgJYRC2PWrQWNBctVDJN00249Ja8M=
X-Received: by 2002:a5d:64eb:0:b0:385:ec89:2f07 with SMTP id ffacd0b85a97d-38a87312d2emr8464149f8f.32.1736498133280;
        Fri, 10 Jan 2025 00:35:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkY+6wyisWu9I5OnlNIAEaCc1RkfYRMe4WOOPOqI9L+4Q6XFHZJA9lRe1HqGdOwc7Z+AC+ww==
X-Received: by 2002:a5d:64eb:0:b0:385:ec89:2f07 with SMTP id ffacd0b85a97d-38a87312d2emr8464107f8f.32.1736498132691;
        Fri, 10 Jan 2025 00:35:32 -0800 (PST)
Received: from step1.. ([5.77.78.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436dcc8ddddsm73101805e9.0.2025.01.10.00.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 00:35:31 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luigi Leonardi <leonardi@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Wongi Lee <qwerty@theori.io>,
	Stefano Garzarella <sgarzare@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hyunwoo Kim <v4bel@theori.io>,
	Jakub Kicinski <kuba@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	virtualization@lists.linux.dev,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 3/5] vsock/virtio: cancel close work in the destructor
Date: Fri, 10 Jan 2025 09:35:09 +0100
Message-ID: <20250110083511.30419-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110083511.30419-1-sgarzare@redhat.com>
References: <20250110083511.30419-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During virtio_transport_release() we can schedule a delayed work to
perform the closing of the socket before destruction.

The destructor is called either when the socket is really destroyed
(reference counter to zero), or it can also be called when we are
de-assigning the transport.

In the former case, we are sure the delayed work has completed, because
it holds a reference until it completes, so the destructor will
definitely be called after the delayed work is finished.
But in the latter case, the destructor is called by AF_VSOCK core, just
after the release(), so there may still be delayed work scheduled.

Refactor the code, moving the code to delete the close work already in
the do_close() to a new function. Invoke it during destruction to make
sure we don't leave any pending work.

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Cc: stable@vger.kernel.org
Reported-by: Hyunwoo Kim <v4bel@theori.io>
Closes: https://lore.kernel.org/netdev/Z37Sh+utS+iV3+eb@v4bel-B760M-AORUS-ELITE-AX/
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 29 ++++++++++++++++++-------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 51a494b69be8..7f7de6d88096 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -26,6 +26,9 @@
 /* Threshold for detecting small packets to copy */
 #define GOOD_COPY_LEN  128
 
+static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
+					       bool cancel_timeout);
+
 static const struct virtio_transport *
 virtio_transport_get_ops(struct vsock_sock *vsk)
 {
@@ -1109,6 +1112,8 @@ void virtio_transport_destruct(struct vsock_sock *vsk)
 {
 	struct virtio_vsock_sock *vvs = vsk->trans;
 
+	virtio_transport_cancel_close_work(vsk, true);
+
 	kfree(vvs);
 	vsk->trans = NULL;
 }
@@ -1204,17 +1209,11 @@ static void virtio_transport_wait_close(struct sock *sk, long timeout)
 	}
 }
 
-static void virtio_transport_do_close(struct vsock_sock *vsk,
-				      bool cancel_timeout)
+static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
+					       bool cancel_timeout)
 {
 	struct sock *sk = sk_vsock(vsk);
 
-	sock_set_flag(sk, SOCK_DONE);
-	vsk->peer_shutdown = SHUTDOWN_MASK;
-	if (vsock_stream_has_data(vsk) <= 0)
-		sk->sk_state = TCP_CLOSING;
-	sk->sk_state_change(sk);
-
 	if (vsk->close_work_scheduled &&
 	    (!cancel_timeout || cancel_delayed_work(&vsk->close_work))) {
 		vsk->close_work_scheduled = false;
@@ -1226,6 +1225,20 @@ static void virtio_transport_do_close(struct vsock_sock *vsk,
 	}
 }
 
+static void virtio_transport_do_close(struct vsock_sock *vsk,
+				      bool cancel_timeout)
+{
+	struct sock *sk = sk_vsock(vsk);
+
+	sock_set_flag(sk, SOCK_DONE);
+	vsk->peer_shutdown = SHUTDOWN_MASK;
+	if (vsock_stream_has_data(vsk) <= 0)
+		sk->sk_state = TCP_CLOSING;
+	sk->sk_state_change(sk);
+
+	virtio_transport_cancel_close_work(vsk, cancel_timeout);
+}
+
 static void virtio_transport_close_timeout(struct work_struct *work)
 {
 	struct vsock_sock *vsk =
-- 
2.47.1


