Return-Path: <stable+bounces-216673-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOj2H9rlkmlSzwEAu9opvQ
	(envelope-from <stable+bounces-216673-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 10:39:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D030214201B
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 10:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E349300C91B
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 09:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097282E541F;
	Mon, 16 Feb 2026 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WZyTeOE1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06BF2DF3DA;
	Mon, 16 Feb 2026 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771234757; cv=none; b=gnfuejgtYnweOAHqptZaH1GuImJ2ldptvqJxyzwvQ6+1U0wN1DERL9yZGioDZ2QBmb3LdwvL4Om1BVlhJrAj5ea1hbt88vpfCHO7PsUp58pbncJGz/xbngGcme7swrZJxq4rW2+dz/BeVBw8purhsRisVaNNski0cYHQpmFWYb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771234757; c=relaxed/simple;
	bh=iAoPzRouAkK5SMi018Uji8IaojFquN9uSDWLVa6JhYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9b7kWNyokECQCJu/bD9vyIwk5o5T0L/bBfljFkAaVnESW3IKuRvy3mKlW46MIP6ECqmZhdXaThwvtqpxpghEJ73ld81tuoY25aV/XNNwAJKdRuQYe6sIFMOu16JLc3C9iA8TsuwrCDkvU2njixtL7to76S1eTsGGifar+OlDhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WZyTeOE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7ADC116C6;
	Mon, 16 Feb 2026 09:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771234757;
	bh=iAoPzRouAkK5SMi018Uji8IaojFquN9uSDWLVa6JhYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WZyTeOE1P15mtWdHffqfPBfltlYUFNZqEvwB3KZDOeqM3tvt3Wq3ksf/2+Njs3yG3
	 0hUZ1zFROBBTSb3O3BnJ4BYV/pnrsvC8PKcNUr7VAyIxZtCDAuRJBkB8ayGc/kn59u
	 /R3fbjCGLIlIVDg/cG9fsbjlVPaxPzxKPTIbgHnM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.72
Date: Mon, 16 Feb 2026 10:39:06 +0100
Message-ID: <2026021606-neglector-troubling-e9ce@gregkh>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026021606-bullhorn-marxism-9cc9@gregkh>
References: <2026021606-bullhorn-marxism-9cc9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216673-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,cfs_work.work:url,free_list.next:url]
X-Rspamd-Queue-Id: D030214201B
X-Rspamd-Action: no action

