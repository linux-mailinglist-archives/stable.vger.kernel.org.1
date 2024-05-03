Return-Path: <stable+bounces-43043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2188BB667
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 23:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79DFC1F24BAD
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 21:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA505347A2;
	Fri,  3 May 2024 21:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lS8ZiW/R"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B0DFC0C;
	Fri,  3 May 2024 21:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714773091; cv=none; b=DCeShDPAweOfkh3W/6qeJqEAU2SS++UC/XakEF11ZdRJTh/QWURaS9IDP0m79gvgm2hgL8XxKoWynLCXxwtDBmdJdCvG1pB0yCHo/998XdYgQpPSvSs8EVi5HX28muJHMZakbfrmyKGv0WBNaOAWHKylFyrIb9BY7ZU5bCbYP7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714773091; c=relaxed/simple;
	bh=1rz5dJT6xaio/D3o/7v1z2CGfstXP2UVM9U/Gv4XoDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l3FHZPp7a6uop6sDGb7G/bfOx1092gmgSQWioc0oCzyGV7Ck7bqEQHWeupEWob6tVeHTVYuzoCxAeQ2G1EDi/ZV4sb7zygJbbaBDXJHrJcatP/qleQNEsNQkr7LGLBCmz+rRbZfQBRQHPEssDFV/a/FBKA+8h3H4SNjjS3GQMB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lS8ZiW/R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 443KwYUb004886;
	Fri, 3 May 2024 21:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=J9I4rqs8FpVS+OX3vWQGpgOOt7IEK4dK8Xe6JwsC4jU=; b=lS
	8ZiW/Rc3yB+jzLJu4CMCm/9E2CvGkvlObRinoEcgULCkumhwPmN3GwLYwo0Wq13z
	RviMyJDj6I2c0t+/kDJI2FeFnbCf39+gr+i1T1KQPXhKmF/A2Eio8bDKIdS5Ckow
	qPcq89oUPtgnVPm3pCVIFlAoiOmMMv8to2MTVkhT2Ds5qigUbiOTzcGE/PGNFpv1
	7kTJQvMm8uZSe8YESkyFV331tQAJB8xq5lonj2Auh12/KVGW0NkZ2aP5lI47+MLI
	X71XOFL09h+CXJWNipQnqkA0gv8hN++l2uPTgulfgGWkHOPlVbyj6ptQHNXYuOZf
	jw5hjfN3Cqqku8v3oeCA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xvwfa9eq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 21:51:20 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 443LpJt1020407
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 May 2024 21:51:19 GMT
Received: from [10.253.35.130] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 3 May 2024
 14:51:18 -0700
Message-ID: <b8cc1486-b627-4186-a53c-8331b84e2318@quicinc.com>
Date: Sat, 4 May 2024 05:51:15 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: qca: Fix BT enable failure again for
 QCA6390 after warm reboot
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <luiz.von.dentz@intel.com>, <marcel@holtmann.org>,
        <linux-bluetooth@vger.kernel.org>, <wt@penguintechs.org>,
        <regressions@lists.linux.dev>, <stable@vger.kernel.org>
References: <1714658761-15326-1-git-send-email-quic_zijuhu@quicinc.com>
 <CABBYNZJc=Pzt02f0L3KOSLqkJ+2SwO=OZibA=0S0T3vKPDwPyw@mail.gmail.com>
 <c5998fbd-bd63-4f7d-8f51-3dd081913449@quicinc.com>
 <CABBYNZJOVnBShpgbWEpFBcu_MnHW+TKLndLKnZkkB9C71EfJNA@mail.gmail.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <CABBYNZJOVnBShpgbWEpFBcu_MnHW+TKLndLKnZkkB9C71EfJNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wHml3u2_WYE0lZgnLncq5Sj7u3cRRpRk
X-Proofpoint-ORIG-GUID: wHml3u2_WYE0lZgnLncq5Sj7u3cRRpRk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_15,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2405030156

