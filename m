Return-Path: <stable+bounces-203406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB0BCDDE81
	for <lists+stable@lfdr.de>; Thu, 25 Dec 2025 16:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81F593008EAD
	for <lists+stable@lfdr.de>; Thu, 25 Dec 2025 15:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7804C145B3E;
	Thu, 25 Dec 2025 15:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="NuiAQ4Ul"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB6A54774
	for <stable@vger.kernel.org>; Thu, 25 Dec 2025 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766678029; cv=none; b=bPJTsBktAHpBRx2SkynN16zshWqF6gl6/v+a7GWhRunxd7amPjUKjuGYhZKx/sI/0vdOVDA1Nq4ysC0YWZjuPb7cBh3YN5kM7Pk7tLlj1S9doulrnK9qE33qkmiOPB2yErhzyuoczLBNb6c+RZQ/JMAEtDG8DGecVH0S98gGask=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766678029; c=relaxed/simple;
	bh=H6ZTwvtAU2w0z8rNyXZSCt83bq0uq4SOpKq/8QR1aH4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h8WuYvkINepYC0yiomlmDVZDJz1XdiBpUJZ3EBWrmEvLe1/HAIw8fg8pFVqIr62JbbG1lp4l5Gq56XND9WrnpyXk1dPiQZZ14blf57vW6XJYi9tw5O7eUFNbhVfiGB6vw9xSovUnXJost89g1hlQ9Hb4GbVRRR47YOeTr3zQqVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=NuiAQ4Ul; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a097cc08d5so14826095ad.0
        for <stable@vger.kernel.org>; Thu, 25 Dec 2025 07:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1766678026; x=1767282826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e7vp3zru4lXBS6Cv7RU5Y4CNnXqTQsOis0taz+tYMSU=;
        b=NuiAQ4Ul01jLGmWCYbZxRaaegWPBJOzj6XhzjmP/MA3qyIDNZOWVM+YvCVU5v5RH11
         xZ5O66GoC+tdo/kR+aDCglX4aGcWKRyUlXeE0JB2qlsB8Bq9szIXF2SwONtAEVs+gO8Z
         U3owP5kQXAeV+aw1Rboar8Qi07TgaT0DBPWH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766678026; x=1767282826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7vp3zru4lXBS6Cv7RU5Y4CNnXqTQsOis0taz+tYMSU=;
        b=jvFSHjOwVhFaQIO0+ra72IIUflhIMy4JxCpijb7y0L9KJv7vyKTzHXtJ5Mbdp17ztT
         e4AO29xPCN12pi0wgWWnuM0nmmnmlz1hx53+F1F9azaVW7rS3FS4kvDp03KAbq+6uF7s
         yyR+5AAMCGMNeno1ZClEK7tpgrn5dun5bH/t7G2CBnaoHahIg+iUTIYQV3qiJ0S1p0Ok
         qBtvHlKwWguxov3n+5RWy+pfUuKUgJV+/CqPzL97/NkPxgoGPxf3vxEniGZZHagZqDqJ
         /Lr02FGs2KvyPK3YejTcp4wEfh2+yMxV4nopCRfmI5pwSVzm40DIFCiaKORMB+3jnC3V
         tAcQ==
X-Gm-Message-State: AOJu0YyM2SHfy+GgWMovz+qtUA8FHeo9VKplyOm9eOLpfEhjaoFjrayz
	vRwQk3mkBP5a/vlHRfWSnEmpuUarFXWnV3HSBK/KIqqBEkLaWkao8Jgt9GZ01o7kuI3ZSabbDB2
	xKtI5
X-Gm-Gg: AY/fxX43GKaGUvnGf7nCi4UWe0oWmAUQatC3kWb2Dsxb1WSwlq0fKak7qVOGbPq5A1P
	4oi7P2OnQyO0LB5q92siyb27oM0fIrsEKcWE5NzbZulxssTvG9teTdHZNdwmxHr31g57f34eO5S
	4JF1ffk+f+FeIE81EzOg5viFMWm8NfWt+6vkF3usOVBkaoOS08LIlTzTEX2fqbkA2YDBoOv9FLh
	zfTVYdbQ6uPpmzgk6nyBO5HcK3FAv+URVLba0vbl8Hoty2f7qjgKPDNgLVJsMLm7tvALz3Tv6AE
	yaJI/y4YKO4IXiOWrZnGZYQmAuteofkQNzDjLayEhmmRQNesommd8W15R6AkQH6Z3QUSinaw5M+
	gLOp+co1h9/W7A6tT2j5cKYjgQbAzo4QvkbdhM9wXaf6GeNIypj4KcccsW59jp5RRKPTj8vIr+6
	Sc6cxhCEW7DqabySgsR0+NbQ==
X-Google-Smtp-Source: AGHT+IGf8qQI+0t0scRoeRm24Lf3HEHF4njZDdAAodEwEJFesVCjwl4+FHMUeVrTAqfpIDKa0Z9edw==
X-Received: by 2002:a17:903:6c6:b0:2a1:3cd9:a742 with SMTP id d9443c01a7336-2a2f2a4f97emr92527515ad.9.1766678026297;
        Thu, 25 Dec 2025 07:53:46 -0800 (PST)
