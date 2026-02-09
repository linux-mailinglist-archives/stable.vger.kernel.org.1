Return-Path: <stable+bounces-214898-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CGHCZW0iWlLBAUAu9opvQ
	(envelope-from <stable+bounces-214898-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 11:19:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 770F510E129
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 11:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8674C3009F8C
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 10:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B94D34CFC5;
	Mon,  9 Feb 2026 10:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="htBHa+qH"
X-Original-To: stable@vger.kernel.org
Received: from n169-111.mail.139.com (n169-111.mail.139.com [120.232.169.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19143446CC
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 10:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770632332; cv=none; b=G/uWVsmPK0bpiutKLct2Z0CMM/VwVL9OEb5EokTzzg0A9Bfw+v5J63k4HE0je5IpiB9492wkBYJoHVvcV9vrrjXT806R/I00sZkedJELln2vSQvjyuiJuOnJEIU3/i4pv9IsVUiWHhQuR4kiUSKbHsM4bhuHg9ql3G9kUd5uKv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770632332; c=relaxed/simple;
	bh=B/Pgh/pQho79XtRC/1WTML7+khYWoZe1J3y/5EDVfs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JsNEuBNwybJ9R0wb/gC+stFe1TExhMdtOn/SkImuOBHjYhVx4w/t0CqvpWymkYiGwtV4E3T4/cSNlof26rCLKZlv4byzhHOyE/QZDov3SshQemBKfawpnQps1w3M3VM54zAHTMij7sFr9twxqyzshUR4xUfXGNSbYn0tuPqITkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=htBHa+qH; arc=none smtp.client-ip=120.232.169.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=htBHa+qH4dTeKMHzL/Y/IjiLt+6HGtKRB08WWLSFnpxA2+siDkqlXuIb6dt/6mjUUsavmd4dYtgDh
	 tGMbtc1SDTTsZyAPopYEh/Nv/qTx2ekgEjSRimhoN7iUKw9C9tBWS0S6OO+lrXhcYFO4iLWlwiTG42
	 SxeZoJ44uW6MGpX4=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from ubuntu24.corp.ad.wrs.com (unknown[120.244.194.126])
	by rmsmtp-lg-appmail-14-12003 (RichMail) with SMTP id 2ee36989b4728a6-49bdc;
	Mon, 09 Feb 2026 18:18:37 +0800 (CST)
X-RM-TRANSID:2ee36989b4728a6-49bdc
From: Bin Lan <lanbincn@139.com>
To: stable@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Bin Lan <lanbincn@139.com>
Subject: [PATCH 5.15.y] Bluetooth: hci_event: call disconnect callback before deleting conn
Date: Mon,  9 Feb 2026 10:18:26 +0000
Message-ID: <20260209101826.17197-1-lanbincn@139.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214898-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[iki.fi,intel.com,139.com];
	DKIM_TRACE(0.00)[139.com:-];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[lanbincn@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[139.com];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,iki.fi:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 770F510E129
X-Rspamd-Action: no action

From: Pauli Virtanen <pav@iki.fi>

[ Upstream commit 7f7cfcb6f0825652973b780f248603e23f16ee90 ]

In hci_cs_disconnect, we do hci_conn_del even if disconnection failed.

ISO, L2CAP and SCO connections refer to the hci_conn without
hci_conn_get, so disconn_cfm must be called so they can clean up their
conn, otherwise use-after-free occurs.

ISO:
==========================================================
iso_sock_connect:880: sk 00000000eabd6557
iso_connect_cis:356: 70:1a:b8:98:ff:a2 -> 28:3d:c2:4a:7e:da
...
iso_conn_add:140: hcon 000000001696f1fd conn 00000000b6251073
hci_dev_put:1487: hci0 orig refcnt 17
__iso_chan_add:214: conn 00000000b6251073
iso_sock_clear_timer:117: sock 00000000eabd6557 state 3
...
hci_rx_work:4085: hci0 Event packet
hci_event_packet:7601: hci0: event 0x0f
hci_cmd_status_evt:4346: hci0: opcode 0x0406
hci_cs_disconnect:2760: hci0: status 0x0c
hci_sent_cmd_data:3107: hci0 opcode 0x0406
hci_conn_del:1151: hci0 hcon 000000001696f1fd handle 2560
hci_conn_unlink:1102: hci0: hcon 000000001696f1fd
hci_conn_drop:1451: hcon 00000000d8521aaf orig refcnt 2
hci_chan_list_flush:2780: hcon 000000001696f1fd
hci_dev_put:1487: hci0 orig refcnt 21
hci_dev_put:1487: hci0 orig refcnt 20
hci_req_cmd_complete:3978: opcode 0x0406 status 0x0c
... <no iso_* activity on sk/conn> ...
iso_sock_sendmsg:1098: sock 00000000dea5e2e0, sk 00000000eabd6557
BUG: kernel NULL pointer dereference, address: 0000000000000668
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP PTI
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
RIP: 0010:iso_sock_sendmsg (net/bluetooth/iso.c:1112) bluetooth
==========================================================

L2CAP:
==================================================================
hci_cmd_status_evt:4359: hci0: opcode 0x0406
hci_cs_disconnect:2760: hci0: status 0x0c
hci_sent_cmd_data:3085: hci0 opcode 0x0406
hci_conn_del:1151: hci0 hcon ffff88800c999000 handle 3585
hci_conn_unlink:1102: hci0: hcon ffff88800c999000
hci_chan_list_flush:2780: hcon ffff88800c999000
hci_chan_del:2761: hci0 hcon ffff88800c999000 chan ffff888018ddd280
...
BUG: KASAN: slab-use-after-free in hci_send_acl+0x2d/0x540 [bluetooth]
Read of size 8 at addr ffff888018ddd298 by task bluetoothd/1175

CPU: 0 PID: 1175 Comm: bluetoothd Tainted: G            E      6.4.0-rc4+ #2
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x5b/0x90
 print_report+0xcf/0x670
 ? __virt_addr_valid+0xf8/0x180
 ? hci_send_acl+0x2d/0x540 [bluetooth]
 kasan_report+0xa8/0xe0
 ? hci_send_acl+0x2d/0x540 [bluetooth]
 hci_send_acl+0x2d/0x540 [bluetooth]
 ? __pfx___lock_acquire+0x10/0x10
 l2cap_chan_send+0x1fd/0x1300 [bluetooth]
 ? l2cap_sock_sendmsg+0xf2/0x170 [bluetooth]
 ? __pfx_l2cap_chan_send+0x10/0x10 [bluetooth]
 ? lock_release+0x1d5/0x3c0
 ? mark_held_locks+0x1a/0x90
 l2cap_sock_sendmsg+0x100/0x170 [bluetooth]
 sock_write_iter+0x275/0x280
 ? __pfx_sock_write_iter+0x10/0x10
 ? __pfx___lock_acquire+0x10/0x10
 do_iter_readv_writev+0x176/0x220
 ? __pfx_do_iter_readv_writev+0x10/0x10
 ? find_held_lock+0x83/0xa0
 ? selinux_file_permission+0x13e/0x210
 do_iter_write+0xda/0x340
 vfs_writev+0x1b4/0x400
 ? __pfx_vfs_writev+0x10/0x10
 ? __seccomp_filter+0x112/0x750
 ? populate_seccomp_data+0x182/0x220
 ? __fget_light+0xdf/0x100
 ? do_writev+0x19d/0x210
 do_writev+0x19d/0x210
 ? __pfx_do_writev+0x10/0x10
 ? mark_held_locks+0x1a/0x90
 do_syscall_64+0x60/0x90
 ? lockdep_hardirqs_on_prepare+0x149/0x210
 ? do_syscall_64+0x6c/0x90
 ? lockdep_hardirqs_on_prepare+0x149/0x210
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7ff45cb23e64
Code: 15 d1 1f 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 80 3d 9d a7 0d 00 00 74 13 b8 14 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 89 54 24 1c 48 89
RSP: 002b:00007fff21ae09b8 EFLAGS: 00000202 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007ff45cb23e64
RDX: 0000000000000001 RSI: 00007fff21ae0aa0 RDI: 0000000000000017
RBP: 00007fff21ae0aa0 R08: 000000000095a8a0 R09: 0000607000053f40
R10: 0000000000000001 R11: 0000000000000202 R12: 00007fff21ae0ac0
R13: 00000fffe435c150 R14: 00007fff21ae0a80 R15: 000060f000000040
 </TASK>

Allocated by task 771:
 kasan_save_stack+0x33/0x60
 kasan_set_track+0x25/0x30
 __kasan_kmalloc+0xaa/0xb0
 hci_chan_create+0x67/0x1b0 [bluetooth]
 l2cap_conn_add.part.0+0x17/0x590 [bluetooth]
 l2cap_connect_cfm+0x266/0x6b0 [bluetooth]
 hci_le_remote_feat_complete_evt+0x167/0x310 [bluetooth]
 hci_event_packet+0x38d/0x800 [bluetooth]
 hci_rx_work+0x287/0xb20 [bluetooth]
 process_one_work+0x4f7/0x970
 worker_thread+0x8f/0x620
 kthread+0x17f/0x1c0
 ret_from_fork+0x2c/0x50

Freed by task 771:
 kasan_save_stack+0x33/0x60
 kasan_set_track+0x25/0x30
 kasan_save_free_info+0x2e/0x50
 ____kasan_slab_free+0x169/0x1c0
 slab_free_freelist_hook+0x9e/0x1c0
 __kmem_cache_free+0xc0/0x310
 hci_chan_list_flush+0x46/0x90 [bluetooth]
 hci_conn_cleanup+0x7d/0x330 [bluetooth]
 hci_cs_disconnect+0x35d/0x530 [bluetooth]
 hci_cmd_status_evt+0xef/0x2b0 [bluetooth]
 hci_event_packet+0x38d/0x800 [bluetooth]
 hci_rx_work+0x287/0xb20 [bluetooth]
 process_one_work+0x4f7/0x970
 worker_thread+0x8f/0x620
 kthread+0x17f/0x1c0
 ret_from_fork+0x2c/0x50
==================================================================

Fixes: b8d290525e39 ("Bluetooth: clean up connection in hci_cs_disconnect")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ Adjust context ]
Signed-off-by: Bin Lan <lanbincn@139.com>
---
 net/bluetooth/hci_event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f07512bcaf12..8d6fc3a0c9a7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2373,6 +2373,9 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
 			hci_req_reenable_advertising(hdev);
 		}
 
+		/* Inform sockets conn is gone before we delete it */
+		hci_disconn_cfm(conn, HCI_ERROR_UNSPECIFIED);
+
 		/* If the disconnection failed for any reason, the upper layer
 		 * does not retry to disconnect in current implementation.
 		 * Hence, we need to do some basic cleanup here and re-enable
-- 
2.43.0



