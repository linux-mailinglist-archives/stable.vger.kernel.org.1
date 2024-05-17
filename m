Return-Path: <stable+bounces-45395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 209BA8C8611
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 14:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0CF01F268A4
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 12:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C8F5491A;
	Fri, 17 May 2024 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qTv4HM0t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8FC548EF;
	Fri, 17 May 2024 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715947150; cv=none; b=r7VUPdP1BQUI/yWkRq3jY5Ioi6+ibDAf3RUJgXqR+/PgjsLKVZGlf7cmhLETeACa38yesEUBH5c9sBNsPX2aItC/tNymhkaGEMN8NgAHCc7gQMccQ6eVGVZYLIQE1IgP9QgneQBmmZV4kluu49n8cFUfTJAKiqWEwDKK4M+4c0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715947150; c=relaxed/simple;
	bh=+z+O+7/kMOu9JC+RQLMr3FYn0ofWr2Eu5H0Z5QlRmTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOaXSLZTXLXCpwzAZbWNAc7+x6HPCwDbYR8W0D33YlTdZvSHp0gunpWxU62oebqVC/40RCRCwG9EVzqdx228R8S+RPcJg/azaLz6Nen3Fjs+4AbBILcOezG41GLvAzhOKPD/WIkyUl7PYtDhssssI+CORZMN+KB4LnkJVOxP7xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qTv4HM0t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65F4C4AF0E;
	Fri, 17 May 2024 11:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715947150;
	bh=+z+O+7/kMOu9JC+RQLMr3FYn0ofWr2Eu5H0Z5QlRmTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qTv4HM0t6D80VGRsT/0SnZnmSuQEs9kpy/7OwdpeerPzM7EVN49HfFS9qLc47U6Vu
	 xXC0uhdytjMWj/UnAIPs41Rl4imZ7RpBC1dsYc5ZRJ5lC6LgOkojpkvk3n2h26Tgc+
	 n5Pr1vplfrLhe/BLLDatoukvZN1QPXZtSDhVJ81Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.9.1
Date: Fri, 17 May 2024 13:58:58 +0200
Message-ID: <2024051758-landfill-wielder-933b@gregkh>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <2024051758-parchment-unadorned-15ed@gregkh>
References: <2024051758-parchment-unadorned-15ed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 967e97878ecd..a7045435151e 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 9
-SUBLEVEL = 0
+SUBLEVEL = 1
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index c095a2c8f659..39935071174a 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -400,6 +400,18 @@ static int idxd_cdev_mmap(struct file *filp, struct vm_area_struct *vma)
 	int rc;
 
 	dev_dbg(&pdev->dev, "%s called\n", __func__);
+
+	/*
+	 * Due to an erratum in some of the devices supported by the driver,
+	 * direct user submission to the device can be unsafe.
+	 * (See the INTEL-SA-01084 security advisory)
+	 *
+	 * For the devices that exhibit this behavior, require that the user
+	 * has CAP_SYS_RAWIO capabilities.
+	 */
+	if (!idxd->user_submission_safe && !capable(CAP_SYS_RAWIO))
+		return -EPERM;
+
 	rc = check_vma(wq, vma, __func__);
 	if (rc < 0)
 		return rc;
@@ -414,6 +426,70 @@ static int idxd_cdev_mmap(struct file *filp, struct vm_area_struct *vma)
 			vma->vm_page_prot);
 }
 
