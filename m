Return-Path: <stable+bounces-188330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2C4BF66E5
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 14:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3375446EB
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 12:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6698C3148DA;
	Tue, 21 Oct 2025 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwbjGFY2"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801CC2F7ADE
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049053; cv=none; b=NPQAoHQgx77X5G1VE1sEnUKLuM0UTLED8gpK88oi4ypjvvQ7yf3gQoE+Xb39Afrd6OWaBBWDHN73Tu6jqiTuAZj0LQkLBlD8v33sy/YR4OhJHRtBfypPkqqGW2h49xmR6/XyAtIBT8iz1FV0OTnmZ8gK1l/9FakRYTk4d0uOOZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049053; c=relaxed/simple;
	bh=8jAVkUMH/+u3VOLZBfozegkzfmtTLIRMJxxRi5VQsQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ID72t3RpRaAJ4RFBlxVLIiXFIyGrHqgjS9ihMdbMPAfX4WnqUdSFiQBovuVZiKytCrtjnlwy18AKtoSeYlboYD2et+pPsGP6xGep1uqUrt/h+RoGzMQEbhFMuK6woGaoH+NnbOfyFL4SOJBC98qVsfHUO2Jn1NNou5P+xu8JEt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VwbjGFY2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761049048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bCWN2qWia5U/NhXPrwUuTQXMXPl3dg4yyzToKGFJy2Y=;
	b=VwbjGFY26BaqtHYrbXQLHOVAOWwFVJFirCs6F4t+OFK7kOPemo7R0hxET+zAuametN88+Q
	KdcWQTZaYM3O5x7I6+ysVNXEiUVeRI4WLj5TVdquChGn9wLCy3jbaLJ/sB+lDvBRbYx6vk
	IFctR3phYMnrUUVmuYS7siqKyiYj71I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-O6Rp6M1WO6-mheQWKkLSUg-1; Tue, 21 Oct 2025 08:17:27 -0400
X-MC-Unique: O6Rp6M1WO6-mheQWKkLSUg-1
X-Mimecast-MFC-AGG-ID: O6Rp6M1WO6-mheQWKkLSUg_1761049046
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3f6b44ab789so2883473f8f.3
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 05:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761049046; x=1761653846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bCWN2qWia5U/NhXPrwUuTQXMXPl3dg4yyzToKGFJy2Y=;
        b=l8p6YyIvswQJzMYYriOLro6MyOMW9zG3/e2/jXgmfTBBHLaFgZswtE/sWoJFaIrqTV
         ERsaenAV0Z8N7+Q+gUjsnABdIiTsymqr+cIhCh2ZD8/9/MXslM2U1mWV4PUuF7cwxguS
         bY/7/kiQzrvw23JfSvuiYM9r5LS2AR8oe6idTARr4xNMImPB/qCSL6J32eeL6umITIkK
         z7ocFvREZJBhZEdPxz3iZSuM2rwmg+TSQikMW252PuUZnTou3YKEYoG9dvO8x0bghJN5
         4KHWqKrbb4I3hali54FdPIEnpz8pvxdO4kZmpvjH3Bjx8UR0qX5iQ2va0u2NQnDGHLOw
         Rbzg==
X-Forwarded-Encrypted: i=1; AJvYcCW/Y5/l4K9BNG/Fl7AoY6CAZXw3Yi2P4zNnoxzBQZ0B4ztrignuNggUctn1AMZzB0VvG3L+D9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjvXxPVOIayKRrHfQKErgt3dtawKB1SdewS7xHceS2imSmDR9G
	sgShczR6ZwVrajsriD94DMQ6HdAn6nhM7TrUrO7ScYBKD3gvQhJCluSwlKEBKRN14lHWxRflxsa
	/C23d5H/fGp+zKiwQP+x0jAl+uZz129lDzFu1Bo3tcpZSqr3YtTd/JNSTxQ==
X-Gm-Gg: ASbGncvAUl88F64FvsZDvi4vKjla2ex3N2sWr3nO+Wv+B3GHCz098ksKnJAgj+G/drU
	n2wTMXrDSp1M/wfDxlKzlIbE04k8msRz0tNS0d6pN80PSGm6/lvCF4HVxBEf4yyFlUMK7Q8Qi9G
	MVIBhzwESVw/1i4VU0EqaYJl87E/tNIN1QUm7TMysQa8qtCEpEdr+9MCe1Yj6wUqWYAZgQOilwP
	Q4JtSm6nK1/FqsKKj1bDQMXKm0mEiPdxp/XxSbbU1TN+oY+k0RSJ6c/J6qRl7yjJP1gpKCVB7YC
	E/vTJBGMjrR/kq6eTn0uDHF2nTvwWAv992jIj4M7YyWDNqugA6PrMb+qcQ+37v1wvqXpI6NlECu
	xBPwtMO9cMt+8gcuwvalF7Z3xixn09JVccFFIx9+GifFrzIRKfRMj
