Return-Path: <stable+bounces-165050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 151A0B14C8B
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 12:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ECDA16D82C
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 10:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB78F28AB10;
	Tue, 29 Jul 2025 10:51:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DF72222A0
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753786270; cv=none; b=Khm4NRI8UTEp8safT9vG7dr0akYbZEaVeb9m5OfIanXKjzhjkt1HF9BeETqSfLMjJn0kWcND8YmvcNeKsxmb8HutlkkPE1CUu8W6hEV0vdUxILfAqKsJsKaM+aKVi8EtYhjuxAsHEsPw1PGCBkKUIAAXxN05nMx32gfKgPiAha0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753786270; c=relaxed/simple;
	bh=vafti5TpIetSDfHajnpON8YL7ZxwGais6YEkVkf5KO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P9wOwAMeyOdVlP/4chAzInqGXC+4B7cRFji684k1D8VLr01QEkMEtnrTVAV2fOj9f5powG7vFfZvMB+YJ0D8ariazoP4xjrAu5baMR+KtuTCQyUiy1eQtr8JbSeoHpCJFeB+BG+4pCmWuRcS5g6Bt8UBR0m4ygi5Q0AtWTFsczI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1753786256-1eb14e1c389ccb0001-OJig3u
Received: from zxbjmbx1.zhaoxin.com (zxbjmbx1.zhaoxin.com [10.29.252.163]) by mx2.zhaoxin.com with ESMTP id RPJgeZXeIcPXFp6F (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 29 Jul 2025 18:50:56 +0800 (CST)
X-Barracuda-Envelope-From: WeitaoWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Tue, 29 Jul
 2025 18:50:55 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::cd37:5202:5b71:926f]) by
 ZXSHMBX1.zhaoxin.com ([fe80::cd37:5202:5b71:926f%7]) with mapi id
 15.01.2507.044; Tue, 29 Jul 2025 18:50:55 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
Received: from [10.29.8.21] (10.29.8.21) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Tue, 29 Jul
 2025 17:24:58 +0800
Message-ID: <dec32556-c28e-aeed-8516-2e0bb56c3a58@zhaoxin.com>
Date: Wed, 30 Jul 2025 01:25:00 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] usb:xhci:Fix slot_id resource race conflict
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH v2] usb:xhci:Fix slot_id resource race conflict
To: Mathias Nyman <mathias.nyman@linux.intel.com>,
	<gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
	<linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <WeitaoWang@zhaoxin.com>, <wwt8723@163.com>, <CobeChen@zhaoxin.com>,
	<stable@vger.kernel.org>
References: <20250725185101.8375-1-WeitaoWang-oc@zhaoxin.com>
 <094f9822-9f12-4c67-b648-84a48c2e154b@linux.intel.com>
From: "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
In-Reply-To: <094f9822-9f12-4c67-b648-84a48c2e154b@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 7/29/2025 6:50:48 PM
X-Barracuda-Connect: zxbjmbx1.zhaoxin.com[10.29.252.163]
X-Barracuda-Start-Time: 1753786256
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 10007
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: 1.09
X-Barracuda-Spam-Status: No, SCORE=1.09 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=DATE_IN_FUTURE_06_12, DATE_IN_FUTURE_06_12_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.144986
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.01 DATE_IN_FUTURE_06_12   Date: is 6 to 12 hours after Received: date
	3.10 DATE_IN_FUTURE_06_12_2 DATE_IN_FUTURE_06_12_2

