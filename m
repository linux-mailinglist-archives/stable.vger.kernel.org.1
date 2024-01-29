Return-Path: <stable+bounces-17346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C77BD841298
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 19:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB301F25575
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E587602D;
	Mon, 29 Jan 2024 18:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b="JS1OT0KW"
X-Original-To: stable@vger.kernel.org
Received: from ma-mailsvcp-mx-lapp01.apple.com (ma-mailsvcp-mx-lapp01.apple.com [17.32.222.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F1F6F092
	for <stable@vger.kernel.org>; Mon, 29 Jan 2024 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.32.222.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553578; cv=none; b=K/8Wq+44f6tquc5E4E5dCRpt5hrUxlPF5atgYgCPRYJTyRYxTORlsIz2YRnzk2ixFo3QMNfe3bQFsL70LwZyb+9otstRq5JqPs0SUDL6Il2UJY5zcJnKNNcFco7QhH1DVa/d3iNkadSIykY3IJd7gp5vvC+8jDNNqxeY5uiIkiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553578; c=relaxed/simple;
	bh=7acKxExqNxF71wZ7pKO8pN/2unB+Rv3aKqp6YvdJGtM=;
	h=From:To:Cc:Subject:Date:Message-id:MIME-version; b=VD9ni5hTNOgtUBxM1OxopLUC6wLztQf21AiQmBbzVWQfrZfhQcdZocBDYxRD8QihCzMKRcC7aYOVBOPspb/nRMUXzLzRgEdP79tJIGXxpIuqqSCF+GFZcF3cFZ1tnQFZX3ygKTLfox3VMcsCSzdOfRaaNhDLN3vDg+unzlBjJ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com; spf=pass smtp.mailfrom=apple.com; dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b=JS1OT0KW; arc=none smtp.client-ip=17.32.222.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apple.com
Received: from rn-mailsvcp-mta-lapp02.rno.apple.com
 (rn-mailsvcp-mta-lapp02.rno.apple.com [10.225.203.150])
 by ma-mailsvcp-mx-lapp01.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0S810030EACYD700@ma-mailsvcp-mx-lapp01.apple.com> for
 stable@vger.kernel.org; Mon, 29 Jan 2024 09:39:28 -0800 (PST)
X-Proofpoint-ORIG-GUID: dEcGG944_EDNHIfux4yFp0K3IDZpROtL
X-Proofpoint-GUID: dEcGG944_EDNHIfux4yFp0K3IDZpROtL
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.619,18.0.1011
 definitions=2024-01-29_10:2024-01-29,2024-01-29 signatures=0
X-Proofpoint-Spam-Details: rule=interactive_user_notspam
 policy=interactive_user score=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=707 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401290129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=from : to
 : cc : subject : date : message-id : mime-version : content-transfer-encoding;
 s=20180706; bh=x9fWPwSrwfyjl+jKU9w/VBf1p+yekVR4ZfQzIdWy2Lw=;
 b=JS1OT0KWD3cBEmf8/wuqIapEIc3soLMCkWzTe117KL9EFvxp5/EaRlCySO/NyHMc2qWz
 l3R9La+yth33FRYQjJlR6t0APH4JhHG3ixsdDEU+31yHza7Ms3cfrjnSfGx1w6v//Zrs
 4vDtDhDY0GZMLLSJRWrORo5+UWDwwTAFmJZWgw8nLprS556U+K9Dq0Uqaf6Oh7fhLE9B
 J8w+6iQVVkBjqNe9wWdHXKsu/Ae6NvMXHixSYscGEhAYv7eGMntb+PbDZ17g9qfl737Z
 Seu2mG045yBs5f58Gy3UxA/37RYK2U++P1bzXMiZ8xVIJuYVAlDwF3mkGkzZssathl9e 4w==
Received: from rn-mailsvcp-mmp-lapp03.rno.apple.com
 (rn-mailsvcp-mmp-lapp03.rno.apple.com [17.179.253.16])
 by rn-mailsvcp-mta-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0S8100YMUADBW160@rn-mailsvcp-mta-lapp02.rno.apple.com>;
 Mon, 29 Jan 2024 09:39:11 -0800 (PST)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp03.rno.apple.com by
 rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0S8100S00A0NCV00@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Mon,
 29 Jan 2024 09:39:11 -0800 (PST)
X-Va-A:
X-Va-T-CD: 3a9d82d30857ca08436fbabda4f0d128
X-Va-E-CD: e01d9841bc048845d9c8360b10c69ca3
X-Va-R-CD: 2b668b5dc3336c2fbbd5332b4923e735
X-Va-ID: b7399c0b-4926-4292-90f9-822791c7aaf9
X-Va-CD: 0
X-V-A:
X-V-T-CD: 3a9d82d30857ca08436fbabda4f0d128
X-V-E-CD: e01d9841bc048845d9c8360b10c69ca3
X-V-R-CD: 2b668b5dc3336c2fbbd5332b4923e735
X-V-ID: 77981d92-9aac-47b9-820f-9fd647bd439e
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.619,18.0.1011
 definitions=2024-01-29_10:2024-01-29,2024-01-29 signatures=0
Received: from localhost.localdomain ([17.192.155.119])
 by rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023))
 with ESMTPSA id <0S8100S9JADAXM00@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Mon,
 29 Jan 2024 09:39:10 -0800 (PST)
