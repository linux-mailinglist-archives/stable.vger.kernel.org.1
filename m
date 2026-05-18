Return-Path: <stable+bounces-249233-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eB3EGTrZCmrb8gQAu9opvQ
	(envelope-from <stable+bounces-249233-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:17:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BD8569854
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64F1B30521C2
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD183E558C;
	Mon, 18 May 2026 09:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cV0Mjq7h";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q0WqA1yB"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442C73E6DCC
	for <stable@vger.kernel.org>; Mon, 18 May 2026 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095234; cv=none; b=WQn5396TJ+XonY6+qYFKFzpu2bP78pyHg89MPmScGtv395oaVIClzMPDMQjEUp24gcdPjyqoMdx3HYcC9zcHU/Yc32qSCKHzOwEaVSWR4Gl+lGR5baAjbc6rUy6HLg7243RjeuXOQJMzyLP6lR351bDVUaHmnOLUsCUEqUPGbWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095234; c=relaxed/simple;
	bh=eYAsyzlcZhIaTkBbynj1OR7+7bApP1e2I2Pa+c+c3J8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3fc6t/D4HO1KIyxZq/qvAQMH4RlOYlfXKCv4IJ8YkYdeXzJkN9MD/b4KXVFmTSF9a4drEQeIGzXZ3eilfS+zqGv/4uYSm/eVne9GZJ5Br2eegQuAxt5B55ZPnyOiu37cutEdBrZ/BC2vy6D6F/n0VLftKhdSIYdbzgVo0psN48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cV0Mjq7h; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q0WqA1yB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779095231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dsBo8SZnL+tIoKyB10yuoDT3WWwlz7J8lfIk8OOzpIc=;
	b=cV0Mjq7h4udO/IE8ULNaDpfN78BaEqHzpoBJGvbUwQYt4qHmLqNy1R0XlV3MGp+juN48C5
	w0b1YSlzAVdB5Yuw1oncQ4OSOAGnVar35K2HMegAvSfYUoFVfKiHhWreWJGXwjeOGo0YIi
	MS2GqlQpEmORBorrV8zxpvK3gB0+zro=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-30EjoTq4PLerE2PA7yIQvw-1; Mon, 18 May 2026 05:07:09 -0400
X-MC-Unique: 30EjoTq4PLerE2PA7yIQvw-1
X-Mimecast-MFC-AGG-ID: 30EjoTq4PLerE2PA7yIQvw_1779095228
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44f56d5523eso2302323f8f.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 02:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779095228; x=1779700028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsBo8SZnL+tIoKyB10yuoDT3WWwlz7J8lfIk8OOzpIc=;
        b=q0WqA1yBuKqudkMDVa9gbdGVzMuIsrVVXNRSwdw3bjgtKnlxMLvJDWrMYDVPEUDhj9
         0QvedwBtRKqNr2F1FrzlxHjJIDmlaHNTkjOmFKFwsewObfVeXX9z/j5l0LsA+LurGglO
         C+aHH7ig9mUcgvF37isjI/JUvEGBJHCyMacgjX7fVv3Cikju5hbhhdzNY9MJNsmfKCXC
         TvvuMtEd7rfvBcZdRbjvQDJrtxVYVcMnoW2RPb+r9/O/atMX0gSuu+aBKebuGAWQAb48
         xlb6ZaThvvV5Fwn67avpYSW3LgKF2Uv/xlmpcz0ykEMEEAXQJOFlRd8ijkcQQGqcYFtc
         PEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095228; x=1779700028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dsBo8SZnL+tIoKyB10yuoDT3WWwlz7J8lfIk8OOzpIc=;
        b=tTzuoD6md/pAN0+c8sUJs/ZnDhQPc5e1XXGHklWYxsno0sEmT3a+DzGLGhIP5XSzzx
         S/psqsC0YWHk1ICocm3Mbw4ykldzYpzoil+Vlh/DZ45orjHp78iCTMizb4mNFtTFHfK0
         EPhlY/BQHg1aQ3RNWqFm/mmvLkVZdewCZOuIJRQGwI4CfGH2p7prF5dh4xADY06MEdhv
         U9EIRnsWthkvwo95Zs1FgBE4JubSAQHrOnDoe2f3tcbp8d6oSZsWOvn8KIgPbocDuoZC
         9saPbNbcS0dOeplsNewyXUIVim3SxgukfhCAO2XArvjWH20YT4VANQIcRobBD3TyLJ9n
         JOWg==
X-Forwarded-Encrypted: i=1; AFNElJ/Iinbh9oYK99Yg9xjVvEicSxP78HApiI8PDFvUj2MkpaQTSWDi21E7/IYUV5atWmfsbOU1sJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx0WENWSn5bJfKGrGb4z3unjQgw4QERZNpkQfIzon1WF8Xhmvo
	MmLwF6NnmV6XDurOCCgxRTdN179+NuoczRHeq4uc5qmwqkYPh18A8recjm2KvgbQgxeOonFwWjr
	vsape1DmiADKvBal6bcY2qQnn8uRBMSNJ7jkd3jWzPXgQij2iOVz2TYMesA==
X-Gm-Gg: Acq92OFo/a6jduIbBKjig5tnUIY0K2ZeFfCzfFyPWEK1o/WB0HYZb7eY5aY39QdlK/8
	KIyj3LzkwzfQN5tLyXqDaZ+0dfjCv8jqaQyMMdHzFlwpTz1TahzTt96B5au3jUa6YMOb30W92ig
	8rp0Ed2wVKdyfirxcGia2dEuRA11JMEx4hdS5npHenZtu/8ZE5ng0xr2mam/zuGrGWpCrSQ/9FH
	cdA6KD2EVoyRJsfnlFz3+5CHQXuMaaGVTAh4pA9VLwrfOleTXFoXhsOa3xcglbmTIb+kfQSWyaM
	7MK2BLiOmbYAnNx3e7FLfS0k9wUzdMTr93I176uXgIVd+4bVx1EokAb/Pi00lCv+sRH0yWuwgGV
	GylH+DzKgkR64LeFToMPwjGCQDYC7vR8IIaPCnCnn+NjRtcnIGsD9t7pIj2NGJVtpfslndGU=
X-Received: by 2002:adf:e681:0:b0:45e:633e:a7cc with SMTP id ffacd0b85a97d-45e633eb4e9mr14807938f8f.24.1779095228408;
        Mon, 18 May 2026 02:07:08 -0700 (PDT)
X-Received: by 2002:adf:e681:0:b0:45e:633e:a7cc with SMTP id ffacd0b85a97d-45e633eb4e9mr14807870f8f.24.1779095227874;
        Mon, 18 May 2026 02:07:07 -0700 (PDT)
Received: from stex1 (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768072sm35104134f8f.5.2026.05.18.02.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:07:07 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	kvm@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4 2/2] vsock/virtio: fix skb overhead accounting to preserve full buf_alloc
Date: Mon, 18 May 2026 11:06:56 +0200
Message-ID: <20260518090656.134588-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518090656.134588-1-sgarzare@redhat.com>
References: <20260518090656.134588-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 80BD8569854
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249233-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Stefano Garzarella <sgarzare@redhat.com>

After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
buf_alloc when checking whether a new packet fits. This reduces the
effective receive buffer below what the user configured via
SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
silently dropped and applications that rely on the full buffer size
to deadlock.

Also, the reduced space is not communicated to the remote peer, so
its credit calculation accounts more credit than the receiver will
actually accept, causing data loss (there is no retransmission).

With this approach we currently have failures in
tools/testing/vsock/vsock_test.c. Test 18 sometimes fails, while
test 22 always fails in this way:
    18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch

    22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
    Resource temporarily unavailable

Fix by allowing at most `buf_alloc * 2` as the total budget for payload
plus skb overhead in virtio_transport_inc_rx_pkt(), similar to how
SO_RCVBUF is doubled to reserve space for sk_buff metadata.
This preserves the full buf_alloc for payload under normal operation,
while still bounding the skb queue growth.

With this patch, all tests in tools/testing/vsock/vsock_test.c are
now passing again.

Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
Cc: stable@vger.kernel.org
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 5028ff534888..df3b418e0392 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -419,7 +419,14 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 {
 	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
 
-	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
+	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
+	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
+	 * metadata. Check payload against buf_alloc to be sure the other
+	 * peer is respecting the credit, and sk_buff overhead to bound
+	 * queue growth.
+	 */
+	if ((u64)vvs->buf_used + len > vvs->buf_alloc ||
+	    skb_overhead > vvs->buf_alloc)
 		return false;
 
 	vvs->rx_bytes += len;
-- 
2.54.0


