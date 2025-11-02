Return-Path: <stable+bounces-192052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B29C28FFE
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 14:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88ADF3A94C9
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 13:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9811F2BAD;
	Sun,  2 Nov 2025 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o1VE7vzq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B68E1EEA5F
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762091798; cv=none; b=AkyVz7/KJqK3oXlPPJIj9+iap1tteGgChLVNf+aeSfOLYHyRZtH/kksD0gu7034gUR16Y4f637mo+l2FsHPhxZXo0ysH4tWdouFJCsQX1X6J45vO6KLcBft5LyBTBuPHFbnRxcWi91PTCOK92whf6ugdu/V1xt60lEK+/UdO2vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762091798; c=relaxed/simple;
	bh=c6gMGVPdVNHXnmzThO2lb/j/9OsKM8R1uzdvzAH/0eU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DJ3go7Fbg37Bzm2Fe7HtWQdUS9F3Y2Xqkzh3XqVD7l5fVEMLw/IRYYQh3kB2d+mJa0Ahj7Qa65LGn7u+PxmBwkIRAyelCom1tK6RU0PZlNLdIy1AsD7pJjivN/x16Qyqt/vpnXxjzQx42Zh2YpskyW9nQbxCfoqCKPmNog48eLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o1VE7vzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D10FC4CEF7;
	Sun,  2 Nov 2025 13:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762091797;
	bh=c6gMGVPdVNHXnmzThO2lb/j/9OsKM8R1uzdvzAH/0eU=;
	h=Subject:To:Cc:From:Date:From;
	b=o1VE7vzqPexcEYdJGW5ATTKR2l1veYRBSKGZoIjSavMh2T59QgR9ItP5oDIpBG9fJ
	 Hlo7Hr9kGIY0+A9yAODx8KUdmIXIf0W39oD/y3IifsIr5QyxA9nkZbho7y5xKg2sSW
	 TPxzqiUUNZtvcFeGZHcqyUVOo+aJICDMZnGqM3CE=
Subject: FAILED: patch "[PATCH] s390/pci: Restore IRQ unconditionally for the zPCI device" failed to apply to 6.6-stable tree
To: alifm@linux.ibm.com,hca@linux.ibm.com,mjrosato@linux.ibm.com,schnelle@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 02 Nov 2025 22:56:34 +0900
Message-ID: <2025110234-parameter-underdog-10cd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x b45873c3f09153d1ad9b3a7bf9e5c0b0387fd2ea
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110234-parameter-underdog-10cd@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b45873c3f09153d1ad9b3a7bf9e5c0b0387fd2ea Mon Sep 17 00:00:00 2001
From: Farhan Ali <alifm@linux.ibm.com>
Date: Wed, 22 Oct 2025 09:47:26 -0700
Subject: [PATCH] s390/pci: Restore IRQ unconditionally for the zPCI device

Commit c1e18c17bda6 ("s390/pci: add zpci_set_irq()/zpci_clear_irq()"),
introduced the zpci_set_irq() and zpci_clear_irq(), to be used while
resetting a zPCI device.

Commit da995d538d3a ("s390/pci: implement reset_slot for hotplug
slot"), mentions zpci_clear_irq() being called in the path for
zpci_hot_reset_device().  But that is not the case anymore and these
functions are not called outside of this file. Instead
zpci_hot_reset_device() relies on zpci_disable_device() also clearing
the IRQs, but misses to reset the zdev->irqs_registered flag.

However after a CLP disable/enable reset, the device's IRQ are
unregistered, but the flag zdev->irq_registered does not get cleared. It
creates an inconsistent state and so arch_restore_msi_irqs() doesn't
correctly restore the device's IRQ. This becomes a problem when a PCI
driver tries to restore the state of the device through
pci_restore_state(). Restore IRQ unconditionally for the device and remove
the irq_registered flag as its redundant.

Fixes: c1e18c17bda6 ("s390/pci: add zpci_set_irq()/zpci_clear_irq()")
Cc: stable@vger.kernnel.org
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 6890925d5587..a32f465ecf73 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -145,7 +145,6 @@ struct zpci_dev {
 	u8		has_resources	: 1;
 	u8		is_physfn	: 1;
 	u8		util_str_avail	: 1;
-	u8		irqs_registered	: 1;
 	u8		tid_avail	: 1;
 	u8		rtr_avail	: 1; /* Relaxed translation allowed */
 	unsigned int	devfn;		/* DEVFN part of the RID*/
diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 84482a921332..e73be96ce5fe 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -107,9 +107,6 @@ static int zpci_set_irq(struct zpci_dev *zdev)
 	else
 		rc = zpci_set_airq(zdev);
 
-	if (!rc)
-		zdev->irqs_registered = 1;
-
 	return rc;
 }
 
@@ -123,9 +120,6 @@ static int zpci_clear_irq(struct zpci_dev *zdev)
 	else
 		rc = zpci_clear_airq(zdev);
 
-	if (!rc)
-		zdev->irqs_registered = 0;
-
 	return rc;
 }
 
@@ -427,8 +421,7 @@ bool arch_restore_msi_irqs(struct pci_dev *pdev)
 {
 	struct zpci_dev *zdev = to_zpci(pdev);
 
-	if (!zdev->irqs_registered)
-		zpci_set_irq(zdev);
+	zpci_set_irq(zdev);
 	return true;
 }
 


