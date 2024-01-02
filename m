Return-Path: <stable+bounces-9187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901F1821CF0
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 14:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7BDD1C22132
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 13:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1815BFBF2;
	Tue,  2 Jan 2024 13:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pau7fCLf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D076FFBEF
	for <stable@vger.kernel.org>; Tue,  2 Jan 2024 13:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA902C433C8;
	Tue,  2 Jan 2024 13:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704202946;
	bh=Lqk7YHQuM5kzoktgowsfTFXYh+/HdzYEDwwiyp9BU48=;
	h=Subject:To:From:Date:From;
	b=pau7fCLfHxZPCb8RIEFgqp9nXELWxmiriWpfYrMYEHQkK4Imev98WHk89xRNpe9Ks
	 5QOc8j8gRNurz2Li3uqSxWAqbJoulPhCKESvw2xSNtTIcBhLC+NMCXBbcWRqlFc85g
	 E14e/n3Ib1tEamBDbVFvmOCvjBTJgIF8aXQTWem8=
Subject: patch "Revert "usb: dwc3: don't reset device side if dwc3 was configured as" added to usb-testing
To: Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Tue, 02 Jan 2024 14:42:17 +0100
Message-ID: <2024010216-transport-matchbook-03e5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    Revert "usb: dwc3: don't reset device side if dwc3 was configured as

to my usb git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
in the usb-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the usb-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From afe28cd686aeb77e8d9140d50fb1cf06a7ecb731 Mon Sep 17 00:00:00 2001
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Date: Fri, 22 Dec 2023 22:11:33 +0000
Subject: Revert "usb: dwc3: don't reset device side if dwc3 was configured as
 host-only"

This reverts commit e835c0a4e23c38531dcee5ef77e8d1cf462658c7.

Don't omit soft-reset. During initialization, the driver may need to
perform a soft reset to ensure the phy is ready when the controller
updates the GCTL.PRTCAPDIR or other settings by issuing phy soft-reset.
Many platforms often have access to DCTL register for soft-reset despite
being host-only. If there are actual reported issues from the platforms
that don't expose DCTL registers, then we will need to revisit (perhaps
to teach dwc3 to perform xhci's soft-reset USBCMD.HCRST).

Cc:  <stable@vger.kernel.org>
Fixes: e835c0a4e23c ("usb: dwc3: don't reset device side if dwc3 was configured as host-only")
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/7668ab11a48f260820825274976eb41fec7f54d1.1703282469.git.Thinh.Nguyen@synopsys.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 832c41fec4f7..f50b5575d588 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -277,9 +277,9 @@ int dwc3_core_soft_reset(struct dwc3 *dwc)
 	/*
 	 * We're resetting only the device side because, if we're in host mode,
 	 * XHCI driver will reset the host block. If dwc3 was configured for
-	 * host-only mode or current role is host, then we can return early.
+	 * host-only mode, then we can return early.
 	 */
-	if (dwc->dr_mode == USB_DR_MODE_HOST || dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
+	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
 		return 0;
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
-- 
2.43.0