X-Received: by 2002:a05:6000:1867:b0:427:6a4:93da with SMTP id ffacd0b85a97d-42706a496dcmr8994717f8f.49.1761049045872;
        Tue, 21 Oct 2025 05:17:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIDzVJ2UzNuMp+C3slOnSBweFytGxnRjkV0uaR+1r+JrGCQpAt/7Y9bGWU8thLnHIYoiPCxA==
X-Received: by 2002:a05:6000:1867:b0:427:6a4:93da with SMTP id ffacd0b85a97d-42706a496dcmr8994691f8f.49.1761049045378;
        Tue, 21 Oct 2025 05:17:25 -0700 (PDT)
Received: from stex1.redhat.com (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47154d38309sm194606535e9.9.2025.10.21.05.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 05:17:24 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	virtualization@lists.linux.dev,
	Michal Luczaj <mhal@rbox.co>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH net] vsock: fix lock inversion in vsock_assign_transport()
Date: Tue, 21 Oct 2025 14:17:18 +0200
Message-ID: <20251021121718.137668-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

Syzbot reported a potential lock inversion deadlock between
vsock_register_mutex and sk_lock-AF_VSOCK when vsock_linger() is called.

The issue was introduced by commit 687aa0c5581b ("vsock: Fix
transport_* TOCTOU") which added vsock_register_mutex locking in
vsock_assign_transport() around the transport->release() call, that can
call vsock_linger(). vsock_assign_transport() can be called with sk_lock
held. vsock_linger() calls sk_wait_event() that temporarily releases and
re-acquires sk_lock. During this window, if another thread hold
vsock_register_mutex while trying to acquire sk_lock, a circular
dependency is created.

Fix this by releasing vsock_register_mutex before calling
transport->release() and vsock_deassign_transport(). This is safe
because we don't need to hold vsock_register_mutex while releasing the
old transport, and we ensure the new transport won't disappear by
obtaining a module reference first via try_module_get().

Reported-by: syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com
Tested-by: syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com
Fixes: 687aa0c5581b ("vsock: Fix transport_* TOCTOU")
Cc: mhal@rbox.co
Cc: stable@vger.kernel.org
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/af_vsock.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 4c2db6cca557..76763247a377 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -487,12 +487,26 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		goto err;
 	}
 
-	if (vsk->transport) {
-		if (vsk->transport == new_transport) {
-			ret = 0;
-			goto err;
-		}
+	if (vsk->transport && vsk->transport == new_transport) {
+		ret = 0;
+		goto err;
+	}
 
+	/* We increase the module refcnt to prevent the transport unloading
+	 * while there are open sockets assigned to it.
+	 */
+	if (!new_transport || !try_module_get(new_transport->module)) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	/* It's safe to release the mutex after a successful try_module_get().
+	 * Whichever transport `new_transport` points at, it won't go away until
+	 * the last module_put() below or in vsock_deassign_transport().
+	 */
+	mutex_unlock(&vsock_register_mutex);
+
+	if (vsk->transport) {
 		/* transport->release() must be called with sock lock acquired.
 		 * This path can only be taken during vsock_connect(), where we
 		 * have already held the sock lock. In the other cases, this
@@ -512,20 +526,6 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		vsk->peer_shutdown = 0;
 	}
 
-	/* We increase the module refcnt to prevent the transport unloading
-	 * while there are open sockets assigned to it.
-	 */
-	if (!new_transport || !try_module_get(new_transport->module)) {
-		ret = -ENODEV;
-		goto err;
-	}
-
-	/* It's safe to release the mutex after a successful try_module_get().
-	 * Whichever transport `new_transport` points at, it won't go away until
-	 * the last module_put() below or in vsock_deassign_transport().
-	 */
-	mutex_unlock(&vsock_register_mutex);
-
 	if (sk->sk_type == SOCK_SEQPACKET) {
 		if (!new_transport->seqpacket_allow ||
 		    !new_transport->seqpacket_allow(remote_cid)) {
-- 
2.51.0


