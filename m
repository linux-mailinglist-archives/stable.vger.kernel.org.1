Return-Path: <stable+bounces-16903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E024B840EF8
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C6051F2517B
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4C0162756;
	Mon, 29 Jan 2024 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yf6oWVDQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D3B1586C5;
	Mon, 29 Jan 2024 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548364; cv=none; b=Kjt2aXLpdx6BKRTIFxpDqDfxYnW2c+wKtp3h8Zz7gIq/gPGq30yuJn56dmy2xWyZtOOzgK9zOTearcrCemgjR5+Wx3GejLgTKNbIDxhnSNbO3ZAibfIV1YxWMLcygILBpuKgu3UCQ9RvvSneful082ZifXILxW99wgtF7bewthU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548364; c=relaxed/simple;
	bh=SrLjkq1XQRUL5dyXqp5JXDhqSxHISiTNjA838bewjMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9OjGeDxdhT1ozK3XoPzguyT9+VZbfA4buuyB7hQ+p6R+TKa8ZnBfmnIv6JzOnhKqWdftpYhgALl7psaPO/qfF1xvPbSYIg0qarcXgOo63dkDzi/A/qYMW+qt0m+aoMJkcW4DQAHg9xOkDeFyPnp3rI3vHOaUNC94YqHToyjzHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yf6oWVDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DC5C433F1;
	Mon, 29 Jan 2024 17:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548364;
	bh=SrLjkq1XQRUL5dyXqp5JXDhqSxHISiTNjA838bewjMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yf6oWVDQNjY/hCIdy7SNBV8dQ0VRIqxXUUTRjDzLmeLwSp3URJmqvfSLF76KNh/FW
	 ki5Avhvb/Fgpnpz/97fF6cr9EW/ocvYk1OzwZh5+zDvItSjCtlLrNaYMIzs7YynGg4
	 mOtYkC1mR7ke8CWwY9Sm3OxqdMeO3n78ijLeASZA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lin Ma <linma@zju.edu.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 128/185] ksmbd: fix global oob in ksmbd_nl_policy
Date: Mon, 29 Jan 2024 09:05:28 -0800
Message-ID: <20240129170002.695789511@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129165958.589924174@linuxfoundation.org>
References: <20240129165958.589924174@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lin Ma <linma@zju.edu.cn>

commit ebeae8adf89d9a82359f6659b1663d09beec2faa upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/ksmbd_netlink.h |    3 ++-
 fs/smb/server/transport_ipc.c |    4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

--- a/fs/smb/server/ksmbd_netlink.h
+++ b/fs/smb/server/ksmbd_netlink.h
@@ -304,7 +304,8 @@ enum ksmbd_event {
 	KSMBD_EVENT_SPNEGO_AUTHEN_REQUEST,
 	KSMBD_EVENT_SPNEGO_AUTHEN_RESPONSE	= 15,
 
-	KSMBD_EVENT_MAX
+	__KSMBD_EVENT_MAX,
+	KSMBD_EVENT_MAX = __KSMBD_EVENT_MAX - 1
 };
 
 /*
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -74,7 +74,7 @@ static int handle_unsupported_event(stru
 static int handle_generic_event(struct sk_buff *skb, struct genl_info *info);
 static int ksmbd_ipc_heartbeat_request(void);
 
-static const struct nla_policy ksmbd_nl_policy[KSMBD_EVENT_MAX] = {
+static const struct nla_policy ksmbd_nl_policy[KSMBD_EVENT_MAX + 1] = {
 	[KSMBD_EVENT_UNSPEC] = {
 		.len = 0,
 	},
@@ -403,7 +403,7 @@ static int handle_generic_event(struct s
 		return -EPERM;
 #endif
 
-	if (type >= KSMBD_EVENT_MAX) {
+	if (type > KSMBD_EVENT_MAX) {
 		WARN_ON(1);
 		return -EINVAL;
 	}



