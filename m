Return-Path: <stable+bounces-222137-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK9cJMOdo2k3IQUAu9opvQ
	(envelope-from <stable+bounces-222137-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:00:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9CB1CC936
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6BB63089624
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE47C2FE577;
	Sun,  1 Mar 2026 01:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liJJ1BIS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B203A2FC89C;
	Sun,  1 Mar 2026 01:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329993; cv=none; b=ZDKBS/E1BOP8gpKulIiMU+LRbofl3s1l4fF6kUAPYHcWe7fNww9zteXH/EIdyYcMCvYXaU/yBDYAFC9xpXjmUmi9btg46xbKsKvG2Vdz/HpM3ggMg32/WyUvM0IYWL2gJRElHyy8Ky5r0R6qwuTHc2oSPxID4Ohh4ce3JudRchc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329993; c=relaxed/simple;
	bh=QWFVOPHe8esj9YZWXGNlOviq4Ox/UdtMYwt6HnWygw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QQtGeSd5srxc8+6JP68u1t8MYx34COZo/IGMoRezShuf6AUIuhIk68rqlK5vCUKzADu4qOJiPCeRwxAsCsTWmiKRX56LUEcBS0WLITuqMJC8C/xr6+wqF0yBW5DBP6Ww4EtneOsYuTCA7XWMfmUoqUUaorcgNBCMWBEc1yrjVEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liJJ1BIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EA1C2BC87;
	Sun,  1 Mar 2026 01:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329993;
	bh=QWFVOPHe8esj9YZWXGNlOviq4Ox/UdtMYwt6HnWygw4=;
	h=From:To:Cc:Subject:Date:From;
	b=liJJ1BISWj2Eq0/OhS0/SEiCSUTAf0MSk1+4Fqu/VvmpwgRmuQ1uexHxwCJPsTEWg
	 iK+cRHU5jJr8eLJ64SJk87zLhqv1KlPZAASZDm9nJ95pYcYpjZ9pLtwUAjQ/Tqwmxm
	 M8BhSFBt8AL1hIil0e9iIaQRyOZbnN9nHFKT1Ui/lsp8fPuFQAffKzIKBT1dhh5Gbb
	 ozuZQvGDo57o2Ez0QIx/9piTcmQgAc/U/6gLTSH6zzQ0llgQgvT/EUspcDiAM+TrkN
	 r/t9FwsbrviC7xi41qDmTntffmJbqkSg8Meklu4LwPOu2bRtPpJCyAd6melL0aFuXY
	 DIFYrHQIH0etw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	schnelle@linux.ibm.com
Cc: Benjamin Block <bblock@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	linux-pci@vger.kernel.org
Subject: FAILED: Patch "Revert "PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV"" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:53:11 -0500
Message-ID: <20260301015311.1719887-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222137-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A9CB1CC936
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 2fa119c0e5e528453ebae9e70740e8d2d8c0ed5a Mon Sep 17 00:00:00 2001
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Tue, 16 Dec 2025 23:14:02 +0100
Subject: [PATCH] Revert "PCI/IOV: Add PCI rescan-remove locking when
 enabling/disabling SR-IOV"

This reverts commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking
when enabling/disabling SR-IOV"), which causes a deadlock by recursively
taking pci_rescan_remove_lock when sriov_del_vfs() is called as part of
pci_stop_and_remove_bus_device(). For example with the following sequence
of commands:

  $ echo <NUM> > /sys/bus/pci/devices/<pf>/sriov_numvfs
  $ echo 1 > /sys/bus/pci/devices/<pf>/remove

A trimmed trace of the deadlock on a mlx5 device is as below:

  zsh/5715 is trying to acquire lock:
  000002597926ef50 (pci_rescan_remove_lock){+.+.}-{3:3}, at: sriov_disable+0x34/0x140

  but task is already holding lock:
  000002597926ef50 (pci_rescan_remove_lock){+.+.}-{3:3}, at: pci_stop_and_remove_bus_device_locked+0x24/0x80
  ...
  Call Trace:
   [<00000259778c4f90>] dump_stack_lvl+0xc0/0x110
   [<00000259779c844e>] print_deadlock_bug+0x31e/0x330
   [<00000259779c1908>] __lock_acquire+0x16c8/0x32f0
   [<00000259779bffac>] lock_acquire+0x14c/0x350
   [<00000259789643a6>] __mutex_lock_common+0xe6/0x1520
   [<000002597896413c>] mutex_lock_nested+0x3c/0x50
   [<00000259784a07e4>] sriov_disable+0x34/0x140
   [<00000258f7d6dd80>] mlx5_sriov_disable+0x50/0x80 [mlx5_core]
   [<00000258f7d5745e>] remove_one+0x5e/0xf0 [mlx5_core]
   [<00000259784857fc>] pci_device_remove+0x3c/0xa0
   [<000002597851012e>] device_release_driver_internal+0x18e/0x280
   [<000002597847ae22>] pci_stop_bus_device+0x82/0xa0
   [<000002597847afce>] pci_stop_and_remove_bus_device_locked+0x5e/0x80
   [<00000259784972c2>] remove_store+0x72/0x90
   [<0000025977e6661a>] kernfs_fop_write_iter+0x15a/0x200
   [<0000025977d7241c>] vfs_write+0x24c/0x300
   [<0000025977d72696>] ksys_write+0x86/0x110
   [<000002597895b61c>] __do_syscall+0x14c/0x400
   [<000002597896e0ee>] system_call+0x6e/0x90

This alone is not a complete fix as it restores the issue the cited commit
tried to solve. A new fix will be provided as a follow on.

Fixes: 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV")
Reported-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Acked-by: Gerd Bayer <gbayer@linux.ibm.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251216-revert_sriov_lock-v3-1-dac4925a7621@linux.ibm.com
---
 drivers/pci/iov.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 00784a60ba80b..7de5b18647beb 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -629,18 +629,15 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
 	if (dev->no_vf_scan)
 		return 0;
 
-	pci_lock_rescan_remove();
 	for (i = 0; i < num_vfs; i++) {
 		rc = pci_iov_add_virtfn(dev, i);
 		if (rc)
 			goto failed;
 	}
-	pci_unlock_rescan_remove();
 	return 0;
 failed:
 	while (i--)
 		pci_iov_remove_virtfn(dev, i);
-	pci_unlock_rescan_remove();
 
 	return rc;
 }
@@ -765,10 +762,8 @@ static void sriov_del_vfs(struct pci_dev *dev)
 	struct pci_sriov *iov = dev->sriov;
 	int i;
 
-	pci_lock_rescan_remove();
 	for (i = 0; i < iov->num_VFs; i++)
 		pci_iov_remove_virtfn(dev, i);
-	pci_unlock_rescan_remove();
 }
 
 static void sriov_disable(struct pci_dev *dev)
-- 
2.51.0





