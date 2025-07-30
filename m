Return-Path: <stable+bounces-165500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B67B15E42
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 12:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2438816DDF1
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 10:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A17B28003A;
	Wed, 30 Jul 2025 10:35:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4910E27F16C
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 10:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753871744; cv=none; b=k/RgG/kHqZ5315BEDTX8vnbhnoXWWTlsBAqSJ8o57t8AlNX/VFv4gcF1jV17D0J2R6JjA/65WRuchFZoSx/lHpLv0yEQAc8EOJmWFdwFwc24tVjF7xu0LFYh8cb5WN94MLKnEsVUQSOcJm6KlT6OWEV4qrjjouU3e1Mp8ZMaAHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753871744; c=relaxed/simple;
	bh=yu2TyOsV1vhFDHgv7NXnrPlhu6GvkW75RQ0Y5mvpUvc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hz0nSNv5pEoVu23iVsfm24YP06L2/+RJLrcLQ5loJeMHeicgHvbJxTxcj3kyYEfwIImEBifs6sGRdfj1pq3IPeYqUZ0qYYeRyigL/q+ClnTDiDY2n/DVColmrPKliKoYD3Kg+vAlwr5DzJn0beI7oAImnsGoDiJ37E9L8F/d8SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1753871736-1eb14e1c3ba0fd0001-OJig3u
Received: from ZXBJMBX03.zhaoxin.com (ZXBJMBX03.zhaoxin.com [10.29.252.7]) by mx2.zhaoxin.com with ESMTP id hcPawu27CI98KdNK (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 30 Jul 2025 18:35:36 +0800 (CST)
X-Barracuda-Envelope-From: WeitaoWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Wed, 30 Jul
 2025 18:35:36 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::cd37:5202:5b71:926f]) by
 ZXSHMBX1.zhaoxin.com ([fe80::cd37:5202:5b71:926f%7]) with mapi id
 15.01.2507.044; Wed, 30 Jul 2025 18:35:36 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
Received: from L440.Zhaoxin.com (10.29.8.21) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Wed, 30 Jul
 2025 15:27:27 +0800
From: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
To: <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
	<linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <WeitaoWang@zhaoxin.com>, <wwt8723@163.com>, <CobeChen@zhaoxin.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v3] usb:xhci:Fix slot_id resource race conflict
Date: Wed, 30 Jul 2025 23:27:12 +0800
X-ASG-Orig-Subj: [PATCH v3] usb:xhci:Fix slot_id resource race conflict
Message-ID: <20250730152715.8368-1-WeitaoWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 7/30/2025 6:35:35 PM
X-Barracuda-Connect: ZXBJMBX03.zhaoxin.com[10.29.252.7]
X-Barracuda-Start-Time: 1753871736
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 8727
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -1.60
X-Barracuda-Spam-Status: No, SCORE=-1.60 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=DATE_IN_FUTURE_03_06, DATE_IN_FUTURE_03_06_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.145034
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.01 DATE_IN_FUTURE_03_06   Date: is 3 to 6 hours after Received: date
	0.42 DATE_IN_FUTURE_03_06_2 DATE_IN_FUTURE_03_06_2

In such a scenario, device-A with slot_id equal to 1 is disconnecting
while device-B is enumerating, device-B will fail to enumerate in the
follow sequence.

1.[device-A] send disable slot command
2.[device-B] send enable slot command
3.[device-A] disable slot command completed and wakeup waiting thread
4.[device-B] enable slot command completed with slot_id equal to 1 and
wakeup waiting thread
5.[device-B] driver check this slot_id was used by someone(device-A) in
xhci_alloc_virt_device, this device fails to enumerate as this conflict
6.[device-A] xhci->devs[slot_id] set to NULL in xhci_free_virt_device

To fix driver's slot_id resources conflict, clear xhci->devs[slot_id] and
xhci->dcbba->dev_context_ptrs[slot_id] pointers in the interrupt context
when disable slot command completes successfully. Simultaneously, adjust
function xhci_free_virt_device to accurately handle device release.

