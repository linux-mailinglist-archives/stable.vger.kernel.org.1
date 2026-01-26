Return-Path: <stable+bounces-211641-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PbyBX2Nd2m9hgEAu9opvQ
	(envelope-from <stable+bounces-211641-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 16:51:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C258A536
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 16:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 19D1530058CD
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 15:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3699F33F395;
	Mon, 26 Jan 2026 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxRy49aY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE46033E35D
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769442682; cv=none; b=F0qkGBR1W17rfHcqNsALxYeeC7O4qHLm9c+ikcxXFmMjnP2jNtjhCVGdTgSLchgLSeUf/xLbYmhV6DuR81D0fPbHs38wa5uyvLjk0XxQcsfh2wfZUJ7VNdU4XS1ILuzZ/9Z4eYYFGaDAOKgnaGeMKYAWb7IRD/bbHFAxuedpFHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769442682; c=relaxed/simple;
	bh=gJ7SM4K9W7j5FZY8g/sfylxEsxv8//8M0csmuqIGxaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jul2G8dhQLP3VbGTSAWWI0bgXwtwaob3fJ9s07BBcLMb5BdDfchjxu2eK6q1I8YPhuWzhqLbD+MceemZ/lncT2JNoQFkIOtlL6ZGZuUkSLrua3K5/pXz/ALQbClt7MnFmOy6iPVTTpkyqtkl52Sr9tSE3n1Q4crvndXArbH7lW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxRy49aY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E8DC116C6;
	Mon, 26 Jan 2026 15:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769442681;
	bh=gJ7SM4K9W7j5FZY8g/sfylxEsxv8//8M0csmuqIGxaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jxRy49aYnHTfTCgC9s/I98vmY1ExFNtnsYJYxPzKxm38TNqyAA8r9TRuWrGzlLkxF
	 Mla/Hr5nasSd2JwO4kesRIGLCgqd8g1b0OyD41wYwC24HQp/CV1kRuZW4QLdNEutd5
	 O1mYzOOMjeLU0Vz4DY7/IQd8uj85Kvkyde2v6U+6bdSYA2oJvCwjmQAjur0HhWNf60
	 u7diyv3FjIGcHtDvOEooKoRLu7UaQ1XZ4nDIprOfuhyrR4ohcK0o7DIRj/9mh4cMI3
	 JmetgQlu0uAzP0NrrZ67t1EwaLVngg3oQZ2YGF4rmkBfmB18XoVRnKp83aw8rxMQNj
	 HALvxwQ1W5Htw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dawei Li <set_pte_at@outlook.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] xen: make remove callback of xen driver void returned
Date: Mon, 26 Jan 2026 10:51:18 -0500
Message-ID: <20260126155119.3323199-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012625-perky-unquote-b3a5@gregkh>
References: <2026012625-perky-unquote-b3a5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[outlook.com,suse.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211641-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:email,suse.com:email]
X-Rspamd-Queue-Id: A8C258A536
X-Rspamd-Action: no action

From: Dawei Li <set_pte_at@outlook.com>

[ Upstream commit 7cffcade57a429667447c4f41d8414bbcf1b3aaa ]

Since commit fc7a6209d571 ("bus: Make remove callback return void")
forces bus_type::remove be void-returned, it doesn't make much sense for
any bus based driver implementing remove callbalk to return non-void to
its caller.

This change is for xen bus based drivers.