+static int idxd_submit_user_descriptor(struct idxd_user_context *ctx,
+				       struct dsa_hw_desc __user *udesc)
+{
+	struct idxd_wq *wq = ctx->wq;
+	struct idxd_dev *idxd_dev = &wq->idxd->idxd_dev;
+	const uint64_t comp_addr_align = is_dsa_dev(idxd_dev) ? 0x20 : 0x40;
+	void __iomem *portal = idxd_wq_portal_addr(wq);
+	struct dsa_hw_desc descriptor __aligned(64);
+	int rc;
+
+	rc = copy_from_user(&descriptor, udesc, sizeof(descriptor));
+	if (rc)
+		return -EFAULT;
+
+	/*
+	 * DSA devices are capable of indirect ("batch") command submission.
+	 * On devices where direct user submissions are not safe, we cannot
+	 * allow this since there is no good way for us to verify these
+	 * indirect commands.
+	 */
+	if (is_dsa_dev(idxd_dev) && descriptor.opcode == DSA_OPCODE_BATCH &&
+		!wq->idxd->user_submission_safe)
+		return -EINVAL;
+	/*
+	 * As per the programming specification, the completion address must be
+	 * aligned to 32 or 64 bytes. If this is violated the hardware
+	 * engine can get very confused (security issue).
+	 */
+	if (!IS_ALIGNED(descriptor.completion_addr, comp_addr_align))
+		return -EINVAL;
+
+	if (wq_dedicated(wq))
+		iosubmit_cmds512(portal, &descriptor, 1);
+	else {
+		descriptor.priv = 0;
+		descriptor.pasid = ctx->pasid;
+		rc = idxd_enqcmds(wq, portal, &descriptor);
+		if (rc < 0)
+			return rc;
+	}
+
+	return 0;
+}
+
+static ssize_t idxd_cdev_write(struct file *filp, const char __user *buf, size_t len,
+			       loff_t *unused)
+{
+	struct dsa_hw_desc __user *udesc = (struct dsa_hw_desc __user *)buf;
+	struct idxd_user_context *ctx = filp->private_data;
+	ssize_t written = 0;
+	int i;
+
+	for (i = 0; i < len/sizeof(struct dsa_hw_desc); i++) {
+		int rc = idxd_submit_user_descriptor(ctx, udesc + i);
+
+		if (rc)
+			return written ? written : rc;
+
+		written += sizeof(struct dsa_hw_desc);
+	}
+
+	return written;
+}
+
 static __poll_t idxd_cdev_poll(struct file *filp,
 			       struct poll_table_struct *wait)
 {
@@ -436,6 +512,7 @@ static const struct file_operations idxd_cdev_fops = {
 	.open = idxd_cdev_open,
 	.release = idxd_cdev_release,
 	.mmap = idxd_cdev_mmap,
+	.write = idxd_cdev_write,
 	.poll = idxd_cdev_poll,
 };
 
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 7b98944135eb..868b724a3b75 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -288,6 +288,7 @@ struct idxd_driver_data {
 	int evl_cr_off;
 	int cr_status_off;
 	int cr_result_off;
+	bool user_submission_safe;
 	load_device_defaults_fn_t load_device_defaults;
 };
 
@@ -374,6 +375,8 @@ struct idxd_device {
 
 	struct dentry *dbgfs_dir;
 	struct dentry *dbgfs_evl_file;
+
+	bool user_submission_safe;
 };
 
 static inline unsigned int evl_ent_size(struct idxd_device *idxd)
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 264c4e47d7cc..a7295943fa22 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -47,6 +47,7 @@ static struct idxd_driver_data idxd_driver_data[] = {
 		.align = 32,
 		.dev_type = &dsa_device_type,
 		.evl_cr_off = offsetof(struct dsa_evl_entry, cr),
+		.user_submission_safe = false, /* See INTEL-SA-01084 security advisory */
 		.cr_status_off = offsetof(struct dsa_completion_record, status),
 		.cr_result_off = offsetof(struct dsa_completion_record, result),
 	},
@@ -57,6 +58,7 @@ static struct idxd_driver_data idxd_driver_data[] = {
 		.align = 64,
 		.dev_type = &iax_device_type,
 		.evl_cr_off = offsetof(struct iax_evl_entry, cr),
+		.user_submission_safe = false, /* See INTEL-SA-01084 security advisory */
 		.cr_status_off = offsetof(struct iax_completion_record, status),
 		.cr_result_off = offsetof(struct iax_completion_record, error_code),
 		.load_device_defaults = idxd_load_iaa_device_defaults,
@@ -774,6 +776,8 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dev_info(&pdev->dev, "Intel(R) Accelerator Device (v%x)\n",
 		 idxd->hw.version);
 
+	idxd->user_submission_safe = data->user_submission_safe;
+
 	return 0;
 
  err_dev_register:
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 315c004f58e4..e16dbf9ab324 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -6,9 +6,6 @@
 #include <uapi/linux/idxd.h>
 
 /* PCI Config */
-#define PCI_DEVICE_ID_INTEL_DSA_SPR0	0x0b25
-#define PCI_DEVICE_ID_INTEL_IAX_SPR0	0x0cfe
-
 #define DEVICE_VERSION_1		0x100
 #define DEVICE_VERSION_2		0x200
 
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 7f28f01be672..f706eae0e76b 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1197,12 +1197,35 @@ static ssize_t wq_enqcmds_retries_store(struct device *dev, struct device_attrib
 static struct device_attribute dev_attr_wq_enqcmds_retries =
 		__ATTR(enqcmds_retries, 0644, wq_enqcmds_retries_show, wq_enqcmds_retries_store);
 
+static ssize_t op_cap_show_common(struct device *dev, char *buf, unsigned long *opcap_bmap)
+{
+	ssize_t pos;
+	int i;
+
+	pos = 0;
+	for (i = IDXD_MAX_OPCAP_BITS/64 - 1; i >= 0; i--) {
+		unsigned long val = opcap_bmap[i];
+
+		/* On systems where direct user submissions are not safe, we need to clear out
+		 * the BATCH capability from the capability mask in sysfs since we cannot support
+		 * that command on such systems.
+		 */
+		if (i == DSA_OPCODE_BATCH/64 && !confdev_to_idxd(dev)->user_submission_safe)
+			clear_bit(DSA_OPCODE_BATCH % 64, &val);
+
+		pos += sysfs_emit_at(buf, pos, "%*pb", 64, &val);
+		pos += sysfs_emit_at(buf, pos, "%c", i == 0 ? '\n' : ',');
+	}
+
+	return pos;
+}
+
 static ssize_t wq_op_config_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
 	struct idxd_wq *wq = confdev_to_wq(dev);
 
-	return sysfs_emit(buf, "%*pb\n", IDXD_MAX_OPCAP_BITS, wq->opcap_bmap);
+	return op_cap_show_common(dev, buf, wq->opcap_bmap);
 }
 
 static int idxd_verify_supported_opcap(struct idxd_device *idxd, unsigned long *opmask)
@@ -1455,7 +1478,7 @@ static ssize_t op_cap_show(struct device *dev,
 {
 	struct idxd_device *idxd = confdev_to_idxd(dev);
 
-	return sysfs_emit(buf, "%*pb\n", IDXD_MAX_OPCAP_BITS, idxd->opcap_bmap);
+	return op_cap_show_common(dev, buf, idxd->opcap_bmap);
 }
 static DEVICE_ATTR_RO(op_cap);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 3709d18da0e6..075d04ba3ef2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1657,6 +1657,10 @@ mt7915_net_fill_forward_path(struct ieee80211_hw *hw,
 #endif
 
 const struct ieee80211_ops mt7915_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx = mt7915_tx,
 	.start = mt7915_start,
 	.stop = mt7915_stop,
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index cb5b7f865d58..e727941f589d 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -71,6 +71,8 @@ static bool vfio_pci_dev_in_denylist(struct pci_dev *pdev)
 		case PCI_DEVICE_ID_INTEL_QAT_C62X_VF:
 		case PCI_DEVICE_ID_INTEL_QAT_DH895XCC:
 		case PCI_DEVICE_ID_INTEL_QAT_DH895XCC_VF:
+		case PCI_DEVICE_ID_INTEL_DSA_SPR0:
+		case PCI_DEVICE_ID_INTEL_IAX_SPR0:
 			return true;
 		default:
 			return false;
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index c547d1d4feb1..4beb29907c2b 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2687,8 +2687,10 @@
 #define PCI_DEVICE_ID_INTEL_I960	0x0960
 #define PCI_DEVICE_ID_INTEL_I960RM	0x0962
 #define PCI_DEVICE_ID_INTEL_HDA_HSW_0	0x0a0c
+#define PCI_DEVICE_ID_INTEL_DSA_SPR0	0x0b25
 #define PCI_DEVICE_ID_INTEL_HDA_HSW_2	0x0c0c
 #define PCI_DEVICE_ID_INTEL_CENTERTON_ILB	0x0c60
+#define PCI_DEVICE_ID_INTEL_IAX_SPR0	0x0cfe
 #define PCI_DEVICE_ID_INTEL_HDA_HSW_3	0x0d0c
 #define PCI_DEVICE_ID_INTEL_HDA_BYT	0x0f04
 #define PCI_DEVICE_ID_INTEL_SST_BYT	0x0f28
diff --git a/security/keys/key.c b/security/keys/key.c
index 560790038329..0aa5f01d16ff 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -463,7 +463,8 @@ static int __key_instantiate_and_link(struct key *key,
 			if (authkey)
 				key_invalidate(authkey);
 
-			key_set_expiry(key, prep->expiry);
+			if (prep->expiry != TIME64_MAX)
+				key_set_expiry(key, prep->expiry);
 		}
 	}
 

