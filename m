Return-Path: <stable+bounces-43039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA268BB4AA
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 22:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10BBB281D9A
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 20:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB53A158D8F;
	Fri,  3 May 2024 20:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="krbKMFH/"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FC0158D8B;
	Fri,  3 May 2024 20:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714767501; cv=none; b=V04yRSWb5lBFKevxAJEws3JzeTxA7nPFQ4J/EQ6bdXxuK6kZTuzY91UvcIj6pszw+0QzIIG5Tk1jz398tkQplEm3nSp4e7lqACc2rpez7Ktz0aUz+j4/4E8q3TQluHsGWGfbUzElnfFcjyPsnYQxBo7DCM0tqID2NcdRDgj2jfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714767501; c=relaxed/simple;
	bh=ZSVyMG6UynWCjwv9tjblL+1JAovgwLToVJciMdyOh7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ylc6ft/yFX35Ez1I4Ixn5knAuICdZDLNlntrMqrcIl1b4msuZtDRWPSsbTmcxvfugI+cpe66XYrYF5GEJoLRxvucb5AzxBEoxsgTxPMN8QUlfXpbMZw0xd9+Gfp/Jf6dpvlXw8Jt/SYDWRoiy+QDiusa7DCjNEC2qwknyrqFX68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=krbKMFH/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 443HfE3q025489;
	Fri, 3 May 2024 20:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ChzedPPNFe/SK4mp7FcDUZTfVCAL0rLOncuQRDJzhZg=; b=kr
	bKMFH/RwyLNYc7k6fB3lA7A8I0wnJd4WJq86LiiwF+2WJ7OAEF7aVB98ty14K1KB
	EQkCKgcfjaBD/6pE13Cv50ImO5h+XZl4+MbkYDWc1+eQLCEGO496LrPBNl2yiyzP
	TgigbaPhxMmzXyeL4EVYPaTFFFTl6+vT6vt+WEQaIlx05Pvsa84wEWi7gdmnBGEp
	KgJF5cPLajv1UYfmXNoyyUihzddyqt0zv84EWaITOfxmJ6ROKdF+IQWerWQqJ/XG
	8leAsvVv/s6SEN2Z+gub9agepUifSni+IuCIywGwo+MsR7+uniXGOWuT5FnBC4Gp
	SK8KJhz1AJ/862S05M/A==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xvwfa98cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 20:18:09 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 443KI8sG016863
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 May 2024 20:18:08 GMT
Received: from [10.253.35.130] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 3 May 2024
 13:18:06 -0700
Message-ID: <c5998fbd-bd63-4f7d-8f51-3dd081913449@quicinc.com>
Date: Sat, 4 May 2024 04:18:04 +0800
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
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <CABBYNZJc=Pzt02f0L3KOSLqkJ+2SwO=OZibA=0S0T3vKPDwPyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6vbPmWJZzbZxvmutlxrNhiS7BEsSTw3G
X-Proofpoint-ORIG-GUID: 6vbPmWJZzbZxvmutlxrNhiS7BEsSTw3G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_14,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2405030142

On 5/4/2024 3:22 AM, Luiz Augusto von Dentz wrote:
> Hi Zijun,
> 
> On Thu, May 2, 2024 at 10:06 AM Zijun Hu <quic_zijuhu@quicinc.com> wrote:
>>
>> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
>> serdev") will cause below regression issue:
>>
>> BT can't be enabled after below steps:
>> cold boot -> enable BT -> disable BT -> warm reboot -> BT enable failure
>> if property enable-gpios is not configured within DT|ACPI for QCA6390.
>>
>> The commit is to fix a use-after-free issue within qca_serdev_shutdown()
>> during reboot, but also introduces this regression issue regarding above
>> steps since the VSC is not sent to reset controller during warm reboot.
>>
>> Fixed by sending the VSC to reset controller within qca_serdev_shutdown()
>> once BT was ever enabled, and the use-after-free issue is also be fixed
>> by this change since serdev is still opened when send to serdev.
>>
>> Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed serdev")
>> Cc: stable@vger.kernel.org
>> Reported-by: Wren Turkal <wt@penguintechs.org>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> Tested-by: Wren Turkal <wt@penguintechs.org>
>> ---
>>  drivers/bluetooth/hci_qca.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 0c9c9ee56592..8e35c9091486 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -2450,13 +2450,12 @@ static void qca_serdev_shutdown(struct device *dev)
>>         struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
>>         struct hci_uart *hu = &qcadev->serdev_hu;
>>         struct hci_dev *hdev = hu->hdev;
>> -       struct qca_data *qca = hu->priv;
>>         const u8 ibs_wake_cmd[] = { 0xFD };
>>         const u8 edl_reset_soc_cmd[] = { 0x01, 0x00, 0xFC, 0x01, 0x05 };
>>
>>         if (qcadev->btsoc_type == QCA_QCA6390) {
>> -               if (test_bit(QCA_BT_OFF, &qca->flags) ||
>> -                   !test_bit(HCI_RUNNING, &hdev->flags))
> 
> This probably deserves a comment on why you end up with
> HCI_QUIRK_NON_PERSISTENT_SETUP and HCI_SETUP flags here, also why you
> are removing the flags above since that was introduce to prevent
> use-after-free this sort of revert it so I do wonder how serdev can
> still be open if you haven't tested for QCA_BT_OFF for example?
> 
okay, let me give comments at next version.
this design logic is shown below. you maybe review it.

if HCI_QUIRK_NON_PERSISTENT_SETUP is set, it means that hdev->setup()
is able to be invoked by every open() to initializate SoC without any
help. so we don't need to send the VSC to reset SoC into initial and
clean state for the next hdev->setup() call success.

otherwise, namely, HCI_QUIRK_NON_PERSISTENT_SETUP is not set.

if HCI_SETUP is set, it means hdev->setup() was never be invoked, so the
SOC is already in the initial and clean state, so we also don't need to
send the VSC to reset SOC.

otherwise, we need to send the VSC to reset Soc into a initial and clean
state for hdev->setup() call success after "warm reboot -> enable BT"

for the case commit message cares about, the only factor which decide to
send the VSC is that SoC is a initial and clean state or not after warm
reboot, any other factors are irrelevant to this decision.

why the serdev is still open after go through
(test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)
|| hci_dev_test_flag(hdev, HCI_SETUP) checking is that
serdev is not closed by hci_uart_close().

see hci_uart_close() within drivers/bluetooth/hci_serdev.c
static int hci_uart_close(struct hci_dev *hdev)
{
......
	/* When QUIRK HCI_QUIRK_NON_PERSISTENT_SETUP is set by driver,
	 * BT SOC is completely powered OFF during BT OFF, holding port
	 * open may drain the battery.
	 */
	if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
		serdev_device_close(hu->serdev);
	}

	return 0;
}

>> +               if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks) ||
>> +                   hci_dev_test_flag(hdev, HCI_SETUP))
>>                         return;
>>
>>                 serdev_device_write_flush(serdev);
>> --
>> 2.7.4
>>
> 
> 


