Return-Path: <stable+bounces-22158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C55785DAA5
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EEB61C22EB8
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01E67C083;
	Wed, 21 Feb 2024 13:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RvzADBXQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA9A1E4B2;
	Wed, 21 Feb 2024 13:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522249; cv=none; b=UrorBf64jjFQx7GYjeU2vixgL5lA1GgyMxla1cgYghMvz1HTHgRbwT+EvBgJalAjED84EJaPxO8y6gXeXup4gdXWi0lBI1AYq7LkzE6nqMXXi9bUi07pGGD3ZsjkoMOs4Uc72e2960P8zs+4XKsNDnJqcPMSCAESKHteOw5xJHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522249; c=relaxed/simple;
	bh=dI7hBryEKVHoGj9B8xH3dAxOEdYuyTFj9SOXIPaLT78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnKz+r3FQzgqZw8tklxvPcF+GxTUloSVW4Vg2y/TBcq2Dd+fvF9XMEQIPZwx03avKDocq+iD7Sx1GWh3CVxfQm/XZkvsSqyJKh5QO+j8F0C+bxnmlEgikdxi7vNm9lrVQc9AQkEa9m3G6naOYYHyGm9YHr0KBGMOqdH7NSqhHJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RvzADBXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09239C433A6;
	Wed, 21 Feb 2024 13:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708522249;
	bh=dI7hBryEKVHoGj9B8xH3dAxOEdYuyTFj9SOXIPaLT78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RvzADBXQ+BgFzFH70Y/YmnSHmwWEVz58Y4EouVqlaAj5XMYuogVNwx+qEmkL0rCl5
	 5An/B/oebPqQQR9dhFN18zthP2VdhxCXiCUe0WXyBkT3cilP+WhwA25dLazN3SzBul
	 ko452v8IPYcPKsVee1YJRuDWxx6bk/BsIj4iDubw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lin Ma <linma@zju.edu.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 113/476] ksmbd: fix global oob in ksmbd_nl_policy
Date: Wed, 21 Feb 2024 14:02:44 +0100
Message-ID: <20240221130012.164659508@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
References: <20240221130007.738356493@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lin Ma <linma@zju.edu.cn>

[ Upstream commit ebeae8adf89d9a82359f6659b1663d09beec2faa ]

Similar to a reported issue (check the commit b33fb5b801c6 ("net:
qualcomm: rmnet: fix global oob in rmnet_policy"), my local fuzzer finds
another global out-of-bounds read for policy ksmbd_nl_policy. See bug
trace below:

==================================================================
BUG: KASAN: global-out-of-bounds in validate_nla lib/nlattr.c:386 [inline]
BUG: KASAN: global-out-of-bounds in __nla_validate_parse+0x24af/0x2750 lib/nlattr.c:600
Read of size 1 at addr ffffffff8f24b100 by task syz-executor.1/62810

CPU: 0 PID: 62810 Comm: syz-executor.1 Tainted: G                 N 6.1.0 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8b/0xb3 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:284 [inline]
 print_report+0x172/0x475 mm/kasan/report.c:395
 kasan_report+0xbb/0x1c0 mm/kasan/report.c:495
 validate_nla lib/nlattr.c:386 [inline]
 __nla_validate_parse+0x24af/0x2750 lib/nlattr.c:600
 __nla_parse+0x3e/0x50 lib/nlattr.c:697
 __nlmsg_parse include/net/netlink.h:748 [inline]
 genl_family_rcv_msg_attrs_parse.constprop.0+0x1b0/0x290 net/netlink/genetlink.c:565
 genl_family_rcv_msg_doit+0xda/0x330 net/netlink/genetlink.c:734
 genl_family_rcv_msg net/netlink/genetlink.c:833 [inline]
 genl_rcv_msg+0x441/0x780 net/netlink/genetlink.c:850
 netlink_rcv_skb+0x14f/0x410 net/netlink/af_netlink.c:2540
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:861
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x54e/0x800 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x930/0xe50 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0x154/0x190 net/socket.c:734
 ____sys_sendmsg+0x6df/0x840 net/socket.c:2482
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2536
 __sys_sendmsg+0xf3/0x1c0 net/socket.c:2565
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3b/0x90 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fdd66a8f359
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdd65e00168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fdd66bbcf80 RCX: 00007fdd66a8f359
RDX: 0000000000000000 RSI: 0000000020000500 RDI: 0000000000000003
RBP: 00007fdd66ada493 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc84b81aff R14: 00007fdd65e00300 R15: 0000000000022000
 </TASK>

The buggy address belongs to the variable:
 ksmbd_nl_policy+0x100/0xa80

The buggy address belongs to the physical page:
page:0000000034f47940 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1ccc4b
flags: 0x200000000001000(reserved|node=0|zone=2)
raw: 0200000000001000 ffffea00073312c8 ffffea00073312c8 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffffffff8f24b000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffff8f24b080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffffff8f24b100: f9 f9 f9 f9 00 00 f9 f9 f9 f9 f9 f9 00 00 07 f9
                   ^
 ffffffff8f24b180: f9 f9 f9 f9 00 05 f9 f9 f9 f9 f9 f9 00 00 00 05
 ffffffff8f24b200: f9 f9 f9 f9 00 00 03 f9 f9 f9 f9 f9 00 00 04 f9
==================================================================

To fix it, add a placeholder named __KSMBD_EVENT_MAX and let
KSMBD_EVENT_MAX to be its original value - 1 according to what other
netlink families do. Also change two sites that refer the
KSMBD_EVENT_MAX to correct value.

Cc: stable@vger.kernel.org
Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/ksmbd_netlink.h | 3 ++-
 fs/ksmbd/transport_ipc.c | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ksmbd/ksmbd_netlink.h b/fs/ksmbd/ksmbd_netlink.h
index 821ed8e3cbee..ecffcb8a1557 100644
--- a/fs/ksmbd/ksmbd_netlink.h
+++ b/fs/ksmbd/ksmbd_netlink.h
@@ -304,7 +304,8 @@ enum ksmbd_event {
 	KSMBD_EVENT_SPNEGO_AUTHEN_REQUEST,
 	KSMBD_EVENT_SPNEGO_AUTHEN_RESPONSE	= 15,
 
-	KSMBD_EVENT_MAX
+	__KSMBD_EVENT_MAX,
+	KSMBD_EVENT_MAX = __KSMBD_EVENT_MAX - 1
 };
 
 /*
diff --git a/fs/ksmbd/transport_ipc.c b/fs/ksmbd/transport_ipc.c
index 9560c704033e..2c9662e32799 100644
--- a/fs/ksmbd/transport_ipc.c
+++ b/fs/ksmbd/transport_ipc.c
@@ -74,7 +74,7 @@ static int handle_unsupported_event(struct sk_buff *skb, struct genl_info *info)
 static int handle_generic_event(struct sk_buff *skb, struct genl_info *info);
 static int ksmbd_ipc_heartbeat_request(void);
 
-static const struct nla_policy ksmbd_nl_policy[KSMBD_EVENT_MAX] = {
+static const struct nla_policy ksmbd_nl_policy[KSMBD_EVENT_MAX + 1] = {
 	[KSMBD_EVENT_UNSPEC] = {
 		.len = 0,
 	},
@@ -402,7 +402,7 @@ static int handle_generic_event(struct sk_buff *skb, struct genl_info *info)
 		return -EPERM;
 #endif
 
-	if (type >= KSMBD_EVENT_MAX) {
+	if (type > KSMBD_EVENT_MAX) {
 		WARN_ON(1);
 		return -EINVAL;
 	}
-- 
2.43.0




