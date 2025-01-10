Return-Path: <stable+bounces-108172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A80DA08A5E
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 09:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A675188499E
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 08:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D1D209F54;
	Fri, 10 Jan 2025 08:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4CSYJHR"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439FC209F23
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736498127; cv=none; b=T62wOwVM93cVtEi8StYj3Q5O3aADt8n1d01O9J6q6CTP+S5s7FMudTXL0S5t0gIAqKMW2PW4PrzW8+7wOqh2inuB8+x8Fk9SmbuVmztJaHUph32PV55eHqt1BFYwYdqbCAXwAdYc7g/EP1iidPi50B3geD5WLkaYpyHKgpOkY14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736498127; c=relaxed/simple;
	bh=gg9zwP3NuIW09DU6vGz9JHfMW8EBO0Kk4gY/BezPQf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDwChe9ztjTbSDnZDj8UHML2vm0WsOY5G9sbz1S3USc5y6lTciOeo2WOiY2hXYxs57FD8oasKiL7ueA04Hc8Px1Iq7An7zVrM5dDlaYh/ojmmhT3KwOr2NYgKfDSRpbfzQ3+TeO28/hbj8eJUZC6JegClXnjvDAT28u3dpxh4qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f4CSYJHR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736498124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9NbnJJOfD3lLHAPtW6xOg0cYnPxIPSN5ji63JO1T6TM=;
	b=f4CSYJHRpBP/Hb3JTzGF46s1rILYt43oHVpRyAp2UL6y7ZAlfZZJFzwhJV+Q4hVm/F7xdm
	hh9uwOHkO8owKGnx8tOauYOsLZvPCDyk0mqzpSjqO2FlkQFX3Bw28wRPXnhFx7sEWiUvHf
	+6QDQimY/yuoz+4qFle3y7YlZV+X484=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-8LrfiiNEPIOVVWfYUP2MvA-1; Fri, 10 Jan 2025 03:35:23 -0500
X-MC-Unique: 8LrfiiNEPIOVVWfYUP2MvA-1
X-Mimecast-MFC-AGG-ID: 8LrfiiNEPIOVVWfYUP2MvA
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385d7611ad3so1005107f8f.2
        for <stable@vger.kernel.org>; Fri, 10 Jan 2025 00:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736498122; x=1737102922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NbnJJOfD3lLHAPtW6xOg0cYnPxIPSN5ji63JO1T6TM=;
        b=OQV0nKUSxfzGT/dMdnMBZaFmyq09Jln2kDyz1zlosiwoO39bygQvjO8tJWu7xazuQE
         zaWODVEW7kAmnDFcazvbP1/z6PfkXdLhjHUi1IN+IbyES8U++t21B1oQYJHHDuNXigXL
         oeMQ8M6oHTjOSSNHZzGfMR+uu4QT0dKdqNWLhv1gqnSNqk3Y+QvlBJkk4yiwiSAm3B4L
         5el0FugE0Ygqutvy+ltp0k8WXWfP0XDZnjuxYzsL6h0gbFJ61J5X8uUiTI6VwFlGWnq1
         1S8envqRMrVEqk29RtCjh97jJyf2KkovSUtTUiW9HAhSqG4uFbGJb6Kt/LZYdsjZ5YZL
         /Fjw==
X-Forwarded-Encrypted: i=1; AJvYcCWXNHPTcwWmGCsih5BJdW2o906VRyaB5E+Fd6Lc/TCByXeVi+x4bOCkKfU8IhQUVpGAG5RFVaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpC/QSGOTgWaT5cY5XXNS1Avgz8LlMtybL5VK4AJUzqCvXkN2c
	0eFtziQNY6otRUiOJzoJImFDFRK6pmGyJHQ6Spg69P9bsiPCciwfqwkxAmODmxxL8ymVaRSVSS8
	FBXL3LZ4BwvftevrcPriCU7UZiZtmlS30M7bXE6mlaVyBe/aP2lkEFg==
X-Gm-Gg: ASbGncsutg4nM93BYv+EksV6a/urBgpEytdLvk0m1lSKvh6ERkjCj+DmNL9FWagyEfk
	BS8cojOTAmh5gp5LgaVj7sLQHaU1woXukWGuyM7hyTD6/6r+MncUGNWOM/AGov+wvcYPQs4EOW1
	LPRMwnlGNsstHcewf5gB3rfFUFVZBJ1N60FUO+bXrn4vtLgJF+ctRkyfVKbH1R/hXeAXvA18USe
	z4imGJ9qs+7NckC5aJ3TElQEEHJNf2QJ5nJK/6j48KbTEo=
X-Received: by 2002:a5d:64ce:0:b0:385:f6de:6266 with SMTP id ffacd0b85a97d-38a872eacdemr7037329f8f.24.1736498121735;
        Fri, 10 Jan 2025 00:35:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHaMGGKjwRAwVyhTKqw23Ww9p2dwBHr6VnXJ4BcQwGregbXhxMe1Q9lXOo3WbQYlPlIlcZAdg==
X-Received: by 2002:a5d:64ce:0:b0:385:f6de:6266 with SMTP id ffacd0b85a97d-38a872eacdemr7037271f8f.24.1736498121118;
        Fri, 10 Jan 2025 00:35:21 -0800 (PST)
Received: from step1.. ([5.77.78.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38c76esm3843166f8f.47.2025.01.10.00.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 00:35:20 -0800 (PST)
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
Subject: [PATCH net v2 1/5] vsock/virtio: discard packets if the transport changes
Date: Fri, 10 Jan 2025 09:35:07 +0100
Message-ID: <20250110083511.30419-2-sgarzare@redhat.com>
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
---
 net/vmw_vsock/virtio_transport_common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 9acc13ab3f82..51a494b69be8 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1628,8 +1628,11 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 
 	lock_sock(sk);
 
-	/* Check if sk has been closed before lock_sock */
-	if (sock_flag(sk, SOCK_DONE)) {
+	/* Check if sk has been closed or assigned to another transport before
+	 * lock_sock (note: listener sockets are not assigned to any transport)
+	 */
+	if (sock_flag(sk, SOCK_DONE) ||
+	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
 		(void)virtio_transport_reset_no_sock(t, skb);
 		release_sock(sk);
 		sock_put(sk);
-- 
2.47.1