On 5/4/2024 5:25 AM, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Fri, May 3, 2024 at 4:18 PM quic_zijuhu <quic_zijuhu@quicinc.com> wrote:
>>
>> On 5/4/2024 3:22 AM, Luiz Augusto von Dentz wrote:
>>> Hi Zijun,
>>>
>>> On Thu, May 2, 2024 at 10:06 AM Zijun Hu <quic_zijuhu@quicinc.com> wrote:
>>>>
>>>> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
>>>> serdev") will cause below regression issue:
>>>>
>>>> BT can't be enabled after below steps:
>>>> cold boot -> enable BT -> disable BT -> warm reboot -> BT enable failure
>>>> if property enable-gpios is not configured within DT|ACPI for QCA6390.
>>>>
>>>> The commit is to fix a use-after-free issue within qca_serdev_shutdown()
>>>> during reboot, but also introduces this regression issue regarding above
>>>> steps since the VSC is not sent to reset controller during warm reboot.
>>>>
>>>> Fixed by sending the VSC to reset controller within qca_serdev_shutdown()
>>>> once BT was ever enabled, and the use-after-free issue is also be fixed
>>>> by this change since serdev is still opened when send to serdev.
>>>>
>>>> Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed serdev")
>>>> Cc: stable@vger.kernel.org
>>>> Reported-by: Wren Turkal <wt@penguintechs.org>
>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>> Tested-by: Wren Turkal <wt@penguintechs.org>
>>>> ---
>>>>  drivers/bluetooth/hci_qca.c | 5 ++---
>>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>>>> index 0c9c9ee56592..8e35c9091486 100644
>>>> --- a/drivers/bluetooth/hci_qca.c
>>>> +++ b/drivers/bluetooth/hci_qca.c
>>>> @@ -2450,13 +2450,12 @@ static void qca_serdev_shutdown(struct device *dev)
>>>>         struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
>>>>         struct hci_uart *hu = &qcadev->serdev_hu;
>>>>         struct hci_dev *hdev = hu->hdev;
>>>> -       struct qca_data *qca = hu->priv;
>>>>         const u8 ibs_wake_cmd[] = { 0xFD };
>>>>         const u8 edl_reset_soc_cmd[] = { 0x01, 0x00, 0xFC, 0x01, 0x05 };
>>>>
>>>>         if (qcadev->btsoc_type == QCA_QCA6390) {
>>>> -               if (test_bit(QCA_BT_OFF, &qca->flags) ||
>>>> -                   !test_bit(HCI_RUNNING, &hdev->flags))
>>>
>>> This probably deserves a comment on why you end up with
>>> HCI_QUIRK_NON_PERSISTENT_SETUP and HCI_SETUP flags here, also why you
>>> are removing the flags above since that was introduce to prevent
>>> use-after-free this sort of revert it so I do wonder how serdev can
>>> still be open if you haven't tested for QCA_BT_OFF for example?
>>>
>> okay, let me give comments at next version.
>> this design logic is shown below. you maybe review it.
>>
>> if HCI_QUIRK_NON_PERSISTENT_SETUP is set, it means that hdev->setup()
>> is able to be invoked by every open() to initializate SoC without any
>> help. so we don't need to send the VSC to reset SoC into initial and
>> clean state for the next hdev->setup() call success.
>>
>> otherwise, namely, HCI_QUIRK_NON_PERSISTENT_SETUP is not set.
>>
>> if HCI_SETUP is set, it means hdev->setup() was never be invoked, so the
>> SOC is already in the initial and clean state, so we also don't need to
>> send the VSC to reset SOC.
>>
>> otherwise, we need to send the VSC to reset Soc into a initial and clean
>> state for hdev->setup() call success after "warm reboot -> enable BT"
>>
>> for the case commit message cares about, the only factor which decide to
>> send the VSC is that SoC is a initial and clean state or not after warm
>> reboot, any other factors are irrelevant to this decision.
>>
>> why the serdev is still open after go through
>> (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)
>> || hci_dev_test_flag(hdev, HCI_SETUP) checking is that
>> serdev is not closed by hci_uart_close().
> 
> Sounds like a logical jump to me, in fact hci_uart_close doesn't
> really change any of those flags, beside these flags are not really
> meant to tell the driver if serdev_device_close has been called or not
> which seems to be the intention with HCI_UART_PROTO_READY so how about
> we use that instead?
> 
sorry for that i maybe not give good explanation, let me explain again.
hci_uart_close() is the only point which maybe close serdev before
qca_serdev_shutdown() is called, but for our case that
HCI_QUIRK_NON_PERSISTENT_SETUP is NOT set, hci_uart_close() will not
close serdev for our case, so serdev must be open state before sending
the VSC. so should not need other checking.

> Another thing that is troubling me is that having traffic on shutdown
> is not common, specially if you are going to reboot, etc, and even if
> it doesn't get power cycle why don't you reset on probe rather than
> shutdown? That way we don't have to depend on what has been done in a
> previous boot, which can really become a problem in case of multi-OS
> where you have another system that may not be doing what you expect.
as you know, BT UART are working at 3M baudrate for normal usage.
we can't distinguish if SoC expects 3M or default 11.52K baudarate
during probe() after reboot. so we send the VSC within shutdown to make
sure SoC enter a initial state with 11.52 baudrate.

for cold boot, SOC expects default 11.52K baudrate for probe().
for Enable BT -> warm boot, SOC expects 3M baudrate for probe().
we can't tell these two case within probe(). so need to send the VSC
within shutdown().

>> see hci_uart_close() within drivers/bluetooth/hci_serdev.c
>> static int hci_uart_close(struct hci_dev *hdev)
>> {
>> ......
>>         /* When QUIRK HCI_QUIRK_NON_PERSISTENT_SETUP is set by driver,
>>          * BT SOC is completely powered OFF during BT OFF, holding port
>>          * open may drain the battery.
>>          */
>>         if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
>>                 clear_bit(HCI_UART_PROTO_READY, &hu->flags);
>>                 serdev_device_close(hu->serdev);
>>         }
>>
>>         return 0;
>> }
>>
>>>> +               if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks) ||
>>>> +                   hci_dev_test_flag(hdev, HCI_SETUP))
>>>>                         return;
>>>>
>>>>                 serdev_device_write_flush(serdev);
>>>> --
>>>> 2.7.4
>>>>
>>>
>>>
>>
> 
> 


