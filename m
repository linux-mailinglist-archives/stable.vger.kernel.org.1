Return-Path: <stable+bounces-254738-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIZ1LqDzF2q5WAgAu9opvQ
	(envelope-from <stable+bounces-254738-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 09:49:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5AD5EDF2C
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 09:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 27E283047DE3
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 07:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383B53451AB;
	Thu, 28 May 2026 07:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LD2HOm9a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF43931195C
	for <stable@vger.kernel.org>; Thu, 28 May 2026 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954449; cv=none; b=sJs52CkEVCErKk2YbSPzIVScPX6KNs2OKzKqsWiLu3nkSk+dySgzoGrW3g/XP1/D2SMhfE3AuGRpmObSOseSrchFVs2d1MnKl8wzx5Ir4FoljnHDTXncpTzDj6iHFgTWNtBC/ACEjIwRbu7ndQLYl1PY72DTEcRB1mG+WSeN3lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954449; c=relaxed/simple;
	bh=4VvVTIdDsbh6eCsCo5JM8ub4BCXIAMH5dCMmzVuDGrg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KMtUxW/Em+OPrg3FybzmP7/jRa5BD7UOu5QEQkfZR10lLtg16mXb5Bnrb7Al5x9Tl3Rc9hLb2oRl246LNvsjq6pGdx9h3SaeLyAmKYntGvHrEqsdWdIRlYw7mxty4GTOHoVgAEuf38d9wnoX7tlgHsnMJPevG0uvalmWULpTenM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LD2HOm9a; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE92C1F000E9;
	Thu, 28 May 2026 07:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779954447;
	bh=M2yz/EbFdsvY1H4WYBdTHJB+A1VNLdk5oWTj1q3JIfc=;
	h=Subject:To:Cc:From:Date;
	b=LD2HOm9aucPqrfmxjdcML4ezKlO0XnvD3ukq9MQ+R0PXLIfxAgMbBTA0I1e+8mVuR
	 NfitFsG4UPYRj99j8b120mQl5Hw2z3zLmbQZLArB0jlNRWB7EciZh7lkCrk7mGFNUq
	 o4LyJQ4IwwJXBQXXBD9jr9McZ5Krme0v37N3yd3c=
Subject: FAILED: patch "[PATCH] platform/x86/intel/vsec: Fix enable_cnt imbalance on PCIe" failed to apply to 6.6-stable tree
To: lukas@wunner.de,ilpo.jarvinen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 09:46:30 +0200
Message-ID: <2026052830-recital-jaws-341f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254738-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,intel.com:email,msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BD5AD5EDF2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 348ccc754d8939e21ca5956ff45720b81d6e407f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052830-recital-jaws-341f@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 348ccc754d8939e21ca5956ff45720b81d6e407f Mon Sep 17 00:00:00 2001
From: Lukas Wunner <lukas@wunner.de>
Date: Thu, 14 May 2026 07:40:42 +0200
Subject: [PATCH] platform/x86/intel/vsec: Fix enable_cnt imbalance on PCIe
 error recovery
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After a PCIe Uncorrectable Error has been reported by a device with
Intel Vendor Specific Extended Capabilities and has been recovered
through a Secondary Bus Reset, its driver calls intel_vsec_pci_probe()
to rescan and reinitialize VSECs.

intel_vsec_pci_probe() invokes pcim_enable_device() and thereby adds
another devm action which calls pcim_disable_device() on driver unbind.

So once the driver unbinds, pcim_disable_device() will be called as many
times as an Uncorrectable Error occurred, plus one.  This will lead to
an enable_cnt imbalance on driver unbind.

Additionally, since commit dc957ab6aa05 ("platform/x86/intel/vsec: Add
private data for per-device data"), a devm_kzalloc() allocation is
leaked on every Uncorrectable Error.

Avoid by splitting the VSEC rescan out of intel_vsec_pci_probe() into a
separate helper and calling that on PCIe error recovery.

Fixes: 936874b77dd0 ("platform/x86/intel/vsec: Add PCI error recovery support to Intel PMT")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org  # v6.0+
Link: https://patch.msgid.link/bd594d09fa866dc51dddc9a447c3b23f9b1402cc.1778736835.git.lukas@wunner.de
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index 7d5dbc1c1d05..18e4a892bf0f 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -649,29 +649,13 @@ static void intel_vsec_skip_missing_dependencies(struct pci_dev *pdev)
 	}
 }
 
-static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+static int intel_vsec_pci_init(struct pci_dev *pdev)
 {
-	const struct intel_vsec_platform_info *info;
-	struct vsec_priv *priv;
-	int num_caps, ret;
+	struct vsec_priv *priv = pci_get_drvdata(pdev);
+	const struct intel_vsec_platform_info *info = priv->info;
 	int run_once = 0;
 	bool found_any = false;
-
-	ret = pcim_enable_device(pdev);
-	if (ret)
-		return ret;
-
-	pci_save_state(pdev);
-	info = (const struct intel_vsec_platform_info *)id->driver_data;
-	if (!info)
-		return -EINVAL;
-
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	priv->info = info;
-	pci_set_drvdata(pdev, priv);
+	int num_caps;
 
 	num_caps = hweight_long(info->caps);
 	while (num_caps--) {
@@ -692,6 +676,31 @@ static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id
 	return 0;
 }
 
+static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	const struct intel_vsec_platform_info *info;
+	struct vsec_priv *priv;
+	int ret;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	pci_save_state(pdev);
+	info = (const struct intel_vsec_platform_info *)id->driver_data;
+	if (!info)
+		return -EINVAL;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->info = info;
+	pci_set_drvdata(pdev, priv);
+
+	return intel_vsec_pci_init(pdev);
+}
+
 int intel_vsec_set_mapping(struct oobmsm_plat_info *plat_info,
 			   struct intel_vsec_device *vsec_dev)
 {
@@ -832,7 +841,6 @@ static pci_ers_result_t intel_vsec_pci_slot_reset(struct pci_dev *pdev)
 {
 	struct intel_vsec_device *intel_vsec_dev;
 	pci_ers_result_t status = PCI_ERS_RESULT_DISCONNECT;
-	const struct pci_device_id *pci_dev_id;
 	unsigned long index;
 
 	dev_info(&pdev->dev, "Resetting PCI slot\n");
@@ -853,10 +861,8 @@ static pci_ers_result_t intel_vsec_pci_slot_reset(struct pci_dev *pdev)
 		devm_release_action(&pdev->dev, intel_vsec_remove_aux,
 				    &intel_vsec_dev->auxdev);
 	}
-	pci_disable_device(pdev);
 	pci_restore_state(pdev);
-	pci_dev_id = pci_match_id(intel_vsec_pci_ids, pdev);
-	intel_vsec_pci_probe(pdev, pci_dev_id);
+	intel_vsec_pci_init(pdev);
 
 out:
 	return status;


