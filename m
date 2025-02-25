Return-Path: <stable+bounces-119510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2D6A44177
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 14:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95EA57A95DB
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 13:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F5126BD9F;
	Tue, 25 Feb 2025 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XOkPOSOm"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F9D26B2CE
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 13:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491617; cv=none; b=DOIOuZdhyhLfw6b35iRiIicEVrGWgui3IkpgregMHg3DKV1hTizHYwLfWOiV9ZR8mWzas028+BdgALwkW9seShgTX28664RUb9xeeCi0Ne5KKsgM+LWTcQDgMIa+RbqoOnt2oUiBAyQdMHw8tzx/ApdqjFyj7agVO6vcwdmCGtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491617; c=relaxed/simple;
	bh=u7DFqbIf6aBe2SdWkoI4ROF9PfyQY6o88Lm/mxybyg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KG5UGYC0MWQIfsyhno+9z0EFXodyUAAw3KStkJR7jT1Cc05nJpc53nMdlmrewYfgLTljqKkCHmPFp57+clydw3cLiTRhCEh3G8mgK+maTYe/VOn6n8tBfb2o6l7eihnLtXfa4b9QPsbecvQj/7d/HLqENoo97FtqQOXtDvMqBf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XOkPOSOm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740491613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqwv+kCtW8wXKVOK9VnyZgm46aBreFsgha+kWwqgBfk=;
	b=XOkPOSOmA3s7HKP3Km8ggwhmW2Ma9KFvi9FlWyWBZLpIs2J/IxqwrykMtMENkEfU/GLcFz
	gMolcny/24b7rDVVeV96riMdW9Y9OIPiuVVaQH0EeuEu3O9xspE2kRjXmRzOP5Nq+3bZdm
	QZih458zefJNH/IIrdhkf+Dy7j4V0xA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-Eb-Zsq3vNZaHoq2WZ0L_EQ-1; Tue, 25 Feb 2025 08:53:32 -0500
X-MC-Unique: Eb-Zsq3vNZaHoq2WZ0L_EQ-1
X-Mimecast-MFC-AGG-ID: Eb-Zsq3vNZaHoq2WZ0L_EQ_1740491611
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f4e47d0b2so2587728f8f.2
        for <stable@vger.kernel.org>; Tue, 25 Feb 2025 05:53:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740491611; x=1741096411;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqwv+kCtW8wXKVOK9VnyZgm46aBreFsgha+kWwqgBfk=;
        b=vdaVDj0nJCYY5TvEJvsL0VCTQlR4y1pYZk4cSCG5qaHoq1hyxde4EUg1XJqgPG2wwK
         8v34m2UxQnFLs/qRGoR0QlpT3cLFZeU2vDa0T43VOqsYRD9MiJTN6l/i6jWSYe9OnAJ1
         iqLcK9tKhw2zPSoP9r61MvXv28oGYth88k0zt47ZT8SOodg2wW1eS6miJMPlcAC8REHk
         G+YsImpw4lv6H43BD0bzQfHTaxNSj81IaPMk2MkiARNU1LWGsAqyIpKLeuFjI2UES2Mx
         dMRrwptTLr06uyUYmawl0cNq6QGCq+8HPvx9qLRsXqfYr+B4IIWK+jQwcYwzIkIGYVYN
         eNzw==
X-Forwarded-Encrypted: i=1; AJvYcCW7x7L0rBQSbXmVKZZp7/nGE/TtpTG5aWK3hobBjbgQdoIOGmrW8K0QxZ1uOc4su0sC/GfZt4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNbSKYyOQyjmAhyoTGPzl0M7qKZSnStryt34EKFWdFROw+0via
	L2G3PIowjyaDd2uDJQ82Xke6gur11yH975TzulyXnnM3jAGgayRo4cUId4GJ+WAoDT3XPmPT6cK
	e1vGTy89lRDds5WCOQPYXqaBph+OdHAtf3UjoEPAHgQgk/8MxX+gnlw==
X-Gm-Gg: ASbGncuTn9fp8nQTGPw31HZGt0gLubCHQ5MvNkqw9jhwJQJJExRX2xC7ANS8qnH9xi9
	zu50OMZ2df5UH7MD4+q2AqhRofdG3Sk3a/vHmlNB5yxZ71ntyowJ2Uzy2u2Ndu33EHm1hUAj6gy
	ol4c4CtH8Ec5mBPPvqv2a0OEYFe6kxJEs3Aqu6TyVvnBttGaZefwZ5dfkajkKZimXd0rohjqOVw
	wo11LcJzvEPdLeSejnI5AQpSnjFWAVYpDYheXbOMX4mVJ7Cri2FD0J3c1St/VDKT2Dh5SECgVfZ
	6nAeXlK1JR+Ww/s+vPC2McsUCqQUKF37RfeN01obNQo4dK2YwKQq6F7FYLo9TthycYnsKzc=
X-Received: by 2002:a05:6000:154a:b0:38f:4251:5971 with SMTP id ffacd0b85a97d-38f6e753b0bmr13461332f8f.6.1740491609808;
        Tue, 25 Feb 2025 05:53:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF50+Wp61jsDeYzAsE3QIMnwmZfeCoCLkGq/zdgOebxdgg88e8DzJEdmJsl3YUaMpC1iu55kQ==
X-Received: by 2002:a05:6000:154a:b0:38f:4251:5971 with SMTP id ffacd0b85a97d-38f6e753b0bmr13461267f8f.6.1740491607985;
        Tue, 25 Feb 2025 05:53:27 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86ca9csm2362323f8f.22.2025.02.25.05.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:53:27 -0800 (PST)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 25 Feb 2025 14:53:17 +0100
Subject: [PATCH PATCH 5.15.y 3/3] vsock: Orphan socket after transport
 release
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-backport_fix_5_15-v1-3-479a1cce11a8@redhat.com>
References: <20250225-backport_fix_5_15-v1-0-479a1cce11a8@redhat.com>
In-Reply-To: <20250225-backport_fix_5_15-v1-0-479a1cce11a8@redhat.com>
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
index f922c4681dd9075ab01d1783178f1fe4f491260c..c7a786c7420ab58934091c026537bf29fe9e8374 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -818,13 +818,19 @@ static void __vsock_release(struct sock *sk, int level)
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


