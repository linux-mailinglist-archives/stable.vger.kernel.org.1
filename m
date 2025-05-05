Return-Path: <stable+bounces-139602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F546AA8D3E
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 09:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 418BA7A2338
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 07:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC211C84B3;
	Mon,  5 May 2025 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0wNm2bQo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5AB176AC8
	for <stable@vger.kernel.org>; Mon,  5 May 2025 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746431004; cv=none; b=qIz8gs/5YDWWSTUWi79Lv7q6zHMeLwo9tX7bLVsFkOfsPVY+b0YUCNgyiEmRENzdosp7a2+Ntj+5pB5O0l2X/uxRmhZZlfb7z6rZDUEOGts2c6zqMDKCvw2r9BO0hOjj21lNz9ZPbo3z2xj6HynhCexZIKpkUn2i2vW3lJN6HqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746431004; c=relaxed/simple;
	bh=+mkomnsv12nmpyI4PUAvIjvTg9Yt52YIujRE86A1MP0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LirhuM3gqDAOkqn7dRHFr9uN0EgknQ6wvzEITMwjm6ryIAgNWpgr36RkCBwFpmhezuj+bisDyLhG1MWpT+MfH77x/UTA1ptroPFuZy5pHZEaHaiDQeRrMjoOh+CJBeKLrmMlLHStVfuU8HERGLQHel7U596ANFsMc4kcCeThmgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0wNm2bQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B983C4CEE4;
	Mon,  5 May 2025 07:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746431004;
	bh=+mkomnsv12nmpyI4PUAvIjvTg9Yt52YIujRE86A1MP0=;
	h=Subject:To:Cc:From:Date:From;
	b=0wNm2bQoDsuuESnvTlZMyJmZpN77hXYbjLbGjoFHwJtEkQtESMT5GqmkWc1B8A+NP
	 AdZqqeNDJ36WY+aYKoejkrbcl3ngA418aEM7h0Xrpje4UE05QW1mhYQO6OQ62Ha/MP
	 YckVF5tnjDmiAuBGGYWqKdw9bIlge49fkk+jviAY=
Subject: FAILED: patch "[PATCH] iommu/arm-smmu-v3: Fix iommu_device_probe bug due to" failed to apply to 6.6-stable tree
To: nicolinc@nvidia.com,jgg@nvidia.com,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 May 2025 09:43:21 +0200
Message-ID: <2025050520-chastity-tasty-6f1e@gregkh>
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
git cherry-pick -x b00d24997a11c10d3e420614f0873b83ce358a34
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025050520-chastity-tasty-6f1e@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b00d24997a11c10d3e420614f0873b83ce358a34 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicolinc@nvidia.com>
Date: Tue, 15 Apr 2025 11:56:20 -0700
Subject: [PATCH] iommu/arm-smmu-v3: Fix iommu_device_probe bug due to
 duplicated stream ids

ASPEED VGA card has two built-in devices:
 0008:06:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge (rev 06)
 0008:07:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED Graphics Family (rev 52)

Its toplogy looks like this:
 +-[0008:00]---00.0-[01-09]--+-00.0-[02-09]--+-00.0-[03]----00.0  Sandisk Corp Device 5017
                             |               +-01.0-[04]--
                             |               +-02.0-[05]----00.0  NVIDIA Corporation Device
                             |               +-03.0-[06-07]----00.0-[07]----00.0  ASPEED Technology, Inc. ASPEED Graphics Family
                             |               +-04.0-[08]----00.0  Renesas Technology Corp. uPD720201 USB 3.0 Host Controller
                             |               \-05.0-[09]----00.0  Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
                             \-00.1  PMC-Sierra Inc. Device 4028

The IORT logic populaties two identical IDs into the fwspec->ids array via
DMA aliasing in iort_pci_iommu_init() called by pci_for_each_dma_alias().

