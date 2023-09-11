Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD36B79AE3A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbjIKUw6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239713AbjIKO1B (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:27:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39EFF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:26:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD32C433C8;
        Mon, 11 Sep 2023 14:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442416;
        bh=wbl3+nvvvlh5fLKyKFDvOHJ8V3bKIeBGQgmB6yGeT74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n4jUOKGVpvwTmtDVdkztdSGp/6m1HV12YSohp3EVC9qRmFKHtkxbSq8paP0gEfhP6
         4ibe0inDYmFmy/vbZGZ87zbullaCBVUHi0+48yxx1RUp1qewcxMYTuOAfC6WajPvrN
         jTIxxrjbAsvVqdDl2SMAiTJ8LPTkNdbagFiAFtVc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 018/737] thermal: core: constify params in thermal_zone_device_register
Date:   Mon, 11 Sep 2023 15:37:57 +0200
Message-ID: <20230911134650.850514011@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ahmad Fatoum <a.fatoum@pengutronix.de>

[ Upstream commit 80ddce5f2dbd0e83eadc9f9d373439180d599fe5 ]

Since commit 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone
parameters structure"), thermal_zone_device_register() allocates a copy
of the tzp argument and callers need not explicitly manage its lifetime.

This means the function no longer cares about the parameter being
mutable, so constify it.

No functional change.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/thermal_core.c | 4 ++--
 include/linux/thermal.h        | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 842f678c1c3e1..cc2b5e81c6205 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1203,7 +1203,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
 struct thermal_zone_device *
 thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *trips, int num_trips, int mask,
 					void *devdata, struct thermal_zone_device_ops *ops,
-					struct thermal_zone_params *tzp, int passive_delay,
+					const struct thermal_zone_params *tzp, int passive_delay,
 					int polling_delay)
 {
 	struct thermal_zone_device *tz;
@@ -1371,7 +1371,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_device_register_with_trips);
 
 struct thermal_zone_device *thermal_zone_device_register(const char *type, int ntrips, int mask,
 							 void *devdata, struct thermal_zone_device_ops *ops,
-							 struct thermal_zone_params *tzp, int passive_delay,
+							 const struct thermal_zone_params *tzp, int passive_delay,
 							 int polling_delay)
 {
 	return thermal_zone_device_register_with_trips(type, NULL, ntrips, mask,
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 87837094d549f..dee66ade89a03 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -301,14 +301,14 @@ int thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp);
 #ifdef CONFIG_THERMAL
 struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
 		void *, struct thermal_zone_device_ops *,
-		struct thermal_zone_params *, int, int);
+		const struct thermal_zone_params *, int, int);
 
 void thermal_zone_device_unregister(struct thermal_zone_device *);
 
 struct thermal_zone_device *
 thermal_zone_device_register_with_trips(const char *, struct thermal_trip *, int, int,
 					void *, struct thermal_zone_device_ops *,
-					struct thermal_zone_params *, int, int);
+					const struct thermal_zone_params *, int, int);
 
 void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
 const char *thermal_zone_device_type(struct thermal_zone_device *tzd);
@@ -348,7 +348,7 @@ void thermal_zone_device_critical(struct thermal_zone_device *tz);
 static inline struct thermal_zone_device *thermal_zone_device_register(
 	const char *type, int trips, int mask, void *devdata,
 	struct thermal_zone_device_ops *ops,
-	struct thermal_zone_params *tzp,
+	const struct thermal_zone_params *tzp,
 	int passive_delay, int polling_delay)
 { return ERR_PTR(-ENODEV); }
 static inline void thermal_zone_device_unregister(
-- 
2.40.1



