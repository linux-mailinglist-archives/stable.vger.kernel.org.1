Return-Path: <stable+bounces-10497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5B482ABAE
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 11:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2F51F25C83
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 10:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BB512E4D;
	Thu, 11 Jan 2024 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cgl3/fIT"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686FF14F60;
	Thu, 11 Jan 2024 10:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40B2ogpQ010118;
	Thu, 11 Jan 2024 10:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=h/DbbzHoNkxnGW4L2L75cbtUpAz/S+Y5/h6ZMK3OrJk=; b=cg
	l3/fIT9N+aKNDm215gnsQQN+s9+izMv0Pb0qUKlLA4NH3U+3VFxzmPK6yexWblp3
	v0U5dWPNdVnxBa/CiUNZWTEcbuxX0aU2LFTBmXqhy7RBfVnP7zd3aiCKfuF9dguO
	aUXWNarJQx/iKHn1IgmSxDYqB55QSkVIqPLgmZze7gXfCxUIGyaO41LeK5rDg7KG
	vBzBiGWE0uvi8OIcyUjqT+n3FSgiw0OVOHbyO9ulTvMNSWu9mKOzz3dyGPj/r4yp
	T711K7pl0ukOaIgy7seK1i5wpylsexGvJ0twjC0pJgZFZ+FaPJCv4qRSq4teZc4u
	WwkZJ5zjGHzwOqulVjbA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vj7w58w6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 10:14:32 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40BAEVvl007213
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 10:14:31 GMT
Received: from [10.253.76.230] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 11 Jan
 2024 02:14:29 -0800
Message-ID: <7975f7af-3369-4590-b943-ad10da247bac@quicinc.com>
Date: Thu, 11 Jan 2024 18:14:27 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: qca: Fix crash when btattach controller
 ROME
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: <luiz.dentz@gmail.com>, <marcel@holtmann.org>, <jiangzp@google.com>,
        <linux-bluetooth@vger.kernel.org>, <stable@vger.kernel.org>
References: <1704960978-5437-1-git-send-email-quic_zijuhu@quicinc.com>
 <bf74d533-c0ff-42c6-966f-b4b28c5e0f60@molgen.mpg.de>
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <bf74d533-c0ff-42c6-966f-b4b28c5e0f60@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YD99fuqPA7JUPIH5Nr1xjLKy8CDa55d3
X-Proofpoint-GUID: YD99fuqPA7JUPIH5Nr1xjLKy8CDa55d3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 mlxlogscore=865 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110083

On 1/11/2024 5:46 PM, Paul Menzel wrote:
> Dear Zijun,
> 
> 
> Thank you for your patch.
> 
> Am 11.01.24 um 09:16 schrieb Zijun Hu:
>> A crash will happen when btattach controller ROME, and it is caused by
> 
> What does “btattach controller ROME” mean? Is ROME a platform? If so, should it be *on ROME* or similar?
> 
ROME is a type of BT controller name, and refer to QCA_ROME of below defination:
drivers/bluetooth/btqca.h:
enum qca_btsoc_type {
	QCA_INVALID = -1,
	QCA_AR3002,
	QCA_ROME,
	QCA_WCN3988,
	QCA_WCN3990,
	QCA_WCN3998,
	QCA_WCN3991,
	QCA_QCA2066,
	QCA_QCA6390,
	QCA_WCN6750,
	QCA_WCN6855,
	QCA_WCN7850,
};

Connect a external ROME module to ubuntu machine by BT UART to USB cable,  then run
"sudo btattach -B /dev/ttyUSB0 -P qca" within ubuntu.

will optimize description.

>> dereferring nullptr hu->serdev, fixed by null check before access.
> 
> dereferring → dereferencing
>
will correct it.
>>
>> sudo btattach -B /dev/ttyUSB0 -P qca
>> Bluetooth: hci1: QCA setup on UART is completed
>> BUG: kernel NULL pointer dereference, address: 00000000000002f0
>> ......
>> Workqueue: hci1 hci_power_on [bluetooth]
>> RIP: 0010:qca_setup+0x7c1/0xe30 [hci_uart]
>> ......
>> Call Trace:
>>   <TASK>
>>   ? show_regs+0x72/0x90
>>   ? __die+0x25/0x80
>>   ? page_fault_oops+0x154/0x4c0
>>   ? srso_alias_return_thunk+0x5/0xfbef5
>>   ? kmem_cache_alloc+0x16b/0x310
>>   ? do_user_addr_fault+0x330/0x6e0
>>   ? srso_alias_return_thunk+0x5/0xfbef5
>>   ? exc_page_fault+0x84/0x1b0
>>   ? asm_exc_page_fault+0x27/0x30
>>   ? qca_setup+0x7c1/0xe30 [hci_uart]
>>   hci_uart_setup+0x5c/0x1a0 [hci_uart]
>>   hci_dev_open_sync+0xee/0xca0 [bluetooth]
>>   hci_dev_do_open+0x2a/0x70 [bluetooth]
>>   hci_power_on+0x46/0x210 [bluetooth]
>>   process_one_work+0x17b/0x360
>>   worker_thread+0x307/0x430
>>   ? __pfx_worker_thread+0x10/0x10
>>   kthread+0xf7/0x130
>>   ? __pfx_kthread+0x10/0x10
>>   ret_from_fork+0x46/0x70
>>   ? __pfx_kthread+0x10/0x10
>>   ret_from_fork_asm+0x1b/0x30
>>   </TASK>
>>
>> Fixes: 03b0093f7b31 ("Bluetooth: hci_qca: get wakeup status from serdev device handle")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> Tested-by: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> On what device?
> 
this crash will happens on any generic linux machine, for example,

lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 22.04.3 LTS
Release:        22.04
Codename:       jammy

>> ---
>>   drivers/bluetooth/hci_qca.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 94b8c406f0c0..6fcfc1f7bb12 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -1951,7 +1951,7 @@ static int qca_setup(struct hci_uart *hu)
>>           qca_debugfs_init(hdev);
>>           hu->hdev->hw_error = qca_hw_error;
>>           hu->hdev->cmd_timeout = qca_cmd_timeout;
>> -        if (device_can_wakeup(hu->serdev->ctrl->dev.parent))
>> +        if (hu->serdev && device_can_wakeup(hu->serdev->ctrl->dev.parent))
>>               hu->hdev->wakeup = qca_wakeup;
> 
> Why is `hu->serdev` not set on the device?
> 
actually, hu->serdev ONLY exists for BT controller which is embedded within machine's board,
and it will be probed by serdev driver and also don't have available device node for user to btattach.
also don't need to btattach.

for external BT module, it is tty instead of serdev. so hu->serdev is nullptr.


>>       } else if (ret == -ENOENT) {
>>           /* No patch/nvm-config found, run with original fw/config */
> 
> 
> Kind regards,
> 
> Paul


