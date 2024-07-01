Return-Path: <stable+bounces-56238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6316691E1CA
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 16:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9340D1C233B7
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 14:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B40015ECED;
	Mon,  1 Jul 2024 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="svJUG/iT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A9415ECC6
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719842550; cv=none; b=PADmqHQyVHQN/3GVRK+UpkOCsmg9/+1nBKLoZxeCRY1agqBrqW9swVxtjcotYg7ISSc6B9IeP6/K9XO1MFYBIm8qOd5otwJ8CdTPGLZllruq1cuLMcwUZvh2WCeT05OVrcUNzBYdA5UGVHaq9WdpyXdF3oXmTk4L9BVOvOJMGdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719842550; c=relaxed/simple;
	bh=si4OtEtGt06IVyH0ZtsI6QD+C8u2Ed+FZkWjOzBhH0w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=drcVCReKzRuULFvyGbKgdupWWO5zpGm5e2tgnJ1iNDHD2Z8JK5JE4DtchASWjL5Bss9VHHbWQ2/OsUx8ozf0VMNG3GwVU/9qpXBZFn7y1dcrKxfHLToDNnGLxVYG11zZouhqn8gyWkefCJ5/JEvyvGGsT4XXcgbSiGBPl94LJxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=svJUG/iT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D6DC116B1;
	Mon,  1 Jul 2024 14:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719842550;
	bh=si4OtEtGt06IVyH0ZtsI6QD+C8u2Ed+FZkWjOzBhH0w=;
	h=Subject:To:Cc:From:Date:From;
	b=svJUG/iTZbChIlyjxyiHCvzU2OEJsUHlpXyhiub2C1RFJx1w38F+2GJQxPj++H8ky
	 /oXXslA9RSTq1QjSVZveOJQYxBjGrzPMOxx75MPWSEcjW6SzP/gfY+tdAXjgAcSvmc
	 6TVX01cnl+0xum3X6Y5IhLW8wnIjHOaAo6cT4ocs=
Subject: FAILED: patch "[PATCH] usb: dwc3: core: Workaround for CSR read timeout" failed to apply to 5.10-stable tree
To: joswang@lenovo.com,Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Jul 2024 16:02:16 +0200
Message-ID: <2024070116-finalize-precise-1679@gregkh>
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
git cherry-pick -x fc1d1a712b517bbcb383b1f1f7ef478e7d0579f2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070116-finalize-precise-1679@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

fc1d1a712b51 ("usb: dwc3: core: Workaround for CSR read timeout")
f56d0d29b018 ("USB: dwc3: drop dead hibernation code")
3497b9a5c8c3 ("usb: dwc3: add power down scale setting")
0c0a20f6da04 ("usb: dwc3: Simplify with dev_err_probe()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fc1d1a712b517bbcb383b1f1f7ef478e7d0579f2 Mon Sep 17 00:00:00 2001
From: Jos Wang <joswang@lenovo.com>
Date: Wed, 19 Jun 2024 19:45:29 +0800
Subject: [PATCH] usb: dwc3: core: Workaround for CSR read timeout

This is a workaround for STAR 4846132, which only affects
DWC_usb31 version2.00a operating in host mode.

There is a problem in DWC_usb31 version 2.00a operating
in host mode that would cause a CSR read timeout When CSR
read coincides with RAM Clock Gating Entry. By disable
Clock Gating, sacrificing power consumption for normal
operation.

Cc: stable <stable@kernel.org> # 5.10.x: 1e43c86d: usb: dwc3: core: Add DWC31 version 2.00a controller
Signed-off-by: Jos Wang <joswang@lenovo.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/20240619114529.3441-1-joswang1221@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9d47c3aa5777..cb82557678dd 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -957,12 +957,16 @@ static bool dwc3_core_is_valid(struct dwc3 *dwc)
 
 static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 {
+	unsigned int power_opt;
+	unsigned int hw_mode;
 	u32 reg;
 
 	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
 	reg &= ~DWC3_GCTL_SCALEDOWN_MASK;
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	power_opt = DWC3_GHWPARAMS1_EN_PWROPT(dwc->hwparams.hwparams1);
 
-	switch (DWC3_GHWPARAMS1_EN_PWROPT(dwc->hwparams.hwparams1)) {
+	switch (power_opt) {
 	case DWC3_GHWPARAMS1_EN_PWROPT_CLK:
 		/**
 		 * WORKAROUND: DWC3 revisions between 2.10a and 2.50a have an
@@ -995,6 +999,20 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 		break;
 	}
 
+	/*
+	 * This is a workaround for STAR#4846132, which only affects
+	 * DWC_usb31 version2.00a operating in host mode.
+	 *
+	 * There is a problem in DWC_usb31 version 2.00a operating
+	 * in host mode that would cause a CSR read timeout When CSR
+	 * read coincides with RAM Clock Gating Entry. By disable
+	 * Clock Gating, sacrificing power consumption for normal
+	 * operation.
+	 */
+	if (power_opt != DWC3_GHWPARAMS1_EN_PWROPT_NO &&
+	    hw_mode != DWC3_GHWPARAMS0_MODE_GADGET && DWC3_VER_IS(DWC31, 200A))
+		reg |= DWC3_GCTL_DSBLCLKGTNG;
+
 	/* check if current dwc3 is on simulation board */
 	if (dwc->hwparams.hwparams6 & DWC3_GHWPARAMS6_EN_FPGA) {
 		dev_info(dwc->dev, "Running with FPGA optimizations\n");


