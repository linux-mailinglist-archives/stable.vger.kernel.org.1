Return-Path: <stable+bounces-81532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7575C994124
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 10:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9AA1F27A96
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 08:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2484213CA99;
	Tue,  8 Oct 2024 07:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aLkENXaI"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D14A23A0
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 07:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373668; cv=none; b=Z1QozR+TIm+AWKm06Jw28oPzyohOEzC5EYAVsBeW8V7RVNMKFcAYW3EUlAtdujKVd4+mpuMnbUvIhL1FjSZq7UsAydEduQd/cVgMzx18jrKIGE9Wtstkk/+cpQtAyD/T+6cvEPs6YzOr/fxRvQHToMYVttG0ck5XD9S2ppdLwpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373668; c=relaxed/simple;
	bh=tCv/7mhipd7WQOFWDu5wytCySq5oguUqWbVzOY5daOM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sPr2dqLHnpWZ7TT7U5fNleEG05MIGuahpIQ43hKMbthPWxds+2cXhUVbskc59oodY0lrf734riKe7XUTpaQ+PZnmn754NrXwGi4V8O5300TirgbfaSnaSEwDoh+kR9f3HUyaoAHbm0mxzgflUatARo71Y4A31XcvJ0PGbt06dKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aLkENXaI; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e045525719so3313811b6e.2
        for <stable@vger.kernel.org>; Tue, 08 Oct 2024 00:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728373665; x=1728978465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Es5a3SaOdE2aGjaLKoPJpJw7Ue4TmpSKGBflwGeF01U=;
        b=aLkENXaID4WyYDu1/Lj2gVfordfIsjcpbppkiE7u7msN+DWqVPc6rNz9ouoj5ANHFD
         U2nQjNZB0qkOuDJu2wom53s7kKhA4uNV5X/gC5jB5d6uup55HHifpIZUO2tMer1bzfSb
         RNhmiVmCdG9Yxl/7Q8jiKw3dKJbnm1JkcYsxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728373665; x=1728978465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Es5a3SaOdE2aGjaLKoPJpJw7Ue4TmpSKGBflwGeF01U=;
        b=SECxVAagLF6gsjNR2y9HZpXB6S3Q09DbJ2sMDY2+bSifZ6y1feMitqCwTvh/sMqg22
         yiepzjUGIWM0THA112MS4y9Gq0yNDU13thy6o63gvUOM1gl2ww4oQG/1RK/zkTpEFIpV
         fk8lSKY4yEf+Vi0pkEVYRMqiJxn+hOkEMRLYKr4/o+9eLT7Tc4AqWP9dw7ui+Whs6T/e
         QfIbwFL95b2ECc3H+ZukfASlPLxs1eoJtPjQ0n7LOjsKxEOiC7LkH6coPwycWqg+ruj+
         AgJKqewocDvPVHj6p+DAdAXGp4V5ILNfJOyh9wZosy0csJj3zLDhBNXg+mmiCLWj/h2W
         DncQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlpyFA0Y5ndxPOn8SmBpcSK2NhvrNt8wKbLpXzTAH6pce1KajfmCj/qjTQ2kosq4VX67BsPQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHJ7ZTM2br7i+T2InWv9PybeyKTkYYieJ4fIImsadtpVS/K7oF
	j/BIlHa4O6/+051J8jQw6CcpJAHn7B4ftDkNKxi7wFXnDKlwFmBrxrQI9R2oPA==
X-Google-Smtp-Source: AGHT+IHcU90bO2mwisFuDqHClHaBqkqjJ5WQ3QaW2yhyT6648XzcBDWFAijqjwcFcv9VNXNf+TZGeg==
X-Received: by 2002:a05:6808:23c9:b0:3e0:6809:ab18 with SMTP id 5614622812f47-3e3c1326016mr10038627b6e.13.1728373665150;
        Tue, 08 Oct 2024 00:47:45 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d452b7sm5596039b3a.108.2024.10.08.00.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 00:47:44 -0700 (PDT)
From: Ranjan Kumar <ranjan.kumar@broadcom.com>
To: linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com
Cc: rajsekhar.chundru@broadcom.com,
	sathya.prakash@broadcom.com,
	sumit.saxena@broadcom.com,
	chandrakanth.patil@broadcom.com,
	prayas.patel@broadcom.com,
	thenzl@redhat.com,
	mav@ixsystems.com,
	Ranjan Kumar <ranjan.kumar@broadcom.com>,
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] mpi3mr: Validating SAS port assignments
Date: Tue,  8 Oct 2024 13:13:53 +0530
Message-Id: <20241008074353.200379-1-ranjan.kumar@broadcom.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sanity on phy_mask was added by Tomas through [1].
It causes warning messages when >64 phys are
detected (expander can have >64 phys) and devices
connected to phys greater than 64 are dropped.
phy_mask bitmap is only needed for controller
phys(not required for expander phys).Controller phys
can go maximum up to 64 and u64 is good enough to contain phy_mask bitmap.

