Return-Path: <stable+bounces-88260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EDD9B234B
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 03:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF861C223F0
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 02:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C4918A959;
	Mon, 28 Oct 2024 02:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWWQ+h+C"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A81918A92C;
	Mon, 28 Oct 2024 02:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730084063; cv=none; b=pmbDbGBUL9AYUQRKACbUfF+04eBgBh2TtdKo9KGxfx3dfvs9efkGTavfUCiB7EaESwZlCqYEapPtE5yehBjcZ2OGSBJxPlVPJfKngcdSveHy6f0QMW07r1N33l0rMiokUh00SByZDXh11/SPIAbw++Nd4hVc4jIl7XHKZW1oeHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730084063; c=relaxed/simple;
	bh=8yAOCH/5oVbc/VWtxtpJpnWwkugwBt/hyzC1N8Mplpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=itLzRHLqOMjb329qUL60+D4ByFcmIIW8DsPZSoF05Pge4g4Fl6524dddJvXAMlfIBJRzLqHTwS9o7ujPB0zh0UFiYtQO6XHyZAfXTa2MX4NdLgd2eQcnFz6gU3uDzWDtunIttrLZgKcZlok0ohaRevJmcFR91koZYxsPIW20X4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWWQ+h+C; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e2a97c2681so2714613a91.2;
        Sun, 27 Oct 2024 19:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730084060; x=1730688860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icnzZRaIqKkWcfBQ8BZ/wsCIQ7yvPTT6fqKPWIQ7kVs=;
        b=RWWQ+h+CjqLZ0D6pSS1eBPlok3Eq9dAhkKLUvTD1tq2X5rUar6Sk8Khr+4/5XhbRHA
         W8UtYyM3QU2kh9ghLgY5IYXOgbymN047hq+GJCAmNtSn4BDAQIk3FS6FifOcJsrv3N/X
         ro5zuoaBvIyr42h/oSnMjtQJoA++hroVh8Ioxcqg3n/2078H8JNyv7680artNSL2ynfo
         T4dOGdT3FH26Th6tzKte/nE+dijA0f4RFUDAW/4eZWWN1QkeVfjfDvqr7L+6tN+KXcOl
         zAnLCx+KUhd5GLzauQM2qxh0pl8jzAbojpHvssjEoqVK/RtkCdxPPo/Ew+nHIhGL96e7
         enHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730084060; x=1730688860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icnzZRaIqKkWcfBQ8BZ/wsCIQ7yvPTT6fqKPWIQ7kVs=;
        b=bLWd+oEcJ8Ddhf8i0tV5KQhiVUkaBypQmSPpYBKV76FivZbYeP7Mr6rf4i4CIUlWfZ
         M/qTaiO65s/SK3qG9h/AYgdUQ4vsOch2VWgeMVS5acj85NdSXB2I4iPNZ1+RnTApdgaw
         czx0wrO+b5uA2UrxyInpkxw/wHft2WzmOAg2uTBQATzccCw2COuk85s4RsbexwDfJUOp
         ZdfB1h44jEdGDI5XlWPOoIY/tdvGWSDeteiZAacim6/IGOvD0JigseWqDAg7sZWRqe4/
         Oqmm0JSzvvNJoPANCxadmXGslTSXMTK44v9VjPXTuWtveA8QkSN7S9+LmRQYMomMJi+0
         sEYw==
X-Forwarded-Encrypted: i=1; AJvYcCVAg+eiQ4StqdbY/0NbrwWuyrPUUzBorRBPWkjV4VHwaE66i1xNIFxvtdspG2adqYJh1Uep0/4f@vger.kernel.org, AJvYcCWQWRC10hg0VnX+CvYE4lPzInXJ0dMdsuA6Fho/5kwY1L6Pm2X7gb+mcxaHsoyA8fannFCok93Peze3qZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeOC7GyHLTZWqd9lkT4NXJUM2BauC81LYa5wSOTLcEFhxNmgFG
	kSWAvqBZpM/ibVUhFw6+lOwQ2Bec4ttiMvHXr+R0GuYldv9EDHR7
X-Google-Smtp-Source: AGHT+IF/DXrsSgB53/f+vdHvP5JHLMOMaohlipY5A+64+th+HvseCzk+rsVXgoEiH2HMAvyZoeY2PQ==
X-Received: by 2002:a17:90b:3ec9:b0:2d3:da6d:8330 with SMTP id 98e67ed59e1d1-2e8f10507f6mr9070599a91.4.1730084060261;
        Sun, 27 Oct 2024 19:54:20 -0700 (PDT)
Received: from kic-machine.localdomain (122-117-151-175.hinet-ip.hinet.net. [122.117.151.175])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e4ca3fcsm8062236a91.13.2024.10.27.19.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 19:54:19 -0700 (PDT)
From: Kuangyi Chiang <ki.chiang65@gmail.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ki.chiang65@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/5] xhci: Combine two if statements for Etron xHCI host
Date: Mon, 28 Oct 2024 10:53:33 +0800
Message-Id: <20241028025337.6372-2-ki.chiang65@gmail.com>
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

Combine two if statements, because these hosts have the same
quirk flags applied.

Fixes: 91f7a1524a92 ("xhci: Apply broken streams quirk to Etron EJ188 xHCI host")
Cc: <stable@vger.kernel.org>
Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
---
 drivers/usb/host/xhci-pci.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 7e538194a0a4..33a6d99afc10 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -395,12 +395,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
 	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
-			pdev->device == PCI_DEVICE_ID_EJ168) {
-		xhci->quirks |= XHCI_RESET_ON_RESUME;
-		xhci->quirks |= XHCI_BROKEN_STREAMS;
-	}
-	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
-			pdev->device == PCI_DEVICE_ID_EJ188) {
+	    (pdev->device == PCI_DEVICE_ID_EJ168 ||
+	     pdev->device == PCI_DEVICE_ID_EJ188)) {
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 	}
-- 
2.25.1


