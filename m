Return-Path: <stable+bounces-154905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4249BAE1328
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95A9C7A72DE
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 05:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132BC1EFF92;
	Fri, 20 Jun 2025 05:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JPdHOOzX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F941DED53
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 05:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398132; cv=none; b=UfcUNUAnv5rSZxs0xNf3R8O0p6SDZrG2k7XXAop+N09QcGcywwWNucqBECuNStt4dyimCbgvLIu5/WbTc+Tf6d5ZSTkAjWPxqnhvyPX3XRn54MhG8k7aqnWwxd/jojt6X7YMJ3MPgXzbXs8J5YWF8bp9Sbyw83LgA+RbpJwPO2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398132; c=relaxed/simple;
	bh=Zaq5U8gay9Qw+4tUR/OH7aQw5+tupWer23b74I2YVME=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FIsH5AFe7VW01uygdMH85dbkpUnOd7rnHHx7gdbzgUyN0Y50AIVO3msj8KPK3KnuGwktIQnjQj2+UpVXWZu/w1lHPLb+nqh5H0dHYtl30l8M/YrOzDyTm+HVKwMj0ddced8b+W1YbhPjJbxAT34nFFhrpw2DFqSmKWA7v4kRBtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JPdHOOzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45ED7C4CEE3;
	Fri, 20 Jun 2025 05:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750398132;
	bh=Zaq5U8gay9Qw+4tUR/OH7aQw5+tupWer23b74I2YVME=;
	h=Subject:To:Cc:From:Date:From;
	b=JPdHOOzXYpv+S/J6T7XGC5uH1Xx81spDptIw3Z10UkB6BrqvOxk/sOiE0h+PE2vWr
	 REYv02pPXLBUYTTT2GDWwWCq5bTrSRCSqSO9g+NkqJik+6LdUqar2+09GiT99EyMFo
	 QI8DSgDNtoGtQROhiBHOpe6sqNb2pfoUD9bY4bxE=
Subject: FAILED: patch "[PATCH] s390/pci: Prevent self deletion in disable_slot()" failed to apply to 5.10-stable tree
To: schnelle@linux.ibm.com,gbayer@linux.ibm.com,hca@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 07:41:55 +0200
Message-ID: <2025062055-throttle-abide-0845@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 47c397844869ad0e6738afb5879c7492f4691122
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062055-throttle-abide-0845@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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
 


