Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832DA76AFDF
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjHAJux (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbjHAJue (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:50:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3196010D4
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:50:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86184614CF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F31C433C9;
        Tue,  1 Aug 2023 09:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883410;
        bh=Z7TSNV8cXtAZxZkEH7Hy7LaKYVa29YFgvCP6UpOG0nM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QK1MU0n8Aq3IolvOaT4NBkzC674bf9hw8WglYl33r5j0AYCCL69FzyAtVAxJrAGqe
         WiJmbb76Gd9Vcw9HwG/fgL4TmpMPp8kvVHm9PahGenk4cUzii4jndK/NZcphEzYRaQ
         +t9n5PcX4+CV3QYrTRPxNSkLZPDsEdurtxsZHYMQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.4 227/239] thermal: of: fix double-free on unregistration
Date:   Tue,  1 Aug 2023 11:21:31 +0200
Message-ID: <20230801091934.136790169@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ahmad Fatoum <a.fatoum@pengutronix.de>

commit ac4436a5b20e0ef1f608a9ef46c08d5d142f8da6 upstream.

Since commit 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal
zone parameters structure"), thermal_zone_device_register() allocates
a copy of the tzp argument and frees it when unregistering, so
thermal_of_zone_register() now ends up leaking its original tzp and
double-freeing the tzp copy. Fix this by locating tzp on stack instead.

Fixes: 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone parameters structure")
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: 6.4+ <stable@vger.kernel.org> # 6.4+: 8bcbb18c61d6: thermal: core: constify params in thermal_zone_device_register
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thermal/thermal_of.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 6fb14e521197..bc07ae1c284c 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -238,17 +238,13 @@ static int thermal_of_monitor_init(struct device_node *np, int *delay, int *pdel
 	return 0;
 }
 
-static struct thermal_zone_params *thermal_of_parameters_init(struct device_node *np)
+static void thermal_of_parameters_init(struct device_node *np,
+				       struct thermal_zone_params *tzp)
 {
-	struct thermal_zone_params *tzp;
 	int coef[2];
 	int ncoef = ARRAY_SIZE(coef);
 	int prop, ret;
 
-	tzp = kzalloc(sizeof(*tzp), GFP_KERNEL);
-	if (!tzp)
-		return ERR_PTR(-ENOMEM);
-
 	tzp->no_hwmon = true;
 
 	if (!of_property_read_u32(np, "sustainable-power", &prop))
@@ -267,8 +263,6 @@ static struct thermal_zone_params *thermal_of_parameters_init(struct device_node
 
 	tzp->slope = coef[0];
 	tzp->offset = coef[1];
-
-	return tzp;
 }
 
 static struct device_node *thermal_of_zone_get_by_name(struct thermal_zone_device *tz)
@@ -442,13 +436,11 @@ static int thermal_of_unbind(struct thermal_zone_device *tz,
 static void thermal_of_zone_unregister(struct thermal_zone_device *tz)
 {
 	struct thermal_trip *trips = tz->trips;
-	struct thermal_zone_params *tzp = tz->tzp;
 	struct thermal_zone_device_ops *ops = tz->ops;
 
 	thermal_zone_device_disable(tz);
 	thermal_zone_device_unregister(tz);
 	kfree(trips);
-	kfree(tzp);
 	kfree(ops);
 }
 
@@ -477,7 +469,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 {
 	struct thermal_zone_device *tz;
 	struct thermal_trip *trips;
-	struct thermal_zone_params *tzp;
+	struct thermal_zone_params tzp = {};
 	struct thermal_zone_device_ops *of_ops;
 	struct device_node *np;
 	int delay, pdelay;
@@ -509,12 +501,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 		goto out_kfree_trips;
 	}
 
-	tzp = thermal_of_parameters_init(np);
-	if (IS_ERR(tzp)) {
-		ret = PTR_ERR(tzp);
-		pr_err("Failed to initialize parameter from %pOFn: %d\n", np, ret);
-		goto out_kfree_trips;
-	}
+	thermal_of_parameters_init(np, &tzp);
 
 	of_ops->bind = thermal_of_bind;
 	of_ops->unbind = thermal_of_unbind;
@@ -522,12 +509,12 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 	mask = GENMASK_ULL((ntrips) - 1, 0);
 
 	tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
-						     mask, data, of_ops, tzp,
+						     mask, data, of_ops, &tzp,
 						     pdelay, delay);
 	if (IS_ERR(tz)) {
 		ret = PTR_ERR(tz);
 		pr_err("Failed to register thermal zone %pOFn: %d\n", np, ret);
-		goto out_kfree_tzp;
+		goto out_kfree_trips;
 	}
 
 	ret = thermal_zone_device_enable(tz);
@@ -540,8 +527,6 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 
 	return tz;
 
-out_kfree_tzp:
-	kfree(tzp);
 out_kfree_trips:
 	kfree(trips);
 out_kfree_of_ops:
-- 
2.41.0



