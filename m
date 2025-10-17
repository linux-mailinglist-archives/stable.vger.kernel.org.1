Return-Path: <stable+bounces-186927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D166CBE9C3F
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C825235E0ED
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416CE3277A9;
	Fri, 17 Oct 2025 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dFmfFPyR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB9D32E156;
	Fri, 17 Oct 2025 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714626; cv=none; b=LgkwMeQhh0oVqt2LOQe2M/zjyHOvVVOLDF/ufi+zW/MgQHVW+FQEog3xUcQyopyqiKXMooP3THfOtnVBfSmgMAWd9BI4tdB81Ew+mIornOzjkkfhdgqjpoVAVYFGHKeASEwwZGRItmPLm8sua02PE0rvB8aopsSQxUKTPeqwn90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714626; c=relaxed/simple;
	bh=a//RSRqGJbfQSMc4i6xhyawe04LBGa9boZ9z2QNvnWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uiv8cGpBNQjx1Z1+zpFIpAqp4PC8Ym9s2lEMDfhmVh2n8DxEDeNV54j3L1GinBQV+/4fkmPE20sFXgR9vJBsVbDMukTokBn9U7LJ9Yc8JM+FgGOIWcM8RK4CJjEK90iweOpAa1pEx8Z3gwsOYlX2716KhypT83sCJkAEz0uTdC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dFmfFPyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71851C4CEE7;
	Fri, 17 Oct 2025 15:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760714625;
	bh=a//RSRqGJbfQSMc4i6xhyawe04LBGa9boZ9z2QNvnWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dFmfFPyRN4r8pnX2HHMa4Oaa/F0XlqBkcLNQLqTKUTCLAccQceszufxYYSxmC+Oko
	 NaBXNxpaQyiZGNedkkuxwrmUA/gD6G/6pieR728uRHNMewkEgdSaI8c7nbLQdpbCeO
	 +MJELtTkylfi/myUuCCH7EkNXf1FNC4URMpUa3Tw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Block <bblock@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH 6.12 178/277] PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV
Date: Fri, 17 Oct 2025 16:53:05 +0200
Message-ID: <20251017145153.627225745@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145147.138822285@linuxfoundation.org>
References: <20251017145147.138822285@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Schnelle <schnelle@linux.ibm.com>

commit 05703271c3cdcc0f2a8cf6ebdc45892b8ca83520 upstream.

Before disabling SR-IOV via config space accesses to the parent PF,
sriov_disable() first removes the PCI devices representing the VFs.

Since commit 9d16947b7583 ("PCI: Add global pci_lock_rescan_remove()")
such removal operations are serialized against concurrent remove and
rescan using the pci_rescan_remove_lock. No such locking was ever added
in sriov_disable() however. In particular when commit 18f9e9d150fc
("PCI/IOV: Factor out sriov_add_vfs()") factored out the PCI device
removal into sriov_del_vfs() there was still no locking around the
pci_iov_remove_virtfn() calls.

On s390 the lack of serialization in sriov_disable() may cause double
remove and list corruption with the below (amended) trace being observed:

  PSW:  0704c00180000000 0000000c914e4b38 (klist_put+56)
  GPRS: 000003800313fb48 0000000000000000 0000000100000001 0000000000000001
	00000000f9b520a8 0000000000000000 0000000000002fbd 00000000f4cc9480
	0000000000000001 0000000000000000 0000000000000000 0000000180692828
	00000000818e8000 000003800313fe2c 000003800313fb20 000003800313fad8
  #0 [3800313fb20] device_del at c9158ad5c
  #1 [3800313fb88] pci_remove_bus_device at c915105ba
  #2 [3800313fbd0] pci_iov_remove_virtfn at c9152f198
  #3 [3800313fc28] zpci_iov_remove_virtfn at c90fb67c0
  #4 [3800313fc60] zpci_bus_remove_device at c90fb6104
  #5 [3800313fca0] __zpci_event_availability at c90fb3dca
  #6 [3800313fd08] chsc_process_sei_nt0 at c918fe4a2
  #7 [3800313fd60] crw_collect_info at c91905822
  #8 [3800313fe10] kthread at c90feb390
  #9 [3800313fe68] __ret_from_fork at c90f6aa64
  #10 [3800313fe98] ret_from_fork at c9194f3f2.

This is because in addition to sriov_disable() removing the VFs, the
platform also generates hot-unplug events for the VFs. This being the
reverse operation to the hotplug events generated by sriov_enable() and
handled via pdev->no_vf_scan. And while the event processing takes
pci_rescan_remove_lock and checks whether the struct pci_dev still exists,
the lack of synchronization makes this checking racy.

Other races may also be possible of course though given that this lack of
locking persisted so long observable races seem very rare. Even on s390 the
list corruption was only observed with certain devices since the platform
events are only triggered by config accesses after the removal, so as long
as the removal finished synchronously they would not race. Either way the
locking is missing so fix this by adding it to the sriov_del_vfs() helper.

Just like PCI rescan-remove, locking is also missing in sriov_add_vfs()
including for the error case where pci_stop_and_remove_bus_device() is
called without the PCI rescan-remove lock being held. Even in the non-error
case, adding new PCI devices and buses should be serialized via the PCI
rescan-remove lock. Add the necessary locking.

Fixes: 18f9e9d150fc ("PCI/IOV: Factor out sriov_add_vfs()")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250826-pci_fix_sriov_disable-v1-1-2d0bc938f2a3@linux.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/iov.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -581,15 +581,18 @@ static int sriov_add_vfs(struct pci_dev
 	if (dev->no_vf_scan)
 		return 0;
 
+	pci_lock_rescan_remove();
 	for (i = 0; i < num_vfs; i++) {
 		rc = pci_iov_add_virtfn(dev, i);
 		if (rc)
 			goto failed;
 	}
+	pci_unlock_rescan_remove();
 	return 0;
 failed:
 	while (i--)
 		pci_iov_remove_virtfn(dev, i);
+	pci_unlock_rescan_remove();
 
 	return rc;
 }
@@ -709,8 +712,10 @@ static void sriov_del_vfs(struct pci_dev
 	struct pci_sriov *iov = dev->sriov;
 	int i;
 
+	pci_lock_rescan_remove();
 	for (i = 0; i < iov->num_VFs; i++)
 		pci_iov_remove_virtfn(dev, i);
+	pci_unlock_rescan_remove();
 }
 
 static void sriov_disable(struct pci_dev *dev)



