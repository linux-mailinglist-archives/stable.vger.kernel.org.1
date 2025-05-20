Return-Path: <stable+bounces-145401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CD5ABDBC6
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21FDF8C28CB
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59544248F4C;
	Tue, 20 May 2025 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qXZt6DQ8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08276242907;
	Tue, 20 May 2025 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750071; cv=none; b=MxZ8eojswIR7YIt/j/REzNDfT7pAl4wWZTGZGDAmdvKzpf0XOne2JOFywrw7MwtjWIkejUpVb1TFZTk7HuasNwgB7pizcQryZgKlY9HEsTcRh6qOxiE5vAh7YGTfOVzsIrdQvwWDFf/pY1NhTrGq1veQ2bAvVpacR/9RNMz986g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750071; c=relaxed/simple;
	bh=S8/Il0nI0udmVcBFlusZ+ni85SYEZZ2p3AXpADIyIUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dcm963/hghZXCAId2mEan5qKLRwCGtQkKCA3Xf5kdHWEK1a4rgSo/eAB1BBwlRBKu/Tle1j1s7etarQ2cdataYKOb7qGk8r1kkQVtv3VGk7KOzkV7P96gBDluNAe/GOnGEXAx7hHimTWcQFhobAFqJcnck17urmN2ax9NYt0F+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qXZt6DQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E20C4CEEB;
	Tue, 20 May 2025 14:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747750070;
	bh=S8/Il0nI0udmVcBFlusZ+ni85SYEZZ2p3AXpADIyIUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qXZt6DQ8Q92a+wnuw3vtVME4xgMSUO62nmGZNxUYfvOHiNJP91EtdzswT9VOY2chv
	 6MvpHBJaUXvPrcMBD643PugB5lhtUicYq4fSFlVcGKkTwItgZ94Iws2E6qVRwiljHJ
	 bKBiuJgnWhKbi2JC1Re+NzaHs6I+rMJURGuASd6U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+e2ce9e275ecc70a30b72@syzkaller.appspotmail.com,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 032/143] RDMA/core: Fix "KASAN: slab-use-after-free Read in ib_register_device" problem
Date: Tue, 20 May 2025 15:49:47 +0200
Message-ID: <20250520125811.310653228@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125810.036375422@linuxfoundation.org>
References: <20250520125810.036375422@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhu Yanjun <yanjun.zhu@linux.dev>

[ Upstream commit d0706bfd3ee40923c001c6827b786a309e2a8713 ]

Call Trace:

 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 strlen+0x93/0xa0 lib/string.c:420
 __fortify_strlen include/linux/fortify-string.h:268 [inline]
 get_kobj_path_length lib/kobject.c:118 [inline]
 kobject_get_path+0x3f/0x2a0 lib/kobject.c:158
 kobject_uevent_env+0x289/0x1870 lib/kobject_uevent.c:545
 ib_register_device drivers/infiniband/core/device.c:1472 [inline]
 ib_register_device+0x8cf/0xe00 drivers/infiniband/core/device.c:1393
 rxe_register_device+0x275/0x320 drivers/infiniband/sw/rxe/rxe_verbs.c:1552
 rxe_net_add+0x8e/0xe0 drivers/infiniband/sw/rxe/rxe_net.c:550
 rxe_newlink+0x70/0x190 drivers/infiniband/sw/rxe/rxe.c:225
 nldev_newlink+0x3a3/0x680 drivers/infiniband/core/nldev.c:1796
 rdma_nl_rcv_msg+0x387/0x6e0 drivers/infiniband/core/netlink.c:195
 rdma_nl_rcv_skb.constprop.0.isra.0+0x2e5/0x450
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x53a/0x7f0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 ____sys_sendmsg+0xa95/0xc70 net/socket.c:2566
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620
 __sys_sendmsg+0x16d/0x220 net/socket.c:2652
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

This problem is similar to the problem that the
commit 1d6a9e7449e2 ("RDMA/core: Fix use-after-free when rename device name")
fixes.

The root cause is: the function ib_device_rename() renames the name with
lock. But in the function kobject_uevent(), this name is accessed without
lock protection at the same time.

The solution is to add the lock protection when this name is accessed in
the function kobject_uevent().

Fixes: 779e0bf47632 ("RDMA/core: Do not indicate device ready when device enablement fails")
Link: https://patch.msgid.link/r/20250506151008.75701-1-yanjun.zhu@linux.dev
Reported-by: syzbot+e2ce9e275ecc70a30b72@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e2ce9e275ecc70a30b72
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 46102f179955b..df2aa15a5bc9b 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1368,6 +1368,9 @@ static void ib_device_notify_register(struct ib_device *device)
 
 	down_read(&devices_rwsem);
 
+	/* Mark for userspace that device is ready */
+	kobject_uevent(&device->dev.kobj, KOBJ_ADD);
+
 	ret = rdma_nl_notify_event(device, 0, RDMA_REGISTER_EVENT);
 	if (ret)
 		goto out;
@@ -1484,10 +1487,9 @@ int ib_register_device(struct ib_device *device, const char *name,
 		return ret;
 	}
 	dev_set_uevent_suppress(&device->dev, false);
-	/* Mark for userspace that device is ready */
-	kobject_uevent(&device->dev.kobj, KOBJ_ADD);
 
 	ib_device_notify_register(device);
+
 	ib_device_put(device);
 
 	return 0;
-- 
2.39.5




