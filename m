Return-Path: <stable+bounces-25840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C6586FAB8
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 08:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1705328152E
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 07:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F1312E54;
	Mon,  4 Mar 2024 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KLFwFekw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899688F7A
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537290; cv=none; b=VXHP0Khh0Tc1VMwo6Hd7BhdTadrdvBgT3S4BmhKxdnfg1tbpt9EMru6dcmTwbO5GO+qWB8jvBUwS0h0dDcZufF3vxwqRn5coEou1CY9p6lQ8lUFD2/DRnsz+EOUFo7OiCp0B7i6ruhK+gWGGo8VqR0VrGtmUl7FhKQ+YlZrbXmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537290; c=relaxed/simple;
	bh=rbWnPqxOtBeUufmY3LTP0hqnm4D0hEjCXc1WpXro9vU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=q72QwyY3RGgKXL7voWdM4mbBvCv30w0JLDCYRexlDPTMR6vCU8BhiE1QPeq0ttn/PyWjAXLHC9o2P5IRPbqCSBn0siGMjKo0GYnGk3jTTOamSU8Hbc1/R5R1upTbACevElKiUfxRN6sV4Y0hc1ls3fO2w7gVyu77Yvm3k3aqTB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KLFwFekw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1297C433F1;
	Mon,  4 Mar 2024 07:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709537290;
	bh=rbWnPqxOtBeUufmY3LTP0hqnm4D0hEjCXc1WpXro9vU=;
	h=Subject:To:Cc:From:Date:From;
	b=KLFwFekw5t3dE4Cz9DBqUwGgpHfCyEEGRrG3H6F0J6k2oT8JAx91h0mRXnDJQdoCD
	 J3VkwTqi+Mho7Maap9cmx5I6ilkk1wEOtgbPFMNmoTUSizcWc9Q7RHSeGpvU7Tn9pL
	 rkKxmAFFTlZlFaMaifqGT0OK9FqxNPWUOT2jPlCM=
Subject: FAILED: patch "[PATCH] iommufd: Fix protection fault in iommufd_test_syz_conv_iova" failed to apply to 6.6-stable tree
To: nicolinc@nvidia.com,jgg@nvidia.com,kevin.tian@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 Mar 2024 08:28:07 +0100
Message-ID: <2024030407-headway-blustery-23f1@gregkh>
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
git cherry-pick -x cf7c2789822db8b5efa34f5ebcf1621bc0008d48
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024030407-headway-blustery-23f1@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

cf7c2789822d ("iommufd: Fix protection fault in iommufd_test_syz_conv_iova")
bd7a282650b8 ("iommufd: Add iommufd_ctx to iommufd_put_object()")
65fe32f7a447 ("iommufd/selftest: Add nested domain allocation for mock domain")
2bdabb8e82f5 ("iommu: Pass in parent domain with user_data to domain_alloc_user op")
b5021cb264e6 ("iommufd: Share iommufd_hwpt_alloc with IOMMUFD_OBJ_HWPT_NESTED")
89db31635c87 ("iommufd: Derive iommufd_hwpt_paging from iommufd_hw_pagetable")
58d84f430dc7 ("iommufd/device: Wrap IOMMUFD_OBJ_HWPT_PAGING-only configurations")
9744a7ab62cc ("iommufd: Rename IOMMUFD_OBJ_HW_PAGETABLE to IOMMUFD_OBJ_HWPT_PAGING")
2ccabf81ddff ("iommufd: Only enforce cache coherency in iommufd_hw_pagetable_alloc")
a9af47e382a4 ("iommufd/selftest: Test IOMMU_HWPT_GET_DIRTY_BITMAP")
7adf267d66d1 ("iommufd/selftest: Test IOMMU_HWPT_SET_DIRTY_TRACKING")
266ce58989ba ("iommufd/selftest: Test IOMMU_HWPT_ALLOC_DIRTY_TRACKING")
e04b23c8d4ed ("iommufd/selftest: Expand mock_domain with dev_flags")
421a511a293f ("iommu/amd: Access/Dirty bit support in IOPTEs")
134288158a41 ("iommu/amd: Add domain_alloc_user based domain allocation")
b9a60d6f850e ("iommufd: Add IOMMU_HWPT_GET_DIRTY_BITMAP")
e2a4b2947849 ("iommufd: Add IOMMU_HWPT_SET_DIRTY_TRACKING")
5f9bdbf4c658 ("iommufd: Add a flag to enforce dirty tracking on attach")
750e2e902b71 ("iommu: Add iommu_domain ops for dirty tracking")
b5f9e63278d6 ("iommufd: Correct IOMMU_HWPT_ALLOC_NEST_PARENT description")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cf7c2789822db8b5efa34f5ebcf1621bc0008d48 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicolinc@nvidia.com>
Date: Thu, 22 Feb 2024 13:23:47 -0800
Subject: [PATCH] iommufd: Fix protection fault in iommufd_test_syz_conv_iova

