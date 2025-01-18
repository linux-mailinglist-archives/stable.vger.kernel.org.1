Return-Path: <stable+bounces-109437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EB9A15CAB
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 13:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 694371888E0A
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 12:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6BC18C006;
	Sat, 18 Jan 2025 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="oKmT7jr5"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B7713BADF
	for <stable@vger.kernel.org>; Sat, 18 Jan 2025 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737203072; cv=none; b=ho5PfskWQe1lD4S0LYRqqP5wllmUqm+04g0dNy77kKeYAUfHTn8j+GlcHObNu4/JC/tAyNURY2v92hrdTpyENGpfALRwJP0TVgSFDCkvqRtj7vwG8m6DUpT9hrQRxqmfBuXPxJfBgYU9tg0FegW9JlzOSg9wR70LFyCEzVINDtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737203072; c=relaxed/simple;
	bh=Q+dKwlAgfJR/L2LcGcl6V4jocS04iT3hVBlahHbjwjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a6G+qoi9uK3muJKyGP/xFsVmtVFZx+qfsuvn+TQDPMMbni2vvDhcXv5vmh5iy/1yqPrcemCgdbddcNzhdOMnY22tz7OvEUiYVgm//GloMRtLUEL9Gn1UQrsCUw5kKZaC6W7X3+FYbsGvjDrOI93NUWrZu0/eQhd1FWYXmkF7Ft8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=oKmT7jr5; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id Z6NXtijbidz4NZ7sFtMQOo; Sat, 18 Jan 2025 12:24:23 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Z7sEt6ZyALkZCZ7sEtOyka; Sat, 18 Jan 2025 12:24:22 +0000
X-Authority-Analysis: v=2.4 cv=ecc7faEH c=1 sm=1 tr=0 ts=678b9d76
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=VdSt8ZQiCzkA:10 a=7vwVE5O1G3EA:10 a=HaFmDPmJAAAA:8 a=SlZi4aQT4Pts4r2Ut8gA:9
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Mh2R0G2cJzYgeWqV9WhHZXx2WksjUEpSn9CcW1gfxZc=; b=oKmT7jr5zQZ/xyYsjgEZVlc/69
	4y3mFmMjWGylZ3r6jJYaK+InscEQ/pCwm6E5JTcCT08nYCRIfqFCAjAtSb/5XfrlTDqSUEe1qteQm
	DWyZxyjn+EcfgS/ssIIro76O1KuOPK+TJDv8BOW8FOf+Elvb6ZNyfq9999f1S7nxsmDYbzHP8n4LO
	RPdeF3nZ0NvAdbGe0V8x+oAyRiKsz5bDHbbCtIGkUxKmvZ4WdN5e1cv2J7W84bEOOYjLEKSEwaVbc
	KJH9la3duxbyIQsmX1k5nMObVRU2S/lc8PgVLjnFCP90AcLLBDqjLXw+2ciHtDbjErWzV+E//KLOi
	vaoYuwug==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:41512 helo=beavis.silicon)
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tZ7sD-001HzA-39;
	Sat, 18 Jan 2025 05:24:22 -0700
From: Ron Economos <re@w6rz.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Pavel Machek <pavel@denx.de>,
	linux-kernel@vger.kernel.org,
	Ron Economos <re@w6rz.net>
Subject: [PATCH 6.1] Partial revert of xhci: use pm_ptr() instead #ifdef for CONFIG_PM conditionals
Date: Sat, 18 Jan 2025 04:24:09 -0800
Message-ID: <20250118122409.4052121-1-re@w6rz.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1tZ7sD-001HzA-39
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net (beavis.silicon) [73.223.253.157]:41512
X-Source-Auth: re@w6rz.net
X-Email-Count: 7
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPh5SDaIaKvbcfPKyjBPZKEkn0fnRXJcIyRxnpQERVbE2cmp081B5zBtHvQLkMSFTm999gTQz0zQKkYORJDUFzN387w0OsboEFAXW2m2ns/4ar0/Xi8w
 ge5L0k4l5l54FAEZrIj3vCiRa3rnEyWtrWVn/vr5RecNrN0Hn6Npwa3SsCO3EkLZIrV5pT+7pjH2nA==

commit 9734fd7a27772016b1f6e31a03258338a219d7d6

This fixes the build when CONFIG_PM is not set

Signed-off-by: Ron Economos <re@w6rz.net>
---
 drivers/usb/host/xhci-pci.c | 8 +++++++-
 include/linux/usb/hcd.h     | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 1d71e8ef9919..2ff049e02326 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -571,6 +571,7 @@ static void xhci_pci_remove(struct pci_dev *dev)
 		pci_set_power_state(dev, PCI_D3hot);
 }
 
+#ifdef CONFIG_PM
 /*
  * In some Intel xHCI controllers, in order to get D3 working,
  * through a vendor specific SSIC CONFIG register at offset 0x883c,
@@ -720,6 +721,7 @@ static void xhci_pci_shutdown(struct usb_hcd *hcd)
 	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
 		pci_set_power_state(pdev, PCI_D3hot);
 }
+#endif /* CONFIG_PM */
 
 /*-------------------------------------------------------------------------*/
 
@@ -761,17 +763,21 @@ static struct pci_driver xhci_pci_driver = {
 	/* suspend and resume implemented later */
 
 	.shutdown = 	usb_hcd_pci_shutdown,
+#ifdef CONFIG_PM
 	.driver = {
-		.pm = pm_ptr(&usb_hcd_pci_pm_ops),
+		.pm = &usb_hcd_pci_pm_ops
 	},
+#endif
 };
 
 static int __init xhci_pci_init(void)
 {
 	xhci_init_driver(&xhci_pci_hc_driver, &xhci_pci_overrides);
+#ifdef CONFIG_PM
 	xhci_pci_hc_driver.pci_suspend = xhci_pci_suspend;
 	xhci_pci_hc_driver.pci_resume = xhci_pci_resume;
 	xhci_pci_hc_driver.shutdown = xhci_pci_shutdown;
+#endif
 	return pci_register_driver(&xhci_pci_driver);
 }
 module_init(xhci_pci_init);
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 575716d3672a..cd667acf6267 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -486,7 +486,9 @@ extern void usb_hcd_pci_shutdown(struct pci_dev *dev);
 
 extern int usb_hcd_amd_remote_wakeup_quirk(struct pci_dev *dev);
 
+#ifdef CONFIG_PM
 extern const struct dev_pm_ops usb_hcd_pci_pm_ops;
+#endif
 #endif /* CONFIG_USB_PCI */
 
 /* pci-ish (pdev null is ok) buffer alloc/mapping support */
-- 
2.43.0


