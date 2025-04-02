Return-Path: <stable+bounces-127391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 217BBA789A0
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 10:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7C13AFB05
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 08:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6291120C485;
	Wed,  2 Apr 2025 08:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="B/SyFJmI"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7768920E6E7
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 08:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743581732; cv=none; b=HgaA0Rf/p2yHCSsCE2qYQxndWL487LxJScUtw7mECLrogir90ZuYdcyt3l/MdnQtLyDGzeiwlNcdVgjKt+OEEnUWoGdAw0344UBmVGIGTttIZw49G92pkO9QmhZbf1E0PKDxUFgODMzfw1Z+I6Yyf38unGcNnE0TOlLDLbJcbN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743581732; c=relaxed/simple;
	bh=/rB1na+6T/TaPYcMnI8p+LW63QLXjPSa+k7qGqNg7Z4=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Content-Type; b=hswaJ0c86IMEsEKmx5PkpU+dOoK9uJ8sESvB+6xZDSSPDs0RZqiyEfSTAjmTiVS9nv9xx4rJdvF7W8YUN+07AV9PK2woSyfDG8R1haCYxUzFHseQLfWmQRZc7qv7yfJQ+H2/RqgVmrgSf/09d0t8waLVGSgtREN6U2J3pR6QbZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=B/SyFJmI; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2c663a3daso1231313766b.2
        for <stable@vger.kernel.org>; Wed, 02 Apr 2025 01:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1743581727; x=1744186527; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AJLNrxtRNOksQSfsfM9qJ47fawsm4XN0V2U99e8rYAg=;
        b=B/SyFJmIXlbsBztA/40+FnSyz1kQbemc8QmMUxUCv0xh5MIg2TaLmMtpg7LKglXJ01
         Ze+3HcL+GWcFp9ZBuIHp+Cwy4a1QDo/qmxJ9bFGoO5Y/aH7AmfH717V7B6/J+ev63sV0
         /mXt8FpzvbYshksATEWvg7RuPOByz6poatTESZREE+0dMivy2HNdYWFf3tYnJL+5wXg2
         a1ZRcFUDnXAT3pVBF3GyIGCx6gGwoAlzP88L2FT/+fYnXNNZ2Je6HG5nhyUga7xALCnf
         hMPNPunuU2dE1pJyS/JvOr1pEt8+DepVZEBLPh1w4rIUqooOv4HyW7RP+1BUGUbPAfDD
         srrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743581727; x=1744186527;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AJLNrxtRNOksQSfsfM9qJ47fawsm4XN0V2U99e8rYAg=;
        b=lEH3tUc4Ub2JiB1TRwFl0FO0/FNnc/oOuPAQXeSzjdkrTeoD5lfZVMGiOAER/0oR95
         76EoFZJ8FsvSXsWs5cRUMyOFYD9wkZM3Ddq4apGXvKcLEdEchhEHHnAhmcbBUCALcMNu
         Pz6JUOuXDv2t6XawPeoCFMv2JPRun1TY8IEISvBM/AKKlqGX7ipT9mCKt4ibI35Gutal
         sa1qXCaOp/DUf7zVtNBpbyunb7+ROdVBG1jTDYB2KkOUd6QWckj7JZsuUWGqt8rXHkJM
         g4FEbALKN6tbPdXKzDlJvdAFAkoJL4c7+1tFUtqW01Qm7Fi6aQtCLhpBVvn90zT++ip3
         A7XQ==
X-Gm-Message-State: AOJu0YxNxGu3UWOg6s2wimxA/JJFG+14GeTQ2NEni6M3Q3og6zQ3H0+E
	1SC+VUuRHZ2AVXtVRDdAOCI+Ni8Eeev20IHNCh4U+8wbolJXjG5jVbTY1ypB9oEdtMEu3bJqlTr
	jn7ifdvD9c8HFy4Q8xaAJ2O+yKh2DqBuexu3e9owSam/Cb18YLg==
X-Gm-Gg: ASbGnctc/jdcmoUAWggP743YEL4YvivXzH9dcYCUl3k7kWcJB0mC2cKR/6pKnbChlM/
	x4i/CrwOqd6/gJeZ1oRLQMVnT/w2fJW7NyaGbHshaKVmYSX4Ik61UfzJHEjd0A3+bD6bFbupNRq
	KvTJanwJdn3IFzlwp6K8jSeIRTmOy78gXXOHM2