diff --git a/Makefile b/Makefile
index 443fa095f66f..8af8b413c054 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 71
+SUBLEVEL = 72
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/drivers/base/base.h b/drivers/base/base.h
index c4ffd0995043..8e1fe3dfa318 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -165,9 +165,18 @@ void device_set_deferred_probe_reason(const struct device *dev, struct va_format
 static inline int driver_match_device(const struct device_driver *drv,
 				      struct device *dev)
 {
+	device_lock_assert(dev);
+
 	return drv->bus->match ? drv->bus->match(dev, drv) : 1;
 }
 
+static inline int driver_match_device_locked(const struct device_driver *drv,
+					     struct device *dev)
+{
+	guard(device)(dev);
+	return driver_match_device(drv, dev);
+}
+
 static inline void dev_sync_state(struct device *dev)
 {
 	if (dev->bus->sync_state)
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index eaf38a6f6091..82a7bc5b4dfb 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -263,7 +263,7 @@ static ssize_t bind_store(struct device_driver *drv, const char *buf,
 	int err = -ENODEV;
 
 	dev = bus_find_device_by_name(bus, NULL, buf);
-	if (dev && driver_match_device(drv, dev)) {
+	if (dev && driver_match_device_locked(drv, dev)) {
 		err = device_driver_attach(drv, dev);
 		if (!err) {
 			/* success */
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index b526e0e0f52d..0952c864b78b 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1168,7 +1168,7 @@ static int __driver_attach(struct device *dev, void *data)
 	 * is an error.
 	 */
 
-	ret = driver_match_device(drv, dev);
+	ret = driver_match_device_locked(drv, dev);
 	if (ret == 0) {
 		/* no match */
 		return 0;
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 603ff13d9f7c..490efe4d67a9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -519,6 +519,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x2001, 0x332a), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x7392, 0xe611), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek 8852AE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0x2852), .driver_info = BTUSB_REALTEK |
diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index abf070760d68..73889a7dcc13 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -744,6 +744,16 @@ static const struct mhi_pci_dev_info mhi_telit_fn990b40_info = {
 	.edl_trigger = true,
 };
 
+static const struct mhi_pci_dev_info mhi_telit_fe990b40_info = {
+	.name = "telit-fe990b40",
+	.config = &modem_telit_fn920c04_config,
+	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
+	.dma_data_width = 32,
+	.sideband_wake = false,
+	.mru_default = 32768,
+	.edl_trigger = true,
+};
+
 static const struct mhi_pci_dev_info mhi_netprisma_lcur57_info = {
 	.name = "netprisma-lcur57",
 	.edl = "qcom/prog_firehose_sdx24.mbn",
@@ -792,6 +802,9 @@ static const struct pci_device_id mhi_pci_id_table[] = {
 	/* Telit FN990B40 (sdx72) */
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0309, 0x1c5d, 0x201a),
 		.driver_data = (kernel_ulong_t) &mhi_telit_fn990b40_info },
+	/* Telit FE990B40 (sdx72) */
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0309, 0x1c5d, 0x2025),
+		.driver_data = (kernel_ulong_t) &mhi_telit_fe990b40_info },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0309),
 		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx75_info },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x1001), /* EM120R-GL (sdx24) */
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index e9391cf2c397..e40dd6afc76c 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -223,15 +223,13 @@ static struct iaa_compression_mode *iaa_compression_modes[IAA_COMP_MODES_MAX];
 
 static int find_empty_iaa_compression_mode(void)
 {
-	int i = -EINVAL;
+	int i;
 
-	for (i = 0; i < IAA_COMP_MODES_MAX; i++) {
-		if (iaa_compression_modes[i])
-			continue;
-		break;
-	}
+	for (i = 0; i < IAA_COMP_MODES_MAX; i++)
+		if (!iaa_compression_modes[i])
+			return i;
 
-	return i;
+	return -EINVAL;
 }
 
 static struct iaa_compression_mode *find_iaa_compression_mode(const char *name, int *idx)
