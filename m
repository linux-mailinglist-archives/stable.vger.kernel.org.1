Return-Path: <stable+bounces-137098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9ECBAA0DFD
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 15:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242751699E6
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 13:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51292C375E;
	Tue, 29 Apr 2025 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="O+uYyik2"
X-Original-To: stable@vger.kernel.org
Received: from smtp64.iad3a.emailsrvr.com (smtp64.iad3a.emailsrvr.com [173.203.187.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED302210F5D
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745935010; cv=none; b=KjAdXpiirifxiXzQNzVQU2ReevR9gnIYmPo8tJflBa0+TdKafebp8YlqLWqayvRS5QAxhiX/bp9kqaMzJIxBZ9s2zCiYFbIodWWPyL82I8mTydHQ6lA5DhzvvM5BhvBfU3IrtVdNoImuh49Ms8aH0CH91rrf6swaB+iK4Hzha6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745935010; c=relaxed/simple;
	bh=P6WoS9ksbwwQ/DijZwAmYXwwbzf1iRwmsVXboH7mbks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9SqOU1ynJUmxA06ARtuVXPwcecIcp2i+bKHubZiYLIp8JvlzY45zl8uSv3J4Ffg5wzfYhrVMrCuqoJ3648WLFxrCCNkPd2i1gXo4xkZgkf1jMm3th4TZ4YFt1w5NN0jErWEn6UC7V7HQO8NZHpZ3aWDkepWCCIBmMbJJxMaTfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=O+uYyik2; arc=none smtp.client-ip=173.203.187.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1745930294;
	bh=P6WoS9ksbwwQ/DijZwAmYXwwbzf1iRwmsVXboH7mbks=;
	h=From:To:Subject:Date:From;
	b=O+uYyik27528CJmZXkWhVk6HWvrYxt89FMbrCuG8i+0YHMNB2B84ACQTh3xhPA1Rc
	 3EdMVLxJBOSDYEKGIlbL5NCR0UShY5G5Ftg7SXzwpPjc7OXryPLPzU9YhYUaf0juWB
	 PRmtLE6cfL0yLZWMSGYolGHRFZWrjMAmGM7s68d4=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp17.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id C4AE425E15;
	Tue, 29 Apr 2025 08:38:13 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.10.y] comedi: jr3_pci: Fix synchronous deletion of timer
Date: Tue, 29 Apr 2025 13:38:05 +0100
Message-ID: <20250429123806.532340-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <2025042808-difficult-germicide-075a@gregkh>
References: <2025042808-difficult-germicide-075a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 6d89ea43-cb57-4068-804e-8fb78ac3fe6d-1-1

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
index 7a02c4fa3cda..cc1232609f32 100644
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


