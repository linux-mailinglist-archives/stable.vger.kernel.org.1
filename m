Return-Path: <stable+bounces-96839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0CD9E21F4
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB6C167580
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C271F757E;
	Tue,  3 Dec 2024 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XlgQSPFg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E1B1F4709;
	Tue,  3 Dec 2024 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238742; cv=none; b=nqhcaOPygTOsif6Jy8wFSMy0wp50NvT4WwJBBxwfLKWxfxFsRHR7/4f9AcRtm57uWV8SQGiTgJo7X6wm0E1mAO0ZNum1AlriTeYc717/76dQtOvGMPQfdh/tEvdKg9d+ntxTzH9ay/pIGBCIiXXcp8g9TBxuWA9xdl2cEEaQ7cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238742; c=relaxed/simple;
	bh=lf8fHrtY5Pu2LL3PL68qCq3OwiiUzkWTE7PsGHLNs78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c23lUziW1B4SZi/K6vNuMlBGo5CsvbsQ93LEm2kW8RbU0X4iZ2MTH3JnD6e6powu6aS6SiBUY6CaY3TA83dTFMzg1IX3TS/DLvxG+tJDd7FRX2nHl/FPIsdGS8QcCh8mDwilBlYn3K/rAWXOjaVY+LZ4+8v8LToiuH4qf9EETIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XlgQSPFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B063C4CECF;
	Tue,  3 Dec 2024 15:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733238742;
	bh=lf8fHrtY5Pu2LL3PL68qCq3OwiiUzkWTE7PsGHLNs78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XlgQSPFgdklyOc94UUVlGP11G4JqqkaIKcQp3rOzQBHGjMs0ZxZdZocBufrm/K0Rb
	 kARZ/8C+VumQfWh9dbcfg0cA1ewneYSCa1/XOj4+qxUFbHoTmHf1crM0AURp10URHA
	 U3ZqtBvttDzweMdRia49X6Kmi4Xc7Kix4/339WW0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 383/817] iommu/s390: Implement blocking domain
Date: Tue,  3 Dec 2024 15:39:15 +0100
Message-ID: <20241203144010.794776779@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Rosato <mjrosato@linux.ibm.com>

[ Upstream commit ecda483339a5151e3ca30d6b82691ef6f1d17912 ]

This fixes a crash when surprise hot-unplugging a PCI device. This crash
happens because during hot-unplug __iommu_group_set_domain_nofail()
attaching the default domain fails when the platform no longer
recognizes the device as it has already been removed and we end up with
a NULL domain pointer and UAF. This is exactly the case referred to in
the second comment in __iommu_device_set_domain() and just as stated
there if we can instead attach the blocking domain the UAF is prevented
as this can handle the already removed device. Implement the blocking
domain to use this handling.  With this change, the crash is fixed but
we still hit a warning attempting to change DMA ownership on a blocked
device.

Fixes: c76c067e488c ("s390/pci: Use dma-iommu layer")
Co-developed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20240910211516.137933-1-mjrosato@linux.ibm.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/pci.h |  4 +-
 arch/s390/pci/pci.c         |  3 ++
 arch/s390/pci/pci_debug.c   | 10 ++++-
 drivers/iommu/s390-iommu.c  | 73 +++++++++++++++++++++++--------------
 4 files changed, 59 insertions(+), 31 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 30820a649e6e7..a60a291fbd58d 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -96,7 +96,6 @@ struct zpci_bar_struct {
 	u8		size;		/* order 2 exponent */
 };
 
-struct s390_domain;
 struct kvm_zdev;
 
 #define ZPCI_FUNCTIONS_PER_BUS 256
@@ -181,9 +180,10 @@ struct zpci_dev {
 	struct dentry	*debugfs_dev;
 
 	/* IOMMU and passthrough */
-	struct s390_domain *s390_domain; /* s390 IOMMU domain data */
+	struct iommu_domain *s390_domain; /* attached IOMMU domain */
 	struct kvm_zdev *kzdev;
 	struct mutex kzdev_lock;
+	spinlock_t dom_lock;		/* protect s390_domain change */
 };
 
 static inline bool zdev_enabled(struct zpci_dev *zdev)
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index cff4838fad216..759983d0e63ed 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -160,6 +160,7 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
 	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
 	struct zpci_iommu_ctrs *ctrs;
 	struct zpci_fib fib = {0};
