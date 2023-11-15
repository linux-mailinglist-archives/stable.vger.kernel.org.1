Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E83E7ED451
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344710AbjKOU5o (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344589AbjKOU53 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:57:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9681ED75
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDADC36AEE;
        Wed, 15 Nov 2023 20:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081384;
        bh=DWDdbniHQjxDVCy4DXVl/gFyeN3QnowM7X+49RaH5/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I4IdvvdqTWVlUI/6t2f89wt5NFjf3An1UnT7Nlr3aqjzDXXQVUuAvb4eIYUo3lU3A
         OFVsfjgrmfGthd5VeDz5cMXl8YAqiybefy6pZXOJ3hr7OJJktXSh+5Tji7ndNnN9w4
         ZPp5aNS7CAmm1yC88GJAewXCJZeCnkYCcplXzq8s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sudeep Holla <sudeep.holla@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 121/244] firmware: arm_ffa: Assign the missing IDR allocation ID to the FFA device
Date:   Wed, 15 Nov 2023 15:35:13 -0500
Message-ID: <20231115203555.611496428@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudeep Holla <sudeep.holla@arm.com>

[ Upstream commit 7d0bc6360f17ea323ab25939a34857123d7d87e5 ]

Commit 19b8766459c4 ("firmware: arm_ffa: Fix FFA device names for logical
partitions") added an ID to the FFA device using ida_alloc() and append
the same to "arm-ffa" to make up a unique device name. However it missed
to stash the id value in ffa_dev to help freeing the ID later when the
device is destroyed.

Due to the missing/unassigned ID in FFA device, we get the following
warning when the FF-A device is unregistered.

  |   ida_free called for id=0 which is not allocated.
  |   WARNING: CPU: 7 PID: 1 at lib/idr.c:525 ida_free+0x114/0x164
  |   CPU: 7 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc4 #209
  |   pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
  |   pc : ida_free+0x114/0x164
  |   lr : ida_free+0x114/0x164
  |   Call trace:
  |    ida_free+0x114/0x164
  |    ffa_release_device+0x24/0x3c
  |    device_release+0x34/0x8c
  |    kobject_put+0x94/0xf8
  |    put_device+0x18/0x24
  |    klist_devices_put+0x14/0x20
  |    klist_next+0xc8/0x114
  |    bus_for_each_dev+0xd8/0x144
  |    arm_ffa_bus_exit+0x30/0x54
  |    ffa_init+0x68/0x330
  |    do_one_initcall+0xdc/0x250
  |    do_initcall_level+0x8c/0xac
  |    do_initcalls+0x54/0x94
  |    do_basic_setup+0x1c/0x28
  |    kernel_init_freeable+0x104/0x170
  |    kernel_init+0x20/0x1a0
  |    ret_from_fork+0x10/0x20

Fix the same by actually assigning the ID in the FFA device this time
for real.

Fixes: 19b8766459c4 ("firmware: arm_ffa: Fix FFA device names for logical partitions")
Link: https://lore.kernel.org/r/20231003085932.3553985-1-sudeep.holla@arm.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_ffa/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
index edef31c413123..f79ba6f733ba4 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -192,6 +192,7 @@ struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id)
 	dev->release = ffa_release_device;
 	dev_set_name(&ffa_dev->dev, "arm-ffa-%d", id);
 
+	ffa_dev->id = id;
 	ffa_dev->vm_id = vm_id;
 	uuid_copy(&ffa_dev->uuid, uuid);
 
-- 
2.42.0



