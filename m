Return-Path: <stable+bounces-136929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CD4A9F71F
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 19:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17EB33B544F
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 17:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF2027C17F;
	Mon, 28 Apr 2025 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kW9hGqqF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26B025F973
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 17:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860685; cv=none; b=Wq57cXXQFC7hO2UI6nji/h+H9gq6r/6nuEZCtOTUF6JvDfB+j+HGk4M88IUCKuCcSAke+chOaMQ0UviUcCIFdQ7oGrtirQvmTg5VCw34VZTW2hJZ6PKR3qOmG1/9ew/6Q9mPJk23zQ/HippX74tnSmgoHS9YHF8P4c4gipbivxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860685; c=relaxed/simple;
	bh=MLt8ciok+BupQxANKpvfddpvnwtVnGyQsUpobffxbj0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pSsUFt6zjKKjiv4MC7YF4ql5qRVQtg6HXwKuGzkcWwRKkyzc4Tt/jXndyxtBFo8/5WzVxt7svoA4E8DHdfDQamOaFZ1+jBDgMeFxUrHtpdW7EGvvtIFsYdQ7dzN/6iOLTQUSguonkKH91+okixCfMpoR0wZ6YCQl6Wfof8vfBNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kW9hGqqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA64EC4CEE4;
	Mon, 28 Apr 2025 17:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745860684;
	bh=MLt8ciok+BupQxANKpvfddpvnwtVnGyQsUpobffxbj0=;
	h=Subject:To:Cc:From:Date:From;
	b=kW9hGqqFL2mMjNU6UPoS521CorC2rFSc+f8RbC1C2BkgNxZaxggBeg2+zQ7L6VUp3
	 oW6fooY/T67lfHMYrQaBER9WroHWDGP3ylhblcEGJgQu+1IHaIcvhe5R1EfyXZTPzd
	 7x3fDCLk71yPbH1KpR0Lg9AIx9TMPyI1RZ4ypkaY=
Subject: FAILED: patch "[PATCH] usb: chipidea: ci_hdrc_imx: implement usb_phy_init() error" failed to apply to 5.10-stable tree
To: pchelkin@ispras.ru,gregkh@linuxfoundation.org,peter.chen@kernel.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Apr 2025 19:17:56 +0200
Message-ID: <2025042856-rotten-chatty-2573@gregkh>
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
git cherry-pick -x 8c531e0a8c2d82509ad97c6d3a1e6217c7ed136d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042856-rotten-chatty-2573@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


