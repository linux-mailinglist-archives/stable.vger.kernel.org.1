Return-Path: <stable+bounces-114595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D14A2EF0C
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 554571622BE
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17A423099F;
	Mon, 10 Feb 2025 13:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DiBmmSgN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8290123099E
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195878; cv=none; b=tJInqtzZPaY37xmP1zicUIkht68im6a8JVfbAIBfaBAbzeXUXxGDG2CRK5MUqAF1A4gFo4RUonTxQtQW8P1f5LiIldlDP0Of5yJBkIhoMXIVz0AndIAK3iVzv4Awor0evpdDZqv+id19ZPubKQ/35XbDfK/VBKQrPF+iO/WNY7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195878; c=relaxed/simple;
	bh=Ci9NF9MnU5cezox6qlPAM3dvuu5LQX+1a7Jo04QNwUg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZzXgzEr+EBxyUgALTSneMWhBSZTmN7NUfhPk0no9Sq2LpgUUTUefCIe4X1mVC3Jyv4Ouxs8FufgGrJBgAOmPT0knWnjrioQP1emHJC0hv4HetkzFj330bTaLc9sTeH4yvnsxUmnwYxKW/KEha7xp7kIj+F6eaylzPdrDKPDePqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DiBmmSgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4971FC4CED1;
	Mon, 10 Feb 2025 13:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739195878;
	bh=Ci9NF9MnU5cezox6qlPAM3dvuu5LQX+1a7Jo04QNwUg=;
	h=Subject:To:Cc:From:Date:From;
	b=DiBmmSgNv3/63tIZNgGqXvC71jjgWeAiyQdP5VC5/lsq+C7bgERUI7Nr5lBio1pqY
	 qVsLVOLHlvj7YVYrJWb6MbnAhIcMb+6z1JALkHubGoVZThFj6pn3s8l7baNV6rKH+g
	 P0kHDylTzSUpfJb6Z6Fmvv9tTwYQzuxHfFnCGeg4=
Subject: FAILED: patch "[PATCH] scsi: ufs: core: Fix use-after free in init error and remove" failed to apply to 5.15-stable tree
To: andre.draszik@linaro.org,beanhuo@micron.com,ebiggers@kernel.org,manivannan.sadhasivam@linaro.org,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:57:44 +0100
Message-ID: <2025021044-crying-depose-dd2a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f8fb2403ddebb5eea0033d90d9daae4c88749ada
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021044-crying-depose-dd2a@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f8fb2403ddebb5eea0033d90d9daae4c88749ada Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
Date: Fri, 24 Jan 2025 15:09:00 +0000
Subject: [PATCH] scsi: ufs: core: Fix use-after free in init error and remove
 paths
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

devm_blk_crypto_profile_init() registers a cleanup handler to run when
the associated (platform-) device is being released. For UFS, the
crypto private data and pointers are stored as part of the ufs_hba's
data structure 'struct ufs_hba::crypto_profile'. This structure is
allocated as part of the underlying ufshcd and therefore Scsi_host
allocation.

During driver release or during error handling in ufshcd_pltfrm_init(),
this structure is released as part of ufshcd_dealloc_host() before the
(platform-) device associated with the crypto call above is released.
Once this device is released, the crypto cleanup code will run, using
the just-released 'struct ufs_hba::crypto_profile'. This causes a
use-after-free situation:

  Call trace:
   kfree+0x60/0x2d8 (P)
   kvfree+0x44/0x60
   blk_crypto_profile_destroy_callback+0x28/0x70
   devm_action_release+0x1c/0x30
   release_nodes+0x6c/0x108
   devres_release_all+0x98/0x100
   device_unbind_cleanup+0x20/0x70
   really_probe+0x218/0x2d0

In other words, the initialisation code flow is:

  platform-device probe
    ufshcd_pltfrm_init()
      ufshcd_alloc_host()
        scsi_host_alloc()
          allocation of struct ufs_hba
          creation of scsi-host devices
    devm_blk_crypto_profile_init()
      devm registration of cleanup handler using platform-device

and during error handling of ufshcd_pltfrm_init() or during driver
removal:

  ufshcd_dealloc_host()
    scsi_host_put()
      put_device(scsi-host)
        release of struct ufs_hba
  put_device(platform-device)
    crypto cleanup handler

