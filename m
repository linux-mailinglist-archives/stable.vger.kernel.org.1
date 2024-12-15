Return-Path: <stable+bounces-104234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7619F229A
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 09:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41F16165B5F
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 08:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6D642AB3;
	Sun, 15 Dec 2024 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JiNg+qld"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897977483
	for <stable@vger.kernel.org>; Sun, 15 Dec 2024 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734251552; cv=none; b=kD/zgLY01EYNmZQdo4Fy0XhmYWqQ896b1UtvswUwYoyF98g2pj/rshArcKaQlRh+Y3I2WLa9UXidXBtyZgS88rPfShbo9qWIa2Y5vTr6eNxMMMIPnGBxdoorivQlSqertq7slU5wQvk8rryoZ8+IDHHCAYRh4afXnQmFgmd0D58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734251552; c=relaxed/simple;
	bh=7lSKFvXjHHQLdzgp/WrRjZIaCIImX2YGYGZYvgHjWVM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=f4K1hIH3QnXAdPAMU6j0UoOJZzUUZH1DpAtKMVXEFIrQLigEpw8BtJujQUqcTogs89nQ5oKb15OBVgeTJVGvIr+7uTSN4soEJ2yYxPTUJHF6y8xx+b1RJHjEoLJBm2oP6FnGbeBvt3TQauETAn8bcZs26DSocTpYBnRvMYXR1OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JiNg+qld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0067EC4CECE;
	Sun, 15 Dec 2024 08:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734251552;
	bh=7lSKFvXjHHQLdzgp/WrRjZIaCIImX2YGYGZYvgHjWVM=;
	h=Subject:To:Cc:From:Date:From;
	b=JiNg+qldGzenhrUwpKtndoRWMbyMWM0iHCCIcz07LL74I+XEv5Wa3oEicAuegQIJ2
	 vuiXdTMdb2LwG74nGGmGdz3ZbkCBaCDCDo7JyfV/A9P/KjbgQ3pmV7ZonS2ROQq8Jw
	 ET2SGmq6Rjk5nhIYKh30sVVPpou9NRbTd+bxEnLg=
Subject: FAILED: patch "[PATCH] usb: dwc3: xilinx: make sure pipe clock is deselected in usb2" failed to apply to 5.15-stable tree
To: neal.frager@amd.com,gregkh@linuxfoundation.org,peter@korsgaard.com,radhey.shyam.pandey@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 15 Dec 2024 09:32:29 +0100
Message-ID: <2024121529-embellish-ruby-d51f@gregkh>
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
git cherry-pick -x a48f744bef9ee74814a9eccb030b02223e48c76c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121529-embellish-ruby-d51f@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a48f744bef9ee74814a9eccb030b02223e48c76c Mon Sep 17 00:00:00 2001
From: Neal Frager <neal.frager@amd.com>
Date: Mon, 2 Dec 2024 23:41:51 +0530
Subject: [PATCH] usb: dwc3: xilinx: make sure pipe clock is deselected in usb2
 only mode

When the USB3 PHY is not defined in the Linux device tree, there could
still be a case where there is a USB3 PHY active on the board and enabled
by the first stage bootloader. If serdes clock is being used then the USB
will fail to enumerate devices in 2.0 only mode.

To solve this, make sure that the PIPE clock is deselected whenever the
USB3 PHY is not defined and guarantees that the USB2 only mode will work
in all cases.

Fixes: 9678f3361afc ("usb: dwc3: xilinx: Skip resets and USB3 register settings for USB2.0 mode")
Cc: stable@vger.kernel.org
Signed-off-by: Neal Frager <neal.frager@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Acked-by: Peter Korsgaard <peter@korsgaard.com>
Link: https://lore.kernel.org/r/1733163111-1414816-1-git-send-email-radhey.shyam.pandey@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index e3738e1610db..a33a42ba0249 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -121,8 +121,11 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	 * in use but the usb3-phy entry is missing from the device tree.
 	 * Therefore, skip these operations in this case.
 	 */
-	if (!priv_data->usb3_phy)
+	if (!priv_data->usb3_phy) {
+		/* Deselect the PIPE Clock Select bit in FPD PIPE Clock register */
+		writel(PIPE_CLK_DESELECT, priv_data->regs + XLNX_USB_FPD_PIPE_CLK);
 		goto skip_usb3_phy;
+	}
 
 	crst = devm_reset_control_get_exclusive(dev, "usb_crst");
 	if (IS_ERR(crst)) {