Acked-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Dawei Li <set_pte_at@outlook.com>
Link: https://lore.kernel.org/r/TYCP286MB23238119AB4DF190997075C9CAE39@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
Signed-off-by: Juergen Gross <jgross@suse.com>
Stable-dep-of: 901a5f309dab ("scsi: xen: scsiback: Fix potential memory leak in scsiback_remove()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/xen-blkback/xenbus.c  | 4 +---
 drivers/block/xen-blkfront.c        | 3 +--
 drivers/char/tpm/xen-tpmfront.c     | 3 +--
 drivers/gpu/drm/xen/xen_drm_front.c | 3 +--
 drivers/input/misc/xen-kbdfront.c   | 5 ++---
 drivers/net/xen-netback/xenbus.c    | 3 +--
 drivers/net/xen-netfront.c          | 4 +---
 drivers/pci/xen-pcifront.c          | 4 +---
 drivers/scsi/xen-scsifront.c        | 4 +---
 drivers/tty/hvc/hvc_xen.c           | 4 ++--
 drivers/usb/host/xen-hcd.c          | 4 +---
 drivers/video/fbdev/xen-fbfront.c   | 6 ++----
 drivers/xen/pvcalls-back.c          | 3 +--
 drivers/xen/pvcalls-front.c         | 3 +--
 drivers/xen/xen-pciback/xenbus.c    | 4 +---
 drivers/xen/xen-scsiback.c          | 4 +---
 include/xen/xenbus.h                | 2 +-
 net/9p/trans_xen.c                  | 3 +--
 sound/xen/xen_snd_front.c           | 3 +--
 19 files changed, 22 insertions(+), 47 deletions(-)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index c0227dfa46887..4807af1d58059 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -524,7 +524,7 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 	return 0;
 }
 
-static int xen_blkbk_remove(struct xenbus_device *dev)
+static void xen_blkbk_remove(struct xenbus_device *dev)
 {
 	struct backend_info *be = dev_get_drvdata(&dev->dev);
 
@@ -547,8 +547,6 @@ static int xen_blkbk_remove(struct xenbus_device *dev)
 		/* Put the reference we set in xen_blkif_alloc(). */
 		xen_blkif_put(be->blkif);
 	}
-
-	return 0;
 }
 
 int xen_blkbk_flush_diskcache(struct xenbus_transaction xbt,
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 5ddf393aa390f..8f91c48cbd37f 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2469,7 +2469,7 @@ static void blkback_changed(struct xenbus_device *dev,
 	}
 }
 
-static int blkfront_remove(struct xenbus_device *xbdev)
+static void blkfront_remove(struct xenbus_device *xbdev)
 {
 	struct blkfront_info *info = dev_get_drvdata(&xbdev->dev);
 
@@ -2490,7 +2490,6 @@ static int blkfront_remove(struct xenbus_device *xbdev)
 	}
 
 	kfree(info);
-	return 0;
 }
 
 static int blkfront_is_ready(struct xenbus_device *dev)
diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
index 3792918262617..80cca3b83b226 100644
--- a/drivers/char/tpm/xen-tpmfront.c
+++ b/drivers/char/tpm/xen-tpmfront.c
@@ -360,14 +360,13 @@ static int tpmfront_probe(struct xenbus_device *dev,
 	return tpm_chip_register(priv->chip);
 }
 
-static int tpmfront_remove(struct xenbus_device *dev)
+static void tpmfront_remove(struct xenbus_device *dev)
 {
 	struct tpm_chip *chip = dev_get_drvdata(&dev->dev);
 	struct tpm_private *priv = dev_get_drvdata(&chip->dev);
 	tpm_chip_unregister(chip);
 	ring_free(priv);
 	dev_set_drvdata(&chip->dev, NULL);
-	return 0;
 }
 
 static int tpmfront_resume(struct xenbus_device *dev)
diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
index 0d8e6bd1ccbf2..90996c108146d 100644
--- a/drivers/gpu/drm/xen/xen_drm_front.c
+++ b/drivers/gpu/drm/xen/xen_drm_front.c
@@ -717,7 +717,7 @@ static int xen_drv_probe(struct xenbus_device *xb_dev,
 	return xenbus_switch_state(xb_dev, XenbusStateInitialising);
 }
 
-static int xen_drv_remove(struct xenbus_device *dev)
+static void xen_drv_remove(struct xenbus_device *dev)
 {
 	struct xen_drm_front_info *front_info = dev_get_drvdata(&dev->dev);
 	int to = 100;
@@ -751,7 +751,6 @@ static int xen_drv_remove(struct xenbus_device *dev)
 
 	xen_drm_drv_fini(front_info);
 	xenbus_frontend_closed(dev);
-	return 0;
 }
 
 static const struct xenbus_device_id xen_driver_ids[] = {
diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
index 8d8ebdc2039b8..67f1c7364c95d 100644
--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -51,7 +51,7 @@ module_param_array(ptr_size, int, NULL, 0444);
 MODULE_PARM_DESC(ptr_size,
 	"Pointing device width, height in pixels (default 800,600)");
 
-static int xenkbd_remove(struct xenbus_device *);
+static void xenkbd_remove(struct xenbus_device *);
 static int xenkbd_connect_backend(struct xenbus_device *, struct xenkbd_info *);
 static void xenkbd_disconnect_backend(struct xenkbd_info *);
 
@@ -404,7 +404,7 @@ static int xenkbd_resume(struct xenbus_device *dev)
 	return xenkbd_connect_backend(dev, info);
 }
 
