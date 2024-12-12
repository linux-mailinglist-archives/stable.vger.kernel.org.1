Return-Path: <stable+bounces-103945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EB49EFF37
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 23:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4EF165AC0
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 22:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCD21DC19A;
	Thu, 12 Dec 2024 22:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QwJuupoJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4181898FB
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 22:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734042171; cv=none; b=aPaGp29vZ03gNdG9zt8iK+u4MC8jORJ+WB6CQFFd31C0Z2tAY3bCzjzFPFz5X9zYrswrK1UcDmLt9iUAL2oHlkLbXaphFpkSZ+A4nDOUTbbp/KRs8qfZMXdmrPodwpYrrvW7F95JzfpXFEmg98Iv4t+y/ed70+WPJzy/GgnM8x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734042171; c=relaxed/simple;
	bh=mYR85XkPv99mgY49elAAtDmoBwLsFWrGRtjvzlV2lMw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bl1KYq4br+v9QDmXXg+e039CkId4U3YJAV8NSpqgnq2smSuqUdk6xA4FYghdSLFnRXLyPKZv60iEDDEzloPpzrXaVXYIfUD5u8hKvyBDiM9ZpggA9W6D4BJML+cuVlwGbkK8cyLXVf5a6rIdvOMR8jZLwkXd1u0SmylmYd0SzQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QwJuupoJ; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7b35758d690so196199785a.1
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 14:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734042169; x=1734646969; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mEPfB9th6277+hdPLAjftJ4fYSDwY+ol/KJ9uoK9pPQ=;
        b=QwJuupoJcBmT+4VDDBJHrFRnzDON6GUAekzM5/1+EE5ALtdn2THHmUPWocx9EU89CA
         LN+PvZjHE4hv6RDPoWhNqZ/JXIyAP11gHH+JuhyysEGdWWiNs/nZ3bMt6F3So1Q03dRC
         5aZaf3OCf4RWxcbdAFkCDR3Eq1ym7M/SanTbI6YSgkLtcf+jonkIHU/RR+AWMFX89hUK
         V7QRpsAMLSlVoavGrepobw2YxfLxoHO94lorpSqzhv4jWAnLlNlcDb62HjsTW0O5JlWW
         +KxORWsp6nIF0NIn4g/uMEzEK7dsV0/jh5Kfm1z7yBvdt63O1WGe7Ytu4roVjnC2BTvB
         tpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734042169; x=1734646969;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mEPfB9th6277+hdPLAjftJ4fYSDwY+ol/KJ9uoK9pPQ=;
        b=GQHzw8Zj93q+gt8xEYDzkKZuzmT1KMvigo5XKCtzWB2b4P/bA7QlOi9g46xtpkbAfb
         qlANXt2Ncf3w/1v/9uQ8wl5U7sUFc2Oo4UwZ6BF5W9SO68mVk4sxbBLeEBqrWxVgBZ/C
         SbS2ryd4k8TEFhwuTWTlfEYpRy+L55UnJ8Gx/XyUqcLcVUrzRCiDKMW1F3+lLlN2OCt/
         ivrv/qNIR2ySo6VAloHFQJcgeEH+gdpFsfUpl6wNBuFLp6V2fnEq5bksczsnziEe6rsK
         eCBJaqBUIhpi+cnpVTCeTmYKUseFXsKR6v8nxFhvLwtM6yLZ1Mhis0O9NmBGb9VBvcqh
         5j0g==
X-Forwarded-Encrypted: i=1; AJvYcCXUZUIBrCOCNyUX01VctygPqBDQGC+R4j5Cfaw23INLguf5q1q8LI6FtZsgBPTYDI++ekJOAik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE8rppGHwvd2VGwrAnZ7pkYaxZgYGzAmnLFz3DagJuXPUlSb7N
	ByEm33GVV9jVpqHfbwlrO6YnGawf9bHQdyywXBkvuqmsLhXFcFeYt0kaeD0VSSSjaxpyLWKGdOZ
	0huKXbEdicg==
