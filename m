Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0711E755666
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjGPUuK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjGPUuJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:50:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ADCD9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:50:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4947260E2C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59557C433C7;
        Sun, 16 Jul 2023 20:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540607;
        bh=TtuAcwGF+FjYDvAWyJdys7g8NcI51RQa76ZTaqls5ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J8vPrIervzCzQxQC0INbOpQYJpyoeMDyP/VVGCd8xGZdbXxaiUU2FLQQw62vv3GdT
         5e7VxY4idiUgSgS6Q+hkpiUN8NuHRh8RU8rq0BkVTFfw5rHpWivkwO6YE0rJswL5sD
         /WubDitT4K4T90eKmm3SWun4Xa0kOOC3a6lnvJVM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 423/591] coresight: Fix loss of connection info when a module is unloaded
Date:   Sun, 16 Jul 2023 21:49:22 +0200
Message-ID: <20230716194934.859408389@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: James Clark <james.clark@arm.com>

[ Upstream commit c45b2835e7b205783bdfe08cc98fa86a7c5eeb74 ]

child_fwnode should be a read only property based on the DT or ACPI. If
it's cleared on the parent device when a child is unloaded, then when
the child is loaded again the connection won't be remade.

child_dev should be cleared instead which signifies that the connection
should be remade when the child_fwnode registers a new coresight_device.

Similarly the reference count shouldn't be decremented as long as the
parent device exists. The correct place to drop the reference is in
coresight_release_platform_data() which is already done.

Reproducible on Juno with the following steps:

  # load all coresight modules.
  $ cd /sys/bus/coresight/devices/
  $ echo 1 > tmc_etr0/enable_sink
  $ echo 1 > etm0/enable_source
  # Works fine ^

  $ echo 0 > etm0/enable_source
  $ rmmod coresight-funnel
  $ modprobe coresight-funnel
  $ echo 1 > etm0/enable_source
  -bash: echo: write error: Invalid argument

Fixes: 37ea1ffddffa ("coresight: Use fwnode handle instead of device names")
Fixes: 2af89ebacf29 ("coresight: Clear the connection field properly")
Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20230425143542.2305069-2-james.clark@arm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight-core.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index f3068175ca9d9..bcb08fadccf21 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1446,13 +1446,8 @@ static int coresight_remove_match(struct device *dev, void *data)
 		if (csdev->dev.fwnode == conn->child_fwnode) {
 			iterator->orphan = true;
 			coresight_remove_links(iterator, conn);
-			/*
-			 * Drop the reference to the handle for the remote
-			 * device acquired in parsing the connections from
-			 * platform data.
-			 */
-			fwnode_handle_put(conn->child_fwnode);
-			conn->child_fwnode = NULL;
+
+			conn->child_dev = NULL;
 			/* No need to continue */
 			break;
 		}
-- 
2.39.2



