Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836307B8A1B
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244354AbjJDScU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244352AbjJDScU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:32:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B28AD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:32:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F30C433C8;
        Wed,  4 Oct 2023 18:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444335;
        bh=qwSHBLVHGysUxDFLdkdtnFAjEqOOitIJ9SqcAcnW7Zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YUeXtg66jQ9icJgEp9jicF5u402+rrN1Bu+OjCWWqJdYiQlIAqtQ8t8Kz/lMCWQMN
         Iuxpeo5TVa5lKnifX7X+RnT/uYgeZHpYeR4u5kcrJl7uZPGBFWEgC85figs6A6YmwM
         YR2XyV36JzWHHAs4fnWCUtQkyRTzKV6gmTKrumIM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 185/321] thermal/of: add missing of_node_put()
Date:   Wed,  4 Oct 2023 19:55:30 +0200
Message-ID: <20231004175237.816635201@linuxfoundation.org>
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
index 22272f9c5934a..e615f735f4c03 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -38,8 +38,10 @@ static int of_find_trip_id(struct device_node *np, struct device_node *trip)
 	 */
 	for_each_child_of_node(trips, t) {
 
-		if (t == trip)
+		if (t == trip) {
+			of_node_put(t);
 			goto out;
+		}
 		i++;
 	}
 
@@ -402,8 +404,10 @@ static int thermal_of_for_each_cooling_maps(struct thermal_zone_device *tz,
 
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



