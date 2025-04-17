Return-Path: <stable+bounces-133058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5651EA91B30
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B84D7A41FB
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C68238164;
	Thu, 17 Apr 2025 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dJsaBRMo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A615122E412
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744890515; cv=none; b=pC8YRZxKPjdhO3r5N10IaJyQnu+GnWGbvbHRLWFBjY3q06eHfuA+G22HitAiPQCcxiyFSWQqw5XGdBfLrTYINLzzOnLon1PxQe+mchkmzTo12pcOcB0LdR9M/N0FQDJY7mab5hLlaLN05Gmk9Pwf3xuh2qMEKVML3QWO4ipAoqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744890515; c=relaxed/simple;
	bh=d4cDMDNf4NU2kP/4DHruAxReC4+Y6uul62fttNX1n38=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S6ycXCBfIWR8fP9oHYK9eBZu6CLZmVpQ5gUkTK0fAUBx88CYy9Q91XqG6Wejaw5LF62KQ9Bq0uv8RlMVHAR1Y2N7rNvF2PpVLoWX/04wVXDa6LDXQSb2DJJa4d96wv4To4x9Bq7L6sLQnuGtvcz78Exgd/zK3088HQPOn4W1DRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dJsaBRMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD3AC4CEE4;
	Thu, 17 Apr 2025 11:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744890515;
	bh=d4cDMDNf4NU2kP/4DHruAxReC4+Y6uul62fttNX1n38=;
	h=Subject:To:Cc:From:Date:From;
	b=dJsaBRMoWV7c0yvfzO9yRxzrabm1rfRW/cJa2j2Y0Ne0tQcJvnwcduKOgsZDLW3is
	 WjM4vfeuVnAasQfTCKaD9h+R8JW3qXeu+XlQIb+vySr6V4UvLSbkWN/u1v/Aw+Xx7n
	 terpCB1JTHa662pjpe4uzVMH6cxqnuQqGQSX+T/c=
Subject: FAILED: patch "[PATCH] iommufd: Fail replace if device has not been attached" failed to apply to 6.12-stable tree
To: yi.l.liu@intel.com,jgg@nvidia.com,kevin.tian@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 13:43:01 +0200
Message-ID: <2025041701-aerospace-retired-ff75@gregkh>
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
git cherry-pick -x 55c85fa7579dc2e3f5399ef5bad67a44257c1a48
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041701-aerospace-retired-ff75@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 55c85fa7579dc2e3f5399ef5bad67a44257c1a48 Mon Sep 17 00:00:00 2001
From: Yi Liu <yi.l.liu@intel.com>
Date: Wed, 5 Mar 2025 19:48:42 -0800
Subject: [PATCH] iommufd: Fail replace if device has not been attached

The current implementation of iommufd_device_do_replace() implicitly
assumes that the input device has already been attached. However, there
is no explicit check to verify this assumption. If another device within
the same group has been attached, the replace operation might succeed,
but the input device itself may not have been attached yet.

As a result, the input device might not be tracked in the
igroup->device_list, and its reserved IOVA might not be added. Despite
this, the caller might incorrectly assume that the device has been
successfully replaced, which could lead to unexpected behavior or errors.

To address this issue, add a check to ensure that the input device has
been attached before proceeding with the replace operation. This check
will help maintain the integrity of the device tracking system and prevent
potential issues arising from incorrect assumptions about the device's
attachment status.

Fixes: e88d4ec154a8 ("iommufd: Add iommufd_device_replace()")
Link: https://patch.msgid.link/r/20250306034842.5950-1-yi.l.liu@intel.com
Cc: stable@vger.kernel.org
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index b2f0cb909e6d..bd50146e2ad0 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -471,6 +471,17 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 
 /* The device attach/detach/replace helpers for attach_handle */
 
+/* Check if idev is attached to igroup->hwpt */
+static bool iommufd_device_is_attached(struct iommufd_device *idev)
+{
+	struct iommufd_device *cur;
+
+	list_for_each_entry(cur, &idev->igroup->device_list, group_item)
+		if (cur == idev)
+			return true;
+	return false;
+}
+
 static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 				      struct iommufd_device *idev)
 {
@@ -710,6 +721,11 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 		goto err_unlock;
 	}
 
+	if (!iommufd_device_is_attached(idev)) {
+		rc = -EINVAL;
+		goto err_unlock;
+	}
+
 	if (hwpt == igroup->hwpt) {
 		mutex_unlock(&idev->igroup->lock);
 		return NULL;


