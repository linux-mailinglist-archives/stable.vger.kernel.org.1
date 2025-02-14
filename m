Return-Path: <stable+bounces-116440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ACDA36509
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 18:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2CE518938DE
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 17:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A76268C54;
	Fri, 14 Feb 2025 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWvV0giL"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657D0267711
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555678; cv=none; b=ZMzUyAthLU/8MoIGs5Dg50TRXyvzuzfDfNZm7E3+FuF5uFaPG+M2Sr3h508dJSZw4kPCuAUgovdhLEgqUq86Yn0lBoyVBL2pacqSkAw0mKfwtPaEWFnyCPLACmMB8/LZGR4Q8OaEJdtta4KUe5qriC1D3oblPjLILxCgYTRWA7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555678; c=relaxed/simple;
	bh=qipJEdHgJ47GQSK/XP3hYKqGBW5i9Fzi2XcLiuWw8pU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VLOzCjoQrlNTUCR8aGe/iL3dA32y8gHKDweuymHliOmcAXjZetBJRO/4+9n9Ducpgt+Ha2tW4t5E8/B2RgOq4UHwfTcC2inYS0O7Kzzb1gc0wqiA+4lC2i2j3XsYQ9+Yhl+3oOxlt/R2Q0sfZQRrYEEW4KWmPsLrZlOyTdhQp0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iWvV0giL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739555675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SiETjw8pdH7wPM9jDoTVGY2+q5/ftBwVGqbISOkw3u4=;
	b=iWvV0giLRbFWqgmP3ITBHHarC2vyIx2hLmCkDwWBK5chF7bJrBHNYhh/hOkwWYn+Y7/Brg
	PARmG56VgJFmC9miIGsXpGzh2nDgiM01Ku83SwXbfIbynr5rNtbg3858MbnIpiQHrgIaZM
	PIvQ7VM3PzZlxwFCawY0ahUnXzb8s8w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-YIJEkc7jPKSf2geB4idfHQ-1; Fri, 14 Feb 2025 12:54:33 -0500
X-MC-Unique: YIJEkc7jPKSf2geB4idfHQ-1
X-Mimecast-MFC-AGG-ID: YIJEkc7jPKSf2geB4idfHQ_1739555672
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f28a4647eso1137481f8f.1
        for <stable@vger.kernel.org>; Fri, 14 Feb 2025 09:54:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739555672; x=1740160472;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiETjw8pdH7wPM9jDoTVGY2+q5/ftBwVGqbISOkw3u4=;
        b=duHwRp4mBjMffnD+ZU+2f6oSnTp3F5usL3RoIu4YhtXfadgJyQLNRrpnEvWHYM5gWt
         lY9ccCTtuYr/PrpIsHm3MN1jHjz/EIjcAawGLC3IX1PNjQVwlcptPqGCwEqsD1Fta+4L
         bD7HHXGQYQLxvCUVWBcic4HWjx7dSw2rPGjpwnOUfGHIdRAJoNOBzTPkBoIkF847+cfo
         dXfsivjyCaK1hk3fptH8mCBc7plM9gCfI8qmBGsM/zOI0HSJT99Dge5lUY71t9r8lXw1
         o/hM7Pmz/q/IzVL0I656pouj5xoGpZRP5JQlIyGeIM+5qh2ty9sfIx7NLuMRX9+BcHkD
         T68Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/AyEl4Yi37Jm0P8BK8rN0P4ICXhZVAC+0h1jQbvL6tr+gjbuCMHKOKksOV8No/cex5nULias=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBYftq+1hT6bgxikmbC7y1w1u8y5z8ZVAb0DM7+WEtjcHxYRZ/
	xinCd2wCvIJFHxtQ0IukIxx/gg+OKTiyj00SrMN8BW8e8y2YTmRs5cSHmHgj57YXAxETNBUhISB
	bU18MkfRxI0EBJMB2vqoUpQmuoTrRhkdF8rJYUwgEFrmi3J8Wx05zeA==
X-Gm-Gg: ASbGncve65/JfOb3viSzhP2KQb7NmZKlTLP/wQjvkxDS4F3K6K0LPv8y/DnkVGkERtI
	Kmz9xL+b0GIFmDoeqRnYxnLBUOfd23X1bYi2argUAdxpLFLfKy4D0p6EQP3W3k/FNA+CAO+pLay
	w4mcWMtuORMqmqDJkDdqA0m86vh9o3az9lHmnpaFT42KVZgdXFaTvwCWh/A+w+MeQ0Y3T764Ldj
	k+6dreAIFEq1hppk5R3b3q6BAX/rzQjkX2/LvyJVpU3swnwRRdSbffN1ubK92bVflkCM/1ViDgm
	t00+OX6kzIfTHpAqw9nuDdqqYl29kI0lzxQ=
X-Received: by 2002:a05:6000:154c:b0:38d:df70:23e7 with SMTP id ffacd0b85a97d-38f245035f5mr9762842f8f.31.1739555672535;
        Fri, 14 Feb 2025 09:54:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWfCxyLEZsFviWXVhTorZEH4Rf8imU0qK6k+buvtVDSZP6DIXtzF6jbazx+++V4zB78XbuNQ==
X-Received: by 2002:a05:6000:154c:b0:38d:df70:23e7 with SMTP id ffacd0b85a97d-38f245035f5mr9762810f8f.31.1739555672200;
        Fri, 14 Feb 2025 09:54:32 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43961884e88sm49418365e9.26.2025.02.14.09.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:54:31 -0800 (PST)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Fri, 14 Feb 2025 18:53:56 +0100
Subject: [PATCH 2/2] vsock: Orphan socket after transport release
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-linux-rolling-stable-v1-2-d39dc6251d2f@redhat.com>
References: <20250214-linux-rolling-stable-v1-0-d39dc6251d2f@redhat.com>
In-Reply-To: <20250214-linux-rolling-stable-v1-0-d39dc6251d2f@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Michal Luczaj <mhal@rbox.co>, 
 stable@vger.kernel.org
Cc: syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com, 
 Luigi Leonardi <leonardi@redhat.com>, Jakub Kicinski <kuba@kernel.org>
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
---
 net/vmw_vsock/af_vsock.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index ec4c1fbbcec7418d2e715bad30845cd95a9b270f..37299a7ca1876e58ff516b5112d44b171cb896b0 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -824,13 +824,19 @@ static void __vsock_release(struct sock *sk, int level)
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


