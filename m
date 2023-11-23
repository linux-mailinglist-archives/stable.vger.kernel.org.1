Return-Path: <stable+bounces-49-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C667F5E99
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 13:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D69E1C20F40
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 12:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F121241F0;
	Thu, 23 Nov 2023 12:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P+B8a3ay"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C5B2377F
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 12:00:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5475C433C7;
	Thu, 23 Nov 2023 12:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700740847;
	bh=9GuWNeCdDOkTPXtVPV5+vFUgHX6DpU5nuEff6JgZlts=;
	h=Subject:To:Cc:From:Date:From;
	b=P+B8a3ayfr/7nDMQj+zPzP1xbU/4fDtxFRsldA5cJkUXIurHQ3lqTBBfR2TMQf/DQ
	 EjSTV1ZFQ/TnJcymvkd04+iQPSCS91j3dANWkMntvrSBUkWZ48jMSPsXRpY6R6eIMD
	 aiuDUhqz4g5a0CEuliX5wqMZ2a2oHQk7Nvr+R7Gc=
Subject: FAILED: patch "[PATCH] driver core: Release all resources during unbind before" failed to apply to 5.10-stable tree
To: saravanak@google.com,andriy.shevchenko@linux.intel.com,broonie@kernel.org,gregkh@linuxfoundation.org,james.clark@arm.com,mazziesaccount@gmail.com,rafael@kernel.org,stable@kernel.org,thierry.reding@gmail.com,u.kleine-koenig@pengutronix.de,yangyingliang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 23 Nov 2023 12:00:33 +0000
Message-ID: <2023112333-splurge-headpiece-79fb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2e84dc37920012b458e9458b19fc4ed33f81bc74
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112333-splurge-headpiece-79fb@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

2e84dc379200 ("driver core: Release all resources during unbind before updating device links")
25f3bcfc54bc ("driver core: Add dma_cleanup callback in bus_type")
9ad307213fa4 ("driver core: Refactor multiple copies of device cleanup")
d8f7a5484f21 ("driver core: Free DMA range map when device is released")
885e50253bfd ("driver core: Move driver_sysfs_remove() after driver_sysfs_add()")
4d1014c1816c ("drivers core: Fix oops when driver probe fails")
45ddcb42949f ("driver core: Don't return EPROBE_DEFER to userspace during sysfs bind")
ef6dcbdd8eb2 ("driver core: Flow the return code from ->probe() through to sysfs bind")
e1499647c69c ("driver core: Better distinguish probe errors in really_probe")
204db60c8357 ("driver core: Pull required checks into driver_probe_device()")
2c3dc6432f33 ("driver core: make driver_probe_device() static")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2e84dc37920012b458e9458b19fc4ed33f81bc74 Mon Sep 17 00:00:00 2001
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 17 Oct 2023 18:38:50 -0700
Subject: [PATCH] driver core: Release all resources during unbind before
 updating device links
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This commit fixes a bug in commit 9ed9895370ae ("driver core: Functional
dependencies tracking support") where the device link status was
incorrectly updated in the driver unbind path before all the device's
resources were released.

Fixes: 9ed9895370ae ("driver core: Functional dependencies tracking support")
Cc: stable <stable@kernel.org>
Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Closes: https://lore.kernel.org/all/20231014161721.f4iqyroddkcyoefo@pengutronix.de/
Signed-off-by: Saravana Kannan <saravanak@google.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: James Clark <james.clark@arm.com>
Acked-by: "Rafael J. Wysocki" <rafael@kernel.org>
Tested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20231018013851.3303928-1-saravanak@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index a528cec24264..0c3725c3eefa 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1274,8 +1274,8 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 		if (dev->bus && dev->bus->dma_cleanup)
 			dev->bus->dma_cleanup(dev);
 
-		device_links_driver_cleanup(dev);
 		device_unbind_cleanup(dev);
+		device_links_driver_cleanup(dev);
 
 		klist_remove(&dev->p->knode_driver);
 		device_pm_check_callbacks(dev);


