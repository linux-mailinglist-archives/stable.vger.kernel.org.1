Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AF779B734
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238725AbjIKUyT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240697AbjIKOvU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:51:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED91B118
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:51:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E203C433C8;
        Mon, 11 Sep 2023 14:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443875;
        bh=uW839yjgBrJH69SABTORs4Y1Y40egSKZx8GMpQZqB30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BMNdWacNoU1pZZLB1wsbofd73xvq8/20V4jhW0Y8D7QlmEC691qDUEEaM3uLiLcx7
         1k1Uvfav88vKfPklIsymOWN1cDczA/Ve9YT4B5w3ULxhkgvUfGsl+C06LfUpqPpcDJ
         MeArnZGm5RYMOKH/2XV9bnZXP0VDBUJDhNwJEVnk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zenghui Yu <yuzenghui@huawei.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 532/737] driver core: Call dma_cleanup() on the test_remove path
Date:   Mon, 11 Sep 2023 15:46:31 +0200
Message-ID: <20230911134705.434228533@linuxfoundation.org>
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

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit f429378a9bf84d79a7e2cae05d2e3384cf7d68ba ]

When test_remove is enabled really_probe() does not properly pair
dma_configure() with dma_remove(), it will end up calling dma_configure()
twice. This corrupts the owner_cnt and renders the group unusable with
VFIO/etc.

Add the missing cleanup before going back to re_probe.

Fixes: 25f3bcfc54bc ("driver core: Add dma_cleanup callback in bus_type")
Reported-by: Zenghui Yu <yuzenghui@huawei.com>
Tested-by: Zenghui Yu <yuzenghui@huawei.com>
Closes: https://lore.kernel.org/all/6472f254-c3c4-8610-4a37-8d9dfdd54ce8@huawei.com/
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/0-v2-4deed94e283e+40948-really_probe_dma_cleanup_jgg@nvidia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/dd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9c09ca5c4ab68..7145d9b940b14 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -693,6 +693,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 
 		device_remove(dev);
 		driver_sysfs_remove(dev);
+		if (dev->bus && dev->bus->dma_cleanup)
+			dev->bus->dma_cleanup(dev);
 		device_unbind_cleanup(dev);
 
 		goto re_probe;
-- 
2.40.1



