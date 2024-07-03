Return-Path: <stable+bounces-57521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B462925CD2
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3082C44CE
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7618C194A72;
	Wed,  3 Jul 2024 11:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1qBTVAvF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D3417DA3A;
	Wed,  3 Jul 2024 11:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005132; cv=none; b=tPIvnwG4EsecdgSxzvxPjMm71eKL/+tiPDyG0BkTO164aGWiB7/qTyQtGHrMwYVihH1W7czZyKqJD2EuD8uSAQZZyCxWH3FKpX1T1EYcTC4nO1DO3cUP7DjIH0qol4246arQFdly/w0U4IbB7deKvHovCKPjeO0GhH+Y0NhHrpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005132; c=relaxed/simple;
	bh=2uxHCjyvaLIdbb1GmHWcY/aDDtZS/IQCxbSCvE9U2tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyTRkfMf2TdgEI46jZmjweku10DhygdqWAjnd3j7EncjXtq7WsVEFBNZlVeOZyiWjNBXk5+JVe9US5qboxRUPINg4R6fitAG3i67KZo54eM4z1HzMPeRfHWXKp8mwYMEPiCMMzS2gUytnVmExf8/1Jbj6sw3APKWC8N8gcYl+QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1qBTVAvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9E0C32781;
	Wed,  3 Jul 2024 11:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720005132;
	bh=2uxHCjyvaLIdbb1GmHWcY/aDDtZS/IQCxbSCvE9U2tQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1qBTVAvFLB09ayZflLWSqdyuvv6orLbEMPiaedR3T7FIL3UoAqOeMncWNLvIr/s4X
	 zXhysIGNtQUMKYIh/acTYE1X2uIAG5vxfqARQ6QepC4Q2qqjLTCVJLKFf91StJ6Z2t
	 e0dHdTXh+GLzWVzYg0RNxDVnFFr+lSwKnFsyiuqY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 5.10 272/290] ata: ahci: Clean up sysfs file on error
Date: Wed,  3 Jul 2024 12:40:53 +0200
Message-ID: <20240703102914.424778771@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102904.170852981@linuxfoundation.org>
References: <20240703102904.170852981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <cassel@kernel.org>

commit eeb25a09c5e0805d92e4ebd12c4b0ad0df1b0295 upstream.

.probe() (ahci_init_one()) calls sysfs_add_file_to_group(), however,
if probe() fails after this call, we currently never call
sysfs_remove_file_from_group().

(The sysfs_remove_file_from_group() call in .remove() (ahci_remove_one())
does not help, as .remove() is not called on .probe() error.)

Thus, if probe() fails after the sysfs_add_file_to_group() call, the next
time we insmod the module we will get:

sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:04.0/remapped_nvme'
CPU: 11 PID: 954 Comm: modprobe Not tainted 6.10.0-rc5 #43
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x5d/0x80
 sysfs_warn_dup.cold+0x17/0x23
 sysfs_add_file_mode_ns+0x11a/0x130
 sysfs_add_file_to_group+0x7e/0xc0
 ahci_init_one+0x31f/0xd40 [ahci]

Fixes: 894fba7f434a ("ata: ahci: Add sysfs attribute to show remapped NVMe device count")
Cc: stable@vger.kernel.org
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Link: https://lore.kernel.org/r/20240629124210.181537-10-cassel@kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/ahci.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1893,8 +1893,10 @@ static int ahci_init_one(struct pci_dev
 	n_ports = max(ahci_nr_ports(hpriv->cap), fls(hpriv->port_map));
 
 	host = ata_host_alloc_pinfo(&pdev->dev, ppi, n_ports);
-	if (!host)
-		return -ENOMEM;
+	if (!host) {
+		rc = -ENOMEM;
+		goto err_rm_sysfs_file;
+	}
 	host->private_data = hpriv;
 
 	if (ahci_init_msi(pdev, n_ports, hpriv) < 0) {
@@ -1947,11 +1949,11 @@ static int ahci_init_one(struct pci_dev
 	/* initialize adapter */
 	rc = ahci_configure_dma_masks(pdev, hpriv);
 	if (rc)
-		return rc;
+		goto err_rm_sysfs_file;
 
 	rc = ahci_pci_reset_controller(host);
 	if (rc)
-		return rc;
+		goto err_rm_sysfs_file;
 
 	ahci_pci_init_controller(host);
 	ahci_pci_print_info(host);
@@ -1960,10 +1962,15 @@ static int ahci_init_one(struct pci_dev
 
 	rc = ahci_host_activate(host, &ahci_sht);
 	if (rc)
-		return rc;
+		goto err_rm_sysfs_file;
 
 	pm_runtime_put_noidle(&pdev->dev);
 	return 0;
+
+err_rm_sysfs_file:
+	sysfs_remove_file_from_group(&pdev->dev.kobj,
+				     &dev_attr_remapped_nvme.attr, NULL);
+	return rc;
 }
 
 static void ahci_shutdown_one(struct pci_dev *pdev)



