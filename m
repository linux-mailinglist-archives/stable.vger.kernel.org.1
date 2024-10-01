Return-Path: <stable+bounces-78422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A293598B991
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6846A281426
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B3E192D74;
	Tue,  1 Oct 2024 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sF3F8HCP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569E53209
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778332; cv=none; b=XPwLSNypoZx+HvbfaAfivCQdkpkzC1qGou5VaKlTXCGsRT1zWMPeXOg/WGPYXQ2MBVQED5nMOPlG70NRXUtPiJ0jgqz6dt1/lia5N2G4ilZ8hwQkGgh0Tmi7gaikiIgttz3ZwRDMk2LuFZbEXohTGMQ095sGKBhTo7HqjUEgzUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778332; c=relaxed/simple;
	bh=VT5hvuOYxX7chsEjrCD4KbOh20MgdvNlnKEtpQsT1o4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a2XfkxttbniS/xrBJA2xwPAadSjcSM3O1Z7tLPVlvVmzsj08aYWSLR5A3TauhYJg74sa776sG+/2awIs0Mn/gawHK+Wk4ysD1eOrWSa0yG+39b1iyJAbLIG5evAYABfCAo8BFACqal0q7DLW+iqOKjeuGyjcu9YdPJ7afKE4yh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sF3F8HCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24FBC4CEC6;
	Tue,  1 Oct 2024 10:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727778332;
	bh=VT5hvuOYxX7chsEjrCD4KbOh20MgdvNlnKEtpQsT1o4=;
	h=Subject:To:Cc:From:Date:From;
	b=sF3F8HCPH6qZ62YHMIIzFoCwbZZMuU9oPltnhUT6doxSvILp9PivroylfSmGwYdA4
	 H5RFLNdicBhjD028P5DpR4Ne3coowKXN8yCJDHi6YuShctAXv1+zoiLHoP+nqnZ3zN
	 XkuBq4kZY6PFfOvNJao81oHqs89WxqitXAquadDo=
Subject: FAILED: patch "[PATCH] xhci: Set quirky xHC PCI hosts to D3 _after_ stopping and" failed to apply to 5.10-stable tree
To: mathias.nyman@linux.intel.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 12:25:29 +0200
Message-ID: <2024100129-user-germicide-1db7@gregkh>
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
git cherry-pick -x f81dfa3b57c624c56f2bff171c431bc7f5b558f2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100129-user-germicide-1db7@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

f81dfa3b57c6 ("xhci: Set quirky xHC PCI hosts to D3 _after_ stopping and freeing them.")
884c27440829 ("usb: renesas-xhci: Remove renesas_xhci_pci_exit()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f81dfa3b57c624c56f2bff171c431bc7f5b558f2 Mon Sep 17 00:00:00 2001
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Date: Thu, 5 Sep 2024 17:32:59 +0300
Subject: [PATCH] xhci: Set quirky xHC PCI hosts to D3 _after_ stopping and
 freeing them.

PCI xHC host should be stopped and xhci driver memory freed before putting
host to PCI D3 state during PCI remove callback.

Hosts with XHCI_SPURIOUS_WAKEUP quirk did this the wrong way around
and set the host to D3 before calling usb_hcd_pci_remove(dev), which will
access the host to stop it, and then free xhci.

Fixes: f1f6d9a8b540 ("xhci: don't dereference a xhci member after removing xhci")
Cc: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20240905143300.1959279-12-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 526739af2070..de50f5ba60df 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -657,8 +657,10 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 void xhci_pci_remove(struct pci_dev *dev)
 {
 	struct xhci_hcd *xhci;
+	bool set_power_d3;
 
 	xhci = hcd_to_xhci(pci_get_drvdata(dev));
+	set_power_d3 = xhci->quirks & XHCI_SPURIOUS_WAKEUP;
 
 	xhci->xhc_state |= XHCI_STATE_REMOVING;
 
@@ -671,11 +673,11 @@ void xhci_pci_remove(struct pci_dev *dev)
 		xhci->shared_hcd = NULL;
 	}
 
-	/* Workaround for spurious wakeups at shutdown with HSW */
-	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
-		pci_set_power_state(dev, PCI_D3hot);
-
 	usb_hcd_pci_remove(dev);
+
+	/* Workaround for spurious wakeups at shutdown with HSW */
+	if (set_power_d3)
+		pci_set_power_state(dev, PCI_D3hot);
 }
 EXPORT_SYMBOL_NS_GPL(xhci_pci_remove, xhci);
 


