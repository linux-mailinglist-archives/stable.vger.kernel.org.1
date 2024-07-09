Return-Path: <stable+bounces-58708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9379C92B846
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C481F21A41
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92300154C07;
	Tue,  9 Jul 2024 11:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B1jgdxWF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F37655E4C;
	Tue,  9 Jul 2024 11:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524753; cv=none; b=jSCzaP27SZIst8S/xWVoi2sQa6KitGjzICxSJVKm/7+kIgUxxobQP5TlxV5mYnKpl1whzbcy9iepnuLObi4Zcdw9zUMTEOdKgqSL1L+n+FXh383WiGsEc4xUUIeJcEwxIAMwfFCxSa+DPTTujjKzMltFkAM8ivb4xq6/wLXSY8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524753; c=relaxed/simple;
	bh=yAqVPeZyvI3bo5mknbV48lcHo88ONj36sJjl8z/CR4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBZ1xD/wk+8Kg3ctPqKLkP99agBCSg4v8XSc3JNBhIoEbRJ7i3QmKhJYWhA9/LlSS43+9cPz9SifvkF9eo1CmMvbvqOPvcFan90RLKv/39y2ElAVs94spU8yVLDfQN/vikP87y9Mdf/JT1+qR2BGwz40wCEhjrGGU8Ygl8BhIFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B1jgdxWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9924C32786;
	Tue,  9 Jul 2024 11:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720524753;
	bh=yAqVPeZyvI3bo5mknbV48lcHo88ONj36sJjl8z/CR4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B1jgdxWFweJL9SHugT2OB3EGJj/L0WRdpvtJtr32x/3NaY0qJHljwKIPwfcRM/NLM
	 1koYbuuw6Hqf/4zLhLyZqMSBqcvlx1YYksndpbDGSYyqpSa0yM5coxk96EvYd5u2hI
	 Ll76dqI6wZdMAsdFNePWIaHswawUCSKD5G5Mcvq8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzkaller <syzkaller@googlegroups.com>,
	Shigeru Yoshida <syoshida@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 059/102] inet_diag: Initialize pad field in struct inet_diag_req_v2
Date: Tue,  9 Jul 2024 13:10:22 +0200
Message-ID: <20240709110653.678523614@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110651.353707001@linuxfoundation.org>
References: <20240709110651.353707001@linuxfoundation.org>
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

From: Shigeru Yoshida <syoshida@redhat.com>

[ Upstream commit 61cf1c739f08190a4cbf047b9fbb192a94d87e3f ]

KMSAN reported uninit-value access in raw_lookup() [1]. Diag for raw
sockets uses the pad field in struct inet_diag_req_v2 for the
underlying protocol. This field corresponds to the sdiag_raw_protocol
field in struct inet_diag_req_raw.

inet_diag_get_exact_compat() converts inet_diag_req to
inet_diag_req_v2, but leaves the pad field uninitialized. So the issue
occurs when raw_lookup() accesses the sdiag_raw_protocol field.

Fix this by initializing the pad field in
inet_diag_get_exact_compat(). Also, do the same fix in
inet_diag_dump_compat() to avoid the similar issue in the future.

[1]
BUG: KMSAN: uninit-value in raw_lookup net/ipv4/raw_diag.c:49 [inline]
BUG: KMSAN: uninit-value in raw_sock_get+0x657/0x800 net/ipv4/raw_diag.c:71
 raw_lookup net/ipv4/raw_diag.c:49 [inline]
 raw_sock_get+0x657/0x800 net/ipv4/raw_diag.c:71
 raw_diag_dump_one+0xa1/0x660 net/ipv4/raw_diag.c:99
 inet_diag_cmd_exact+0x7d9/0x980
 inet_diag_get_exact_compat net/ipv4/inet_diag.c:1404 [inline]
 inet_diag_rcv_msg_compat+0x469/0x530 net/ipv4/inet_diag.c:1426
 sock_diag_rcv_msg+0x23d/0x740 net/core/sock_diag.c:282
 netlink_rcv_skb+0x537/0x670 net/netlink/af_netlink.c:2564
 sock_diag_rcv+0x35/0x40 net/core/sock_diag.c:297
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0xe74/0x1240 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x10c6/0x1260 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x332/0x3d0 net/socket.c:745
 ____sys_sendmsg+0x7f0/0xb70 net/socket.c:2585
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2639
 __sys_sendmsg net/socket.c:2668 [inline]
 __do_sys_sendmsg net/socket.c:2677 [inline]
 __se_sys_sendmsg net/socket.c:2675 [inline]
 __x64_sys_sendmsg+0x27e/0x4a0 net/socket.c:2675
 x64_sys_call+0x135e/0x3ce0 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd9/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 raw_sock_get+0x650/0x800 net/ipv4/raw_diag.c:71
 raw_diag_dump_one+0xa1/0x660 net/ipv4/raw_diag.c:99
 inet_diag_cmd_exact+0x7d9/0x980
 inet_diag_get_exact_compat net/ipv4/inet_diag.c:1404 [inline]
 inet_diag_rcv_msg_compat+0x469/0x530 net/ipv4/inet_diag.c:1426
 sock_diag_rcv_msg+0x23d/0x740 net/core/sock_diag.c:282
 netlink_rcv_skb+0x537/0x670 net/netlink/af_netlink.c:2564
 sock_diag_rcv+0x35/0x40 net/core/sock_diag.c:297
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0xe74/0x1240 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x10c6/0x1260 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x332/0x3d0 net/socket.c:745
 ____sys_sendmsg+0x7f0/0xb70 net/socket.c:2585
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2639
 __sys_sendmsg net/socket.c:2668 [inline]
 __do_sys_sendmsg net/socket.c:2677 [inline]
 __se_sys_sendmsg net/socket.c:2675 [inline]
 __x64_sys_sendmsg+0x27e/0x4a0 net/socket.c:2675
 x64_sys_call+0x135e/0x3ce0 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd9/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable req.i created at:
 inet_diag_get_exact_compat net/ipv4/inet_diag.c:1396 [inline]
 inet_diag_rcv_msg_compat+0x2a6/0x530 net/ipv4/inet_diag.c:1426
 sock_diag_rcv_msg+0x23d/0x740 net/core/sock_diag.c:282

CPU: 1 PID: 8888 Comm: syz-executor.6 Not tainted 6.10.0-rc4-00217-g35bb670d65fc #32
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014

Fixes: 432490f9d455 ("net: ip, diag -- Add diag interface for raw sockets")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20240703091649.111773-1-syoshida@redhat.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/inet_diag.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 8f690a6e61baa..e4e1999d93f50 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -1281,6 +1281,7 @@ static int inet_diag_dump_compat(struct sk_buff *skb,
 	req.sdiag_family = AF_UNSPEC; /* compatibility */
 	req.sdiag_protocol = inet_diag_type2proto(cb->nlh->nlmsg_type);
 	req.idiag_ext = rc->idiag_ext;
+	req.pad = 0;
 	req.idiag_states = rc->idiag_states;
 	req.id = rc->id;
 
@@ -1296,6 +1297,7 @@ static int inet_diag_get_exact_compat(struct sk_buff *in_skb,
 	req.sdiag_family = rc->idiag_family;
 	req.sdiag_protocol = inet_diag_type2proto(nlh->nlmsg_type);
 	req.idiag_ext = rc->idiag_ext;
+	req.pad = 0;
 	req.idiag_states = rc->idiag_states;
 	req.id = rc->id;
 
-- 
2.43.0




