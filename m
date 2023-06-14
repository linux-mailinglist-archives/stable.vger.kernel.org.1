Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366E7713FD5
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjE1Ttg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjE1Tte (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:49:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D9BB1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:49:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE8676201E
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09282C433D2;
        Sun, 28 May 2023 19:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303372;
        bh=yLLjt2jiPzCkqX/nVm6QACF+yHfPd08bej8jwjx9XmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j4vgDP9Y8NxN14i89hft+oTQCXEE1IMsSVbogD9svIRCyDf/TdHsiD2VY9eZyfn6j
         wiFgELO/FK++gu2zNLOSbBw3o+SQrjjyaS49FioHoKPzXCAKzTrwhT+XZ53QSjzGUl
         u1627Auob0xSHYFjEGfpoWcR+ra+vL/581tzfxyM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Lucian Paul-Trifu <lucian.paul-trifu@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 5.15 50/69] firmware: arm_ffa: Fix FFA device names for logical partitions
Date:   Sun, 28 May 2023 20:12:10 +0100
Message-Id: <20230528190830.240509970@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190828.358612414@linuxfoundation.org>
References: <20230528190828.358612414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

commit 19b8766459c41c6f318f8a548cc1c66dffd18363 upstream.

Each physical partition can provide multiple services each with UUID.
Each such service can be presented as logical partition with a unique
combination of VM ID and UUID. The number of distinct UUID in a system
will be less than or equal to the number of logical partitions.

However, currently it fails to register more than one logical partition
or service within a physical partition as the device name contains only
VM ID while both VM ID and UUID are maintained in the partition information.
The kernel complains with the below message:

  | sysfs: cannot create duplicate filename '/devices/arm-ffa-8001'
  | CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.3.0-rc7 #8
  | Hardware name: FVP Base RevC (DT)
  | Call trace:
  |  dump_backtrace+0xf8/0x118
  |  show_stack+0x18/0x24
  |  dump_stack_lvl+0x50/0x68
  |  dump_stack+0x18/0x24
  |  sysfs_create_dir_ns+0xe0/0x13c
  |  kobject_add_internal+0x220/0x3d4
  |  kobject_add+0x94/0x100
  |  device_add+0x144/0x5d8
  |  device_register+0x20/0x30
  |  ffa_device_register+0x88/0xd8
  |  ffa_setup_partitions+0x108/0x1b8
  |  ffa_init+0x2ec/0x3a4
  |  do_one_initcall+0xcc/0x240
  |  do_initcall_level+0x8c/0xac
  |  do_initcalls+0x54/0x94
  |  do_basic_setup+0x1c/0x28
  |  kernel_init_freeable+0x100/0x16c
  |  kernel_init+0x20/0x1a0
  |  ret_from_fork+0x10/0x20
  | kobject_add_internal failed for arm-ffa-8001 with -EEXIST, don't try to
  | register things with the same name in the same directory.
  | arm_ffa arm-ffa: unable to register device arm-ffa-8001 err=-17
  | ARM FF-A: ffa_setup_partitions: failed to register partition ID 0x8001

By virtue of being random enough to avoid collisions when generated in a
distributed system, there is no way to compress UUID keys to the number
of bits required to identify each. We can eliminate '-' in the name but
it is not worth eliminating 4 bytes and add unnecessary logic for doing
that. Also v1.0 doesn't provide the UUID of the partitions which makes
it hard to use the same for the device name.

So to keep it simple, let us alloc an ID using ida_alloc() and append the
same to "arm-ffa" to make up a unique device name. Also stash the id value
in ffa_dev to help freeing the ID later when the device is destroyed.

Fixes: e781858488b9 ("firmware: arm_ffa: Add initial FFA bus support for device enumeration")
Reported-by: Lucian Paul-Trifu <lucian.paul-trifu@arm.com>
Link: https://lore.kernel.org/r/20230419-ffa_fixes_6-4-v2-3-d9108e43a176@arm.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/arm_ffa/bus.c |   16 +++++++++++++---
 include/linux/arm_ffa.h        |    1 +
 2 files changed, 14 insertions(+), 3 deletions(-)

--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -15,6 +15,8 @@
 
 #include "common.h"
 
+static DEFINE_IDA(ffa_bus_id);
+
 static int ffa_device_match(struct device *dev, struct device_driver *drv)
 {
 	const struct ffa_device_id *id_table;
@@ -131,6 +133,7 @@ static void ffa_release_device(struct de
 {
 	struct ffa_device *ffa_dev = to_ffa_dev(dev);
 
+	ida_free(&ffa_bus_id, ffa_dev->id);
 	kfree(ffa_dev);
 }
 
@@ -170,18 +173,24 @@ bool ffa_device_is_valid(struct ffa_devi
 
 struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id)
 {
-	int ret;
+	int id, ret;
 	struct device *dev;
 	struct ffa_device *ffa_dev;
 
+	id = ida_alloc_min(&ffa_bus_id, 1, GFP_KERNEL);
+	if (id < 0)
+		return NULL;
+
 	ffa_dev = kzalloc(sizeof(*ffa_dev), GFP_KERNEL);
-	if (!ffa_dev)
+	if (!ffa_dev) {
+		ida_free(&ffa_bus_id, id);
 		return NULL;
+	}
 
 	dev = &ffa_dev->dev;
 	dev->bus = &ffa_bus_type;
 	dev->release = ffa_release_device;
-	dev_set_name(&ffa_dev->dev, "arm-ffa-%04x", vm_id);
+	dev_set_name(&ffa_dev->dev, "arm-ffa-%d", id);
 
 	ffa_dev->vm_id = vm_id;
 	uuid_copy(&ffa_dev->uuid, uuid);
@@ -216,4 +225,5 @@ void arm_ffa_bus_exit(void)
 {
 	ffa_devices_unregister();
 	bus_unregister(&ffa_bus_type);
+	ida_destroy(&ffa_bus_id);
 }
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -13,6 +13,7 @@
 
 /* FFA Bus/Device/Driver related */
 struct ffa_device {
+	u32 id;
 	int vm_id;
 	bool mode_32bit;
 	uuid_t uuid;


