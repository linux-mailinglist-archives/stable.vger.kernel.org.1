Return-Path: <stable+bounces-221456-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GxPJCKlo2mWJAUAu9opvQ
	(envelope-from <stable+bounces-221456-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:32:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 201601CDA65
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE1B2302E301
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B681F27E07A;
	Sun,  1 Mar 2026 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfKK8AW/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC6B2727EB;
	Sun,  1 Mar 2026 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328310; cv=none; b=RBksEa6kZ2YT5dSkXo5H/zaU7uqiAsAiy3UK9AJhmrmH26XHajTi/GSJKkgrvsyTtNqY0NKKfpghQMvIxWTwD1PyAnogGr0q+y4pgcOEgzfv4ChxP21lZmtzFsMoK3mxWCYRPqopBdsaYNPMagzgnAyjZM6cMYMBbE/BcgGNnSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328310; c=relaxed/simple;
	bh=yfLntZyjFRtW0d6AS6ZFzz8TUaysqvRNczAUc7bZNJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cweu1Z6Oy8QO45Wf5kdzkQOJlHwF8BRBRY+zqlA5ev/cko4j34B8LRSRzRPGrjGwiJctt9IOgDQPuYiTKKrwiYbSC/XpDRnqDHhLnXQhiRdCDJU3hIDQEhaB9M/LWCOXbGa6BBva9Ui8qervnHAll9s1DLNda+wDA7crEE3E3Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfKK8AW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609A2C19424;
	Sun,  1 Mar 2026 01:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328310;
	bh=yfLntZyjFRtW0d6AS6ZFzz8TUaysqvRNczAUc7bZNJw=;
	h=From:To:Cc:Subject:Date:From;
	b=hfKK8AW/sb8A+Ia1Pu1t0D+2XSFXy0Bcve5ufVChdoghmNzjQ6AWFBjt4ngD8bLuz
	 +ZLZ8z33l4kt+2xDucS8GiCT03xylR2fy6Mn23fcJvB6sKhccznsd0lb6+ynckeAvN
	 2Dw5UX5cRhwohuvQBaGNAu57RAtDJxiFrocHXnGmKRVNVKnu6NgIU9kh2YZh4kqOa6
	 1L3lDQ4HcZhVv5Z8TuATrXuntXVLdVAffLRVCGQbqIJJJ+sFZDLcsB2qQNq3mwUq2G
	 ZdLGj2MgUwAF2raZAf+XVvXbBXp8T8HtPbppVT/Ywk2khNllvNaMV3rSWAKxh5JKQb
	 u08ZkEeZpXH5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	schnelle@linux.ibm.com
Cc: Benjamin Block <bblock@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	linux-pci@vger.kernel.org
Subject: FAILED: Patch "PCI/IOV: Fix race between SR-IOV enable/disable and hotplug" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:25:07 -0500
Message-ID: <20260301012508.1682164-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221456-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 201601CDA65
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a5338e365c4559d7b4d7356116b0eb95b12e08d5 Mon Sep 17 00:00:00 2001
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Tue, 16 Dec 2025 23:14:03 +0100
Subject: [PATCH] PCI/IOV: Fix race between SR-IOV enable/disable and hotplug

Commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when
enabling/disabling SR-IOV") tried to fix a race between the VF removal
inside sriov_del_vfs() and concurrent hot unplug by taking the PCI
rescan/remove lock in sriov_del_vfs(). Similarly the PCI rescan/remove lock
was also taken in sriov_add_vfs() to protect addition of VFs.

This approach however causes deadlock on trying to remove PFs with SR-IOV
enabled because PFs disable SR-IOV during removal and this removal happens
under the PCI rescan/remove lock. So the original fix had to be reverted.

Instead of taking the PCI rescan/remove lock in sriov_add_vfs() and
sriov_del_vfs(), fix the race that occurs with SR-IOV enable and disable vs
hotplug higher up in the callchain by taking the lock in
sriov_numvfs_store() before calling into the driver's sriov_configure()
callback.

Fixes: 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV")
Reported-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251216-revert_sriov_lock-v3-2-dac4925a7621@linux.ibm.com
---
 drivers/pci/iov.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 7de5b18647beb..4a659c34935e1 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -495,7 +495,9 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 
 	if (num_vfs == 0) {
 		/* disable VFs */
+		pci_lock_rescan_remove();
 		ret = pdev->driver->sriov_configure(pdev, 0);
+		pci_unlock_rescan_remove();
 		goto exit;
 	}
 
@@ -507,7 +509,9 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 		goto exit;
 	}
 
+	pci_lock_rescan_remove();
 	ret = pdev->driver->sriov_configure(pdev, num_vfs);
+	pci_unlock_rescan_remove();
 	if (ret < 0)
 		goto exit;
 
-- 
2.51.0





