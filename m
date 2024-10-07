Return-Path: <stable+bounces-81393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC3299343F
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77562B29AAB
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 16:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69911DC188;
	Mon,  7 Oct 2024 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nE+FXPTi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E181DBB04
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319973; cv=none; b=ntofw/2/q4htqP1s7Xak4GOw+C7NbgLPqhtzukAqX7WbGuUGeIsF+fORbVNHDA5QGdzxoyFtZxY0WSKTFsMJE9I3OBbAWbwibd0bNgWYOEZXB2VPhdXzIXvx6mTH9WbOu/19tPdp81SnZ5FLOJokXHC/J9Q4J0NDEcYMYOaPui4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319973; c=relaxed/simple;
	bh=X/MLBQI9bNxCVOqs8mpb09mfQ5hbvOw6HWPBInB3NgI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=T2DLMJMHxUWzvtvv2xpj4HthRBmY3hHfTUJ+g7AP7CQMyzi3/xQhRcDScF1TLo+JzyJwyM6bgfB0gdU8zdOq8/kZUG0TkOBRq8aUN9r5IlmWCotwVVK28VC29FkBKXfqBc2jfVKyR1fNOO6qej1qZcrwPbxXplZsFy+SY2I0lzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nE+FXPTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BDCC4CEC6;
	Mon,  7 Oct 2024 16:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728319973;
	bh=X/MLBQI9bNxCVOqs8mpb09mfQ5hbvOw6HWPBInB3NgI=;
	h=Subject:To:Cc:From:Date:From;
	b=nE+FXPTilF+uUHiHfgo484heAG9NapNp0iCcBBu/RQ8nGob8+uLOMkjCc9oKsuJsA
	 Muy/rqgPXjb0Z0WCPX09A/zwKq6O4tcGXkn7LSf13THdbf1IrPO8YlBClQXhQ9wqbU
	 GeA9AauGUKDUCUpiEWECOinJKjyv8n1pUtWts1L4=
Subject: FAILED: patch "[PATCH] media: qcom: camss: Fix ordering of pm_runtime_enable" failed to apply to 5.15-stable tree
To: bryan.odonoghue@linaro.org,hverkuil-cisco@xs4all.nl,johan+linaro@kernel.org,konradybcio@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 18:52:50 +0200
Message-ID: <2024100750-catalyst-lankiness-bd40@gregkh>
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
git cherry-pick -x a151766bd3688f6803e706c6433a7c8d3c6a6a94
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100750-catalyst-lankiness-bd40@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

a151766bd368 ("media: qcom: camss: Fix ordering of pm_runtime_enable")
f69791c39745 ("media: qcom: camss: Fix genpd cleanup")
b278080a89f4 ("media: qcom: camss: Fix V4L2 async notifier error path")
7405116519ad ("media: qcom: camss: Fix pm_domain_on sequence in probe")
5651bab6890a ("media: qcom: Initialise V4L2 async notifier later")
428bbf4be401 ("media: camss: Convert to platform remove callback returning void")
46cc03175498 ("media: camss: Split power domain management")
3d658980e6da ("media: camss: Do not attach an already attached power domain on MSM8916 platform")
cf295629e3d6 ("media: camss: Allocate camss struct as a managed device resource")
6b1814e26989 ("media: camss: Allocate power domain resources dynamically")
5ba38efb2622 ("media: camss: Add SM8250 bandwdith configuration support")
b4436a18eedb ("media: camss: add support for SM8250 camss")
4edc8eae715c ("media: camss: Add initial support for VFE hardware version Titan 480")
3c8c15391481 ("media: v4l: async: Rename async nf functions, clean up long lines")
2070893aed11 ("media: rcar-vin: Move group async notifier")
161b56a82dba ("media: rcar-vin: Rename array storing subdevice information")
6df305779291 ("media: rcar-vin: Improve async notifier cleanup paths")
b2dc5680aeb4 ("media: rcar-vin: Refactor controls creation for video device")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a151766bd3688f6803e706c6433a7c8d3c6a6a94 Mon Sep 17 00:00:00 2001
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Mon, 29 Jul 2024 13:42:03 +0100
Subject: [PATCH] media: qcom: camss: Fix ordering of pm_runtime_enable

pm_runtime_enable() should happen prior to vfe_get() since vfe_get() calls
pm_runtime_resume_and_get().

This is a basic race condition that doesn't show up for most users so is
not widely reported. If you blacklist qcom-camss in modules.d and then
subsequently modprobe the module post-boot it is possible to reliably show
this error up.

The kernel log for this error looks like this:

qcom-camss ac5a000.camss: Failed to power up pipeline: -13

Fixes: 02afa816dbbf ("media: camss: Add basic runtime PM support")
Reported-by: Johan Hovold <johan+linaro@kernel.org>
Closes: https://lore.kernel.org/lkml/ZoVNHOTI0PKMNt4_@hovoldconsulting.com/
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 51b1d3550421..d64985ca6e88 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -2283,6 +2283,8 @@ static int camss_probe(struct platform_device *pdev)
 
 	v4l2_async_nf_init(&camss->notifier, &camss->v4l2_dev);
 
+	pm_runtime_enable(dev);
+
 	num_subdevs = camss_of_parse_ports(camss);
 	if (num_subdevs < 0) {
 		ret = num_subdevs;
@@ -2323,8 +2325,6 @@ static int camss_probe(struct platform_device *pdev)
 		}
 	}
 
-	pm_runtime_enable(dev);
-
 	return 0;
 
 err_register_subdevs:
@@ -2332,6 +2332,7 @@ static int camss_probe(struct platform_device *pdev)
 err_v4l2_device_unregister:
 	v4l2_device_unregister(&camss->v4l2_dev);
 	v4l2_async_nf_cleanup(&camss->notifier);
+	pm_runtime_disable(dev);
 err_genpd_cleanup:
 	camss_genpd_cleanup(camss);
 


