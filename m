Return-Path: <stable+bounces-98806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3229E5755
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 14:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414FD169A39
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 13:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CA6433D8;
	Thu,  5 Dec 2024 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="XAvpQWug"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F1C218AB8;
	Thu,  5 Dec 2024 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733405609; cv=none; b=OmYdIZwOzC4DPNyESTHI0euUZkl2g7tSQasseFZx2M4hp3INSh+4paLHBfGWl1MIxLMgBcFBWclcJJ5/EDooCH+WprWPy7dqOTaLLoQqOfn61EmIS4feLlcYhZp0uOPzq/RJYITI0h6ZPxgO9/AvuKeINdHubQ3uqhmrAn4k8TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733405609; c=relaxed/simple;
	bh=lczAqVQfpP9AYgOE79ExuSe2liZMUmXcyvl2haixi/M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cQA61lkqN6vq+ET81FgGrbWtDtgr4SmfO0Dm1vAdLspuvo7kDtQ8357OyKGoF8O0KNbaAQ2bI/EmD53+VQkHO0D9MDnUoGZbJ6KKC9PQKDNpwnkObUo7j93dSGBFBW1gjr7dEiMc7OxDqeK33S6yZEJjBu/PK/YlKho+ZUpkW78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=XAvpQWug; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from ldvnode.intra.ispras.ru (unknown [10.10.2.153])
	by mail.ispras.ru (Postfix) with ESMTPSA id BA1C840762DC;
	Thu,  5 Dec 2024 13:33:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru BA1C840762DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1733405595;
	bh=j0BGhnmGhO8DhdcdiITa7Hz70d0+hDipGh+uz2C2l9U=;
	h=From:To:Cc:Subject:Date:From;
	b=XAvpQWug+JRVbPPJSkYq6+qysJM9+WgBEyCqlgmJUP7WZBVmXZ+JraFosMDtxIHZg
	 Ns6vK67zdrr6Y4VssMzWHcn34mD0yNygqbga0dqZQnzZlfxZuGSsKBPMxkqiv/KVKK
	 e2XL21Y/VDaUxYwVuj+tM6mx43Sm9mtAKzNhS+Sw=
From: Vitalii Mordan <mordan@ispras.ru>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Vitalii Mordan <mordan@ispras.ru>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Deepak Saxena <dsaxena@linaro.org>,
	Manjunath Goudar <manjunath.goudar@linaro.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Vadim Mutilin <mutilin@ispras.ru>,
	stable@vger.kernel.org
Subject: [PATCH] usb: ohci-spear: fix call balance of sohci_p->clk handling routines
Date: Thu,  5 Dec 2024 16:33:00 +0300
Message-Id: <20241205133300.884353-1-mordan@ispras.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the clock sohci_p->clk was not enabled in spear_ohci_hcd_drv_probe,
it should not be disabled in any path.

Conversely, if it was enabled in spear_ohci_hcd_drv_probe, it must be disabled
in all error paths to ensure proper cleanup.

The check inside spear_ohci_hcd_drv_resume() actually doesn't prevent
the clock to be unconditionally disabled later during the driver removal but
it is still good to have the check at least so that the PM core would duly
print the errors in the system log. This would also be consistent with
the similar code paths in ->resume() functions of other usb drivers, e.g. in
exynos_ehci_resume().

Found by Linux Verification Center (linuxtesting.org) with Klever.

Fixes: 1cc6ac59ffaa ("USB: OHCI: make ohci-spear a separate driver")
Cc: stable@vger.kernel.org
Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
---
 drivers/usb/host/ohci-spear.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ohci-spear.c b/drivers/usb/host/ohci-spear.c
index 993f347c5c28..6f6ae6fadfe5 100644
--- a/drivers/usb/host/ohci-spear.c
+++ b/drivers/usb/host/ohci-spear.c
@@ -80,7 +80,9 @@ static int spear_ohci_hcd_drv_probe(struct platform_device *pdev)
 	sohci_p = to_spear_ohci(hcd);
 	sohci_p->clk = usbh_clk;
 
-	clk_prepare_enable(sohci_p->clk);
+	retval = clk_prepare_enable(sohci_p->clk);
+	if (retval)
+		goto err_put_hcd;
 
 	retval = usb_add_hcd(hcd, irq, 0);
 	if (retval == 0) {
@@ -103,8 +105,7 @@ static void spear_ohci_hcd_drv_remove(struct platform_device *pdev)
 	struct spear_ohci *sohci_p = to_spear_ohci(hcd);
 
 	usb_remove_hcd(hcd);
-	if (sohci_p->clk)
-		clk_disable_unprepare(sohci_p->clk);
+	clk_disable_unprepare(sohci_p->clk);
 
 	usb_put_hcd(hcd);
 }
@@ -137,12 +138,15 @@ static int spear_ohci_hcd_drv_resume(struct platform_device *dev)
 	struct usb_hcd *hcd = platform_get_drvdata(dev);
 	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
 	struct spear_ohci *sohci_p = to_spear_ohci(hcd);
+	int ret;
 
 	if (time_before(jiffies, ohci->next_statechange))
 		msleep(5);
 	ohci->next_statechange = jiffies;
 
-	clk_prepare_enable(sohci_p->clk);
+	ret = clk_prepare_enable(sohci_p->clk);
+	if (ret)
+		return ret;
 	ohci_resume(hcd, false);
 	return 0;
 }
-- 
2.25.1


