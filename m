Return-Path: <stable+bounces-96088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D939E06D4
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7FD289164
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD94F20A5F4;
	Mon,  2 Dec 2024 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JK3tkMRi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C9B20A5ED
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152741; cv=none; b=aBTWT8xlgoDSjm+a0HN6x0evt8OkgjgaBFPHK7E7H8poZAriB1+yACHurT0VqBN+7ITduCSgZICsPeM7PkunIWn7JTXUNddaGRh9Gc36zq+cfdsoz2alZ+KVGzFpsDUMzyZ4E4R23I2BRKxiYgE0pzeSr33SUOVtH+fLI/B3LEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152741; c=relaxed/simple;
	bh=AjLZjFw6dD+rFwrTWBlo2DOeVZRw8hUFdrTylKGyXcg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mofDNtKaKoF7EzjXgQXGQ2dNLgTOpuDPb8ZhFCbdY0YchwxFCWyU5fOblK3AM9fs6/gYjU8fd31Dawilay9EtDJEWlHjy4xhcPp96w1M6C4BIGpn0QwheqzDY9e3eNM2H9hwaPpspfg7Vm1SAt/7i673HqQiIYmGTg/HX7TtSfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JK3tkMRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E83C4CED2;
	Mon,  2 Dec 2024 15:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733152741;
	bh=AjLZjFw6dD+rFwrTWBlo2DOeVZRw8hUFdrTylKGyXcg=;
	h=Subject:To:Cc:From:Date:From;
	b=JK3tkMRixakJ7sWGRVUDdNORBRK/deaNGnJ2M8GhLU9/u/ujXMM+jUp17+o483ziR
	 qylX4NoDHsjLaS/IioIZMly41p+E1dFXHpM3JWshYKEjneErfkVFdX6SHVsoQesbiF
	 l9uj3KMxnaDjouP9t79eMXSR7QDF/YjoNwBUY0kM=
Subject: FAILED: patch "[PATCH] xhci: Combine two if statements for Etron xHCI host" failed to apply to 5.15-stable tree
To: ki.chiang65@gmail.com,gregkh@linuxfoundation.org,mathias.nyman@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Dec 2024 16:18:50 +0100
Message-ID: <2024120250-wok-batboy-aebc@gregkh>
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
git cherry-pick -x d7b11fe5790203fcc0db182249d7bfd945e44ccb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120250-wok-batboy-aebc@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d7b11fe5790203fcc0db182249d7bfd945e44ccb Mon Sep 17 00:00:00 2001
From: Kuangyi Chiang <ki.chiang65@gmail.com>
Date: Wed, 6 Nov 2024 12:14:43 +0200
Subject: [PATCH] xhci: Combine two if statements for Etron xHCI host

Combine two if statements, because these hosts have the same
quirk flags applied.

[Mathias: has stable tag because other fixes in series depend on this]

Fixes: 91f7a1524a92 ("xhci: Apply broken streams quirk to Etron EJ188 xHCI host")
Cc: stable@vger.kernel.org
Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20241106101459.775897-18-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 7803ff1f1c9f..db3c7e738213 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -394,12 +394,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
 	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
-			pdev->device == PCI_DEVICE_ID_EJ168) {
-		xhci->quirks |= XHCI_RESET_ON_RESUME;
-		xhci->quirks |= XHCI_BROKEN_STREAMS;
-	}
-	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
-			pdev->device == PCI_DEVICE_ID_EJ188) {
+	    (pdev->device == PCI_DEVICE_ID_EJ168 ||
+	     pdev->device == PCI_DEVICE_ID_EJ188)) {
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 	}


