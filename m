Return-Path: <stable+bounces-216477-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QICFN4VykGncZgEAu9opvQ
	(envelope-from <stable+bounces-216477-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 14:03:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B00013C045
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 14:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48381301027C
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 13:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF10F2222CB;
	Sat, 14 Feb 2026 13:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQZxi3Mz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A304C18DB35
	for <stable@vger.kernel.org>; Sat, 14 Feb 2026 13:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771074177; cv=none; b=qjgGlNRZzfnB1isRzkChFmeDuIVCCCOkIBTSGXNs+3TsbdGzAqnNoZGFT1SWs6UlLLv5PKVe5CLJdrsrPHXH5E642vfn1s5RRq/f+caVyhC4Mwg6CfCae2lmFA+RT5+j3rkXqZpTCIgbApwE7zEUbGwMf6oLpLgFzWqPmAAUpY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771074177; c=relaxed/simple;
	bh=6aOXdO6UdD3iD8+uuz0n40Uz1u0ZpKev1VqHX353/bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T2ZRHU09dWIEDh5YY1xSIkJc34AnpL8Q3iuLtcUDCCMe/YzDt+yP/swhlg2n5IZ4M0sZ0fC70EqqLPxtcmZSZbJMyn+CVKvArhqr7++oEFoaYid1+K53vB/iRTartH6uax3iZBMGEfPRc0x0IPuzDp6g5B+5ikx0h2sIFy/Awng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQZxi3Mz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BA0C16AAE;
	Sat, 14 Feb 2026 13:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771074177;
	bh=6aOXdO6UdD3iD8+uuz0n40Uz1u0ZpKev1VqHX353/bQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aQZxi3Mz/8Mn0GAaE4EDqQYVzyx8NAOaKLMSQS9XN1ZhyL2qxnOnzDayEeVakAAq3
	 bGNPzyl+pVaeZUJQbrm5vtkOI96MtzUcwmV6g5h388W2g/8djISaJpv1AjV6z9p+ia
	 /uMRkPIptS/iKbDbrS7f1sNev5MJpE7pdDINGum4gZTppGSz4z4W1DRszv5RntM4LS
	 dHg0RsjWUhVWto2PO4vlJ0GMHd2qnfXh9gOPHx5gQQ4OUvvTUDfPMUvC8BklVAJ0Q0
	 N4Kk1Cq24TXG8DyvsmABHO8fbnVT6XVyGW4WbuLaivb0oJ3pZe/lNJy3I951cmlJcz
	 DYeoxaw5m6KxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] PCI: endpoint: Automatically create a function specific attributes group
Date: Sat, 14 Feb 2026 08:02:52 -0500
Message-ID: <20260214130254.345213-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026021309-browse-cloud-99d5@gregkh>
References: <2026021309-browse-cloud-99d5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216477-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B00013C045
X-Rspamd-Action: no action

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit 70b3740f2c1941e2006d61539131b70d20cba9a6 ]

A PCI endpoint function driver can define function specific attributes
under its function configfs directory using the add_cfs() endpoint driver
operation. This is done by tying up the mkdir operation for the function
configfs directory to a call to the add_cfs() operation.  However, there
are no checks preventing the user from repeatedly creating function
specific attribute directories with different names, resulting in the same
endpoint specific attributes group being added multiple times, which also
result in an invalid reference counting for the attribute groups. E.g.,
using the pci-epf-ntb function driver as an example, the user creates the
function as follows:

  $ modprobe pci-epf-ntb
  $ cd /sys/kernel/config/pci_ep/functions/pci_epf_ntb
  $ mkdir func0
  $ tree func0
  func0/
  |-- baseclass_code
  |-- cache_line_size
  |-- ...
  `-- vendorid

  $ mkdir func0/attrs
  $ tree func0
  func0/
  |-- attrs
  |   |-- db_count
  |   |-- mw1
  |   |-- mw2
  |   |-- mw3
  |   |-- mw4
  |   |-- num_mws
  |   `-- spad_count
  |-- baseclass_code
  |-- cache_line_size
  |-- ...
  `-- vendorid

At this point, the function can be started by linking the EP controller.
However, if the user mistakenly creates again a directory:

  $ mkdir func0/attrs2
  $ tree func0
  func0/
  |-- attrs
  |   |-- db_count
  |   |-- mw1
  |   |-- mw2
  |   |-- mw3
  |   |-- mw4
  |   |-- num_mws
  |   `-- spad_count
  |-- attrs2
  |   |-- db_count
  |   |-- mw1
  |   |-- mw2
  |   |-- mw3
  |   |-- mw4
  |   |-- num_mws
  |   `-- spad_count
  |-- baseclass_code
  |-- cache_line_size
  |-- ...
  `-- vendorid

The endpoint function specific attributes are duplicated and cause a crash
when the endpoint function device is torn down:

  refcount_t: addition on 0; use-after-free.
  WARNING: CPU: 2 PID: 834 at lib/refcount.c:25 refcount_warn_saturate+0xc8/0x144
  CPU: 2 PID: 834 Comm: rmdir Not tainted 6.3.0-rc1 #1
  Hardware name: Pine64 RockPro64 v2.1 (DT)
  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  ...
  Call trace:
  refcount_warn_saturate+0xc8/0x144
  config_item_get+0x7c/0x80
  configfs_rmdir+0x17c/0x30c
  vfs_rmdir+0x8c/0x204
  do_rmdir+0x158/0x184
  __arm64_sys_unlinkat+0x64/0x80
  invoke_syscall+0x48/0x114
  ...

