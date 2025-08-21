Return-Path: <stable+bounces-172045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE74B2F9CC
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6658601A5C
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6254B2C11C1;
	Thu, 21 Aug 2025 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tVo7JgtX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2256636CDE1
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781746; cv=none; b=YPDVNSmODqRDH7RgOd5nETcn98ZUG1gq3PJ8g3sJ5S4noWUiCZrhnGTdLsETKN4f06qXvNlOEC0S4IlFUxdcAUnsMdhMheriT4Yz2AvjAkID3B16UjA8rIDqkTByAfbdaFiH8fv9Fn7nkMvm+NGZRB55djXYJ3nzX7coB8k5eYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781746; c=relaxed/simple;
	bh=WsrklQ1LOID6DOoDyzdZCaAHUIUlsCtblDtS+PxvTU0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jMZsghH43ZkqQQCUtDSQ3RfxmqNc+JLTnRcFsCQck8DfOKhBfvxHzPpJbgAJWXLsZESCwG3VrtIp1AD6IGwPO3ZGoQhUbd67ofpvuKzX4/YulkTtlWD5SyBP4LZySulbLpA9DVB5aUdd9Pr7DJO+vK3hnMxWaklf9py7EbIG2IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tVo7JgtX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE59C4CEED;
	Thu, 21 Aug 2025 13:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755781746;
	bh=WsrklQ1LOID6DOoDyzdZCaAHUIUlsCtblDtS+PxvTU0=;
	h=Subject:To:Cc:From:Date:From;
	b=tVo7JgtXpwCN+16zjhR2kVRb2e5agATot6ZGe5vJNa9un+lx5rsiDvRYe3Phmc3y8
	 QXCYJGxPiqOHumK4tDxqYb1/MRGf6eNnx5F8yUunaeDRXQd7dbbjoxfRVwO09Y5XaF
	 ZNFpZHIdOBO+bLEYy3pnfxjMkheIOk9KrlAmxWkE=
Subject: FAILED: patch "[PATCH] scsi: ufs: ufs-pci: Fix default runtime and system PM levels" failed to apply to 5.15-stable tree
To: adrian.hunter@intel.com,bvanassche@acm.org,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:09:02 +0200
Message-ID: <2025082102-levitate-simple-9760@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 6de7435e6b81fe52c0ab4c7e181f6b5decd18eb1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082102-levitate-simple-9760@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6de7435e6b81fe52c0ab4c7e181f6b5decd18eb1 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Wed, 23 Jul 2025 19:58:50 +0300
Subject: [PATCH] scsi: ufs: ufs-pci: Fix default runtime and system PM levels

Intel MTL-like host controllers support auto-hibernate.  Using
auto-hibernate with manual (driver initiated) hibernate produces more
complex operation.  For example, the host controller will have to exit
auto-hibernate simply to allow the driver to enter hibernate state
manually.  That is not recommended.

The default rpm_lvl and spm_lvl is 3, which includes manual hibernate.

Change the default values to 2, which does not.

Note, to be simpler to backport to stable kernels, utilize the UFS PCI
driver's ->late_init() call back.  Recent commits have made it possible
to set up a controller-specific default in the regular ->init() call
back, but not all stable kernels have those changes.

Fixes: 4049f7acef3e ("scsi: ufs: ufs-pci: Add support for Intel MTL")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20250723165856.145750-3-adrian.hunter@intel.com
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/ufs/host/ufshcd-pci.c b/drivers/ufs/host/ufshcd-pci.c
index af1c272eef1c..8aff32d7057d 100644
--- a/drivers/ufs/host/ufshcd-pci.c
+++ b/drivers/ufs/host/ufshcd-pci.c
@@ -468,10 +468,23 @@ static int ufs_intel_adl_init(struct ufs_hba *hba)
 	return ufs_intel_common_init(hba);
 }
 
+static void ufs_intel_mtl_late_init(struct ufs_hba *hba)
+{
+	hba->rpm_lvl = UFS_PM_LVL_2;
+	hba->spm_lvl = UFS_PM_LVL_2;
+}
+
 static int ufs_intel_mtl_init(struct ufs_hba *hba)
 {
+	struct ufs_host *ufs_host;
+	int err;
+
 	hba->caps |= UFSHCD_CAP_CRYPTO | UFSHCD_CAP_WB_EN;
-	return ufs_intel_common_init(hba);
+	err = ufs_intel_common_init(hba);
+	/* Get variant after it is set in ufs_intel_common_init() */
+	ufs_host = ufshcd_get_variant(hba);
+	ufs_host->late_init = ufs_intel_mtl_late_init;
+	return err;
 }
 
 static int ufs_qemu_get_hba_mac(struct ufs_hba *hba)


