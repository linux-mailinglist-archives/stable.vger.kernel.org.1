Return-Path: <stable+bounces-256665-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iI/LNU7JGWpzzAgAu9opvQ
	(envelope-from <stable+bounces-256665-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:13:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 817DA606365
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4BA531B7324
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 16:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654773EFD13;
	Fri, 29 May 2026 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoQxK4br"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070493F44F4
	for <stable@vger.kernel.org>; Fri, 29 May 2026 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073972; cv=none; b=Xviwd1BsNlj09HCwMY6CCDIudpL6RWm0KGusZN5QWmB7xm2dmr3016oHtzbnxtqDUuAz4zJTpY1KToycOnJI8hfvndeaWsBEp2C4X+Wlnq+6EEir7q6RGe2cgQEbHkh5eraLBPLw6LXwx4yMrH+EWcUe7bOhSUo0IbtGgbX2HEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073972; c=relaxed/simple;
	bh=uPae/BeCFBseFejHtwmGC7G/+OhH+iuFe+/oPFSA10A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THxr+63WrA1ABNJPMDaqeH355I6ja0DXsDWy8tdbwLLN8DQSBly2D20rvbknyOWzfWTqlurPhnfFUYRMhTS9C0CtqPcVzPhgdg+kluEZhQPEOrRgMFRHJ8Wx3SN1oJKALApOZcxVyVtqWu1U/FaGWLt6PvVz7ezjgxL0Jzjwu0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoQxK4br; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CACA1F00898;
	Fri, 29 May 2026 16:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780073970;
	bh=n6ggt2+XaD39MgGtr0ABNOPvq64t6J2JWBkl7UzpEGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aoQxK4brY0BIR2U6Jm0N+C8EfY1hXutev8JoqUXUqxHFez0qLZHu/49XS7sizLglt
	 61lW1nBF/EvCj6aNX4QV5z2O+5NdbYYbjoWcgXRJ4eJJPQ4xRHg0u2+14/C35GMwin
	 88y22g68SN5WvliQb0rRLlHVNSNmHUDPyxhy81BIqLMv7jjRMgI6SafSX/Cf8strY3
	 DU1R/p9QS77D3C1yWdOitH2oTlorVyszP3UfyBB3CE8gTn+jHDGRTx9letJ3QOwZpq
	 3csMGXXFHMyb0j09sU3MUTVRi1EZW2D+GOrLIxlzmpOfaobdz8qS5i1RuHXlFDYxhP
	 h6kf15BVKtR0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] platform/x86/intel/vsec: Fix enable_cnt imbalance on PCIe error recovery
Date: Fri, 29 May 2026 12:59:26 -0400
Message-ID: <20260529165926.1255525-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529165926.1255525-1-sashal@kernel.org>
References: <2026052829-promotion-chubby-ffb5@gregkh>
 <20260529165926.1255525-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256665-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,wunner.de:email]
X-Rspamd-Queue-Id: 817DA606365
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Lukas Wunner <lukas@wunner.de>

[ Upstream commit 348ccc754d8939e21ca5956ff45720b81d6e407f ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/vsec.c | 54 +++++++++++++++++--------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index 008a840a6ac87..96fc27d88fbf3 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -620,29 +620,13 @@ static void intel_vsec_skip_missing_dependencies(struct pci_dev *pdev)
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
@@ -663,6 +647,31 @@ static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id
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
@@ -796,7 +805,6 @@ static pci_ers_result_t intel_vsec_pci_slot_reset(struct pci_dev *pdev)
 {
 	struct intel_vsec_device *intel_vsec_dev;
 	pci_ers_result_t status = PCI_ERS_RESULT_DISCONNECT;
-	const struct pci_device_id *pci_dev_id;
 	unsigned long index;
 
 	dev_info(&pdev->dev, "Resetting PCI slot\n");
@@ -817,10 +825,8 @@ static pci_ers_result_t intel_vsec_pci_slot_reset(struct pci_dev *pdev)
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
-- 
2.53.0


