Return-Path: <stable+bounces-56034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF62F91B61C
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 07:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6101E1F23F4D
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 05:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC23837165;
	Fri, 28 Jun 2024 05:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwdpu6n8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5032D36B11;
	Fri, 28 Jun 2024 05:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719552574; cv=none; b=GfNfIFZ1695A9uF+TMrmhouHXlqR6uuMwom3+W/8hxynRA3vO1Jc/+lgA+BHQbMwFRSPKYt+R5oUG9BDa7rVAxqLfJ6kPdGfdCg+zh6maKmu+QXRA9MPskxnj5jmMGwxJjNbSDIFAf/wX6fd6B3X2UuuFd/5jLN7cqvA6tnKkM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719552574; c=relaxed/simple;
	bh=ks1F6Sn9pTxTI0BwOCBA0EESvxRrUUHI3vfdcNjpIUw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TOrjZwJQELbdlNiDAKFj05T1a2Stdqe6Ij0Fptc3zFQD8ZESsUUpFAJmBMP18F0QA3/hHnhpp5Io0SYqt8KlV1IzM8gG+4CzFVvGmJsMVDa3wwC2i8C/5UWL44d9C6ktoSF5A6+YalAvUJWgLUvvnUbVat+KgxH3Pri7uunf++U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwdpu6n8; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c7af3116aaso56096a91.2;
        Thu, 27 Jun 2024 22:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719552572; x=1720157372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PJ/M56ThtwrsFD5Lfw9SbGejoYETZHoSJEMo2+pp2ms=;
        b=kwdpu6n8pNn9eyb+lBJKj44mYs5+fAc4M3IRux4ckG5ZGhHbCLMln9GxjW/V9Mdt6H
         EYTtcjXGwCp2DXcQTftMIM20Nl8+zjOJEuSYePhPNBK8GU3TYQU+4qzQt5vrvoiCxvEk
         qcbeageydIWL2hpkGPlHQuXZMondcrNUTJMsiJoUGL28wpgvUfYKNCLk8CaGG751yLnV
         Z8dv+pjvSJ8kiAfQWfQoops2dtTXBqLmjd9z5RArzTLNKw9g6ntvMaGeA0cPaQwudACj
         ln+/xqr42P/amow7KThd6eWB2XVAh4ta95l5lqTZM5w/3LMVLUzJBYM1YdFFNd9eV2hw
         4qHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719552572; x=1720157372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PJ/M56ThtwrsFD5Lfw9SbGejoYETZHoSJEMo2+pp2ms=;
        b=CGc3q46fNmzYXzX0ujBC3obDay9B5H3WltfmT9GW0Gc9RUI8ENZ41IJbkWKL3ppkUg
         JiehWops1buy+JKWsH9Rmg2Fl8P8+VFxp01/Hq90Ab0nXu38qDyb5M/sLmlUkEae/6c/
         7qJSGdfcnqPdQ9a0zYWNHIIqQNryJNdZst4Cn32M2GIu4Dd1EY8/FRNvI6DjRnnDKQJt
         ba6hgBjINDY+wJYByYBb3mA2X/l10SkUD/dyW7GmmMq2kpN59GozmXMd2fyv7fDDH2NE
         b9WDU5LkQ7sQadIi7/428npytwlhs/Qr/yZzcSlCg6N0hB3x7hjh+VvARazVnkW91xTL
         Spwg==
X-Forwarded-Encrypted: i=1; AJvYcCVzfFUJ9G7XD3djr+ZiEARnbN+1dSQ1w/vRRIqZyph5Yx+2qj2B/sRKRw/QZLGI+E/lNTLWl1jDfn+tHjBqvFMOmtZJXkI5BJB8haiCkRWksQnGlYoCHu6J318M5uTg2edBsHZj
X-Gm-Message-State: AOJu0YwyCEntHdUVHFx4e8MaBQuRBPxWhzRmGdiZmbnbm+L4FjLYck86
	fL01xDw6o++cdmdRUrDrBAQDWhD4Qyvijr7968kqx+SHrb+SnRx3KP23bS15
