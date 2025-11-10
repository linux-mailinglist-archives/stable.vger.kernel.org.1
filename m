Return-Path: <stable+bounces-192948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AFDC4693A
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 13:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE759189162F
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 12:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4364C30C36F;
	Mon, 10 Nov 2025 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="NOyCK2Xo"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D524204E
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762777480; cv=none; b=c1lkP1eRt1sGSJSerIlfCOnlI0wtMbn6QTGXNHECtAoinYLB3F8Ycnv56b10X6g6aVU/pf+0A0CkvFNgO8YQFLsoU5I5pKzNqiaMa1vjJ67VrusZiZzfqr6kqn3P03MtxTBjrG7Qb6jZ30U+0B+NtqZQAmr73MqE8sQD9PFlLxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762777480; c=relaxed/simple;
	bh=iBjE4qsUXRnUKxokF53ibNtr8teJpeoQfYoPxvA+jt0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=moUn1LlopH6BxanAxyYTnpLdTw08dl71uq0RYvBnAV54clxgWwTSzZI7KKlQrPjWTljG5PptKn79vD34SeFiuyi6kGPMEuqeFJipRTGUnT055COWnDR3XjuojJrrOhSmkNLYArI2OfYekFV6fVzHsRpS6FHZ63Nx1ZSJ+z4FfsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=NOyCK2Xo; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1762777167;
	bh=vvt/OcCHPdN6qdJpeUCyR+Kpo8faYRmxmEfKlW+uK8U=;
	h=From:To:Cc:Subject:Date;
	b=NOyCK2XoEdx7sk1S3hyaZYIgU8UYjMHAzn9Rja+VdEjY+Bckvmrv+WWpnnyTGYvpf
	 KHMYgBpYdyIY610sY/SqA2GqLC1ZjwrByAJB8DNTvNt+zxHGDek1eag09DfCHsB1xk
	 lk45ZYATwcLdSS5XTZTeVP3TllA9osespVK7jYPk=
Received: from pek-blan-cn-l1.corp.ad.wrs.com ([120.244.195.255])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id 4B13520E; Mon, 10 Nov 2025 20:18:49 +0800
X-QQ-mid: xmsmtpt1762777129tyozap6np
Message-ID: <tencent_1120D6A1383F30BC0D07B441359D1F619208@qq.com>
X-QQ-XMAILINFO: Nco5cZgmLIi8Yg+jK6h8MmF2eUINN7+2avq6Kj7iszJL4dq4O9ZFD8/TedQozh
	 AkHBq9MeN1UE38r0nAUjAdbBdDOcOkdVUXiOKQPkaZdSlZL25fooZ4tEFy52uiXIPJqWcwB2V9wq
	 U1xk/X97tyyzZ46l0dPSiVYXeFyIhKzlYwvre//kwzK8xsbuGGuotXn20kf7eMQzbU4QNZonmcD2
	 D8bA/JYtLVSejwn+XW1IYlG7Em8LSqZpI0i+K/QVfWknElp7dmnA5LpbBAnHKlPC6g3va61utqGU
	 15+nYTMUgKlcoiRlyaQLhbDyHuBuEr5L71vHvLoFyPCuXiULLJ03Eo6AWbBRe0UVCITIeGp/dDzt
	 28jMxzrAwSuhubCRlzCpesIDJR/IgD064ygbx3nfk4GXMhqfNPZJvUd7r+s0mVXbX7UyYtJOuwuQ
	 8GpanOWg9c8SipDWghIfmRbY0NNSzWNre8B96x7w7etj0YWVHDbvZsWsbNcoCiak0S2wYNPR3el2
	 N4jdMqIqo8XJQw06eNF1A+Yc59S184lH43PE60G+n3gXG/t5hC+7hYLutUYWWHKZOteBOaSI8I2P
	 bYww0qA8klpbh+Q6BHbUAw+GiIi2TLrZaezyTqXqOaYy0BN9seANr0yVIfnYZ/GXhoMYvP4fjP5E
	 QhGpK+ZtDSyI/5MikCO0ZUXfE242ygt33SPOvo8HkeOXpgPzjQP9FT+gJWM4RmqjENZczk3uyuD5
	 mNGDC2hZwNRjyKoyvp2Mz+2mFOB7mmtG7G5r210BcszGrvg1kw7Xf1IQQRBUCLkPuxAF0UiXBUt+
	 vLgyjIJqhCGYeo7PdEncyaiZGhQdsOWgxIc20DnNJmk6FzydqtYsRqJN/B9p6/hvN08GgKTCxNwN
	 nOTYWD4s7gyVhGBCFzLUYncZEdHvV94t2e3uO8IvTZpwMH0Rc4+mPo9UVN8EXGBT6uiSeHMhdq9K
	 b32SyuG5h8va+sKPCkT2GLvOTG6tfoUFgtMNuQo8cqwbyYYSfn2kRMkvOeh3+GiH9W0z6j/mqMPR
	 Hk7Sp67TaGTXd5DlPpbOmU/D1OY71sUcDaOaLuj6S09fiUNOpm
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: alvalan9@foxmail.com
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.6.y] Bluetooth: hci_sync: fix double free in 'hci_discovery_filter_clear()'
Date: Mon, 10 Nov 2025 20:18:47 +0800
X-OQ-MSGID: <20251110121847.5361-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arseniy Krasnov <avkrasnov@salutedevices.com>

