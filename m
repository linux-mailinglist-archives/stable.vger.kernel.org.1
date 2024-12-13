Return-Path: <stable+bounces-103997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B848E9F09E9
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 11:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B357D16A3BC
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 10:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A9A1BD01D;
	Fri, 13 Dec 2024 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aw3X96/A"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F01C1B392A
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086654; cv=none; b=KY17n/fHNsZlqm8RX05BVLB8yVq/IRCFOOBRNFCwWyGuiVjUlw/O2sSxtyyZvcLxyqXLuMj//qah8Q7tK2qiGx1QZM2u+LJwnUVez8X/AuO0sRRi9hINteIe/SqFC0SmcRTt7GRhoq6LmJghQcNHzfbXUPl4skk4wdLQnFO4HaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086654; c=relaxed/simple;
	bh=IGZfQpsj09ZOmgKGOHCDJHHULrPjxGEUWVqXlin6jMU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sJ2UFoDOfzKC6Urq9FlMfVynM3gxL6YzBMnUifOSI3B9fftmlJ6877g/jQBnpjqqGwsgovXSAN4akwq7jGAy0jAVWbkich8RXSgxegSeEMQljwBT8CgTL4hlR3xxAV2VWauylKz+HhfRdfXWfNtjmvfaD3QnbbUJALCOpi0Z59A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aw3X96/A; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa6c0dbce1fso210766166b.2
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 02:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734086651; x=1734691451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HCRRRjBZCPIP5ncu2g7N8BOdr3+KyrcLc7zyxTypBtw=;
        b=Aw3X96/AFIxwMVD0XskSm2F0BLKXPBrOaGDTMoxeYuE3Yb8TgBmLBuQjgiAgbyhpvK
         SBNJPj584IHiaXQRZae9BnGTwp3udf7dqFxYjOXoNkTfKzSIQ/FFTrMsOxgYRlokVslf
         phFu4388+AtTxooy5qN6/vUUS7uQJZ5lns4hQEfpPiJZWxOEml3lVjOiNrW4pV0yGOLg
         r+bzS4LMWmrwyILrrCx5K0S2QKvDK8Ebfw7U7ToxjBjQbXgDvKgw9CDb9qEW+INFgyfK
         B5qf5ojgmRRDNkwX+PUGWWcbodXDRnPClPvJJ6UplBxQbUvGLWASEZtNoFa4DB9NSs/Q
         84AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734086651; x=1734691451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCRRRjBZCPIP5ncu2g7N8BOdr3+KyrcLc7zyxTypBtw=;
        b=dj1neH5ICyEXl0pOHs8L3XT0pqNzHcpwchUtvbqPFh4TyOLCGaAxceYlaaJEpDFA0+
         LhfSzUaa16aGZ9XfW/e5/mOiBmitODsFRHTxuXzjmIJwU+OkvuoK8CUh+4hEth4R0Jah
         xn7UBaDR+AmGXT6GaapGTFiHpCwFjBGw8wKwCb06Je2SPzY0NYfGkK5MtCZ531afRzhM
         XELyJeXSO4tUlqp8bVAY1XDgFCQKJ52/y/MrOn/Nht+N7iiBGYABjsD6aL+WRdyXrQ2j
         r8FI5Aq0ElUV4npWHtczZZuMaHik114UoY7vm00eW10D2ErZhOMeaP83XrhA3WMbNNJ4
         zxAg==
X-Gm-Message-State: AOJu0YzrRe9pXJnYuLI8jZofrZ7/hjV0cZwand2utcZCESwtn61jeKJq
	I+C1sblvbJWBzrkSKjxCrGumgF6J1uZ4XlmlM4DqYk85Nnexer7VJGuU4LDUwUi2aQ==
X-Gm-Gg: ASbGnctSKdz66qwUunzAatWRJjtvsOv1xIuja+mb9EzFb3he6dD5sxnauATPg4JwsVl
	T1x5gl3hdzNtV0WEteWFA3JrsAbXuS1ay7rWlwOZr9bIu6lzkRY6QtKNlSAMLampe1d+HOjvDmm
	OKFcTivZLKF4KxYh+m9nDQmrMacS4Gj8eDLJLhxFaHa51tmVyRz1dPc5aLRZhKaXjaEZHRs83QI
	wfc3mhHYX82baatdB5LXLEB/QW4QX5w7uw/ldrgm8d39ppoFpbKdTBKWic3xlVJaDSDRF6baLCo
	eVejOsyCxYh2trnIrivzMfJc40vNEvGebeyAnB4+XHydVBEYggAVH3heAQ5nmpY=
