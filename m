Return-Path: <stable+bounces-195096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5FEC68BF3
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 11:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA37F4EEDD6
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 10:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC76C333732;
	Tue, 18 Nov 2025 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TKKjqYnB"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66668332918
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460749; cv=none; b=eydvntYR/BjV3NAjZF9UdSRC0zga+/ALRKiYOEfOJcqwl+zm1nzigHcY619TDkrT2bgZwurrAm15/f4nNVUr8ms3kD17pX0/Bett+O5W9DMIMA9ofgD7zNokwZzVh2hpgcamMtYGICMZS5f/7w+D2RFCM67t43QoLVwTfONIuF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460749; c=relaxed/simple;
	bh=SeOijDDBbx/gt8b41/UY+Z9ZzrzLSuYGOCdDop6i7I4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iLjkPOOsaHoMcaMNGyOFECZDjEX6MCeSu9qkHWpGsxAF8MTieVwLEGaYJprrj2cpECPFjqwr75+J0O5p4L3swmYwG0rwtW5JuVqIvkvH3SXdz9dFtNQ/W72532NQbCLF0J+OiE3ziXy/LgpXOntIKNQNs2KEKmAT8nRK+MAj380=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TKKjqYnB; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nQ
	LVkl2V7v/t3JQEFAjk0mHOi1899CqsYo+GwAOjuHA=; b=TKKjqYnBYp1GJ0sq8l
	l+0x3xO3ltjLqBVQY1fIAtsFxcKnlCvobOHQ7KMC7AWO3DkiZmTEm5PLUuCEvqHu
	VaFMobWtC5a4rjy++uh+S4LCO0NSEiKc4unyN2Sx86uIbQsz64H0r8JnA9QSlM/l
	mnhH61in11nTN0Y6elTxM/Ua4=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDHlOI2RhxpjRW9EQ--.15317S2;
	Tue, 18 Nov 2025 18:11:03 +0800 (CST)
From: zhangchen200426@163.com
To: luiz.von.dentz@intel.com,
	pav@iki.fi,
	pmenzel@molgen.mpg.de,
	chharry@chromium.org,
	kuniyu@google.com,
	yang.li@amlogic.com,
	linux@treblig.org,
	ceggers@arri.de,
	nishiyama.pedro@gmail.com,
	marcel@holtmann.org
Cc: zhangchen <zhangchen01@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: HCI: Fix hci0 not release in usb disconnect process
Date: Tue, 18 Nov 2025 18:10:54 +0800
Message-Id: <20251118101054.1182503-1-zhangchen200426@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDHlOI2RhxpjRW9EQ--.15317S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuw4DurWkGrWUWr4UJFy7ZFb_yoW3Ar1kpa
	9Ika4fAw18Jr4Sg34rAa18JF9Yk3yI93y7CFZ7W3srG39Yy34UtryUAryYqF9ruryDJr1q
	vF4Dta1a9Fy8Gw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jMfO7UUUUU=
X-CM-SenderInfo: x2kd0whfkh0jaqqujli6rwjhhfrp/xtbCwBcAnGkcRjdG0wAA3a

From: zhangchen <zhangchen01@kylinos.cn>

If hci_resume_dev before hci_unregister_dev, the hci command will
timeout and the reference count of hdev will not reset to zero.
Then the node "hci0" will not release.

The output in question is as follows:
[ 3391.553518][ 7] [T247244] Bluetooth: hci0: command 0x0c01 tx timeout
[ 3391.553588][ 7] [T264732] Bluetooth: hci0: Opcode 0x0c01 failed: -110
[ 3393.569514][ 3] [T247244] Bluetooth: hci0: command 0x0c01 tx timeout
[ 3393.569515][ 3] [T264732] Bluetooth: hci0: Opcode 0x0c1a failed: -110
[ 3393.709645][ 6] [T104579] usb 10-1: new full-speed USB device number 95 using xhci-hcd
[ 3393.862194][ 6] [T104579] usb 10-1: New USB device found, idVendor=13d3, idProduct=3570, bcdDevice= 0.00
[ 3393.862205][ 6] [T104579] usb 10-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 3393.862208][ 6] [T104579] usb 10-1: Product: Bluetooth Radio
[ 3393.862210][ 6] [T104579] usb 10-1: Manufacturer: Realtek
[ 3393.862212][ 6] [T104579] usb 10-1: SerialNumber: 00e04c000001
[ 3393.867589][ 6] [T247244] Bluetooth: hci1: RTL: examining hci_ver=0b hci_rev=000b lmp_ver=0b lmp_subver=8852
[ 3393.868573][ 6] [T247244] Bluetooth: hci1: RTL: rom_version status=0 version=1
[ 3393.868583][ 6] [T247244] Bluetooth: hci1: RTL: loading rtl_bt/rtl8852bu_fw.bin
[ 3393.868672][ 6] [T247244] Bluetooth: hci1: RTL: loading rtl_bt/rtl8852bu_config.bin
[ 3393.869699][ 6] [T247244] Bluetooth: hci1: RTL: cfg_sz 6, total sz 65603

