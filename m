Return-Path: <stable+bounces-216073-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id g3JiBJgVj2lfIQEAu9opvQ
	(envelope-from <stable+bounces-216073-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:14:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE92135F7E
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCAD23048ED6
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 12:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600063570BA;
	Fri, 13 Feb 2026 12:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q9CoyOyY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2216134A3A7
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 12:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770984852; cv=none; b=XLncTpfGn1sYrooEqHhUEuZ7mswiOJa6KOGeW85m4oBvM9dxnCHop/xJ+IdVwsiwjNfvH67LUjalGOdfL3/rE3w99YisRmS7q/zzm6dBk39I3S6pnK/Ims7Ev8ECx+MCBDDPkPqHMZLUbT7tI/9/uGxJmL8LXBVXUTiRrj6kbGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770984852; c=relaxed/simple;
	bh=+ErKUSWbJ2esJjnO+/ZE/z78vJzZmPCzwd4sugrHRyk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EnxDlJ0+oS3Q8OX52ewlRKI65qtD8ZDH3H8OMjKucpDc4DJgktzDr2xyyRWcrl80TtwgNIsELwcEiO3x2mcyYPeEXlQs/JgKfYQJwszbAGRfrz1s28g9bdmy/3i6dVo0hJmf48KYcDOnzVQFsSj7GXUfHp3GvmKlQmG/hso6bhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q9CoyOyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7D8C116C6;
	Fri, 13 Feb 2026 12:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770984851;
	bh=+ErKUSWbJ2esJjnO+/ZE/z78vJzZmPCzwd4sugrHRyk=;
	h=Subject:To:Cc:From:Date:From;
	b=Q9CoyOyYPzSgZ+qFD4vMj5ztxOSZ8+Xpt19TcHkipy3pC0gZkdSab5Vo6rlNYarz7
	 MVMa8lIULvojeHjVgj76cZmzknPYieewsgkAy2Sodd+PppJTu6hqd0Q5neMgSAIudv
	 DNDCyQWhcc4QSgQj5Cq4oZN2oE5gKRlYVIG7wHyE=
Subject: FAILED: patch "[PATCH] PCI: endpoint: Avoid creating sub-groups asynchronously" failed to apply to 6.6-stable tree
To: liu.song13@zte.com.cn,bhelgaas@google.com,mani@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 13 Feb 2026 13:14:03 +0100
Message-ID: <2026021303-salt-retread-63e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216073-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,zte.com.cn:email]
X-Rspamd-Queue-Id: 5BE92135F7E
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7c5c7d06bd1f86d2c3ebe62be903a4ba42db4d2c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026021303-salt-retread-63e7@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7c5c7d06bd1f86d2c3ebe62be903a4ba42db4d2c Mon Sep 17 00:00:00 2001
From: Liu Song <liu.song13@zte.com.cn>
Date: Thu, 10 Jul 2025 14:38:45 +0800
Subject: [PATCH] PCI: endpoint: Avoid creating sub-groups asynchronously

The asynchronous creation of sub-groups by a delayed work could lead to a
NULL pointer dereference when the driver directory is removed before the
work completes.

The crash can be easily reproduced with the following commands:

  # cd /sys/kernel/config/pci_ep/functions/pci_epf_test
  # for i in {1..20}; do mkdir test && rmdir test; done

  BUG: kernel NULL pointer dereference, address: 0000000000000088
  ...
  Call Trace:
   configfs_register_group+0x3d/0x190
   pci_epf_cfs_work+0x41/0x110
   process_one_work+0x18f/0x350
   worker_thread+0x25a/0x3a0

Fix this issue by using configfs_add_default_group() API which does not
have the deadlock problem as configfs_register_group() and does not require
the delayed work handler.

Fixes: e85a2d783762 ("PCI: endpoint: Add support in configfs to associate two EPCs with EPF")
Signed-off-by: Liu Song <liu.song13@zte.com.cn>
[mani: slightly reworded the description and added stable list]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@kernel.org
Link: https://patch.msgid.link/20250710143845409gLM6JdlwPhlHG9iX3F6jK@zte.com.cn

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index ef50c82e647f..43feb6139fa3 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -23,7 +23,6 @@ struct pci_epf_group {
 	struct config_group group;
 	struct config_group primary_epc_group;
 	struct config_group secondary_epc_group;
-	struct delayed_work cfs_work;
 	struct pci_epf *epf;
 	int index;
 };
@@ -103,7 +102,7 @@ static struct config_group
 	secondary_epc_group = &epf_group->secondary_epc_group;
 	config_group_init_type_name(secondary_epc_group, "secondary",
 				    &pci_secondary_epc_type);
-	configfs_register_group(&epf_group->group, secondary_epc_group);
+	configfs_add_default_group(secondary_epc_group, &epf_group->group);
 
 	return secondary_epc_group;
 }
@@ -166,7 +165,7 @@ static struct config_group
 
 	config_group_init_type_name(primary_epc_group, "primary",
 				    &pci_primary_epc_type);
-	configfs_register_group(&epf_group->group, primary_epc_group);
+	configfs_add_default_group(primary_epc_group, &epf_group->group);
 
 	return primary_epc_group;
 }
@@ -570,15 +569,13 @@ static void pci_ep_cfs_add_type_group(struct pci_epf_group *epf_group)
 		return;
 	}
 
-	configfs_register_group(&epf_group->group, group);
+	configfs_add_default_group(group, &epf_group->group);
 }
 
-static void pci_epf_cfs_work(struct work_struct *work)
+static void pci_epf_cfs_add_sub_groups(struct pci_epf_group *epf_group)
 {
-	struct pci_epf_group *epf_group;
 	struct config_group *group;
 
-	epf_group = container_of(work, struct pci_epf_group, cfs_work.work);
 	group = pci_ep_cfs_add_primary_group(epf_group);
 	if (IS_ERR(group)) {
 		pr_err("failed to create 'primary' EPC interface\n");
@@ -637,9 +634,7 @@ static struct config_group *pci_epf_make(struct config_group *group,
 
 	kfree(epf_name);
 
-	INIT_DELAYED_WORK(&epf_group->cfs_work, pci_epf_cfs_work);
-	queue_delayed_work(system_wq, &epf_group->cfs_work,
-			   msecs_to_jiffies(1));
+	pci_epf_cfs_add_sub_groups(epf_group);
 
 	return &epf_group->group;
 


