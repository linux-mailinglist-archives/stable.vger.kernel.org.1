Return-Path: <stable+bounces-101137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F049EEAE1
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AAB8188A8F3
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF3621764F;
	Thu, 12 Dec 2024 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iYTKiJHR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566E62165F0;
	Thu, 12 Dec 2024 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016487; cv=none; b=FUhGBV1WvAf2gHQ3U7FfKxnYDs/ZOqVvXfr1iuBgf5CkpgdyeCKUIEAEZAvbup21HSvSSpRouz83VUca4qoTqm91qSRcItgsEqz6AcoL6+h2wlT/EH4lkUIEcgbDHEdkbxuF72OtR+ukBHPNuXWD2zFFQKrywy/tvsTpe+78yds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016487; c=relaxed/simple;
	bh=qf0YsCJjncRWm6POVkpbfGAVEdkAsfLRIk5yNinUc7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mlmBTLfLnm4Ucq3lhWKRVcZiKVQ42lIjcLfXvrqnUOcwKKbT++ud4yjd29GyjdRCwerSviYTkLvl8Dz1amsQPWXiP+hOgrAq5ESIday9ZnjHRPu4hgz4MArMDjxziOA9Tx4LYZFKhSCbpPZsvA/5oK80vKXr5mHJlY4UyyS7XcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iYTKiJHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FB6C4CED7;
	Thu, 12 Dec 2024 15:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734016487;
	bh=qf0YsCJjncRWm6POVkpbfGAVEdkAsfLRIk5yNinUc7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iYTKiJHR8WfDLErGe+DZE7qolhYGzEdw5Yse5PIq42JWBLlJj6eVf9Ici+FZpB5Bz
	 cCys+Itqf/Chcm2rQbXQZF2MMC5bXb5rihbFNo78+asR8etWdub8S5wChidCLhrhK/
	 geClmoKKvzRWcnO0D3sB3tMawRb6PqR583mSHDNw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 212/466] s390/pci: Sort PCI functions prior to creating virtual busses
Date: Thu, 12 Dec 2024 15:56:21 +0100
Message-ID: <20241212144315.164355186@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144306.641051666@linuxfoundation.org>
References: <20241212144306.641051666@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Schnelle <schnelle@linux.ibm.com>

[ Upstream commit 0467cdde8c4320bbfdb31a8cff1277b202f677fc ]

Instead of relying on the observed but not architected firmware behavior
that PCI functions from the same card are listed in ascending RID order
in clp_list_pci() ensure this by sorting. To allow for sorting separate
the initial clp_list_pci() and creation of the virtual PCI busses.

