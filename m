Return-Path: <stable+bounces-154899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4A7AE1323
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FCE74A2933
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 05:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E1B1F09BF;
	Fri, 20 Jun 2025 05:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lGw8fEEd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC7E1DED53
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 05:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398111; cv=none; b=CWalX+rIq9xCWLvGfbEp4eJZLL7VP4Gv2bRdouP3PbRfVdq3BiA13Vu3TvZiPHdiiKGY3J/zJ+98/Ur5YJWGFa4VFmkfup5uP/jSEEna809uJXmF9KJDo1vnHMe4bXsmCzhKuRnKv125KLO95Z3ZQj49LKAUq3lAyZs9z2bOTGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398111; c=relaxed/simple;
	bh=b2vVkqUtciCeDCDNgbSvvCQ+G+vdKHiF/bXDOKgPu3g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UxiePr6I2LGxMWHnF868oFG1zTHM738RMfFkmKoohdGEmkfeZaYyPRPALy7tiGDKJZSliu03CH8X4e12t40K1QMKufyq87bcLFVe8STtJFel2AJKjDzUKypazNUVwm9oDpDhivnUSuP1nNYL/WAWkLH4+uoH2kcJYTfnkXUWIfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lGw8fEEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48090C4CEE3;
	Fri, 20 Jun 2025 05:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750398111;
	bh=b2vVkqUtciCeDCDNgbSvvCQ+G+vdKHiF/bXDOKgPu3g=;
	h=Subject:To:Cc:From:Date:From;
	b=lGw8fEEdm6Sy2EbER+rwtzNCx5oh0IIN9t9PHXL+xFvJyrtME7rq7dYO/NN5ZHYfp
	 l8svax7N+R1PgQnpFZ6c1MulHScLVHRg0l80Tu9jOKXPZzuQbw4os8sXW4SvFssuJR
	 dCMJl6ZOBcylaPV093PmAzH+c/Mwaulqg5KP97tM=
Subject: FAILED: patch "[PATCH] s390/pci: Remove redundant bus removal and disable from" failed to apply to 5.15-stable tree
To: schnelle@linux.ibm.com,gbayer@linux.ibm.com,hca@linux.ibm.com,julianr@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 07:41:39 +0200
Message-ID: <2025062039-ligament-subtract-d8af@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d76f9633296785343d45f85199f4138cb724b6d2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062039-ligament-subtract-d8af@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d76f9633296785343d45f85199f4138cb724b6d2 Mon Sep 17 00:00:00 2001
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Thu, 22 May 2025 14:13:12 +0200
Subject: [PATCH] s390/pci: Remove redundant bus removal and disable from
 zpci_release_device()

Remove zpci_bus_remove_device() and zpci_disable_device() calls from
zpci_release_device(). These calls were done when the device
transitioned into the ZPCI_FN_STATE_STANDBY state which is guaranteed to
happen before it enters the ZPCI_FN_STATE_RESERVED state. When
zpci_release_device() is called the device is known to be in the
ZPCI_FN_STATE_RESERVED state which is also checked by a WARN_ON().

Cc: stable@vger.kernel.org
Fixes: a46044a92add ("s390/pci: fix zpci_zdev_put() on reserve")
Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
Tested-by: Gerd Bayer <gbayer@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 5bbdc4190b8b..9fcc6d3180f2 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -949,12 +949,6 @@ void zpci_release_device(struct kref *kref)
 
 	WARN_ON(zdev->state != ZPCI_FN_STATE_RESERVED);
 
-	if (zdev->zbus->bus)
-		zpci_bus_remove_device(zdev, false);
-
-	if (zdev_enabled(zdev))
-		zpci_disable_device(zdev);
-
 	if (zdev->has_hp_slot)
 		zpci_exit_slot(zdev);
 


