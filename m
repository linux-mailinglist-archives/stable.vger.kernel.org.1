Return-Path: <stable+bounces-146283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99830AC3072
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 18:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D54E3BFA39
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 16:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8411EDA35;
	Sat, 24 May 2025 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fBg+tzQd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3358C11
	for <stable@vger.kernel.org>; Sat, 24 May 2025 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748103608; cv=none; b=lliU6E9sdAPXCjVz31DO3sf/qmGOOluQQq2at1ZlnR4oVvhlWt4StFzMooBXnlNDV4/Jg1G1F5agb0z1wcVpNhDu+tmHZQK6VnSK314cU7jsVUadHzXVFhb+mnMrVzY9IrNe3DbDPj+A6uXVBtwt6Igcopd30sIH0iyRTeVHQ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748103608; c=relaxed/simple;
	bh=k3wx97sPd4S2Uiq9waM0fJDqc6qknCaABXDqNe2eVgc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=u+m/Pq6xhFjM8v2YnVYXjdfXYtL5D3UnmT1BSdL2yo4mVlACEMgb6Z5XCWM6i000uaRcvOg0J4VHihZwdYj2gnELKSkphWIxGBLRwcSYHHDrekwGTbstDC009dROnWZaQ9Uavgrp+6bRQg7TbJt938IvjEHWxsC7CkdPiSRFac0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fBg+tzQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E59C4CEE4;
	Sat, 24 May 2025 16:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748103607;
	bh=k3wx97sPd4S2Uiq9waM0fJDqc6qknCaABXDqNe2eVgc=;
	h=Subject:To:Cc:From:Date:From;
	b=fBg+tzQd31GC2vUK4W31cnVFUgqN3rFNqf5AFOyNAQgXWcz/dWRLaiC8Lif1/VEzt
	 IZA7rC+xZ9Z1QcokqXKqTnKluyZjts/Ow2oB679ZaQTU+SpJEQxX1dcsUSmrxd6yt6
	 5HSMX+1x0+GSe2o4SpNGULBIjU5rhSEPc6H8zxJE=
Subject: FAILED: patch "[PATCH] iommu: Skip PASID validation for devices without PASID" failed to apply to 6.6-stable tree
To: tdave@nvidia.com,baolu.lu@linux.intel.com,jroedel@suse.de,vasant.hegde@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 24 May 2025 18:19:54 +0200
Message-ID: <2025052454-kinship-reiterate-9e47@gregkh>
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
git cherry-pick -x b3f6fcd8404f9f92262303369bb877ec5d188a81
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025052454-kinship-reiterate-9e47@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b3f6fcd8404f9f92262303369bb877ec5d188a81 Mon Sep 17 00:00:00 2001
From: Tushar Dave <tdave@nvidia.com>
Date: Mon, 19 May 2025 18:19:37 -0700
Subject: [PATCH] iommu: Skip PASID validation for devices without PASID
 capability

Generally PASID support requires ACS settings that usually create
single device groups, but there are some niche cases where we can get
multi-device groups and still have working PASID support. The primary
issue is that PCI switches are not required to treat PASID tagged TLPs
specially so appropriate ACS settings are required to route all TLPs to
the host bridge if PASID is going to work properly.

pci_enable_pasid() does check that each device that will use PASID has
the proper ACS settings to achieve this routing.

However, no-PASID devices can be combined with PASID capable devices
within the same topology using non-uniform ACS settings. In this case
the no-PASID devices may not have strict route to host ACS flags and
end up being grouped with the PASID devices.

This configuration fails to allow use of the PASID within the iommu
core code which wrongly checks if the no-PASID device supports PASID.

Fix this by ignoring no-PASID devices during the PASID validation. They
will never issue a PASID TLP anyhow so they can be ignored.

Fixes: c404f55c26fc ("iommu: Validate the PASID in iommu_attach_device_pasid()")
Cc: stable@vger.kernel.org
Signed-off-by: Tushar Dave <tdave@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Link: https://lore.kernel.org/r/20250520011937.3230557-1-tdave@nvidia.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4f91a740c15f..9d728800a862 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3366,10 +3366,12 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
 	int ret;
 
 	for_each_group_device(group, device) {
-		ret = domain->ops->set_dev_pasid(domain, device->dev,
-						 pasid, old);
-		if (ret)
-			goto err_revert;
+		if (device->dev->iommu->max_pasids > 0) {
+			ret = domain->ops->set_dev_pasid(domain, device->dev,
+							 pasid, old);
+			if (ret)
+				goto err_revert;
+		}
 	}
 
 	return 0;
@@ -3379,15 +3381,18 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
 	for_each_group_device(group, device) {
 		if (device == last_gdev)
 			break;
-		/*
-		 * If no old domain, undo the succeeded devices/pasid.
-		 * Otherwise, rollback the succeeded devices/pasid to the old
-		 * domain. And it is a driver bug to fail attaching with a
-		 * previously good domain.
-		 */
-		if (!old || WARN_ON(old->ops->set_dev_pasid(old, device->dev,
+		if (device->dev->iommu->max_pasids > 0) {
+			/*
+			 * If no old domain, undo the succeeded devices/pasid.
+			 * Otherwise, rollback the succeeded devices/pasid to
+			 * the old domain. And it is a driver bug to fail
+			 * attaching with a previously good domain.
+			 */
+			if (!old ||
+			    WARN_ON(old->ops->set_dev_pasid(old, device->dev,
 							    pasid, domain)))
-			iommu_remove_dev_pasid(device->dev, pasid, domain);
+				iommu_remove_dev_pasid(device->dev, pasid, domain);
+		}
 	}
 	return ret;
 }
@@ -3398,8 +3403,10 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
 {
 	struct group_device *device;
 
-	for_each_group_device(group, device)
-		iommu_remove_dev_pasid(device->dev, pasid, domain);
+	for_each_group_device(group, device) {
+		if (device->dev->iommu->max_pasids > 0)
+			iommu_remove_dev_pasid(device->dev, pasid, domain);
+	}
 }
 
 /*
@@ -3440,7 +3447,13 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 
 	mutex_lock(&group->mutex);
 	for_each_group_device(group, device) {
-		if (pasid >= device->dev->iommu->max_pasids) {
+		/*
+		 * Skip PASID validation for devices without PASID support
+		 * (max_pasids = 0). These devices cannot issue transactions
+		 * with PASID, so they don't affect group's PASID usage.
+		 */
+		if ((device->dev->iommu->max_pasids > 0) &&
+		    (pasid >= device->dev->iommu->max_pasids)) {
 			ret = -EINVAL;
 			goto out_unlock;
 		}


