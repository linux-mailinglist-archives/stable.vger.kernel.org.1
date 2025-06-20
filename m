Return-Path: <stable+bounces-155012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0D5AE16C1
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC9F189BE38
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 08:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA17255F4C;
	Fri, 20 Jun 2025 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="upucIq/P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C246F252904
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 08:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750409634; cv=none; b=ReVBRnRDJRsypGqeBxz3pfBomoALDk++LSxmaf7hEjYKXRc0oA8xoNfCs7dCswaSj8oA7pcrtXoiMYbdbpdEtA5vtKjvqvBeTZAgHADjGfOnKKgHBuUStyAXeJYsIR6WF9YZtpIxeo7hKDLMTwaY18cuewwaAG7WTnGDLG7PeJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750409634; c=relaxed/simple;
	bh=C1VxireHCCBWtanooCDlyCM7Wfq3ggDdbZaHVtuE1E4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AYJ1eNHxABwl83l+jBF1tT0xPjdlmPuaV43xxMQ8hQTa9GW8rDPFTj8O11bnWzu2ppOtFk7S+n443A8zaCU6fQilLb86EgVFrh8T+A57LCoKKFx/C6vI33ir+dSH2OhbzD8bjiI7nIkCnZz15evNT6nQJK6EbogG92D+UBerDcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=upucIq/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D306C4CEE3;
	Fri, 20 Jun 2025 08:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750409634;
	bh=C1VxireHCCBWtanooCDlyCM7Wfq3ggDdbZaHVtuE1E4=;
	h=Subject:To:Cc:From:Date:From;
	b=upucIq/P0JjXK+mp83CVvinmVzg2uyswt+hiMVaEZ1nVtmHVfiSzVIJnXHIyEiAen
	 w22J5ZMT+zhAm0L1J3j89jdRABV1KLkaVqx5NG5h697zJ+l01Fsq/jmn37I5A8BL6W
	 4PhRKqzerejFQdpar1mixEF69SDZuef+Itnago+o=
Subject: FAILED: patch "[PATCH] iommu: Allow attaching static domains in" failed to apply to 6.12-stable tree
To: baolu.lu@linux.intel.com,dave.jiang@intel.com,jgg@nvidia.com,jroedel@suse.de,kevin.tian@intel.com,robin.murphy@arm.com,vasant.hegde@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 10:53:51 +0200
Message-ID: <2025062051-rage-declared-354d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6f7340120a0aa8b2eb29c826a4434e8b5c4e11d3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062051-rage-declared-354d@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6f7340120a0aa8b2eb29c826a4434e8b5c4e11d3 Mon Sep 17 00:00:00 2001
From: Lu Baolu <baolu.lu@linux.intel.com>
Date: Thu, 24 Apr 2025 11:41:23 +0800
Subject: [PATCH] iommu: Allow attaching static domains in
 iommu_attach_device_pasid()

The idxd driver attaches the default domain to a PASID of the device to
perform kernel DMA using that PASID. The domain is attached to the
device's PASID through iommu_attach_device_pasid(), which checks if the
domain->owner matches the iommu_ops retrieved from the device. If they
do not match, it returns a failure.

        if (ops != domain->owner || pasid == IOMMU_NO_PASID)
                return -EINVAL;

The static identity domain implemented by the intel iommu driver doesn't
specify the domain owner. Therefore, kernel DMA with PASID doesn't work
for the idxd driver if the device translation mode is set to passthrough.

Generally the owner field of static domains are not set because they are
already part of iommu ops. Add a helper domain_iommu_ops_compatible()
that checks if a domain is compatible with the device's iommu ops. This
helper explicitly allows the static blocked and identity domains associated
with the device's iommu_ops to be considered compatible.

Fixes: 2031c469f816 ("iommu/vt-d: Add support for static identity domain")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220031
Cc: stable@vger.kernel.org
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/linux-iommu/20250422191554.GC1213339@ziepe.ca/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20250424034123.2311362-1-baolu.lu@linux.intel.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3e4a9fe867f5..f257ca30ed48 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2206,6 +2206,19 @@ static void *iommu_make_pasid_array_entry(struct iommu_domain *domain,
 	return xa_tag_pointer(domain, IOMMU_PASID_ARRAY_DOMAIN);
 }
 
+static bool domain_iommu_ops_compatible(const struct iommu_ops *ops,
+					struct iommu_domain *domain)
+{
+	if (domain->owner == ops)
+		return true;
+
+	/* For static domains, owner isn't set. */
+	if (domain == ops->blocked_domain || domain == ops->identity_domain)
+		return true;
+
+	return false;
+}
+
 static int __iommu_attach_group(struct iommu_domain *domain,
 				struct iommu_group *group)
 {
@@ -2216,7 +2229,8 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 		return -EBUSY;
 
 	dev = iommu_group_first_dev(group);
-	if (!dev_has_iommu(dev) || dev_iommu_ops(dev) != domain->owner)
+	if (!dev_has_iommu(dev) ||
+	    !domain_iommu_ops_compatible(dev_iommu_ops(dev), domain))
 		return -EINVAL;
 
 	return __iommu_group_set_domain(group, domain);
@@ -3405,7 +3419,8 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	    !ops->blocked_domain->ops->set_dev_pasid)
 		return -EOPNOTSUPP;
 
-	if (ops != domain->owner || pasid == IOMMU_NO_PASID)
+	if (!domain_iommu_ops_compatible(ops, domain) ||
+	    pasid == IOMMU_NO_PASID)
 		return -EINVAL;
 
 	mutex_lock(&group->mutex);
@@ -3481,7 +3496,7 @@ int iommu_replace_device_pasid(struct iommu_domain *domain,
 	if (!domain->ops->set_dev_pasid)
 		return -EOPNOTSUPP;
 
-	if (dev_iommu_ops(dev) != domain->owner ||
+	if (!domain_iommu_ops_compatible(dev_iommu_ops(dev), domain) ||
 	    pasid == IOMMU_NO_PASID || !handle)
 		return -EINVAL;
 


