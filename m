Return-Path: <stable+bounces-93062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D27C9C95C0
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 00:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4381F2198B
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 23:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECDC1B219B;
	Thu, 14 Nov 2024 23:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="GbuMwzpI"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9C81AAE09;
	Thu, 14 Nov 2024 23:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625464; cv=none; b=m0kdrsU7fPTuN1p0EwPlHxu2+ViP9+UzBNWzNyrNxLCYFGf/lFSbYLmFViAIoQYIU8bE7Oat/t/9o4nSUc+kMRiEx+umW6b4+iAFR/fAc1A79RbVhqgLvkyA4ReYQw+osGu9oRGscGIw4oKT6gR15GiXa4rWSRhc7J5ZPxPbBAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625464; c=relaxed/simple;
	bh=OsGfGF/o5RpRQwcQvXjOZn+wKPv66BZqun6G0zAFjug=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fC5C/HfN/Ey2XyjSYbjUtZxt+s0welQzPrVjYjJAQTmSChuonC0A/W19qCahSagrin9Wwn/rrBUqu6ibYzRtUI0WJ/uS3CIsFbTkK2VTqBbz1B3+TB1vLQDrdvuq5r5/SOT7fyxwzb06IaDDsb/wRwnGpJjLGlv24CthsCFoZIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=GbuMwzpI; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from ldvnode.intra.ispras.ru (unknown [10.10.2.153])
	by mail.ispras.ru (Postfix) with ESMTPSA id 2DB0140777B9;
	Thu, 14 Nov 2024 23:04:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2DB0140777B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1731625457;
	bh=TSg5BOYF5KkmZaE8tI+lrU/1Mu+x0qt/noMtspsYKeM=;
	h=From:To:Cc:Subject:Date:From;
	b=GbuMwzpIFr+6skO8lVRVyDRQZ137I06PkPaAngrV+v1BWttjSyGlCLXZM9FgiIVJX
	 pJnkvaPyIw5y6YbpprG69OR/k0KtQviXSZwFyHCpSbfNLKzA7u5maFs0/A0dFtyFRD
	 WMUMbmoZ/zImKV1n8uR+jVPFjAPazzUXQGW7BUTM=
From: Vitalii Mordan <mordan@ispras.ru>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Vitalii Mordan <mordan@ispras.ru>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Vadim Mutilin <mutilin@ispras.ru>,
	stable@vger.kernel.org
Subject: [PATCH] usb: ehci-spear: fix call balance of sehci clk handling routines
Date: Fri, 15 Nov 2024 02:03:10 +0300
Message-Id: <20241114230310.432213-1-mordan@ispras.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the clock sehci->clk was not enabled in spear_ehci_hcd_drv_probe,
it should not be disabled in any path.

Conversely, if it was enabled in spear_ehci_hcd_drv_probe, it must be disabled
in all error paths to ensure proper cleanup.

Found by Linux Verification Center (linuxtesting.org) with Klever.

Fixes: 7675d6ba436f ("USB: EHCI: make ehci-spear a separate driver")
Cc: stable@vger.kernel.org
Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
---
 drivers/usb/host/ehci-spear.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-spear.c b/drivers/usb/host/ehci-spear.c
index d0e94e4c9fe2..11294f196ee3 100644
--- a/drivers/usb/host/ehci-spear.c
+++ b/drivers/usb/host/ehci-spear.c
@@ -105,7 +105,9 @@ static int spear_ehci_hcd_drv_probe(struct platform_device *pdev)
 	/* registers start at offset 0x0 */
 	hcd_to_ehci(hcd)->caps = hcd->regs;
 
-	clk_prepare_enable(sehci->clk);
+	retval = clk_prepare_enable(sehci->clk);
+	if (retval)
+		goto err_put_hcd;
 	retval = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (retval)
 		goto err_stop_ehci;
@@ -130,8 +132,7 @@ static void spear_ehci_hcd_drv_remove(struct platform_device *pdev)
 
 	usb_remove_hcd(hcd);
 
-	if (sehci->clk)
-		clk_disable_unprepare(sehci->clk);
+	clk_disable_unprepare(sehci->clk);
 	usb_put_hcd(hcd);
 }
 
-- 
2.25.1