Fix this by modifying pci_epf_cfs_work() to execute the new function
pci_ep_cfs_add_type_group() which itself calls pci_epf_type_add_cfs() to
obtain the function specific attribute group and the group name (directory
name) from the endpoint function driver. If the function driver defines an
attribute group, pci_ep_cfs_add_type_group() then proceeds to register this
group using configfs_register_group(), thus automatically exposing the
function type specific configfs attributes to the user. E.g.:

  $ modprobe pci-epf-ntb
  $ cd /sys/kernel/config/pci_ep/functions/pci_epf_ntb
  $ mkdir func0
  $ tree func0
  func0/
  |-- baseclass_code
  |-- cache_line_size
  |-- ...
  |-- pci_epf_ntb.0
  |   |-- db_count
  |   |-- mw1
  |   |-- mw2
  |   |-- mw3
  |   |-- mw4
  |   |-- num_mws
  |   `-- spad_count
  |-- primary
  |-- ...
  `-- vendorid

With this change, there is no need for the user to create or delete
directories in the endpoint function attributes directory. The
pci_epf_type_group_ops group operations are thus removed.

Also update the documentation for the pci-epf-ntb and pci-epf-vntb function
drivers to reflect this change, removing the explanations showing the need
to manually create the sub-directory for the function specific attributes.

Link: https://lore.kernel.org/r/20230415023542.77601-2-dlemoal@kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Stable-dep-of: 7c5c7d06bd1f ("PCI: endpoint: Avoid creating sub-groups asynchronously")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/PCI/endpoint/pci-ntb-howto.rst | 11 ++---
 drivers/pci/endpoint/pci-ep-cfs.c            | 42 ++++++++++----------
 2 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/Documentation/PCI/endpoint/pci-ntb-howto.rst b/Documentation/PCI/endpoint/pci-ntb-howto.rst
index 1884bf29caba4..4261e7157ef1c 100644
--- a/Documentation/PCI/endpoint/pci-ntb-howto.rst
+++ b/Documentation/PCI/endpoint/pci-ntb-howto.rst
@@ -88,13 +88,10 @@ commands can be used::
 	# echo 0x104c > functions/pci_epf_ntb/func1/vendorid
 	# echo 0xb00d > functions/pci_epf_ntb/func1/deviceid
 
-In order to configure NTB specific attributes, a new sub-directory to func1
-should be created::
-
-	# mkdir functions/pci_epf_ntb/func1/pci_epf_ntb.0/
-
-The NTB function driver will populate this directory with various attributes
-that can be configured by the user::
+The PCI endpoint framework also automatically creates a sub-directory in the
+function attribute directory. This sub-directory has the same name as the name
+of the function device and is populated with the following NTB specific
+attributes that can be configured by the user::
 
 	# ls functions/pci_epf_ntb/func1/pci_epf_ntb.0/
 	db_count    mw1         mw2         mw3         mw4         num_mws
diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index 149de77b2a423..9afc907f3660a 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -23,6 +23,7 @@ struct pci_epf_group {
 	struct config_group group;
 	struct config_group primary_epc_group;
 	struct config_group secondary_epc_group;
+	struct config_group *type_group;
 	struct delayed_work cfs_work;
 	struct pci_epf *epf;
 	int index;
@@ -514,34 +515,29 @@ static struct configfs_item_operations pci_epf_ops = {
 	.release		= pci_epf_release,
 };
 
-static struct config_group *pci_epf_type_make(struct config_group *group,
-					      const char *name)
-{
-	struct pci_epf_group *epf_group = to_pci_epf_group(&group->cg_item);
-	struct config_group *epf_type_group;
-
-	epf_type_group = pci_epf_type_add_cfs(epf_group->epf, group);
-	return epf_type_group;
-}
-
-static void pci_epf_type_drop(struct config_group *group,
-			      struct config_item *item)
-{
-	config_item_put(item);
-}
-
-static struct configfs_group_operations pci_epf_type_group_ops = {
-	.make_group     = &pci_epf_type_make,
-	.drop_item      = &pci_epf_type_drop,
-};
-
 static const struct config_item_type pci_epf_type = {
-	.ct_group_ops	= &pci_epf_type_group_ops,
 	.ct_item_ops	= &pci_epf_ops,
 	.ct_attrs	= pci_epf_attrs,
 	.ct_owner	= THIS_MODULE,
 };
 
+static void pci_ep_cfs_add_type_group(struct pci_epf_group *epf_group)
+{
+	struct config_group *group;
+
+	group = pci_epf_type_add_cfs(epf_group->epf, &epf_group->group);
+	if (!group)
+		return;
+
+	if (IS_ERR(group)) {
+		dev_err(&epf_group->epf->dev,
+			"failed to create epf type specific attributes\n");
+		return;
+	}
+
+	configfs_register_group(&epf_group->group, group);
+}
+
 static void pci_epf_cfs_work(struct work_struct *work)
 {
 	struct pci_epf_group *epf_group;
@@ -559,6 +555,8 @@ static void pci_epf_cfs_work(struct work_struct *work)
 		pr_err("failed to create 'secondary' EPC interface\n");
 		return;
 	}
+
+	pci_ep_cfs_add_type_group(epf_group);
 }
 
 static struct config_group *pci_epf_make(struct config_group *group,
-- 
2.51.0


