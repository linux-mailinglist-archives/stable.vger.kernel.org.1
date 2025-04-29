Return-Path: <stable+bounces-137057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF95AA0ADA
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 13:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C745F16F945
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 11:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ABC29DB99;
	Tue, 29 Apr 2025 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="e+MkDo1j"
X-Original-To: stable@vger.kernel.org
Received: from smtp109.iad3a.emailsrvr.com (smtp109.iad3a.emailsrvr.com [173.203.187.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02225258CE9
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 11:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745927511; cv=none; b=M4K/ky7jOiPL+SRDtzjQyxuV2aqnnmS8r8LAAmyhiyxU8+N02pONj7UwtBpxgTs6JiHp/nF6G7XjU2ws8r6OAYJ464k88iJRbFG0X9knpbhDcm/Ie8AYwg35klenX9X4uqMTl2DM+53w7kznfdyS/+qB6lM8fCY2Pp3rEtgrUS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745927511; c=relaxed/simple;
	bh=62H8mfQhhUDvyTvchRYFFUbvoDWe8dkhDspFhn4Kbis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWYWOT3Ng/5ZdivFWL+o/vcChH9WZgKmL52LbcH3lx3mPdavxEqliccUMsTyMqnSGCCIpi1wpDRTWk0B40/lTrLi/Ot1MZVgqI+eOwFAj+7Vep5zB5tPF1cbiHffAX+bibGEd5f8DWW0tPM4b9tUQ13B1TItI5H4xJ1h9OTT2KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=e+MkDo1j; arc=none smtp.client-ip=173.203.187.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1745926469;
	bh=62H8mfQhhUDvyTvchRYFFUbvoDWe8dkhDspFhn4Kbis=;
	h=From:To:Subject:Date:From;
	b=e+MkDo1jKtNE2QJfv9r9NJQS2vuXcniDr/tD5knRqlZaoXCPtsCmqb9gc+9NJIPVw
	 1W5YwwWkMRQBvpbjVAheiyoMUKOswsDDpigwxlaOZjjqHcy6wOF+G7vtT1P9z8klWN
	 5c5y98Cd9te2qRDmiVhpS39SzwTiWR6Aa5Kh0PVc=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp14.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id A3F86239FD;
	Tue, 29 Apr 2025 07:34:28 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.1.y] comedi: jr3_pci: Fix synchronous deletion of timer
Date: Tue, 29 Apr 2025 12:34:20 +0100
Message-ID: <20250429113420.288397-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <2025042807-emcee-squealing-c022@gregkh>
References: <2025042807-emcee-squealing-c022@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 4d809336-b39d-4481-aeb0-bf905bc3ffa5-1-1

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
index 951c23fa0369..88f1e7862614 100644
--- a/drivers/comedi/drivers/jr3_pci.c
+++ b/drivers/comedi/drivers/jr3_pci.c
@@ -87,6 +87,7 @@ struct jr3_pci_poll_delay {
 struct jr3_pci_dev_private {
 	struct timer_list timer;
 	struct comedi_device *dev;
+	bool timer_enable;
 };
 
 union jr3_pci_single_range {
@@ -596,10 +597,11 @@ static void jr3_pci_poll_dev(struct timer_list *t)
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
@@ -748,6 +750,7 @@ static int jr3_pci_auto_attach(struct comedi_device *dev,
 	devpriv->dev = dev;
 	timer_setup(&devpriv->timer, jr3_pci_poll_dev, 0);
 	devpriv->timer.expires = jiffies + msecs_to_jiffies(1000);
+	devpriv->timer_enable = true;
 	add_timer(&devpriv->timer);
 
 	return 0;
@@ -757,8 +760,12 @@ static void jr3_pci_detach(struct comedi_device *dev)
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


