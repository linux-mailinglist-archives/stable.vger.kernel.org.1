Return-Path: <stable+bounces-204658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FEACF3194
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 11:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0480300286B
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 10:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A9D32E12D;
	Mon,  5 Jan 2026 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LnRhnLMc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A942D7810
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610778; cv=none; b=bYREnUj+KUSog7SkuXEMtKVMACvsvvkS2R2bTkQAy6XIDsUl1MmV/kI+JXjS9CXzXhGMNop403O5ylN3RwK0xKtqsFfCjAiwm8JULn+Et23zairS3QKaGSQv7kTzcEGGJZoYP4+37kloLG07CycPsRynugUzqr4m0iGNpnNqBmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610778; c=relaxed/simple;
	bh=vE1mT/uAx6uEDjM1QnLd85Cw7d3ZM8z2MqSSMM342Fc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jcuW20exiUTZ/LtS0myp9hPjYez53hBi8KhEWlbciKxzCaLmsLJ4hvHqeG8eR8j4yDoUuDap7lOW7uQsiLgq22b1kkumfiXc6NHZzNfAl3iQVLBQPRi3B8ilFNyOo+w4SnpLRobFPAmS6kNvOFAzImMT5ZpjaobpcVwUK+uEAfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LnRhnLMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618F7C116D0;
	Mon,  5 Jan 2026 10:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767610777;
	bh=vE1mT/uAx6uEDjM1QnLd85Cw7d3ZM8z2MqSSMM342Fc=;
	h=Subject:To:Cc:From:Date:From;
	b=LnRhnLMcFlTjOau3XKD15iAzIr399sJE1j4PfU6l+wVV1/lRxb3+rNxwwNNnx34eC
	 YGFESDwrOhC0R5bq3d9BBoINg9LgT0KEy1aNWtDZ3nKvlTn18Zf2NHQm3/qfvZdxLX
	 soOq+rU2Uc3aTQw57rPCq3YbaNKhWfw5jiEJgpbA=
Subject: FAILED: patch "[PATCH] media: vpif_capture: fix section mismatch" failed to apply to 5.15-stable tree
To: johan@kernel.org,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 11:59:34 +0100
Message-ID: <2026010534-slinging-linguini-bbf3@gregkh>
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
git cherry-pick -x 0ef841113724166c3c484d0e9ae6db1eb5634fde
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010534-slinging-linguini-bbf3@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