Received: from MVIN00229.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c667cesm186553485ad.18.2025.12.25.07.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 07:53:45 -0800 (PST)
From: skulkarni@mvista.com
To: stable@vger.kernel.org
Cc: Shigeru Yoshida <syoshida@redhat.com>,
	syzkaller <syzkaller@googlegroups.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shubham Kulkarni <skulkarni@mvista.com>
Subject: [PATCH 5.15.y 5.10.y] ipv4: Fix uninit-value access in __ip_make_skb()
Date: Thu, 25 Dec 2025 21:22:37 +0530
Message-Id: <20251225155236.1881304-1-skulkarni@mvista.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shigeru Yoshida <syoshida@redhat.com>

commit fc1092f51567277509563800a3c56732070b6aa4 upstream.

KMSAN reported uninit-value access in __ip_make_skb() [1].  __ip_make_skb()
tests HDRINCL to know if the skb has icmphdr. However, HDRINCL can cause a
race condition. If calling setsockopt(2) with IP_HDRINCL changes HDRINCL
while __ip_make_skb() is running, the function will access icmphdr in the
skb even if it is not included. This causes the issue reported by KMSAN.

Check FLOWI_FLAG_KNOWN_NH on fl4->flowi4_flags instead of testing HDRINCL
on the socket.

Also, fl4->fl4_icmp_type and fl4->fl4_icmp_code are not initialized. These
are union in struct flowi4 and are implicitly initialized by
flowi4_init_output(), but we should not rely on specific union layout.

Initialize these explicitly in raw_sendmsg().

[1]
BUG: KMSAN: uninit-value in __ip_make_skb+0x2b74/0x2d20 net/ipv4/ip_output.c:1481
 __ip_make_skb+0x2b74/0x2d20 net/ipv4/ip_output.c:1481
 ip_finish_skb include/net/ip.h:243 [inline]
 ip_push_pending_frames+0x4c/0x5c0 net/ipv4/ip_output.c:1508
 raw_sendmsg+0x2381/0x2690 net/ipv4/raw.c:654
 inet_sendmsg+0x27b/0x2a0 net/ipv4/af_inet.c:851
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x274/0x3c0 net/socket.c:745
 __sys_sendto+0x62c/0x7b0 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0x130/0x200 net/socket.c:2199
 do_syscall_64+0xd8/0x1f0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3804 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc_node+0x5f6/0xc50 mm/slub.c:3888
 kmalloc_reserve+0x13c/0x4a0 net/core/skbuff.c:577
 __alloc_skb+0x35a/0x7c0 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1318 [inline]
 __ip_append_data+0x49ab/0x68c0 net/ipv4/ip_output.c:1128
 ip_append_data+0x1e7/0x260 net/ipv4/ip_output.c:1365
 raw_sendmsg+0x22b1/0x2690 net/ipv4/raw.c:648
 inet_sendmsg+0x27b/0x2a0 net/ipv4/af_inet.c:851
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x274/0x3c0 net/socket.c:745
 __sys_sendto+0x62c/0x7b0 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0x130/0x200 net/socket.c:2199
 do_syscall_64+0xd8/0x1f0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

CPU: 1 PID: 15709 Comm: syz-executor.7 Not tainted 6.8.0-11567-gb3603fcb79b1 #25
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-1.fc39 04/01/2014

Fixes: 99e5acae193e ("ipv4: Fix potential uninit variable access bug in __ip_make_skb()")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
Link: https://lore.kernel.org/r/20240430123945.2057348-1-syoshida@redhat.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Shubham Kulkarni <skulkarni@mvista.com>
---
Referred stable v6.1.y version of the patch to generate this one
 [ v6.1 link: https://github.com/gregkh/linux/commit/55bf541e018b76b3750cb6c6ea18c46e1ac5562e ]
---
 net/ipv4/ip_output.c | 3 ++-
 net/ipv4/raw.c       | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 1e430e135aa6..70c316c0537f 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1572,7 +1572,8 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 		 * so icmphdr does not in skb linear region and can not get icmp_type
 		 * by icmp_hdr(skb)->type.
 		 */
-		if (sk->sk_type == SOCK_RAW && !inet_sk(sk)->hdrincl)
+		if (sk->sk_type == SOCK_RAW &&
+		    !(fl4->flowi4_flags & FLOWI_FLAG_KNOWN_NH))
 			icmp_type = fl4->fl4_icmp_type;
 		else
 			icmp_type = icmp_hdr(skb)->type;
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 650da4d8f7ad..5a8d5ebe6590 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -634,6 +634,9 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			    (hdrincl ? FLOWI_FLAG_KNOWN_NH : 0),
 			   daddr, saddr, 0, 0, sk->sk_uid);
 
+	fl4.fl4_icmp_type = 0;
+	fl4.fl4_icmp_code = 0;
+
 	if (!hdrincl) {
 		rfv.msg = msg;
 		rfv.hlen = 0;
-- 
2.25.1


