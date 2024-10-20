Return-Path: <stable+bounces-86956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B213B9A5350
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 11:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29EC1C20BF2
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 09:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8F63A27E;
	Sun, 20 Oct 2024 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hehwqfZf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262E628F4
	for <stable@vger.kernel.org>; Sun, 20 Oct 2024 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729416691; cv=none; b=JR6IuEwofU6kBslEX+67w1v5lq+2iy9Dh5nJ0OR4f+QemutEpDVX+phYUIMTEONh5YNROpYU2dACzkcAJn5CUfGTXX4FRyBNuxvH3jfz3iDANAee29OPYmuQTlVWV5Tjba8oxH4DEbInHgb1bs2JOt57GF19LVGxQjrgaDUM3Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729416691; c=relaxed/simple;
	bh=SS2VMdhbaMJmerJ7Yp3E7l22YF4xY80WQ69B4piBbXk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YVA9zQ7g9+38JElOGK0MkD/P8+ghg3zLfA/tH7tWiARhvz16cFudHvIAwON5KUFWDWIugIOg4sZELfCUG/TQIBgaQDbwlaXfIbYzgetabX/NpBBWD5fBPmIhUoU8caj/mKuNpuoj/gnhWJqAIPIZl62v+rmin0HBbqTQZjSSG4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hehwqfZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA77C4CEC6;
	Sun, 20 Oct 2024 09:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729416691;
	bh=SS2VMdhbaMJmerJ7Yp3E7l22YF4xY80WQ69B4piBbXk=;
	h=Subject:To:Cc:From:Date:From;
	b=hehwqfZf7LeLf22N0tHtbTlbfmpPBwN7RcCb5etSg+5nsIYPwJw6fWPmgD5B+fXGo
	 hRoLKarSF9Gt/pZmLlmOV0zMyY4naoQ4iRfx+vUogx1yYHnb8dp0c0bZ9GQsZG/StB
	 YJt17FdUOqPRngOy1G5pWIuFA1lALYqGKj/EhKNo=
Subject: FAILED: patch "[PATCH] scsi: mpi3mr: Validate SAS port assignments" failed to apply to 6.6-stable tree
To: ranjan.kumar@broadcom.com,lkp@intel.com,martin.petersen@oracle.com,mav@ixsystems.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 20 Oct 2024 11:31:27 +0200
Message-ID: <2024102027-late-goggles-8ae6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x b9e63d6c7c0e94a99e1af7c9c0c7fad13a2f2453
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024102027-late-goggles-8ae6@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b9e63d6c7c0e94a99e1af7c9c0c7fad13a2f2453 Mon Sep 17 00:00:00 2001
From: Ranjan Kumar <ranjan.kumar@broadcom.com>
Date: Tue, 8 Oct 2024 13:13:53 +0530
Subject: [PATCH] scsi: mpi3mr: Validate SAS port assignments

A sanity check on phy_mask was added in commit 3668651def2c ("scsi:
mpi3mr: Sanitise num_phys"). This causes warning messages when more than
64 phys are detected and devices connected to phys greater than 64 are
dropped.

The phy_mask bitmap is only needed for controller phys and not required
for expander phys. Controller phys can go up to a maximum of 64 and
therefore u64 is good enough to contain phy_mask bitmap.

To suppress those warnings and allow devices to be discovered as before
the offending commit, restrict the phy_mask setting and lowest phy
setting only to the controller phys.

Fixes: 3668651def2c ("scsi: mpi3mr: Sanitise num_phys")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410051943.Mp9o5DlF-lkp@intel.com/
Reported-by: Alexander Motin <mav@ixsystems.com>
Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
Link: https://lore.kernel.org/r/20241008074353.200379-1-ranjan.kumar@broadcom.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index fcb0fa31536b..16e0baeb8799 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -542,8 +542,8 @@ struct mpi3mr_hba_port {
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


