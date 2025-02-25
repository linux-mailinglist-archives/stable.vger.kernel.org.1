Return-Path: <stable+bounces-119524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C920A442B2
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 15:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B173BE28E
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 14:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA72226A1B4;
	Tue, 25 Feb 2025 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NeWrCmGk"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F51426A0CB
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493610; cv=none; b=GtVq4erfT9ka1Ozvc2zT2npfhmvEAWG+3FoYRgd/FP3jGclclQr8Lq/7qsvLmRU6K3NSWhBtTwBIROiuzg0Sh1ntxzOe6e8issBNW0Y74+/DklOdDZrM/56KuaE4BiQcXO4Bz1lcSUS5cX69dpqGUa/9FLnigmqHwnSFFwXKG1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493610; c=relaxed/simple;
	bh=GOh4+50PRvLp9ZgJW6cr/Gcfi4LzA6IJSZaOKCZ4/Ms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HXltV/Bf7gNApLXMEefnwZj9DBHUOlZuRVXAVOg89RwqEqOFzfIoa0JiKg0WT/ukbrYKOUIvApB33puH7PR+OWd/wB3mIm2hebzigwSCMZ4aVblYaeQd1J4p7SOIkHa3ebhboAl0txDvmLsz3kClBdHF5vsQPzyOQZj8DOZITuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NeWrCmGk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740493608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hbO+fJSJT9+crDzXbYNXdCbbAXk45+sqJkD6HwBBjeM=;
	b=NeWrCmGkWqxKvvf51TSfdMnqxp3hAq5HjgB44WIMWnF8nR+tvh05vcbCyMk26ZaCo7qtuv
	OD9Q3hk+74txef1txf9cXD2EPwbGD3w0xaUyBynjMtETgWq7Rfa4sZ8nXZGRL7CqDM3xmK
	Oq7HUPOgwpY78h4hjoeqAJ6Pyh2UVHk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-LRSXOXNOPSyh7NVThFK6Tw-1; Tue, 25 Feb 2025 09:26:46 -0500
X-MC-Unique: LRSXOXNOPSyh7NVThFK6Tw-1
X-Mimecast-MFC-AGG-ID: LRSXOXNOPSyh7NVThFK6Tw_1740493605
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f255d44acso2478418f8f.0
        for <stable@vger.kernel.org>; Tue, 25 Feb 2025 06:26:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740493605; x=1741098405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbO+fJSJT9+crDzXbYNXdCbbAXk45+sqJkD6HwBBjeM=;
        b=fVAmOKAArRKA6kXKoavuRYWrpDGRILVoBsWnyuqkLpVjEKrqa2FsnkOtfsjyG6x5h9
         yZ0o8t38cBtCQWbLNx8nRCyp10gJwUBJc/HuO6rZBb/UumrHibaUlfobo12KAHcvvbP1
         ozHStugODpkuSzaGBesJB8N/52rRt3CIdXNVphHj6XAc2O6kh+W1s+4RwmQpq2aV9eDl
         00PV0CVaPBXGILJAddQwVy+ewHU+OCCyVEPoeBVQ+MO0YM/BXERr6JJpyT3Jlkf08Wa9
         1Et6HY8pfunRUxbJdWInq2MnKm0Trv5oCZBWAQSIW+cDtJ7skdHGnImkWMG4KwyaqNkf
         /4Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWCtBm3plpOnQH5d0i7n4VYHlsE61KQCZG9VwzfYfMShsJjrKshKetteCUEbjFN92ARePZgfMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhGOuP1JZ9KaRV1JMLhf3O5nTne9jUj4Ux6101zjkHEZJUhPRH
	9mC1LkFnW1LjjRWMqPXOIjjnGGINBZuZ0uALC0uVT+9ia9/FcD9K3zdsTZsreET+TSorUJr5kq8
	3umDfWLhGIQtpl8ieBdNMk/4yjdjq3E7gLVV3QAVIt4hCfKAzOIY0QSvJkYjc/PT+
