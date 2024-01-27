Return-Path: <stable+bounces-16114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A6683F075
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6ED1C23887
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8081B809;
	Sat, 27 Jan 2024 22:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j80RccwA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500741B7FA
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 22:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706393078; cv=none; b=Syb588NCA+WVKSwCXDAwSVlYvP9jaCoXfUSmvc2e9rt1G0eoEHQoFRSvL0nqVj3uqbk6ing6RfFu0EBx2KUqraGol3+0PKtggaxdqFjrThw1nci6c2nl143xVjXvXOCY2dT7zdqcD4C7elYzFTAEttFLM2gOUUMGOb53mu3aoNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706393078; c=relaxed/simple;
	bh=7v2+YH7+fvYL8UEiQi/3zHOMJou66nVbC85pSeHuE8A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=obY/qMerCijN134H/d1WdQ8DwfJFRUQ1MnvIvR1Z3SalG0JrKIEpztk+cxnJTES4yWCarcslLBarZlB7UPpx1RCrks/WbpHRiwAmEHuFogoXS+/WsieAXfYs0X2tzaZ7Q+v8/GjJilDSauUq90Oxn1xvdFvxIS09/C04rirD7OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j80RccwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1E9C433C7;
	Sat, 27 Jan 2024 22:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706393077;
	bh=7v2+YH7+fvYL8UEiQi/3zHOMJou66nVbC85pSeHuE8A=;
	h=Subject:To:Cc:From:Date:From;
	b=j80RccwAT7IPfoGpDPnid9odBXr9Jdp+gsb0fHopzez9yygyHeh8xyOhcnYm/sHjE
	 64GrTUe1tB/0lyExG4ysk4NkKMlhDI4OtxIrYUc+wThX2kWx4SxLazZGfCc2Kvgk11
	 CJbZmeaS3JvTHPRADL43cd/ykRUsxHWqYGMuYMQA=
Subject: FAILED: patch "[PATCH] ksmbd: fix global oob in ksmbd_nl_policy" failed to apply to 5.15-stable tree
To: linma@zju.edu.cn,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 14:04:36 -0800
Message-ID: <2024012736-impatient-slighted-d314@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ebeae8adf89d9a82359f6659b1663d09beec2faa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012736-impatient-slighted-d314@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ebeae8adf89d9a82359f6659b1663d09beec2faa Mon Sep 17 00:00:00 2001
From: Lin Ma <linma@zju.edu.cn>
Date: Sun, 21 Jan 2024 15:35:06 +0800
Subject: [PATCH] ksmbd: fix global oob in ksmbd_nl_policy

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

diff --git a/fs/smb/server/ksmbd_netlink.h b/fs/smb/server/ksmbd_netlink.h
index b7521e41402e..0ebf91ffa236 100644
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
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index b49d47bdafc9..f29bb03f0dc4 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -74,7 +74,7 @@ static int handle_unsupported_event(struct sk_buff *skb, struct genl_info *info)
 static int handle_generic_event(struct sk_buff *skb, struct genl_info *info);
 static int ksmbd_ipc_heartbeat_request(void);
 
-static const struct nla_policy ksmbd_nl_policy[KSMBD_EVENT_MAX] = {
+static const struct nla_policy ksmbd_nl_policy[KSMBD_EVENT_MAX + 1] = {
 	[KSMBD_EVENT_UNSPEC] = {
 		.len = 0,
 	},
@@ -403,7 +403,7 @@ static int handle_generic_event(struct sk_buff *skb, struct genl_info *info)
 		return -EPERM;
 #endif
 
-	if (type >= KSMBD_EVENT_MAX) {
+	if (type > KSMBD_EVENT_MAX) {
 		WARN_ON(1);
 		return -EINVAL;
 	}


