Return-Path: <stable+bounces-109478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B64CDA160DD
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 09:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9B61882AFD
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 08:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD0B157A46;
	Sun, 19 Jan 2025 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TtT3OB2t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4880C1401C;
	Sun, 19 Jan 2025 08:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737273863; cv=none; b=Smgp3pBHNL6rRZUyMofFJk87zZ3UoaCgKF4llCMQEjsBPkOUUCZfALB8+sACb+XdP4K6+2nUUkAzGq+ixCr/T9kjT9HD2BMej84Yg1QQ9zziMO+s+AUy5olEfUjJVpu3bqp73792KfbbL0h1pmO/1YF+KsHvB1FZnz0wcb3ef+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737273863; c=relaxed/simple;
	bh=wUB7n5idkAdTQlHGFoillvGMOi4IJPWUR2lafoYitdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Btfrf1z1goA2qYQ4+ED+kKucx13bfQhNwgBmF7LNee+3qYPpsfI6jW8NGN9JwtI+m4RDjTC0mBej4v1sie6DJLS8jdc/khRt0t/rEQ0OhVFxEH2zeCshrFQwxzdXvzMHSFvtTfIQUk+lHOTzNoVmspjhH8wahyM0gp7B1bx1rCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TtT3OB2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2813BC4CED6;
	Sun, 19 Jan 2025 08:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737273862;
	bh=wUB7n5idkAdTQlHGFoillvGMOi4IJPWUR2lafoYitdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TtT3OB2t2Pwb1bi+IB4kfSp04IHCKv2fDa3QPhOBZff2ag+sqp06V180+55Ck0zoV
	 +gW9hQuo6nUsjsf2Q6N3pZx12ovxiIaGL4If552tb+BLEC67P15P8+Kt5+wsoqAcoO
	 x3wd4uz9w0yeonZUWWZaU+thRAls2z+jIktGh/jQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.126
Date: Sun, 19 Jan 2025 09:04:17 +0100
Message-ID: <2025011941-bride-juicy-4971@gregkh>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025011941-sludge-pushup-e772@gregkh>
References: <2025011941-sludge-pushup-e772@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 9151052c19af..916ed3b66536 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 125
+SUBLEVEL = 126
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 1d71e8ef9919..e90ff21b7c54 100644
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
 
@@ -769,9 +771,11 @@ static struct pci_driver xhci_pci_driver = {
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

