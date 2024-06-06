Return-Path: <stable+bounces-48526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 903B08FE960
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B590287409
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E461C19A285;
	Thu,  6 Jun 2024 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eeqHWxCu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FD7199EB7;
	Thu,  6 Jun 2024 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683012; cv=none; b=RIebsyfydiZ7UDniE/QCgYVWbkIUbg8/LSItnrscunYCMURoPsATfNG30Bn0jdYsJN3koTGLpUokF1deKL04IEnC2Wcm58kksZpqho1+OvkRMUGQQMVS48WQicvkqGLKoUkWcrW5z1fZ/6CqSpw9MI5GjrBu1SH7mApoNyAYJoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683012; c=relaxed/simple;
	bh=AAVeWYxPCejQ6HNc6qu6sgeWiKpeonbE/9QuacJ5sfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3zF4MsKjcLx+nspJCmq7d8R/49B1pCfNMRnT+MD0Fkjc/LUFvXQ/ryMtJAtRpQUtFfDmYik3ygXvRF+uKl7O3Q0l4IPQ4bfxPTHIIiJqhO0vuH4Vw08bkeBLVZ+XMjsCHP2bO82lE/ePGNJjv071hGBYpSP5Opky2CSq6Nl4+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eeqHWxCu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665D6C4AF0A;
	Thu,  6 Jun 2024 14:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683012;
	bh=AAVeWYxPCejQ6HNc6qu6sgeWiKpeonbE/9QuacJ5sfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eeqHWxCuLkRr1k3P0dOu3GUCI8PP7Jjn7fvva7K5WcO1Ir87+MUIdJwRCvZ0iPIfg
	 0cqoo+zS1wq8szY1bHiwBMxk27aWZPpG4rcHIqOPE68AKZ/Es7DIEelHQYdaeBbyJA
	 HzOrz16pZXM/K0nKFUxhH9fbLxQyez0rgOoAtSwY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Sungwoo Kim <iam@sung-woo.kim>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 224/374] Bluetooth: L2CAP: Fix div-by-zero in l2cap_le_flowctl_init()
Date: Thu,  6 Jun 2024 16:03:23 +0200
Message-ID: <20240606131659.310331397@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sungwoo Kim <iam@sung-woo.kim>

[ Upstream commit a5b862c6a221459d54e494e88965b48dcfa6cc44 ]

l2cap_le_flowctl_init() can cause both div-by-zero and an integer
overflow since hdev->le_mtu may not fall in the valid range.

Move MTU from hci_dev to hci_conn to validate MTU and stop the connection
process earlier if MTU is invalid.
Also, add a missing validation in read_buffer_size() and make it return
an error value if the validation fails.
Now hci_conn_add() returns ERR_PTR() as it can fail due to the both a
kzalloc failure and invalid MTU value.

divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 PID: 67 Comm: kworker/u5:0 Tainted: G        W          6.9.0-rc5+ #20
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: hci0 hci_rx_work
RIP: 0010:l2cap_le_flowctl_init+0x19e/0x3f0 net/bluetooth/l2cap_core.c:547
Code: e8 17 17 0c 00 66 41 89 9f 84 00 00 00 bf 01 00 00 00 41 b8 02 00 00 00 4c
89 fe 4c 89 e2 89 d9 e8 27 17 0c 00 44 89 f0 31 d2 <66> f7 f3 89 c3 ff c3 4d 8d
b7 88 00 00 00 4c 89 f0 48 c1 e8 03 42
RSP: 0018:ffff88810bc0f858 EFLAGS: 00010246
RAX: 00000000000002a0 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffff88810bc0f7c0 RDI: ffffc90002dcb66f
RBP: ffff88810bc0f880 R08: aa69db2dda70ff01 R09: 0000ffaaaaaaaaaa
R10: 0084000000ffaaaa R11: 0000000000000000 R12: ffff88810d65a084
R13: dffffc0000000000 R14: 00000000000002a0 R15: ffff88810d65a000
FS:  0000000000000000(0000) GS:ffff88811ac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000100 CR3: 0000000103268003 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <TASK>
 l2cap_le_connect_req net/bluetooth/l2cap_core.c:4902 [inline]
 l2cap_le_sig_cmd net/bluetooth/l2cap_core.c:5420 [inline]
 l2cap_le_sig_channel net/bluetooth/l2cap_core.c:5486 [inline]
 l2cap_recv_frame+0xe59d/0x11710 net/bluetooth/l2cap_core.c:6809
 l2cap_recv_acldata+0x544/0x10a0 net/bluetooth/l2cap_core.c:7506
 hci_acldata_packet net/bluetooth/hci_core.c:3939 [inline]
 hci_rx_work+0x5e5/0xb20 net/bluetooth/hci_core.c:4176
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0x90f/0x1530 kernel/workqueue.c:3335
 worker_thread+0x926/0xe70 kernel/workqueue.c:3416
 kthread+0x2e3/0x380 kernel/kthread.c:388
 ret_from_fork+0x5c/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---

Fixes: 6ed58ec520ad ("Bluetooth: Use LE buffers for LE traffic")
Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5449c6c086aa4..1ed734a7fb313 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6363,7 +6363,7 @@ static void hci_le_pa_sync_estabilished_evt(struct hci_dev *hdev, void *data,
 	pa_sync = hci_conn_add_unset(hdev, ISO_LINK, BDADDR_ANY,
 				     HCI_ROLE_SLAVE);
 
-	if (!pa_sync)
+	if (IS_ERR(pa_sync))
 		goto unlock;
 
 	pa_sync->sync_handle = le16_to_cpu(ev->handle);
-- 
2.43.0




