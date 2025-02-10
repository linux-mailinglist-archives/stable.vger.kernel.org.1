Return-Path: <stable+bounces-114588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAB5A2EEFC
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8414D7A2299
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086F522E406;
	Mon, 10 Feb 2025 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KhidOPOZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8C5230998
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195763; cv=none; b=tDyWv1OuZGdkLa3XvL52SmjLIsW8rngWYaBwJnLTNQwdz0pSMGel9+WynwHAxZRFQ0g2gYiEvj9XmB8e3R0ef2ntHunmy9FrAhqdFGT8RhOaNmOFAAhvat2lKUvyDJmdITHRn5dleDuQomehP67bfPZ3YN0qZOn0fCyXAnPD7jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195763; c=relaxed/simple;
	bh=5LkIGzhc0rKCTq6NzEBMayZ9yKGFApAkVil0cRG/OOE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZDkE/yXedXP21Xim+ah1YhddzxIUzHrpTk7lE8dMP3+/OTYPmVvE/oBBnFR3jgEgEGuyhsB/8q3hfSSAjUehNCzveuwHaLQpYAlNBb0Sn7BMhQ7VsU2MJzvz8myeo9+U2jd0046NXYedwCtaQ+b4gTYHxDX4HeysElNkJoF8pXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KhidOPOZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88895C4CED1;
	Mon, 10 Feb 2025 13:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739195763;
	bh=5LkIGzhc0rKCTq6NzEBMayZ9yKGFApAkVil0cRG/OOE=;
	h=Subject:To:Cc:From:Date:From;
	b=KhidOPOZ5Ys6+i5xVK38BUz+svAeen2symPIm6k4MWk/yrF9r2uijS/hebjtUu+XW
	 jIoAlibNbzH6T/6lMvXWgOlthxjqknt2O2jS6HC1G0+yJ79b6o2AWFNAkfhR4W5yv0
	 C4dhfM/HWR+8xW3ZqGjrlUwQaueg8KYoM8ZvCmv0=
Subject: FAILED: patch "[PATCH] PCI: dwc: ep: Prevent changing BAR size/flags in" failed to apply to 6.6-stable tree
To: cassel@kernel.org,kwilczynski@kernel.org,manivannan.sadhasivam@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:55:44 +0100
Message-ID: <2025021044-cruelly-backpack-4cb2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 3708acbd5f169ebafe1faa519cb28adc56295546
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021044-cruelly-backpack-4cb2@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3708acbd5f169ebafe1faa519cb28adc56295546 Mon Sep 17 00:00:00 2001
From: Niklas Cassel <cassel@kernel.org>
Date: Fri, 13 Dec 2024 15:33:03 +0100
Subject: [PATCH] PCI: dwc: ep: Prevent changing BAR size/flags in
 pci_epc_set_bar()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In commit 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update
inbound map address") set_bar() was modified to support dynamically
changing the backing physical address of a BAR that was already configured.

This means that set_bar() can be called twice, without ever calling
clear_bar() (as calling clear_bar() would clear the BAR's PCI address
assigned by the host).

This can only be done if the new BAR size/flags does not differ from the
existing BAR configuration. Add these missing checks.

If we allow set_bar() to set e.g. a new BAR size that differs from the
existing BAR size, the new address translation range will be smaller than
the BAR size already determined by the host, which would mean that a read
past the new BAR size would pass the iATU untranslated, which could allow
the host to read memory not belonging to the new struct pci_epf_bar.

While at it, add comments which clarifies the support for dynamically
changing the physical address of a BAR. (Which was also missing.)

Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
Link: https://lore.kernel.org/r/20241213143301.4158431-10-cassel@kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: stable@vger.kernel.org

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index bad588ef69a4..44a617d54b15 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -222,8 +222,28 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	if ((flags & PCI_BASE_ADDRESS_MEM_TYPE_64) && (bar & 1))
 		return -EINVAL;
 
-	if (ep->epf_bar[bar])
+	/*
+	 * Certain EPF drivers dynamically change the physical address of a BAR
+	 * (i.e. they call set_bar() twice, without ever calling clear_bar(), as
+	 * calling clear_bar() would clear the BAR's PCI address assigned by the
+	 * host).
+	 */
+	if (ep->epf_bar[bar]) {
+		/*
+		 * We can only dynamically change a BAR if the new BAR size and
+		 * BAR flags do not differ from the existing configuration.
+		 */
+		if (ep->epf_bar[bar]->barno != bar ||
+		    ep->epf_bar[bar]->size != size ||
+		    ep->epf_bar[bar]->flags != flags)
+			return -EINVAL;
+
+		/*
+		 * When dynamically changing a BAR, skip writing the BAR reg, as
+		 * that would clear the BAR's PCI address assigned by the host.
+		 */
 		goto config_atu;
+	}
 
 	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
 


