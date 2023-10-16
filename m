Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0567CA237
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjJPIrR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjJPIrJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:47:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE0A100
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:47:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1427C433C8;
        Mon, 16 Oct 2023 08:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446027;
        bh=D/DD6p8aJu2p43d1jK04WO5V7PJdcnirepauJJKRvV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dqTemZ3Xt4cfU5yHjP4UPqVh1oJD79bfQA+j0p6KslV3dv4XIBVEotj6mBPyis6ON
         NzgAVaCMnIbLSUNK29egR9P7x48NoLeWuDtXL8i8js8VHn2EVUMfEH6Fy00WaJIR8V
         +abaG4gZOEgiVt6oaGqKAmApLG0t9mfDCNo/RMes=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>,
        Jose Javier Rodriguez Barbarin 
        <JoseJavier.Rodriguez@duagon.com>
Subject: [PATCH 5.15 062/102] mcb: remove is_added flag from mcb_device struct
Date:   Mon, 16 Oct 2023 10:41:01 +0200
Message-ID: <20231016083955.356970762@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>

commit 0f28ada1fbf0054557cddcdb93ad17f767105208 upstream.

When calling mcb_bus_add_devices(), both mcb devices and the mcb
bus will attempt to attach a device to a driver because they share
the same bus_type. This causes an issue when trying to cast the
container of the device to mcb_device struct using to_mcb_device(),
leading to a wrong cast when the mcb_bus is added. A crash occurs
when freing the ida resources as the bus numbering of mcb_bus gets
confused with the is_added flag on the mcb_device struct.

The only reason for this cast was to keep an is_added flag on the
mcb_device struct that does not seem necessary. The function
device_attach() handles already bound devices and the mcb subsystem
does nothing special with this is_added flag so remove it completely.

Fixes: 18d288198099 ("mcb: Correctly initialize the bus's device")
Cc: stable <stable@kernel.org>
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Co-developed-by: Jose Javier Rodriguez Barbarin <JoseJavier.Rodriguez@duagon.com>
Signed-off-by: Jose Javier Rodriguez Barbarin <JoseJavier.Rodriguez@duagon.com>
Link: https://lore.kernel.org/r/20230906114901.63174-2-JoseJavier.Rodriguez@duagon.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mcb/mcb-core.c  |   10 +++-------
 drivers/mcb/mcb-parse.c |    2 --
 include/linux/mcb.h     |    1 -
 3 files changed, 3 insertions(+), 10 deletions(-)

--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -387,17 +387,13 @@ EXPORT_SYMBOL_NS_GPL(mcb_free_dev, MCB);
 
 static int __mcb_bus_add_devices(struct device *dev, void *data)
 {
-	struct mcb_device *mdev = to_mcb_device(dev);
 	int retval;
 
-	if (mdev->is_added)
-		return 0;
-
 	retval = device_attach(dev);
-	if (retval < 0)
+	if (retval < 0) {
 		dev_err(dev, "Error adding device (%d)\n", retval);
-
-	mdev->is_added = true;
+		return retval;
+	}
 
 	return 0;
 }
--- a/drivers/mcb/mcb-parse.c
+++ b/drivers/mcb/mcb-parse.c
@@ -99,8 +99,6 @@ static int chameleon_parse_gdd(struct mc
 	mdev->mem.end = mdev->mem.start + size - 1;
 	mdev->mem.flags = IORESOURCE_MEM;
 
-	mdev->is_added = false;
-
 	ret = mcb_device_register(bus, mdev);
 	if (ret < 0)
 		goto err;
--- a/include/linux/mcb.h
+++ b/include/linux/mcb.h
@@ -63,7 +63,6 @@ static inline struct mcb_bus *to_mcb_bus
 struct mcb_device {
 	struct device dev;
 	struct mcb_bus *bus;
-	bool is_added;
 	struct mcb_driver *driver;
 	u16 id;
 	int inst;