diff --git a/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c b/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
index c4250e5fcf8f..11dfbd4beba9 100644
--- a/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
+++ b/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
@@ -1336,7 +1336,7 @@ static ssize_t ucode_load_store(struct device *dev,
 	int del_grp_idx = -1;
 	int ucode_idx = 0;
 
-	if (strlen(buf) > OTX_CPT_UCODE_NAME_LENGTH)
+	if (count >= OTX_CPT_UCODE_NAME_LENGTH)
 		return -EINVAL;
 
 	eng_grps = container_of(attr, struct otx_cpt_eng_grps, ucode_load_attr);
diff --git a/drivers/crypto/omap-crypto.c b/drivers/crypto/omap-crypto.c
index a4cc6bf146ec..0345c9383d50 100644
--- a/drivers/crypto/omap-crypto.c
+++ b/drivers/crypto/omap-crypto.c
@@ -21,7 +21,7 @@ static int omap_crypto_copy_sg_lists(int total, int bs,
 	struct scatterlist *tmp;
 
 	if (!(flags & OMAP_CRYPTO_FORCE_SINGLE_ENTRY)) {
-		new_sg = kmalloc_array(n, sizeof(*sg), GFP_KERNEL);
+		new_sg = kmalloc_array(n, sizeof(*new_sg), GFP_KERNEL);
 		if (!new_sg)
 			return -ENOMEM;
 
diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index d0278eb568b9..817be17241d6 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -75,15 +75,20 @@ static void virtcrypto_done_task(unsigned long data)
 	struct data_queue *data_vq = (struct data_queue *)data;
 	struct virtqueue *vq = data_vq->vq;
 	struct virtio_crypto_request *vc_req;
+	unsigned long flags;
 	unsigned int len;
 
+	spin_lock_irqsave(&data_vq->lock, flags);
 	do {
 		virtqueue_disable_cb(vq);
 		while ((vc_req = virtqueue_get_buf(vq, &len)) != NULL) {
+			spin_unlock_irqrestore(&data_vq->lock, flags);
 			if (vc_req->alg_cb)
 				vc_req->alg_cb(vc_req, len);
+			spin_lock_irqsave(&data_vq->lock, flags);
 		}
 	} while (!virtqueue_enable_cb(vq));
+	spin_unlock_irqrestore(&data_vq->lock, flags);
 }
 
 static void virtcrypto_dataq_callback(struct virtqueue *vq)
diff --git a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
index 23c41d87d835..487f60e35df1 100644
--- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
@@ -550,8 +550,6 @@ int virtio_crypto_skcipher_crypt_req(
 	if (ret < 0)
 		return ret;
 
-	virtqueue_kick(data_vq->vq);
-
 	return 0;
 }
 
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 76d5d87e9681..595ef2008404 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -799,10 +799,13 @@ static struct platform_device omap_mpuio_device = {
 
 static inline void omap_mpuio_init(struct gpio_bank *bank)
 {
-	platform_set_drvdata(&omap_mpuio_device, bank);
+	static bool registered;
 
-	if (platform_driver_register(&omap_mpuio_driver) == 0)
-		(void) platform_device_register(&omap_mpuio_device);
+	platform_set_drvdata(&omap_mpuio_device, bank);
+	if (!registered) {
+		(void)platform_device_register(&omap_mpuio_device);
+		registered = true;
+	}
 }
 
 /*---------------------------------------------------------------------*/
@@ -1572,13 +1575,24 @@ static struct platform_driver omap_gpio_driver = {
  */
 static int __init omap_gpio_drv_reg(void)
 {
-	return platform_driver_register(&omap_gpio_driver);
+	int ret;
+
+	ret = platform_driver_register(&omap_mpuio_driver);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&omap_gpio_driver);
+	if (ret)
+		platform_driver_unregister(&omap_mpuio_driver);
+
+	return ret;
 }
 postcore_initcall(omap_gpio_drv_reg);
 
 static void __exit omap_gpio_exit(void)
 {
 	platform_driver_unregister(&omap_gpio_driver);
+	platform_driver_unregister(&omap_mpuio_driver);
 }
 module_exit(omap_gpio_exit);
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index b517df2db6d7..81350c4dee53 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -7903,6 +7903,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 		goto err_set_intfdata;
 
 	hw->vif_data_size = sizeof(struct rtl8xxxu_vif);
+	hw->sta_data_size = sizeof(struct rtl8xxxu_sta_info);
 
 	hw->wiphy->max_scan_ssids = 1;
 	hw->wiphy->max_scan_ie_len = IEEE80211_MAX_DATA_LEN;
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 01c8b748b20b..a4416e8986b9 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -2408,10 +2408,10 @@ void rtw_core_enable_beacon(struct rtw_dev *rtwdev, bool enable)
 
 	if (enable) {
 		rtw_write32_set(rtwdev, REG_BCN_CTRL, BIT_EN_BCN_FUNCTION);
-		rtw_write32_clr(rtwdev, REG_TXPAUSE, BIT_HIGH_QUEUE);
+		rtw_write8_clr(rtwdev, REG_TXPAUSE, BIT_HIGH_QUEUE);
 	} else {
 		rtw_write32_clr(rtwdev, REG_BCN_CTRL, BIT_EN_BCN_FUNCTION);
-		rtw_write32_set(rtwdev, REG_TXPAUSE, BIT_HIGH_QUEUE);
+		rtw_write8_set(rtwdev, REG_TXPAUSE, BIT_HIGH_QUEUE);
 	}
 }
 
diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index ef50c82e647f..43feb6139fa3 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -23,7 +23,6 @@ struct pci_epf_group {
 	struct config_group group;
 	struct config_group primary_epc_group;
 	struct config_group secondary_epc_group;
-	struct delayed_work cfs_work;
 	struct pci_epf *epf;
 	int index;
 };
@@ -103,7 +102,7 @@ static struct config_group
 	secondary_epc_group = &epf_group->secondary_epc_group;
 	config_group_init_type_name(secondary_epc_group, "secondary",
 				    &pci_secondary_epc_type);
-	configfs_register_group(&epf_group->group, secondary_epc_group);
+	configfs_add_default_group(secondary_epc_group, &epf_group->group);
 
 	return secondary_epc_group;
 }
@@ -166,7 +165,7 @@ static struct config_group
 
 	config_group_init_type_name(primary_epc_group, "primary",
 				    &pci_primary_epc_type);
-	configfs_register_group(&epf_group->group, primary_epc_group);
+	configfs_add_default_group(primary_epc_group, &epf_group->group);
 
 	return primary_epc_group;
 }
@@ -570,15 +569,13 @@ static void pci_ep_cfs_add_type_group(struct pci_epf_group *epf_group)
 		return;
 	}
 
