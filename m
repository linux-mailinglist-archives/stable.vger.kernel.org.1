Return-Path: <stable+bounces-50321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9350E905ABB
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 20:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09BA31F23697
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 18:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89EC38DF2;
	Wed, 12 Jun 2024 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q7heRgT/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E5839FCF
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718216564; cv=none; b=PR7HypqD6Fd5q/H+9Ej/QUkv+sK7KrlZXyIsd4FzE2DbLT5+7CkZLhz2usumIuxSZRBoEzoYLsfCbhI1jfBc70Q9rk9qU1eftHRwnoXlrotdED3Jay82roaio3sgR2lqZVNJAEeGCuhzoEre5Cc6Gn72Ix1OWCAxLYylJcLhKl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718216564; c=relaxed/simple;
	bh=kqd8+eyS4LJXF1lRCOBBmpvbFyXgVHU5NuCf2ZGl5wg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QkuiczVjivNHhJSvZc+N0B/gxfjlm5DLnuJkIHac6Mm+3yx3E87fzVz3vL5EJVhWmMrZeK3oEqWeJdmRPYWCtpnG8LBjBBxt9MVGLUsMBUOlcNQH4B3iR9bxLez74NNI/bJDwVSqj7e+mxx+HNhHRMKUEClyU4dMf4AciLkSvXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q7heRgT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2D6C32786;
	Wed, 12 Jun 2024 18:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718216563;
	bh=kqd8+eyS4LJXF1lRCOBBmpvbFyXgVHU5NuCf2ZGl5wg=;
	h=Subject:To:Cc:From:Date:From;
	b=q7heRgT/n5ps5S2X1v7gfUbAf3Qb/hCJrFqRcqhGIRL5AyM2PI5Edr74g4UA6cnwT
	 pHbY+rG3OSdy6iAOiw4N43a2f+BiUHomLdYZR6A0PZN5foekGdd53yjFrj6pi1OG7A
	 4rt71ZyHXcvME/TreTeJHq/7OdDAJqx1pGh2W1mc=
Subject: FAILED: patch "[PATCH] mmc: davinci: Don't strip remove function when driver is" failed to apply to 4.19-stable tree
To: u.kleine-koenig@pengutronix.de,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 12 Jun 2024 20:22:31 +0200
Message-ID: <2024061231-player-lumpish-af5c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 55c421b364482b61c4c45313a535e61ed5ae4ea3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061231-player-lumpish-af5c@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

55c421b36448 ("mmc: davinci: Don't strip remove function when driver is builtin")
bc1711e8332d ("mmc: davinci_mmc: Convert to platform remove callback returning void")
fa6c12e036c9 ("drm/xe/guc: Add Relay Communication ABI definitions")
fa6c12e036c9 ("drm/xe/guc: Add Relay Communication ABI definitions")
fa6c12e036c9 ("drm/xe/guc: Add Relay Communication ABI definitions")
fa6c12e036c9 ("drm/xe/guc: Add Relay Communication ABI definitions")
fa6c12e036c9 ("drm/xe/guc: Add Relay Communication ABI definitions")
fa6c12e036c9 ("drm/xe/guc: Add Relay Communication ABI definitions")
fa6c12e036c9 ("drm/xe/guc: Add Relay Communication ABI definitions")
fa6c12e036c9 ("drm/xe/guc: Add Relay Communication ABI definitions")
fa6c12e036c9 ("drm/xe/guc: Add Relay Communication ABI definitions")
fa6c12e036c9 ("drm/xe/guc: Add Relay Communication ABI definitions")
fa6c12e036c9 ("drm/xe/guc: Add Relay Communication ABI definitions")
fa6c12e036c9 ("drm/xe/guc: Add Relay Communication ABI definitions")
fa6c12e036c9 ("drm/xe/guc: Add Relay Communication ABI definitions")
fa6c12e036c9 ("drm/xe/guc: Add Relay Communication ABI definitions")
fa6c12e036c9 ("drm/xe/guc: Add Relay Communication ABI definitions")
fa6c12e036c9 ("drm/xe/guc: Add Relay Communication ABI definitions")
fa6c12e036c9 ("drm/xe/guc: Add Relay Communication ABI definitions")
fa6c12e036c9 ("drm/xe/guc: Add Relay Communication ABI definitions")

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
 


