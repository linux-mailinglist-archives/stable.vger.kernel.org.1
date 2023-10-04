Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F627B8A8C
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjJDSgw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244444AbjJDSgX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:36:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32409A6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:36:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7707EC433C9;
        Wed,  4 Oct 2023 18:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444579;
        bh=PngZUPknEplCNHVXu9xljAPYootAslWKSY7pTK5aiBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QyxzsAR4qyGBW+g+9uazEyuhN8xPaStZWLqftKNZh/rOqbcVnw0iV+INwlrANOrTu
         T4KtLfz1cqiQsRozfp73epaAobADjyfLhk3AExaXrGEaOPJhQp4WjdSsI2lCuTfYqF
         Ozh3H2s/UoLJ7jip/jHXYsVsFOimMeHKMI+em+U8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.5 300/321] thermal: sysfs: Fix trip_point_hyst_store()
Date:   Wed,  4 Oct 2023 19:57:25 +0200
Message-ID: <20231004175243.192542461@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit ea3105672c68a5b6d7368504067220682ee6c65c upstream.

After commit 2e38a2a981b2 ("thermal/core: Add a generic thermal_zone_set_trip()
function") updating a trip point temperature doesn't actually work,
because the value supplied by user space is subsequently overwritten
with the current trip point hysteresis value.

Fix this by changing the code to parse the number string supplied by
user space after retrieving the current trip point data from the
thermal zone.

Also drop a redundant tab character from the code in question.

Fixes: 2e38a2a981b2 ("thermal/core: Add a generic thermal_zone_set_trip() function")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: 6.3+ <stable@vger.kernel.org> # 6.3+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thermal/thermal_sysfs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 6c20c9f90a05..4e6a97db894e 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -185,9 +185,6 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) != 1)
 		return -EINVAL;
 
-	if (kstrtoint(buf, 10, &trip.hysteresis))
-		return -EINVAL;
-
 	mutex_lock(&tz->lock);
 
 	if (!device_is_registered(dev)) {
@@ -198,7 +195,11 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 	ret = __thermal_zone_get_trip(tz, trip_id, &trip);
 	if (ret)
 		goto unlock;
-	
+
+	ret = kstrtoint(buf, 10, &trip.hysteresis);
+	if (ret)
+		goto unlock;
+
 	ret = thermal_zone_set_trip(tz, trip_id, &trip);
 unlock:
 	mutex_unlock(&tz->lock);
-- 
2.42.0



