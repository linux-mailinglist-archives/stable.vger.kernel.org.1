Return-Path: <stable+bounces-75785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 064B99749A5
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 07:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF6C1C21A6A
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 05:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D45853E15;
	Wed, 11 Sep 2024 05:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jF7vVryV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9D26A33B;
	Wed, 11 Sep 2024 05:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726031904; cv=none; b=WkeFlLkJsmeRiLzPonsndFA/uTPi0ZWAA9CUUdq/IfZobtfId8SC+kEc6Ey5UQNw7w3T9vaCmWyFSEs8j7EBrhgCMHua1b7AYVRPtjRK5cFyY0lgRhdByE7sdHXZf7X71S4M/80KjovNVHvpGl+4CeCJuzWQSsYPKT34hokK140=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726031904; c=relaxed/simple;
	bh=KfIlK/+l3YnhJ98a5ywAp03Aaq0K9BAiH8QDXhowRoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pNMVaCR9umUdisA891lnG6nJsgbttF2ETj4YyxiWU6WaTMxrZSFWGJECzmE55+pHmIMjFm5/9Exks3TsSLuvrgws5kvDNeqrXziN2ABscti16spkzYS5WnSf0W5VV6+UBcGoDghgfTl7hr/5F8NVqUFgTAFmCPKC+v1xvFPLTg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jF7vVryV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2059112f0a7so58148545ad.3;
        Tue, 10 Sep 2024 22:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726031902; x=1726636702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWIDMbqJsRxxIml4+HWO93IWTZE2hwnYycJj4UDpW+E=;
        b=jF7vVryVWSf26ajdOPsDx74W5ji3JHpz+L+GEvDoI2GaD5GdtjiRjnw11z5/J6dk7V
         xMy/Pr0XhoW+sBiYnnNzpUIZcMJOuKBuRNkuKupbB5L+rLKWQ5U4xcLUo3U/mKXvCD0p
         7JLTyBMXK/8FtTBsVdLCPzEVKyt8c8BdCeyAf/bSxGoAWyfrPhRsqsJ4bJ303bwHjhAc
         BcHm/QhnsDteNpJHeOMry4Wb8RA0diWf9ObSvzDT4o1oL4LQrNB66iS2ECPtp5UVi62l
         4wsqIQnOWxIBBPVaeDrLyEniUO66d0FMjK8cmgzO3cXLWn8zdiBVGqcuwSw0Ln6KBBiE
         Kr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726031902; x=1726636702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWIDMbqJsRxxIml4+HWO93IWTZE2hwnYycJj4UDpW+E=;
        b=DOgLPIJLwa989WgJ+SURL/jV3gyL3QA4e4wdERiBM9XNB7Wg2XIMuM81xfF7MRGn/6
         DDaBXMl2y/7kxT76KNCsEPflHIgnTe3Mq6DXGdevFYsA9pNndns0/BmdwnXV1Vr67LR+
         42JKGrKv2ubajtyHMl6eDdjSbx+xTXmRRcyZu4PGq9+Su8Q37IBPAi/xqSxEcycrghAw
         nnxxSIivbc2cyPKqCbKN8rDXGPYjFiW6ohPXJRXpkfBwWjiIvPb69MF/RET1DrGoNqu6
         7v3jAPgS24KtfOnI4PkD6MdH3nD25g+cpSvD43Bp1MFdZuhgNb2mzBLZVCAeqRy7Jc2B
         ihZg==
X-Forwarded-Encrypted: i=1; AJvYcCVcb0xXAkxcW6Fhztx5pTEm3xb7jPrx0eVyF2kT6Asqcscsn2DDsb4M0aGL5G0Q6s5dnDKke+fT@vger.kernel.org, AJvYcCXINhgXZ08D5bd7FwkMtxG0II3EJueVS0K9lzHmryCnwhljyoG3Vx5LkN7tmsC/eU+MvjzF9NEZA4BccYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyruoce+aNYCvCJkApn4OsMMeRwtwTlzpppHgdy7exur00KtXjI
	3RedIHFw5XfmkLU6wQHAw0yS71nJFgXZlOCgb7kzErSnvzGEUdFS
X-Google-Smtp-Source: AGHT+IGp9udTy8LVWEL7pJkY8X8ptRgiBtwX/0i2COXqT3aJcTWJZrG8LjQUUgq3e8lv7w0mBNSEjA==
X-Received: by 2002:a17:903:2ca:b0:206:aa47:adc2 with SMTP id d9443c01a7336-2074c4cb9d1mr37395025ad.14.1726031901838;
        Tue, 10 Sep 2024 22:18:21 -0700 (PDT)