Note that fundamentally in our per-PCI function hotplug design non RID
order of discovery is still possible. For example when the two PFs of
a two port NIC are hotplugged after initial boot and in descending RID
order. In this case the virtual PCI bus would be created by the second
PF using that PF's UID as domain number instead of that of the first PF.
Thus the domain number would then change from the UID of the second PF
to that of the first PF on reboot but there is really nothing we can do
about that since changing domain numbers at runtime seems even worse.
This only impacts the domain number as the RIDs are consistent and thus
even with just the second PF visible it will show up in the correct
position on the virtual bus.

Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/pci.h |  5 ++-
 arch/s390/pci/pci.c         | 69 ++++++++++++++++++++++++++++++++-----
 arch/s390/pci/pci_clp.c     | 12 ++++---
 arch/s390/pci/pci_event.c   | 13 ++++---
 4 files changed, 82 insertions(+), 17 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 30b20ce9a7003..b10801fa73569 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -129,6 +129,7 @@ struct zpci_dev {
 	u16		vfn;		/* virtual function number */
 	u16		pchid;		/* physical channel ID */
 	u16		maxstbl;	/* Maximum store block size */
+	u16		rid;		/* RID as supplied by firmware */
 	u8		pfgid;		/* function group ID */
 	u8		pft;		/* pci function type */
 	u8		port;
@@ -210,12 +211,14 @@ extern struct airq_iv *zpci_aif_sbv;
 ----------------------------------------------------------------------------- */
 /* Base stuff */
 struct zpci_dev *zpci_create_device(u32 fid, u32 fh, enum zpci_state state);
+int zpci_add_device(struct zpci_dev *zdev);
 int zpci_enable_device(struct zpci_dev *);
 int zpci_disable_device(struct zpci_dev *);
 int zpci_scan_configured_device(struct zpci_dev *zdev, u32 fh);
 int zpci_deconfigure_device(struct zpci_dev *zdev);
 void zpci_device_reserved(struct zpci_dev *zdev);
 bool zpci_is_device_configured(struct zpci_dev *zdev);
+int zpci_scan_devices(void);
 
 int zpci_hot_reset_device(struct zpci_dev *zdev);
 int zpci_register_ioat(struct zpci_dev *, u8, u64, u64, u64, u8 *);
@@ -225,7 +228,7 @@ void zpci_update_fh(struct zpci_dev *zdev, u32 fh);
 
 /* CLP */
 int clp_setup_writeback_mio(void);
-int clp_scan_pci_devices(void);
+int clp_scan_pci_devices(struct list_head *scan_list);
 int clp_query_pci_fn(struct zpci_dev *zdev);
 int clp_enable_fh(struct zpci_dev *zdev, u32 *fh, u8 nr_dma_as);
 int clp_disable_fh(struct zpci_dev *zdev, u32 *fh);
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 635fd8f2acbaa..2a5299888ca86 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -29,6 +29,7 @@
 #include <linux/pci.h>
 #include <linux/printk.h>
 #include <linux/lockdep.h>
+#include <linux/list_sort.h>
 
 #include <asm/isc.h>
 #include <asm/airq.h>
@@ -788,7 +789,6 @@ struct zpci_dev *zpci_create_device(u32 fid, u32 fh, enum zpci_state state)
 	struct zpci_dev *zdev;
 	int rc;
 
-	zpci_dbg(1, "add fid:%x, fh:%x, c:%d\n", fid, fh, state);
 	zdev = kzalloc(sizeof(*zdev), GFP_KERNEL);
 	if (!zdev)
 		return ERR_PTR(-ENOMEM);
@@ -808,6 +808,19 @@ struct zpci_dev *zpci_create_device(u32 fid, u32 fh, enum zpci_state state)
 	mutex_init(&zdev->fmb_lock);
 	mutex_init(&zdev->kzdev_lock);
 
+	return zdev;
+
+error:
+	zpci_dbg(0, "crt fid:%x, rc:%d\n", fid, rc);
+	kfree(zdev);
+	return ERR_PTR(rc);
+}
+
+int zpci_add_device(struct zpci_dev *zdev)
+{
+	int rc;
+
+	zpci_dbg(1, "add fid:%x, fh:%x, c:%d\n", zdev->fid, zdev->fh, zdev->state);
 	rc = zpci_init_iommu(zdev);
 	if (rc)
 		goto error;
@@ -819,15 +832,13 @@ struct zpci_dev *zpci_create_device(u32 fid, u32 fh, enum zpci_state state)
 	spin_lock(&zpci_list_lock);
 	list_add_tail(&zdev->entry, &zpci_list);
 	spin_unlock(&zpci_list_lock);
-
-	return zdev;
+	return 0;
 
 error_destroy_iommu:
 	zpci_destroy_iommu(zdev);
 error:
-	zpci_dbg(0, "add fid:%x, rc:%d\n", fid, rc);
-	kfree(zdev);
-	return ERR_PTR(rc);
+	zpci_dbg(0, "add fid:%x, rc:%d\n", zdev->fid, rc);
+	return rc;
 }
 
 bool zpci_is_device_configured(struct zpci_dev *zdev)
@@ -1069,6 +1080,49 @@ bool zpci_is_enabled(void)
 	return s390_pci_initialized;
 }
 
