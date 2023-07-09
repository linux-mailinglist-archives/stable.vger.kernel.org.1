Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994E474C3C8
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjGILgP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbjGILgP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:36:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFEE198
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:36:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F6D260BBA
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC84DC433C8;
        Sun,  9 Jul 2023 11:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902573;
        bh=7XT1lu2g6szgXOZYRbd+fY//JrpY8FXG0L9cecd3r2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z7oFZ0BaEMynpqXnkEBZm5JBKOScQbVJvnd0kGaO9Zhj+19JMre+IQ3ysxEgwVa1e
         /sFdVCOaMVxOGTEx7XUtzbycNWYk9pXzBgpcv3MhLI1yApxph7OReXyij0ytcX+xUe
         l5TgA7qCFN4g9PRar5A3dQrULfPRjAqr6NxTB0vE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 397/431] vfio/mdev: Move the compat_class initialization to module init
Date:   Sun,  9 Jul 2023 13:15:45 +0200
Message-ID: <20230709111500.479354120@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
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

From: Eric Farman <farman@linux.ibm.com>

[ Upstream commit ff598081e5b9d0bdd6874bfe340811bbb75b35e4 ]

The pointer to mdev_bus_compat_class is statically defined at the top
of mdev_core, and was originally (commit 7b96953bc640 ("vfio: Mediated
device Core driver") serialized by the parent_list_lock. The blamed
commit removed this mutex, leaving the pointer initialization
unserialized. As a result, the creation of multiple MDEVs in parallel
(such as during boot) can encounter errors during the creation of the
sysfs entries, such as:

  [    8.337509] sysfs: cannot create duplicate filename '/class/mdev_bus'
  [    8.337514] vfio_ccw 0.0.01d8: MDEV: Registered
  [    8.337516] CPU: 13 PID: 946 Comm: driverctl Not tainted 6.4.0-rc7 #20
  [    8.337522] Hardware name: IBM 3906 M05 780 (LPAR)
  [    8.337525] Call Trace:
  [    8.337528]  [<0000000162b0145a>] dump_stack_lvl+0x62/0x80
  [    8.337540]  [<00000001622aeb30>] sysfs_warn_dup+0x78/0x88
  [    8.337549]  [<00000001622aeca6>] sysfs_create_dir_ns+0xe6/0xf8
  [    8.337552]  [<0000000162b04504>] kobject_add_internal+0xf4/0x340
  [    8.337557]  [<0000000162b04d48>] kobject_add+0x78/0xd0
  [    8.337561]  [<0000000162b04e0a>] kobject_create_and_add+0x6a/0xb8
  [    8.337565]  [<00000001627a110e>] class_compat_register+0x5e/0x90
  [    8.337572]  [<000003ff7fd815da>] mdev_register_parent+0x102/0x130 [mdev]
  [    8.337581]  [<000003ff7fdc7f2c>] vfio_ccw_sch_probe+0xe4/0x178 [vfio_ccw]
  [    8.337588]  [<0000000162a7833c>] css_probe+0x44/0x80
  [    8.337599]  [<000000016279f4da>] really_probe+0xd2/0x460
  [    8.337603]  [<000000016279fa08>] driver_probe_device+0x40/0xf0
  [    8.337606]  [<000000016279fb78>] __device_attach_driver+0xc0/0x140
  [    8.337610]  [<000000016279cbe0>] bus_for_each_drv+0x90/0xd8
  [    8.337618]  [<00000001627a00b0>] __device_attach+0x110/0x190
  [    8.337621]  [<000000016279c7c8>] bus_rescan_devices_helper+0x60/0xb0
  [    8.337626]  [<000000016279cd48>] drivers_probe_store+0x48/0x80
  [    8.337632]  [<00000001622ac9b0>] kernfs_fop_write_iter+0x138/0x1f0
  [    8.337635]  [<00000001621e5e14>] vfs_write+0x1ac/0x2f8
  [    8.337645]  [<00000001621e61d8>] ksys_write+0x70/0x100
  [    8.337650]  [<0000000162b2bdc4>] __do_syscall+0x1d4/0x200
  [    8.337656]  [<0000000162b3c828>] system_call+0x70/0x98
  [    8.337664] kobject: kobject_add_internal failed for mdev_bus with -EEXIST, don't try to register things with the same name in the same directory.
  [    8.337668] kobject: kobject_create_and_add: kobject_add error: -17
  [    8.337674] vfio_ccw: probe of 0.0.01d9 failed with error -12
  [    8.342941] vfio_ccw_mdev aeb9ca91-10c6-42bc-a168-320023570aea: Adding to iommu group 2

Move the initialization of the mdev_bus_compat_class pointer to the
init path, to match the cleanup in module exit. This way the code
in mdev_register_parent() can simply link the new parent to it,
rather than determining whether initialization is required first.

Fixes: 89345d5177aa ("vfio/mdev: embedd struct mdev_parent in the parent data structure")
Reported-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20230626133642.2939168-1-farman@linux.ibm.com
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/mdev/mdev_core.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index 58f91b3bd670c..ed4737de45289 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -72,12 +72,6 @@ int mdev_register_parent(struct mdev_parent *parent, struct device *dev,
 	parent->nr_types = nr_types;
 	atomic_set(&parent->available_instances, mdev_driver->max_instances);
 
-	if (!mdev_bus_compat_class) {
-		mdev_bus_compat_class = class_compat_register("mdev_bus");
-		if (!mdev_bus_compat_class)
-			return -ENOMEM;
-	}
-
 	ret = parent_create_sysfs_files(parent);
 	if (ret)
 		return ret;
@@ -251,13 +245,24 @@ int mdev_device_remove(struct mdev_device *mdev)
 
 static int __init mdev_init(void)
 {
-	return bus_register(&mdev_bus_type);
+	int ret;
+
+	ret = bus_register(&mdev_bus_type);
+	if (ret)
+		return ret;
+
+	mdev_bus_compat_class = class_compat_register("mdev_bus");
+	if (!mdev_bus_compat_class) {
+		bus_unregister(&mdev_bus_type);
+		return -ENOMEM;
+	}
+
+	return 0;
 }
 
 static void __exit mdev_exit(void)
 {
-	if (mdev_bus_compat_class)
-		class_compat_unregister(mdev_bus_compat_class);
+	class_compat_unregister(mdev_bus_compat_class);
 	bus_unregister(&mdev_bus_type);
 }
 
-- 
2.39.2