X-Google-Smtp-Source: AGHT+IHLv5sQ9sNkcIC/nJeiyanw64nDmI2PGR16Y8htj0wpAT+P7CbV8FfgwKGWVS9OAZ3ykXJVGA==
X-Received: by 2002:a17:90a:db94:b0:2c2:d11b:14dd with SMTP id 98e67ed59e1d1-2c8452e0fdbmr15923350a91.0.1719552572391;
        Thu, 27 Jun 2024 22:29:32 -0700 (PDT)
Received: from localhost.localdomain (122-117-151-175.hinet-ip.hinet.net. [122.117.151.175])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91c7ddb23sm735599a91.0.2024.06.27.22.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 22:29:31 -0700 (PDT)
From: Kuangyi Chiang <ki.chiang65@gmail.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ki.chiang65@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3] xhci: Don't issue Reset Device command to Etron xHCI host
Date: Fri, 28 Jun 2024 13:29:14 +0800
Message-Id: <20240628052914.5215-1-ki.chiang65@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes the hub driver does not recognize the USB device connected
to the external USB2.0 hub when the system resumes from S4.

After the SetPortFeature(PORT_RESET) request is completed, the hub
driver calls the HCD reset_device callback, which will issue a Reset
Device command and free all structures associated with endpoints
that were disabled.

This happens when the xHCI driver issue a Reset Device command to
inform the Etron xHCI host that the USB device associated with a
device slot has been reset. Seems that the Etron xHCI host can not
perform this command correctly, affecting the USB device.

To work around this, the xHCI driver should obtain a new device slot
with reference to commit 651aaf36a7d7 ("usb: xhci: Handle USB transaction
error on address command"), which is another way to inform the Etron
xHCI host that the USB device has been reset.

Both EJ168 and EJ188 have the same problem, applying this patch then
the problem is gone.

Cc: <stable@vger.kernel.org>
Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
---
Changes in v3:
- Modify commit message
- Modify comment
- Fix coding style, add a #define PCI_VENDOR_ID_ETRON
- Code refactor, call xhci_disable_slot() + xhci_free_virt_device() helper

Changes in v2:
- Change commit log
- Add a comment for the workaround
- Revert "global xhci_free_dev()"
- Remove XHCI_ETRON_HOST quirk bit

 drivers/usb/host/xhci.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 37eb37b0affa..abaef0adacf1 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3682,6 +3682,10 @@ void xhci_free_device_endpoint_resources(struct xhci_hcd *xhci,
 				xhci->num_active_eps);
 }
 
+#define PCI_VENDOR_ID_ETRON		0x1b6f
+
+static void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev);
+
 /*
  * This submits a Reset Device Command, which will set the device state to 0,
  * set the device address to 0, and disable all the endpoints except the default
@@ -3711,6 +3715,7 @@ static int xhci_discover_or_reset_device(struct usb_hcd *hcd,
 	struct xhci_command *reset_device_cmd;
 	struct xhci_slot_ctx *slot_ctx;
 	int old_active_eps = 0;
+	struct device *dev = hcd->self.controller;
 
 	ret = xhci_check_args(hcd, udev, NULL, 0, false, __func__);
 	if (ret <= 0)
@@ -3752,6 +3757,23 @@ static int xhci_discover_or_reset_device(struct usb_hcd *hcd,
 						SLOT_STATE_DISABLED)
 		return 0;
 
+	if (dev_is_pci(dev) && to_pci_dev(dev)->vendor == PCI_VENDOR_ID_ETRON) {
+		/*
+		 * Obtaining a new device slot to inform the xHCI host that
+		 * the USB device has been reset.
+		 */
+		ret = xhci_disable_slot(xhci, udev->slot_id);
+		xhci_free_virt_device(xhci, udev->slot_id);
+		if (!ret) {
+			ret = xhci_alloc_dev(hcd, udev);
+			if (ret == 1)
+				ret = 0;
+			else
+				ret = -EINVAL;
+		}
+		return ret;
+	}
+
 	trace_xhci_discover_or_reset_device(slot_ctx);
 
 	xhci_dbg(xhci, "Resetting device with slot ID %u\n", slot_id);
-- 
2.25.1


