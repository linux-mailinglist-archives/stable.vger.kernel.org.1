Return-Path: <stable+bounces-179782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC9CB7DA04
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8EE21B27509
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 07:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B17D2882DB;
	Wed, 17 Sep 2025 07:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c6xP1mZo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9282877D8
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 07:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095040; cv=none; b=BF09bw8+dxO7ay3jkm8yMV0H6pnJrDDyEtxg4dbHtYrtBxOz63xHCcN8H4FIArjw/PD93LlqZ2Ja1pPQanNeYBqoEoPurUkOipwHm9a0KQI8mJfA+KjEmBEgNRQwZHynVkaM4it+iSpw6X6W+q8OXu2r6QQhgWXhjhBwb0xZsQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095040; c=relaxed/simple;
	bh=+TguVmfQIXoXRdHeRWlVyYbpHIEjblPJzJvrJyAHar0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=N/SRTeQzhD/2TJDZ8XpiRSBLsghA5dKV1wIMRYrsjZ+AqWL3Ii4ahnbmI09a/2TBTt59qeTZS+Jq6RrXYVAnCLN7El9NUSFijFsn4FTnzkUCqc85+fL61dhUq9eUBeIYY9/F3FRUyoRWDD3T0Hyk17MA0cIyTnQ7cS/sHUoGVBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c6xP1mZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F944C4CEF0;
	Wed, 17 Sep 2025 07:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758095040;
	bh=+TguVmfQIXoXRdHeRWlVyYbpHIEjblPJzJvrJyAHar0=;
	h=Subject:To:Cc:From:Date:From;
	b=c6xP1mZoyDstG55kz81VAugjzQHpBifWbGxnyg07BONILAekOuuGfuPML9lG0scIk
	 k1wG5eXOCiQKHG4pppd1XVGpaNKtARMQTQ9QrZNiQz/lVx3r6QKk0OXUw8mCYiPcpv
	 CzZ8SHu+aDuEx47TzwEAcrBt8CRem3PQpdf2DzuY=
Subject: FAILED: patch "[PATCH] xhci: fix memory leak regression when freeing xhci vdev" failed to apply to 6.1-stable tree
To: mathias.nyman@linux.intel.com,00107082@163.com,gregkh@linuxfoundation.org,michal.pecio@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 17 Sep 2025 09:43:56 +0200
Message-ID: <2025091756-outskirts-monetize-6f6b@gregkh>
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
git cherry-pick -x edcbe06453ddfde21f6aa763f7cab655f26133cc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091756-outskirts-monetize-6f6b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