X-Google-Smtp-Source: AGHT+IEkfBEcTEkVJGvf1OwRVvLqSr+l9+Cj+M0CIIHdevUdBSf07U1WjkecJNhO+14Lpi0Na6QFbg==
X-Received: by 2002:a05:6402:35c3:b0:5d2:7396:b0ed with SMTP id 4fb4d7f45d1cf-5d63c31e814mr5072282a12.14.1734086650889;
        Fri, 13 Dec 2024 02:44:10 -0800 (PST)
Received: from dev-dsk-krckatom-1b-7b393aa4.eu-west-1.amazon.com (54-240-197-239.amazon.com. [54.240.197.239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa66c646defsm854719766b.181.2024.12.13.02.44.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2024 02:44:10 -0800 (PST)
From: Tomas Krcka <tomas.krcka@gmail.com>
X-Google-Original-From: Tomas Krcka <krckatom@amazon.de>
To: stable@vger.kernel.org
Cc: Michal Luczaj <mhal@rbox.co>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Tomas Krcka <krckatom@amazon.de>
Subject: [PATCH 5.15.y 5.10.y] virtio/vsock: Fix accept_queue memory leak
Date: Fri, 13 Dec 2024 10:43:57 +0000
Message-Id: <20241213104357.15964-1-krckatom@amazon.de>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Luczaj <mhal@rbox.co>

[ Upstream commit d7b0ff5a866724c3ad21f2628c22a63336deec3f ]

As the final stages of socket destruction may be delayed, it is possible
that virtio_transport_recv_listen() will be called after the accept_queue
has been flushed, but before the SOCK_DONE flag has been set. As a result,
sockets enqueued after the flush would remain unremoved, leading to a
memory leak.

vsock_release
  __vsock_release
    lock
    virtio_transport_release
      virtio_transport_close
        schedule_delayed_work(close_work)
    sk_shutdown = SHUTDOWN_MASK
(!) flush accept_queue
    release
                                        virtio_transport_recv_pkt
                                          vsock_find_bound_socket
                                          lock
                                          if flag(SOCK_DONE) return
                                          virtio_transport_recv_listen
                                            child = vsock_create_connected
                                      (!)   vsock_enqueue_accept(child)
                                          release
close_work
  lock
  virtio_transport_do_close
    set_flag(SOCK_DONE)
    virtio_transport_remove_sock
      vsock_remove_sock
        vsock_remove_bound
  release

Introduce a sk_shutdown check to disallow vsock_enqueue_accept() during
socket destruction.

unreferenced object 0xffff888109e3f800 (size 2040):
  comm "kworker/5:2", pid 371, jiffies 4294940105
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    28 00 0b 40 00 00 00 00 00 00 00 00 00 00 00 00  (..@............
  backtrace (crc 9e5f4e84):
    [<ffffffff81418ff1>] kmem_cache_alloc_noprof+0x2c1/0x360
    [<ffffffff81d27aa0>] sk_prot_alloc+0x30/0x120
    [<ffffffff81d2b54c>] sk_alloc+0x2c/0x4b0
    [<ffffffff81fe049a>] __vsock_create.constprop.0+0x2a/0x310
    [<ffffffff81fe6d6c>] virtio_transport_recv_pkt+0x4dc/0x9a0
    [<ffffffff81fe745d>] vsock_loopback_work+0xfd/0x140
    [<ffffffff810fc6ac>] process_one_work+0x20c/0x570
    [<ffffffff810fce3f>] worker_thread+0x1bf/0x3a0
    [<ffffffff811070dd>] kthread+0xdd/0x110
    [<ffffffff81044fdd>] ret_from_fork+0x2d/0x50
    [<ffffffff8100785a>] ret_from_fork_asm+0x1a/0x30

Fixes: 3fe356d58efa ("vsock/virtio: discard packets only when socket is really closed")
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[Adapted due to missing commit
71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")]
Signed-off-by: Tomas Krcka <krckatom@amazon.de>
---
 net/vmw_vsock/virtio_transport_common.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index b626c7e8e61a..ccbee1723b07 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1062,6 +1062,14 @@ virtio_transport_recv_listen(struct sock *sk, struct virtio_vsock_pkt *pkt,
 		return -ENOMEM;
 	}
 
+	/* __vsock_release() might have already flushed accept_queue.
+	 * Subsequent enqueues would lead to a memory leak.
+	 */
+	if (sk->sk_shutdown == SHUTDOWN_MASK) {
+		virtio_transport_reset_no_sock(t, pkt);
+		return -ESHUTDOWN;
+	}
+
 	child = vsock_create_connected(sk);
 	if (!child) {
 		virtio_transport_reset_no_sock(t, pkt);
-- 
2.40.1


