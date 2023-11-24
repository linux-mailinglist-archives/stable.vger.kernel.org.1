Return-Path: <stable+bounces-2419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD8E7F8418
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A398BB279F2
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D959364B7;
	Fri, 24 Nov 2023 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0DrKmnmv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B423306F;
	Fri, 24 Nov 2023 19:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522DCC433C7;
	Fri, 24 Nov 2023 19:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853835;
	bh=PZeY9q4Hn/ulVGoag1dRRFfGrt949evT9vUhUazPr/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0DrKmnmvIPtPrHdm1+01pNYO2C/2YqkweuQL4g/8dSgiK2u2Twen/nWbTDVj8Dmrd
	 LTXcq1Z2rYX8lNBuVlFKxqD+PdswVOeD3Mq+NBmOTxt0g1o5+i90Ax5BHgLR2CwjG7
	 Xdh4OyHOzU6GdvhOXIgR8u+hQPmfUR8sClxq5lQg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shigeru Yoshida <syoshida@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 050/159] tipc: Fix kernel-infoleak due to uninitialized TLV value
Date: Fri, 24 Nov 2023 17:54:27 +0000
Message-ID: <20231124171944.029319566@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171941.909624388@linuxfoundation.org>
References: <20231124171941.909624388@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shigeru Yoshida <syoshida@redhat.com>

[ Upstream commit fb317eb23b5ee4c37b0656a9a52a3db58d9dd072 ]

KMSAN reported the following kernel-infoleak issue:

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in copy_to_user_iter lib/iov_iter.c:24 [inline]
BUG: KMSAN: kernel-infoleak in iterate_ubuf include/linux/iov_iter.h:29 [inline]
BUG: KMSAN: kernel-infoleak in iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
BUG: KMSAN: kernel-infoleak in iterate_and_advance include/linux/iov_iter.h:271 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x4ec/0x2bc0 lib/iov_iter.c:186
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 copy_to_user_iter lib/iov_iter.c:24 [inline]
 iterate_ubuf include/linux/iov_iter.h:29 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
 iterate_and_advance include/linux/iov_iter.h:271 [inline]
 _copy_to_iter+0x4ec/0x2bc0 lib/iov_iter.c:186
 copy_to_iter include/linux/uio.h:197 [inline]
 simple_copy_to_iter net/core/datagram.c:532 [inline]
 __skb_datagram_iter.5+0x148/0xe30 net/core/datagram.c:420
 skb_copy_datagram_iter+0x52/0x210 net/core/datagram.c:546
 skb_copy_datagram_msg include/linux/skbuff.h:3960 [inline]
 netlink_recvmsg+0x43d/0x1630 net/netlink/af_netlink.c:1967
 sock_recvmsg_nosec net/socket.c:1044 [inline]
 sock_recvmsg net/socket.c:1066 [inline]
 __sys_recvfrom+0x476/0x860 net/socket.c:2246
 __do_sys_recvfrom net/socket.c:2264 [inline]
 __se_sys_recvfrom net/socket.c:2260 [inline]
 __x64_sys_recvfrom+0x130/0x200 net/socket.c:2260
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 slab_post_alloc_hook+0x103/0x9e0 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x5f7/0xb50 mm/slub.c:3523
 kmalloc_reserve+0x13c/0x4a0 net/core/skbuff.c:560
 __alloc_skb+0x2fd/0x770 net/core/skbuff.c:651
 alloc_skb include/linux/skbuff.h:1286 [inline]
 tipc_tlv_alloc net/tipc/netlink_compat.c:156 [inline]
 tipc_get_err_tlv+0x90/0x5d0 net/tipc/netlink_compat.c:170
 tipc_nl_compat_recv+0x1042/0x15d0 net/tipc/netlink_compat.c:1324
 genl_family_rcv_msg_doit net/netlink/genetlink.c:972 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1052 [inline]
 genl_rcv_msg+0x1220/0x12c0 net/netlink/genetlink.c:1067
 netlink_rcv_skb+0x4a4/0x6a0 net/netlink/af_netlink.c:2545
 genl_rcv+0x41/0x60 net/netlink/genetlink.c:1076
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0xf4b/0x1230 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x1242/0x1420 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x997/0xd60 net/socket.c:2588
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2642
 __sys_sendmsg net/socket.c:2671 [inline]
 __do_sys_sendmsg net/socket.c:2680 [inline]
 __se_sys_sendmsg net/socket.c:2678 [inline]
 __x64_sys_sendmsg+0x2fa/0x4a0 net/socket.c:2678
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Bytes 34-35 of 36 are uninitialized
Memory access of size 36 starts at ffff88802d464a00
Data copied to user address 00007ff55033c0a0

CPU: 0 PID: 30322 Comm: syz-executor.0 Not tainted 6.6.0-14500-g1c41041124bd #10
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
=====================================================

tipc_add_tlv() puts TLV descriptor and value onto `skb`. This size is
calculated with TLV_SPACE() macro. It adds the size of struct tlv_desc and
the length of TLV value passed as an argument, and aligns the result to a
multiple of TLV_ALIGNTO, i.e., a multiple of 4 bytes.

If the size of struct tlv_desc plus the length of TLV value is not aligned,
the current implementation leaves the remaining bytes uninitialized. This
is the cause of the above kernel-infoleak issue.

This patch resolves this issue by clearing data up to an aligned size.

Fixes: d0796d1ef63d ("tipc: convert legacy nl bearer dump to nl compat")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/netlink_compat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
index bef28e900b3ed..5c61b8ee7fc09 100644
--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -101,6 +101,7 @@ static int tipc_add_tlv(struct sk_buff *skb, u16 type, void *data, u16 len)
 		return -EMSGSIZE;
 
 	skb_put(skb, TLV_SPACE(len));
+	memset(tlv, 0, TLV_SPACE(len));
 	tlv->tlv_type = htons(type);
 	tlv->tlv_len = htons(TLV_LENGTH(len));
 	if (len && data)
-- 
2.42.0




