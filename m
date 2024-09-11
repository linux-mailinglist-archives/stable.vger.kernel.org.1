Return-Path: <stable+bounces-75786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6869749A9
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 07:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6639C1F26B32
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 05:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B1054277;
	Wed, 11 Sep 2024 05:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEWAvKkv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDCE762D0;
	Wed, 11 Sep 2024 05:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726031913; cv=none; b=TwnIHBVuKUXA+3hhFKbwBYMnrzYRh1iJr0cn6jhxnjrmmencIauIatboYSkjpBYPO4EWbUAPdgPuzBHLVmzUKVXsDKm3gl2cAMh71HWtJL4JPkn3UN2EWL4bN6/ucfrEpzcqq+ksCYPYZ/aCBsuE5wblHcjaiuoohPVwoWLvgmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726031913; c=relaxed/simple;
	bh=RqBrtZ6RcId/Wwa03NFKxlcuYZrrOtLPWX9Kfq5utiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=goUT4x6PG2FjRuvrxitH1ma/71+AkH+kUi4bR9Uz7KrVwY/dw7SMMFwI3eS0jVXoJLowUAKxSyB5Zq0fb2WcGYxGC40E2x4qWgxj4TDS+s1Gn06kWczAGoyrrB6LOTDfhg9QtG8X7aMZTczjxtshCg9Kb3QJj8uu89fHZDRpeh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEWAvKkv; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2068acc8b98so58945735ad.3;
        Tue, 10 Sep 2024 22:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726031912; x=1726636712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JccXbw3hH4c/KqwFumvLxKlVMr8FDRUDpE1kHgDGAvw=;
        b=gEWAvKkvk7l0y3s0C3CqelD74M1Y3lPZm7pwu3J79K6cJ3+8a8mdnpPx7MCvCWDVZg
         HR58PlE7YadbETYkdopfyOJtB05EDKOG1vW3ZSVOWQkOj/3BiOyTIFhmvKpjUto9XAUy
         g0qfyfwwt6ho/oRuiHFFUgvj3VttzZkHunYOF/6lHaS9RFew0wVB9XlUY7K30ZKt3Pp8
         794eVBXVR/Ys4PVv0hhkkXsWqPnwx0uWk4ubAqekswSMp4KKMDDVJivyUzFxGd/9TqbW
         kcInJ+caoQjVUw8bZK0bJbSSoB+ovNNOn4b/m3jV79fzExNiNNRNyHj0DxVy4NmO6XX/
         p2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726031912; x=1726636712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JccXbw3hH4c/KqwFumvLxKlVMr8FDRUDpE1kHgDGAvw=;
        b=OuE2ZdnEp+p4ewY21ipnt4nRUqnDix6oWcaNa3xAbp24qZADVEPjga+ZnmlmLCmgPT
         WUO4xV2iNegiBQ8tfGfVQoz8Gwfewt3iXjCx/vOBJEkGDiuCEaUyFxAfUou/Xk/jv3T7
         HMxNqQtzgBgC2vo0Hw5UWTj55JltK5lGAac5DfsCBeqzZRAVy7bIMjPQB604x8vsKc7d
         +cypuQ1VxNVjxb/o9ZzOqijaOtUBCUjC/KXe7v9H4VsY3kePo6HyTNdUJY8co08u1IjR
         /+08IAF60ZYrvpAQRLbR06pu4qLO+0neHdBcFsZE/fhMO0CxOELLmxsXgSOTO3IXtqPT
         SAWA==
X-Forwarded-Encrypted: i=1; AJvYcCVtPcFnulw8X9PRUPGwoCRa4fzOdt1Wwss473RmXB7tH9qKd9xx4l8HhKshCfMenazVMZ7VWwVpGai4PGA=@vger.kernel.org, AJvYcCVv03CKLkamn6P8ehI+izhfd6qa4NTXgMtD2rzKdtSdkYjWTd1YlbCqRgMagMaDUS4MBtdvwmpN@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbyw6oIjmyw16NTty+Qtzmla6jBBfeYYVQvM/ph6c9/jTW3B+3
	2dDgvLLZF9ljPJIDoZBGpzBbMjL+KwD6cWyorfY/sAJml4QUNsHU
X-Google-Smtp-Source: AGHT+IErzhhAleCqnI06WgjhDxXvL3+aItEi1FKD9pXg99eqcy1Z4myO2SKjAur1AtKIAwIVZe0RtA==
X-Received: by 2002:a17:903:238e:b0:206:8acc:8871 with SMTP id d9443c01a7336-2074c60f452mr37745755ad.31.1726031911552;
        Tue, 10 Sep 2024 22:18:31 -0700 (PDT)
Received: from kic-machine.localdomain (122-117-151-175.hinet-ip.hinet.net. [122.117.151.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e10eb4sm56252735ad.7.2024.09.10.22.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 22:18:30 -0700 (PDT)
From: Kuangyi Chiang <ki.chiang65@gmail.com>
To: gregkh@linuxfoundation.org,
	mathias.nyman@intel.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ki.chiang65@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 1/3] xhci: Don't issue Reset Device command to Etron xHCI host
Date: Wed, 11 Sep 2024 13:17:15 +0800
Message-Id: <20240911051716.6572-3-ki.chiang65@gmail.com>
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

Add a new quirk flag XHCI_NO_RESET_DEVICE to invoke the workaround
in xhci_discover_or_reset_device().

Both EJ168 and EJ188 have the same problem, applying this patch then
the problem is gone.

Fixes: 2a8f82c4ceaf ("USB: xhci: Notify the xHC when a device is reset.")
Cc: <stable@vger.kernel.org>
Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
---
 drivers/usb/host/xhci-pci.c |  2 ++
 drivers/usb/host/xhci.c     | 19 +++++++++++++++++++
 drivers/usb/host/xhci.h     |  1 +
 3 files changed, 22 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index dc1e345ab67e..2fa7f32c2bf9 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -397,11 +397,13 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 			pdev->device == PCI_DEVICE_ID_EJ168) {
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
+		xhci->quirks |= XHCI_NO_RESET_DEVICE;
 	}
 	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
 			pdev->device == PCI_DEVICE_ID_EJ188) {
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
+		xhci->quirks |= XHCI_NO_RESET_DEVICE;
 	}
 
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index efdf4c228b8c..d890a97e0682 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3692,6 +3692,8 @@ void xhci_free_device_endpoint_resources(struct xhci_hcd *xhci,
 				xhci->num_active_eps);
 }
 
+static void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev);
+
 /*
  * This submits a Reset Device Command, which will set the device state to 0,
  * set the device address to 0, and disable all the endpoints except the default
@@ -3762,6 +3764,23 @@ static int xhci_discover_or_reset_device(struct usb_hcd *hcd,
 						SLOT_STATE_DISABLED)
 		return 0;
 
+	if (xhci->quirks & XHCI_NO_RESET_DEVICE) {
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
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index ebd0afd59a60..1272d725270a 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1628,6 +1628,7 @@ struct xhci_hcd {
 #define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(45)
 #define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
 #define XHCI_WRITE_64_HI_LO	BIT_ULL(47)
+#define XHCI_NO_RESET_DEVICE	BIT_ULL(48)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
-- 
2.25.1