+	unsigned long flags;
 	u8 cc, status;
 
 	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
@@ -171,6 +172,7 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
 	WARN_ON((u64) zdev->fmb & 0xf);
 
 	/* reset software counters */
+	spin_lock_irqsave(&zdev->dom_lock, flags);
 	ctrs = zpci_get_iommu_ctrs(zdev);
 	if (ctrs) {
 		atomic64_set(&ctrs->mapped_pages, 0);
@@ -179,6 +181,7 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
 		atomic64_set(&ctrs->sync_map_rpcits, 0);
 		atomic64_set(&ctrs->sync_rpcits, 0);
 	}
+	spin_unlock_irqrestore(&zdev->dom_lock, flags);
 
 
 	fib.fmb_addr = virt_to_phys(zdev->fmb);
diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
index 2cb5043a997d5..38014206c16b9 100644
--- a/arch/s390/pci/pci_debug.c
+++ b/arch/s390/pci/pci_debug.c
@@ -71,17 +71,23 @@ static void pci_fmb_show(struct seq_file *m, char *name[], int length,
 
 static void pci_sw_counter_show(struct seq_file *m)
 {
-	struct zpci_iommu_ctrs  *ctrs = zpci_get_iommu_ctrs(m->private);
+	struct zpci_dev *zdev = m->private;
+	struct zpci_iommu_ctrs *ctrs;
 	atomic64_t *counter;
+	unsigned long flags;
 	int i;
 
+	spin_lock_irqsave(&zdev->dom_lock, flags);
+	ctrs = zpci_get_iommu_ctrs(m->private);
 	if (!ctrs)
-		return;
+		goto unlock;
 
 	counter = &ctrs->mapped_pages;
 	for (i = 0; i < ARRAY_SIZE(pci_sw_names); i++, counter++)
 		seq_printf(m, "%26s:\t%llu\n", pci_sw_names[i],
 			   atomic64_read(counter));
+unlock:
+	spin_unlock_irqrestore(&zdev->dom_lock, flags);
 }
 
 static int pci_perf_show(struct seq_file *m, void *v)
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index d8eaa7ea380bb..fbdeded3d48b5 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -33,6 +33,8 @@ struct s390_domain {
 	struct rcu_head		rcu;
 };
 
+static struct iommu_domain blocking_domain;
+
 static inline unsigned int calc_rtx(dma_addr_t ptr)
 {
 	return ((unsigned long)ptr >> ZPCI_RT_SHIFT) & ZPCI_INDEX_MASK;
@@ -369,20 +371,36 @@ static void s390_domain_free(struct iommu_domain *domain)
 	call_rcu(&s390_domain->rcu, s390_iommu_rcu_free_domain);
 }
 
-static void s390_iommu_detach_device(struct iommu_domain *domain,
-				     struct device *dev)
+static void zdev_s390_domain_update(struct zpci_dev *zdev,
+				    struct iommu_domain *domain)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&zdev->dom_lock, flags);
+	zdev->s390_domain = domain;
+	spin_unlock_irqrestore(&zdev->dom_lock, flags);
+}
+
+static int blocking_domain_attach_device(struct iommu_domain *domain,
+					 struct device *dev)
 {
-	struct s390_domain *s390_domain = to_s390_domain(domain);
 	struct zpci_dev *zdev = to_zpci_dev(dev);
+	struct s390_domain *s390_domain;
 	unsigned long flags;
 
+	if (zdev->s390_domain->type == IOMMU_DOMAIN_BLOCKED)
+		return 0;
+
+	s390_domain = to_s390_domain(zdev->s390_domain);
 	spin_lock_irqsave(&s390_domain->list_lock, flags);
 	list_del_rcu(&zdev->iommu_list);
 	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
 
 	zpci_unregister_ioat(zdev, 0);
-	zdev->s390_domain = NULL;
 	zdev->dma_table = NULL;
+	zdev_s390_domain_update(zdev, domain);
+
+	return 0;
 }
 
 static int s390_iommu_attach_device(struct iommu_domain *domain,
@@ -401,20 +419,15 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 		domain->geometry.aperture_end < zdev->start_dma))
 		return -EINVAL;
 
