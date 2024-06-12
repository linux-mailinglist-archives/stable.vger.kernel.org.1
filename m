Return-Path: <stable+bounces-50189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE8F9048F2
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 04:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2D61F247A5
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 02:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC899B651;
	Wed, 12 Jun 2024 02:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmsKNxu1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C3847C;
	Wed, 12 Jun 2024 02:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718159013; cv=none; b=YxN0m27YL32gXPcerppyg3RCoi4iHWtSlQPULTqjD3FokhWZGr7Kaq9lfx41o03nxffEcnPM+M1DEFLMerpduZrMoDInmlxLQu8znzBKKS01+RiSVNU3H9NBzcR2juV0o4MxfbXYBA4hObZWZhN9/8r5WSxHRlSqnxC97lB1lTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718159013; c=relaxed/simple;
	bh=553eqYP03BYXJPed84E6WmxmDEiKOgjTIuF2NPlDzdI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n6HjSZjPvzYzJXslZjVwdVB5EjqjvfEGq5sfEz8F4qmdODRtk5jNNd8uGayhYolTYtwSbSL5f7Saz7pdT/uzUYVOa2tH2J3spKfeHRS9QYtCj2r7rrcSYezhlo67UyJbPc0H3p/QrPuf4DegNnOnJJHkA2JadI5xyqSCVCjZ3tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmsKNxu1; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c2db1fc31fso655430a91.0;
        Tue, 11 Jun 2024 19:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718159011; x=1718763811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5gFOKkMDT7D7pRqOfPOEkuBjvwZEWIElC/m+QYJ00kU=;
        b=CmsKNxu1/Fbcelfj2kBARXJPX6MNHDbL+q6qrT3Ng5ty8OLnQBlhM4uzbCLXSM97w6
         UxOSgChF0jMNgb5Oqb+LQO3g5+I02B99AcAoBbTnQnSr2FJr5dLvMFTFTf0Vp6g1RmoI
         P8sQp7tUWEzg4MI/UZqqIMIU+t5q6mmOISBZmiAG+EHt9zoU8ehAk2lJOjjFqCc5G1tC
         4wFKP1fSXHuObpnJfucwChAGeM9dYWOFDVMKe1UFOajIpV8wG4Dqo+VfhlaYeXq+K7b9
         QChUsWjFSNB1L/TLek1tVQQ8Un04mHQAw26GptiKVF4ln0XEWq7uDIXoq2yq+bKhNMa+
         kFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718159011; x=1718763811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gFOKkMDT7D7pRqOfPOEkuBjvwZEWIElC/m+QYJ00kU=;
        b=BzRPpslJz/WPCyV6rgfVIfv7zwplI3c0sYp9AH5Tq3gFOyCKW7dlm+4H/cbCf7HRWh
         HYO71sdx5CiXPvms9XwCasZTDhpTyP2xDAmSJgTxtHycpgXcwh0A2DlhRT4pu/Z/jH6S
         Io6iU11JM3oV/ex4eVvi2gbBd1zFyDmuZDXvNX+ILQyOpFdK6jbgHZAyiLmF2Of23cZR
         dppOm03IAWuOgV6Br0vmOpZrUH5vl884Y26CQTvPSnGsru/Ohbo5wAu0qpeEoaMkEddg
         M74x43/QjKGetXiqb11Z7aormMpmqSEWmCz993KduPE8S0eMNkzRjJbxLoXfqfNRG0K5
         XWvw==
X-Forwarded-Encrypted: i=1; AJvYcCXXBbMkJ0AxoU/JfQ0dSnLUObKhU2QpNeXaPXC7/0nmTkEk+IjwpwbFPudJRBNXcauEh0TXNVGbzS1y7MpOJfnTeLIWjl+YaQbaZv2yv85YyRh5tR1fxu9oy2vG5Vb8uxrC16xR
X-Gm-Message-State: AOJu0YxFX+fgNQP8E1aU31H8yjiPzZoXvNj3JWwetbglQpvkPeRrHZjG
	rqvacfGa1dy8R9lD5ESgQ134YR2uHMyGI1cTugeIW51Oc/K+TiTT