On 2025/7/28 21:16, Mathias Nyman wrote:
>=20
> On 25.7.2025 21.51, Weitao Wang wrote:
>> In such a scenario, device-A with slot_id equal to 1 is disconnecting
>> while device-B is enumerating, device-B will fail to enumerate in the
>> follow sequence.
>>
>> 1.[device-A] send disable slot command
>> 2.[device-B] send enable slot command
>> 3.[device-A] disable slot command completed and wakeup waiting thread
>> 4.[device-B] enable slot command completed with slot_id equal to 1 and
>> wakeup waiting thread
>> 5.[device-B] driver check this slot_id was used by someone(device-A) in
>> xhci_alloc_virt_device, this device fails to enumerate as this conflict
>> 6.[device-A] xhci->devs[slot_id] set to NULL in xhci_free_virt_device
>>
>> To fix driver's slot_id resources conflict, let the xhci_free_virt_devic=
e
>> functionm call in the interrupt handler when disable slot command succes=
s.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 7faac1953ed1 ("xhci: avoid race between disable slot command and =
host runtime=20
>> suspend")
>> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
>=20
> Nice catch, good to get this fixed.
>=20
> This however has the downside of doing a lot in interrupt context.
>=20
> what if we only clear some strategic pointers in the interrupt context,
> and then do all the actual unmapping and endpoint ring segments freeing,
> contexts freeing ,etc later?
>=20
> Pseudocode:
>=20
> xhci_handle_cmd_disable_slot(xhci, slot_id, comp_code)
> {
>  =C2=A0=C2=A0=C2=A0 if (cmd_comp_code =3D=3D COMP_SUCCESS) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xhci->dcbaa->dev_context_ptrs=
[slot_id] =3D 0;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xhci->devs[slot_id] =3D NULL;
>  =C2=A0=C2=A0=C2=A0 }
> }
>=20
> xhci_disable_and_free_slot(xhci, slot_id)
> {
>  =C2=A0=C2=A0=C2=A0 struct xhci_virt_device *vdev =3D xhci->devs[slot_id]=
;
>=20
>  =C2=A0=C2=A0=C2=A0 xhci_disable_slot(xhci, slot_id);
>  =C2=A0=C2=A0=C2=A0 xhci_free_virt_device(xhci, vdev, slot_id);
> }
>=20
> xhci_free_virt_device(xhci, vdev, slot_id)
> {
>  =C2=A0=C2=A0=C2=A0 if (xhci->dcbaa->dev_context_ptrs[slot_id] =3D=3D vde=
v->out_ctx->dma)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xhci->dcbaa->dev_context_ptrs=
[slot_id] =3D 0;
>=20
>  =C2=A0=C2=A0=C2=A0 // free and unmap things just like before
>  =C2=A0=C2=A0=C2=A0 ...
>=20
>  =C2=A0=C2=A0=C2=A0 if (xhci->devs[slot_id] =3D=3D vdev)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xhci->devs[slot_id] =3D NULL;
>=20
>  =C2=A0=C2=A0=C2=A0 kfee(vdev);
> }

Hi Mathias,

Yes, your suggestion is a better revision, I made some modifications
to the patch which is listed below. Please help to review again.
Thanks for your help.

