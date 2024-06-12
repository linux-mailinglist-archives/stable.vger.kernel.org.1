Return-Path: <stable+bounces-50317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD437905AB7
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 20:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689F31F236A5
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 18:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67E138DF2;
	Wed, 12 Jun 2024 18:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KEfTtpZX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6581B26AD5
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 18:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718216553; cv=none; b=hG4OGLApHPzjr83JMa2PQcAHAfxyMj8HVNdEG9VHs88waXKMoUMeImydUkEOG3RJL+X4hIH+sSXzBny+lLZfVIM+Ze5s6InGL044a5FxBs8QjI49TGmLFO0BJy9SkA+PbRI3nWITlQmYuWnQ+OjxTCalYSk7CBC2wXb+r4peQjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718216553; c=relaxed/simple;
	bh=XRcnnp+VWL13605qgnK6cGJKdJlH8bbs4QFQ5RuSQ/Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SKvz+1gevH1/hSgM9lPAsXOqYVknOmxGS+SgDMyGrVA9JYSlEuWVr+ZMPkNGlWaT9BzHI73DBtRrlBCU0t7shIxwFcCnf6tyXRdlLRCIjjSly9Ukl+uEDpUK6C7gPbdsxkPet81PelhIO4mkXDnrFryWt5YZOkhE9D2EhFDUXc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KEfTtpZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837F0C32786;
	Wed, 12 Jun 2024 18:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718216550;
	bh=XRcnnp+VWL13605qgnK6cGJKdJlH8bbs4QFQ5RuSQ/Y=;
	h=Subject:To:Cc:From:Date:From;
	b=KEfTtpZXB1Sla6VBib3oMvDxWhaKNDyiE3UwNtAiUcXu+ehB+gwyxWpzdonZT12HO
	 NPZKn8jjvQu8zxzNNplEf1dRN75dGRHedDvV97woaWf31ZNXG75mmE5s7iEj0Ef8GT
	 VZVFkg3T1+tOsxJbAB4xzexIPHjbRwFYrp7E2mhs=
Subject: FAILED: patch "[PATCH] mmc: davinci: Don't strip remove function when driver is" failed to apply to 6.1-stable tree
To: u.kleine-koenig@pengutronix.de,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 12 Jun 2024 20:22:28 +0200
Message-ID: <2024061227-zit-rupture-640c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 55c421b364482b61c4c45313a535e61ed5ae4ea3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061227-zit-rupture-640c@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

55c421b36448 ("mmc: davinci: Don't strip remove function when driver is builtin")
bc1711e8332d ("mmc: davinci_mmc: Convert to platform remove callback returning void")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 55c421b364482b61c4c45313a535e61ed5ae4ea3 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Date: Sun, 24 Mar 2024 12:40:17 +0100
Subject: [PATCH] mmc: davinci: Don't strip remove function when driver is
 builtin
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Using __exit for the remove function results in the remove callback being
discarded with CONFIG_MMC_DAVINCI=y. When such a device gets unbound (e.g.
using sysfs or hotplug), the driver is just removed without the cleanup
being performed. This results in resource leaks. Fix it by compiling in the
remove callback unconditionally.

This also fixes a W=1 modpost warning:

WARNING: modpost: drivers/mmc/host/davinci_mmc: section mismatch in
reference: davinci_mmcsd_driver+0x10 (section: .data) ->
davinci_mmcsd_remove (section: .exit.text)

Fixes: b4cff4549b7a ("DaVinci: MMC: MMC/SD controller driver for DaVinci family")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240324114017.231936-2-u.kleine-koenig@pengutronix.de
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 8bd938919687..d7427894e0bc 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1337,7 +1337,7 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static void __exit davinci_mmcsd_remove(struct platform_device *pdev)
+static void davinci_mmcsd_remove(struct platform_device *pdev)
 {
 	struct mmc_davinci_host *host = platform_get_drvdata(pdev);
 
@@ -1392,7 +1392,7 @@ static struct platform_driver davinci_mmcsd_driver = {
 		.of_match_table = davinci_mmc_dt_ids,
 	},
 	.probe		= davinci_mmcsd_probe,
-	.remove_new	= __exit_p(davinci_mmcsd_remove),
+	.remove_new	= davinci_mmcsd_remove,
 	.id_table	= davinci_mmc_devtype,
 };
 


