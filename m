Return-Path: <stable+bounces-197516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2DDC8F83D
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 17:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 207574E13B5
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 16:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A872D73B6;
	Thu, 27 Nov 2025 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="H5iqeIFW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F13F2D3EDE
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764261156; cv=none; b=BJUwRYBrNHN6kIyfQgxiy6jv4xIA3U73Z9avlhmL10m69RQ7MKUNbVNiZP1H51eGDKeaV/azO05oyQGTaGEwbVVL+aXUnlIfWnjqM5Q2qFL1uxHgSO9f1l/tZ7Gk6UijQS+ueQeabdIkK4XDntua/9unbHVckeDr3/EL6FQVKfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764261156; c=relaxed/simple;
	bh=tXBFd47Ra46sxs0vF+NMtPDy1FgNeJRrOKBZRZErof4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eCS/PGQIE9Www9Zkb9bSbMO5X5QGyIsFtbIgk5v1SZINFX4sWtgPrseNHa/HMeVRV6BXKCQ1ma01kixp9xIlvmNff9PKo7oFiVm4NnEN5tPg/gWty6c8vJyCe0HSKE2ObEfpIAIWWqKFtAOlCkQPLPfLZJnqIISS5EOeFUTa0AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=H5iqeIFW; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-340a5c58bf1so663475a91.2
        for <stable@vger.kernel.org>; Thu, 27 Nov 2025 08:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1764261153; x=1764865953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tIxXAEKMOqnp4VYEF4NxFKhRMequxzs6deYOmCKzJNA=;
        b=H5iqeIFWy1CyJZRnTiFD2kEzVcgX4g5R9M7JGtwQYPE+yGH+aW6UnU8DBpbVlDY7JJ
         mq48vpoJ/2vaYxY02u+rUgFsGx93HI2mGIjWtT2Wd8R1T06xuB2oGOWEwvYHnxzN8VDY
         KUMZcIqJ5klhqtYuXHLDKM9oqwPAHBrKuDPoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764261153; x=1764865953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIxXAEKMOqnp4VYEF4NxFKhRMequxzs6deYOmCKzJNA=;
        b=leKWNfuG3D5GanVpHJ/M1LAPl5SBMoz7Z5AnXT0IHPD+diSgHqDhYsQId1Z9Iqotxq
         pU5VCfjbYp+HK5SfuR+bhX+gZ2eJYnQ7IfK8u/tYtt4ZCyHBxZYqw/EqMOeM5IDTb4sp
         XsR/4EIc3Lg7EczWkiQ1hI/seMybAtnn8HZSEd+uPgY9fh4fuH3BY2lVjLrfxP43ytTS
         YQ+MmlXGBGajo5LvyOfp/w8H3YbhpKRlWNZDTFpNQALvefLN5lkR2rgpdnww8cWZ877y
         9K2TYP3wLVtz53xUlu+Uq/WueC5cFk/4j3zyF2PWPOb+WnCsZrnsqoSV09aXnWiRjdnA
         aPUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnvONUoQQEE01Hc4KcfRg90IvDyZqayK/MerjlvJU3Y86IQ4sJNCTh3FfdgzrGiyVmrpaGo2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+wOO0ger3OUzAEf/8wetbHiOkiE+dpAlY5ptSMlsZCnmTKMQL
	GMDB/ehGFAJWiUxb3eNSOrHEHyWQkaTKNWlBJnXpito+VWHaQ389joe3FDF0hAj74J4=
X-Gm-Gg: ASbGnctCqjyWt8yelUFlDEojeXoo5sBjFqkPXcuQNrrH2C3yhHie7IZwF8ClLq8avGr
	mZxiFke+yPNi8jjMQrs3DFaxb4RCmSF92oksTNXb4vRkGstnBD5wAo64X0wj/LPiOWOg5uYa/BB
	x+aZuMG9IYZhWHk/L04ljR4ww00l3Uv3bEsMEghinIAAsG1d+0ls6II7DUhk8+Awfr8wbmBoE2o
	saLsgr7LTQYEo8VBeD5tSRFva0ZHy791hsn1Fxl7+ejpDewFdLi8DmiNwL31pJXXdtBfSwsF4wa
	z1O7zMa+l7c0FIH5JjoVXxSGFulvDwmxhbKeOxy+WB8mGO+VDNvy2lAnhE91W92Tpm6LEGK2chU
	aEpJjmXS5kIEUIMnChmfX/Q5oH4oRFfGCJmlTTN65vVAaXGzdCPDpnKa9E33bHGr3ZlxA6n7I5x
	ZwDl9VGeaXnhArT0bolKFJdtKQh2MlYLTxIMFs939U+2RM31s8M5tMzbUj/aDtkuCIrPBTn9Eyy
	lI=
X-Google-Smtp-Source: AGHT+IFsZoc6OMfnFDCWIGaHyE67GKVuemKdu8AOJhsk6IxbuQOKi+aD5tJTzqTKiHZQirFrN7JA2Q==
X-Received: by 2002:a17:90b:58cf:b0:343:d70e:bef0 with SMTP id 98e67ed59e1d1-3475ed514d7mr9353698a91.21.1764261153388;
        Thu, 27 Nov 2025 08:32:33 -0800 (PST)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([2409:40c0:1009:d133:fe97:1986:db7a:ab8b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476a560090sm6225670a91.7.2025.11.27.08.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 08:32:32 -0800 (PST)
From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	jkarrenpalo@gmail.com,
	fmaurer@redhat.com,
	arvid.brodin@alten.se,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	syzbot+2fa344348a579b779e05@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH net v2] net/hsr: fix NULL pointer dereference in skb_clone with hw tag insertion
Date: Thu, 27 Nov 2025 22:02:19 +0530
Message-Id: <20251127163219.40389-1-ssrane_b23@ee.vjti.ac.in>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When NETIF_F_HW_HSR_TAG_INS is enabled and frame->skb_std is NULL,
hsr_create_tagged_frame() and prp_create_tagged_frame() call skb_clone()
with a NULL pointer. Similarly, prp_get_untagged_frame() doesn't check
if __pskb_copy() fails before calling skb_clone().

This causes a kernel crash reported by Syzbot:

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

Fix this by adding NULL checks for frame->skb_std before calling
skb_clone() in the affected functions.

Reported-by: syzbot+2fa344348a579b779e05@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2fa344348a579b779e05
Fixes: f266a683a480 ("net/hsr: Better frame dispatch")
Cc: stable@vger.kernel.org
Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
 net/hsr/hsr_forward.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 339f0d220212..8a8559f0880f 100644
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
@@ -341,6 +343,8 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr_frame_info *frame,
 		hsr_set_path_id(frame, hsr_ethhdr, port);
 		return skb_clone(frame->skb_hsr, GFP_ATOMIC);
 	} else if (port->dev->features & NETIF_F_HW_HSR_TAG_INS) {
+		if (!frame->skb_std)
+			return NULL;
 		return skb_clone(frame->skb_std, GFP_ATOMIC);
 	}
 
@@ -385,6 +389,8 @@ struct sk_buff *prp_create_tagged_frame(struct hsr_frame_info *frame,
 		}
 		return skb_clone(frame->skb_prp, GFP_ATOMIC);
 	} else if (port->dev->features & NETIF_F_HW_HSR_TAG_INS) {
+		if (!frame->skb_std)
+			return NULL;
 		return skb_clone(frame->skb_std, GFP_ATOMIC);
 	}
 
-- 
2.34.1


