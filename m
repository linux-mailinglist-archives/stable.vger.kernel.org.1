Return-Path: <stable+bounces-136924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29670A9F702
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 19:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6F0189A667
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 17:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88B323370C;
	Mon, 28 Apr 2025 17:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uqS+QTkc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613E82820B3
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 17:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860407; cv=none; b=FwNYaIbbxzVOKmRrfmj/7f5ePjdk/bTB4NSNfEROo1/tdH6yKChgnC7N2aKDN0hg5GKObhOsLJRZCENtq93A7DzHdYQpkhZwK2dXKc0Ne0H6jlO56SNQiFNGwzuilase+bei+noxnH1ZUHASbWsNQSzC6hX27jqQa3QbnwAP2Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860407; c=relaxed/simple;
	bh=CJ68BBGmjkvXJvR7ekw+GAqNZs3kAED/lIZYC8Mq3gg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JOMkLY1tOrTnpr0zMaCAYr84/idmJCOnsdVB1VfZ0320jgrbOwF8wppgoptmu+WrsjhOT8ML+8oZN0EgOWkSsV64Y8H4k8qFmn3omK76Sky/tjpIzgiOxs78QFFR0AB+PvhOMO+cL3pkLNEYJRVVsNqbEEriWk0ZF0XUyc1JRu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uqS+QTkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDBDC4CEE4;
	Mon, 28 Apr 2025 17:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745860406;
	bh=CJ68BBGmjkvXJvR7ekw+GAqNZs3kAED/lIZYC8Mq3gg=;
	h=Subject:To:Cc:From:Date:From;
	b=uqS+QTkcWXfO3gW8M/xU73e3DYDf17imOqUZ9TL1XGs/MUV3WUkOFORcg5Hnikptu
	 Nv4TTNbXA6of4fb/LD7pEd9zNI8mDzXaFHBTjHNxxW+a7NBjYq+2/Q5KePt8cARqGz
	 cajhokS5nZrJLW3Y5W9vx/Ai8t+3qJDhkH74XaB4=
Subject: FAILED: patch "[PATCH] comedi: jr3_pci: Fix synchronous deletion of timer" failed to apply to 6.1-stable tree
To: abbotti@mev.co.uk,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Apr 2025 19:13:07 +0200
Message-ID: <2025042807-emcee-squealing-c022@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 44d9b3f584c59a606b521e7274e658d5b866c699
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042807-emcee-squealing-c022@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 44d9b3f584c59a606b521e7274e658d5b866c699 Mon Sep 17 00:00:00 2001
From: Ian Abbott <abbotti@mev.co.uk>
Date: Tue, 15 Apr 2025 13:39:01 +0100
Subject: [PATCH] comedi: jr3_pci: Fix synchronous deletion of timer

When `jr3_pci_detach()` is called during device removal, it calls
`timer_delete_sync()` to stop the timer, but the timer expiry function
always reschedules the timer, so the synchronization is ineffective.

Call `timer_shutdown_sync()` instead.  It does not matter that the timer
expiry function pointer is cleared, because the device is being removed.

Fixes: 07b509e6584a5 ("Staging: comedi: add jr3_pci driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20250415123901.13483-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/comedi/drivers/jr3_pci.c b/drivers/comedi/drivers/jr3_pci.c
index cdc842b32bab..75dce1ff2419 100644
--- a/drivers/comedi/drivers/jr3_pci.c
+++ b/drivers/comedi/drivers/jr3_pci.c
@@ -758,7 +758,7 @@ static void jr3_pci_detach(struct comedi_device *dev)
 	struct jr3_pci_dev_private *devpriv = dev->private;
 
 	if (devpriv)
-		timer_delete_sync(&devpriv->timer);
+		timer_shutdown_sync(&devpriv->timer);
 
 	comedi_pci_detach(dev);
 }