Syzkaller reported the following bug:

  general protection fault, probably for non-canonical address 0xdffffc0000000038: 0000 [#1] SMP KASAN
  KASAN: null-ptr-deref in range [0x00000000000001c0-0x00000000000001c7]
  Call Trace:
   lock_acquire
   lock_acquire+0x1ce/0x4f0
   down_read+0x93/0x4a0
   iommufd_test_syz_conv_iova+0x56/0x1f0
   iommufd_test_access_rw.isra.0+0x2ec/0x390
   iommufd_test+0x1058/0x1e30
   iommufd_fops_ioctl+0x381/0x510
   vfs_ioctl
   __do_sys_ioctl
   __se_sys_ioctl
   __x64_sys_ioctl+0x170/0x1e0
   do_syscall_x64
   do_syscall_64+0x71/0x140

This is because the new iommufd_access_change_ioas() sets access->ioas to
NULL during its process, so the lock might be gone in a concurrent racing
context.

Fix this by doing the same access->ioas sanity as iommufd_access_rw() and
iommufd_access_pin_pages() functions do.

Cc: stable@vger.kernel.org
Fixes: 9227da7816dd ("iommufd: Add iommufd_access_change_ioas(_id) helpers")
Link: https://lore.kernel.org/r/3f1932acaf1dd494d404c04364d73ce8f57f3e5e.1708636627.git.nicolinc@nvidia.com
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 2bfe77bd351d..d59e199a8705 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -63,8 +63,8 @@ enum {
  * In syzkaller mode the 64 bit IOVA is converted into an nth area and offset
  * value. This has a much smaller randomization space and syzkaller can hit it.
  */
-static unsigned long iommufd_test_syz_conv_iova(struct io_pagetable *iopt,
-						u64 *iova)
+static unsigned long __iommufd_test_syz_conv_iova(struct io_pagetable *iopt,
+						  u64 *iova)
 {
 	struct syz_layout {
 		__u32 nth_area;
@@ -88,6 +88,21 @@ static unsigned long iommufd_test_syz_conv_iova(struct io_pagetable *iopt,
 	return 0;
 }
 
+static unsigned long iommufd_test_syz_conv_iova(struct iommufd_access *access,
+						u64 *iova)
+{
+	unsigned long ret;
+
+	mutex_lock(&access->ioas_lock);
+	if (!access->ioas) {
+		mutex_unlock(&access->ioas_lock);
+		return 0;
+	}
+	ret = __iommufd_test_syz_conv_iova(&access->ioas->iopt, iova);
+	mutex_unlock(&access->ioas_lock);
+	return ret;
+}
+
 void iommufd_test_syz_conv_iova_id(struct iommufd_ucmd *ucmd,
 				   unsigned int ioas_id, u64 *iova, u32 *flags)
 {
@@ -100,7 +115,7 @@ void iommufd_test_syz_conv_iova_id(struct iommufd_ucmd *ucmd,
 	ioas = iommufd_get_ioas(ucmd->ictx, ioas_id);
 	if (IS_ERR(ioas))
 		return;
-	*iova = iommufd_test_syz_conv_iova(&ioas->iopt, iova);
+	*iova = __iommufd_test_syz_conv_iova(&ioas->iopt, iova);
 	iommufd_put_object(ucmd->ictx, &ioas->obj);
 }
 
@@ -1161,7 +1176,7 @@ static int iommufd_test_access_pages(struct iommufd_ucmd *ucmd,
 	}
 
 	if (flags & MOCK_FLAGS_ACCESS_SYZ)
-		iova = iommufd_test_syz_conv_iova(&staccess->access->ioas->iopt,
+		iova = iommufd_test_syz_conv_iova(staccess->access,
 					&cmd->access_pages.iova);
 
 	npages = (ALIGN(iova + length, PAGE_SIZE) -
@@ -1263,8 +1278,8 @@ static int iommufd_test_access_rw(struct iommufd_ucmd *ucmd,
 	}
 
 	if (flags & MOCK_FLAGS_ACCESS_SYZ)
-		iova = iommufd_test_syz_conv_iova(&staccess->access->ioas->iopt,
-					&cmd->access_rw.iova);
+		iova = iommufd_test_syz_conv_iova(staccess->access,
+				&cmd->access_rw.iova);
 
 	rc = iommufd_access_rw(staccess->access, iova, tmp, length, flags);
 	if (rc)


