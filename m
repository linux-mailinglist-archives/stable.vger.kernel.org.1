Return-Path: <stable+bounces-10553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD46782BAB0
	for <lists+stable@lfdr.de>; Fri, 12 Jan 2024 06:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DCA8285B0A
	for <lists+stable@lfdr.de>; Fri, 12 Jan 2024 05:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7455F5B5C0;
	Fri, 12 Jan 2024 05:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lIGSiP2/"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C535B5BA;
	Fri, 12 Jan 2024 05:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40C4c3BM026611;
	Fri, 12 Jan 2024 05:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1Qu6qj+vZRCKJR7O0f/0EI3VnYFGa4mdapasG8Ccl4I=; b=lI
	GSiP2/V9ji6rl4sxeMs5kLGdhY0Vy+rztrBp/Ewf1t/4h0lg/FBqaqwlVFFb0YRN
	ypdRRdkW0EVXdH8ke9q36xyxc4PYtotQ8zAXuWDM/k98FypJFHSXYkmOsuRcxOTb
	w8Tf86CS+WO8cNAFPXrTuvcF41YAjpHXfcbWJ2QhXdOzNnNMtrw6tJlJWuU75Lu2
	Y8jWNylgBPAjOOT0GduUeJgyy82bBMCRPlQB11La0cV19v8YPp2kY/c/kH9SPgsM
	75WkLl85eIWgU/oplgjAvSh9bGh1dBcEA8jn+OwW0GtdO9aLfkt/ZlMvHvfhI3wv
	ngjjwsZ7W8bB1N1CKCEg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjqx1gr2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 05:14:32 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40C5EVFF021262
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 05:14:31 GMT
Received: from [10.253.78.45] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 11 Jan
 2024 21:14:30 -0800
Message-ID: <ced5a5f8-7e31-4eea-a12d-b8b76735e2a3@quicinc.com>
Date: Fri, 12 Jan 2024 13:14:27 +0800
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
X-Proofpoint-ORIG-GUID: Y-zRZ6-N7TCYYSMzY7JWBG2KUEzpFE8c
X-Proofpoint-GUID: Y-zRZ6-N7TCYYSMzY7JWBG2KUEzpFE8c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 mlxlogscore=997
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401120037

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
it means that use tool btattach to attach BT controller QCA_ROME, ROME is a controller name. namely QCA_ROME
as defined below, have optimized description and sent v2 patch.
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
 

>> dereferring nullptr hu->serdev, fixed by null check before access.
> 
> dereferring → dereferencing
> 
>>
have corrected as your advise
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
it will happens on any machine with linux OS, such as 
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
For ALL QCA BT controller which are attached by tool btattach. hu->serdev is nullptr since
it is not probed by serdev driver. and it is a tty device.

as you saw, the following code also do nullptr check for hu->serdev, since protocol setup function
are used by both Serdev and Non-serdev, thanks

if (hu->serdev) {
       serdev_device_close(hu->serdev);
}

> 
>>       } else if (ret == -ENOENT) {
>>           /* No patch/nvm-config found, run with original fw/config */
> 
> 
> Kind regards,
> 
> Paul