-	if (zdev->s390_domain)
-		s390_iommu_detach_device(&zdev->s390_domain->domain, dev);
+	blocking_domain_attach_device(&blocking_domain, dev);
 
+	/* If we fail now DMA remains blocked via blocking domain */
 	cc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
 				virt_to_phys(s390_domain->dma_table), &status);
-	/*
-	 * If the device is undergoing error recovery the reset code
-	 * will re-establish the new domain.
-	 */
 	if (cc && status != ZPCI_PCI_ST_FUNC_NOT_AVAIL)
 		return -EIO;
-
 	zdev->dma_table = s390_domain->dma_table;
-	zdev->s390_domain = s390_domain;
+	zdev_s390_domain_update(zdev, domain);
 
 	spin_lock_irqsave(&s390_domain->list_lock, flags);
 	list_add_rcu(&zdev->iommu_list, &s390_domain->devices);
@@ -466,19 +479,11 @@ static struct iommu_device *s390_iommu_probe_device(struct device *dev)
 	if (zdev->tlb_refresh)
 		dev->iommu->shadow_on_flush = 1;
 
-	return &zdev->iommu_dev;
-}
+	/* Start with DMA blocked */
+	spin_lock_init(&zdev->dom_lock);
+	zdev_s390_domain_update(zdev, &blocking_domain);
 
-static void s390_iommu_release_device(struct device *dev)
-{
-	struct zpci_dev *zdev = to_zpci_dev(dev);
-
-	/*
-	 * release_device is expected to detach any domain currently attached
-	 * to the device, but keep it attached to other devices in the group.
-	 */
-	if (zdev)
-		s390_iommu_detach_device(&zdev->s390_domain->domain, dev);
+	return &zdev->iommu_dev;
 }
 
 static int zpci_refresh_all(struct zpci_dev *zdev)
@@ -697,9 +702,15 @@ static size_t s390_iommu_unmap_pages(struct iommu_domain *domain,
 
 struct zpci_iommu_ctrs *zpci_get_iommu_ctrs(struct zpci_dev *zdev)
 {
-	if (!zdev || !zdev->s390_domain)
+	struct s390_domain *s390_domain;
+
+	lockdep_assert_held(&zdev->dom_lock);
+
+	if (zdev->s390_domain->type == IOMMU_DOMAIN_BLOCKED)
 		return NULL;
-	return &zdev->s390_domain->ctrs;
+
+	s390_domain = to_s390_domain(zdev->s390_domain);
+	return &s390_domain->ctrs;
 }
 
 int zpci_init_iommu(struct zpci_dev *zdev)
@@ -776,11 +787,19 @@ static int __init s390_iommu_init(void)
 }
 subsys_initcall(s390_iommu_init);
 
+static struct iommu_domain blocking_domain = {
+	.type = IOMMU_DOMAIN_BLOCKED,
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev	= blocking_domain_attach_device,
+	}
+};
+
 static const struct iommu_ops s390_iommu_ops = {
+	.blocked_domain		= &blocking_domain,
+	.release_domain		= &blocking_domain,
 	.capable = s390_iommu_capable,
 	.domain_alloc_paging = s390_domain_alloc_paging,
 	.probe_device = s390_iommu_probe_device,
-	.release_device = s390_iommu_release_device,
 	.device_group = generic_device_group,
 	.pgsize_bitmap = SZ_4K,
 	.get_resv_regions = s390_iommu_get_resv_regions,
-- 
2.43.0




