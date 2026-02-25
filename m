Return-Path: <stable+bounces-219188-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JWmlI653nmn/VQQAu9opvQ
	(envelope-from <stable+bounces-219188-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 05:16:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2E119188A
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 05:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA7AA304C486
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F46329BD90;
	Wed, 25 Feb 2026 04:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MyvzTN8u"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26141E8836;
	Wed, 25 Feb 2026 04:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771992999; cv=none; b=t8Yy9P48f4X3TTcP1idsm5PvCnICHClFiqM+J3Bpc4hdhVY6fFyeWAmsbuaq+6gK/8NTiia+LbX98d410bQGC1hXhlRb3JuCNadW1DjGkRmhPx5brwXj65YHr9HFBtlv70djKDGWtGQzByKd+po1zh0T3ZP4+8KUC70XU9UpEYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771992999; c=relaxed/simple;
	bh=sdKKVLcqscdDMHAnpJ+Gkqhj+X56bUXmUnQwvc+2jLU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m9HZKoh+3NDTqw0/+7RwTJ5lI2ZYB9zUfxCy1z1x6Clp9GTnsBZqe5TbVyBUs9Mv/HclQ0Vt7Uwu5XSY6kgWo2uKeWLIOt7Sl9ynBN3hdBkfBcd5s8e5CuXVsuJcHn6yXjteph9dgV0388zQYIethb35By+5ZwdipqZy98fidSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MyvzTN8u; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Hr
	hdleSboPuLc6Y9mZ4jEkEnwB4af0/nPwDI6YPYUfU=; b=MyvzTN8u61wLcChTdo
	eCMHgT/ycIMFpsTnvivUwOFByQwtjyKdaauHtm3YZU0yA6BQZIN6kyKu2G88uA4j
	NBqr+rHpJeoIhxfjsp/8f1CiGyWeIUq0MUnYrBuzM4571ofBGKLPu8BIDVSioh99
	v9dkVONMlqVR/yTDv2diX1Bls=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDX_QiHd55pLy8aMw--.48963S2;
	Wed, 25 Feb 2026 12:16:08 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Rob Herring <robh@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 6.1.y 1/2] net: enetc: reimplement RFS/RSS memory clearing as PCI quirk
Date: Wed, 25 Feb 2026 12:16:04 +0800
Message-Id: <20260225041605.1563705-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX_QiHd55pLy8aMw--.48963S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Aw18Zr47WF43Kw1xJw4UCFg_yoWxXr4DpF
	WfWasIgr4kXry5Cw4kJr4UAFy5KF4Iq3yrW3yxCw1I9a1avFn7Jrn2gr10y3W8trWkXa17
	A34Dta18ZF1kAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi4SokUUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC+QkCm2med4k0cQAA3l
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219188-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,nxp.com,kernel.org,davemloft.net,163.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[black.hawk@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,davemloft.net:email]
X-Rspamd-Queue-Id: DA2E119188A
X-Rspamd-Action: no action

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit f0168042a21292d20007d24ab2e4fc32f79ebf11 ]