From: Christoph Paasch <cpaasch@apple.com>
To: stable@vger.kernel.org
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <martineau@kernel.org>
Subject: [PATCH stable] mptcp: introduce explicit flag for first subflow
 disposal
Date: Mon, 29 Jan 2024 09:38:29 -0800
Message-id: <20240129173829.62287-1-cpaasch@apple.com>
X-Mailer: git-send-email 2.32.3 (Apple Git-135)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

This is a partial backport of the upstram commit 39880bd808ad ("mptcp:
get rid of msk->subflow"). It's partial to avoid a long a complex
dependency chain not suitable for stable.

The only bit remaning from the original commit is the introduction of a
new field avoid a race at close time causing an UaF:

BUG: KASAN: use-after-free in mptcp_subflow_queue_clean+0x2c9/0x390 include/net/mptcp.h:104
Read of size 1 at addr ffff88803bf72884 by task syz-executor.6/23092

CPU: 0 PID: 23092 Comm: syz-executor.6 Not tainted 6.1.65-gc6114c845984 #50
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x18f lib/dump_stack.c:106
 print_report+0x163/0x4f0 mm/kasan/report.c:284
 kasan_report+0xc4/0x100 mm/kasan/report.c:495
 mptcp_subflow_queue_clean+0x2c9/0x390 include/net/mptcp.h:104
 mptcp_check_listen_stop+0x190/0x2a0 net/mptcp/protocol.c:3009
 __mptcp_close+0x9a/0x970 net/mptcp/protocol.c:3024
 mptcp_close+0x2a/0x130 net/mptcp/protocol.c:3089
 inet_release+0x13d/0x190 net/ipv4/af_inet.c:429
 sock_close+0xcf/0x230 net/socket.c:652
 __fput+0x3a2/0x870 fs/file_table.c:320
 task_work_run+0x24e/0x300 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0xa4/0xc0 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0x51/0x90 kernel/entry/common.c:204
 syscall_exit_to_user_mode+0x26/0x140 kernel/entry/common.c:286
 do_syscall_64+0x53/0xa0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x64/0xce
RIP: 0033:0x41d791
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 74 2a 00 00 c3 48 83 ec 08 e8 9a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 e3 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00000000008bfb90 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 000000000041d791
RDX: 0000001b33920000 RSI: ffffffff8139adff RDI: 0000000000000003
RBP: 000000000079d980 R08: 0000001b33d20000 R09: 0000000000000951
R10: 000000008139a955 R11: 0000000000000293 R12: 00000000000c739b
R13: 000000000079bf8c R14: 00007fa301053000 R15: 00000000000c705a
 </TASK>

Allocated by task 22528:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x40/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa0/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slab_common.c:955 [inline]
 __kmalloc+0xaa/0x1c0 mm/slab_common.c:968
 kmalloc include/linux/slab.h:558 [inline]
 sk_prot_alloc+0xac/0x200 net/core/sock.c:2038
 sk_clone_lock+0x56/0x1090 net/core/sock.c:2236
 inet_csk_clone_lock+0x26/0x420 net/ipv4/inet_connection_sock.c:1141
 tcp_create_openreq_child+0x30/0x1910 net/ipv4/tcp_minisocks.c:474
 tcp_v6_syn_recv_sock+0x413/0x1a90 net/ipv6/tcp_ipv6.c:1283
 subflow_syn_recv_sock+0x621/0x1300 net/mptcp/subflow.c:730
 tcp_get_cookie_sock+0xf0/0x5f0 net/ipv4/syncookies.c:201
 cookie_v6_check+0x130f/0x1c50 net/ipv6/syncookies.c:261
 tcp_v6_do_rcv+0x7e0/0x12b0 net/ipv6/tcp_ipv6.c:1147
 tcp_v6_rcv+0x2494/0x2f50 net/ipv6/tcp_ipv6.c:1743
 ip6_protocol_deliver_rcu+0xba3/0x1620 net/ipv6/ip6_input.c:438
 ip6_input+0x1bc/0x470 net/ipv6/ip6_input.c:483
 ipv6_rcv+0xef/0x2c0 include/linux/netfilter.h:302
 __netif_receive_skb+0x1ea/0x6a0 net/core/dev.c:5525
 process_backlog+0x353/0x660 net/core/dev.c:5967
 __napi_poll+0xc6/0x5a0 net/core/dev.c:6534
 net_rx_action+0x652/0xea0 net/core/dev.c:6601
 __do_softirq+0x176/0x525 kernel/softirq.c:571

Freed by task 23093:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x40/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x50 mm/kasan/generic.c:516
 ____kasan_slab_free+0x13a/0x1b0 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1724 [inline]
 slab_free_freelist_hook mm/slub.c:1750 [inline]
 slab_free mm/slub.c:3661 [inline]
 __kmem_cache_free+0x1eb/0x340 mm/slub.c:3674
 sk_prot_free net/core/sock.c:2074 [inline]
 __sk_destruct+0x4ad/0x620 net/core/sock.c:2160
 tcp_v6_rcv+0x269c/0x2f50 net/ipv6/tcp_ipv6.c:1761
 ip6_protocol_deliver_rcu+0xba3/0x1620 net/ipv6/ip6_input.c:438
 ip6_input+0x1bc/0x470 net/ipv6/ip6_input.c:483
 ipv6_rcv+0xef/0x2c0 include/linux/netfilter.h:302
 __netif_receive_skb+0x1ea/0x6a0 net/core/dev.c:5525
 process_backlog+0x353/0x660 net/core/dev.c:5967
 __napi_poll+0xc6/0x5a0 net/core/dev.c:6534
 net_rx_action+0x652/0xea0 net/core/dev.c:6601
 __do_softirq+0x176/0x525 kernel/softirq.c:571

The buggy address belongs to the object at ffff88803bf72000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 2180 bytes inside of
 4096-byte region [ffff88803bf72000, ffff88803bf73000)

The buggy address belongs to the physical page:
page:00000000a72e4e51 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3bf70
head:00000000a72e4e51 order:3 compound_mapcount:0 compound_pincount:0
flags: 0x100000000010200(slab|head|node=0|zone=1)
raw: 0100000000010200 ffffea0000a0ea00 dead000000000002 ffff888100042140
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88803bf72780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803bf72800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88803bf72880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88803bf72900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803bf72980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

Prevent the MPTCP worker from freeing the first subflow for unaccepted
socket when such sockets transition to TCP_CLOSE state, and let that
happen at accept() or listener close() time.

Fixes: b6985b9b8295 ("mptcp: use the workqueue to destroy unaccepted sockets")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Reported-by: Christoph Paasch <cpaasch@apple.com>
Tested-by: Christoph Paasch <cpaasch@apple.com>
---

Notes:
    This patch is targeted only for -stable and specifically v6.1.x
    
    The Fixes-tag is from the upstream tree. We can change that to the
    commit in the v6.1.x-tree if needed.

 net/mptcp/protocol.c | 9 ++++-----
 net/mptcp/protocol.h | 3 ++-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 76539d1004eb..db5369b6442d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2422,7 +2422,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		goto out_release;
 	}
 
-	dispose_it = !msk->subflow || ssk != msk->subflow->sk;
+	dispose_it = msk->free_first || ssk != msk->first;
 	if (dispose_it)
 		list_del(&subflow->node);
 
@@ -2440,7 +2440,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
 	if (!dispose_it) {
 		__mptcp_subflow_disconnect(ssk, subflow, flags);
-		msk->subflow->state = SS_UNCONNECTED;
 		release_sock(ssk);
 
 		goto out;
@@ -3341,10 +3340,10 @@ static void mptcp_destroy(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	/* clears msk->subflow, allowing the following to close
-	 * even the initial subflow
-	 */
 	mptcp_dispose_initial_subflow(msk);
+
+	/* allow the following to close even the initial subflow */
+	msk->free_first = 1;
 	mptcp_destroy_common(msk, 0);
 	sk_sockets_allocated_dec(sk);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4ec8e0a81b5a..e5d553dfc13f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -287,7 +287,8 @@ struct mptcp_sock {
 			cork:1,
 			nodelay:1,
 			fastopening:1,
-			in_accept_queue:1;
+			in_accept_queue:1,
+			free_first:1;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
-- 
2.32.3 (Apple Git-135)


