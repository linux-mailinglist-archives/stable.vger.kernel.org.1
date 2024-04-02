Return-Path: <stable+bounces-35594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB41C8951DF
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 13:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A421F22AB5
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 11:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E209634EA;
	Tue,  2 Apr 2024 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="FeN5p0g4"
X-Original-To: stable@vger.kernel.org
Received: from forward102c.mail.yandex.net (forward102c.mail.yandex.net [178.154.239.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D394CB4A;
	Tue,  2 Apr 2024 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712057540; cv=none; b=VI+zVkArYmRqEYnBinE4zVCeFf+m0LDAGP12gDBp7g7R33NoYJe7rJW7NbHNvXtbkWh2pZP+xihE2YUxq7FHOO3BXlFUzPIxty4zPBtfcsvMMRh2tSTWKiXMJF7g8gYjwYq+0i6v1db7afD5IYKva0UwBCLzaH4TZiqwR0h55zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712057540; c=relaxed/simple;
	bh=eYeSrltvF+cUWa2IqQCh1lj0SrTxH0+xfPp5ajygmAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JrscB8bpu6mvLRyGkVgpQn/VcgPD+IQw9edWopav4vnqBO5Oo9Bj5K3YM1s9xCyuAuLB51tqX1x6B64QjW6b0OyV0wFdcruMWyws/exNMxfJKVEfPWyMCzG1Ad32PLb8k6R2PIbl29E7SquJYQXf7JA272gj1+2g2DG1ronY9rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=FeN5p0g4; arc=none smtp.client-ip=178.154.239.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:30ac:0:640:8a30:0])
	by forward102c.mail.yandex.net (Yandex) with ESMTPS id 0527B60B67;
	Tue,  2 Apr 2024 14:32:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 6WQ91E8WlKo0-S3pysM6y;
	Tue, 02 Apr 2024 14:32:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1712057527; bh=afxENWSoVYIs+dj5wCAUXvNsz/HQtcJMCSYZyFyBTiM=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=FeN5p0g4RmZ9ynGCzPul+7Gtr2Y/BoyEgltU3ZzxLEwA2s3AcDrFM/cGalP94vXNg
	 aOCkXR4vvoGOsWavrJyE15mcZXRZu73DDxai5OXbZqlFQgroCzdUJME+BwKM5jDRnk
	 VNaEJB8918aoSp+d+mQ7U5CRI42dyJ6CeY36Gcv8=
Authentication-Results: mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+39ec16ff6cc18b1d066d@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: fix memory leak in hci_req_sync_complete()
Date: Tue,  2 Apr 2024 14:32:05 +0300
Message-ID: <20240402113205.7260-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'hci_req_sync_complete()', always free the previous sync
request state before assigning reference to a new one.

Reported-by: syzbot+39ec16ff6cc18b1d066d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=39ec16ff6cc18b1d066d
Cc: stable@vger.kernel.org
Fixes: f60cb30579d3 ("Bluetooth: Convert hci_req_sync family of function to new request API")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/bluetooth/hci_request.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 00e02138003e..efea25eb56ce 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -105,8 +105,10 @@ void hci_req_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
 	if (hdev->req_status == HCI_REQ_PEND) {
 		hdev->req_result = result;
 		hdev->req_status = HCI_REQ_DONE;
-		if (skb)
+		if (skb) {
+			kfree_skb(hdev->req_skb);
 			hdev->req_skb = skb_get(skb);
+		}
 		wake_up_interruptible(&hdev->req_wait_q);
 	}
 }
-- 
2.44.0


