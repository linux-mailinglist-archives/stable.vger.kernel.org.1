Return-Path: <stable+bounces-75432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CF1973484
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9621C24FCB
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F8318C03E;
	Tue, 10 Sep 2024 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="widdOfb5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D1A5674D;
	Tue, 10 Sep 2024 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964715; cv=none; b=TUC19YBq7NUMCTHepTEygyRDnEqLDznu3aUpcLvR8JMm2kxY+BvP8++MvvNOpA6EVrZtSyu4uwn71R0U9RBgts2BJ8BlCsSw+MHJH2jlWr4kZu0OKYBR/hEIy/JERRJWaZH/+SRXz3dCeysSe9SG837pS6f0AMRAYIFPg5ls6v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964715; c=relaxed/simple;
	bh=KNaNsW/j6NDztrnWr9mElq12kT0biRIigUEDce25i24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pcvh3ciluIdUKeTjuBJJbQCYfBjFyLq/eISNOwh2a9uuT8NTaOztxiuBmeW8ucojqZtIF1JnQo/jQefX7Hv0mRSpr6VRGATf3Jtea+UG5XHIkbQSTOFcbLpb723/Kkk0KHBrcU1iy0rUXa2BN3EyVsHoaOSzLn07K7aXArJrOw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=widdOfb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955FEC4CEC3;
	Tue, 10 Sep 2024 10:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725964715;
	bh=KNaNsW/j6NDztrnWr9mElq12kT0biRIigUEDce25i24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=widdOfb5V3zTDICNZn8peNGno5CjmUfeBftwisAlqjtcO6J3Pke/iqEhwG1Vu1BLw
	 E97QLkxBkvjg9riRXs0Nrrt3z3g8Qn9+ACuYphsXk0cQcb1r4yY1BnlT8dp3dYRPM5
	 gXdcpV1qGjPe/O/3yerMqBR2K5N3R3IIO7JrtIrI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.6 269/269] Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync
Date: Tue, 10 Sep 2024 11:34:16 +0200
Message-ID: <20240910092617.320405012@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
References: <20240910092608.225137854@linuxfoundation.org>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

commit 7453847fb22c7c45334c43cc6a02ea5df5b9961d upstream.

Fixes the following trace where hci_acl_create_conn_sync attempts to
call hci_abort_conn_sync after timeout:

BUG: KASAN: slab-use-after-free in hci_abort_conn_sync
(net/bluetooth/hci_sync.c:5439)
Read of size 2 at addr ffff88800322c032 by task kworker/u3:2/36

Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38
04/01/2014
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
<TASK>
dump_stack_lvl (./arch/x86/include/asm/irqflags.h:26
./arch/x86/include/asm/irqflags.h:67 ./arch/x86/include/asm/irqflags.h:127
lib/dump_stack.c:107)
print_report (mm/kasan/report.c:378 mm/kasan/report.c:488)
? preempt_count_sub (kernel/sched/core.c:5889)
? __virt_addr_valid (./arch/x86/include/asm/preempt.h:103 (discriminator 1)
./include/linux/rcupdate.h:865 (discriminator 1)
./include/linux/mmzone.h:2026 (discriminator 1)
arch/x86/mm/physaddr.c:65 (discriminator 1))
? hci_abort_conn_sync (net/bluetooth/hci_sync.c:5439)
kasan_report (mm/kasan/report.c:603)
? hci_abort_conn_sync (net/bluetooth/hci_sync.c:5439)
hci_abort_conn_sync (net/bluetooth/hci_sync.c:5439)
? __pfx_hci_abort_conn_sync (net/bluetooth/hci_sync.c:5433)
hci_acl_create_conn_sync (net/bluetooth/hci_sync.c:6681)

Fixes: 45340097ce6e ("Bluetooth: hci_conn: Only do ACL connections sequentially")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/hci_sync.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6796,15 +6796,10 @@ static int hci_acl_create_conn_sync(stru
 	else
 		cp.role_switch = 0x00;
 
-	err = __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
-				       sizeof(cp), &cp,
-				       HCI_EV_CONN_COMPLETE,
-				       HCI_ACL_CONN_TIMEOUT, NULL);
-
-	if (err == -ETIMEDOUT)
-		hci_abort_conn_sync(hdev, conn, HCI_ERROR_LOCAL_HOST_TERM);
-
-	return err;
+	return __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
+					sizeof(cp), &cp,
+					HCI_EV_CONN_COMPLETE,
+					conn->conn_timeout, NULL);
 }
 
 int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn)