The call sequence in question is as follows:
usb disconnect:
  btusb_disconnect
   hci_unregister_dev
    hci_dev_set_flag
    hci_cmd_sync_clear
    hci_unregister_suspend_notifier
    hci_dev_do_close
    device_del

device resume:
  hci_suspend_notifier
   hci_resume_dev
    hci_resume_sync
     hci_set_event_mask_sync
      __hci_cmd_sync_status
       __hci_cmd_sync_status_sk
        __hci_cmd_sync_sk
         wait_event_interruptible_timeout

The output after adding debug information in question is as follows:
[ 6378.366215][ 6] [T434033] hci_resume_dev hci name hci0
[ 6378.366218][ 6] [T434033] hci_resume_sync set event mask sync
[ 6378.366219][ 6] [T434033] hci_set_event_mask_sync
[ 6378.366220][ 6] [T434033] __hci_cmd_sync_sk hci name hci0 Opcode 0x0c01
[ 6378.366227][ 6] [T434033] __hci_cmd_sync_sk wait event interruptible timeout
[ 6378.367632][ 6] [T420012] btusb_disconnect intf 0000000024117fc1
[ 6378.367637][ 6] [T420012] btusb_disconnect hci_unregister_dev
[ 6378.367638][ 6] [T420012] hci_unregister_dev 0000000064bfd783 name hci0 bus 1
[ 6378.367641][ 6] [T420012] hci_unregister_dev set flag
[ 6378.367804][ 6] [T420012] hci_unregister_dev cmd sync clear
[ 6378.367807][ 6] [T420012] hci_unregister_dev unregister suspend notifier
[ 6380.367544][ 6] [T434033] __hci_cmd_sync_sk cmd timeout
[ 6380.367542][ 6] [T197498] Bluetooth: hci0: command 0x0c01 tx timeout
[ 6380.367550][ 6] [T434033] __hci_cmd_sync_sk hci0 end: err -110
[ 6380.367552][ 6] [T434033] Bluetooth: hci0: Opcode 0x0c01 failed: -110
[ 6380.367555][ 6] [T434033] hci_resume_sync clear event filter
[ 6380.367556][ 6] [T434033] hci_resume_sync resume scan sync
[ 6380.367558][ 6] [T434033] __hci_cmd_sync_sk hci name hci0 Opcode 0x0c1a
[ 6380.367561][ 6] [T434033] __hci_cmd_sync_sk wait event interruptible timeout
[ 6382.383538][ 6] [T197498] Bluetooth: hci0: command 0x0c01 tx timeout
[ 6382.383593][ 6] [T434033] __hci_cmd_sync_sk hci0 end: err -110
[ 6382.383597][ 6] [T434033] Bluetooth: hci0: Opcode 0x0c1a failed: -110

The output after adding debug information in normal is as follows:
[50.039156][ 6] [ T8360] btusb_disconnect intf 00000000fca35842
[50.039160][ 6] [ T8360] btusb_disconnect hci_unregister_dev
[50.039162][ 6] [ T8360] hci_unregister_dev 000000002422b946 name hci0 bus 1
[50.039164][ 6] [ T8360] hci_unregister_dev set flag
[50.039224][ 6] [ T8360] hci_unregister_dev cmd sync clear
[50.039227][ 5] [ T8360] hci_unregister_dev unregister suspend notifier
[50.043542][ 5] [ T8284] hci_resume_dev hci name hci0

