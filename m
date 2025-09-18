Return-Path: <stable+bounces-169006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4FBB237B4
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152436E01D0
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0952DA779;
	Tue, 12 Aug 2025 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jq3byNz8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368F2260583;
	Tue, 12 Aug 2025 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026066; cv=none; b=KGH0WVno3LOK9IbxzhRM2pcAvkZpy4kt0oXop/3XxsMKhanBXCxW6Ni7eneewfCafcLbKVwk9psCi5nf7XfYqme5p56MQKnsMOCqyooNXTW8iqUFvcTSp+E4vXs3yoaGvPMWXBaDK6a1QoP/Xg6UMFh9oizLgJOo4PG3rxI2l8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026066; c=relaxed/simple;
	bh=4nN+ORKgWrb9uB2HlyzlMKvLwEQPqSlaT2RXgBu312o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAK/p/4jZzrg2EthliQqS0pbdYb3TIpvrUJ9JTWyd5yjStAt+0mzdwFgkrM4d80z4MnLOwCHlT133PnHm0r2RBQB8vWb+nvTucsODgAEFFw3+retFVi4/SUcj4VTQjuS3+Tj1RaUDa4l09QurFjCiTAlPd6E0Cy5faL5R/TJ2qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jq3byNz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3047C4CEF6;
	Tue, 12 Aug 2025 19:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755026066;
	bh=4nN+ORKgWrb9uB2HlyzlMKvLwEQPqSlaT2RXgBu312o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jq3byNz8xY3mE/8+bL1ExcMalFJaxyBjvDUW0BMPlIOBoOX3fv2xcEn3l0JqehiTB
	 QzJVsyv8htxGdOvfmayqsbupYucGExzUZfyVmYdh34UQ/n+7ZEAXu50kpbSrE6FIu4
	 NnEm9+2JDMqrmfPRLRNOFw3wyGHBvqAz9T5KWftw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 193/480] Bluetooth: hci_devcd_dump: fix out-of-bounds via dev_coredumpv
Date: Tue, 12 Aug 2025 19:46:41 +0200
Message-ID: <20250812174405.456544557@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Pravdin <ipravdin.official@gmail.com>

[ Upstream commit 7af4d7b53502286c6cf946d397ab183e76d14820 ]

Currently both dev_coredumpv and skb_put_data in hci_devcd_dump use
hdev->dump.head. However, dev_coredumpv can free the buffer. From
dev_coredumpm_timeout documentation, which is used by dev_coredumpv:

    > Creates a new device coredump for the given device. If a previous one hasn't
    > been read yet, the new coredump is discarded. The data lifetime is determined
    > by the device coredump framework and when it is no longer needed the @free
    > function will be called to free the data.

If the data has not been read by the userspace yet, dev_coredumpv will
discard new buffer, freeing hdev->dump.head. This leads to
vmalloc-out-of-bounds error when skb_put_data tries to access
hdev->dump.head.

A crash report from syzbot illustrates this:

    ==================================================================
    BUG: KASAN: vmalloc-out-of-bounds in skb_put_data
    include/linux/skbuff.h:2752 [inline]
    BUG: KASAN: vmalloc-out-of-bounds in hci_devcd_dump+0x142/0x240
    net/bluetooth/coredump.c:258
    Read of size 140 at addr ffffc90004ed5000 by task kworker/u9:2/5844

    CPU: 1 UID: 0 PID: 5844 Comm: kworker/u9:2 Not tainted
    6.14.0-syzkaller-10892-g4e82c87058f4 #0 PREEMPT(full)
    Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
    Google 02/12/2025
    Workqueue: hci0 hci_devcd_timeout
    Call Trace:
     <TASK>
     __dump_stack lib/dump_stack.c:94 [inline]
     dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
     print_address_description mm/kasan/report.c:408 [inline]
     print_report+0xc3/0x670 mm/kasan/report.c:521
     kasan_report+0xe0/0x110 mm/kasan/report.c:634
     check_region_inline mm/kasan/generic.c:183 [inline]
     kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
     __asan_memcpy+0x23/0x60 mm/kasan/shadow.c:105
     skb_put_data include/linux/skbuff.h:2752 [inline]
     hci_devcd_dump+0x142/0x240 net/bluetooth/coredump.c:258
     hci_devcd_timeout+0xb5/0x2e0 net/bluetooth/coredump.c:413
     process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
     process_scheduled_works kernel/workqueue.c:3319 [inline]
     worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
     kthread+0x3c2/0x780 kernel/kthread.c:464
     ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
     ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
     </TASK>

    The buggy address ffffc90004ed5000 belongs to a vmalloc virtual mapping
    Memory state around the buggy address:
     ffffc90004ed4f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
     ffffc90004ed4f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
    >ffffc90004ed5000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                       ^
     ffffc90004ed5080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
     ffffc90004ed5100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
    ==================================================================

To avoid this issue, reorder dev_coredumpv to be called after
skb_put_data that does not free the data.

Reported-by: syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ac3c79181f6aecc5120c
Fixes: b257e02ecc46 ("HCI: coredump: Log devcd dumps into the monitor")
Tested-by: syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com
Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/coredump.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/coredump.c b/net/bluetooth/coredump.c
index 819eacb38762..720cb79adf96 100644
--- a/net/bluetooth/coredump.c
+++ b/net/bluetooth/coredump.c
@@ -249,15 +249,15 @@ static void hci_devcd_dump(struct hci_dev *hdev)
 
 	size = hdev->dump.tail - hdev->dump.head;
 
-	/* Emit a devcoredump with the available data */
-	dev_coredumpv(&hdev->dev, hdev->dump.head, size, GFP_KERNEL);
-
 	/* Send a copy to monitor as a diagnostic packet */
 	skb = bt_skb_alloc(size, GFP_ATOMIC);
 	if (skb) {
 		skb_put_data(skb, hdev->dump.head, size);
 		hci_recv_diag(hdev, skb);
 	}
+
+	/* Emit a devcoredump with the available data */
+	dev_coredumpv(&hdev->dev, hdev->dump.head, size, GFP_KERNEL);
 }
 
 static void hci_devcd_handle_pkt_complete(struct hci_dev *hdev,
-- 
2.39.5