+static int zpci_cmp_rid(void *priv, const struct list_head *a,
+			const struct list_head *b)
+{
+	struct zpci_dev *za = container_of(a, struct zpci_dev, entry);
+	struct zpci_dev *zb = container_of(b, struct zpci_dev, entry);
+
+	/*
+	 * PCI functions without RID available maintain original order
+	 * between themselves but sort before those with RID.
+	 */
+	if (za->rid == zb->rid)
+		return za->rid_available > zb->rid_available;
+	/*
+	 * PCI functions with RID sort by RID ascending.
+	 */
+	return za->rid > zb->rid;
+}
+
+static void zpci_add_devices(struct list_head *scan_list)
+{
+	struct zpci_dev *zdev, *tmp;
+
+	list_sort(NULL, scan_list, &zpci_cmp_rid);
+	list_for_each_entry_safe(zdev, tmp, scan_list, entry) {
+		list_del_init(&zdev->entry);
+		zpci_add_device(zdev);
+	}
+}
+
+int zpci_scan_devices(void)
+{
+	LIST_HEAD(scan_list);
+	int rc;
+
+	rc = clp_scan_pci_devices(&scan_list);
+	if (rc)
+		return rc;
+
+	zpci_add_devices(&scan_list);
+	zpci_bus_scan_busses();
+	return 0;
+}
+
 static int __init pci_base_init(void)
 {
 	int rc;
@@ -1098,10 +1152,9 @@ static int __init pci_base_init(void)
 	if (rc)
 		goto out_irq;
 
-	rc = clp_scan_pci_devices();
+	rc = zpci_scan_devices();
 	if (rc)
 		goto out_find;
-	zpci_bus_scan_busses();
 
 	s390_pci_initialized = 1;
 	return 0;
diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index 6f55a59a08711..f7430086e9739 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -164,8 +164,10 @@ static int clp_store_query_pci_fn(struct zpci_dev *zdev,
 	zdev->port = response->port;
 	zdev->uid = response->uid;
 	zdev->fmb_length = sizeof(u32) * response->fmb_len;
-	zdev->rid_available = response->rid_avail;
 	zdev->is_physfn = response->is_physfn;
+	zdev->rid_available = response->rid_avail;
+	if (zdev->rid_available)
+		zdev->rid = response->rid;
 	if (!s390_pci_no_rid && zdev->rid_available)
 		zdev->devfn = response->rid & ZPCI_RID_MASK_DEVFN;
 
@@ -407,6 +409,7 @@ static int clp_find_pci(struct clp_req_rsp_list_pci *rrb, u32 fid,
 
 static void __clp_add(struct clp_fh_list_entry *entry, void *data)
 {
+	struct list_head *scan_list = data;
 	struct zpci_dev *zdev;
 
 	if (!entry->vendor_id)
@@ -417,10 +420,11 @@ static void __clp_add(struct clp_fh_list_entry *entry, void *data)
 		zpci_zdev_put(zdev);
 		return;
 	}
-	zpci_create_device(entry->fid, entry->fh, entry->config_state);
+	zdev = zpci_create_device(entry->fid, entry->fh, entry->config_state);
+	list_add_tail(&zdev->entry, scan_list);
 }
 
-int clp_scan_pci_devices(void)
+int clp_scan_pci_devices(struct list_head *scan_list)
 {
 	struct clp_req_rsp_list_pci *rrb;
 	int rc;
@@ -429,7 +433,7 @@ int clp_scan_pci_devices(void)
 	if (!rrb)
 		return -ENOMEM;
 
-	rc = clp_list_pci(rrb, NULL, __clp_add);
+	rc = clp_list_pci(rrb, scan_list, __clp_add);
 
 	clp_free_block(rrb);
 	return rc;
diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index d4f19d33914cb..47f934f4e828e 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -340,6 +340,7 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 			zdev = zpci_create_device(ccdf->fid, ccdf->fh, ZPCI_FN_STATE_CONFIGURED);
 			if (IS_ERR(zdev))
 				break;
+			zpci_add_device(zdev);
 		} else {
 			/* the configuration request may be stale */
 			if (zdev->state != ZPCI_FN_STATE_STANDBY)
@@ -349,10 +350,14 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 		zpci_scan_configured_device(zdev, ccdf->fh);
 		break;
 	case 0x0302: /* Reserved -> Standby */
-		if (!zdev)
-			zpci_create_device(ccdf->fid, ccdf->fh, ZPCI_FN_STATE_STANDBY);
-		else
+		if (!zdev) {
+			zdev = zpci_create_device(ccdf->fid, ccdf->fh, ZPCI_FN_STATE_STANDBY);
+			if (IS_ERR(zdev))
+				break;
+			zpci_add_device(zdev);
+		} else {
 			zpci_update_fh(zdev, ccdf->fh);
+		}
 		break;
 	case 0x0303: /* Deconfiguration requested */
 		if (zdev) {
@@ -381,7 +386,7 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 		break;
 	case 0x0306: /* 0x308 or 0x302 for multiple devices */
 		zpci_remove_reserved_devices();
-		clp_scan_pci_devices();
+		zpci_scan_devices();
 		break;
 	case 0x0308: /* Standby -> Reserved */
 		if (!zdev)
-- 
2.43.0




