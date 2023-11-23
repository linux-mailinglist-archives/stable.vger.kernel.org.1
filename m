Return-Path: <stable+bounces-48-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EC37F5E98
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 13:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F65281971
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 12:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF6E23770;
	Thu, 23 Nov 2023 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mQxc+2V2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECF8225A1
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 12:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7ABBC433C8;
	Thu, 23 Nov 2023 12:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700740837;
	bh=UqX0SB+eoBRTF0wdDDnkYNf+pW6G59Z4WhE5b9j4hFs=;
	h=Subject:To:Cc:From:Date:From;
	b=mQxc+2V2bFFCZ6vXia5wTlyp1bVd+DPRvJ2m4ytfl4hc+h/GbdAQlDYV4cJrYAH1t
	 MICySrGZowuPdPjy+HEE/VsdWpdE57CcwKWwHjeE4Ya7O/xOLMT3X5nREL5BQOPzZY
	 poS/T0CWR8tkfBIJywYxxdMXDSGiTb5yUmgk/61I=
Subject: FAILED: patch "[PATCH] driver core: Release all resources during unbind before" failed to apply to 5.15-stable tree
To: saravanak@google.com,andriy.shevchenko@linux.intel.com,broonie@kernel.org,gregkh@linuxfoundation.org,james.clark@arm.com,mazziesaccount@gmail.com,rafael@kernel.org,stable@kernel.org,thierry.reding@gmail.com,u.kleine-koenig@pengutronix.de,yangyingliang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 23 Nov 2023 12:00:30 +0000
Message-ID: <2023112330-squealer-strife-0ecc@gregkh>
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
git cherry-pick -x 2e84dc37920012b458e9458b19fc4ed33f81bc74
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112330-squealer-strife-0ecc@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

2e84dc379200 ("driver core: Release all resources during unbind before updating device links")
25f3bcfc54bc ("driver core: Add dma_cleanup callback in bus_type")
9ad307213fa4 ("driver core: Refactor multiple copies of device cleanup")
d8f7a5484f21 ("driver core: Free DMA range map when device is released")
885e50253bfd ("driver core: Move driver_sysfs_remove() after driver_sysfs_add()")

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