Received: from kic-machine.localdomain (122-117-151-175.hinet-ip.hinet.net. [122.117.151.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e10eb4sm56252735ad.7.2024.09.10.22.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 22:18:21 -0700 (PDT)
From: Kuangyi Chiang <ki.chiang65@gmail.com>
To: gregkh@linuxfoundation.org,
	mathias.nyman@intel.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ki.chiang65@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 2/3] xhci: Fix control transfer error on Etron xHCI host
Date: Wed, 11 Sep 2024 13:17:14 +0800
Message-Id: <20240911051716.6572-2-ki.chiang65@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240911051716.6572-1-ki.chiang65@gmail.com>
References: <20240911051716.6572-1-ki.chiang65@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Performing a stability stress test on a USB3.0 2.5G ethernet adapter
results in errors like this:

[   91.441469] r8152 2-3:1.0 eth3: get_registers -71
[   91.458659] r8152 2-3:1.0 eth3: get_registers -71
[   91.475911] r8152 2-3:1.0 eth3: get_registers -71
[   91.493203] r8152 2-3:1.0 eth3: get_registers -71
[   91.510421] r8152 2-3:1.0 eth3: get_registers -71

The r8152 driver will periodically issue lots of control-IN requests
to access the status of ethernet adapter hardware registers during
the test.

This happens when the xHCI driver enqueue a control TD (which cross
over the Link TRB between two ring segments, as shown) in the endpoint
zero's transfer ring. Seems the Etron xHCI host can not perform this
TD correctly, causing the USB transfer error occurred, maybe the upper
driver retry that control-IN request can solve problem, but not all
drivers do this.

|     |
-------
| TRB | Setup Stage
-------
| TRB | Link
-------
-------
| TRB | Data Stage
-------
| TRB | Status Stage
-------
|     |

To work around this, the xHCI driver should enqueue a No Op TRB if
next available TRB is the Link TRB in the ring segment, this can
prevent the Setup and Data Stage TRB to be breaked by the Link TRB.

Add a new quirk flag XHCI_NO_BREAK_CTRL_TD to invoke the workaround
in xhci_queue_ctrl_tx().

Both EJ168 and EJ188 have the same problem, applying this patch then
the problem is gone.

Fixes: d0e96f5a71a0 ("USB: xhci: Control transfer support.")
Cc: <stable@vger.kernel.org>
Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
---
 drivers/usb/host/xhci-pci.c  |  2 ++
 drivers/usb/host/xhci-ring.c | 13 +++++++++++++
 drivers/usb/host/xhci.h      |  1 +
 3 files changed, 16 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 2fa7f32c2bf9..dda873f3fee7 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -398,12 +398,14 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 		xhci->quirks |= XHCI_NO_RESET_DEVICE;
+		xhci->quirks |= XHCI_NO_BREAK_CTRL_TD;
 	}
 	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
 			pdev->device == PCI_DEVICE_ID_EJ188) {
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 		xhci->quirks |= XHCI_NO_RESET_DEVICE;
+		xhci->quirks |= XHCI_NO_BREAK_CTRL_TD;
 	}
 
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 4ea2c3e072a9..1c387d4dc152 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3727,6 +3727,19 @@ int xhci_queue_ctrl_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 	if (!urb->setup_packet)
 		return -EINVAL;
 
+	if (xhci->quirks & XHCI_NO_BREAK_CTRL_TD) {
+		/*
+		 * If next available TRB is the Link TRB in the ring segment then
+		 * enqueue a No Op TRB, this can prevent the Setup and Data Stage
+		 * TRB to be breaked by the Link TRB.
+		 */
+		if (trb_is_link(ep_ring->enqueue + 1)) {
+			field = TRB_TYPE(TRB_TR_NOOP) | ep_ring->cycle_state;
+			queue_trb(xhci, ep_ring, false, 0, 0,
+					TRB_INTR_TARGET(0), field);
+		}
+	}
+
 	/* 1 TRB for setup, 1 for status */
 	num_trbs = 2;
 	/*
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 1272d725270a..aedbe8fee8be 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1629,6 +1629,7 @@ struct xhci_hcd {
 #define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
 #define XHCI_WRITE_64_HI_LO	BIT_ULL(47)
 #define XHCI_NO_RESET_DEVICE	BIT_ULL(48)
+#define XHCI_NO_BREAK_CTRL_TD	BIT_ULL(49)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
-- 
2.25.1


