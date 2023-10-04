Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747827B8899
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244102AbjJDSRq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244105AbjJDSRl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:17:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8AFAD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:17:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D5CC433C8;
        Wed,  4 Oct 2023 18:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443458;
        bh=veujR2mR8JrqPxGYA6znc38fs1IJ24iXxgooJ5FujLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AnzVYbSrcsqacrlZquL+UrspdSt8WO3vHtFt+78XQHs+QRim3fBkp7oWaWzCoSUUF
         Kqe8gkZ3Udso9NUgpNYTNG0RnZMaWIqBqh4tjjsyLQt6y3HFLINQRHUGQZiPq+OXLj
         aTv39q4R1NVXJkVYqXaT3dxcRTyu2BWFxLgl3g7Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 164/259] thermal/of: add missing of_node_put()
Date:   Wed,  4 Oct 2023 19:55:37 +0200
Message-ID: <20231004175224.814932492@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julia Lawall <Julia.Lawall@inria.fr>

[ Upstream commit 8a81cf96f5510aaf9a65d103f7405079a7b0fcc5 ]

for_each_child_of_node performs an of_node_get on each
iteration, so a break out of the loop requires an
of_node_put.

This was done using the Coccinelle semantic patch
iterators/for_each_child.cocci

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/thermal_of.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 762d1990180bf..4104743dbc17e 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -149,8 +149,10 @@ static int of_find_trip_id(struct device_node *np, struct device_node *trip)
 	 */
 	for_each_child_of_node(trips, t) {
 
-		if (t == trip)
+		if (t == trip) {
+			of_node_put(t);
 			goto out;
+		}
 		i++;
 	}
 
@@ -519,8 +521,10 @@ static int thermal_of_for_each_cooling_maps(struct thermal_zone_device *tz,
 
 	for_each_child_of_node(cm_np, child) {
 		ret = thermal_of_for_each_cooling_device(tz_np, child, tz, cdev, action);
-		if (ret)
+		if (ret) {
+			of_node_put(child);
 			break;
+		}
 	}
 
 	of_node_put(cm_np);
-- 
2.40.1