[ Upstream commit 2935e556850e9c94d7a00adf14d3cd7fe406ac03 ]

Function 'hci_discovery_filter_clear()' frees 'uuids' array and then
sets it to NULL. There is a tiny chance of the following race:

'hci_cmd_sync_work()'

 'update_passive_scan_sync()'

   'hci_update_passive_scan_sync()'

     'hci_discovery_filter_clear()'
       kfree(uuids);

       <-------------------------preempted-------------------------------->
                                           'start_service_discovery()'

                                             'hci_discovery_filter_clear()'
                                               kfree(uuids); // DOUBLE FREE

       <-------------------------preempted-------------------------------->

      uuids = NULL;

To fix it let's add locking around 'kfree()' call and NULL pointer
assignment. Otherwise the following backtrace fires:

[ ] ------------[ cut here ]------------
[ ] kernel BUG at mm/slub.c:547!
[ ] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
[ ] CPU: 3 UID: 0 PID: 246 Comm: bluetoothd Tainted: G O 6.12.19-kernel #1
[ ] Tainted: [O]=OOT_MODULE
[ ] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ ] pc : __slab_free+0xf8/0x348
[ ] lr : __slab_free+0x48/0x348
...
[ ] Call trace:
[ ]  __slab_free+0xf8/0x348
[ ]  kfree+0x164/0x27c
[ ]  start_service_discovery+0x1d0/0x2c0
[ ]  hci_sock_sendmsg+0x518/0x924
[ ]  __sock_sendmsg+0x54/0x60
[ ]  sock_write_iter+0x98/0xf8
[ ]  do_iter_readv_writev+0xe4/0x1c8
[ ]  vfs_writev+0x128/0x2b0
[ ]  do_writev+0xfc/0x118
[ ]  __arm64_sys_writev+0x20/0x2c
[ ]  invoke_syscall+0x68/0xf0
[ ]  el0_svc_common.constprop.0+0x40/0xe0
[ ]  do_el0_svc+0x1c/0x28
[ ]  el0_svc+0x30/0xd0
[ ]  el0t_64_sync_handler+0x100/0x12c
[ ]  el0t_64_sync+0x194/0x198
[ ] Code: 8b0002e6 eb17031f 54fffbe1 d503201f (d4210000)
[ ] ---[ end trace 0000000000000000 ]---

Fixes: ad383c2c65a5 ("Bluetooth: hci_sync: Enable advertising when LL privacy is enabled")
Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ Minor context change fixed. ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 include/net/bluetooth/hci_core.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 62135b7782f5..c7f402a0a958 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -29,6 +29,7 @@
 #include <linux/idr.h>
 #include <linux/leds.h>
 #include <linux/rculist.h>
+#include <linux/spinlock.h>
 #include <linux/srcu.h>
 
 #include <net/bluetooth/hci.h>
@@ -95,6 +96,7 @@ struct discovery_state {
 	unsigned long		scan_start;
 	unsigned long		scan_duration;
 	unsigned long		name_resolve_timeout;
+	spinlock_t		lock;
 };
 
 #define SUSPEND_NOTIFIER_TIMEOUT	msecs_to_jiffies(2000) /* 2 seconds */
@@ -869,6 +871,7 @@ static inline void iso_recv(struct hci_conn *hcon, struct sk_buff *skb,
 
 static inline void discovery_init(struct hci_dev *hdev)
 {
+	spin_lock_init(&hdev->discovery.lock);
 	hdev->discovery.state = DISCOVERY_STOPPED;
 	INIT_LIST_HEAD(&hdev->discovery.all);
 	INIT_LIST_HEAD(&hdev->discovery.unknown);
@@ -883,8 +886,12 @@ static inline void hci_discovery_filter_clear(struct hci_dev *hdev)
 	hdev->discovery.report_invalid_rssi = true;
 	hdev->discovery.rssi = HCI_RSSI_INVALID;
 	hdev->discovery.uuid_count = 0;
+
+	spin_lock(&hdev->discovery.lock);
 	kfree(hdev->discovery.uuids);
 	hdev->discovery.uuids = NULL;
+	spin_unlock(&hdev->discovery.lock);
+
 	hdev->discovery.scan_start = 0;
 	hdev->discovery.scan_duration = 0;
 }
-- 
2.43.0


