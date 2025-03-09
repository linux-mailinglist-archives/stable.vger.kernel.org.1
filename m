Return-Path: <stable+bounces-121635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529EBA5890D
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 00:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8564A3ABA6F
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 23:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A6E2144AE;
	Sun,  9 Mar 2025 23:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDipUIJg"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2CA182D0
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 23:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741561349; cv=none; b=rdkGl720ksjejc6FVAWmB4kn0vNpwz8ysvCwN7OawK7d+VVZZ4xkgHvb1su35vfSwWPNhFHmAkaLjtQCh2sw1++wUgbq7ZsVQx+9CGNaLYRdKW370E2a8/22aL5WZG5P0bIY35sfL/WLbafvi4lMvdC0Pjhw7IO0lo0x+YFFkf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741561349; c=relaxed/simple;
	bh=BdNEga+4oSMAZ4FCw1Yv62nZmbK2xtqsUQSUKFSpLbc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owVcnWIN5FeS9rkWLIKN/y1B9Qrx/36sx1wKQ5jYaPum5MPuIrK8jBR3gGq/4Hv2NEsPwNfiWznB8VV4ZasX+2qnC35OVicWz4IMJSOl+Rtco9nCOw3qsWmjgs3ijgoLucARg3OoTNOJkwZeYtf9g5w3SfFf2yX10jHrCSq8Tlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDipUIJg; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5dce099f4so4482648a12.1
        for <stable@vger.kernel.org>; Sun, 09 Mar 2025 16:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741561346; x=1742166146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2wChi6jE/rXxQ+om9NGLmPPyb/wa2izstEZzMc1IH4=;
        b=CDipUIJgrUilvGqI3IDf7nDOGd8DOYsqlv1vApgamsKdYE/zCo64OyoNY4FN/fjJgl
         kbW61avw5htOfIuKoxEFItjWIAnyWrfcUdyFt2WBNDETcICscNzPuNLmAWiNCn7vrpVk
         NNz9OjPLSm56Mc8foBC/BIxkPgkxwV5izTRWTcPQ9rQIObn450Guy0C5BDj2VNSUvj65
         ulCXI04zxeqLDczSX2j8kgWV5EpyyqvyP825OMIfFqsHMWFT3IO9mHzV9J8y33f4WVtu
         u+lfb+fd/Wlm6ZOQ69N2crKEMy8ZijNk9CIHC1XTIKKDE2RQyfeZZ11LPmwYvsZkdQuf
         rjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741561346; x=1742166146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2wChi6jE/rXxQ+om9NGLmPPyb/wa2izstEZzMc1IH4=;
        b=RG8f1k3GaqqWmj/qv8H5v9MrVfcWZ39qqfdaFRaxtqSoZlk3e5ovfEaVFo53KnVcWu
         H/97zuouWXvNhByEuIowT78f+FyzRSBxqyhY8BYDG49kPunSyKelP+lw6VspJwj6yK5i
         d2tI6k8bhuLKC0MLH2FFTSOCxVKyLZs/co0eRs1ZD0AoFGSc8ZyvpUV43REDw8svrp/K
         MHaiDs+bGZJo57J9zKFa2lJaKTeMltMEpLGEwFybbuCibA4wnda1GVAibqixU3LCCsNU
         PA7bralw/bhnkDFcconu1CNswwzD9SrXenNfQ5/f5Lvf0ku8MUOSMiCW3smHwKlQb6zu
         Jcpg==
X-Gm-Message-State: AOJu0YzovIfa7hXI9OHwZc2QaKKH8kXjuV/RcU+OOhs7jGKsVrkUZs3d
	ixT44V9OiqKirfl0h/Jp5Vdyj7vx/w5fj4LWh9F7WVSdVTemzWt+
X-Gm-Gg: ASbGnctDbuUr8WPZpPQDt8bPADmnXjm5KhEbgWIIYdY8+BvPDKmRkQXGkQK1j28zHEv
	srpKBYIv+jeJmZYgd7xmy9TpJ+fV7xnH74s+Rd3AQfs8vWyJANG3p2Ue8evXvzONFVB0pE4gmpR
	Ivbq/po4VafAwpTSUVSeRfPqtKjVbWPNe+jZpm2OmEcrZ7749LkPMOPHopqQ2gVAD6W03JR8MlT
	/sxd3HWbOpkLXlTPwgpegGDSjBZfLNlE1Xuik1tLJYM5JBAzRnqJQWAbvC9u48jidncuD6EcpqJ
	mTb7HhKISeIcnsBY/Z/ZrvkHuL4HigYA673DJEqyYixME7/4nKX8j7gjGt58FQ==
X-Google-Smtp-Source: AGHT+IFrodM5IDbFAOX/SPYXtbsTYV/ocD72s31M/47mqApu9ITtqel53sktIoo5IG0zYr9aywPLxA==
X-Received: by 2002:a05:6402:2115:b0:5e6:616f:42e4 with SMTP id 4fb4d7f45d1cf-5e6617e8eb9mr4811422a12.27.1741561346043;
        Sun, 09 Mar 2025 16:02:26 -0700 (PDT)