-static int xenkbd_remove(struct xenbus_device *dev)
+static void xenkbd_remove(struct xenbus_device *dev)
 {
 	struct xenkbd_info *info = dev_get_drvdata(&dev->dev);
 
@@ -417,7 +417,6 @@ static int xenkbd_remove(struct xenbus_device *dev)
 		input_unregister_device(info->mtouch);
 	free_page((unsigned long)info->page);
 	kfree(info);
-	return 0;
 }
 
 static int xenkbd_connect_backend(struct xenbus_device *dev,
diff --git a/drivers/net/xen-netback/xenbus.c b/drivers/net/xen-netback/xenbus.c
index c1ba4294f3647..001636901ddae 100644
--- a/drivers/net/xen-netback/xenbus.c
+++ b/drivers/net/xen-netback/xenbus.c
@@ -977,7 +977,7 @@ static int read_xenbus_vif_flags(struct backend_info *be)
 	return 0;
 }
 
-static int netback_remove(struct xenbus_device *dev)
+static void netback_remove(struct xenbus_device *dev)
 {
 	struct backend_info *be = dev_get_drvdata(&dev->dev);
 
@@ -992,7 +992,6 @@ static int netback_remove(struct xenbus_device *dev)
 	kfree(be->hotplug_script);
 	kfree(be);
 	dev_set_drvdata(&dev->dev, NULL);
-	return 0;
 }
 
 /*
diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 74925e1664626..dd40e0d98d7e7 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -2652,7 +2652,7 @@ static void xennet_bus_close(struct xenbus_device *dev)
 	} while (!ret);
 }
 
-static int xennet_remove(struct xenbus_device *dev)
+static void xennet_remove(struct xenbus_device *dev)
 {
 	struct netfront_info *info = dev_get_drvdata(&dev->dev);
 
@@ -2668,8 +2668,6 @@ static int xennet_remove(struct xenbus_device *dev)
 		rtnl_unlock();
 	}
 	xennet_free_netdev(info->netdev);
-
-	return 0;
 }
 
 static const struct xenbus_device_id netfront_ids[] = {
diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 7378e2f3e525f..fcd029ca2eb18 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -1055,14 +1055,12 @@ static int pcifront_xenbus_probe(struct xenbus_device *xdev,
 	return err;
 }
 
-static int pcifront_xenbus_remove(struct xenbus_device *xdev)
+static void pcifront_xenbus_remove(struct xenbus_device *xdev)
 {
 	struct pcifront_device *pdev = dev_get_drvdata(&xdev->dev);
 
 	if (pdev)
 		free_pdev(pdev);
-
-	return 0;
 }
 
 static const struct xenbus_device_id xenpci_ids[] = {
diff --git a/drivers/scsi/xen-scsifront.c b/drivers/scsi/xen-scsifront.c
index 66b316d173b0b..71a3bb83984c0 100644
--- a/drivers/scsi/xen-scsifront.c
+++ b/drivers/scsi/xen-scsifront.c
@@ -995,7 +995,7 @@ static int scsifront_suspend(struct xenbus_device *dev)
 	return err;
 }
 
-static int scsifront_remove(struct xenbus_device *dev)
+static void scsifront_remove(struct xenbus_device *dev)
 {
 	struct vscsifrnt_info *info = dev_get_drvdata(&dev->dev);
 
@@ -1011,8 +1011,6 @@ static int scsifront_remove(struct xenbus_device *dev)
 
 	scsifront_free_ring(info);
 	scsi_host_put(info->host);
-
-	return 0;
 }
 
 static void scsifront_disconnect(struct vscsifrnt_info *info)
diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index 281bc83acfadd..34c01874f45be 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -420,9 +420,9 @@ static int xen_console_remove(struct xencons_info *info)
 	return 0;
 }
 
-static int xencons_remove(struct xenbus_device *dev)
+static void xencons_remove(struct xenbus_device *dev)
 {
-	return xen_console_remove(dev_get_drvdata(&dev->dev));
+	xen_console_remove(dev_get_drvdata(&dev->dev));
 }
 
 static int xencons_connect_backend(struct xenbus_device *dev,
diff --git a/drivers/usb/host/xen-hcd.c b/drivers/usb/host/xen-hcd.c
index de1b091583183..46fdab940092e 100644
--- a/drivers/usb/host/xen-hcd.c
+++ b/drivers/usb/host/xen-hcd.c
@@ -1530,15 +1530,13 @@ static void xenhcd_backend_changed(struct xenbus_device *dev,
 	}
 }
 
-static int xenhcd_remove(struct xenbus_device *dev)
+static void xenhcd_remove(struct xenbus_device *dev)
 {
 	struct xenhcd_info *info = dev_get_drvdata(&dev->dev);
 	struct usb_hcd *hcd = xenhcd_info_to_hcd(info);
 
 	xenhcd_destroy_rings(info);
 	usb_put_hcd(hcd);
-
-	return 0;
 }
 
 static int xenhcd_probe(struct xenbus_device *dev,
diff --git a/drivers/video/fbdev/xen-fbfront.c b/drivers/video/fbdev/xen-fbfront.c
index 4d2694d904aab..ae8a50ecdbd3a 100644
--- a/drivers/video/fbdev/xen-fbfront.c
+++ b/drivers/video/fbdev/xen-fbfront.c
@@ -67,7 +67,7 @@ MODULE_PARM_DESC(video,
 	"Video memory size in MB, width, height in pixels (default 2,800,600)");
 
 static void xenfb_make_preferred_console(void);
-static int xenfb_remove(struct xenbus_device *);
+static void xenfb_remove(struct xenbus_device *);
 static void xenfb_init_shared_page(struct xenfb_info *, struct fb_info *);
 static int xenfb_connect_backend(struct xenbus_device *, struct xenfb_info *);
 static void xenfb_disconnect_backend(struct xenfb_info *);
@@ -527,7 +527,7 @@ static int xenfb_resume(struct xenbus_device *dev)
 	return xenfb_connect_backend(dev, info);
 }
 
-static int xenfb_remove(struct xenbus_device *dev)
+static void xenfb_remove(struct xenbus_device *dev)
 {
 	struct xenfb_info *info = dev_get_drvdata(&dev->dev);
 
@@ -542,8 +542,6 @@ static int xenfb_remove(struct xenbus_device *dev)
 	vfree(info->gfns);
 	vfree(info->fb);
 	kfree(info);
-
-	return 0;
 }
 
 static unsigned long vmalloc_to_gfn(void *address)
diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index 0bff02ac0045c..c633ebcf11630 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -1180,9 +1180,8 @@ static void pvcalls_back_changed(struct xenbus_device *dev,
 	}
 }
 
-static int pvcalls_back_remove(struct xenbus_device *dev)
+static void pvcalls_back_remove(struct xenbus_device *dev)
 {
-	return 0;
 }
 
 static int pvcalls_back_uevent(struct xenbus_device *xdev,
diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
index 9b569278788a4..d5d589bda243d 100644
--- a/drivers/xen/pvcalls-front.c
+++ b/drivers/xen/pvcalls-front.c
@@ -1087,7 +1087,7 @@ static const struct xenbus_device_id pvcalls_front_ids[] = {
 	{ "" }
 };
 
-static int pvcalls_front_remove(struct xenbus_device *dev)
+static void pvcalls_front_remove(struct xenbus_device *dev)
 {
 	struct pvcalls_bedata *bedata;
 	struct sock_mapping *map = NULL, *n;
@@ -1123,7 +1123,6 @@ static int pvcalls_front_remove(struct xenbus_device *dev)
 	kfree(bedata->ring.sring);
 	kfree(bedata);
 	xenbus_switch_state(dev, XenbusStateClosed);
-	return 0;
 }
 
 static int pvcalls_front_probe(struct xenbus_device *dev,
diff --git a/drivers/xen/xen-pciback/xenbus.c b/drivers/xen/xen-pciback/xenbus.c
index d171091eec123..b11e401f1b1ee 100644
--- a/drivers/xen/xen-pciback/xenbus.c
+++ b/drivers/xen/xen-pciback/xenbus.c
@@ -716,14 +716,12 @@ static int xen_pcibk_xenbus_probe(struct xenbus_device *dev,
 	return err;
 }
 
-static int xen_pcibk_xenbus_remove(struct xenbus_device *dev)
+static void xen_pcibk_xenbus_remove(struct xenbus_device *dev)
 {
 	struct xen_pcibk_device *pdev = dev_get_drvdata(&dev->dev);
 
 	if (pdev != NULL)
 		free_pdev(pdev);
-
-	return 0;
 }
 
 static const struct xenbus_device_id xen_pcibk_ids[] = {
diff --git a/drivers/xen/xen-scsiback.c b/drivers/xen/xen-scsiback.c
index 6106ed93817d6..954188b0b858a 100644
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -1249,7 +1249,7 @@ static void scsiback_release_translation_entry(struct vscsibk_info *info)
 	spin_unlock_irqrestore(&info->v2p_lock, flags);
 }
 
-static int scsiback_remove(struct xenbus_device *dev)
+static void scsiback_remove(struct xenbus_device *dev)
 {
 	struct vscsibk_info *info = dev_get_drvdata(&dev->dev);
 
@@ -1261,8 +1261,6 @@ static int scsiback_remove(struct xenbus_device *dev)
 	gnttab_page_cache_shrink(&info->free_pages, 0);
 
 	dev_set_drvdata(&dev->dev, NULL);
-
-	return 0;
 }
 
 static int scsiback_probe(struct xenbus_device *dev,
diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index eaa932b99d8ac..ad4fb4eab753d 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -117,7 +117,7 @@ struct xenbus_driver {
 		     const struct xenbus_device_id *id);
 	void (*otherend_changed)(struct xenbus_device *dev,
 				 enum xenbus_state backend_state);
-	int (*remove)(struct xenbus_device *dev);
+	void (*remove)(struct xenbus_device *dev);
 	int (*suspend)(struct xenbus_device *dev);
 	int (*resume)(struct xenbus_device *dev);
 	int (*uevent)(struct xenbus_device *, struct kobj_uevent_env *);
diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index 4ad7e7a269ca0..36f432ca4cd54 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -307,13 +307,12 @@ static void xen_9pfs_front_free(struct xen_9pfs_front_priv *priv)
 	kfree(priv);
 }
 
-static int xen_9pfs_front_remove(struct xenbus_device *dev)
+static void xen_9pfs_front_remove(struct xenbus_device *dev)
 {
 	struct xen_9pfs_front_priv *priv = dev_get_drvdata(&dev->dev);
 
 	dev_set_drvdata(&dev->dev, NULL);
 	xen_9pfs_front_free(priv);
-	return 0;
 }
 
 static int xen_9pfs_front_alloc_dataring(struct xenbus_device *dev,
diff --git a/sound/xen/xen_snd_front.c b/sound/xen/xen_snd_front.c
index 4041748c12e51..b66e037710d0d 100644
--- a/sound/xen/xen_snd_front.c
+++ b/sound/xen/xen_snd_front.c
@@ -311,7 +311,7 @@ static int xen_drv_probe(struct xenbus_device *xb_dev,
 	return xenbus_switch_state(xb_dev, XenbusStateInitialising);
 }
 
-static int xen_drv_remove(struct xenbus_device *dev)
+static void xen_drv_remove(struct xenbus_device *dev)
 {
 	struct xen_snd_front_info *front_info = dev_get_drvdata(&dev->dev);
 	int to = 100;
@@ -345,7 +345,6 @@ static int xen_drv_remove(struct xenbus_device *dev)
 
 	xen_snd_drv_fini(front_info);
 	xenbus_frontend_closed(dev);
-	return 0;
 }
 
 static const struct xenbus_device_id xen_drv_ids[] = {
-- 
2.51.0


