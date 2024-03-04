Return-Path: <stable+bounces-25841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8AC86FAB9
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 08:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB77E285358
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 07:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FF6134AE;
	Mon,  4 Mar 2024 07:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gEcnElZp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C4C12E54
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 07:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537303; cv=none; b=MfKQfoHCioyNIdGHlxFFY/X4hUqDhlqDeX+DPbkFD6Lt7egTmz1BjAEt7rUCPlD5gTbNMyAQyBuEs3klfw/pLDscPX8JpUteHlCB7tTfxlkHNSZYYaspn23r5CF03OX7O330q6fP0OuIngB0af/tDD5vikG9OMmEq+fJcGABYJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537303; c=relaxed/simple;
	bh=kb3Q1HRILGDEEIrsCA1GKRfgYXRIhEOcLiUcJPYmaB0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ET4xaGPaGkFfkcn12NpJ5QZYvxYDoL2LDC2eYX87f0H13fdXlz3Arss9f+xG/8BRot7vklssrE9n8XRerHsUDzyUvKl5u+ZSgU1/dfyoJO+vAukqwwpwR40YlH+hXDHxGHeVrlCaia1w+na/jCUusnL8QZLwpINGuCUcGoWf6J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gEcnElZp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9646DC43390;
	Mon,  4 Mar 2024 07:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709537303;
	bh=kb3Q1HRILGDEEIrsCA1GKRfgYXRIhEOcLiUcJPYmaB0=;
	h=Subject:To:Cc:From:Date:From;
	b=gEcnElZpkqMUv2Lr9c9V7ZVionErNpkkS2lonqw23P20p/NZn4Imb3VW9SyINQtUv
	 ARXFNkdDBB4iut15JxUB75rPxpQZ9gXdrYaf51xu9cDHG0aUXFMZwR2B3JaUQcBAw8
	 PLnDfzo0WTrioCxNVSxhh3+9GHhE1j6uU0ZwBgMs=
Subject: FAILED: patch "[PATCH] iommufd/selftest: Fix mock_dev_num bug" failed to apply to 6.6-stable tree
To: nicolinc@nvidia.com,jgg@nvidia.com,kevin.tian@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 Mar 2024 08:28:20 +0100
Message-ID: <2024030420-fester-semester-873a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x fde372df96afddcda3ec94944351f2a14f7cd98d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024030420-fester-semester-873a@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

fde372df96af ("iommufd/selftest: Fix mock_dev_num bug")
47f2bd2ff382 ("iommufd/selftest: Check the bus type during probe")
65fe32f7a447 ("iommufd/selftest: Add nested domain allocation for mock domain")
2bdabb8e82f5 ("iommu: Pass in parent domain with user_data to domain_alloc_user op")
9744a7ab62cc ("iommufd: Rename IOMMUFD_OBJ_HW_PAGETABLE to IOMMUFD_OBJ_HWPT_PAGING")
266ce58989ba ("iommufd/selftest: Test IOMMU_HWPT_ALLOC_DIRTY_TRACKING")
e04b23c8d4ed ("iommufd/selftest: Expand mock_domain with dev_flags")
421a511a293f ("iommu/amd: Access/Dirty bit support in IOPTEs")
134288158a41 ("iommu/amd: Add domain_alloc_user based domain allocation")
e2a4b2947849 ("iommufd: Add IOMMU_HWPT_SET_DIRTY_TRACKING")
750e2e902b71 ("iommu: Add iommu_domain ops for dirty tracking")
c97d1b20d383 ("iommu/vt-d: Add domain_alloc_user op")
408663619fcf ("iommufd/selftest: Add domain_alloc_user() support in iommu mock")
4ff542163397 ("iommufd: Support allocating nested parent domain")
89d63875d80e ("iommufd: Flow user flags for domain allocation to domain_alloc_user()")
7975b722087f ("iommufd: Use the domain_alloc_user() op for domain allocation")
909f4abd1097 ("iommu: Add new iommu op to create domains owned by userspace")
bb812e0069ce ("iommufd/selftest: Iterate idev_ids in mock_domain's alloc_hwpt test")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fde372df96afddcda3ec94944351f2a14f7cd98d Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicolinc@nvidia.com>
Date: Thu, 22 Feb 2024 13:23:46 -0800
Subject: [PATCH] iommufd/selftest: Fix mock_dev_num bug

