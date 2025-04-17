Return-Path: <stable+bounces-133055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B78BA91B2D
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151C619E381B
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6B323E34E;
	Thu, 17 Apr 2025 11:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VpVlnNh2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7F4238164
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 11:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744890507; cv=none; b=eZshyt1PRaei10MAKgFMBkUJCaXiTxN8o06H/VFJdjVLQ9c8i3PpxvsC/jpojga0hdc7r3dkNg03wAwunihwcMdM+RwEphhg4i4925D7nxM4TRbt2Xbu/vKmfz4EYJjuyvzXbl3Qf8dBcYIx03mWKS/uTvD+j45s6kZ0mP/hPzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744890507; c=relaxed/simple;
	bh=C1BtRUOrxOtPlsQO385W5O1thZdRFrbObxJAKfn4n1s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=l7pDIYzH0eX9wpVliRnJg0GXAdlv+je9i6MIexEGD/yfluOVlMakY5QJkEymDmB9JMeHRBHz23dgvXcHEeQEjuAUeI803R3nabCVMEe7vmUfizPuS4eAYANewtmJlHdMiyenSiZZL6kDf2oa5a+oJ9Ms0CJq+D2AmA8kCRaOEyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VpVlnNh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2C7C4CEE4;
	Thu, 17 Apr 2025 11:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744890506;
	bh=C1BtRUOrxOtPlsQO385W5O1thZdRFrbObxJAKfn4n1s=;
	h=Subject:To:Cc:From:Date:From;
	b=VpVlnNh2Y/27Dlqfq1tlhseOU43+Q1DKVZ7g1otEzliz21YpYIV4d2mc737Lf9hWh
	 RiCep2dBiXYfqySFE59iCtJpkYm8eMKPw/JECsZAuXKInn/kee6myfzajVboRAzF7H
	 RdoNSeMhNRVvbGWVwvvP0XbwWwxV6iWJlgh1DN8M=
Subject: FAILED: patch "[PATCH] iommufd: Fail replace if device has not been attached" failed to apply to 6.14-stable tree
To: yi.l.liu@intel.com,jgg@nvidia.com,kevin.tian@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 13:42:59 +0200
Message-ID: <2025041759-knee-unearned-530e@gregkh>
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
git cherry-pick -x 55c85fa7579dc2e3f5399ef5bad67a44257c1a48
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041759-knee-unearned-530e@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

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