X-Google-Smtp-Source: AGHT+IESk5o6BdqOI4+/gL5n5TOvot4UBXUgXEXOFZNwf8A6gZ8XocCd8ISrU+dCkYmNGrzZHycrXA==
X-Received: by 2002:a05:6a20:dd9e:b0:1b5:ae2c:c730 with SMTP id adf61e73a8af0-1b8a9c5107cmr620180637.3.1718159011301;
        Tue, 11 Jun 2024 19:23:31 -0700 (PDT)
Received: from localhost.localdomain (122-117-151-175.hinet-ip.hinet.net. [122.117.151.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f70e644446sm52250505ad.7.2024.06.11.19.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 19:23:30 -0700 (PDT)
From: Kuangyi Chiang <ki.chiang65@gmail.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ki.chiang65@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] xhci: Don't issue Reset Device command to Etron xHCI host
Date: Wed, 12 Jun 2024 10:22:56 +0800
Message-Id: <20240612022256.7365-1-ki.chiang65@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes hub driver does not recognize USB device that is connected
to external USB2.0 Hub when system resumes from S4.

This happens when xHCI driver issue Reset Device command to inform
Etron xHCI host that USB device has been reset.

Seems that Etron xHCI host can not perform this command correctly,
affecting that USB device.

Instead, to aviod this, xHCI driver should reassign device slot ID
by calling xhci_free_dev() and then xhci_alloc_dev(), the effect is
the same.

Add XHCI_ETRON_HOST quirk flag to invoke workaround in
xhci_discover_or_reset_device().

Cc: <stable@vger.kernel.org>
Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
---
 drivers/usb/host/xhci-pci.c |  2 ++
 drivers/usb/host/xhci.c     | 11 ++++++++++-
 drivers/usb/host/xhci.h     |  2 ++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 05881153883e..c7a88340a6f8 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -395,11 +395,13 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 			pdev->device == PCI_DEVICE_ID_EJ168) {
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
+		xhci->quirks |= XHCI_ETRON_HOST;
 	}
 	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
 			pdev->device == PCI_DEVICE_ID_EJ188) {
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
+		xhci->quirks |= XHCI_ETRON_HOST;
 	}
 
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 37eb37b0affa..aba4164b0873 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3752,6 +3752,15 @@ static int xhci_discover_or_reset_device(struct usb_hcd *hcd,
 						SLOT_STATE_DISABLED)
 		return 0;
 
+	if (xhci->quirks & XHCI_ETRON_HOST) {
+		xhci_free_dev(hcd, udev);
+		ret = xhci_alloc_dev(hcd, udev);
+		if (ret == 1)
+			return 0;
+		else
+			return -EINVAL;
+	}
+
 	trace_xhci_discover_or_reset_device(slot_ctx);
 
 	xhci_dbg(xhci, "Resetting device with slot ID %u\n", slot_id);
@@ -3862,7 +3871,7 @@ static int xhci_discover_or_reset_device(struct usb_hcd *hcd,
  * disconnected, and all traffic has been stopped and the endpoints have been
  * disabled.  Free any HC data structures associated with that device.
  */
-static void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev)
+void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev)
 {
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
 	struct xhci_virt_device *virt_dev;
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 30415158ed3c..f46b4dcb0613 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1627,6 +1627,7 @@ struct xhci_hcd {
 #define XHCI_RESET_TO_DEFAULT	BIT_ULL(44)
 #define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(45)
 #define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
+#define XHCI_ETRON_HOST	BIT_ULL(47)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
@@ -1863,6 +1864,7 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg);
 irqreturn_t xhci_irq(struct usb_hcd *hcd);
 irqreturn_t xhci_msi_irq(int irq, void *hcd);
 int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev);
+void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev);
 int xhci_alloc_tt_info(struct xhci_hcd *xhci,
 		struct xhci_virt_device *virt_dev,
 		struct usb_device *hdev,
-- 
2.25.1


