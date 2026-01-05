Return-Path: <stable+bounces-204659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF301CF3197
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 11:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A00D30049C7
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 10:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188C532E12D;
	Mon,  5 Jan 2026 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lgoRILXg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD65526ED41
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 10:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610787; cv=none; b=Z4IWO9Zx7rDYmddR43blWag7M1bVt5E+lygK02Xc9UgydZvoBTvSTc1zsKOhaOa2fyxmVXYxFW9xjIlTFBK8kzbHGsXicB1ZtnphCJZ8WuGgaCNSfoDbZaJWDRfoXIKpckA9c0G5otpjXVLqMINOmH5XYwQtN8F0EOdzskSIkvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610787; c=relaxed/simple;
	bh=LxOtL+yonHQ+IYPIwxWLqHtfxaavcWtViu3l5qe2EQQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=F6SJvFFGrY0l41UO2UzHkSvNybU6LIVT6D2I5D//v2A/3rUEkhSl8L23NI3BEx5pGYBW8A14RjoCijyJfRB+2VnQy9KH26kBE/RlhOsuU34hGS83hh6U8F+dxgCZB4b0dwc//+eLhdpbYPq1HdJUHsjoXINj6OlADE/RTfaE32w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lgoRILXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E545FC116D0;
	Mon,  5 Jan 2026 10:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767610786;
	bh=LxOtL+yonHQ+IYPIwxWLqHtfxaavcWtViu3l5qe2EQQ=;
	h=Subject:To:Cc:From:Date:From;
	b=lgoRILXgtk15K4zNULMTfKk3htpyQLi34bxTYZicl7o6lvqpV3VxU4i9tbR++ZI5f
	 gmDcg27EfrE5JEznK25fK6OX5iggD6OmulwAs0V8YV7enFotFAp07Y4Lv4v7IxIIPw
	 8v83buSrm0MG6PzI7G1OK0uJwU/VQA73wHKgbWkI=
Subject: FAILED: patch "[PATCH] media: vpif_capture: fix section mismatch" failed to apply to 5.10-stable tree
To: johan@kernel.org,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 11:59:35 +0100
Message-ID: <2026010535-unmindful-hedge-1198@gregkh>
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
git cherry-pick -x 0ef841113724166c3c484d0e9ae6db1eb5634fde
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010535-unmindful-hedge-1198@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0ef841113724166c3c484d0e9ae6db1eb5634fde Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 17 Oct 2025 07:33:20 +0200
Subject: [PATCH] media: vpif_capture: fix section mismatch

Platform drivers can be probed after their init sections have been
discarded (e.g. on probe deferral or manual rebind through sysfs) so the
probe function must not live in init.

Note that commit ffa1b391c61b ("V4L/DVB: vpif_cap/disp: Removed section
mismatch warning") incorrectly suppressed the modpost warning.

Fixes: ffa1b391c61b ("V4L/DVB: vpif_cap/disp: Removed section mismatch warning")
Fixes: 6ffefff5a9e7 ("V4L/DVB (12906c): V4L : vpif capture driver for DM6467")
Cc: stable@vger.kernel.org	# 2.6.32
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/platform/ti/davinci/vpif_capture.c b/drivers/media/platform/ti/davinci/vpif_capture.c
index d053972888d1..243c6196b024 100644
--- a/drivers/media/platform/ti/davinci/vpif_capture.c
+++ b/drivers/media/platform/ti/davinci/vpif_capture.c
@@ -1600,7 +1600,7 @@ vpif_capture_get_pdata(struct platform_device *pdev,
  * This creates device entries by register itself to the V4L2 driver and
  * initializes fields of each channel objects
  */
-static __init int vpif_probe(struct platform_device *pdev)
+static int vpif_probe(struct platform_device *pdev)
 {
 	struct vpif_subdev_info *subdevdata;
 	struct i2c_adapter *i2c_adap;
@@ -1807,7 +1807,7 @@ static int vpif_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(vpif_pm_ops, vpif_suspend, vpif_resume);
 
-static __refdata struct platform_driver vpif_driver = {
+static struct platform_driver vpif_driver = {
 	.driver	= {
 		.name	= VPIF_DRIVER_NAME,
 		.pm	= &vpif_pm_ops,


