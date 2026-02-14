Return-Path: <stable+bounces-216463-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGu3D5vcj2l+UAEAu9opvQ
	(envelope-from <stable+bounces-216463-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 03:23:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C93C13AC3E
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 03:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 060253038285
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 02:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3E617A2FB;
	Sat, 14 Feb 2026 02:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGHZbV0v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A1A78F59
	for <stable@vger.kernel.org>; Sat, 14 Feb 2026 02:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771035799; cv=none; b=UiXDKK6kbB5GJlQ7FGR32uy9AmDmAYwhWgFYz2mEcf19/ej53maDZoL75umViuYPC63aTqjvEJDtgZ142kPgjxM/xb6nadGQu2k/MS8PfHJbjUThbMPSy0tbV5ghz+q4OjsOSBMjo4LsWj7oxAzjnaeh68r3EwNMSU40MpDJhfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771035799; c=relaxed/simple;
	bh=ridQD8P1dsH2FX8RqVka7S2ww1xcA9HFtWqJLWF8S+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hw8T26LU/vlVjXcQ61vEnL/pbR/vBfWN8md+K/B3dFibZh0Zwj5fno4t0SB9IKdAsBGCnbjxtSz6JO3n81J30j+A68m2Dm9JEeU2Y53QyVFdKRX9eFoWCYXcKGTlLOZENZMqwBSYc09L+bsTaxABF9RJAmsANuF/kuAi9tHLPGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGHZbV0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD106C116C6;
	Sat, 14 Feb 2026 02:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771035798;
	bh=ridQD8P1dsH2FX8RqVka7S2ww1xcA9HFtWqJLWF8S+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NGHZbV0vByVDhAQZg3+Q0F1yOcfB6l2hXzVLNx26n44tSk+0tM8yZJxBtEc7NXgqI
	 lEefYbEdZKutgF98zwIOTHjGX8aG86g6gCPg8w8PszauT2i3I82fQ5WbJ6VJ10ZubP
	 Jq3qxL1YLTHy6lJrb7WbOWr5cCOEAquGbPDo6OAP4381YfkTIi59rHfyyAxdIExvjh
	 i6D/C/4RGhUnKzckmOzTDk5QiAwOzINeVEwIGWAmUZZ86BmYp5jeXXMndrgik/2SrZ
	 fg7Vlcq7fjiDf1p2z/lR5WHlAsFBeKHG6nI71vEn5AnOxO+qoQVj7B1LnnQy358qFj
	 8WqqOL3VCVcxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] PCI: endpoint: Automatically create a function specific attributes group
Date: Fri, 13 Feb 2026 21:23:13 -0500
Message-ID: <20260214022316.4103092-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026021308-foil-sycamore-7994@gregkh>
References: <2026021308-foil-sycamore-7994@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216463-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C93C13AC3E
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
 Documentation/PCI/endpoint/pci-ntb-howto.rst  | 11 ++---
 Documentation/PCI/endpoint/pci-vntb-howto.rst | 13 +++---
 drivers/pci/endpoint/pci-ep-cfs.c             | 42 +++++++++----------
 3 files changed, 29 insertions(+), 37 deletions(-)

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
diff --git a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentation/PCI/endpoint/pci-vntb-howto.rst
index 4ab8e4a26d4be..70d3bc90893f3 100644
--- a/Documentation/PCI/endpoint/pci-vntb-howto.rst
+++ b/Documentation/PCI/endpoint/pci-vntb-howto.rst
@@ -84,13 +84,10 @@ commands can be used::
 	# echo 0x1957 > functions/pci_epf_vntb/func1/vendorid
 	# echo 0x0809 > functions/pci_epf_vntb/func1/deviceid
 
-In order to configure NTB specific attributes, a new sub-directory to func1
-should be created::
-
-	# mkdir functions/pci_epf_vntb/func1/pci_epf_vntb.0/
-
-The NTB function driver will populate this directory with various attributes
-that can be configured by the user::
+The PCI endpoint framework also automatically creates a sub-directory in the
+function attribute directory. This sub-directory has the same name as the name
+of the function device and is populated with the following NTB specific
+attributes that can be configured by the user::
 
 	# ls functions/pci_epf_vntb/func1/pci_epf_vntb.0/
 	db_count    mw1         mw2         mw3         mw4         num_mws
@@ -103,7 +100,7 @@ A sample configuration for NTB function is given below::
 	# echo 1 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/num_mws
 	# echo 0x100000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1
 
-A sample configuration for virtual NTB driver for virutal PCI bus::
+A sample configuration for virtual NTB driver for virtual PCI bus::
 
 	# echo 0x1957 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid
 	# echo 0x080A > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_pid
diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index 6f7253d420dbf..76cffd1c18d8a 100644
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
@@ -502,34 +503,29 @@ static struct configfs_item_operations pci_epf_ops = {
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
@@ -547,6 +543,8 @@ static void pci_epf_cfs_work(struct work_struct *work)
 		pr_err("failed to create 'secondary' EPC interface\n");
 		return;
 	}
+
+	pci_ep_cfs_add_type_group(epf_group);
 }
 
 static struct config_group *pci_epf_make(struct config_group *group,
-- 
2.51.0