-	configfs_register_group(&epf_group->group, group);
+	configfs_add_default_group(group, &epf_group->group);
 }
 
-static void pci_epf_cfs_work(struct work_struct *work)
+static void pci_epf_cfs_add_sub_groups(struct pci_epf_group *epf_group)
 {
-	struct pci_epf_group *epf_group;
 	struct config_group *group;
 
-	epf_group = container_of(work, struct pci_epf_group, cfs_work.work);
 	group = pci_ep_cfs_add_primary_group(epf_group);
 	if (IS_ERR(group)) {
 		pr_err("failed to create 'primary' EPC interface\n");
@@ -637,9 +634,7 @@ static struct config_group *pci_epf_make(struct config_group *group,
 
 	kfree(epf_name);
 
-	INIT_DELAYED_WORK(&epf_group->cfs_work, pci_epf_cfs_work);
-	queue_delayed_work(system_wq, &epf_group->cfs_work,
-			   msecs_to_jiffies(1));
+	pci_epf_cfs_add_sub_groups(epf_group);
 
 	return &epf_group->group;
 
diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index d2bddca7045a..4cef9a349343 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3356,9 +3356,6 @@ void qla_fab_scan_finish(scsi_qla_host_t *vha, srb_t *sp)
 			    atomic_read(&fcport->state) == FCS_ONLINE) ||
 				do_delete) {
 				if (fcport->loop_id != FC_NO_LOOP_ID) {
-					if (fcport->flags & FCF_FCP2_DEVICE)
-						continue;
-
 					ql_log(ql_log_warn, vha, 0x20f0,
 					       "%s %d %8phC post del sess\n",
 					       __func__, __LINE__,
@@ -3625,8 +3622,8 @@ int qla_fab_async_scan(scsi_qla_host_t *vha, srb_t *sp)
 	if (vha->scan.scan_flags & SF_SCANNING) {
 		spin_unlock_irqrestore(&vha->work_lock, flags);
 		ql_dbg(ql_dbg_disc + ql_dbg_verbose, vha, 0x2012,
-		    "%s: scan active\n", __func__);
-		return rval;
+		    "%s: scan active for sp:%p\n", __func__, sp);
+		goto done_free_sp;
 	}
 	vha->scan.scan_flags |= SF_SCANNING;
 	if (!sp)
@@ -3791,23 +3788,25 @@ int qla_fab_async_scan(scsi_qla_host_t *vha, srb_t *sp)
 	return rval;
 
 done_free_sp:
-	if (sp->u.iocb_cmd.u.ctarg.req) {
-		dma_free_coherent(&vha->hw->pdev->dev,
-		    sp->u.iocb_cmd.u.ctarg.req_allocated_size,
-		    sp->u.iocb_cmd.u.ctarg.req,
-		    sp->u.iocb_cmd.u.ctarg.req_dma);
-		sp->u.iocb_cmd.u.ctarg.req = NULL;
-	}
-	if (sp->u.iocb_cmd.u.ctarg.rsp) {
-		dma_free_coherent(&vha->hw->pdev->dev,
-		    sp->u.iocb_cmd.u.ctarg.rsp_allocated_size,
-		    sp->u.iocb_cmd.u.ctarg.rsp,
-		    sp->u.iocb_cmd.u.ctarg.rsp_dma);
-		sp->u.iocb_cmd.u.ctarg.rsp = NULL;
-	}
+	if (sp) {
+		if (sp->u.iocb_cmd.u.ctarg.req) {
+			dma_free_coherent(&vha->hw->pdev->dev,
+			    sp->u.iocb_cmd.u.ctarg.req_allocated_size,
+			    sp->u.iocb_cmd.u.ctarg.req,
+			    sp->u.iocb_cmd.u.ctarg.req_dma);
+			sp->u.iocb_cmd.u.ctarg.req = NULL;
+		}
+		if (sp->u.iocb_cmd.u.ctarg.rsp) {
+			dma_free_coherent(&vha->hw->pdev->dev,
+			    sp->u.iocb_cmd.u.ctarg.rsp_allocated_size,
+			    sp->u.iocb_cmd.u.ctarg.rsp,
+			    sp->u.iocb_cmd.u.ctarg.rsp_dma);
+			sp->u.iocb_cmd.u.ctarg.rsp = NULL;
+		}
 
-	/* ref: INIT */
-	kref_put(&sp->cmd_kref, qla2x00_sp_release);
+		/* ref: INIT */
+		kref_put(&sp->cmd_kref, qla2x00_sp_release);
+	}
 
 	spin_lock_irqsave(&vha->work_lock, flags);
 	vha->scan.scan_flags &= ~SF_SCANNING;
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 8bd4aa935e22..2ab1cecda8c7 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1859,15 +1859,6 @@ void qla2x00_handle_rscn(scsi_qla_host_t *vha, struct event_arg *ea)
 	case RSCN_PORT_ADDR:
 		fcport = qla2x00_find_fcport_by_nportid(vha, &ea->id, 1);
 		if (fcport) {
-			if (ql2xfc2target &&
-			    fcport->flags & FCF_FCP2_DEVICE &&
-			    atomic_read(&fcport->state) == FCS_ONLINE) {
-				ql_dbg(ql_dbg_disc, vha, 0x2115,
-				       "Delaying session delete for FCP2 portid=%06x %8phC ",
-					fcport->d_id.b24, fcport->port_name);
-				return;
-			}
-
 			if (vha->hw->flags.edif_enabled && DBELL_ACTIVE(vha)) {
 				/*
 				 * On ipsec start by remote port, Target port
@@ -2471,8 +2462,23 @@ qla24xx_handle_plogi_done_event(struct scsi_qla_host *vha, struct event_arg *ea)
 	    ea->sp->gen1, fcport->rscn_gen,
 	    ea->data[0], ea->data[1], ea->iop[0], ea->iop[1]);
 
-	if ((fcport->fw_login_state == DSC_LS_PLOGI_PEND) ||
-	    (fcport->fw_login_state == DSC_LS_PRLI_PEND)) {
+	if (fcport->fw_login_state == DSC_LS_PLOGI_PEND) {
+		ql_dbg(ql_dbg_disc, vha, 0x20ea,
+		    "%s %d %8phC Remote is trying to login\n",
+		    __func__, __LINE__, fcport->port_name);
+		/*
+		 * If we get here, there is port thats already logged in,
+		 * but it's state has not moved ahead. Recheck with FW on
+		 * what state it is in and proceed ahead
+		 */
+		if (!N2N_TOPO(vha->hw)) {
+			fcport->fw_login_state = DSC_LS_PRLI_COMP;
+			qla24xx_post_gpdb_work(vha, fcport, 0);
+		}
+		return;
+	}
+
+	if (fcport->fw_login_state == DSC_LS_PRLI_PEND) {
 		ql_dbg(ql_dbg_disc, vha, 0x20ea,
 		    "%s %d %8phC Remote is trying to login\n",
 		    __func__, __LINE__, fcport->port_name);
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index a1c5ef569f9d..07b08119af0b 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -1676,13 +1676,28 @@ qla2x00_async_event(scsi_qla_host_t *vha, struct rsp_que *rsp, uint16_t *mb)
 
 			/* Port logout */
 			fcport = qla2x00_find_fcport_by_loopid(vha, mb[1]);
-			if (!fcport)
+			if (!fcport) {
+				ql_dbg(ql_dbg_async, vha, 0x5011,
+					"Could not find fcport:%04x %04x %04x\n",
+					mb[1], mb[2], mb[3]);
 				break;
-			if (atomic_read(&fcport->state) != FCS_ONLINE)
+			}
+
+			if (atomic_read(&fcport->state) != FCS_ONLINE) {
+				ql_dbg(ql_dbg_async, vha, 0x5012,
+					"Port state is not online State:0x%x \n",
+					atomic_read(&fcport->state));
+				ql_dbg(ql_dbg_async, vha, 0x5012,
+					"Scheduling session for deletion \n");
+				fcport->logout_on_delete = 0;
+				qlt_schedule_sess_for_deletion(fcport);
 				break;
+			}
+
 			ql_dbg(ql_dbg_async, vha, 0x508a,
 			    "Marking port lost loopid=%04x portid=%06x.\n",
 			    fcport->loop_id, fcport->d_id.b24);
+
 			if (qla_ini_mode_enabled(vha)) {
 				fcport->logout_on_delete = 0;
 				qlt_schedule_sess_for_deletion(fcport);
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 8d3bade03fdc..b8631698e262 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1194,7 +1194,8 @@ qla2x00_wait_for_hba_ready(scsi_qla_host_t *vha)
 	while ((qla2x00_reset_active(vha) || ha->dpc_active ||
 		ha->flags.mbox_busy) ||
 	       test_bit(FX00_RESET_RECOVERY, &vha->dpc_flags) ||
-	       test_bit(FX00_TARGET_SCAN, &vha->dpc_flags)) {
+	       test_bit(FX00_TARGET_SCAN, &vha->dpc_flags) ||
+	       (vha->scan.scan_flags & SF_SCANNING)) {
 		if (test_bit(UNLOADING, &base_vha->dpc_flags))
 			break;
 		msleep(1000);
diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index c865a7a61030..990defcf9304 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -10,6 +10,7 @@ struct erofs_fileio_rq {
 	struct bio bio;
 	struct kiocb iocb;
 	struct super_block *sb;
+	refcount_t ref;
 };
 
 struct erofs_fileio {
@@ -42,7 +43,8 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 		}
 	}
 	bio_uninit(&rq->bio);
-	kfree(rq);
+	if (refcount_dec_and_test(&rq->ref))
+		kfree(rq);
 }
 
 static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
@@ -63,6 +65,8 @@ static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
 	ret = vfs_iocb_iter_read(rq->iocb.ki_filp, &rq->iocb, &iter);
 	if (ret != -EIOCBQUEUED)
 		erofs_fileio_ki_complete(&rq->iocb, ret);
+	if (refcount_dec_and_test(&rq->ref))
+		kfree(rq);
 }
 
 static struct erofs_fileio_rq *erofs_fileio_rq_alloc(struct erofs_map_dev *mdev)
@@ -73,6 +77,7 @@ static struct erofs_fileio_rq *erofs_fileio_rq_alloc(struct erofs_map_dev *mdev)
 	bio_init(&rq->bio, NULL, rq->bvecs, BIO_MAX_VECS, REQ_OP_READ);
 	rq->iocb.ki_filp = mdev->m_dif->file;
 	rq->sb = mdev->m_sb;
+	refcount_set(&rq->ref, 2);
 	return rq;
 }
 
diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
index eea5a6a12f7b..bd45c53163b0 100644
--- a/fs/nilfs2/sufile.c
+++ b/fs/nilfs2/sufile.c
@@ -1106,6 +1106,9 @@ int nilfs_sufile_trim_fs(struct inode *sufile, struct fstrim_range *range)
 	else
 		end_block = start_block + len - 1;
 
+	if (end_block < nilfs->ns_first_data_block)
+		goto out;
+
 	segnum = nilfs_get_segnum_of_block(nilfs, start_block);
 	segnum_end = nilfs_get_segnum_of_block(nilfs, end_block);
 
@@ -1203,6 +1206,7 @@ int nilfs_sufile_trim_fs(struct inode *sufile, struct fstrim_range *range)
 out_sem:
 	up_read(&NILFS_MDT(sufile)->mi_sem);
 
+out:
 	range->len = ndiscarded << nilfs->ns_blocksize_bits;
 	return ret;
 }
diff --git a/fs/smb/client/cached_dir.h b/fs/smb/client/cached_dir.h
index bc8a812ff95f..96697c78b3a6 100644
--- a/fs/smb/client/cached_dir.h
+++ b/fs/smb/client/cached_dir.h
@@ -34,10 +34,10 @@ struct cached_fid {
 	struct list_head entry;
 	struct cached_fids *cfids;
 	const char *path;
-	bool has_lease:1;
-	bool is_open:1;
-	bool on_list:1;
-	bool file_all_info_is_valid:1;
+	bool has_lease;
+	bool is_open;
+	bool on_list;
+	bool file_all_info_is_valid;
 	unsigned long time; /* jiffies of when lease was taken */
 	struct kref refcount;
 	struct cifs_fid fid;
diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index ab533c602987..73a07758f97a 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -126,21 +126,21 @@ static int __process_request(struct ksmbd_work *work, struct ksmbd_conn *conn,
 andx_again:
 	if (command >= conn->max_cmds) {
 		conn->ops->set_rsp_status(work, STATUS_INVALID_PARAMETER);
-		return SERVER_HANDLER_CONTINUE;
+		return SERVER_HANDLER_ABORT;
 	}
 
 	cmds = &conn->cmds[command];
 	if (!cmds->proc) {
 		ksmbd_debug(SMB, "*** not implemented yet cmd = %x\n", command);
 		conn->ops->set_rsp_status(work, STATUS_NOT_IMPLEMENTED);
-		return SERVER_HANDLER_CONTINUE;
+		return SERVER_HANDLER_ABORT;
 	}
 
 	if (work->sess && conn->ops->is_sign_req(work, command)) {
 		ret = conn->ops->check_sign_req(work);
 		if (!ret) {
 			conn->ops->set_rsp_status(work, STATUS_ACCESS_DENIED);
-			return SERVER_HANDLER_CONTINUE;
+			return SERVER_HANDLER_ABORT;
 		}
 	}
 
diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index 0ef17d070711..9ad9b50bf93e 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -41,6 +41,7 @@ static const struct ksmbd_transport_ops ksmbd_tcp_transport_ops;
 
 static void tcp_stop_kthread(struct task_struct *kthread);
 static struct interface *alloc_iface(char *ifname);
+static void ksmbd_tcp_disconnect(struct ksmbd_transport *t);
 
 #define KSMBD_TRANS(t)	(&(t)->transport)
 #define TCP_TRANS(t)	((struct tcp_transport *)container_of(t, \
@@ -219,7 +220,7 @@ static int ksmbd_tcp_new_connection(struct socket *client_sk)
 	if (IS_ERR(handler)) {
 		pr_err("cannot start conn thread\n");
 		rc = PTR_ERR(handler);
-		free_transport(t);
+		ksmbd_tcp_disconnect(KSMBD_TRANS(t));
 	}
 	return rc;
 
diff --git a/fs/xfs/scrub/btree.c b/fs/xfs/scrub/btree.c
index fe678a0438bc..b8d5a02334b8 100644
--- a/fs/xfs/scrub/btree.c
+++ b/fs/xfs/scrub/btree.c
@@ -370,12 +370,15 @@ xchk_btree_check_block_owner(
 {
 	xfs_agnumber_t		agno;
 	xfs_agblock_t		agbno;
+	bool			is_bnobt, is_rmapbt;
 	bool			init_sa;
 	int			error = 0;
 
 	if (!bs->cur)
 		return 0;
 
+	is_bnobt = xfs_btree_is_bno(bs->cur->bc_ops);
+	is_rmapbt = xfs_btree_is_rmap(bs->cur->bc_ops);
 	agno = xfs_daddr_to_agno(bs->cur->bc_mp, daddr);
 	agbno = xfs_daddr_to_agbno(bs->cur->bc_mp, daddr);
 
@@ -398,11 +401,11 @@ xchk_btree_check_block_owner(
 	 * have to nullify it (to shut down further block owner checks) if
 	 * self-xref encounters problems.
 	 */
-	if (!bs->sc->sa.bno_cur && xfs_btree_is_bno(bs->cur->bc_ops))
+	if (!bs->sc->sa.bno_cur && is_bnobt)
 		bs->cur = NULL;
 
 	xchk_xref_is_only_owned_by(bs->sc, agbno, 1, bs->oinfo);
-	if (!bs->sc->sa.rmap_cur && xfs_btree_is_rmap(bs->cur->bc_ops))
+	if (!bs->sc->sa.rmap_cur && is_rmapbt)
 		bs->cur = NULL;
 
 out_free:
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0b4ab3c816da..864c26e22b24 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1811,16 +1811,26 @@ static void __reset_counters(struct pm_nl_pernet *pernet)
 int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
-	LIST_HEAD(free_list);
+	struct list_head free_list;
 
 	spin_lock_bh(&pernet->lock);
-	list_splice_init(&pernet->local_addr_list, &free_list);
+	free_list = pernet->local_addr_list;
+	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
 	__reset_counters(pernet);
 	pernet->next_id = 1;
 	bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	spin_unlock_bh(&pernet->lock);
-	mptcp_nl_flush_addrs_list(sock_net(skb->sk), &free_list);
+
+	if (free_list.next == &pernet->local_addr_list)
+		return 0;
+
 	synchronize_rcu();
+
+	/* Adjust the pointers to free_list instead of pernet->local_addr_list */
+	free_list.prev->next = &free_list;
+	free_list.next->prev = &free_list;
+
+	mptcp_nl_flush_addrs_list(sock_net(skb->sk), &free_list);
 	__flush_addrs(&free_list);
 	return 0;
 }

