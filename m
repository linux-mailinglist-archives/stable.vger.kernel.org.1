Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B753A7ECF66
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbjKOTsO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbjKOTsN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:48:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E74AB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:48:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1E2C433C8;
        Wed, 15 Nov 2023 19:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077689;
        bh=z7QuIdLpA6UyqVG21L0xByF246Itg0y/SBDtwA+BCmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FLd4c6mPI5DXr6wIhq/lm+JBL2FxiaiJcnDE05RylwTWZOmGZr8OrviW0oggNi8J0
         IOBo5t+hmzVx9ndZlxlz3IWzwakzUqhKq8iHIKQxYNPCSNvBH1Va6BhJzV1I2z26We
         pqCZDXetkuGSvvdscBOt5N23+rYtTFvyYbsSMkhM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Georgi Djakov <djakov@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 458/603] interconnect: qcom: osm-l3: Replace custom implementation of COUNT_ARGS()
Date:   Wed, 15 Nov 2023 14:16:43 -0500
Message-ID: <20231115191644.325755564@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 577a3c5af1fe87b65931ea94d5515266da301f56 ]

Replace custom and non-portable implementation of COUNT_ARGS().

Fixes: 5bc9900addaf ("interconnect: qcom: Add OSM L3 interconnect provider support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20230920154927.2090732-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Georgi Djakov <djakov@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/interconnect/qcom/osm-l3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index dc321bb86d0be..e97478bbc2825 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/args.h>
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/interconnect-provider.h>
@@ -78,7 +79,7 @@ enum {
 		.name = #_name,						\
 		.id = _id,						\
 		.buswidth = _buswidth,					\
-		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\
+		.num_links = COUNT_ARGS(__VA_ARGS__),			\
 		.links = { __VA_ARGS__ },				\
 	}
 
-- 
2.42.0



