Return-Path: <stable+bounces-213459-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHJyB5Vcg2mJlQMAu9opvQ
	(envelope-from <stable+bounces-213459-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:49:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9489EE76D5
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D472C302C931
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FB51C5D77;
	Wed,  4 Feb 2026 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K1Dg/Piq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45815221F17;
	Wed,  4 Feb 2026 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216409; cv=none; b=nlqPZwgClbOM9R8Mw7Daua1fZ3la2d3UDSDtRLEXmd3GzFJXeclQu96KN/3EjBm483LoiUOoEvOzEV3RoCr0Q19AxZoI1tCd7GOU6qsxO82L1Rp4e3sQx43zpAHG7q0WTDXVzzzjd7sug5gMnZ3XGdHF/U5xih0MuZwOJ1tWpfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216409; c=relaxed/simple;
	bh=Oyxk2+AadiJY8/J0bfARPxhL7+XwPco6d1Wj/T9aM88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHEq09fSflygdYE0+6RDz+H4Mdisr0iIhSlLYzw/LHG5IWvohmt4tiP4visxzYNg3M1kkeOH+ng7SJdiVQ3Sq/lblDI+oc4xmSCK9VqjjchkRemPSBI2APfIDjUbMMDS8EADgFD4HAWBcTY/W+5m7xbaDiICJH0FdxkT+GPbGxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K1Dg/Piq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7FAC4CEF7;
	Wed,  4 Feb 2026 14:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216409;
	bh=Oyxk2+AadiJY8/J0bfARPxhL7+XwPco6d1Wj/T9aM88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K1Dg/PiqnHbGn5YfZxv7AmgPVkCU+WWrqwY3UizfxPnvdvMS4Sm97wES1npNPmXoK
	 go9PJKEfOaMq1VXXWh+w2hQoREijrRmxj/woOsaKIJnsOSRMw7RHMaU/W83C0uZ0Nl
	 cIU8U/qHR5p483xu8dYrAi69S9l03vrawjxD+bvo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiang Chen <chenxiang66@hisilicon.com>,
	John Garry <john.garry@huawei.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 080/161] scsi: hisi_sas: Use managed PCI functions
Date: Wed,  4 Feb 2026 15:39:03 +0100
Message-ID: <20260204143854.629264200@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.755002596@linuxfoundation.org>
References: <20260204143851.755002596@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213459-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,oracle.com:email,hisilicon.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9489EE76D5
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiang Chen <chenxiang66@hisilicon.com>

[ Upstream commit 4f6094f1663e2ed26a940f1842cdaa15c1dd649a ]

Use managed PCI functions such as pcim_enable_device() and
pcim_iomap_regions() to simplify exception handling code.

Link: https://lore.kernel.org/r/1629799260-120116-2-git-send-email-john.garry@huawei.com
Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: d5077426e1a7 ("drm/amd/pm: Don't clear SI SMC table when setting power limit")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index fdd765d41f190..4da5f84d46358 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -510,6 +510,8 @@ struct hisi_sas_err_record_v3 {
 #define CHNL_INT_STS_INT2_MSK BIT(3)
 #define CHNL_WIDTH 4
 
+#define BAR_NO_V3_HW	5
+
 enum {
 	DSM_FUNC_ERR_HANDLE_MSI = 0,
 };
@@ -3259,15 +3261,15 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct sas_ha_struct *sha;
 	int rc, phy_nr, port_nr, i;
 
-	rc = pci_enable_device(pdev);
+	rc = pcim_enable_device(pdev);
 	if (rc)
 		goto err_out;
 
 	pci_set_master(pdev);
 
-	rc = pci_request_regions(pdev, DRV_NAME);
+	rc = pcim_iomap_regions(pdev, 1 << BAR_NO_V3_HW, DRV_NAME);
 	if (rc)
-		goto err_out_disable_device;
+		goto err_out;
 
 	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (rc)
@@ -3275,20 +3277,20 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc) {
 		dev_err(dev, "No usable DMA addressing method\n");
 		rc = -ENODEV;
-		goto err_out_regions;
+		goto err_out;
 	}
 
 	shost = hisi_sas_shost_alloc_pci(pdev);
 	if (!shost) {
 		rc = -ENOMEM;
-		goto err_out_regions;
+		goto err_out;
 	}
 
 	sha = SHOST_TO_SAS_HA(shost);
 	hisi_hba = shost_priv(shost);
 	dev_set_drvdata(dev, sha);
 
-	hisi_hba->regs = pcim_iomap(pdev, 5, 0);
+	hisi_hba->regs = pcim_iomap_table(pdev)[BAR_NO_V3_HW];
 	if (!hisi_hba->regs) {
 		dev_err(dev, "cannot map register\n");
 		rc = -ENOMEM;
@@ -3378,10 +3380,6 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 err_out_ha:
 	hisi_sas_free(hisi_hba);
 	scsi_host_put(shost);
-err_out_regions:
-	pci_release_regions(pdev);
-err_out_disable_device:
-	pci_disable_device(pdev);
 err_out:
 	return rc;
 }
@@ -3417,8 +3415,6 @@ static void hisi_sas_v3_remove(struct pci_dev *pdev)
 	sas_remove_host(sha->core.shost);
 
 	hisi_sas_v3_destroy_irqs(pdev, hisi_hba);
-	pci_release_regions(pdev);
-	pci_disable_device(pdev);
 	hisi_sas_free(hisi_hba);
 	hisi_sas_debugfs_exit(hisi_hba);
 	scsi_host_put(shost);
-- 
2.51.0




