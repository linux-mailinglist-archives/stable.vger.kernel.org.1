Return-Path: <stable+bounces-88261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4F39B234E
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 03:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C14C7280DD5
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 02:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB34188CCA;
	Mon, 28 Oct 2024 02:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9HUjyHo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C8A188917;
	Mon, 28 Oct 2024 02:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730084073; cv=none; b=TEp9MCUa1u5OMflo3fdXPh3KZSGUaxOo0xQmfQepWrh5uygW3nm8NzhZpvC06J8NyS+KFBGCWnjgeDaQk52DPtFKSHGlv63kGMWidZ4xGHzQqqnFqW5Qh9dZSpxGdQ5eW8J5GpqMj2qVykm4X5b4DMj9n1Tqxc0NNs9rq6BVRSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730084073; c=relaxed/simple;
	bh=THNvtpDf6RD8r1gTD1glpT99xqlWAFtlu/f8pbzGBCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ga5tEWCYY2wUrQM6KD4hRHe7V5vjrBv6JgRh4n2cAskNzi2H8XOEOBGIUc0HZw5+nszF6Qw/t1+QvDAjFNj8fQTNNtpYyA5pkjKJP4J8yeX6nxnfHAnYH5HvclF9udDY7/AQdfeROA8nIZqjTsfY8uTjlmTW7SY0+DRc/vGvpLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9HUjyHo; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2e8c8915eso2947476a91.3;
        Sun, 27 Oct 2024 19:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730084071; x=1730688871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6241+IQ+gPSntMSqtbQTA4Zs9SgWvlCVF1HFnw4CGA=;
        b=M9HUjyHozmTnbicX+JbJhLUgb0ij9AepUfvDnoJgZhUnrx2Kjv21t2y18hDlrRq1Kt
         gfhCPRgb/I98O7Cx8joeZcZlQSLJnR9A1lzL+TOT2SYtq7lfgFVnZ3oi+tvtkRuXNSD0
         NumZVIc1oATs0SR2iuyvi+733PugYehX2TooWfMiPhiv6yvB76yqsfM0MDeu+Juw9scI
         QpMKQI9duwheXkG4Hoc+eveV3t3DYd7PfWWztNdAYYHv6xKQ9gZvzQEY8q/YP7MG/bsN
         R3h/iEE90EMZWMDFzVOBZRMTF+P/i47Zllg5N0rHtYjw3oti2yuDeXW7uItyHUrJr/k9
         F/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730084071; x=1730688871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6241+IQ+gPSntMSqtbQTA4Zs9SgWvlCVF1HFnw4CGA=;
        b=ECyq06/6/8m9bGn4YJzf7tbeD1nEsmgDYHfuxGgUit3A0Df6JZhvCySgpDtezwHuUt
         tfs+NuUxVVAy0G/vejU7u1w6c3ci9GvYa1iC+97CMJTDPv+PadaTcvId9accY1Tl5Cb3
         VHMbcfvl4RSiH00KUZ5sDJCXcpqjZwpwuK5ZhlH18nzKayjywxjbdLlaQUIbACYpNIpy
         dnR7SSqTz8QbCuvfKA1kTv9/KbWwpqosbglGEnFI11dQdTyt7eHWS5ivKK2MQvVby/o1
         jlex4SEISlaJnGXdw8t216KfFnoHz1Rb1SyvY8ml8icilD9NaQvuPIAnGBT910++b/N1
         zKzw==
X-Forwarded-Encrypted: i=1; AJvYcCVKE1sSdXUJCNTA8o8yzG0kDny1pzTIfqF3dkwvSfTCeJVWzfrhrgV2yvsQuud1OrsjfCLIu8nFIWz8yUk=@vger.kernel.org, AJvYcCXhxEVeJ4N52tpz6EXOfxUBdd9IXvhZypYkBENcRi8lvRLoqNng85P89jAd2VkgbAlsok1z5WXe@vger.kernel.org
X-Gm-Message-State: AOJu0Yx55jFbxD1KkVDe97/a835GubDMre/PDmy7SzPcrV4WRY4E1ize
	qGCnqR3nD3s1rB/OWdlHFkriMn9AwvkBZJmbNpzH9xLBqR8+QJie
X-Google-Smtp-Source: AGHT+IFlS+vzvtRYT2KLuakjh78ZcCJaADricoLgfFaHy4yT4yA05Pag436gSCJ6nNfRedkTfASBZA==
X-Received: by 2002:a17:90a:1157:b0:2e0:b26c:906f with SMTP id 98e67ed59e1d1-2e8f11a879cmr8407834a91.27.1730084071030;
        Sun, 27 Oct 2024 19:54:31 -0700 (PDT)
Received: from kic-machine.localdomain (122-117-151-175.hinet-ip.hinet.net. [122.117.151.175])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e4ca3fcsm8062236a91.13.2024.10.27.19.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 19:54:30 -0700 (PDT)
From: Kuangyi Chiang <ki.chiang65@gmail.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ki.chiang65@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 2/5] xhci: Don't issue Reset Device command to Etron xHCI host
Date: Mon, 28 Oct 2024 10:53:34 +0800
Message-Id: <20241028025337.6372-3-ki.chiang65@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241028025337.6372-1-ki.chiang65@gmail.com>
References: <20241028025337.6372-1-ki.chiang65@gmail.com>
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

Add a new XHCI_ETRON_HOST quirk flag to invoke the workaround in
xhci_discover_or_reset_device().

Fixes: 2a8f82c4ceaf ("USB: xhci: Notify the xHC when a device is reset.")
Cc: <stable@vger.kernel.org>
Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
---
 drivers/usb/host/xhci-pci.c |  1 +
 drivers/usb/host/xhci.c     | 19 +++++++++++++++++++
 drivers/usb/host/xhci.h     |  1 +
 3 files changed, 21 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 33a6d99afc10..ddc9a82cceec 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -397,6 +397,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
 	    (pdev->device == PCI_DEVICE_ID_EJ168 ||
 	     pdev->device == PCI_DEVICE_ID_EJ188)) {
+		xhci->quirks |= XHCI_ETRON_HOST;
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 	}
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 899c0effb5d3..ef7ead6393d4 100644
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
 
+	if (xhci->quirks & XHCI_ETRON_HOST) {
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
index f0fb696d5619..4f5b732e8944 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1624,6 +1624,7 @@ struct xhci_hcd {
 #define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
 #define XHCI_WRITE_64_HI_LO	BIT_ULL(47)
 #define XHCI_CDNS_SCTX_QUIRK	BIT_ULL(48)
+#define XHCI_ETRON_HOST	BIT_ULL(49)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
-- 
2.25.1


