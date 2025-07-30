Return-Path: <stable+bounces-165501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ADEB15E47
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 12:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5FE05A0896
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 10:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4342853F1;
	Wed, 30 Jul 2025 10:35:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D90D276058
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 10:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753871755; cv=none; b=TQZkziA/CXuayhl2Z3Bxy0ZJAgpwcMU5SzvdQxUEV45gU09OGGzImylmNHVZwuNc4Co4qN/eCBuJAQz6SntxX7p+vd0wlq7GBJxphDbisj0a03KU21YHQqV9giTOUgOLBKi/K1VrRugwjJC9oWpJnWn3Wcv2WNvJjlXrP/JJrv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753871755; c=relaxed/simple;
	bh=qweWPyKEs3pN6MuNg0KaCYdJj9vxUHHf8MFrmW68PPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GZOeyWvb/WdVWGaz1KiltVbet6MKUsfrD79BUvFxtNj5GFFkIbyJDNjY24AGZyXorC2mBPO9N67aLL6VMSfqoBkss9UTarODssA7WZ0Rd8B6+dyc3OjRD6YWoJhrfJY7ZjV23USPy3sNgQNV/Z76UUFaIoqBJX3/Xu+2ysg2f2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1753871743-086e23295483150001-OJig3u
Received: from ZXBJMBX02.zhaoxin.com (ZXBJMBX02.zhaoxin.com [10.29.252.6]) by mx1.zhaoxin.com with ESMTP id EoKJyGyVHCBkiczC (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 30 Jul 2025 18:35:43 +0800 (CST)
X-Barracuda-Envelope-From: WeitaoWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.6
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXBJMBX02.zhaoxin.com
 (10.29.252.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Wed, 30 Jul
 2025 18:35:36 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::cd37:5202:5b71:926f]) by
 ZXSHMBX1.zhaoxin.com ([fe80::cd37:5202:5b71:926f%7]) with mapi id
 15.01.2507.044; Wed, 30 Jul 2025 18:35:36 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.6
Received: from [10.29.8.21] (10.29.8.21) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Wed, 30 Jul
 2025 15:21:49 +0800
Message-ID: <683553fc-3874-0c31-d317-03b28dc3431e@zhaoxin.com>
Date: Wed, 30 Jul 2025 23:21:51 +0800
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
 <dec32556-c28e-aeed-8516-2e0bb56c3a58@zhaoxin.com>
 <855b4621-fc40-4281-9e44-7a2ac861dd4b@linux.intel.com>
From: "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
In-Reply-To: <855b4621-fc40-4281-9e44-7a2ac861dd4b@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 7/30/2025 6:35:34 PM
X-Barracuda-Connect: ZXBJMBX02.zhaoxin.com[10.29.252.6]
X-Barracuda-Start-Time: 1753871743
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 5302
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -1.60
X-Barracuda-Spam-Status: No, SCORE=-1.60 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=DATE_IN_FUTURE_03_06, DATE_IN_FUTURE_03_06_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.145035
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.01 DATE_IN_FUTURE_03_06   Date: is 3 to 6 hours after Received: date
	0.42 DATE_IN_FUTURE_03_06_2 DATE_IN_FUTURE_03_06_2