X-Google-Smtp-Source: AGHT+IGU+o6blREVhT0LLWc8ZCPaCAVDB+osEsUjo71jUlZik2HWGuo5c92043DX2/O7o9KJtZZHwWS0Pbqi59WUwE8=
X-Received: by 2002:a17:906:c14e:b0:ac7:3456:7ece with SMTP id
 a640c23a62f3a-ac738bae0c2mr1170269166b.46.1743581727119; Wed, 02 Apr 2025
 01:15:27 -0700 (PDT)
Received: from 239600423368 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Apr 2025 04:15:26 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: Sean Rhodes <sean@starlabs.systems>
Date: Wed, 2 Apr 2025 04:15:26 -0400
X-Gm-Features: AQ5f1Jr_qEv_6k6sWSHWcYsNs1Opz15s5snhZc-nApPIJP1Vyho31Qz2BO-deU4
Message-ID: <CABtds-0a9d5OMjOTO2Juf6zTvK5inq9BKnKUkWE1of-gnk7TDQ@mail.gmail.com>
Subject: [PATCH] Bluetooth: Revert vendor-specific ISO classification for
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From ccabbdd36dacc3e03ed819b4b050ebcc1978e311 Mon Sep 17 00:00:00 2001
From: Sean Rhodes <sean@starlabs.systems>
Date: Wed, 2 Apr 2025 09:05:17 +0100
Subject: [PATCH] Bluetooth: Revert vendor-specific ISO classification for
 non-offload cards

This reverts commit f25b7fd36cc3a850e006aed686f5bbecd200de1b.

The commit introduces vendor-specific classification of ISO data,
but breaks Bluetooth functionality on certain Intel cards that do
not support audio offload, such as the 9462. Affected devices are
unable to discover new Bluetooth peripherals, and previously paired
devices fail to reconnect.

This issue does not affect newer cards (e.g., AX201+) that support
audio offload. A conditional check using AOLD() could be used in
the future to reintroduce this behavior only on supported hardware.

Cc: Ying Hsu <yinghsu@chromium.org>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/bluetooth/btintel.c      |  7 ++-----
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_core.c         | 16 ----------------
 3 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 48e2f400957b..2114fe8d527e 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -3588,15 +3588,12 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		err = btintel_bootloader_setup(hdev, &ver);
 		btintel_register_devcoredump_support(hdev);
 		break;
-	case 0x18: /* GfP2 */
-	case 0x1c: /* GaP */
-		/* Re-classify packet type for controllers with LE audio */
-		hdev->classify_pkt_type = btintel_classify_pkt_type;
-		fallthrough;
 	case 0x17:
+	case 0x18:
 	case 0x19:
 	case 0x1b:
 	case 0x1d:
+	case 0x1c:
 	case 0x1e:
 	case 0x1f:
 		/* Display version information of TLV type */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5115da34f881..d1a4436e4cc3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -646,7 +646,6 @@ struct hci_dev {
 	int (*get_codec_config_data)(struct hci_dev *hdev, __u8 type,
 				     struct bt_codec *codec, __u8 *vnd_len,
 				     __u8 **vnd_data);
-	u8 (*classify_pkt_type)(struct hci_dev *hdev, struct sk_buff *skb);
 };

 #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5eb0600bbd03..5b7515703ad1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2868,31 +2868,15 @@ int hci_reset_dev(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL(hci_reset_dev);

-static u8 hci_dev_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	if (hdev->classify_pkt_type)
-		return hdev->classify_pkt_type(hdev, skb);
-
-	return hci_skb_pkt_type(skb);
-}
-
 /* Receive frame from HCI drivers */
 int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	u8 dev_pkt_type;
-
 	if (!hdev || (!test_bit(HCI_UP, &hdev->flags)
 		      && !test_bit(HCI_INIT, &hdev->flags))) {
 		kfree_skb(skb);
 		return -ENXIO;
 	}

-	/* Check if the driver agree with packet type classification */
-	dev_pkt_type = hci_dev_classify_pkt_type(hdev, skb);
-	if (hci_skb_pkt_type(skb) != dev_pkt_type) {
-		hci_skb_pkt_type(skb) = dev_pkt_type;
-	}
-
 	switch (hci_skb_pkt_type(skb)) {
 	case HCI_EVENT_PKT:
 		break;
-- 
2.45.2

