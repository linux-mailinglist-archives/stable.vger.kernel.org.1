Return-Path: <stable+bounces-101417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B558B9EEC20
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76CF42848B2
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B693217F29;
	Thu, 12 Dec 2024 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="neYDFP2e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093E32135C1;
	Thu, 12 Dec 2024 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017479; cv=none; b=hAY1FLY2YHqK96qomrbMX5lMfsAwpQZtq930YV8k2tLkA5mRjyl4c2pqh4UkHAS/OO6nUd5zf44XC4TIeTZKNxlW6UoJb/zxr05l7QgRUwzpqsKzEl4l0qRNhX8CiKfZWiWpt/5NroCihm1ux0Rus+ro8a6p1YyxR7G+XOA/Alg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017479; c=relaxed/simple;
	bh=+HCKjpkNo3YnVoFbMnMHbU9i+PB18ZfQfUKggocindU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bI2PtCcK7B0YyGogF96LxoQUOgfv6KSAaOflwEKLX0MBi2UENVhcOybCwB/ZKkQL14kmnkxycI86W+Ct3Ipr0mBJPuOl1ICR/VjWZhG+qGdXFiCYZwmDZ/OHK+B+H2FlqxxFnAgi0Vuv7APJNtt3riwnIgcT9u0xAg57ofZVhPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=neYDFP2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37005C4CECE;
	Thu, 12 Dec 2024 15:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734017478;
	bh=+HCKjpkNo3YnVoFbMnMHbU9i+PB18ZfQfUKggocindU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=neYDFP2eRzLh6sY21Bbd6KcMqfRf4BH/iszxblueOV/UyhQgkDXOKJeSF+tgxx9BV
	 TDUe3SbmtHByOVk7VyRE1QoB+qAPb2OSC59G47kmNw23CHy2UpbUzH9i4khrM0W0v0
	 8gmE19HIx0zrQLPhUADn/dA9eDNzBa51Do0IYT7c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+671e2853f9851d039551@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	WingMan Kwok <w-kwok2@ti.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Jiri Pirko <jiri@nvidia.com>,
	George McCollister <george.mccollister@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 024/356] net: hsr: avoid potential out-of-bound access in fill_frame_info()
Date: Thu, 12 Dec 2024 15:55:43 +0100
Message-ID: <20241212144245.585618400@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144244.601729511@linuxfoundation.org>
References: <20241212144244.601729511@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit b9653d19e556c6afd035602927a93d100a0d7644 ]

syzbot is able to feed a packet with 14 bytes, pretending
it is a vlan one.

Since fill_frame_info() is relying on skb->mac_len already,
extend the check to cover this case.

BUG: KMSAN: uninit-value in fill_frame_info net/hsr/hsr_forward.c:709 [inline]
 BUG: KMSAN: uninit-value in hsr_forward_skb+0x9ee/0x3b10 net/hsr/hsr_forward.c:724
  fill_frame_info net/hsr/hsr_forward.c:709 [inline]
  hsr_forward_skb+0x9ee/0x3b10 net/hsr/hsr_forward.c:724
  hsr_dev_xmit+0x2f0/0x350 net/hsr/hsr_device.c:235
  __netdev_start_xmit include/linux/netdevice.h:5002 [inline]
  netdev_start_xmit include/linux/netdevice.h:5011 [inline]
  xmit_one net/core/dev.c:3590 [inline]
  dev_hard_start_xmit+0x247/0xa20 net/core/dev.c:3606
  __dev_queue_xmit+0x366a/0x57d0 net/core/dev.c:4434
  dev_queue_xmit include/linux/netdevice.h:3168 [inline]
  packet_xmit+0x9c/0x6c0 net/packet/af_packet.c:276
  packet_snd net/packet/af_packet.c:3146 [inline]
  packet_sendmsg+0x91ae/0xa6f0 net/packet/af_packet.c:3178
  sock_sendmsg_nosec net/socket.c:711 [inline]
  __sock_sendmsg+0x30f/0x380 net/socket.c:726
  __sys_sendto+0x594/0x750 net/socket.c:2197
  __do_sys_sendto net/socket.c:2204 [inline]
  __se_sys_sendto net/socket.c:2200 [inline]
  __x64_sys_sendto+0x125/0x1d0 net/socket.c:2200
  x64_sys_call+0x346a/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:45
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
  slab_post_alloc_hook mm/slub.c:4091 [inline]
  slab_alloc_node mm/slub.c:4134 [inline]
  kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4186
  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:587
  __alloc_skb+0x363/0x7b0 net/core/skbuff.c:678
  alloc_skb include/linux/skbuff.h:1323 [inline]
  alloc_skb_with_frags+0xc8/0xd00 net/core/skbuff.c:6612
  sock_alloc_send_pskb+0xa81/0xbf0 net/core/sock.c:2881
  packet_alloc_skb net/packet/af_packet.c:2995 [inline]
  packet_snd net/packet/af_packet.c:3089 [inline]
  packet_sendmsg+0x74c6/0xa6f0 net/packet/af_packet.c:3178
  sock_sendmsg_nosec net/socket.c:711 [inline]
  __sock_sendmsg+0x30f/0x380 net/socket.c:726
  __sys_sendto+0x594/0x750 net/socket.c:2197
  __do_sys_sendto net/socket.c:2204 [inline]
  __se_sys_sendto net/socket.c:2200 [inline]
  __x64_sys_sendto+0x125/0x1d0 net/socket.c:2200
  x64_sys_call+0x346a/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:45
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 48b491a5cc74 ("net: hsr: fix mac_len checks")
Reported-by: syzbot+671e2853f9851d039551@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6745dc7f.050a0220.21d33d.0018.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: WingMan Kwok <w-kwok2@ti.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: MD Danish Anwar <danishanwar@ti.com>
Cc: Jiri Pirko <jiri@nvidia.com>
Cc: George McCollister <george.mccollister@gmail.com>
Link: https://patch.msgid.link/20241126144344.4177332-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/hsr/hsr_forward.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 0323ab5023c69..2790f3964d6bd 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -588,6 +588,8 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 		frame->is_vlan = true;
 
 	if (frame->is_vlan) {
+		if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr, vlanhdr))
+			return -EINVAL;
 		vlan_hdr = (struct hsr_vlan_ethhdr *)ethhdr;
 		proto = vlan_hdr->vlanhdr.h_vlan_encapsulated_proto;
 		/* FIXME: */
-- 
2.43.0