To suppress those warnings and allow devices to be discovered as
before the [1], restrict the phy_mask setting and lowest phy
setting only to the controller phys.

[1]:https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/
drivers/scsi/mpi3mr?h=6.12/
scsi-queue&id=3668651def2c1622904e58b0280ee93121f2b10b

Fixes: 3668651def2c ("mpi3mr: Sanitise num_phys")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410051943.Mp9o5DlF-lkp@intel.com/
Reported-by: Alexander Motin <mav@ixsystems.com>
Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
---
 drivers/scsi/mpi3mr/mpi3mr.h           |  4 +--
 drivers/scsi/mpi3mr/mpi3mr_transport.c | 42 +++++++++++++++++---------
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index dc2cdd5f0311..3822efe349e1 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -541,8 +541,8 @@ struct mpi3mr_hba_port {
  * @port_list: List of ports belonging to a SAS node
  * @num_phys: Number of phys associated with port
  * @marked_responding: used while refresing the sas ports
- * @lowest_phy: lowest phy ID of current sas port
- * @phy_mask: phy_mask of current sas port
+ * @lowest_phy: lowest phy ID of current sas port, valid for controller port
+ * @phy_mask: phy_mask of current sas port, valid for controller port
  * @hba_port: HBA port entry
  * @remote_identify: Attached device identification
  * @rphy: SAS transport layer rphy object
diff --git a/drivers/scsi/mpi3mr/mpi3mr_transport.c b/drivers/scsi/mpi3mr/mpi3mr_transport.c
index ccd23def2e0c..0ba9e6a6a13c 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_transport.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_transport.c
@@ -590,12 +590,13 @@ static enum sas_linkrate mpi3mr_convert_phy_link_rate(u8 link_rate)
  * @mrioc: Adapter instance reference
  * @mr_sas_port: Internal Port object
  * @mr_sas_phy: Internal Phy object
+ * @host_node: Flag to indicate this is a host_node
  *
  * Return: None.
  */
 static void mpi3mr_delete_sas_phy(struct mpi3mr_ioc *mrioc,
 	struct mpi3mr_sas_port *mr_sas_port,
-	struct mpi3mr_sas_phy *mr_sas_phy)
+	struct mpi3mr_sas_phy *mr_sas_phy, u8 host_node)
 {
 	u64 sas_address = mr_sas_port->remote_identify.sas_address;
 
@@ -605,9 +606,13 @@ static void mpi3mr_delete_sas_phy(struct mpi3mr_ioc *mrioc,
 
 	list_del(&mr_sas_phy->port_siblings);
 	mr_sas_port->num_phys--;
-	mr_sas_port->phy_mask &= ~(1 << mr_sas_phy->phy_id);
-	if (mr_sas_port->lowest_phy == mr_sas_phy->phy_id)
-		mr_sas_port->lowest_phy = ffs(mr_sas_port->phy_mask) - 1;
+
+	if (host_node) {
+		mr_sas_port->phy_mask &= ~(1 << mr_sas_phy->phy_id);
+
+		if (mr_sas_port->lowest_phy == mr_sas_phy->phy_id)
+			mr_sas_port->lowest_phy = ffs(mr_sas_port->phy_mask) - 1;
+	}
 	sas_port_delete_phy(mr_sas_port->port, mr_sas_phy->phy);
 	mr_sas_phy->phy_belongs_to_port = 0;
 }
@@ -617,12 +622,13 @@ static void mpi3mr_delete_sas_phy(struct mpi3mr_ioc *mrioc,
  * @mrioc: Adapter instance reference
  * @mr_sas_port: Internal Port object
  * @mr_sas_phy: Internal Phy object
+ * @host_node: Flag to indicate this is a host_node
  *
  * Return: None.
  */
 static void mpi3mr_add_sas_phy(struct mpi3mr_ioc *mrioc,
 	struct mpi3mr_sas_port *mr_sas_port,
-	struct mpi3mr_sas_phy *mr_sas_phy)
+	struct mpi3mr_sas_phy *mr_sas_phy, u8 host_node)
 {
 	u64 sas_address = mr_sas_port->remote_identify.sas_address;
 
@@ -632,9 +638,12 @@ static void mpi3mr_add_sas_phy(struct mpi3mr_ioc *mrioc,
 
 	list_add_tail(&mr_sas_phy->port_siblings, &mr_sas_port->phy_list);
 	mr_sas_port->num_phys++;
-	mr_sas_port->phy_mask |= (1 << mr_sas_phy->phy_id);
-	if (mr_sas_phy->phy_id < mr_sas_port->lowest_phy)
-		mr_sas_port->lowest_phy = ffs(mr_sas_port->phy_mask) - 1;
+	if (host_node) {
+		mr_sas_port->phy_mask |= (1 << mr_sas_phy->phy_id);
+
+		if (mr_sas_phy->phy_id < mr_sas_port->lowest_phy)
+			mr_sas_port->lowest_phy = ffs(mr_sas_port->phy_mask) - 1;
+	}
 	sas_port_add_phy(mr_sas_port->port, mr_sas_phy->phy);
 	mr_sas_phy->phy_belongs_to_port = 1;
 }
@@ -675,7 +684,7 @@ static void mpi3mr_add_phy_to_an_existing_port(struct mpi3mr_ioc *mrioc,
 			if (srch_phy == mr_sas_phy)
 				return;
 		}
-		mpi3mr_add_sas_phy(mrioc, mr_sas_port, mr_sas_phy);
+		mpi3mr_add_sas_phy(mrioc, mr_sas_port, mr_sas_phy, mr_sas_node->host_node);
 		return;
 	}
 }
