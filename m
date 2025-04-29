Return-Path: <stable+bounces-137097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6A1AA0DFC
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 15:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD52B168993
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 13:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE417211A0B;
	Tue, 29 Apr 2025 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="VcOC+KW2"
X-Original-To: stable@vger.kernel.org
Received: from smtp67.ord1d.emailsrvr.com (smtp67.ord1d.emailsrvr.com [184.106.54.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F8686353
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745935009; cv=none; b=TyZ30MwLyrSiHKtbYl5Um6TN1r/PBi+GxKNd1+OvMb94ULtvMAxXbzwI5aWhhul667AKP0rN3eXOGivO/lBsPH8HYcxoOcW+bA//SwhyExq+KATBG/qhDRQehkrB3FdlM/xdlLKbjIQt5RXpsjV9wZaqpNI5v/IlUaiHr/Ivcys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745935009; c=relaxed/simple;
	bh=2BMQsJZw9mH37ibyJ4Pf85dh/qEc0CL1cgJwVgm7na0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mXeDSl6h7u3rgbGgjSsF8PJg+KMZ9WzasGG2BxsK91g3XpBY6WEF0HlevsRtgqZJH883v2vlkL5WMqzs8vweHG0V3tPBVfOYAFO7kbUvET6gmnPifzevFnXYGS5WuMZ3Tkk21HK0NSU1IkWHtKGC5xwhDCOk8406HtjgBE0seDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=VcOC+KW2; arc=none smtp.client-ip=184.106.54.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1745928115;
	bh=2BMQsJZw9mH37ibyJ4Pf85dh/qEc0CL1cgJwVgm7na0=;
	h=From:To:Subject:Date:From;
	b=VcOC+KW2kJyUk7+y4Fmh5iXlgCxm5PcnIyhPSL7coxftiIdnShrTwT/VDOLIm3was
	 oa98PErDd+0yBlcjFzv2JqZyBoEonyAN10bgGzJUZdKKNYR7sCMn36bInJmrNKU+g2
	 530Bf0Gthmthf/vM0JnPfzgll0rJqD9x0c/15sxg=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp1.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id E28ED4017A;
	Tue, 29 Apr 2025 08:01:54 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.15.y] comedi: jr3_pci: Fix synchronous deletion of timer
Date: Tue, 29 Apr 2025 13:01:42 +0100
Message-ID: <20250429120142.403147-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <2025042807-vanquish-unbeaten-57ab@gregkh>
References: <2025042807-vanquish-unbeaten-57ab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: c203898c-a852-48e1-8993-4b1a70333ef1-1-1

commit 44d9b3f584c59a606b521e7274e658d5b866c699 upstream.

When `jr3_pci_detach()` is called during device removal, it calls
`timer_delete_sync()` to stop the timer, but the timer expiry function
always reschedules the timer, so the synchronization is ineffective.

Add a member `bool timer_enable` to the device private data to indicate
whether the timer should be restarted.  Use the main comedi device
spin-lock for synchronization, as that is already used by the timer
expiry function.  (The upstream commit called `timer_shutdown_sync()`
instead of `timer_delete_sync()`, but that is not available.)

Fixes: 07b509e6584a5 ("Staging: comedi: add jr3_pci driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20250415123901.13483-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/comedi/drivers/jr3_pci.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/comedi/drivers/jr3_pci.c b/drivers/comedi/drivers/jr3_pci.c
index f963080dd61f..8ef13f5baf07 100644
--- a/drivers/comedi/drivers/jr3_pci.c
+++ b/drivers/comedi/drivers/jr3_pci.c
@@ -88,6 +88,7 @@ struct jr3_pci_poll_delay {
 struct jr3_pci_dev_private {
 	struct timer_list timer;
 	struct comedi_device *dev;
+	bool timer_enable;
 };
 
 union jr3_pci_single_range {
@@ -597,10 +598,11 @@ static void jr3_pci_poll_dev(struct timer_list *t)
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
@@ -749,6 +751,7 @@ static int jr3_pci_auto_attach(struct comedi_device *dev,
 	devpriv->dev = dev;
 	timer_setup(&devpriv->timer, jr3_pci_poll_dev, 0);
 	devpriv->timer.expires = jiffies + msecs_to_jiffies(1000);
+	devpriv->timer_enable = true;
 	add_timer(&devpriv->timer);
 
 	return 0;
@@ -758,8 +761,12 @@ static void jr3_pci_detach(struct comedi_device *dev)
 {
 	struct jr3_pci_dev_private *devpriv = dev->private;
 
-	if (devpriv)
-		del_timer_sync(&devpriv->timer);
+	if (devpriv) {
+		spin_lock_bh(&dev->spinlock);
+		devpriv->timer_enable = false;
+		spin_unlock_bh(&dev->spinlock);
+		timer_delete_sync(&devpriv->timer);
+	}
 
 	comedi_pci_detach(dev);
 }
-- 
2.47.2


