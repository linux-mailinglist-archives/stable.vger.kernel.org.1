Return-Path: <stable+bounces-109554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C11A16EFE
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 16:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74508166986
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 15:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11DF1E47BE;
	Mon, 20 Jan 2025 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QaIfgRom"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D783B1B4F02
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737385646; cv=none; b=ELpwRlL/pm9TnZ1M8M3k4oUg8Lp0nmxzGOX811JYvnbq6v74rd5dcJTlXd2BLaHRXf2LlBAz1581r13EyVPpnn0AAN31ic24jaysLtzr+AIaaviCqLMGjVri/mtmb4cEe3z5S5sKQDSKXm8k1npqbkAKuJDOwkGlC/EJ5EmTrjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737385646; c=relaxed/simple;
	bh=8jr08/K3XCn2ipOcq62fMeZeQXal3hcYB3+itE3g//U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YeoR86CLPbxMIIDGesthEtBbAdAYxs9OLM1CKp312rRXTacayAmSyJxF/hdhxiGmDDE+kTndEUzEZcrlusEqWgtilph55eiWgFPYjlZ41/YPMAY7jdyogRUItW2tdu8PdAlg5jg//Bh8qvS0YbY/P/oh1/errosM/v0wDCO09Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QaIfgRom; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737385643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5CSM4KZIGabCVR3LDPAMQ22HYonZS3nRr5CSu0whl1Q=;
	b=QaIfgRomo+7w6UH+juCJ24TnlEMgQMFfbdJvGA0KIiR8FVeM74R5D16ExCc1fd7ZD9oPrY
	evEmolEwlDD8wg8KeBdEErge0o3BtHFJ+tCk4hvu7QdoFoMWmV0rJkl1D7ONXdaO9K3YhZ
	GIy7dUyl2swrZJmflM5mmbBfAbnTUUc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-hmEm7IqXMGGMrRP-5R99DQ-1; Mon, 20 Jan 2025 10:07:22 -0500
X-MC-Unique: hmEm7IqXMGGMrRP-5R99DQ-1
X-Mimecast-MFC-AGG-ID: hmEm7IqXMGGMrRP-5R99DQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385d6ee042eso3036060f8f.0
        for <stable@vger.kernel.org>; Mon, 20 Jan 2025 07:07:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737385641; x=1737990441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CSM4KZIGabCVR3LDPAMQ22HYonZS3nRr5CSu0whl1Q=;
        b=ghBjre/VFtqcZglydfLgFwGfROrcIwKtAK3HE7M3qIt2e7N8pSOTvXsH9FMjzG907y
         BMfnvZL5kU+/XvA7iLJugM6Xp+29ResuqRPv0D9rOYQdiFiQAUEPSGLN2MrbVASOF7Af
         iQYaw3D12Zvi02k+ku5jfwv2T91njCERu/+jBzrV5nzAsjlkK5lUG+G2oHJDaheHKiEq
         sNJff50uetLqZzNxPKlHMBn8rJ8/6/5kn8HqNW2Pb2hgvtPmFqewKoIw5LP5CjBZdKei
         Y1E7OExQRBL7IVPlIw2EsXeQxRqMRBd4XY40DqmL3OCeHtIN/I8FUiwvvkMRbVpwY88J
         gDMw==
X-Gm-Message-State: AOJu0YxwRUTnzTSz15fYEuf20NwCM0JYwbsaSXVblh7xNg/rQ6E/Q76E
	RcgBckDU6eXZk++Wy67f9wzGVsNuY6fHf/V25n18dA8IJVjlhY6qz65PzmHDekcqR9uXDdj4TCR
	Q72O8zJyMY0D+4T4O78BcgihPX6ghZhqsP7HY0RpXrcbxasGxE5YlYiWDLAi19EZiyGXDWn0ONi
	6vYFLbdOw+VhZbVVEcOSpO0tsetSkjbBt5uo2fKg==
X-Gm-Gg: ASbGnctoq3HEyGZRWSw0txRtXHRQQVcEoIuFU0mje1yvEW8gJUil6LSrVl1vTa9XCAv
	ekeTDVictL3x9YEXEys8CybncxHUDVQInh44yI66o6Xl3gBbYisZKawzwHbYwYhdJql2mXxtKoj
	cLZkblbdHD/JxFKmPgSMJQl/4VpKXwx7Hc3Jm6OLbAhM4lS9Yn4Et0qJO29cqmwxPPeQtiGpRs/
	VtCShm/K8piWwmnuEoIler5h0M6QpAsk29MFnioUuMi6XYMYODQheIxKGtWJTPrqckxa7k/x4hZ
	0JoHq63Ppjbj6ihIPzF5gOun74UDd3GX9ajCaZcvQse7f2k=
X-Received: by 2002:adf:f68f:0:b0:38a:4184:1520 with SMTP id ffacd0b85a97d-38bf5673e98mr10480686f8f.27.1737385639261;
        Mon, 20 Jan 2025 07:07:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFt75w2pDhtY0jCAY7k2MnlfdAoslTHDWDzLTD8JC+VJj+WoW8p62iXGCUYy1dUvdGaHfpvBA==
X-Received: by 2002:adf:f68f:0:b0:38a:4184:1520 with SMTP id ffacd0b85a97d-38bf5673e98mr10480625f8f.27.1737385638598;
        Mon, 20 Jan 2025 07:07:18 -0800 (PST)
Received: from step1.redhat.com (host-82-53-134-100.retail.telecomitalia.it. [82.53.134.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3214c5csm10716929f8f.8.2025.01.20.07.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 07:07:17 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: stable@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Hyunwoo Kim <v4bel@theori.io>,
	Wongi Lee <qwerty@theori.io>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15.y] vsock/virtio: discard packets if the transport changes
Date: Mon, 20 Jan 2025 16:07:04 +0100
Message-ID: <20250120150704.103935-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025012004-rise-cavity-58aa@gregkh>
References: <2025012004-rise-cavity-58aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the socket has been de-assigned or assigned to another transport,
we must discard any packets received because they are not expected
and would cause issues when we access vsk->transport.

A possible scenario is described by Hyunwoo Kim in the attached link,
where after a first connect() interrupted by a signal, and a second
connect() failed, we can find `vsk->transport` at NULL, leading to a
NULL pointer dereference.

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Cc: stable@vger.kernel.org
Reported-by: Hyunwoo Kim <v4bel@theori.io>
Reported-by: Wongi Lee <qwerty@theori.io>
Closes: https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Hyunwoo Kim <v4bel@theori.io>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
(cherry picked from commit 2cb7c756f605ec02ffe562fb26828e4bcc5fdfc1)
[SG: fixed context conflict since this tree is missing commit 71dc9ec9ac7d
 ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")]
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 276993dd6416..580c5a86b13a 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1304,8 +1304,11 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 
 	lock_sock(sk);
 
-	/* Check if sk has been closed before lock_sock */
-	if (sock_flag(sk, SOCK_DONE)) {
+	/* Check if sk has been closed or assigned to another transport before
+	 * lock_sock (note: listener sockets are not assigned to any transport)
+	 */
+	if (sock_flag(sk, SOCK_DONE) ||
+	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
 		(void)virtio_transport_reset_no_sock(t, pkt);
 		release_sock(sk);
 		sock_put(sk);
-- 
2.48.1


