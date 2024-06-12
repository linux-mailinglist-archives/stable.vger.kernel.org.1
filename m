Return-Path: <stable+bounces-50318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 188A6905AB8
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 20:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 052CAB23D34
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 18:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3502739FCF;
	Wed, 12 Jun 2024 18:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TkwLBolM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A2D26AD5
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718216555; cv=none; b=WS4CkG6K3upVStS4eTXpQQE2kknW04YRmxCsvU3t3kpmkJCngOm2dGdUmyfbA3/pHCJUgMyHrSxcsG7e0+D66UDfQX71JPoBW5/CGdrwfyHEx0J2S+5PyOqDjT1jfqU2OuqAc3ptZcOJQ6mQ0u50PNSKhglFThZH4y3u+lp/H28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718216555; c=relaxed/simple;
	bh=uC8tE3SMo9kYiJyrtXtyxS5pH1H29OGGyx3Fajm9CDE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HtbBO657zB0b46HsWGKJSduVuCRrKRpd0oOsU98wFmfaGh7BVxuNljq43eh5Dy5McF7sECVEC23tljDWAr8OP6g/uGUpQTdQJ3mF6S+3UkEqrZWqHrruoSYHI+PktnWEQPLU7IiWOodjHjez9Iaxjya48/qMLbexzyzpfOUk9Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TkwLBolM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C1EC4AF1A;
	Wed, 12 Jun 2024 18:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718216554;
	bh=uC8tE3SMo9kYiJyrtXtyxS5pH1H29OGGyx3Fajm9CDE=;
	h=Subject:To:Cc:From:Date:From;
	b=TkwLBolMR4Ge5CXhN0fOu6IqjW0+/rybImTWM2G84FR0hHrsg76lbWb0OIVkmrsl0
	 rt+xOx45lR1219BOepvhgk3MR83qklFUwiwJ15v+apx2Qa+Tji833LcX27oY+iU8Tt
	 X4Mg2WDXlnaUxpZM87fWLFXG3NjavkcfVen9FAqA=
Subject: FAILED: patch "[PATCH] mmc: davinci: Don't strip remove function when driver is" failed to apply to 5.15-stable tree
To: u.kleine-koenig@pengutronix.de,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 12 Jun 2024 20:22:28 +0200
Message-ID: <2024061228-olive-jawless-313c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 55c421b364482b61c4c45313a535e61ed5ae4ea3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061228-olive-jawless-313c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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
 


