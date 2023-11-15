Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBF17ED156
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344138AbjKOUBA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344141AbjKOUA5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:00:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92DBD40
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:00:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BAAC433C9;
        Wed, 15 Nov 2023 20:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078453;
        bh=l19/Vz3ai7rKLktu1bUDF4y7gJZ4tqLVR4xL/ej9/1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zpvqnTsxeBtYwct3uADoD4QmuEKWaIoWblcXcwnGrKAH5HhhfuQhYqJzvpb0v6jU8
         VACsw3CISFvDJvL8P7s8ucGrHdh0JNoofv+KI/HQq/wh1SA8r4XgIlgLxtqnktftYw
         LZOsKo48vViqbd5HWtlAjjTGx9WoI7w4GLLtRmzM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 306/379] cxl/mem: Fix shutdown order
Date:   Wed, 15 Nov 2023 14:26:21 -0500
Message-ID: <20231115192703.250704120@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

[ Upstream commit 88d3917f82ed4215a2154432c26de1480a61b209 ]

Ira reports that removing cxl_mock_mem causes a crash with the following
trace:

 BUG: kernel NULL pointer dereference, address: 0000000000000044
 [..]
 RIP: 0010:cxl_region_decode_reset+0x7f/0x180 [cxl_core]
 [..]
 Call Trace:
  <TASK>
  cxl_region_detach+0xe8/0x210 [cxl_core]
  cxl_decoder_kill_region+0x27/0x40 [cxl_core]
  cxld_unregister+0x29/0x40 [cxl_core]
  devres_release_all+0xb8/0x110
  device_unbind_cleanup+0xe/0x70
  device_release_driver_internal+0x1d2/0x210
  bus_remove_device+0xd7/0x150
  device_del+0x155/0x3e0
  device_unregister+0x13/0x60
  devm_release_action+0x4d/0x90
  ? __pfx_unregister_port+0x10/0x10 [cxl_core]
  delete_endpoint+0x121/0x130 [cxl_core]
  devres_release_all+0xb8/0x110
  device_unbind_cleanup+0xe/0x70
  device_release_driver_internal+0x1d2/0x210
  bus_remove_device+0xd7/0x150
  device_del+0x155/0x3e0
  ? lock_release+0x142/0x290
  cdev_device_del+0x15/0x50
  cxl_memdev_unregister+0x54/0x70 [cxl_core]

This crash is due to the clearing out the cxl_memdev's driver context
(@cxlds) before the subsystem is done with it. This is ultimately due to
the region(s), that this memdev is a member, being torn down and expecting
to be able to de-reference @cxlds, like here:

static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
...
                if (cxlds->rcd)
                        goto endpoint_reset;
...

Fix it by keeping the driver context valid until memdev-device
unregistration, and subsequently the entire stack of related
dependencies, unwinds.

Fixes: 9cc238c7a526 ("cxl/pci: Introduce cdevm_file_operations")
Reported-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Tested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/memdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 20ce488a77540..03cf99cce7047 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -214,8 +214,8 @@ static void cxl_memdev_unregister(void *_cxlmd)
 	struct cxl_memdev *cxlmd = _cxlmd;
 	struct device *dev = &cxlmd->dev;
 
-	cxl_memdev_shutdown(dev);
 	cdev_device_del(&cxlmd->cdev, dev);
+	cxl_memdev_shutdown(dev);
 	put_device(dev);
 }
 
-- 
2.42.0



