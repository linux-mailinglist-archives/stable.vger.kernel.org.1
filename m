Return-Path: <stable+bounces-272888-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oH23LQyLT2r0jAIAu9opvQ
	(envelope-from <stable+bounces-272888-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 13:50:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 260A9730991
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 13:50:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=jqWYavq4;
	dmarc=pass (policy=none) header.from=163.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272888-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272888-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A86953048A26
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 11:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F08A40E8CE;
	Thu,  9 Jul 2026 11:48:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6714B3F8233;
	Thu,  9 Jul 2026 11:48:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783597697; cv=none; b=XBaZ6LUryOxsZ12HswtvM1Jjma+yQWL1ZpwG5hA2GDlCI60/JLHPvKh8CbuAyBc8uns0G7nC9bhVltMiW0Ok4jFl2nAOzeXr3hQr/bNMFS/lbw1grvNLgW4dOueVNZ8FCYjdCjI86UR7NTmA1y0ZzwT17iAuID9TYo1MXdAiK9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783597697; c=relaxed/simple;
	bh=3GHVytqAiXztOpvo3irA/vj2g4iFfeqJ9bonYBsjPOY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eCw0uXUKyIXNLa7/2RV3SnjOPfIBLjM7A2IROdrl77wJ2KcGWt0bZ/gzz52jOSr3PPVbYp4NjwQmdC9SdF4/PSSzET8kuXRfy22BBFhDjDxSy9hrX/iFI2zgp9AQ+nufJ3eIyXGejJzzefhhxd7zB82uTSruyGFPL5ZmXTBhSJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jqWYavq4; arc=none smtp.client-ip=220.197.31.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=TQ
	2dgI13JWSwktDEmuOJMUNjWbExU+eiPgxf6tnfoW8=; b=jqWYavq4f045OAUzlJ
	Wqgm2eBhuNfeNeIsU8fONZtNpzBVFYn9huJy92i7dfQgH6NbDkivi5U9oRuBKp4d
	oY505kINaHjREeaR1qzL8d9A7JpT/iA0YUoAOLTDa2zCWd8H1S0LjNQYZnbA2Dod
	2LJxSQd8JVPuk9S/tLXNP2beo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAHRqBiik9q5_JKIw--.24489S2;
	Thu, 09 Jul 2026 19:47:48 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	yangyingliang@huawei.com,
	error27@gmail.com,
	mst@redhat.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] Bluetooth: virtio: Fix virtbt_probe() init and cleanup
Date: Thu,  9 Jul 2026 19:47:45 +0800
Message-Id: <20260709114745.4030794-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHRqBiik9q5_JKIw--.24489S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArWxAF1DXF13XFWUXF48Crg_yoW5WrW5pF
	sxWF98AFy0gFW3Can8Xa18ua4xCFs7C3yIgrWaq3s0grZ0yrWUAryjy34UKa4UZrZ8Zay8
	JF4kJ34kZrWDuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUUfQiUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7QQqmGpPimRsSgAA32
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:yangyingliang@huawei.com,m:error27@gmail.com,m:mst@redhat.com,m:linux-bluetooth@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:haoxiang_li2024@163.com,m:stable@vger.kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272888-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,huawei.com,redhat.com];
	DKIM_TRACE(0.00)[163.com:+];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 260A9730991

virtbt_probe() allocates vbt before setting up the virtqueues, but some
failure paths return without freeing it.

The probe path also registers the HCI device before the virtio transport
is opened. Since hci_register_dev() makes the HCI device visible and queues
power_on work, move it after virtio_device_ready() and virtbt_open_vdev()
so the transport is ready before the HCI core can use it.

On failures after DRIVER_OK, reset and close the virtio device before
deleting the virtqueues and freeing vbt. This also cancels pending rx work
before vbt is freed.

Fixes: afd2daa26c7a ("Bluetooth: Add support for virtio transport driver")
Fixes: dc65b4b0f90a ("Bluetooth: virtio_bt: fix device removal")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
Changes in v2:
 - Rework virtbt_probe() error paths into an unwind ladder.
 - Free vbt on probe failures.
 - Reset the virtio device and unregister the HCI device before freeing it
   when virtbt_open_vdev() fails.
 - Close the virtio device before unregistering the HCI device in remove().

   Thanks Dan for the suggestions. The blog is very helpful.

Changes in v3:
 - Remove virtio_reset_device() from the virtbt_open_vdev() failure path.

Changes in v4:
 - Move hci_register_dev() after virtio_device_ready() and virtbt_open_vdev().
 - Reset and close the virtio device on probe failures after DRIVER_OK. Thanks, Luiz!
---
 drivers/bluetooth/virtio_bt.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 140ab55c9fc5..e7e79ba3c1f7 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -311,12 +311,12 @@ static int virtbt_probe(struct virtio_device *vdev)
 
 	err = virtio_find_vqs(vdev, VIRTBT_NUM_VQS, vbt->vqs, vqs_info, NULL);
 	if (err)
-		return err;
+		goto err_free_vbt;
 
 	hdev = hci_alloc_dev();
 	if (!hdev) {
 		err = -ENOMEM;
-		goto failed;
+		goto err_del_vqs;
 	}
 
 	vbt->hdev = hdev;
@@ -383,23 +383,28 @@ static int virtbt_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_BT_F_AOSP_EXT))
 		hci_set_aosp_capable(hdev);
 
-	if (hci_register_dev(hdev) < 0) {
-		hci_free_dev(hdev);
-		err = -EBUSY;
-		goto failed;
-	}
-
 	virtio_device_ready(vdev);
 	err = virtbt_open_vdev(vbt);
 	if (err)
-		goto open_failed;
+		goto err_close_vdev;
+
+	err = hci_register_dev(hdev);
+	if (err < 0) {
+		err = -EBUSY;
+		goto err_close_vdev;
+	}
 
 	return 0;
 
-open_failed:
+err_close_vdev:
+	virtio_reset_device(vdev);
+	virtbt_close_vdev(vbt);
 	hci_free_dev(hdev);
-failed:
+err_del_vqs:
 	vdev->config->del_vqs(vdev);
+err_free_vbt:
+	vdev->priv = NULL;
+	kfree(vbt);
 	return err;
 }
 
-- 
2.25.1


