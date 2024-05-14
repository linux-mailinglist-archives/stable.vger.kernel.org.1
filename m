Return-Path: <stable+bounces-44065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8218C510F
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE851C21164
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ECB12F597;
	Tue, 14 May 2024 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cfsmZGEb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B788112880A;
	Tue, 14 May 2024 10:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684024; cv=none; b=clM3o0sFEeUi9b2zlUNHfKVeu7U2koHWp1FzDQpRnuq1ZpisZihQQZrWKCHQDLfKVGRHkNxQKhvoyXoQq9AoH1TyTPBllBULAScCtU71000PCnxFByZBGMRVb1O3oK9AINpxcWxPzNnyzMme7eAhKMi/uL8z4QqTtlCJTlECWf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684024; c=relaxed/simple;
	bh=r3h1Ni6qDiut4kpEBJ7sKO+7g3HEW+4YuFgobmfQu8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMQa1V+4ajGg05FoQssljkFuSYAw7mAHDYJ0KoGEBXVlqO532M1Z6AHQcdY0kJb1m6IDIhEvM3HSvUOXfrB9iDfPpwNmLd1khf5ZrhVWiKaQyTP7Ch+hq59OV34/IqJK35p7TlpJb0irQAKGzSScwK4Qw8JwBOXYdTQqXut8qIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cfsmZGEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B03DC2BD10;
	Tue, 14 May 2024 10:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715684024;
	bh=r3h1Ni6qDiut4kpEBJ7sKO+7g3HEW+4YuFgobmfQu8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cfsmZGEbCLV25CdEfvaaSnhYQOJMbSxgTior+wuLuxuFOXMG1RuXLDBe8HU6Gpr15
	 wi9Sks+nA+dCU4sO5BD2v1JUSIicHBvxsXazQC55DyAkcaofSJwo/mpwvYkkeOdJOy
	 UdQLayx/iE75qg/AAWf8kQITYFdy9JYkPZnnQlI4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 6.8 308/336] iommu/arm-smmu: Use the correct type in nvidia_smmu_context_fault()
Date: Tue, 14 May 2024 12:18:32 +0200
Message-ID: <20240514101050.247264460@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@nvidia.com>

commit 65ade5653f5ab5a21635e51d0c65e95f490f5b6f upstream.

This was missed because of the function pointer indirection.

nvidia_smmu_context_fault() is also installed as a irq function, and the
'void *' was changed to a struct arm_smmu_domain. Since the iommu_domain
is embedded at a non-zero offset this causes nvidia_smmu_context_fault()
to miscompute the offset. Fixup the types.

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000120
  Mem abort info:
    ESR = 0x0000000096000004
    EC = 0x25: DABT (current EL), IL = 32 bits
    SET = 0, FnV = 0
    EA = 0, S1PTW = 0
    FSC = 0x04: level 0 translation fault
  Data abort info:
    ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
  user pgtable: 4k pages, 48-bit VAs, pgdp=0000000107c9f000
  [0000000000000120] pgd=0000000000000000, p4d=0000000000000000
  Internal error: Oops: 0000000096000004 [#1] SMP
  Modules linked in:
  CPU: 1 PID: 47 Comm: kworker/u25:0 Not tainted 6.9.0-0.rc7.58.eln136.aarch64 #1
  Hardware name: Unknown NVIDIA Jetson Orin NX/NVIDIA Jetson Orin NX, BIOS 3.1-32827747 03/19/2023
  Workqueue: events_unbound deferred_probe_work_func
  pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : nvidia_smmu_context_fault+0x1c/0x158
  lr : __free_irq+0x1d4/0x2e8
  sp : ffff80008044b6f0
  x29: ffff80008044b6f0 x28: ffff000080a60b18 x27: ffffd32b5172e970
  x26: 0000000000000000 x25: ffff0000802f5aac x24: ffff0000802f5a30
  x23: ffff0000802f5b60 x22: 0000000000000057 x21: 0000000000000000
  x20: ffff0000802f5a00 x19: ffff000087d4cd80 x18: ffffffffffffffff
  x17: 6234362066666666 x16: 6630303078302d30 x15: ffff00008156d888
  x14: 0000000000000000 x13: ffff0000801db910 x12: ffff00008156d6d0
  x11: 0000000000000003 x10: ffff0000801db918 x9 : ffffd32b50f94d9c
  x8 : 1fffe0001032fda1 x7 : ffff00008197ed00 x6 : 000000000000000f
  x5 : 000000000000010e x4 : 000000000000010e x3 : 0000000000000000
  x2 : ffffd32b51720cd8 x1 : ffff000087e6f700 x0 : 0000000000000057
  Call trace:
   nvidia_smmu_context_fault+0x1c/0x158
   __free_irq+0x1d4/0x2e8
   free_irq+0x3c/0x80
   devm_free_irq+0x64/0xa8
   arm_smmu_domain_free+0xc4/0x158
   iommu_domain_free+0x44/0xa0
   iommu_deinit_device+0xd0/0xf8
   __iommu_group_remove_device+0xcc/0xe0
   iommu_bus_notifier+0x64/0xa8
   notifier_call_chain+0x78/0x148
   blocking_notifier_call_chain+0x4c/0x90
   bus_notify+0x44/0x70
   device_del+0x264/0x3e8
   pci_remove_bus_device+0x84/0x120
   pci_remove_root_bus+0x5c/0xc0
   dw_pcie_host_deinit+0x38/0xe0
   tegra_pcie_config_rp+0xc0/0x1f0
   tegra_pcie_dw_probe+0x34c/0x700
   platform_probe+0x70/0xe8
   really_probe+0xc8/0x3a0
   __driver_probe_device+0x84/0x160
   driver_probe_device+0x44/0x130
   __device_attach_driver+0xc4/0x170
   bus_for_each_drv+0x90/0x100
   __device_attach+0xa8/0x1c8
   device_initial_probe+0x1c/0x30
   bus_probe_device+0xb0/0xc0
   deferred_probe_work_func+0xbc/0x120
   process_one_work+0x194/0x490
   worker_thread+0x284/0x3b0
   kthread+0xf4/0x108
   ret_from_fork+0x10/0x20
  Code: a9b97bfd 910003fd a9025bf5 f85a0035 (b94122a1)

Cc: stable@vger.kernel.org
Fixes: e0976331ad11 ("iommu/arm-smmu: Pass arm_smmu_domain to internal functions")
Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
Closes: https://lore.kernel.org/all/jto5e3ili4auk6sbzpnojdvhppgwuegir7mpd755anfhwcbkfz@2u5gh7bxb4iv
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Jerry Snitselaar <jsnitsel@redhat.com>
Acked-by: Jerry Snitselaar <jsnitsel@redhat.com>
Link: https://lore.kernel.org/r/0-v1-24ce064de41f+4ac-nvidia_smmu_fault_jgg@nvidia.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
index 87bf522b9d2e..957d988b6d83 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
@@ -221,11 +221,9 @@ static irqreturn_t nvidia_smmu_context_fault(int irq, void *dev)
 	unsigned int inst;
 	irqreturn_t ret = IRQ_NONE;
 	struct arm_smmu_device *smmu;
-	struct iommu_domain *domain = dev;
-	struct arm_smmu_domain *smmu_domain;
+	struct arm_smmu_domain *smmu_domain = dev;
 	struct nvidia_smmu *nvidia;
 
-	smmu_domain = container_of(domain, struct arm_smmu_domain, domain);
 	smmu = smmu_domain->smmu;
 	nvidia = to_nvidia_smmu(smmu);
 
-- 
2.45.0