To fix this use-after free, change ufshcd_alloc_host() to register a
devres action to automatically cleanup the underlying SCSI device on
ufshcd destruction, without requiring explicit calls to
ufshcd_dealloc_host(). This way:

    * the crypto profile and all other ufs_hba-owned resources are
      destroyed before SCSI (as they've been registered after)
    * a memleak is plugged in tc-dwc-g210-pci.c remove() as a
      side-effect
    * EXPORT_SYMBOL_GPL(ufshcd_dealloc_host) can be removed fully as
      it's not needed anymore
    * no future drivers using ufshcd_alloc_host() could ever forget
      adding the cleanup

Fixes: cb77cb5abe1f ("blk-crypto: rename blk_keyslot_manager to blk_crypto_profile")
Fixes: d76d9d7d1009 ("scsi: ufs: use devm_blk_ksm_init()")
Cc: stable@vger.kernel.org
Signed-off-by: André Draszik <andre.draszik@linaro.org>
Link: https://lore.kernel.org/r/20250124-ufshcd-fix-v4-1-c5d0144aae59@linaro.org
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index d3741b1f4382..d2de80b2bba4 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -10226,16 +10226,6 @@ int ufshcd_system_thaw(struct device *dev)
 EXPORT_SYMBOL_GPL(ufshcd_system_thaw);
 #endif /* CONFIG_PM_SLEEP  */
 
-/**
- * ufshcd_dealloc_host - deallocate Host Bus Adapter (HBA)
- * @hba: pointer to Host Bus Adapter (HBA)
- */
-void ufshcd_dealloc_host(struct ufs_hba *hba)
-{
-	scsi_host_put(hba->host);
-}
-EXPORT_SYMBOL_GPL(ufshcd_dealloc_host);
-
 /**
  * ufshcd_set_dma_mask - Set dma mask based on the controller
  *			 addressing capability
@@ -10254,12 +10244,26 @@ static int ufshcd_set_dma_mask(struct ufs_hba *hba)
 	return dma_set_mask_and_coherent(hba->dev, DMA_BIT_MASK(32));
 }
 
+/**
+ * ufshcd_devres_release - devres cleanup handler, invoked during release of
+ *			   hba->dev
+ * @host: pointer to SCSI host
+ */
+static void ufshcd_devres_release(void *host)
+{
+	scsi_host_put(host);
+}
+
 /**
  * ufshcd_alloc_host - allocate Host Bus Adapter (HBA)
  * @dev: pointer to device handle
  * @hba_handle: driver private handle
  *
  * Return: 0 on success, non-zero value on failure.
+ *
+ * NOTE: There is no corresponding ufshcd_dealloc_host() because this function
+ * keeps track of its allocations using devres and deallocates everything on
+ * device removal automatically.
  */
 int ufshcd_alloc_host(struct device *dev, struct ufs_hba **hba_handle)
 {
@@ -10281,6 +10285,13 @@ int ufshcd_alloc_host(struct device *dev, struct ufs_hba **hba_handle)
 		err = -ENOMEM;
 		goto out_error;
 	}
+
+	err = devm_add_action_or_reset(dev, ufshcd_devres_release,
+				       host);
+	if (err)
+		return dev_err_probe(dev, err,
+				     "failed to add ufshcd dealloc action\n");
+
 	host->nr_maps = HCTX_TYPE_POLL + 1;
 	hba = shost_priv(host);
 	hba->host = host;
diff --git a/drivers/ufs/host/ufshcd-pci.c b/drivers/ufs/host/ufshcd-pci.c
index ea39c5d5b8cf..9cfcaad23cf9 100644
--- a/drivers/ufs/host/ufshcd-pci.c
+++ b/drivers/ufs/host/ufshcd-pci.c
@@ -562,7 +562,6 @@ static void ufshcd_pci_remove(struct pci_dev *pdev)
 	pm_runtime_forbid(&pdev->dev);
 	pm_runtime_get_noresume(&pdev->dev);
 	ufshcd_remove(hba);
-	ufshcd_dealloc_host(hba);
 }
 
 /**
@@ -605,7 +604,6 @@ ufshcd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	err = ufshcd_init(hba, mmio_base, pdev->irq);
 	if (err) {
 		dev_err(&pdev->dev, "Initialization failed\n");
-		ufshcd_dealloc_host(hba);
 		return err;
 	}
 
diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufshcd-pltfrm.c
index 505572d4fa87..ffe5d1d2b215 100644
--- a/drivers/ufs/host/ufshcd-pltfrm.c
+++ b/drivers/ufs/host/ufshcd-pltfrm.c
@@ -465,21 +465,17 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 
 	mmio_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(mmio_base)) {
-		err = PTR_ERR(mmio_base);
-		goto out;
-	}
+	if (IS_ERR(mmio_base))
+		return PTR_ERR(mmio_base);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		err = irq;
-		goto out;
-	}
+	if (irq < 0)
+		return irq;
 
 	err = ufshcd_alloc_host(dev, &hba);
 	if (err) {
 		dev_err(dev, "Allocation failed\n");
-		goto out;
+		return err;
 	}
 
 	hba->vops = vops;
@@ -488,13 +484,13 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
 	if (err) {
 		dev_err(dev, "%s: clock parse failed %d\n",
 				__func__, err);
-		goto dealloc_host;
+		return err;
 	}
 	err = ufshcd_parse_regulator_info(hba);
 	if (err) {
 		dev_err(dev, "%s: regulator init failed %d\n",
 				__func__, err);
-		goto dealloc_host;
+		return err;
 	}
 
 	ufshcd_init_lanes_per_dir(hba);
@@ -502,25 +498,20 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
 	err = ufshcd_parse_operating_points(hba);
 	if (err) {
 		dev_err(dev, "%s: OPP parse failed %d\n", __func__, err);
-		goto dealloc_host;
+		return err;
 	}
 
 	err = ufshcd_init(hba, mmio_base, irq);
 	if (err) {
 		dev_err_probe(dev, err, "Initialization failed with error %d\n",
 			      err);
-		goto dealloc_host;
+		return err;
 	}
 
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
 	return 0;
-
-dealloc_host:
-	ufshcd_dealloc_host(hba);
-out:
-	return err;
 }
 EXPORT_SYMBOL_GPL(ufshcd_pltfrm_init);
 
@@ -534,7 +525,6 @@ void ufshcd_pltfrm_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(&pdev->dev);
 	ufshcd_remove(hba);
-	ufshcd_dealloc_host(hba);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 }
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 650ff238cd74..8bf31e6ca4e5 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1309,7 +1309,6 @@ static inline void ufshcd_rmwl(struct ufs_hba *hba, u32 mask, u32 val, u32 reg)
 void ufshcd_enable_irq(struct ufs_hba *hba);
 void ufshcd_disable_irq(struct ufs_hba *hba);
 int ufshcd_alloc_host(struct device *, struct ufs_hba **);
-void ufshcd_dealloc_host(struct ufs_hba *);
 int ufshcd_hba_enable(struct ufs_hba *hba);
 int ufshcd_init(struct ufs_hba *, void __iomem *, unsigned int);
 int ufshcd_link_recovery(struct ufs_hba *hba);


