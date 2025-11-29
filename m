Return-Path: <stable+bounces-197637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08676C93B8B
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 10:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 16B453486C4
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 09:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E85A275AE3;
	Sat, 29 Nov 2025 09:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="hhvMO3gE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD212737F9
	for <stable@vger.kernel.org>; Sat, 29 Nov 2025 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764409053; cv=none; b=i6bM+uaX7WAR7VLX/JI4nXy0QX+8sLuzbhXkiGWRjzBsfwr2UXX8Qjhk2aTt7MCRYeVaxHKf+uG6ShF6iuIX7boN28b2ovdr8jXndRc7/MeeMcMIF/QAZBgsK/Mflegraaqwr/SuBgzl4/8h1IM1b1s1drA/9zjXJnYlQdyIrpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764409053; c=relaxed/simple;
	bh=ZlTvxu3VWssXrEln8HvuE9rP2j0RUbWa4IrghVjwy5M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TY68+yrf7MJZV/1HjJ92sIRjqa5OJdTT4fr20bNbblEpDYlKZHAH3ZlHhTg/F1dN1bZD/7WBlak/pg6Y9+VK8FrunWGjGA+a3ioGMG6Mnip2/q4hfvkCJNX5lRNiP1LnIpm52D4kHHznaQbmbmJEmi9lYifD3F9d9eJPK/sgjbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=hhvMO3gE; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2957850c63bso18907065ad.0
        for <stable@vger.kernel.org>; Sat, 29 Nov 2025 01:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1764409051; x=1765013851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jGXKKxMGK1eysZNyH6QH0SU/9g3Orh82OvwO5tAJksY=;
        b=hhvMO3gEvKcsgY1equvmoKoj5AZan7EXQc7pQvj69X7UhuCMposksLrAhKbTG8Z+th
         I2oMG0aHSgsVM/jCn/OjnlGkyHI4bCw+5ASo7qKfnGn3dMS+exo5cuiRycgvRQP+VqnE
         JiQzYAoJwAsaLTQKgsUGwbQpD9M8ggouq5NWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764409051; x=1765013851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGXKKxMGK1eysZNyH6QH0SU/9g3Orh82OvwO5tAJksY=;
        b=uWItAjTuQUKpEY+VxmsXP9DM09QV4BmrH/KDiLeSfudFnsxY3XPHht4JpanvcPTo7Y
         aTFgqYIrVXCojUYJUMwLRgOey8LwVMvLV3c/N/hlSpcuXW7jl9uaCpilvFReVcfbWddY
         r4IK/ObrzrMhPuBRNmSNLJ4aH4QWj33aceEU3pVCEiGYoDPzO1sTzKCT01tmAxOxbEbp
         sRwEOMOs6x90bvRK+NKrncHn1IaH+RU4mXnQo+JL3z/mLVRGTIyqo3/qbzgpqbGe7i9Q
         URcLqd9lX9hWA7dkN3vvRJpbY4yeo/C2L88qyMLYSInqo3wCe4GINeqML9viYW1IB6Zh
         VT5g==
X-Forwarded-Encrypted: i=1; AJvYcCVBWYoJRqecWemjc5zpKSDgjJlYA3XAKDSKxSjzMCXn+x01PdEp3GnuCI9VOFLP98KY2RreVTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI5BXgbIN5+L4bhThjRohcgmKNyjxk4GRVOTFxK0dHyvSIlZyR
	U3VOnegy0MNaQtxg3mngPrnC/lEm7WudzLjfxxqVmsvgN4Z/hYqlXeJ2W0lN0F9pudw=
X-Gm-Gg: ASbGncuYVAeViMw09y0jum6UJl6eJRld6IfeDX0+TSXCYbXuO+z5JVDYt2H5/+70soh
	kMf4GJUQN30/TPEHTmqduzumhFLv9QL7q1rDRmSLlV5m2U1A6R0fyqpOrneg59HsKBIi0216c+8
	eZHYq2wooQPg6bgafESXd4FFeMqhBa6Mf4BJGbVndfyah1mpW/S2cYy7P99Wqok+Zk7ppTVnhT4
	u+8XeZuL+IXNxUyGwuDGBMJIbYISKrwcwO59f4DHAz+JpQeHf9OvIAtjVlofH56QGXvIHXTlrVv
	P0ThshXLyoM6iuJz7qbqB+8uW37KSMXGxiqiqeG8Oofvumef/HmrYaU+XTk0/byDdSGXqKz5Go7
	kfq2je/9nX+uH1Sveqno8+ExZZpDLozplJfIHTeV25fE/2TIef7e805ysWXjXz+KIfOOKlO2eyU
	cI9WijtGjS9A8g0h0wlgdyT3aonWmL2G3dEdAUep7CJsII+Fy44lwPkk7hyPY=