X-Gm-Gg: ASbGncvyJr8fBLEA5e5f5sm0HGP6V321vHqVi9N2hn7Txv06t5OOW0pQoVxp6KGq/zF
	PRUCNBOSXDcI1eSCjmmRsqTr1cvNghqS9TWbVGDfgZU3MiIv+bUKtf3leTF6PJ8dFnRub3nNbin
	5mC0Rmv1KYIDCu4Ueh/vYOHsJsEFfiSJ3kwq1lGsORICxF/uWy8iwgxpQuFFrqJ5vdYcuVr/el0
	T1zzlMjwOtOF7R4NRPkr9nyBzxCVRf00D9UnZKvj7tRtwX3FF2uYZpu4mLVznCk2/ik4dzXxOFJ
	7Ubp+L9wPtVWOijQ8KOUZndN4J66wPA3qWp4aCXTBGm9dEdHufXrpw8b66l1F7j98RbfMas=
X-Received: by 2002:adf:e10a:0:b0:38f:4d91:c118 with SMTP id ffacd0b85a97d-38f6e979275mr13182723f8f.28.1740493605265;
        Tue, 25 Feb 2025 06:26:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnPSIoPX5YvlHVigLzVhkLdX9vwpuv8B6+pTWEF60jHbArNijXZhKqHKP8JBdGBJcZSXq4Kg==
X-Received: by 2002:adf:e10a:0:b0:38f:4d91:c118 with SMTP id ffacd0b85a97d-38f6e979275mr13182631f8f.28.1740493603416;
        Tue, 25 Feb 2025 06:26:43 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8e7108sm2494009f8f.69.2025.02.25.06.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:26:43 -0800 (PST)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 25 Feb 2025 15:26:30 +0100
Subject: [PATCH 5.10.y 3/3] vsock: Orphan socket after transport release
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-backport_fix_5_10-v1-3-055dfd7be521@redhat.com>
References: <20250225-backport_fix_5_10-v1-0-055dfd7be521@redhat.com>
In-Reply-To: <20250225-backport_fix_5_10-v1-0-055dfd7be521@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Michal Luczaj <mhal@rbox.co>, 
 stable@vger.kernel.org
Cc: Luigi Leonardi <leonardi@redhat.com>, 
 syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com, 
 Jakub Kicinski <kuba@kernel.org>
X-Mailer: b4 0.14.2

From: Michal Luczaj <mhal@rbox.co>

commit 78dafe1cf3afa02ed71084b350713b07e72a18fb upstream.

During socket release, sock_orphan() is called without considering that it
sets sk->sk_wq to NULL. Later, if SO_LINGER is enabled, this leads to a
null pointer dereferenced in virtio_transport_wait_close().

Orphan the socket only after transport release.

Partially reverts the 'Fixes:' commit.

KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
 lock_acquire+0x19e/0x500
 _raw_spin_lock_irqsave+0x47/0x70
 add_wait_queue+0x46/0x230
 virtio_transport_release+0x4e7/0x7f0
 __vsock_release+0xfd/0x490
 vsock_release+0x90/0x120
 __sock_release+0xa3/0x250
 sock_close+0x14/0x20
 __fput+0x35e/0xa90
 __x64_sys_close+0x78/0xd0
 do_syscall_64+0x93/0x1b0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Reported-by: syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9d55b199192a4be7d02c
Fixes: fcdd2242c023 ("vsock: Keep the binding until socket destruction")
Tested-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
Link: https://patch.msgid.link/20250210-vsock-linger-nullderef-v3-1-ef6244d02b54@rbox.co
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 net/vmw_vsock/af_vsock.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index f3e520e127bc271810ce80152d1e05a9ed1bea42..8955a574719f2df6431cc9240f1bbb7f1b637b31 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -785,13 +785,19 @@ static void __vsock_release(struct sock *sk, int level)
 	 */
 	lock_sock_nested(sk, level);
 
-	sock_orphan(sk);
+	/* Indicate to vsock_remove_sock() that the socket is being released and
+	 * can be removed from the bound_table. Unlike transport reassignment
+	 * case, where the socket must remain bound despite vsock_remove_sock()
+	 * being called from the transport release() callback.
+	 */
+	sock_set_flag(sk, SOCK_DEAD);
 
 	if (vsk->transport)
 		vsk->transport->release(vsk);
 	else if (sk->sk_type == SOCK_STREAM)
 		vsock_remove_sock(vsk);
 
+	sock_orphan(sk);
 	sk->sk_shutdown = SHUTDOWN_MASK;
 
 	skb_queue_purge(&sk->sk_receive_queue);

-- 
2.48.1