This patch add hci_cancel_cmd_sync in hci_unregister_dev to wake up
hdev->req_wait_q, and stop __hci_cmd_sync_sk by judging the
HCI_UNREGISTER flag. Then stopping hci_resume_dev process based on the
returned error code.

Fixes: 182ee45da083 ("Bluetooth: hci_sync: Rework hci_suspend_notifier")
Cc: stable@vger.kernel.org
Signed-off-by: zhangchen <zhangchen01@kylinos.cn>
---
 net/bluetooth/hci_core.c |  6 ++++++
 net/bluetooth/hci_sync.c | 22 ++++++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3418d7b964a1..c977bcba3e76 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -50,6 +50,7 @@
 static void hci_rx_work(struct work_struct *work);
 static void hci_cmd_work(struct work_struct *work);
 static void hci_tx_work(struct work_struct *work);
+static void hci_cancel_cmd_sync(struct hci_dev *hdev, int err);
 
 /* HCI device list */
 LIST_HEAD(hci_dev_list);
@@ -2695,6 +2696,8 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_dev_set_flag(hdev, HCI_UNREGISTER);
 	mutex_unlock(&hdev->unregister_lock);
 
+	hci_cancel_cmd_sync(hdev, EINTR);
+
 	write_lock(&hci_dev_list_lock);
 	list_del(&hdev->list);
 	write_unlock(&hci_dev_list_lock);
@@ -2877,6 +2880,9 @@ int hci_resume_dev(struct hci_dev *hdev)
 	ret = hci_resume_sync(hdev);
 	hci_req_sync_unlock(hdev);
 
+	if (ret && hci_dev_test_flag(hdev, HCI_UNREGISTER))
+		return 0;
+
 	mgmt_resuming(hdev, hdev->wake_reason, &hdev->wake_addr,
 		      hdev->wake_addr_type);
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 6e76798ec786..f48d34fbfff2 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -174,10 +174,11 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 		return ERR_PTR(err);
 
 	err = wait_event_interruptible_timeout(hdev->req_wait_q,
-					       hdev->req_status != HCI_REQ_PEND,
+					       hdev->req_status != HCI_REQ_PEND ||
+					       hci_dev_test_flag(hdev, HCI_UNREGISTER),
 					       timeout);
 
-	if (err == -ERESTARTSYS)
+	if (err == -ERESTARTSYS || hci_dev_test_flag(hdev, HCI_UNREGISTER))
 		return ERR_PTR(-EINTR);
 
 	switch (hdev->req_status) {
@@ -6296,6 +6297,7 @@ static int hci_resume_scan_sync(struct hci_dev *hdev)
  */
 int hci_resume_sync(struct hci_dev *hdev)
 {
+	int err;
 	/* If not marked as suspended there nothing to do */
 	if (!hdev->suspended)
 		return 0;
@@ -6303,10 +6305,14 @@ int hci_resume_sync(struct hci_dev *hdev)
 	hdev->suspended = false;
 
 	/* Restore event mask */
-	hci_set_event_mask_sync(hdev);
+	err = hci_set_event_mask_sync(hdev);
+	if (err && hci_dev_test_flag(hdev, HCI_UNREGISTER))
+		return err;
 
 	/* Clear any event filters and restore scan state */
-	hci_clear_event_filter_sync(hdev);
+	err = hci_clear_event_filter_sync(hdev);
+	if (err && hci_dev_test_flag(hdev, HCI_UNREGISTER))
+		return err;
 
 	/* Resume scanning */
 	hci_resume_scan_sync(hdev);
@@ -6315,10 +6321,14 @@ int hci_resume_sync(struct hci_dev *hdev)
 	hci_resume_monitor_sync(hdev);
 
 	/* Resume other advertisements */
-	hci_resume_advertising_sync(hdev);
+	err = hci_resume_advertising_sync(hdev);
+	if (err && hci_dev_test_flag(hdev, HCI_UNREGISTER))
+		return err;
 
 	/* Resume discovery */
-	hci_resume_discovery_sync(hdev);
+	err = hci_resume_discovery_sync(hdev);
+	if (err && hci_dev_test_flag(hdev, HCI_UNREGISTER))
+		return err;
 
 	return 0;
 }
-- 
2.25.1


