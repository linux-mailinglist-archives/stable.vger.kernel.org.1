Return-Path: <stable+bounces-146281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A81AC3070
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 18:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B4E189F707
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 16:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FB01EC01F;
	Sat, 24 May 2025 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yMVvxQW4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B8B18859B
	for <stable@vger.kernel.org>; Sat, 24 May 2025 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748103596; cv=none; b=LXE4Q/64wh6dHd02zpMfJHyUsEx4Z+qLOl3NlMsGWcLrUIrjgbsl3jUDwbsYn851IczENGyrYNuk957TuXwm2EA62qU7/sxYRnOcg4HHrAZ0IOJe3lSu3FOzDd4AUJuwR9nm3w+PzGDw06koR/CN/2axL3BRiPJTJU5yhZQNlrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748103596; c=relaxed/simple;
	bh=i9efKHS3GJ7E0rwP9cA18ZodbPq6qRaXvlEXBeprQg0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=f+42QMiXKEJArFSr9HYk8wSs6gnpkvE/Yfwgukw+hnlYphNPmh203Yb9+mudjfwUKLhzLKvS8H2ml3wkzWbFsP9yppQjooFgV/23uEXtjtxGPPqJMqOfDvsw/SkP99gIFfgkzCjsj9BPi9QbYmmoAefLNC+lCGnBp/Bz+wn9MrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yMVvxQW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C1BC4CEE7;
	Sat, 24 May 2025 16:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748103595;
	bh=i9efKHS3GJ7E0rwP9cA18ZodbPq6qRaXvlEXBeprQg0=;
	h=Subject:To:Cc:From:Date:From;
	b=yMVvxQW4AqxhF+8h7NyhM9efbQQMynPrjax1sQORSi9FOtt/VhG+JXzvprthd6dKM
	 Ee7TF+t2kojDzlRK6a9pQLxtoX9PoBUhUH6dR/wWlFo7uzU4QEoJMYF2ciLov6F3LT
	 xdrolIjhMukMgDE55enKBaeMj/ez/+qU7VN+u3Z8=
Subject: FAILED: patch "[PATCH] iommu: Skip PASID validation for devices without PASID" failed to apply to 6.14-stable tree
To: tdave@nvidia.com,baolu.lu@linux.intel.com,jroedel@suse.de,vasant.hegde@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 24 May 2025 18:19:52 +0200
Message-ID: <2025052452-sputter-outmost-ef4f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x b3f6fcd8404f9f92262303369bb877ec5d188a81
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025052452-sputter-outmost-ef4f@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

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


