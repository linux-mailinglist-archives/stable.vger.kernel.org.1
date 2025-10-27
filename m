Return-Path: <stable+bounces-189946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 276EAC0C9C0
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 10:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BFF7188A04A
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 09:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF662E7BB4;
	Mon, 27 Oct 2025 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQ6Gd4cA"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3265327B34E
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761556512; cv=none; b=rPlPH5rSR4hW1giPhDVfpZoTO4SwN3UHq0JxJy1B+pu/XnYmoP/lZHp3618zuGaT13AcBYTGggJn5ZOlCsmi8wAu+oiaoUCoftZ27EZuQMaP42F4s/B20lr4b+/DP2LYiEtDTDYxulyOliit9xegmTyzHaQiyjCY3KHPanvQVMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761556512; c=relaxed/simple;
	bh=aCiL81SvwOvGaN13+RPD9P7QrhEmNIPF5KTv4Mbu2ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbLp2J4M7NvBf+xqIGYVIoYfSNbAjadjl1y0uZYKfi47gDgxdAva5lT5A/RxN6DTOZTJ4DmpXKANbvySU9kHGJHIWV3ZvxxT8hSIF/bl7trsu4HXWXCKNAzg8aF1lw5UoBrl77zpsk4i1gXiMJzwnrnDb7G5SlerM1I3EfSGSYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQ6Gd4cA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761556509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7h6QWv8WcClAlKLHLUfdbnGWxWPalV8PKglJ6+42v7o=;
	b=dQ6Gd4cAzxSM+XHD0gDab76YM/EmZ48VvwxUF/cjWqJ85GskSxYQ4cT+uXME/+GcXoqX/c
	klg0C3POfHuOm0dL+7pGURYULKCvqs8c+umpAr3STCtFTfLVNP4FnL4Gweq8f/AMRPBtQL
	bVaWEVpEZQeYyiPCDYhIm3KmVmIqSk4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-zXTpBSR9M9mzeofQ-U_p7A-1; Mon, 27 Oct 2025 05:15:05 -0400
X-MC-Unique: zXTpBSR9M9mzeofQ-U_p7A-1
X-Mimecast-MFC-AGG-ID: zXTpBSR9M9mzeofQ-U_p7A_1761556504
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b448c864d45so418444966b.2
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 02:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761556503; x=1762161303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7h6QWv8WcClAlKLHLUfdbnGWxWPalV8PKglJ6+42v7o=;
        b=Ftlh+to60XcMZDpTnPhIJnUtXrwrYeM8kTWBI6PUTMb27eCI1UUQ8LlnooRdLl34le
         4Jeyap6s9UNXmOiKFPFVWRwwl2DpofQ/lTkwcuS9Es1KfcYmRcrxb+S29oNA0uchjjaV
         rAg+pRhLVNpJpJOZGvHkdwwvlNwhyLt9FInb0oZVTKo3KeCq/LnOg0qOVCJX8Equo2MX
         WnFtDVhJC6IdMPXl+pqDaVx3ZsTJm3VycY7i/GG3j94hiOG7kMkQhGLYzNwfZoKG85ot
         LgBAv4WtmoQE+gViNd6SVC2OjNoW5tJqmU59wEW0EqwHWBaDDQsaUxrMFXDVzn9m4Ffh
         TvGA==
X-Gm-Message-State: AOJu0YyCVW4L8pHnPwDyR+uYqXYdm7KPaEMCeS6Bfjj1KyAzVvkM11P/
	DNHyET295t/Kl53hWE1T1DipWLplxANZqqt8s0QJkSHEfTooVdTJFFMa8hJdkO7t/4y11Lhtnro
	ZtBNhxo1BQ4vuP3YKQQDOiW9VbHw3h3dVdsP01PgoABpj6kOTMlZh9BnWmBDJFZl0x/FKsJIHk8
	ZRofUd8a9uW3TGKw1mPQIus66Q7iXznamotZWck7VENA==
X-Gm-Gg: ASbGnctE5dkmFtxpqRlFfhA+5gZ0ZwULbI6xc8lDPge/fvdSlq9aenNcyobYcJWQdra
	ngJk+b1kvYbX09rLb1v416c63XfgXl0/PWuiOrzNdT8yK3cE9d1cYYDkivDLWFNq7bDhIJBx6by
	DZkthyq5W7YpNfgsE6sZHCoxZrucDWHPDjlmrAyydLoguZGryTQzg/ZVtGW+2DJ/e5T8B35VZD7
	KImCCxMleAGLbErI6V5dlZvMegcQO8WZvn4M9A15O92yNgce0G17jjjjyysFnqPiyXNSflcO6ls
	xkOlo3MiREJraTMhBrNMxdrvVQD8rAgX3ckyq5bxMPNqU9xAdlyejddasmtgFFFUeCOWKL6d6r8
	eyu2KNyFHfT7Qt0mD4jpqBS+Ys4E15nCuNS/CYA==
X-Received: by 2002:a17:906:6a1d:b0:b45:8370:eefd with SMTP id a640c23a62f3a-b647254f631mr3882153566b.5.1761556503374;
        Mon, 27 Oct 2025 02:15:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTdfYk5+mMhbK+qxd8I7yWJOVduqrF3VF00VHZta1FomrBfgtBep9OwVqTDsf2cdgFXzm8/w==
X-Received: by 2002:a17:906:6a1d:b0:b45:8370:eefd with SMTP id a640c23a62f3a-b647254f631mr3882150366b.5.1761556502809;
        Mon, 27 Oct 2025 02:15:02 -0700 (PDT)
Received: from stex1 (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85338663sm701908266b.17.2025.10.27.02.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 02:15:01 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: stable@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com,
	mhal@rbox.co,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.10.y] vsock: fix lock inversion in vsock_assign_transport()
Date: Mon, 27 Oct 2025 10:14:29 +0100
Message-ID: <20251027091429.159730-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102616-navy-creatable-7fad@gregkh>
References: <2025102616-navy-creatable-7fad@gregkh>
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
Link: https://patch.msgid.link/20251021121718.137668-1-sgarzare@redhat.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
(cherry picked from commit f7c877e7535260cc7a21484c994e8ce7e8cb6780)
[Stefano: fixed context since 5.10 is missing SEQPACKET support in
vsock]
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/af_vsock.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index f04b39c601f89..36b65b45c5c7a 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -479,12 +479,26 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
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
 		 * This path can only be taken during vsock_stream_connect(),
 		 * where we have already held the sock lock.
@@ -504,20 +518,6 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
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
 	ret = new_transport->init(vsk, psk);
 	if (ret) {
 		module_put(new_transport->module);
-- 
2.51.0


