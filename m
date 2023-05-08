Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3512D6FAAED
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjEHLIA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjEHLHp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:07:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02E029C84
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:06:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 736D262AB4
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E09C4339C;
        Mon,  8 May 2023 11:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544014;
        bh=fFyPfRN7SKtNCXDgYca5B2esR3kaPFlmqjZcsAxYCuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zxdf4raH4ArD3jUght5PXZHRQWi7v9RmC4PMB7s36QNuhRnn4Yrr5sCPmzbgK6QYz
         rzGylyMklwe73qjnUzwd84bJNqhfTI3QrUPrsxUkuN+KfFo+XwSXltKnt3HqjmTB1+
         RsYmMifcPRjhDB42vZlaSnWSiYCo5AzN6U8VO4qU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yang Yingliang <yangyingliang@huawei.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 247/694] gpu: host1x: Fix memory leak of device names
Date:   Mon,  8 May 2023 11:41:22 +0200
Message-Id: <20230508094440.323386860@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit 55879dad0f3ae8468444b42f785ad79eac05fe5b ]

The device names allocated by dev_set_name() need be freed
before module unloading, but they can not be freed because
the kobject's refcount which was set in device_initialize()
has not be decreased to 0.

As comment of device_add() says, if it fails, use only
put_device() drop the refcount, then the name will be
freed in kobejct_cleanup().

device_del() and put_device() can be replaced with
device_unregister(), so call it to unregister the added
successfully devices, and just call put_device() to the
not added device.

Add a release() function to device to avoid null release()
function WARNING in device_release(), it's empty, because
the context devices are freed together in
host1x_memory_context_list_free().

Fixes: 8aa5bcb61612 ("gpu: host1x: Add context device management code")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/host1x/context.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/host1x/context.c b/drivers/gpu/host1x/context.c
index 5ec18315ff9fe..9ad89d22c0ca7 100644
--- a/drivers/gpu/host1x/context.c
+++ b/drivers/gpu/host1x/context.c
@@ -13,6 +13,11 @@
 #include "context.h"
 #include "dev.h"
 
+static void host1x_memory_context_release(struct device *dev)
+{
+	/* context device is freed in host1x_memory_context_list_free() */
+}
+
 int host1x_memory_context_list_init(struct host1x *host1x)
 {
 	struct host1x_memory_context_list *cdl = &host1x->context_list;
@@ -51,36 +56,38 @@ int host1x_memory_context_list_init(struct host1x *host1x)
 		dev_set_name(&ctx->dev, "host1x-ctx.%d", i);
 		ctx->dev.bus = &host1x_context_device_bus_type;
 		ctx->dev.parent = host1x->dev;
+		ctx->dev.release = host1x_memory_context_release;
 
 		dma_set_max_seg_size(&ctx->dev, UINT_MAX);
 
 		err = device_add(&ctx->dev);
 		if (err) {
 			dev_err(host1x->dev, "could not add context device %d: %d\n", i, err);
-			goto del_devices;
+			put_device(&ctx->dev);
+			goto unreg_devices;
 		}
 
 		err = of_dma_configure_id(&ctx->dev, node, true, &i);
 		if (err) {
 			dev_err(host1x->dev, "IOMMU configuration failed for context device %d: %d\n",
 				i, err);
-			device_del(&ctx->dev);
-			goto del_devices;
+			device_unregister(&ctx->dev);
+			goto unreg_devices;
 		}
 
 		if (!tegra_dev_iommu_get_stream_id(&ctx->dev, &ctx->stream_id) ||
 		    !device_iommu_mapped(&ctx->dev)) {
 			dev_err(host1x->dev, "Context device %d has no IOMMU!\n", i);
-			device_del(&ctx->dev);
-			goto del_devices;
+			device_unregister(&ctx->dev);
+			goto unreg_devices;
 		}
 	}
 
 	return 0;
 
-del_devices:
+unreg_devices:
 	while (i--)
-		device_del(&cdl->devs[i].dev);
+		device_unregister(&cdl->devs[i].dev);
 
 	kfree(cdl->devs);
 	cdl->devs = NULL;
@@ -94,7 +101,7 @@ void host1x_memory_context_list_free(struct host1x_memory_context_list *cdl)
 	unsigned int i;
 
 	for (i = 0; i < cdl->len; i++)
-		device_del(&cdl->devs[i].dev);
+		device_unregister(&cdl->devs[i].dev);
 
 	kfree(cdl->devs);
 	cdl->len = 0;
-- 
2.39.2



