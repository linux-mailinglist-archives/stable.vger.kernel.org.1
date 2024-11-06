Return-Path: <stable+bounces-91007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 139979BEC06
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C023A1F24F1F
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9B61FAC3B;
	Wed,  6 Nov 2024 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f0oMTdwU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABBD1EF957;
	Wed,  6 Nov 2024 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897465; cv=none; b=dbJ4upOb4F4rLsS6ICLyxFnu6OP1b7DtYc+KtibJJuPsxLG9fNkvC51RqkS4EQq6pzRW1MNBtDklJBVCcoU/iApbXohzNopf3R6lxi6FxLR5XkL1xlvVmDMOLcz0Lj48QwwLz8+RVGobz2WtrgP9b0X9U+z3FXSCk7ack5Qg/8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897465; c=relaxed/simple;
	bh=469WMVeOyZqJu8QjGz/lAnVi6zMZgoG/sVZ6Gl+TXFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2T3a3dSKxRVXRG7uwT+Pq7nBrS1t29AlUBV4aA7zZJDxOGg/SxJ/xRHmF7XMnIspvPrtRkn49nDJ3mGupLHelosJwBb0jiiYxlqiQBn1RLip8mVkucOwD/EIrIztzzldaRQm+uz5z5BvLZ2Yys28zB8mOEfWgoXX20gAIWAV4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f0oMTdwU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BBFC4CECD;
	Wed,  6 Nov 2024 12:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730897465;
	bh=469WMVeOyZqJu8QjGz/lAnVi6zMZgoG/sVZ6Gl+TXFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f0oMTdwUiWCoiyUOi4qNU0WEenRn4AM8O4ffFsFNh99ojM6dro8y19EhBRX9gajb6
	 nssaxVLS45NM3eaLxKGEU7qKrzrc7hmqiQCXSI241sD5qr5JOB44sSxuGDW+fV69I4
	 uwpComdZsobpTtZlE/4k0pb9qGfzvYnbopEY1bKY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sungwoo Kim <iam@sung-woo.kim>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 035/151] Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs
Date: Wed,  6 Nov 2024 13:03:43 +0100
Message-ID: <20241106120309.801220232@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120308.841299741@linuxfoundation.org>
References: <20241106120308.841299741@linuxfoundation.org>
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

From: Sungwoo Kim <iam@sung-woo.kim>

[ Upstream commit 1e67d8641813f1876a42eeb4f532487b8a7fb0a8 ]

Fix __hci_cmd_sync_sk() to return not NULL for unknown opcodes.

__hci_cmd_sync_sk() returns NULL if a command returns a status event.
However, it also returns NULL where an opcode doesn't exist in the
hci_cc table because hci_cmd_complete_evt() assumes status = skb->data[0]
for unknown opcodes.
This leads to null-ptr-deref in cmd_sync for HCI_OP_READ_LOCAL_CODECS as
there is no hci_cc for HCI_OP_READ_LOCAL_CODECS, which always assumes
status = skb->data[0].

KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
CPU: 1 PID: 2000 Comm: kworker/u9:5 Not tainted 6.9.0-ga6bcb805883c-dirty #10
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: hci7 hci_power_on
RIP: 0010:hci_read_supported_codecs+0xb9/0x870 net/bluetooth/hci_codec.c:138
Code: 08 48 89 ef e8 b8 c1 8f fd 48 8b 75 00 e9 96 00 00 00 49 89 c6 48 ba 00 00 00 00 00 fc ff df 4c 8d 60 70 4c 89 e3 48 c1 eb 03 <0f> b6 04 13 84 c0 0f 85 82 06 00 00 41 83 3c 24 02 77 0a e8 bf 78
RSP: 0018:ffff888120bafac8 EFLAGS: 00010212
RAX: 0000000000000000 RBX: 000000000000000e RCX: ffff8881173f0040
RDX: dffffc0000000000 RSI: ffffffffa58496c0 RDI: ffff88810b9ad1e4
RBP: ffff88810b9ac000 R08: ffffffffa77882a7 R09: 1ffffffff4ef1054
R10: dffffc0000000000 R11: fffffbfff4ef1055 R12: 0000000000000070
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88810b9ac000
FS:  0000000000000000(0000) GS:ffff8881f6c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6ddaa3439e CR3: 0000000139764003 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <TASK>
 hci_read_local_codecs_sync net/bluetooth/hci_sync.c:4546 [inline]
 hci_init_stage_sync net/bluetooth/hci_sync.c:3441 [inline]
 hci_init4_sync net/bluetooth/hci_sync.c:4706 [inline]
 hci_init_sync net/bluetooth/hci_sync.c:4742 [inline]
 hci_dev_init_sync net/bluetooth/hci_sync.c:4912 [inline]
 hci_dev_open_sync+0x19a9/0x2d30 net/bluetooth/hci_sync.c:4994
 hci_dev_do_open net/bluetooth/hci_core.c:483 [inline]
 hci_power_on+0x11e/0x560 net/bluetooth/hci_core.c:1015
 process_one_work kernel/workqueue.c:3267 [inline]
 process_scheduled_works+0x8ef/0x14f0 kernel/workqueue.c:3348
 worker_thread+0x91f/0xe50 kernel/workqueue.c:3429
 kthread+0x2cb/0x360 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Fixes: abfeea476c68 ("Bluetooth: hci_sync: Convert MGMT_OP_START_DISCOVERY")

Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_sync.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 75515a1d2923a..c553b637cda7f 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -201,6 +201,12 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 		return ERR_PTR(err);
 	}
 
+	/* If command return a status event skb will be set to NULL as there are
+	 * no parameters.
+	 */
+	if (!skb)
+		return ERR_PTR(-ENODATA);
+
 	return skb;
 }
 EXPORT_SYMBOL(__hci_cmd_sync_sk);
@@ -250,6 +256,11 @@ int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 	u8 status;
 
 	skb = __hci_cmd_sync_sk(hdev, opcode, plen, param, event, timeout, sk);
+
+	/* If command return a status event, skb will be set to -ENODATA */
+	if (skb == ERR_PTR(-ENODATA))
+		return 0;
+
 	if (IS_ERR(skb)) {
 		if (!event)
 			bt_dev_err(hdev, "Opcode 0x%4.4x failed: %ld", opcode,
@@ -257,13 +268,6 @@ int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 		return PTR_ERR(skb);
 	}
 
-	/* If command return a status event skb will be set to NULL as there are
-	 * no parameters, in case of failure IS_ERR(skb) would have be set to
-	 * the actual error would be found with PTR_ERR(skb).
-	 */
-	if (!skb)
-		return 0;
-
 	status = skb->data[0];
 
 	kfree_skb(skb);
-- 
2.43.0




