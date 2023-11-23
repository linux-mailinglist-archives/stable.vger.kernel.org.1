Return-Path: <stable+bounces-65-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BD97F603E
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 14:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524BB1C21053
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 13:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6811224A0D;
	Thu, 23 Nov 2023 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DC6D42
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 05:28:56 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r69lG-0001nt-Q7; Thu, 23 Nov 2023 14:28:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r69lD-00B3G0-HM; Thu, 23 Nov 2023 14:28:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r69lD-006gWD-7r; Thu, 23 Nov 2023 14:28:51 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: stable@vger.kernel.org
Cc: Saravana Kannan <saravanak@google.com>,
	stable <stable@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	James Clark <james.clark@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.15.y] driver core: Release all resources during unbind before updating device links
Date: Thu, 23 Nov 2023 14:28:36 +0100
Message-ID: <20231123132835.486026-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <2023112330-squealer-strife-0ecc@gregkh>
References: <2023112330-squealer-strife-0ecc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2333; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=tLqLw9nPrNrHmGPU3gYP04t83UUZBzC03u1RcLJXdrU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlX1OEBUv0BYWTJWkhz5+E3cAZaukruZC5RYugd xyC4DrbaPOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZV9ThAAKCRCPgPtYfRL+ Tp7ZCACnVwD2VxDr+Rsfo5/nlLnABYb3rOEtj90/VrhBqSoYv57yAa0GX+xx2ybBdXPZclif0lo IMp7j7e3toEt3BYJSXhMQLT7ovfbyQ7iqfror6J0hzMhyrc80EVId7ssVB1YHW9IaG1XQWBglzP 3D/2IUdQKrDdAZxqQ2Td77Z779LK5vo+B/RrTazNCrhRt1T+1kcB4kjQLqBe9+tEx9DY/J8+Mpd w5wuvQt7pfypSjP6pHC7QFInu8ASF0s0mqmxdX/Y1VmFppv+NDwOTk1Thnk4A8KEN6b05e+j7zD 14X6g/y+fgXvPejn/zWQcHD3PcnVhj7OL2TUpWGpXzBAeHZ5
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

From: Saravana Kannan <saravanak@google.com>

[ Upstream commit 2e84dc37920012b458e9458b19fc4ed33f81bc74 ]

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
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

this needed some conflict resolution around commit
9ad307213fa4 ("driver core: Refactor multiple copies of device
cleanup").

Best regards
Uwe

 drivers/base/dd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index ab0b2eb5fa07..0bd166ad6f13 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1228,8 +1228,6 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 		else if (drv->remove)
 			drv->remove(dev);
 
-		device_links_driver_cleanup(dev);
-
 		devres_release_all(dev);
 		arch_teardown_dma_ops(dev);
 		kfree(dev->dma_range_map);
@@ -1241,6 +1239,8 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 		pm_runtime_reinit(dev);
 		dev_pm_set_driver_flags(dev, 0);
 
+		device_links_driver_cleanup(dev);
+
 		klist_remove(&dev->p->knode_driver);
 		device_pm_check_callbacks(dev);
 		if (dev->bus)

base-commit: 2a910f4af54d11deaefdc445f895724371645a97
-- 
2.42.0