On 2025/7/29 23:00, Mathias Nyman wrote:
>=20
> On 29.7.2025 20.25, WeitaoWang-oc@zhaoxin.com wrote:
>> On 2025/7/28 21:16, Mathias Nyman wrote:
>>>
>>> On 25.7.2025 21.51, Weitao Wang wrote:
>>>> In such a scenario, device-A with slot_id equal to 1 is disconnecting
>>>> while device-B is enumerating, device-B will fail to enumerate in the
>>>> follow sequence.
>>>>
>>>> 1.[device-A] send disable slot command
>>>> 2.[device-B] send enable slot command
>>>> 3.[device-A] disable slot command completed and wakeup waiting thread
>>>> 4.[device-B] enable slot command completed with slot_id equal to 1 and
>>>> wakeup waiting thread
>>>> 5.[device-B] driver check this slot_id was used by someone(device-A) i=
n
>>>> xhci_alloc_virt_device, this device fails to enumerate as this conflic=
t
>>>> 6.[device-A] xhci->devs[slot_id] set to NULL in xhci_free_virt_device
>>>>
>>>> To fix driver's slot_id resources conflict, let the xhci_free_virt_dev=
ice
>>>> functionm call in the interrupt handler when disable slot command succ=
ess.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: 7faac1953ed1 ("xhci: avoid race between disable slot command an=
d host runtime=20
>>>> suspend")
>>>> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
>>>
>>> Nice catch, good to get this fixed.
>>>
>>> This however has the downside of doing a lot in interrupt context.
>>>
>>> what if we only clear some strategic pointers in the interrupt context,
>>> and then do all the actual unmapping and endpoint ring segments freeing=
,
>>> contexts freeing ,etc later?
>>>
>>> Pseudocode:
>>>
>>> xhci_handle_cmd_disable_slot(xhci, slot_id, comp_code)
>>> {
>>> =C2=A0=C2=A0=C2=A0=C2=A0 if (cmd_comp_code =3D=3D COMP_SUCCESS) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xhci->dcbaa->dev_conte=
xt_ptrs[slot_id] =3D 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xhci->devs[slot_id] =
=3D NULL;
>>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>> }
>>>
>>> xhci_disable_and_free_slot(xhci, slot_id)
>>> {
>>> =C2=A0=C2=A0=C2=A0=C2=A0 struct xhci_virt_device *vdev =3D xhci->devs[s=
lot_id];
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 xhci_disable_slot(xhci, slot_id);
>>> =C2=A0=C2=A0=C2=A0=C2=A0 xhci_free_virt_device(xhci, vdev, slot_id);
>>> }
>>>
>>> xhci_free_virt_device(xhci, vdev, slot_id)
>>> {
>>> =C2=A0=C2=A0=C2=A0=C2=A0 if (xhci->dcbaa->dev_context_ptrs[slot_id] =3D=
=3D vdev->out_ctx->dma)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xhci->dcbaa->dev_conte=
xt_ptrs[slot_id] =3D 0;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 // free and unmap things just like before
>>> =C2=A0=C2=A0=C2=A0=C2=A0 ...
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 if (xhci->devs[slot_id] =3D=3D vdev)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xhci->devs[slot_id] =
=3D NULL;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 kfee(vdev);
>>> }
>>
>> Hi Mathias,
>>
>> Yes, your suggestion is a better revision, I made some modifications
>> to the patch which is listed below. Please help to review again.
>> Thanks for your help.
>>
>> ---
>> =C2=A0 drivers/usb/host/xhci-hub.c=C2=A0 |=C2=A0 3 +--
>> =C2=A0 drivers/usb/host/xhci-mem.c=C2=A0 | 21 ++++++++++-----------
>> =C2=A0 drivers/usb/host/xhci-ring.c |=C2=A0 9 +++++++--
>> =C2=A0 drivers/usb/host/xhci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 23 ++++++=
++++++++++-------
>> =C2=A0 drivers/usb/host/xhci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +=
+-
>> =C2=A0 5 files changed, 36 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
>> index 92bb84f8132a..b3a59ce1b3f4 100644
>> --- a/drivers/usb/host/xhci-hub.c
>> +++ b/drivers/usb/host/xhci-hub.c
>> @@ -704,8 +704,7 @@ static int xhci_enter_test_mode(struct xhci_hcd *xhc=
i,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!xhci->devs[i=
])
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 continue;
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retval =3D xhci_disable_slot=
(xhci, i);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xhci_free_virt_device(xhci, =
i);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retval =3D xhci_disable_and_=
free_slot(xhci, i);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (retval)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 xhci_err(xhci, "Failed to disable slot %d, %d. Enter test mode anywa=
y\n",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i, retval);
>> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
>> index 6680afa4f596..fc4aca2e65bc 100644
>> --- a/drivers/usb/host/xhci-mem.c
>> +++ b/drivers/usb/host/xhci-mem.c
>> @@ -865,21 +865,18 @@ int xhci_alloc_tt_info(struct xhci_hcd *xhci,
>> =C2=A0=C2=A0 * will be manipulated by the configure endpoint, allocate d=
evice, or update
>> =C2=A0=C2=A0 * hub functions while this function is removing the TT entr=
ies from the list.
>> =C2=A0=C2=A0 */
>> -void xhci_free_virt_device(struct xhci_hcd *xhci, int slot_id)
>> +void xhci_free_virt_device(struct xhci_hcd *xhci, struct xhci_virt_devi=
ce *dev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int slot_id)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 struct xhci_virt_device *dev;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int old_active_eps =3D 0;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Slot ID 0 is reserved */
>> -=C2=A0=C2=A0=C2=A0 if (slot_id =3D=3D 0 || !xhci->devs[slot_id])
>> +=C2=A0=C2=A0=C2=A0 if (slot_id =3D=3D 0 || !dev)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>
>> -=C2=A0=C2=A0=C2=A0 dev =3D xhci->devs[slot_id];
>> -
>> -=C2=A0=C2=A0=C2=A0 xhci->dcbaa->dev_context_ptrs[slot_id] =3D 0;
>> -=C2=A0=C2=A0=C2=A0 if (!dev)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 if (xhci->dcbaa->dev_context_ptrs[slot_id] =3D=3D de=
v->out_ctx->dma)
>=20
> forgot that dev_context_ptrs[] values are stored as le64 while
> out_ctx->dma=C2=A0 is in whatever cpu uses.
>=20
> So above should be:
> if (xhci->dcbaa->dev_context_ptrs[slot_id] =3D=3D cpu_to_le64(dev->out_ct=
x->dma))
>=20
> Otherwise it looks good to me

Ok, I got it. I'll submit a new version with this issue fix.

Best Regards,
weitao