Though the SMMU driver had been able to handle this situation since commit
563b5cbe334e ("iommu/arm-smmu-v3: Cope with duplicated Stream IDs"), that
got broken by the later commit cdf315f907d4 ("iommu/arm-smmu-v3: Maintain
a SID->device structure"), which ended up with allocating separate streams
with the same stuffing.

On a kernel prior to v6.15-rc1, there has been an overlooked warning:
  pci 0008:07:00.0: vgaarb: setting as boot VGA device
  pci 0008:07:00.0: vgaarb: bridge control possible
  pci 0008:07:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
  pcieport 0008:06:00.0: Adding to iommu group 14
  ast 0008:07:00.0: stream 67328 already in tree   <===== WARNING
  ast 0008:07:00.0: enabling device (0002 -> 0003)
  ast 0008:07:00.0: Using default configuration
  ast 0008:07:00.0: AST 2600 detected
  ast 0008:07:00.0: [drm] Using analog VGA
  ast 0008:07:00.0: [drm] dram MCLK=396 Mhz type=1 bus_width=16
  [drm] Initialized ast 0.1.0 for 0008:07:00.0 on minor 0
  ast 0008:07:00.0: [drm] fb0: astdrmfb frame buffer device

With v6.15-rc, since the commit bcb81ac6ae3c ("iommu: Get DT/ACPI parsing
into the proper probe path"), the error returned with the warning is moved
to the SMMU device probe flow:
  arm_smmu_probe_device+0x15c/0x4c0
  __iommu_probe_device+0x150/0x4f8
  probe_iommu_group+0x44/0x80
  bus_for_each_dev+0x7c/0x100
  bus_iommu_probe+0x48/0x1a8
  iommu_device_register+0xb8/0x178
  arm_smmu_device_probe+0x1350/0x1db0
which then fails the entire SMMU driver probe:
  pci 0008:06:00.0: Adding to iommu group 21
  pci 0008:07:00.0: stream 67328 already in tree
  arm-smmu-v3 arm-smmu-v3.9.auto: Failed to register iommu
  arm-smmu-v3 arm-smmu-v3.9.auto: probe with driver arm-smmu-v3 failed with error -22

Since SMMU driver had been already expecting a potential duplicated Stream
ID in arm_smmu_install_ste_for_dev(), change the arm_smmu_insert_master()
routine to ignore a duplicated ID from the fwspec->sids array as well.

Note: this has been failing the iommu_device_probe() since 2021, although a
recent iommu commit in v6.15-rc1 that moves iommu_device_probe() started to
fail the SMMU driver probe. Since nobody has cared about DMA Alias support,
leave that as it was but fix the fundamental iommu_device_probe() breakage.

Fixes: cdf315f907d4 ("iommu/arm-smmu-v3: Maintain a SID->device structure")
Cc: stable@vger.kernel.org
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Link: https://lore.kernel.org/r/20250415185620.504299-1-nicolinc@nvidia.com
Signed-off-by: Will Deacon <will@kernel.org>

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5467f85dd463..0826b6bdf327 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3388,6 +3388,7 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++) {
 		struct arm_smmu_stream *new_stream = &master->streams[i];
+		struct rb_node *existing;
 		u32 sid = fwspec->ids[i];
 
 		new_stream->id = sid;
@@ -3398,10 +3399,20 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 			break;
 
 		/* Insert into SID tree */
-		if (rb_find_add(&new_stream->node, &smmu->streams,
-				arm_smmu_streams_cmp_node)) {
-			dev_warn(master->dev, "stream %u already in tree\n",
-				 sid);
+		existing = rb_find_add(&new_stream->node, &smmu->streams,
+				       arm_smmu_streams_cmp_node);
+		if (existing) {
+			struct arm_smmu_master *existing_master =
+				rb_entry(existing, struct arm_smmu_stream, node)
+					->master;
+
+			/* Bridged PCI devices may end up with duplicated IDs */
+			if (existing_master == master)
+				continue;
+
+			dev_warn(master->dev,
+				 "stream %u already in tree from dev %s\n", sid,
+				 dev_name(existing_master->dev));
 			ret = -EINVAL;
 			break;
 		}


