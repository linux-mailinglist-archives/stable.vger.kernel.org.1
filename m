Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE506FA56F
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbjEHKJ0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbjEHKJZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:09:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEC13292B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:09:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E89CF6239C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A480C433EF;
        Mon,  8 May 2023 10:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540563;
        bh=m2MAVz1sFRRcDP0NOl/MARcnCO2Q+y+I1t5a6wLEScU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OW25dm6qZJ+1oBMZ27GVwd4bZASIaBNeZQqM5dpIT01e5ag3bmbA/WBkb/oE/3UKH
         M4d1gVCeWzQIZPmw4R3ivHt84+13MMf3LKqd/4Hsqp2/JPZE4BXDplrH3ZaaF/VxaH
         6O++yzwDk6V6wwfOFXqAayiIqvLTfNRSIlEDVp+8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zheng Wang <zyytlz.wz@163.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 411/611] usb: gadget: udc: renesas_usb3: Fix use after free bug in renesas_usb3_remove due to race condition
Date:   Mon,  8 May 2023 11:44:13 +0200
Message-Id: <20230508094435.601676969@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zheng Wang <zyytlz.wz@163.com>

[ Upstream commit 2b947f8769be8b8181dc795fd292d3e7120f5204 ]

In renesas_usb3_probe, role_work is bound with renesas_usb3_role_work.
renesas_usb3_start will be called to start the work.

If we remove the driver which will call usbhs_remove, there may be
an unfinished work. The possible sequence is as follows:

CPU0                  			CPU1

                    			 renesas_usb3_role_work
renesas_usb3_remove
usb_role_switch_unregister
device_unregister
kfree(sw)
//free usb3->role_sw
                    			 usb_role_switch_set_role
                    			 //use usb3->role_sw

The usb3->role_sw could be freed under such circumstance and then
used in usb_role_switch_set_role.

This bug was found by static analysis. And note that removing a
driver is a root-only operation, and should never happen in normal
case. But the root user may directly remove the device which
will also trigger the remove function.

Fix it by canceling the work before cleanup in the renesas_usb3_remove.

Fixes: 39facfa01c9f ("usb: gadget: udc: renesas_usb3: Add register of usb role switch")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20230320062931.505170-1-zyytlz.wz@163.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/renesas_usb3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index 615ba0a6fbee1..32c9e369216c9 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2596,6 +2596,7 @@ static int renesas_usb3_remove(struct platform_device *pdev)
 	debugfs_remove_recursive(usb3->dentry);
 	device_remove_file(&pdev->dev, &dev_attr_role);
 
+	cancel_work_sync(&usb3->role_work);
 	usb_role_switch_unregister(usb3->role_sw);
 
 	usb_del_gadget_udc(&usb3->gadget);
-- 
2.39.2