The workaround implemented in commit 3222b5b613db ("net: enetc:
initialize RFS/RSS memories for unused ports too") is no longer
effective after commit 6fffbc7ae137 ("PCI: Honor firmware's device
disabled status"). Thus, it has introduced a regression and we see AER
errors being reported again:

$ ip link set sw2p0 up && dhclient -i sw2p0 && ip addr show sw2p0
fsl_enetc 0000:00:00.2 eno2: configuring for fixed/internal link mode
fsl_enetc 0000:00:00.2 eno2: Link is Up - 2.5Gbps/Full - flow control rx/tx
mscc_felix 0000:00:00.5 swp2: configuring for fixed/sgmii link mode
mscc_felix 0000:00:00.5 swp2: Link is Up - 1Gbps/Full - flow control off
sja1105 spi2.2 sw2p0: configuring for phy/rgmii-id link mode
sja1105 spi2.2 sw2p0: Link is Up - 1Gbps/Full - flow control off
pcieport 0000:00:1f.0: AER: Multiple Corrected error received: 0000:00:00.0
pcieport 0000:00:1f.0: AER: can't find device of ID0000

Rob's suggestion is to reimplement the enetc driver workaround as a
PCI fixup, and to modify the PCI core to run the fixups for all PCI
functions. This change handles the first part.

We refactor the common code in enetc_psi_create() and enetc_psi_destroy(),
and use the PCI fixup only for those functions for which enetc_pf_probe()
won't get called. This avoids some work being done twice for the PFs
which are enabled.

Fixes: 6fffbc7ae137 ("PCI: Honor firmware's device disabled status")
Link: https://lore.kernel.org/netdev/CAL_JsqLsVYiPLx2kcHkDQ4t=hQVCR7NHziDwi9cCFUFhx48Qow@mail.gmail.com/
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Rahul Sharma <black.hawk@163.com>
---
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 103 +++++++++++++-----
 1 file changed, 73 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index b84d5a66558a..b6fd12c9ecc4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -1236,50 +1236,81 @@ static int enetc_pf_register_with_ierb(struct pci_dev *pdev)
 	return ret;
 }
 
-static int enetc_pf_probe(struct pci_dev *pdev,
-			  const struct pci_device_id *ent)
+static struct enetc_si *enetc_psi_create(struct pci_dev *pdev)
 {
-	struct device_node *node = pdev->dev.of_node;
-	struct enetc_ndev_priv *priv;
-	struct net_device *ndev;
 	struct enetc_si *si;
-	struct enetc_pf *pf;
 	int err;
 
-	err = enetc_pf_register_with_ierb(pdev);
-	if (err == -EPROBE_DEFER)
-		return err;
-	if (err)
-		dev_warn(&pdev->dev,
-			 "Could not register with IERB driver: %pe, please update the device tree\n",
-			 ERR_PTR(err));
-
-	err = enetc_pci_probe(pdev, KBUILD_MODNAME, sizeof(*pf));
-	if (err)
-		return dev_err_probe(&pdev->dev, err, "PCI probing failed\n");
+	err = enetc_pci_probe(pdev, KBUILD_MODNAME, sizeof(struct enetc_pf));
+	if (err) {
+		dev_err_probe(&pdev->dev, err, "PCI probing failed\n");
+		goto out;
+	}
 
 	si = pci_get_drvdata(pdev);
 	if (!si->hw.port || !si->hw.global) {
 		err = -ENODEV;
 		dev_err(&pdev->dev, "could not map PF space, probing a VF?\n");
-		goto err_map_pf_space;
+		goto out_pci_remove;
 	}
 
 	err = enetc_setup_cbdr(&pdev->dev, &si->hw, ENETC_CBDR_DEFAULT_SIZE,
 			       &si->cbd_ring);
 	if (err)
-		goto err_setup_cbdr;
+		goto out_pci_remove;
 
 	err = enetc_init_port_rfs_memory(si);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to initialize RFS memory\n");
-		goto err_init_port_rfs;
+		goto out_teardown_cbdr;
 	}
 
 	err = enetc_init_port_rss_memory(si);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to initialize RSS memory\n");
-		goto err_init_port_rss;
+		goto out_teardown_cbdr;
+	}
+
+	return si;
+
+out_teardown_cbdr:
+	enetc_teardown_cbdr(&si->cbd_ring);
+out_pci_remove:
+	enetc_pci_remove(pdev);
+out:
+	return ERR_PTR(err);
+}
+
+static void enetc_psi_destroy(struct pci_dev *pdev)
+{
+	struct enetc_si *si = pci_get_drvdata(pdev);
+
+	enetc_teardown_cbdr(&si->cbd_ring);
+	enetc_pci_remove(pdev);
+}
+
+static int enetc_pf_probe(struct pci_dev *pdev,
+			  const struct pci_device_id *ent)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct enetc_ndev_priv *priv;
+	struct net_device *ndev;
+	struct enetc_si *si;
+	struct enetc_pf *pf;
+	int err;
+
+	err = enetc_pf_register_with_ierb(pdev);
+	if (err == -EPROBE_DEFER)
+		return err;
+	if (err)
+		dev_warn(&pdev->dev,
+			 "Could not register with IERB driver: %pe, please update the device tree\n",
+			 ERR_PTR(err));
+
+	si = enetc_psi_create(pdev);
+	if (IS_ERR(si)) {
+		err = PTR_ERR(si);
+		goto err_psi_create;
 	}
 
 	if (node && !of_device_is_available(node)) {
@@ -1365,15 +1396,10 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 	si->ndev = NULL;
 	free_netdev(ndev);
 err_alloc_netdev:
-err_init_port_rss:
-err_init_port_rfs:
 err_device_disabled:
 err_setup_mac_addresses:
-	enetc_teardown_cbdr(&si->cbd_ring);
-err_setup_cbdr:
-err_map_pf_space:
-	enetc_pci_remove(pdev);
-
+	enetc_psi_destroy(pdev);
+err_psi_create:
 	return err;
 }
 
@@ -1396,12 +1422,29 @@ static void enetc_pf_remove(struct pci_dev *pdev)
 	enetc_free_msix(priv);
 
 	enetc_free_si_resources(priv);
-	enetc_teardown_cbdr(&si->cbd_ring);
 
 	free_netdev(si->ndev);
 
-	enetc_pci_remove(pdev);
+	enetc_psi_destroy(pdev);
+}
+
+static void enetc_fixup_clear_rss_rfs(struct pci_dev *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct enetc_si *si;
+
+	/* Only apply quirk for disabled functions. For the ones
+	 * that are enabled, enetc_pf_probe() will apply it.
+	 */
+	if (node && of_device_is_available(node))
+		return;
+
+	si = enetc_psi_create(pdev);
+	if (si)
+		enetc_psi_destroy(pdev);
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, ENETC_DEV_ID_PF,
+			enetc_fixup_clear_rss_rfs);
 
 static const struct pci_device_id enetc_pf_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, ENETC_DEV_ID_PF) },
-- 
2.34.1


