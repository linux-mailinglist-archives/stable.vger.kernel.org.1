Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631B879B40B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbjIKWum (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239958AbjIKOc2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:32:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7E7F2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:32:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91D4C433C7;
        Mon, 11 Sep 2023 14:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442744;
        bh=0p49XxBF8dgaYqUHoN3DgzKigf3U/06afSfBfmz9HWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B8PHJms6L0j7KZ4MOT3S920gmKiG2CCxkOjReWNTGbZSaG9oYmvbiJBDxlm1GLuOa
         GIjSLJC4MNAL+zLhXcfoHunxLodG1zuxaNXWD6MRZMYwloMHUrjwOoPsevrWzURvsW
         Ltf1/x89+F4+sQYGsK5daLiRO9dTWaQOf1qHx2u0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peng Fan <peng.fan@nxp.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 133/737] thermal/of: Fix potential uninitialized value access
Date:   Mon, 11 Sep 2023 15:39:52 +0200
Message-ID: <20230911134654.216443442@linuxfoundation.org>
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

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit f96801f0cfcefc0a16b146596577c53c75ee9773 ]

If of_parse_phandle_with_args() called from __thermal_of_bind() or
__thermal_of_unbind() fails, cooling_spec.np will not be initialized,
so move the of_node_put() calls below the respective return value checks
to avoid dereferencing an uninitialized pointer.

Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initialization")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
[ rjw: Subject and changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/thermal_of.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index bc07ae1c284cf..22272f9c5934a 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -292,13 +292,13 @@ static int __thermal_of_unbind(struct device_node *map_np, int index, int trip_i
 	ret = of_parse_phandle_with_args(map_np, "cooling-device", "#cooling-cells",
 					 index, &cooling_spec);
 
-	of_node_put(cooling_spec.np);
-
 	if (ret < 0) {
 		pr_err("Invalid cooling-device entry\n");
 		return ret;
 	}
 
+	of_node_put(cooling_spec.np);
+
 	if (cooling_spec.args_count < 2) {
 		pr_err("wrong reference to cooling device, missing limits\n");
 		return -EINVAL;
@@ -325,13 +325,13 @@ static int __thermal_of_bind(struct device_node *map_np, int index, int trip_id,
 	ret = of_parse_phandle_with_args(map_np, "cooling-device", "#cooling-cells",
 					 index, &cooling_spec);
 
-	of_node_put(cooling_spec.np);
-
 	if (ret < 0) {
 		pr_err("Invalid cooling-device entry\n");
 		return ret;
 	}
 
+	of_node_put(cooling_spec.np);
+
 	if (cooling_spec.args_count < 2) {
 		pr_err("wrong reference to cooling device, missing limits\n");
 		return -EINVAL;
-- 
2.40.1



