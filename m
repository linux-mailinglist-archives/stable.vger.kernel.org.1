Return-Path: <stable+bounces-47548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDE28D1297
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 05:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A988328413E
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 03:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B57199B8;
	Tue, 28 May 2024 03:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XD6l51WU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0611401B;
	Tue, 28 May 2024 03:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716867162; cv=none; b=s2nNyXzM/ENXAKZQ+jF2qG6T8cQTctBkM1upWiN0KdEotcVzwIbC+OGE+S8vqc7muAHwm1LSgRIaGEv16/0WUZn1T1uBqYQ/dLBj6nsrsLqqPc5/fzMlghfJGcGNdnT53chCGGCzURroWbYhQJL5R7KoYglIwswGCa3AtYs+iCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716867162; c=relaxed/simple;
	bh=SleKNQwalY1X1sWZ99eNvJW3+I467p59CunL4Lgmfks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QJ1tKbnibIMB4o5tWO4Cfd/G34GT/pWZlP1bUvLpR+es8ZUD6HJgs7IgCYqv10sD2fPbnPfFtxUqTkkcWAXYL5UXgyx9EV3c+YKuKyHsyGBqNVmNljFlz79u+8xFzYYjq4LUiptdSX0dcTMPNV2MZnAuIIpCG2zpLmi4PmHeO/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XD6l51WU; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2bda88e2b23so71566a91.1;
        Mon, 27 May 2024 20:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716867160; x=1717471960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLJbSBSqoq/Zyb8WJpUER3T2Y8k8wG3x9WsdChjQWJg=;
        b=XD6l51WUm9sSn1Yla2Pd2bhoHIoJkeXG1s1NfUzt9p79H3cWpMz0vHNQ9OOR1W0uYs
         5QDWBOIkhr87ybiuohlQ5JJHSUp7d+/x7phKf1iGPySd6gCcSnPvbeTS3QxIkRMtLAwN
         mtec126NS/mXXP5s+Mk1rDmer2ZqiwDWh1vqeP3+hrnPWLYSPK/0vI+lijITpKhXlK0E
         pb3dddfsayFK84oOm+MIPCFMq8Pgpv8FZ1cFufojQ5Z2W4UvVKA6txUNtBC/mHK1rf80
         23Rh3GtfrkzsZXZpceMmuMzuTW4OK7h0XRg6GR2AHqa2LJq9MzuD9Me1k8lSiI7JwGms
         IzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716867160; x=1717471960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jLJbSBSqoq/Zyb8WJpUER3T2Y8k8wG3x9WsdChjQWJg=;
        b=NTX3vWZFlXC1k6FX7t11YBGSIagrX8H67TtnfmWClGf1/aQbIgOf6UQxJorrqFuQ91
         /cIDzT29vAqq6IgNI7WgMjYS9i5ohkjfBVek6eFk2ABzAGFOyoqWkcHVJn7vHfztOExr
         pR4MeRMD6HRYF+TeELHiQnBHLgjQ9jmRHtRjCOIs4OOCIfWtzSuDE9BPdWHE1QvZ9TOR
         OHDxGwxmyEPNM9R6PAzaeKS01Pc74lodNRNtw5HJdgugu44eGTqEAF9iEThGDr0pfT8m
         sRvKCI3fBLfrfJs3vQ9HmWJUAmGf9e8PWFLB6VkAKPuR7r6Uxh0Oxp09Z9EzcjVFMU1X
         vcEg==
X-Forwarded-Encrypted: i=1; AJvYcCWQm90b2L8Ev4kqBwOzhINB2IHeRc0TL5LNi1PMVGb6Qss5JiZEQgg9QHpBGAd3FMUFwvmeIuftTm/IpEQzAA/r8qzL80i5NHytZITS57qibVaEIH93ElbhYlbdTn8+zZeQNFGt
X-Gm-Message-State: AOJu0YwAhfVLrWyl1uPxV/zOy1cNZYUjIylm55U58Nz4Y1fxiP/8YOtk
	hXwRv7Z5PCfcQ0Udg1SDiVoEubNYRjCCqh6tstLp6jQ37gyW62hmaElBD1yC
X-Google-Smtp-Source: AGHT+IGvqs9EvS9l7fq4AM0aII/4Cp9J/Kxzr2kPMQsY+M6noSmTXGcunoA7KtbZwmrClItXIiBfEw==
X-Received: by 2002:a05:6a20:dd86:b0:1af:dbe4:b34e with SMTP id adf61e73a8af0-1b212e726a1mr11500416637.4.1716867160520;
        Mon, 27 May 2024 20:32:40 -0700 (PDT)
Received: from localhost.localdomain (122-117-151-175.hinet-ip.hinet.net. [122.117.151.175])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcbec62fsm5909651b3a.133.2024.05.27.20.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 20:32:40 -0700 (PDT)
From: Kuangyi Chiang <ki.chiang65@gmail.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ki.chiang65@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] xhci: Apply reset resume quirk to Etron EJ188 xHCI host
Date: Tue, 28 May 2024 11:31:36 +0800
Message-Id: <20240528033136.14102-2-ki.chiang65@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240528033136.14102-1-ki.chiang65@gmail.com>
References: <20240528033136.14102-1-ki.chiang65@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As described in commit c877b3b2ad5c ("xhci: Add reset on resume quirk for
asrock p67 host"), EJ188 have the same issue as EJ168, where completely
dies on resume. So apply XHCI_RESET_ON_RESUME quirk to EJ188 as well.

Cc: <stable@vger.kernel.org>
Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
---
Changes in v2:
- Porting to latest release

 drivers/usb/host/xhci-pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index c040d816e626..b47d57d80b96 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -36,6 +36,7 @@
 
 #define PCI_VENDOR_ID_ETRON		0x1b6f
 #define PCI_DEVICE_ID_EJ168		0x7023
+#define PCI_DEVICE_ID_EJ188		0x7052
 
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_XHCI	0x8c31
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
@@ -395,6 +396,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 	}
+	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
+			pdev->device == PCI_DEVICE_ID_EJ188) {
+		xhci->quirks |= XHCI_RESET_ON_RESUME;
+	}
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
 	    pdev->device == 0x0014) {
 		xhci->quirks |= XHCI_ZERO_64B_REGS;
-- 
2.25.1


