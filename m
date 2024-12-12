Return-Path: <stable+bounces-102052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1459EEFB9
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BFB3297B83
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8826A236949;
	Thu, 12 Dec 2024 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gYG2oKIy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD33222D66;
	Thu, 12 Dec 2024 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019786; cv=none; b=q/H3ZannCnHf1pZEF33waJyzNSjNgf7CzOLSMjbxnZvaceGStP48bITOORLRF9+UiGeRD+oFmbUaYcMigVCfZcmCJlD2ZQx6XvY8g5TaQKY6fVS8G0HifD50ipU+FWPisZqAH+nMCgIVIJbJW7MBkd9DHvogVyvsvmIhP+TJWfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019786; c=relaxed/simple;
	bh=2kYExG2Qmr8MXWYkXjxKkfhF3VawPogT5nf0eyksYRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oj5MLtNHyJz1VjI97me+/WdU0xniG62GuRBZN6jvRIZjmTpkeXyYZZGGTbAatcj/hMbQ3gEvXKsqFUTzrJINdcepqK5n0hBxAjqoEyK7zLLfydqt3z4FxR7y86KWzxgyVzDr+9i0/4MHrLz3zHdpA5Cq46v4eUSoiw1IqpqP2vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gYG2oKIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E33C4CED0;
	Thu, 12 Dec 2024 16:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734019785;
	bh=2kYExG2Qmr8MXWYkXjxKkfhF3VawPogT5nf0eyksYRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gYG2oKIyv44FiOc7TpWklX9Fz6Bp9Os/ybehw6ozPpuK/59ftEVJR7vTenXiMegLQ
	 abEB/gHhrguJFVE0XhirkBz/25dqnlGfinFXHk5BGjW61WY1UBCPuVekavrzhLUk5g
	 HeZyJ1FR6zgM2swA8yelHUnCyRwAfPwW9hgOZB9E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Avihai Horon <avihaih@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 298/772] vfio/pci: Properly hide first-in-list PCIe extended capability
Date: Thu, 12 Dec 2024 15:54:03 +0100
Message-ID: <20241212144402.216843650@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Avihai Horon <avihaih@nvidia.com>

[ Upstream commit fe4bf8d0b6716a423b16495d55b35d3fe515905d ]

There are cases where a PCIe extended capability should be hidden from
the user. For example, an unknown capability (i.e., capability with ID
greater than PCI_EXT_CAP_ID_MAX) or a capability that is intentionally
chosen to be hidden from the user.

Hiding a capability is done by virtualizing and modifying the 'Next
Capability Offset' field of the previous capability so it points to the
capability after the one that should be hidden.

The special case where the first capability in the list should be hidden
is handled differently because there is no previous capability that can
be modified. In this case, the capability ID and version are zeroed
while leaving the next pointer intact. This hides the capability and
leaves an anchor for the rest of the capability list.

However, today, hiding the first capability in the list is not done
properly if the capability is unknown, as struct
vfio_pci_core_device->pci_config_map is set to the capability ID during
initialization but the capability ID is not properly checked later when
used in vfio_config_do_rw(). This leads to the following warning [1] and
to an out-of-bounds access to ecap_perms array.

Fix it by checking cap_id in vfio_config_do_rw(), and if it is greater
than PCI_EXT_CAP_ID_MAX, use an alternative struct perm_bits for direct
read only access instead of the ecap_perms array.

Note that this is safe since the above is the only case where cap_id can
exceed PCI_EXT_CAP_ID_MAX (except for the special capabilities, which
are already checked before).

[1]

WARNING: CPU: 118 PID: 5329 at drivers/vfio/pci/vfio_pci_config.c:1900 vfio_pci_config_rw+0x395/0x430 [vfio_pci_core]
CPU: 118 UID: 0 PID: 5329 Comm: simx-qemu-syste Not tainted 6.12.0+ #1
(snip)
Call Trace:
 <TASK>
 ? show_regs+0x69/0x80
 ? __warn+0x8d/0x140
 ? vfio_pci_config_rw+0x395/0x430 [vfio_pci_core]
 ? report_bug+0x18f/0x1a0
 ? handle_bug+0x63/0xa0
 ? exc_invalid_op+0x19/0x70
 ? asm_exc_invalid_op+0x1b/0x20
 ? vfio_pci_config_rw+0x395/0x430 [vfio_pci_core]
 ? vfio_pci_config_rw+0x244/0x430 [vfio_pci_core]
 vfio_pci_rw+0x101/0x1b0 [vfio_pci_core]
 vfio_pci_core_read+0x1d/0x30 [vfio_pci_core]
 vfio_device_fops_read+0x27/0x40 [vfio]
 vfs_read+0xbd/0x340
 ? vfio_device_fops_unl_ioctl+0xbb/0x740 [vfio]
 ? __rseq_handle_notify_resume+0xa4/0x4b0
 __x64_sys_pread64+0x96/0xc0
 x64_sys_call+0x1c3d/0x20d0
 do_syscall_64+0x4d/0x120
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: 89e1f7d4c66d ("vfio: Add PCI device driver")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Yi Liu <yi.l.liu@intel.com>
Link: https://lore.kernel.org/r/20241124142739.21698-1-avihaih@nvidia.com
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/pci/vfio_pci_config.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 523e0144c86fa..7902e1ec0fef2 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -312,6 +312,10 @@ static int vfio_virt_config_read(struct vfio_pci_core_device *vdev, int pos,
 	return count;
 }
 
+static struct perm_bits direct_ro_perms = {
+	.readfn = vfio_direct_config_read,
+};
+
 /* Default capability regions to read-only, no-virtualization */
 static struct perm_bits cap_perms[PCI_CAP_ID_MAX + 1] = {
 	[0 ... PCI_CAP_ID_MAX] = { .readfn = vfio_direct_config_read }
@@ -1890,9 +1894,17 @@ static ssize_t vfio_config_do_rw(struct vfio_pci_core_device *vdev, char __user
 		cap_start = *ppos;
 	} else {
 		if (*ppos >= PCI_CFG_SPACE_SIZE) {
-			WARN_ON(cap_id > PCI_EXT_CAP_ID_MAX);
+			/*
+			 * We can get a cap_id that exceeds PCI_EXT_CAP_ID_MAX
+			 * if we're hiding an unknown capability at the start
+			 * of the extended capability list.  Use default, ro
+			 * access, which will virtualize the id and next values.
+			 */
+			if (cap_id > PCI_EXT_CAP_ID_MAX)
+				perm = &direct_ro_perms;
+			else
+				perm = &ecap_perms[cap_id];
 
-			perm = &ecap_perms[cap_id];
 			cap_start = vfio_find_cap_start(vdev, *ppos);
 		} else {
 			WARN_ON(cap_id > PCI_CAP_ID_MAX);
-- 
2.43.0




