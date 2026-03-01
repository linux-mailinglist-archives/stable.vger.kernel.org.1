Return-Path: <stable+bounces-221713-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GDZEhGoo2mWJAUAu9opvQ
	(envelope-from <stable+bounces-221713-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:44:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC53D1CDDD8
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F002F32533AF
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91272EB5A6;
	Sun,  1 Mar 2026 01:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryEFbSXm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6DE2D9ECA;
	Sun,  1 Mar 2026 01:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328959; cv=none; b=GiBoUBEOyKHf9OiE9pIEEhbKjqU/tyn6I6X8khXKFGGACs3K3lNVur393WukvSYNZZECPgHWPKs6GCQ8+gB63hmN2wb9Xs0p7wirdE4FxDI88IyJ5gIQbV4/nUE8aSBRkjQHXesr1h65MAQpa9lPc7p4EaNJm5PJ8P7NsPsCP1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328959; c=relaxed/simple;
	bh=R6fxfOvR6jIpSBDGAaQs1PwoCRiQiMbaDo4rBT2tTLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sw8ykBTkT4qYnMy9MKEaObgI7h2T+SlpYk6xVvbtD0QIgAxJPx9/2W0H77UtS0rgkjTO95D68puPftAs2xp7Kv4Y7XiwZbr1Zx9DNsP7iF36nrIfEsIZ05cAy12KGGqPh7PpSKPrDrJ/lAS7pXtOygGO9MuP5EaH5STel3H7UYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryEFbSXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EFAC19425;
	Sun,  1 Mar 2026 01:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328959;
	bh=R6fxfOvR6jIpSBDGAaQs1PwoCRiQiMbaDo4rBT2tTLU=;
	h=From:To:Cc:Subject:Date:From;
	b=ryEFbSXmfV9iH9NAlBn/4Vw+ztG1FHmbkJE3BReOMtYtIh+dA9ftt63JBGQFuhaoW
	 S/ODsiMH+6JOY1FVAEmEP7D9PpOCu2j4RcpH2gi6G57pBqOhonXswGHkjn+STZoTTw
	 FVtnbbBUb2HM4djUHxW+BjJ3eLRaNuSp8N9DRC6X93ecfoOV1aO6SE6B+XIpO2EDwt
	 WZbaL1mDrzMe162laLxBeQ5gM6xP0eSY37e9yze7MT/hmzkKw9mJyrwuAJmOLLV4zq
	 Ts5o2b556z8Y/Isd8oqhdBovWpULKRE9DSQ88673PAUHi/sBge4Y2faJ/h84kGLGFv
	 o7Xbsh+rXGwOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	schnelle@linux.ibm.com
Cc: Benjamin Block <bblock@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	linux-pci@vger.kernel.org
Subject: FAILED: Patch "PCI/IOV: Fix race between SR-IOV enable/disable and hotplug" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:35:57 -0500
Message-ID: <20260301013557.1695786-1-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-221713-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: AC53D1CDDD8
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
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





