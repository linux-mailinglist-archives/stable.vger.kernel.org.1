Return-Path: <stable+bounces-47545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D73F8D125A
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 05:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 175AFB21DB7
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 03:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBE51401B;
	Tue, 28 May 2024 03:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfaWkHfG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB08F9D6
	for <stable@vger.kernel.org>; Tue, 28 May 2024 03:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716865202; cv=none; b=LvzCRXQ6rAyOZoC7Q0B3acevCG0yjk8GMtfjWx9UVgsEEsmB9OnxVfq42GYusn65YrstZ6oZlyjNyFSRAaujLC4wzFzWFqiS3ASQPPNALcakH8Del7SOPGYPrxWlktZd2s79I50okj+nr2huEYhvhDi2vp3iQFOq7Pe+wChP/U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716865202; c=relaxed/simple;
	bh=SleKNQwalY1X1sWZ99eNvJW3+I467p59CunL4Lgmfks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fhEz2ZNkyIEs9cZ2A8fRJf4D+0dOkE+nohzyKRkMgfRUuW0wvATydGkCBfheXVi0VLurLagpl9UBqh3gwKChaRKdOggDz2NxY+pxhdRvSYhRPGvUf8o0Er1oJH+oQdttmnBvMqR0qjJmNSCAg9ZGmeLeLodadPA9rapCdajI1bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfaWkHfG; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f8e965d1b6so5585b3a.1
        for <stable@vger.kernel.org>; Mon, 27 May 2024 20:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716865200; x=1717470000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLJbSBSqoq/Zyb8WJpUER3T2Y8k8wG3x9WsdChjQWJg=;
        b=IfaWkHfGOskEHX6srvbjDvZpZte7sU0KnyZ2pUEM021uL1gKmIRdjLrFNPCWp9Aceh
         E71EdOYkVALmRQKxmcv7g9Y+Lr8Bp1iRgi/baUq4ZU0Bst3TB5Jgdur35J5oDfVkDSke
         KRfS36DQV3Vk70l2ka38XzfNuKuRm/VDk7sYNxFmnFpf6ZoRC45PZfCaycPGEolWvsHG
         exjGALZ4N/3gLanAK8klevLgjlRmmL29i7GAnYEEpGIIi+82lnUWJ95EtPYM0Gy4hlwB
         VOeOVNMG8HLYwJjlNCyOLuYsEdCoc2ECOjBOMOJcd5X/stJ6SZOw5twR/pCyBb3amMWJ
         neTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716865200; x=1717470000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jLJbSBSqoq/Zyb8WJpUER3T2Y8k8wG3x9WsdChjQWJg=;
        b=T+91FMElpRhRByXjk/Y+3+3YNYf4NTSda/IFCPK6iy9E6zbAtO5Mt6OXLmNcP9m+/q
         1YlmN56D00uU69jO/Pj28P5lOf/FKCSdm/2EFAHLhKSC2KZsJtZLFd1GCaGC51JnXoVq
         U9nyI3O7t8HEVlEocB/Rm+lNeuWqmAlqytocET9zYEz9kCPmZiIHKSf3JrXuccfdY7NB
         jol4WekrNHzBbhcoHG2HnLe8HLmLA75rfI70UAcX5BdS7aOn0tE57ywFV0iplKRW9XG+
         p/34l04kDywC3XZwiuUVSjwaBw/bj9UuQiRnvx0RqkkNi+Ogdt4kiiB7lbIr1xMHmQeu
         MFBQ==
X-Gm-Message-State: AOJu0YxescOKELREdT7cwxf0RoddotcMqr1b3Wx7NcZ3dKcmfMhIExma
	WvgEdL/gWRMbrENcG/oJi+NVu4bbKslTo0X75Q2Ss96c6VD0QD4gOjQvWDV6
X-Google-Smtp-Source: AGHT+IG5dU6BsPaSgahc57q9qCbwE/wOZCr7X1WIANVkPcfKjond+Z/ssOt37C6QTVNqxEW565cZNw==
X-Received: by 2002:a05:6a00:2176:b0:6ec:ee44:17bb with SMTP id d2e1a72fcca58-6f8f3e843a1mr11397926b3a.2.1716865199665;
        Mon, 27 May 2024 19:59:59 -0700 (PDT)
Received: from localhost.localdomain (122-117-151-175.hinet-ip.hinet.net. [122.117.151.175])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcbeea11sm5666533b3a.98.2024.05.27.19.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 19:59:59 -0700 (PDT)
From: Kuangyi Chiang <ki.chiang65@gmail.com>
To: ki.chiang65@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH v2 1/2] xhci: Apply reset resume quirk to Etron EJ188 xHCI host
Date: Tue, 28 May 2024 10:59:49 +0800
Message-Id: <20240528025949.13679-2-ki.chiang65@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240528025949.13679-1-ki.chiang65@gmail.com>
References: <20240528025949.13679-1-ki.chiang65@gmail.com>
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