Syzkaller reported the following bug:
  sysfs: cannot create duplicate filename '/devices/iommufd_mock4'

  Call Trace:
    sysfs_warn_dup+0x71/0x90
    sysfs_create_dir_ns+0x1ee/0x260
    ? sysfs_create_mount_point+0x80/0x80
    ? spin_bug+0x1d0/0x1d0
    ? do_raw_spin_unlock+0x54/0x220
    kobject_add_internal+0x221/0x970
    kobject_add+0x11c/0x1e0
    ? lockdep_hardirqs_on_prepare+0x273/0x3e0
    ? kset_create_and_add+0x160/0x160
    ? kobject_put+0x5d/0x390
    ? bus_get_dev_root+0x4a/0x60
    ? kobject_put+0x5d/0x390
    device_add+0x1d5/0x1550
    ? __fw_devlink_link_to_consumers.isra.0+0x1f0/0x1f0
    ? __init_waitqueue_head+0xcb/0x150
    iommufd_test+0x462/0x3b60
    ? lock_release+0x1fe/0x640
    ? __might_fault+0x117/0x170
    ? reacquire_held_locks+0x4b0/0x4b0
    ? iommufd_selftest_destroy+0xd0/0xd0
    ? __might_fault+0xbe/0x170
    iommufd_fops_ioctl+0x256/0x350
    ? iommufd_option+0x180/0x180
    ? __lock_acquire+0x1755/0x45f0
    __x64_sys_ioctl+0xa13/0x1640

The bug is triggered when Syzkaller created multiple mock devices but
didn't destroy them in the same sequence, messing up the mock_dev_num
counter. Replace the atomic with an mock_dev_ida.

Cc: stable@vger.kernel.org
Fixes: 23a1b46f15d5 ("iommufd/selftest: Make the mock iommu driver into a real driver")
Link: https://lore.kernel.org/r/5af41d5af6d5c013cc51de01427abb8141b3587e.1708636627.git.nicolinc@nvidia.com
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 8abf9747773e..2bfe77bd351d 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -36,7 +36,7 @@ static struct mock_bus_type iommufd_mock_bus_type = {
 	},
 };
 
-static atomic_t mock_dev_num;
+static DEFINE_IDA(mock_dev_ida);
 
 enum {
 	MOCK_DIRTY_TRACK = 1,
@@ -123,6 +123,7 @@ enum selftest_obj_type {
 struct mock_dev {
 	struct device dev;
 	unsigned long flags;
+	int id;
 };
 
 struct selftest_obj {
@@ -631,7 +632,7 @@ static void mock_dev_release(struct device *dev)
 {
 	struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
 
-	atomic_dec(&mock_dev_num);
+	ida_free(&mock_dev_ida, mdev->id);
 	kfree(mdev);
 }
 
@@ -653,8 +654,12 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 	mdev->dev.release = mock_dev_release;
 	mdev->dev.bus = &iommufd_mock_bus_type.bus;
 
-	rc = dev_set_name(&mdev->dev, "iommufd_mock%u",
-			  atomic_inc_return(&mock_dev_num));
+	rc = ida_alloc(&mock_dev_ida, GFP_KERNEL);
+	if (rc < 0)
+		goto err_put;
+	mdev->id = rc;
+
+	rc = dev_set_name(&mdev->dev, "iommufd_mock%u", mdev->id);
 	if (rc)
 		goto err_put;
 


