Return-Path: <stable+bounces-179784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 263FFB7D903
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD043B7BCB
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 07:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDC030147F;
	Wed, 17 Sep 2025 07:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PzALCC/K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3492F3C16
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 07:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095051; cv=none; b=G5y0HIINoV+NlhjsXNkh/gSDwCpACoavbzE8k9nkmW+OtoRC/Y1WHYIa550M5jdtVELqPyVDF2/H3h5iSTi+Xgvg1NtTdklgZOJrw8+MXps1lBafhFAkcfGVIqbMMcRfXcz/qf5iz3PDKUVfJBc3VkZ79Yv3FP1yHSAD3Gu5zZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095051; c=relaxed/simple;
	bh=Yo/D1FMCQ3cuqZH7GieRFm9glGiVBDrXzq7FGEbmEXI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Bph/LOeft0G0+xUT1gKooBGLg9Ca6NISpYgODaX1OcCV3uIqNMFZpmHwL4SgSrMCRy1wyvLECywps8WW+Txb/2Ix+uXtTzIOPh+tMXQ2PWVKL8ql5BQxMHvx/zInr0tHQ5x6w+RdEE/0VZ68/5yeATulEpMuWbzb6WQJwLq7tfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PzALCC/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FA9C4CEF0;
	Wed, 17 Sep 2025 07:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758095051;
	bh=Yo/D1FMCQ3cuqZH7GieRFm9glGiVBDrXzq7FGEbmEXI=;
	h=Subject:To:Cc:From:Date:From;
	b=PzALCC/KlUPO1wazyE9nlSQCkOv69vfr+6ra6QEAfZVauV2I9AU0C0z7jFeUOJdUX
	 l5FLYPYDwl2yN7NJHCFqtITBkX1eUx6/c0Ejt0vPG09Sxii4MRGjKmybQzob2k2zso
	 8dQljkRM30r8cMFxmXTQkGl9wJ0QI7TcR8EhY1CE=
Subject: FAILED: patch "[PATCH] xhci: fix memory leak regression when freeing xhci vdev" failed to apply to 5.15-stable tree
To: mathias.nyman@linux.intel.com,00107082@163.com,gregkh@linuxfoundation.org,michal.pecio@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 17 Sep 2025 09:43:57 +0200
Message-ID: <2025091757-filler-dispose-635b@gregkh>
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
git cherry-pick -x edcbe06453ddfde21f6aa763f7cab655f26133cc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091757-filler-dispose-635b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From edcbe06453ddfde21f6aa763f7cab655f26133cc Mon Sep 17 00:00:00 2001
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Date: Tue, 2 Sep 2025 13:53:06 +0300
Subject: [PATCH] xhci: fix memory leak regression when freeing xhci vdev
 devices depth first

Suspend-resume cycle test revealed a memory leak in 6.17-rc3

Turns out the slot_id race fix changes accidentally ends up calling
xhci_free_virt_device() with an incorrect vdev parameter.
The vdev variable was reused for temporary purposes right before calling
xhci_free_virt_device().

Fix this by passing the correct vdev parameter.

The slot_id race fix that caused this regression was targeted for stable,
so this needs to be applied there as well.

Fixes: 2eb03376151b ("usb: xhci: Fix slot_id resource race conflict")
Reported-by: David Wang <00107082@163.com>
Closes: https://lore.kernel.org/linux-usb/20250829181354.4450-1-00107082@163.com
Suggested-by: Michal Pecio <michal.pecio@gmail.com>
Suggested-by: David Wang <00107082@163.com>
Cc: stable@vger.kernel.org
Tested-by: David Wang <00107082@163.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20250902105306.877476-4-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 81eaad87a3d9..c4a6544aa107 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -962,7 +962,7 @@ static void xhci_free_virt_devices_depth_first(struct xhci_hcd *xhci, int slot_i
 out:
 	/* we are now at a leaf device */
 	xhci_debugfs_remove_slot(xhci, slot_id);
-	xhci_free_virt_device(xhci, vdev, slot_id);
+	xhci_free_virt_device(xhci, xhci->devs[slot_id], slot_id);
 }
 
 int xhci_alloc_virt_device(struct xhci_hcd *xhci, int slot_id,


