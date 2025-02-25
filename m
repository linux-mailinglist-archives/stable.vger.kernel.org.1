Return-Path: <stable+bounces-119514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3456AA441A3
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 15:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2AA3188AEBF
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 13:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA9A26E65A;
	Tue, 25 Feb 2025 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hkh2jGWO"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D24126E621
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491786; cv=none; b=MCmdVZls/vsq188hwgqgH/1dL2Ke/vEIe5ugkphmhnrc8pjjNtIjxGWNZf0t192riHTusBswsPbI66vs6ReT3HuPMdSFICSelkJWY3kJYpD+HfYvt/0Ksk+D2+8foiz7A3rhT2KwPRAgjJTuuqdp0GSEbsu/RqKLFqvjL1YkN7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491786; c=relaxed/simple;
	bh=TiCXB8u2P86GhZ7J+CUQial990BBeGMgEI7XFj89O2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TxA60HkyvSU1ILb67zP9yvWGrJwEghaiQe/tq6EsAU2oS9Mow9cgfO6wNOiQVAu30rQOdkpw01pFW3+PloZuqmApJo8vQ6yopE44QUw5RQEwhx6XbhKOi4qBa4ferBAr4witS+Ll/B7C9yE6/gCSoYsZWFjy+QaS2s1zLP1eJgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hkh2jGWO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740491783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ygmYHX7F/P9jBlXoI0l3kSczkjn6daAuzKCINT7JFw=;
	b=Hkh2jGWO1QGJpoInnqeR1vLpQZpqhoKT5QhTov4a8xCpxfdr3BGQxHJTywybXMbyhjTovM
	9sbPQkjuhl/MrvN62qTthZ79pyLSpzYQgzRpSpw0E4quIvMFQEn2iqJsTdKrEC6ZQ/NkYI
	2V03UKtFSAmmaY+Mo0HD9SoI48Jj//s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-Rbvj6Xx6N9irjxzpQ4IqPA-1; Tue, 25 Feb 2025 08:56:22 -0500
X-MC-Unique: Rbvj6Xx6N9irjxzpQ4IqPA-1
X-Mimecast-MFC-AGG-ID: Rbvj6Xx6N9irjxzpQ4IqPA_1740491781
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f2ef5f0dbso2069977f8f.2
        for <stable@vger.kernel.org>; Tue, 25 Feb 2025 05:56:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740491781; x=1741096581;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ygmYHX7F/P9jBlXoI0l3kSczkjn6daAuzKCINT7JFw=;
        b=Sk7iMpDAPC628m3Fmnumcqiv2w5X7yY8991YetCxlZW5FiBjg9kY079MZWJaL5BBDC
         87W/NCIe2gx9M4OuaOsB81htDWQavERpup60jx5n9lh+LHXk50ZN4CKfHcrLYLu6kglJ
         gf4FvTcIPZNTW9Uw812kNu4SNK7WiDRscAttZMq+ZRu5ftlabBb++AW8jzP48sh9UNUD
         oHNTFQn+27RKGKNqNE2muyz1ZejsOq0VCsyGPLRx9+8TbGkQRW7meC/WJakx4phtmuOp
         M7tvug4PuK/grfDVBSHDHzIIND3WSyY0UtVq4s+9/NkEc7kX9pwmbVn3etuKHJGnXjHr
         iY3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjW4LusZKmiMtVEp4wmHu4jpAwyAQoi0zZEVW3F+2mKYnTA7RE4M5jHgTsrDt7fdMRoiqaPw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3XG4QMSuAgRMKh7ZSjuFDIu23hsPNa9dmcryzm2uIuD941x+E
	HZ9WEoHnMKGpsH/Eypr0zWgMZQpandfQCFYcGq4sa6fH4bwpj1spyHlrV3GBMO5PB2PpwDheFl/
	LQSnU6CVtN4q5vt/diQuG1uf7rp0K4KST88a9URaJccqm4I5exdRdlA==
X-Gm-Gg: ASbGncvJCQMHDd7dHUCz3L6Rjy0XVwnAxtWR8tuIkTrNigy/ar2ZA0rMmje/i1CLGJP
	sKlbog0LuR/6MLHOq6Nr5K1WdX+l1xw0CoB7JJOcmJhaxep1iuJM6XSiP0NfUe/4BHijgFsgSJv
	yxiUk92xtn7UUjAykrxKaBC2ZNESq/fcdH4MYzO3jmEZo8aYQJpNgOCs7K54c8ij2tjri2Wy+nc
	79cxnmv4Q02Oki7clfntmbuh8HGTnZLTVCEWN5VYKCteHdxOduh7/RQGDRoO9wUcpvZhNdYBo2m
	xtLQGn8Kre46diayAcJPuJRBkL4b6WtR8SiyVHEtpnJkOf4+sGczdPaQEyMQnKeUf1tdKcA=
X-Received: by 2002:a5d:6d07:0:b0:38f:3f65:2ea3 with SMTP id ffacd0b85a97d-390cc602127mr2413857f8f.17.1740491780736;
        Tue, 25 Feb 2025 05:56:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVVfg4uGV+U1Zj7Ifyq6Wtu6sCGkhPMUW7GfJXdHfNHkqm8ZAIy6qiwpgRLMnaaiS+IDzHQA==
X-Received: by 2002:a5d:6d07:0:b0:38f:3f65:2ea3 with SMTP id ffacd0b85a97d-390cc602127mr2413837f8f.17.1740491780411;
        Tue, 25 Feb 2025 05:56:20 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86cd10sm2424181f8f.37.2025.02.25.05.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:56:20 -0800 (PST)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 25 Feb 2025 14:56:15 +0100
Subject: [PATCH PATCH 6.1.y 3/3] vsock: Orphan socket after transport
 release
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-backport_fix-v1-3-71243c63da05@redhat.com>
References: <20250225-backport_fix-v1-0-71243c63da05@redhat.com>
In-Reply-To: <20250225-backport_fix-v1-0-71243c63da05@redhat.com>
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
index b43aabf905f6ea24e4fb0ebc211ccff954ea0b13..e78c9209e0b45c7cc747bc433f8cb4f17bb18f97 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -821,13 +821,19 @@ static void __vsock_release(struct sock *sk, int level)
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
 	else if (sock_type_connectible(sk->sk_type))
 		vsock_remove_sock(vsk);
 
+	sock_orphan(sk);
 	sk->sk_shutdown = SHUTDOWN_MASK;
 
 	skb_queue_purge(&sk->sk_receive_queue);

-- 
2.48.1