Received: from foxbook (adts246.neoplus.adsl.tpnet.pl. [79.185.230.246])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c74a8f3bsm6020036a12.44.2025.03.09.16.02.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 09 Mar 2025 16:02:25 -0700 (PDT)
Date: Mon, 10 Mar 2025 00:02:21 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: <stable@vger.kernel.org>
Cc: <gregkh@linuxfoundation.org>, mathias.nyman@linux.intel.com
Subject: [PATCH 5.10.y] usb: xhci: Enable the TRB overfetch quirk on VIA
 VL805
Message-ID: <20250310000221.1a7d4993@foxbook>
In-Reply-To: <2025030901-banshee-unwomanly-f19e@gregkh>
References: <2025030901-banshee-unwomanly-f19e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Raspberry Pi is a major user of those chips and they discovered a bug -
when the end of a transfer ring segment is reached, up to four TRBs can
be prefetched from the next page even if the segment ends with link TRB
and on page boundary (the chip claims to support standard 4KB pages).

It also appears that if the prefetched TRBs belong to a different ring
whose doorbell is later rung, they may be used without refreshing from
system RAM and the endpoint will stay idle if their cycle bit is stale.

Other users complain about IOMMU faults on x86 systems, unsurprisingly.

Deal with it by using existing quirk which allocates a dummy page after
each transfer ring segment. This was seen to resolve both problems. RPi
came up with a more efficient solution, shortening each segment by four
TRBs, but it complicated the driver and they ditched it for this quirk.

Also rename the quirk and add VL805 device ID macro.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Link: https://github.com/raspberrypi/linux/issues/4685
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=215906
CC: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20250225095927.2512358-2-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit c133ec0e5717868c9967fa3df92a55e537b1aead)
[ Michal: merge conflict with white space and an unrelated quirk ]
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-mem.c | 3 ++-
 drivers/usb/host/xhci-pci.c | 9 ++++++---
 drivers/usb/host/xhci.h     | 2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 006e1b15fbda..cdf9806c87a4 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2492,7 +2492,8 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 	 * and our use of dma addresses in the trb_address_map radix tree needs
 	 * TRB_SEGMENT_SIZE alignment, so we pick the greater alignment need.
 	 */
-	if (xhci->quirks & XHCI_ZHAOXIN_TRB_FETCH)
+	if (xhci->quirks & XHCI_TRB_OVERFETCH)
+		/* Buggy HC prefetches beyond segment bounds - allocate dummy space at the end */
 		xhci->segment_pool = dma_pool_create("xHCI ring segments", dev,
 				TRB_SEGMENT_SIZE * 2, TRB_SEGMENT_SIZE * 2, xhci->page_size * 2);
 	else
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 030e2383f025..6dc0c22268ca 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -37,6 +37,8 @@
 #define PCI_DEVICE_ID_EJ168		0x7023
 #define PCI_DEVICE_ID_EJ188		0x7052
 
+#define PCI_DEVICE_ID_VIA_VL805			0x3483
+
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_XHCI	0x8c31
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
 #define PCI_DEVICE_ID_INTEL_WILDCATPOINT_LP_XHCI	0x9cb1
@@ -296,8 +298,9 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 			pdev->device == 0x3432)
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 
-	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == 0x3483) {
+	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == PCI_DEVICE_ID_VIA_VL805) {
 		xhci->quirks |= XHCI_LPM_SUPPORT;
+		xhci->quirks |= XHCI_TRB_OVERFETCH;
 		xhci->quirks |= XHCI_EP_CTX_BROKEN_DCS;
 	}
 
@@ -347,11 +350,11 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 
 		if (pdev->device == 0x9202) {
 			xhci->quirks |= XHCI_RESET_ON_RESUME;
-			xhci->quirks |= XHCI_ZHAOXIN_TRB_FETCH;
+			xhci->quirks |= XHCI_TRB_OVERFETCH;
 		}
 
 		if (pdev->device == 0x9203)
-			xhci->quirks |= XHCI_ZHAOXIN_TRB_FETCH;
+			xhci->quirks |= XHCI_TRB_OVERFETCH;
 	}
 
 	/* xHC spec requires PCI devices to support D3hot and D3cold */
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 6304e9b00ecc..165f57911d94 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1897,7 +1897,7 @@ struct xhci_hcd {
 #define XHCI_EP_CTX_BROKEN_DCS	BIT_ULL(42)
 #define XHCI_SUSPEND_RESUME_CLKS	BIT_ULL(43)
 #define XHCI_RESET_TO_DEFAULT	BIT_ULL(44)
-#define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(45)
+#define XHCI_TRB_OVERFETCH	BIT_ULL(45)
 #define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
 
 	unsigned int		num_active_eps;
-- 
2.48.1

