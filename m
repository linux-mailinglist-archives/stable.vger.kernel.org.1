Return-Path: <stable+bounces-96089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA8C9E0811
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 17:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE50C178C3A
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A1A20ADD0;
	Mon,  2 Dec 2024 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tS1VjCqz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DF1209F4D
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152744; cv=none; b=meSbt7tuOHRNd1eS2dp2R56KL+BXIJvukyUSpmy9EI6hsSGFAUiEFBEsGZ0HFS+CoW7ah/qyYErStWmEVsGznR1+zxcIRX7MvnExZ18XLvUMzrF5DnkV10Q4UlWY4C1Ml6dEHmXBWGNvMws70PJuzWKXI0D3uCpoPboohhrF1FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152744; c=relaxed/simple;
	bh=sT7sVgH83qz3+xT+S1Y1QW40+oVFX8QAvSjtOWD45v8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lLIt/MBDsKfVXeYqBUOAk8cQht5mfAyEdhnd+edYDDqHCkiiwJ94z9QPT614g7hA40JS+avswsaKH+0jOgIi+wMBms54CwOG2bIUAKCIb6MhuhmWzBaoDEUWEgWiE50RBobT/+KDrhC7h+JMahVvqNIM6iG0kgnCZhhoLY3Fs6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tS1VjCqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9927C4CED2;
	Mon,  2 Dec 2024 15:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733152744;
	bh=sT7sVgH83qz3+xT+S1Y1QW40+oVFX8QAvSjtOWD45v8=;
	h=Subject:To:Cc:From:Date:From;
	b=tS1VjCqzV6YBRjdc21RDHnXFN33APu4jWTlES9N6tJgtXawURRwh04RmpYrx1ihY6
	 jDLq54e+5pBkiwXQOKj7p40EVcons8YqusIV28l6+MMsYlWEVyDOCrl8JV8v/uW5PD
	 xBVrV0r7sukPkBZpuS6OVhcuf2K+7XIdRzYTlTpA=
Subject: FAILED: patch "[PATCH] xhci: Combine two if statements for Etron xHCI host" failed to apply to 6.1-stable tree
To: ki.chiang65@gmail.com,gregkh@linuxfoundation.org,mathias.nyman@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Dec 2024 16:18:50 +0100
Message-ID: <2024120249-dynamite-flounder-73f6@gregkh>
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
git cherry-pick -x d7b11fe5790203fcc0db182249d7bfd945e44ccb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120249-dynamite-flounder-73f6@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


