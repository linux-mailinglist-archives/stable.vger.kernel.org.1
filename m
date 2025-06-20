Return-Path: <stable+bounces-154900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7013AE1324
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903354A28FD
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 05:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A5D1F09BF;
	Fri, 20 Jun 2025 05:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cvMnIV5T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171B61DED53
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 05:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398115; cv=none; b=jzA0ewRoItA21ucCFk64pYs1MdFfYsqCI0XOsZ/A4LMQbtMZDvbPV5e7s1ELGnxgbb2DGu00rqPmzvdhZOmr8RFnWSFcwff9IqftvAimCQp0rrb5za5NG8ko39d9POe8bbXw0ZM9QCXfCttsYhtTdf1h3XxWDMBvQrewhHw1e4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398115; c=relaxed/simple;
	bh=brpFwo5T9PizCpPYLi5FzBqfIt/enoeISW2Fo4iaxtA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oYTIHod3Yd7UrfrSt6Qkjm2IrAkrZz1GH0SoTkOkQBbgbnYkYynwz3EzKRV7tSzSPDds0d8y8JPlxEDkDj8xfXmXJ8Y7ZVI5gm3XWYi9eWEcddNaLUxwVl5KtfLZe3OHTdbunBfMO616L7EtwHFZnjzFds0N0zuadf1eYluXI4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cvMnIV5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73833C4CEE3;
	Fri, 20 Jun 2025 05:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750398114;
	bh=brpFwo5T9PizCpPYLi5FzBqfIt/enoeISW2Fo4iaxtA=;
	h=Subject:To:Cc:From:Date:From;
	b=cvMnIV5TJeIMpmnMZJl2DbuiIa9ziAWXE2BWPoCF96dBVog+sXL4fqt4KbjwL33no
	 SjHZrOwngkchjhR3Rj+keNmlD/S1Y6pTmZoRWR2r0TShl/8bDjeIIG7FNTwiMiV4VA
	 1yy1iEH0SXrHs+qK16WdzzhavnPwYFnxw0D28UkY=
Subject: FAILED: patch "[PATCH] s390/pci: Remove redundant bus removal and disable from" failed to apply to 6.1-stable tree
To: schnelle@linux.ibm.com,gbayer@linux.ibm.com,hca@linux.ibm.com,julianr@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 07:41:39 +0200
Message-ID: <2025062039-unnerving-tasting-63f1@gregkh>
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
git cherry-pick -x d76f9633296785343d45f85199f4138cb724b6d2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062039-unnerving-tasting-63f1@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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
 


