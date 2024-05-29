Return-Path: <stable+bounces-47611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 977338D2AC0
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 04:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C80AB230E7
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 02:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1609B15ADBE;
	Wed, 29 May 2024 02:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2S/5qri"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D6915ADA8;
	Wed, 29 May 2024 02:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716949489; cv=none; b=jh0aFDrfHOnD15yGe1D7cByG1K7gf1orIW1gSqOVD2q0kv00olL3zHagl/gjWFCrAFckgflqTg4tN89Mu0e0NBkdK25+6ekKe4YTWqrc5DILs5GdGynLHVQFVOgfxUMIHnlhYbt2UtUIlz3KTJY6UXPT0iF9Te5tQN8vS4SADgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716949489; c=relaxed/simple;
	bh=hxtqqQFtAYgzzrgf4DLHYl91O3D7RMr1juMPdGUfxbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YT900deBl/hn2BXqDke5oML4UrmVjgXmnQ7TjMCk7B4nFdu2l2Ig2Z4cgmnMRtCEPjrQ94/JMbljwZJCqTxiVd34lVqNU6G+7L/9nghZNZMPQYp5uPqc725gmB84yzzh9cO1r2CHBf6XnssGioSRvEbCTzoXdqAqhE7ma8upX4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2S/5qri; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2bded7f6296so270337a91.1;
        Tue, 28 May 2024 19:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716949488; x=1717554288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CY4dWZ9cyChcyNHRqzuKIDzJLz0YH1+twjPfRFeGrQ=;
        b=P2S/5qriIuoK4h9tEXWxJzWr+mHNsGWebLHVyehUkw6Sljg9LWXx88wrsgDGSThsbw
         KaA6MoMwoIS377yGqWa/iSzwNIPNYEuz2Thn+WHymNFNVC9FViil9E9tNUIned5pILnJ
         rvltBMDd89MTqToKlwi6axQ9dSywfZELPeLVpGAsDtNnO2KX+A9vXT4IkIlGl/kGPvPD
         2d8TdMhc+6LT2DkTnWkQlU9tkx36LlSrtv+baX3n7NIX15/2OV5pSIta79MoRkqm/+rd
         wGLduEEaot3yx9+emXWspec1dUtCJhPusLI3kzcnmc9SdiBSsrikja5oFnkuYF5VyNvZ
         5/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716949488; x=1717554288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0CY4dWZ9cyChcyNHRqzuKIDzJLz0YH1+twjPfRFeGrQ=;
        b=pgMCZVO1VHQuDLGJqquvQtVupN5zAKyit9IXx66e+3WKw0JP/cuHgbGtqB0JmDDefk
         dZoYc5g4GeAelf/8k1isyDGz18TaGB7TQxcYCx1i1oa8F0YTFXVvzqeTygD2r7fvRNKL
         4qCssHo1MS0yNIIwj4VACPnTbOi9g1fJH2uyujtIQ1n435QQdN9VlZ8dTTGyjt/kh/sl
         FKKW6bHpmb1PzBRNQCDQb7Lt6P2NtnRqZTL/ttQe0wc15rqAiM/MWCgeP0vEmpz5pA8q
         kJOM6T7S/1OF5iU3rtLvqixvw7hiJ2eqnmyKH9Rt+bgYmunUhMqCIWaWRh1SLIx5+amV
         NrPw==
X-Forwarded-Encrypted: i=1; AJvYcCVtH07zRA6j15CouHwZ15thH9pZlFkHeBFWasQ5iNqmLVNfJoCJu7V92CgPqt9iZvfkQtZNl0ScvNkqKe4D5P3Kab3GuOQJs1ww9M81YWOyD8OD29537dhCTpuocBXv8JuPzGyK
X-Gm-Message-State: AOJu0YzJr9W8ScELZgfdN3qfkAfMNM6qFhpxMomZHksLHoSvThKiL+Ww
	HCkYdFr8Leywbl7Zwp4M79jkZWi7yQtMHtmOlNFC/k4ceJYIG+72
X-Google-Smtp-Source: AGHT+IH58pyD92nfulzMGoXRvsFuUoLd54s3wBPWPwNPjTLmxqGbpNPlaSj4WoSUuI1iQI49cCdeww==
X-Received: by 2002:a17:902:d4c8:b0:1f2:ffbc:7156 with SMTP id d9443c01a7336-1f4486ae484mr156437435ad.1.1716949487799;
        Tue, 28 May 2024 19:24:47 -0700 (PDT)
Received: from localhost.localdomain (122-117-151-175.hinet-ip.hinet.net. [122.117.151.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9c6fd1sm89856375ad.278.2024.05.28.19.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 19:24:47 -0700 (PDT)
From: Kuangyi Chiang <ki.chiang65@gmail.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ki.chiang65@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] xhci: Apply reset resume quirk to Etron EJ188 xHCI host
Date: Wed, 29 May 2024 10:24:20 +0800
Message-Id: <20240529022420.9449-2-ki.chiang65@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240529022420.9449-1-ki.chiang65@gmail.com>
References: <20240529022420.9449-1-ki.chiang65@gmail.com>
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
Changes in v3:
- Fix coding style

Changes in v2:
- Porting to latest release

 drivers/usb/host/xhci-pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index c040d816e626..dd8256e4e02a 100644
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
+			pdev->device == PCI_DEVICE_ID_EJ188)
+		xhci->quirks |= XHCI_RESET_ON_RESUME;
+
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
 	    pdev->device == 0x0014) {
 		xhci->quirks |= XHCI_ZERO_64B_REGS;
-- 
2.25.1


