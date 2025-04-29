Return-Path: <stable+bounces-137094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B360AA0D5F
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 15:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAEF43B8B0B
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 13:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A210442C;
	Tue, 29 Apr 2025 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="dFbB7Kg2"
X-Original-To: stable@vger.kernel.org
Received: from smtp120.ord1d.emailsrvr.com (smtp120.ord1d.emailsrvr.com [184.106.54.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EDD2C179F
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745932907; cv=none; b=JMFbS9WqaHwhL3kKSu+vEfRbe5Cw2NwZqV0ezoi4hcE1Tzs2eHSnO2inDwpn8HS6jrGPGGAUcz4lxcv0j0LzH0kmzRTpIrqf/Ey/sGtcqzRh+iW/w2uSPNkzLwlYxlkbmCDKVpXjh3caLnCV0vwPfPLVjcJKx1XVgbB5MSKXFz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745932907; c=relaxed/simple;
	bh=37saT0y0HaSeI7zFesxBqgz5KOtM1yTe6E9nTplQa30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoixNbpquyf05nijpm3PxYX9/rnqDmMBUjaF09AZKYzBxn/bayDMepXBN4wV5FqEYS9DABhDYN10nv947rteMfOHtaOTVSPtDEWDet4BneBHNhmblgmXT8zvga0J6GHkkZTZ6he2ejn1nO/7gtzkQurSb8JPRu+hKENC3m0Oc+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=dFbB7Kg2; arc=none smtp.client-ip=184.106.54.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1745931970;
	bh=37saT0y0HaSeI7zFesxBqgz5KOtM1yTe6E9nTplQa30=;
	h=From:To:Subject:Date:From;
	b=dFbB7Kg26muhOVw1Z0W8155pEW9Dtxf7APvBb0ZPcYu5UGbfe2eVN8D5ozKDoyEvG
	 Eq+3V5+s7Cc21w8L756pjStAWu7g2qNZpBbxcy0ZW2cTNoEp8W+Wrg6kVIUMWLaJPd
	 kQ2uAmqcUgRznKitDBmfp/XScCcRcYui3kS4Utdw=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp24.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 867DCA01B1;
	Tue, 29 Apr 2025 09:06:09 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.4.y] comedi: jr3_pci: Fix synchronous deletion of timer
Date: Tue, 29 Apr 2025 14:06:01 +0100
Message-ID: <20250429130601.672190-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <2025042808-vastly-armrest-7811@gregkh>
References: <2025042808-vastly-armrest-7811@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 35dc8a35-9bf2-4e4e-bca6-27ae172bec23-1-1

commit 44d9b3f584c59a606b521e7274e658d5b866c699 upstream.

When `jr3_pci_detach()` is called during device removal, it calls
`del_timer_sync()` to stop the timer, but the timer expiry function
always reschedules the timer, so the synchronization is ineffective.

Add a member `bool timer_enable` to the device private data to indicate
whether the timer should be restarted.  Use the main comedi device
spin-lock for synchronization, as that is already used by the timer
expiry function.  (The upstream commit called `timer_shutdown_sync()`
instead of `del_timer_sync()`, but that is not available.)

Fixes: 07b509e6584a5 ("Staging: comedi: add jr3_pci driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20250415123901.13483-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/comedi/drivers/jr3_pci.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/comedi/drivers/jr3_pci.c b/drivers/staging/comedi/drivers/jr3_pci.c
index c3c88e6d298f..50dd88f8d238 100644
--- a/drivers/staging/comedi/drivers/jr3_pci.c
+++ b/drivers/staging/comedi/drivers/jr3_pci.c
@@ -88,6 +88,7 @@ struct jr3_pci_poll_delay {
 struct jr3_pci_dev_private {
 	struct timer_list timer;
 	struct comedi_device *dev;
+	bool timer_enable;
 };
 
 union jr3_pci_single_range {
@@ -612,10 +613,11 @@ static void jr3_pci_poll_dev(struct timer_list *t)
 				delay = sub_delay.max;
 		}
 	}
+	if (devpriv->timer_enable) {
+		devpriv->timer.expires = jiffies + msecs_to_jiffies(delay);
+		add_timer(&devpriv->timer);
+	}
 	spin_unlock_irqrestore(&dev->spinlock, flags);
-
-	devpriv->timer.expires = jiffies + msecs_to_jiffies(delay);
-	add_timer(&devpriv->timer);
 }
 
 static struct jr3_pci_subdev_private *
@@ -764,6 +766,7 @@ static int jr3_pci_auto_attach(struct comedi_device *dev,
 	devpriv->dev = dev;
 	timer_setup(&devpriv->timer, jr3_pci_poll_dev, 0);
 	devpriv->timer.expires = jiffies + msecs_to_jiffies(1000);
+	devpriv->timer_enable = true;
 	add_timer(&devpriv->timer);
 
 	return 0;
@@ -773,8 +776,12 @@ static void jr3_pci_detach(struct comedi_device *dev)
 {
 	struct jr3_pci_dev_private *devpriv = dev->private;
 
-	if (devpriv)
+	if (devpriv) {
+		spin_lock_bh(&dev->spinlock);
+		devpriv->timer_enable = false;
+		spin_unlock_bh(&dev->spinlock);
 		del_timer_sync(&devpriv->timer);
+	}
 
 	comedi_pci_detach(dev);
 }
-- 
2.47.2