---
  drivers/usb/host/xhci-hub.c  |  3 +--
  drivers/usb/host/xhci-mem.c  | 21 ++++++++++-----------
  drivers/usb/host/xhci-ring.c |  9 +++++++--
  drivers/usb/host/xhci.c      | 23 ++++++++++++++++-------
  drivers/usb/host/xhci.h      |  3 ++-
  5 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 92bb84f8132a..b3a59ce1b3f4 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -704,8 +704,7 @@ static int xhci_enter_test_mode(struct xhci_hcd *xhci,
  		if (!xhci->devs[i])
  			continue;

-		retval =3D xhci_disable_slot(xhci, i);
-		xhci_free_virt_device(xhci, i);
+		retval =3D xhci_disable_and_free_slot(xhci, i);
  		if (retval)
  			xhci_err(xhci, "Failed to disable slot %d, %d. Enter test mode anyway\=
n",
  				 i, retval);
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 6680afa4f596..fc4aca2e65bc 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -865,21 +865,18 @@ int xhci_alloc_tt_info(struct xhci_hcd *xhci,
   * will be manipulated by the configure endpoint, allocate device, or upd=
ate
   * hub functions while this function is removing the TT entries from the =
list.
   */
-void xhci_free_virt_device(struct xhci_hcd *xhci, int slot_id)
+void xhci_free_virt_device(struct xhci_hcd *xhci, struct xhci_virt_device =
*dev,
+		int slot_id)
  {
-	struct xhci_virt_device *dev;
  	int i;
  	int old_active_eps =3D 0;

  	/* Slot ID 0 is reserved */
-	if (slot_id =3D=3D 0 || !xhci->devs[slot_id])
+	if (slot_id =3D=3D 0 || !dev)
  		return;

-	dev =3D xhci->devs[slot_id];
-
-	xhci->dcbaa->dev_context_ptrs[slot_id] =3D 0;
-	if (!dev)
-		return;
+	if (xhci->dcbaa->dev_context_ptrs[slot_id] =3D=3D dev->out_ctx->dma)
+		xhci->dcbaa->dev_context_ptrs[slot_id] =3D 0;

  	trace_xhci_free_virt_device(dev);

@@ -920,8 +917,10 @@ void xhci_free_virt_device(struct xhci_hcd *xhci, int =
slot_id)
  		dev->udev->slot_id =3D 0;
  	if (dev->rhub_port && dev->rhub_port->slot_id =3D=3D slot_id)
  		dev->rhub_port->slot_id =3D 0;
-	kfree(xhci->devs[slot_id]);
-	xhci->devs[slot_id] =3D NULL;
+	if (xhci->devs[slot_id] =3D=3D dev)
+		xhci->devs[slot_id] =3D NULL;
+	kfree(dev);
  }

  /*
@@ -962,7 +961,7 @@ static void xhci_free_virt_devices_depth_first(struct x=
hci_hcd *xhci,=20
int slot_i
  out:
  	/* we are now at a leaf device */
  	xhci_debugfs_remove_slot(xhci, slot_id);
-	xhci_free_virt_device(xhci, slot_id);
+	xhci_free_virt_device(xhci, vdev, slot_id);
  }

  int xhci_alloc_virt_device(struct xhci_hcd *xhci, int slot_id,
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 94c9c9271658..7a440ec52ff6 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1589,7 +1589,8 @@ static void xhci_handle_cmd_enable_slot(int slot_id, =
struct=20
xhci_command *comman
  		command->slot_id =3D 0;
  }

-static void xhci_handle_cmd_disable_slot(struct xhci_hcd *xhci, int slot_i=
d)
+static void xhci_handle_cmd_disable_slot(struct xhci_hcd *xhci, int slot_i=
d,
+					u32 cmd_comp_code)
  {
  	struct xhci_virt_device *virt_dev;
  	struct xhci_slot_ctx *slot_ctx;
@@ -1604,6 +1605,10 @@ static void xhci_handle_cmd_disable_slot(struct xhci=
_hcd *xhci, int=20
slot_id)
  	if (xhci->quirks & XHCI_EP_LIMIT_QUIRK)
  		/* Delete default control endpoint resources */
  		xhci_free_device_endpoint_resources(xhci, virt_dev, true);
+	if (cmd_comp_code =3D=3D COMP_SUCCESS) {
+		xhci->dcbaa->dev_context_ptrs[slot_id] =3D 0;
+		xhci->devs[slot_id] =3D NULL;
+	}
  }

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
index 8a819e853288..b3b39b2498f6 100644
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

  	spin_lock_irqsave(&xhci->lock, flags);
-	xhci_free_virt_device(xhci, udev->slot_id);
+	xhci_free_virt_device(xhci, virt_dev, udev->slot_id);
  	spin_unlock_irqrestore(&xhci->lock, flags);

  }
@@ -4137,6 +4136,18 @@ int xhci_disable_slot(struct xhci_hcd *xhci, u32 slo=
t_id)
  	return 0;
  }

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
   * Checks if we have enough host controller resources for the default con=
trol
   * endpoint.
@@ -4243,8 +4254,7 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_de=
vice *udev)
  	return 1;

  disable_slot:
-	xhci_disable_slot(xhci, udev->slot_id);
-	xhci_free_virt_device(xhci, udev->slot_id);
+	xhci_disable_and_free_slot(xhci, udev->slot_id);

  	return 0;
  }
@@ -4380,8 +4390,7 @@ static int xhci_setup_device(struct usb_hcd *hcd, str=
uct usb_device=20
*udev,
  		dev_warn(&udev->dev, "Device not responding to setup %s.\n", act);

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
ce)(struct=20
va_format *),
  /* xHCI memory management */
  void xhci_mem_cleanup(struct xhci_hcd *xhci);
  int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags);
-void xhci_free_virt_device(struct xhci_hcd *xhci, int slot_id);
+void xhci_free_virt_device(struct xhci_hcd *xhci, struct xhci_virt_device =
*dev, int slot_id);
  int xhci_alloc_virt_device(struct xhci_hcd *xhci, int slot_id, struct usb=
_device *udev,=20
gfp_t flags);
  int xhci_setup_addressable_virt_dev(struct xhci_hcd *xhci, struct usb_dev=
ice *udev);
  void xhci_copy_ep0_dequeue_into_input_ctx(struct xhci_hcd *xhci,
@@ -1888,6 +1888,7 @@ void xhci_reset_bandwidth(struct usb_hcd *hcd, struct=
 usb_device *udev);
  int xhci_update_hub_device(struct usb_hcd *hcd, struct usb_device *hdev,
  			   struct usb_tt *tt, gfp_t mem_flags);
  int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id);
+int xhci_disable_and_free_slot(struct xhci_hcd *xhci, u32 slot_id);
  int xhci_ext_cap_init(struct xhci_hcd *xhci);

  int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup);
--=20

Best Regards,
weitao