X-Google-Smtp-Source: AGHT+IG3QKcT19u3tKue7Af++4n+trcy46qQ2b0EAFNosiBK/eJ754xf5sUvQqp2hsksG9PM0K6tME4nWOHiQg==
X-Received: from qkpn21.prod.google.com ([2002:a05:620a:2955:b0:7b6:e209:1c29])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:27cc:b0:7b6:c540:9531 with SMTP id af79cd13be357-7b6fbee746bmr25541885a.18.1734042169099;
 Thu, 12 Dec 2024 14:22:49 -0800 (PST)
Date: Thu, 12 Dec 2024 22:22:47 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212222247.724674-1-edumazet@google.com>
Subject: [PATCH net] net: tun: fix tun_napi_alloc_frags()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com, 
	stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

syzbot reported the following crash [1]

Issue came with the blamed commit. Instead of going through
all the iov components, we keep using the first one
and end up with a malformed skb.

[1]

kernel BUG at net/core/skbuff.c:2849 !
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 6230 Comm: syz-executor132 Not tainted 6.13.0-rc1-syzkaller-00407-g96b6fcc0ee41 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
 RIP: 0010:__pskb_pull_tail+0x1568/0x1570 net/core/skbuff.c:2848
Code: 38 c1 0f 8c 32 f1 ff ff 4c 89 f7 e8 92 96 74 f8 e9 25 f1 ff ff e8 e8 ae 09 f8 48 8b 5c 24 08 e9 eb fb ff ff e8 d9 ae 09 f8 90 <0f> 0b 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90004cbef30 EFLAGS: 00010293
RAX: ffffffff8995c347 RBX: 00000000fffffff2 RCX: ffff88802cf45a00
RDX: 0000000000000000 RSI: 00000000fffffff2 RDI: 0000000000000000
RBP: ffff88807df0c06a R08: ffffffff8995b084 R09: 1ffff1100fbe185c
R10: dffffc0000000000 R11: ffffed100fbe185d R12: ffff888076e85d50
R13: ffff888076e85c80 R14: ffff888076e85cf4 R15: ffff888076e85c80
FS:  00007f0dca6ea6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0dca6ead58 CR3: 00000000119da000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  skb_cow_data+0x2da/0xcb0 net/core/skbuff.c:5284
  tipc_aead_decrypt net/tipc/crypto.c:894 [inline]
  tipc_crypto_rcv+0x402/0x24e0 net/tipc/crypto.c:1844
  tipc_rcv+0x57e/0x12a0 net/tipc/node.c:2109
  tipc_l2_rcv_msg+0x2bd/0x450 net/tipc/bearer.c:668
  __netif_receive_skb_list_ptype net/core/dev.c:5720 [inline]
  __netif_receive_skb_list_core+0x8b7/0x980 net/core/dev.c:5762
  __netif_receive_skb_list net/core/dev.c:5814 [inline]
  netif_receive_skb_list_internal+0xa51/0xe30 net/core/dev.c:5905
  gro_normal_list include/net/gro.h:515 [inline]
  napi_complete_done+0x2b5/0x870 net/core/dev.c:6256
  napi_complete include/linux/netdevice.h:567 [inline]
  tun_get_user+0x2ea0/0x4890 drivers/net/tun.c:1982
  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2057
 do_iter_readv_writev+0x600/0x880
  vfs_writev+0x376/0xba0 fs/read_write.c:1050
  do_writev+0x1b6/0x360 fs/read_write.c:1096
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: de4f5fed3f23 ("iov_iter: add iter_iovec() helper")
Reported-by: syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/675b61aa.050a0220.599f4.00bb.GAE@google.com/T/#u
Cc: stable@vger.kernel.org
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
 drivers/net/tun.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index d7a865ef370b6968c095510ae16b5196e30e54b9..e816aaba8e5f2ed06f8832f79553b6c976e75bb8 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1481,7 +1481,7 @@ static struct sk_buff *tun_napi_alloc_frags(struct tun_file *tfile,
 	skb->truesize += skb->data_len;
 
 	for (i = 1; i < it->nr_segs; i++) {
-		const struct iovec *iov = iter_iov(it);
+		const struct iovec *iov = iter_iov(it) + i;
 		size_t fragsz = iov->iov_len;
 		struct page *page;
 		void *frag;
-- 
2.47.1.613.gc27f4b7a9f-goog


