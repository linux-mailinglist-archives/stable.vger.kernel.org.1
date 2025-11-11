Return-Path: <stable+bounces-194424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FABC4B3DE
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 03:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 553FC4E62B6
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD61348468;
	Tue, 11 Nov 2025 02:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Mb8r/qmi"
X-Original-To: stable@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BB932E14A
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 02:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762829216; cv=none; b=b/00FpAR6tr99rjVIAX1K3VIuEE+okEgHmnm8ApOzfoIwnV8UZX8sDu5BAu5aFQHcHiRUok52m0/0+oGgbmEqSeOnbSgFcBj99UW/nU2zBuUgxh8vM5Tbls4qy75ZFaEw+87e22Ndur2b+CbJVo3MB8dbXcxI4RFB8nh7odTKfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762829216; c=relaxed/simple;
	bh=32XMv6wcKtwFSqSBFkS+97LjDAakRBelWZG11HJdzQE=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=scEB6jV1mVh15JITcuAIKo/zRda15a7E3a9Pw5oGQ5BymlqyYSt0c3w2jxViyXLjrCBYVLawYtE5p3Hlv37lRLuo0S7SAQ5aHAupBegbntXLqYZX8uTb/pwLexECGyzhrlwCYV8L4CIW7rRvY6j2hFzuf+d10h/sgZO5s5qgI5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Mb8r/qmi; arc=none smtp.client-ip=43.163.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1762828904;
	bh=c+3Xij452Ppa7gpaPGnM5Db/iOlZ30SHUAYwLlof7cA=;
	h=From:To:Cc:Subject:Date;
	b=Mb8r/qmi1iDmMy6pofZbgOykItNGT80sV6V4ILpHdtnH7xGb/ReH2kEuFWcVJqYa6
	 aySFkfJc6T8WIy868WYg/t33YKAvS44woyGHo0g130WruusqVi1JQ1Yu0o+tmZYraY
	 JHFZzGQSTZb6jPMM1EOpONL6pcl9DVB3QnE6uWT0=
Received: from pek-blan-cn-l1.corp.ad.wrs.com ([120.244.195.255])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id A66888C4; Tue, 11 Nov 2025 10:41:38 +0800
X-QQ-mid: xmsmtpt1762828898teb5zenp4
Message-ID: <tencent_FF86E4B3752C0E284C4FC31B2D4ECDEDC706@qq.com>
X-QQ-XMAILINFO: NkkLWZdzT0a2gP7KCSx7WUC6OEaoFMBp3brH21A2iIEwzPDXszOWgfgA7xt2RZ
	 6eSGYgLfS9PK0LQkUhIzMfqWqY6Q4dtnk4HGUyLLyCEM1MFbWynGWfU9suLAEitUT/tMzbCXmZ8B
	 Pmw8JXuvDRjciCr1K8BCoK2K+vX/xLP18o8Qy9OMrp1XoqYCOEV2R6X8ABcGM4Mh9psiZ7HK5KJ9
	 zfg3SPea3FEmGhZRmPsfd+Ylj4S2bA9OHYIMs3t7y5n56mmIgDFI92cFMLFLLPLCo39F8aqPDPQm
	 qzXB/ERjKJcvlcvW5Ag6Ham3BBH8mrYqQ/zncAVIdfvsdyTsjtYLjBHyCbpI8zKYkrzk9a2h8918
	 ggxEFwxg9HiHkCpnHpQomsWsFOApzk7fMkJplwqEURxQHPpRSMCMBr0+RzVwhWEukG92tcCGK7nK
	 go84IWij0ThY4a8pTqjEkNrGO+Tc2rfBYsdTOzPZVuFavuMS4AKCbVcrjZQNH9FbqfrsCWVb7gQy
	 ZqtrLRsDe7C93VxqlW1xvKaLNKARJbg/d7M7tNzDD+uTDjj5IwUgGt+G2zxzU47O/r6Iok6/n067
	 go7qKfhsNvwXGLfN1+Ja49xGk3g/1PMPoBEGTihZcptCsKEVlPIKRzn04WbboSRmPoG/GPZsHJPs
	 JoIvBGIJ+xLc0hxeWLxrrBPMmwL3KKO0wrhTjMXBA2TSuc7kfNRpX8fcMF+SiPibisPy+QnqwyT0
	 2D96SohyEANn0FUnmll2fTjI1HI9SJfOAHnFOH60WxQsP+5ThlWGT6DfWlLo6TYqoFVzb2Q1AXgm
	 e2+2lrq5+ib9lRPEA2RozIo/tKqzDqRXoHo3sjg52coPSuY0SNDZ0UX11c8/lSZolYZDJHuo/Hyx
	 uTQDfGfYDVBsV1hvWZFz33oftCnq3DUg3pJp3kVg4KP3Su2atqbgkG55eY6IP5LXYwKBw7PpRL9c
	 GgEhdjo87tNDcroKq6C/YwqKj34/jWVk+Wo/jZATQibNLLY5sTW1GQZ3iyHcY/LvucN2jsj3Icq2
	 hRtR6kYoDiDJz2DYbe/DhK632EIM5FkhPYuiBkqw==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: alvalan9@foxmail.com
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.1.y] Bluetooth: hci_sync: fix double free in 'hci_discovery_filter_clear()'
Date: Tue, 11 Nov 2025 10:41:28 +0800
X-OQ-MSGID: <20251111024128.1357-1-alvalan9@foxmail.com>
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
 include/net/bluetooth/hci_core.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4a1faf11785f..b0a7ceb99eec 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -28,7 +28,7 @@
 #include <linux/idr.h>
 #include <linux/leds.h>
 #include <linux/rculist.h>
-
+#include <linux/spinlock.h>
 #include <net/bluetooth/hci.h>
 #include <net/bluetooth/hci_sync.h>
 #include <net/bluetooth/hci_sock.h>
@@ -92,6 +92,7 @@ struct discovery_state {
 	unsigned long		scan_start;
 	unsigned long		scan_duration;
 	unsigned long		name_resolve_timeout;
+	spinlock_t		lock;
 };
 
 #define SUSPEND_NOTIFIER_TIMEOUT	msecs_to_jiffies(2000) /* 2 seconds */
@@ -881,6 +882,7 @@ static inline void iso_recv(struct hci_conn *hcon, struct sk_buff *skb,
 
 static inline void discovery_init(struct hci_dev *hdev)
 {
+	spin_lock_init(&hdev->discovery.lock);
 	hdev->discovery.state = DISCOVERY_STOPPED;
 	INIT_LIST_HEAD(&hdev->discovery.all);
 	INIT_LIST_HEAD(&hdev->discovery.unknown);
@@ -895,8 +897,12 @@ static inline void hci_discovery_filter_clear(struct hci_dev *hdev)
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