X-Google-Smtp-Source: AGHT+IEI8230ifO4LYJAs7VvXkSTCZgJ9OOKZGhnRbVSZR7l7RNsQuwaVaZI1pZEkHGHHbd0YQM1Pg==
X-Received: by 2002:a17:903:98c:b0:299:dc97:a694 with SMTP id d9443c01a7336-29b5e3b86f5mr378476365ad.24.1764409050232;
        Sat, 29 Nov 2025 01:37:30 -0800 (PST)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([2405:201:31:d869:ca83:6d4:140:3932])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb542a4sm67075505ad.86.2025.11.29.01.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 01:37:29 -0800 (PST)
From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jaakko Karrenpalo <jkarrenpalo@gmail.com>,
	Felix Maurer <fmaurer@redhat.com>,
	Arvid Brodin <arvid.brodin@alten.se>,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	syzbot+2fa344348a579b779e05@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH net v3] net/hsr: fix NULL pointer dereference in prp_get_untagged_frame()
Date: Sat, 29 Nov 2025 15:07:18 +0530
Message-Id: <20251129093718.25320-1-ssrane_b23@ee.vjti.ac.in>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

prp_get_untagged_frame() calls __pskb_copy() to create frame->skb_std
but doesn't check if the allocation failed. If __pskb_copy() returns
NULL, skb_clone() is called with a NULL pointer, causing a crash:
Oops: general protection fault, probably for non-canonical address 0xdffffc000000000f: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000078-0x000000000000007f]
CPU: 0 UID: 0 PID: 5625 Comm: syz.1.18 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:skb_clone+0xd7/0x3a0 net/core/skbuff.c:2041
Code: 03 42 80 3c 20 00 74 08 4c 89 f7 e8 23 29 05 f9 49 83 3e 00 0f 85 a0 01 00 00 e8 94 dd 9d f8 48 8d 6b 7e 49 89 ee 49 c1 ee 03 <43> 0f b6 04 26 84 c0 0f 85 d1 01 00 00 44 0f b6 7d 00 41 83 e7 0c
RSP: 0018:ffffc9000d00f200 EFLAGS: 00010207
RAX: ffffffff892235a1 RBX: 0000000000000000 RCX: ffff88803372a480
RDX: 0000000000000000 RSI: 0000000000000820 RDI: 0000000000000000
RBP: 000000000000007e R08: ffffffff8f7d0f77 R09: 1ffffffff1efa1ee
R10: dffffc0000000000 R11: fffffbfff1efa1ef R12: dffffc0000000000
R13: 0000000000000820 R14: 000000000000000f R15: ffff88805144cc00
FS:  0000555557f6d500(0000) GS:ffff88808d72f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555581d35808 CR3: 000000005040e000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 hsr_forward_do net/hsr/hsr_forward.c:-1 [inline]
 hsr_forward_skb+0x1013/0x2860 net/hsr/hsr_forward.c:741
 hsr_handle_frame+0x6ce/0xa70 net/hsr/hsr_slave.c:84
 __netif_receive_skb_core+0x10b9/0x4380 net/core/dev.c:5966
 __netif_receive_skb_one_core net/core/dev.c:6077 [inline]
 __netif_receive_skb+0x72/0x380 net/core/dev.c:6192
 netif_receive_skb_internal net/core/dev.c:6278 [inline]
 netif_receive_skb+0x1cb/0x790 net/core/dev.c:6337
 tun_rx_batched+0x1b9/0x730 drivers/net/tun.c:1485
 tun_get_user+0x2b65/0x3e90 drivers/net/tun.c:1953
 tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1999
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0449f8e1ff
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 f9 92 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 4c 93 02 00 48
RSP: 002b:00007ffd7ad94c90 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f044a1e5fa0 RCX: 00007f0449f8e1ff
RDX: 000000000000003e RSI: 0000200000000500 RDI: 00000000000000c8
RBP: 00007ffd7ad94d20 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000003e R11: 0000000000000293 R12: 0000000000000001
R13: 00007f044a1e5fa0 R14: 00007f044a1e5fa0 R15: 0000000000000003
 </TASK>
Add a NULL check immediately after __pskb_copy() to handle allocation
failures gracefully.

Reported-by: syzbot+2fa344348a579b779e05@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2fa344348a579b779e05
Fixes: f266a683a480 ("net/hsr: Better frame dispatch")
Cc: stable@vger.kernel.org
Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
v3:
  - Keep only prp_get_untagged_frame() fix as the other two
    NETIF_F_HW_HSR_TAG_INS checks are not needed for this bug
  - Move NULL check immediately after __pskb_copy() call

v2:
  - Add stack trace to commit message
  - Target net tree with [PATCH net]
  - Add Cc: stable@vger.kernel.org
---
 net/hsr/hsr_forward.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 339f0d220212..aefc9b6936ba 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -205,6 +205,8 @@ struct sk_buff *prp_get_untagged_frame(struct hsr_frame_info *frame,
 				__pskb_copy(frame->skb_prp,
 					    skb_headroom(frame->skb_prp),
 					    GFP_ATOMIC);
+			if (!frame->skb_std)
+				return NULL;
 		} else {
 			/* Unexpected */
 			WARN_ONCE(1, "%s:%d: Unexpected frame received (port_src %s)\n",
-- 
2.34.1