@@ -736,7 +745,7 @@ static void mpi3mr_del_phy_from_an_existing_port(struct mpi3mr_ioc *mrioc,
 				mpi3mr_delete_sas_port(mrioc, mr_sas_port);
 			else
 				mpi3mr_delete_sas_phy(mrioc, mr_sas_port,
-				    mr_sas_phy);
+				    mr_sas_phy, mr_sas_node->host_node);
 			return;
 		}
 	}
@@ -1028,7 +1037,7 @@ mpi3mr_alloc_hba_port(struct mpi3mr_ioc *mrioc, u16 port_id)
 /**
  * mpi3mr_get_hba_port_by_id - find hba port by id
  * @mrioc: Adapter instance reference
- * @port_id - Port ID to search
+ * @port_id: Port ID to search
  *
  * Return: mpi3mr_hba_port reference for the matched port
  */
@@ -1367,7 +1376,8 @@ static struct mpi3mr_sas_port *mpi3mr_sas_port_add(struct mpi3mr_ioc *mrioc,
 	mpi3mr_sas_port_sanity_check(mrioc, mr_sas_node,
 	    mr_sas_port->remote_identify.sas_address, hba_port);
 
-	if (mr_sas_node->num_phys >= sizeof(mr_sas_port->phy_mask) * 8)
+	if (mr_sas_node->host_node && mr_sas_node->num_phys >=
+			sizeof(mr_sas_port->phy_mask) * 8)
 		ioc_info(mrioc, "max port count %u could be too high\n",
 		    mr_sas_node->num_phys);
 
@@ -1377,7 +1387,7 @@ static struct mpi3mr_sas_port *mpi3mr_sas_port_add(struct mpi3mr_ioc *mrioc,
 		    (mr_sas_node->phy[i].hba_port != hba_port))
 			continue;
 
-		if (i >= sizeof(mr_sas_port->phy_mask) * 8) {
+		if (mr_sas_node->host_node && (i >= sizeof(mr_sas_port->phy_mask) * 8)) {
 			ioc_warn(mrioc, "skipping port %u, max allowed value is %zu\n",
 			    i, sizeof(mr_sas_port->phy_mask) * 8);
 			goto out_fail;
@@ -1385,7 +1395,8 @@ static struct mpi3mr_sas_port *mpi3mr_sas_port_add(struct mpi3mr_ioc *mrioc,
 		list_add_tail(&mr_sas_node->phy[i].port_siblings,
 		    &mr_sas_port->phy_list);
 		mr_sas_port->num_phys++;
-		mr_sas_port->phy_mask |= (1 << i);
+		if (mr_sas_node->host_node)
+			mr_sas_port->phy_mask |= (1 << i);
 	}
 
 	if (!mr_sas_port->num_phys) {
@@ -1394,7 +1405,8 @@ static struct mpi3mr_sas_port *mpi3mr_sas_port_add(struct mpi3mr_ioc *mrioc,
 		goto out_fail;
 	}
 
-	mr_sas_port->lowest_phy = ffs(mr_sas_port->phy_mask) - 1;
+	if (mr_sas_node->host_node)
+		mr_sas_port->lowest_phy = ffs(mr_sas_port->phy_mask) - 1;
 
 	if (mr_sas_port->remote_identify.device_type == SAS_END_DEVICE) {
 		tgtdev = mpi3mr_get_tgtdev_by_addr(mrioc,
-- 
2.31.1


