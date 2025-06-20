Return-Path: <stable+bounces-154902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B20FAE1329
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543DF3A9CE4
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 05:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5442C1F09BF;
	Fri, 20 Jun 2025 05:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AhEhb3WM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1518E1DED53
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 05:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398124; cv=none; b=A6msO+y6IZcRC5KS8bBVi3Vmnr/c7bgHjW9Hh6l0S5HywOL2D+a/2w7ZsxQLvfVe3sNTLJHef+3YTScwJjYr8jYflomSH7vAvh9Huoir49J0YVgNQu7Au3C/M4eL6bLPCSC7QGluKkQ+qQ5+jiAKlJJmwu53Pij8ZPuOkpo+Nt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398124; c=relaxed/simple;
	bh=OXtnButRSefGSg0xiMhFHNVr1GttZUNwn58djmRBY3o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tqodNegLEFTptRq3ypdxd/+/FMomAY3/uY5UCE7fkBxRkZ2URSjFjblNn16PgnKvY9dqY9yg0RREOrfBG5Doy9ufWyIA9vlSN4888B8h5zvWliX0ytzPFTvL2GjiaUSDj6MQVerfCGU0fGCeQG8t5lEBR/iwk4UQ/IUEPrmMFzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AhEhb3WM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A7DC4CEE3;
	Fri, 20 Jun 2025 05:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750398123;
	bh=OXtnButRSefGSg0xiMhFHNVr1GttZUNwn58djmRBY3o=;
	h=Subject:To:Cc:From:Date:From;
	b=AhEhb3WMVvzb9Pw4yBydtDNV4I+OKyOHPgSE17QDxov5QvXf+CH6+CAbeBB9c7elF
	 JJQ+5H1G+cxMuJ1IuJ1IpdmmWbMswvXiiTOhtUznigjZabQZNjahIOpnsxICHGyj1/
	 j0vFIRoQsZbZENp6jbVP9iHKqgB9vvHrt/oa4T6c=
Subject: FAILED: patch "[PATCH] s390/pci: Prevent self deletion in disable_slot()" failed to apply to 6.6-stable tree
To: schnelle@linux.ibm.com,gbayer@linux.ibm.com,hca@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 07:41:52 +0200
Message-ID: <2025062052-deviate-fetal-1fef@gregkh>
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
git cherry-pick -x 47c397844869ad0e6738afb5879c7492f4691122
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062052-deviate-fetal-1fef@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 47c397844869ad0e6738afb5879c7492f4691122 Mon Sep 17 00:00:00 2001
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Thu, 22 May 2025 14:13:13 +0200
Subject: [PATCH] s390/pci: Prevent self deletion in disable_slot()

As disable_slot() takes a struct zpci_dev from the Configured to the
Standby state. In Standby there is still a hotplug slot so this is not
usually a case of sysfs self deletion. This is important because self
deletion gets very hairy in terms of locking (see for example
recover_store() in arch/s390/pci/pci_sysfs.c).

Because the pci_dev_put() is not within the critical section of the
zdev->state_lock however, disable_slot() can turn into a case of self
deletion if zPCI device event handling slips between the mutex_unlock()
and the pci_dev_put(). If the latter is the last put and
zpci_release_device() is called this then tries to remove the hotplug
slot via zpci_exit_slot() which will try to remove the hotplug slot
directory the disable_slot() is part of i.e. self deletion.

Prevent this by widening the zdev->state_lock critical section to
include the pci_dev_put() which is then guaranteed to happen with the
struct zpci_dev still in Standby state ensuring it will not lead to
a zpci_release_device() call as at least the zPCI event handling code
still holds a reference.

Cc: stable@vger.kernel.org
Fixes: a46044a92add ("s390/pci: fix zpci_zdev_put() on reserve")
Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
Tested-by: Gerd Bayer <gbayer@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

diff --git a/drivers/pci/hotplug/s390_pci_hpc.c b/drivers/pci/hotplug/s390_pci_hpc.c
index 055518ee354d..3d26d273f29d 100644
--- a/drivers/pci/hotplug/s390_pci_hpc.c
+++ b/drivers/pci/hotplug/s390_pci_hpc.c
@@ -66,9 +66,9 @@ static int disable_slot(struct hotplug_slot *hotplug_slot)
 
 	rc = zpci_deconfigure_device(zdev);
 out:
-	mutex_unlock(&zdev->state_lock);
 	if (pdev)
 		pci_dev_put(pdev);
+	mutex_unlock(&zdev->state_lock);
 	return rc;
 }
 