Cc: stable@vger.kernel.org
Fixes: 7faac1953ed1 ("xhci: avoid race between disable slot command and hos=
t runtime suspend")
Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
---
v2->v3
 - When disable slot command completes successfully, only clear some
   strategic pointers instead of calling xhci_free_virt_device in the
   interrupt context.

 drivers/usb/host/xhci-hub.c  |  3 +--
 drivers/usb/host/xhci-mem.c  | 20 +++++++++-----------
 drivers/usb/host/xhci-ring.c |  9 +++++++--
 drivers/usb/host/xhci.c      | 21 ++++++++++++++-------
 drivers/usb/host/xhci.h      |  3 ++-
 5 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 92bb84f8132a..b3a59ce1b3f4 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -704,8 +704,7 @@ static int xhci_enter_test_mode(struct xhci_hcd *xhci,
 		if (!xhci->devs[i])
 			continue;
=20
-		retval =3D xhci_disable_slot(xhci, i);
-		xhci_free_virt_device(xhci, i);
+		retval =3D xhci_disable_and_free_slot(xhci, i);
 		if (retval)
 			xhci_err(xhci, "Failed to disable slot %d, %d. Enter test mode anyway\n=
",
 				 i, retval);
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 6680afa4f596..962b0c20b883 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -865,21 +865,18 @@ int xhci_alloc_tt_info(struct xhci_hcd *xhci,
  * will be manipulated by the configure endpoint, allocate device, or upda=
te
  * hub functions while this function is removing the TT entries from the l=
ist.
  */
-void xhci_free_virt_device(struct xhci_hcd *xhci, int slot_id)
+void xhci_free_virt_device(struct xhci_hcd *xhci, struct xhci_virt_device =
*dev,
+		int slot_id)
 {
-	struct xhci_virt_device *dev;
 	int i;
 	int old_active_eps =3D 0;
=20
 	/* Slot ID 0 is reserved */
-	if (slot_id =3D=3D 0 || !xhci->devs[slot_id])
+	if (slot_id =3D=3D 0 || !dev)
 		return;
=20
-	dev =3D xhci->devs[slot_id];
-
-	xhci->dcbaa->dev_context_ptrs[slot_id] =3D 0;
-	if (!dev)
-		return;
+	if (xhci->dcbaa->dev_context_ptrs[slot_id] =3D=3D cpu_to_le64(dev->out_ct=
x->dma))
+		xhci->dcbaa->dev_context_ptrs[slot_id] =3D 0;
=20
 	trace_xhci_free_virt_device(dev);
=20
@@ -920,8 +917,9 @@ void xhci_free_virt_device(struct xhci_hcd *xhci, int s=
lot_id)
 		dev->udev->slot_id =3D 0;
 	if (dev->rhub_port && dev->rhub_port->slot_id =3D=3D slot_id)
 		dev->rhub_port->slot_id =3D 0;
-	kfree(xhci->devs[slot_id]);
-	xhci->devs[slot_id] =3D NULL;
+	if (xhci->devs[slot_id] =3D=3D dev)
+		xhci->devs[slot_id] =3D NULL;
+	kfree(dev);
 }
=20
 /*
@@ -962,7 +960,7 @@ static void xhci_free_virt_devices_depth_first(struct x=
hci_hcd *xhci, int slot_i
 out:
 	/* we are now at a leaf device */
 	xhci_debugfs_remove_slot(xhci, slot_id);
-	xhci_free_virt_device(xhci, slot_id);
+	xhci_free_virt_device(xhci, vdev, slot_id);
 }
=20
 int xhci_alloc_virt_device(struct xhci_hcd *xhci, int slot_id,
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 94c9c9271658..7a440ec52ff6 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1589,7 +1589,8 @@ static void xhci_handle_cmd_enable_slot(int slot_id, =
struct xhci_command *comman
 		command->slot_id =3D 0;
 }
=20
-static void xhci_handle_cmd_disable_slot(struct xhci_hcd *xhci, int slot_i=
d)
+static void xhci_handle_cmd_disable_slot(struct xhci_hcd *xhci, int slot_i=
d,
+					u32 cmd_comp_code)
 {
 	struct xhci_virt_device *virt_dev;
 	struct xhci_slot_ctx *slot_ctx;
@@ -1604,6 +1605,10 @@ static void xhci_handle_cmd_disable_slot(struct xhci=
_hcd *xhci, int slot_id)
 	if (xhci->quirks & XHCI_EP_LIMIT_QUIRK)
 		/* Delete default control endpoint resources */
 		xhci_free_device_endpoint_resources(xhci, virt_dev, true);
+	if (cmd_comp_code =3D=3D COMP_SUCCESS) {
+		xhci->dcbaa->dev_context_ptrs[slot_id] =3D 0;
+		xhci->devs[slot_id] =3D NULL;
+	}
 }
=20
 static void xhci_handle_cmd_config_ep(struct xhci_hcd *xhci, int slot_id)
@@ -1853,7 +1858,7 @@ static void handle_cmd_completion(struct xhci_hcd *xh=
ci,
 		xhci_handle_cmd_enable_slot(slot_id, cmd, cmd_comp_code);
 		break;
 	case TRB_DISABLE_SLOT:
-		xhci_handle_cmd_disable_slot(xhci, slot_id);
+		xhci_handle_cmd_disable_slot(xhci, slot_id, cmd_comp_code);
 		break;
 	case TRB_CONFIG_EP:
 		if (!cmd->completion)
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 8a819e853288..b1419e3ec7f9 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3930,8 +3930,7 @@ static int xhci_discover_or_reset_device(struct usb_h=
cd *hcd,
 		 * Obtaining a new device slot to inform the xHCI host that
 		 * the USB device has been reset.
 		 */
-		ret =3D xhci_disable_slot(xhci, udev->slot_id);
-		xhci_free_virt_device(xhci, udev->slot_id);
+		ret =3D xhci_disable_and_free_slot(xhci, udev->slot_id);
 		if (!ret) {
 			ret =3D xhci_alloc_dev(hcd, udev);
 			if (ret =3D=3D 1)
@@ -4088,7 +4087,7 @@ static void xhci_free_dev(struct usb_hcd *hcd, struct=
 usb_device *udev)
 	xhci_disable_slot(xhci, udev->slot_id);
=20
 	spin_lock_irqsave(&xhci->lock, flags);
-	xhci_free_virt_device(xhci, udev->slot_id);
+	xhci_free_virt_device(xhci, virt_dev, udev->slot_id);
 	spin_unlock_irqrestore(&xhci->lock, flags);
=20
 }
@@ -4137,6 +4136,16 @@ int xhci_disable_slot(struct xhci_hcd *xhci, u32 slo=
t_id)
 	return 0;
 }
=20
+int xhci_disable_and_free_slot(struct xhci_hcd *xhci, u32 slot_id)
+{
+	struct xhci_virt_device *vdev =3D xhci->devs[slot_id];
+	int ret;
+
+	ret =3D xhci_disable_slot(xhci, slot_id);
+	xhci_free_virt_device(xhci, vdev, slot_id);
+	return ret;
+}
+
 /*
  * Checks if we have enough host controller resources for the default cont=
rol
  * endpoint.
@@ -4243,8 +4252,7 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_de=
vice *udev)
 	return 1;
=20
 disable_slot:
-	xhci_disable_slot(xhci, udev->slot_id);
-	xhci_free_virt_device(xhci, udev->slot_id);
+	xhci_disable_and_free_slot(xhci, udev->slot_id);
=20
 	return 0;
 }
@@ -4380,8 +4388,7 @@ static int xhci_setup_device(struct usb_hcd *hcd, str=
uct usb_device *udev,
 		dev_warn(&udev->dev, "Device not responding to setup %s.\n", act);
=20
 		mutex_unlock(&xhci->mutex);
-		ret =3D xhci_disable_slot(xhci, udev->slot_id);
-		xhci_free_virt_device(xhci, udev->slot_id);
+		ret =3D xhci_disable_and_free_slot(xhci, udev->slot_id);
 		if (!ret) {
 			if (xhci_alloc_dev(hcd, udev) =3D=3D 1)
 				xhci_setup_addressable_virt_dev(xhci, udev);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index a20f4e7cd43a..85d5b964bf1e 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1791,7 +1791,7 @@ void xhci_dbg_trace(struct xhci_hcd *xhci, void (*tra=
ce)(struct va_format *),
 /* xHCI memory management */
 void xhci_mem_cleanup(struct xhci_hcd *xhci);
 int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags);
-void xhci_free_virt_device(struct xhci_hcd *xhci, int slot_id);
+void xhci_free_virt_device(struct xhci_hcd *xhci, struct xhci_virt_device =
*dev, int slot_id);
 int xhci_alloc_virt_device(struct xhci_hcd *xhci, int slot_id, struct usb_=
device *udev, gfp_t flags);
 int xhci_setup_addressable_virt_dev(struct xhci_hcd *xhci, struct usb_devi=
ce *udev);
 void xhci_copy_ep0_dequeue_into_input_ctx(struct xhci_hcd *xhci,
@@ -1888,6 +1888,7 @@ void xhci_reset_bandwidth(struct usb_hcd *hcd, struct=
 usb_device *udev);
 int xhci_update_hub_device(struct usb_hcd *hcd, struct usb_device *hdev,
 			   struct usb_tt *tt, gfp_t mem_flags);
 int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id);
+int xhci_disable_and_free_slot(struct xhci_hcd *xhci, u32 slot_id);
 int xhci_ext_cap_init(struct xhci_hcd *xhci);
=20
 int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup);
--=20
2.32.0


