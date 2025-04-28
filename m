Return-Path: <stable+bounces-136930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F73A9F720
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 19:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51591756EB
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 17:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B4C270EBC;
	Mon, 28 Apr 2025 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TeDDcM7M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C385B22DFAD
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860693; cv=none; b=kU59JyCasKCo5bmylUkphzNI5eYWdA0yobcvrd4BHzPH8jBIQORzl6yeTMPgI0V4ecsLBsWQBeNIjUGGfdyrt5+ofVFUfmpRzEJOcRlG8FT9/4e2LPGsXA7c7gp4hmwn42R+fsDvihCJC1ST/DmlcyENgcO0P7FGHSA25NPwzZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860693; c=relaxed/simple;
	bh=Y+Cd7M4Ooj+lDFLzRlX/kPw73AUG1Flq/ELpdXtdCJs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jCZp75EfOHeMceVaAgGgMJNwRnaaiM5X/VlbT3EFAYBPn/2lFGs4SIhRuBtHFKbpQyOBo6VMt3Y6fgCuQlktCHesorkv2C1XqhqPUX6iVfPJoU+EsKBhq8xIC/UuOnWJG5YpgOIJPfKuDGIKZjHaD5bWlwAAGTP2RXwwof0BadM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TeDDcM7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BC3C4CEEC;
	Mon, 28 Apr 2025 17:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745860693;
	bh=Y+Cd7M4Ooj+lDFLzRlX/kPw73AUG1Flq/ELpdXtdCJs=;
	h=Subject:To:Cc:From:Date:From;
	b=TeDDcM7MLdg7lSj8TXIMazAkfEapYejbau0N3dCO3Cvn5I6HWPkFqLrrASs4J/3zD
	 P8bystlqYIUkB714VLkOiG28EuQvC+qK+mgVC7xR//I8CFDhj6GvAwIiNuUJflM6Ba
	 txpVcrl4ACq9QDDU1BGTKNtotxjik0CFRQoUql4I=
Subject: FAILED: patch "[PATCH] usb: chipidea: ci_hdrc_imx: implement usb_phy_init() error" failed to apply to 5.4-stable tree
To: pchelkin@ispras.ru,gregkh@linuxfoundation.org,peter.chen@kernel.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Apr 2025 19:18:02 +0200
Message-ID: <2025042802-foil-prepaid-54ec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 8c531e0a8c2d82509ad97c6d3a1e6217c7ed136d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042802-foil-prepaid-54ec@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8c531e0a8c2d82509ad97c6d3a1e6217c7ed136d Mon Sep 17 00:00:00 2001
From: Fedor Pchelkin <pchelkin@ispras.ru>
Date: Sun, 16 Mar 2025 13:26:56 +0300
Subject: [PATCH] usb: chipidea: ci_hdrc_imx: implement usb_phy_init() error
 handling

usb_phy_init() may return an error code if e.g. its implementation fails
to prepare/enable some clocks. And properly rollback on probe error path
by calling the counterpart usb_phy_shutdown().

Found by Linux Verification Center (linuxtesting.org).

Fixes: be9cae2479f4 ("usb: chipidea: imx: Fix ULPI on imx53")
Cc: stable <stable@kernel.org>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/20250316102658.490340-4-pchelkin@ispras.ru
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index d942b3c72640..4f8bfd242b59 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -484,7 +484,11 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	    of_usb_get_phy_mode(np) == USBPHY_INTERFACE_MODE_ULPI) {
 		pdata.flags |= CI_HDRC_OVERRIDE_PHY_CONTROL;
 		data->override_phy_control = true;
-		usb_phy_init(pdata.usb_phy);
+		ret = usb_phy_init(pdata.usb_phy);
+		if (ret) {
+			dev_err(dev, "Failed to init phy\n");
+			goto err_clk;
+		}
 	}
 
 	if (pdata.flags & CI_HDRC_SUPPORTS_RUNTIME_PM)
@@ -493,7 +497,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	ret = imx_usbmisc_init(data->usbmisc_data);
 	if (ret) {
 		dev_err(dev, "usbmisc init failed, ret=%d\n", ret);
-		goto err_clk;
+		goto phy_shutdown;
 	}
 
 	data->ci_pdev = ci_hdrc_add_device(dev,
@@ -502,7 +506,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	if (IS_ERR(data->ci_pdev)) {
 		ret = PTR_ERR(data->ci_pdev);
 		dev_err_probe(dev, ret, "ci_hdrc_add_device failed\n");
-		goto err_clk;
+		goto phy_shutdown;
 	}
 
 	if (data->usbmisc_data) {
@@ -536,6 +540,9 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 
 disable_device:
 	ci_hdrc_remove_device(data->ci_pdev);
+phy_shutdown:
+	if (data->override_phy_control)
+		usb_phy_shutdown(data->phy);
 err_clk:
 	clk_disable_unprepare(data->clk_wakeup);
 err_wakeup_clk:


