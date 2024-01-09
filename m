Return-Path: <stable+bounces-10367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66D9828421
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 11:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4E72877DD
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 10:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0DF364BA;
	Tue,  9 Jan 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jLaCWDv0"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6889C273FA;
	Tue,  9 Jan 2024 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409AdNVm012221;
	Tue, 9 Jan 2024 10:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=AweU5Ei+gvo7E0DMGDfPT7IbKTgVtCA6zKIA67ho+sE=; b=jL
	aCWDv0bRpyqoTiM07jruAeHbOywMwpGxgUU6NFxxNHbZDyyE0hlQ+obYx+eG9P/d
	MxN0YqOOvkFcu+POhD427BK5M2xeI2HmTlsLfaUQRxZgTSUWkjYIeB7E02pvYCk8
	UxoLHMEVTJYxPnqbe2YDc7rBC1zgqNiUkPubZ3Br/gjLxHX6pYkRm7q5qSipimeo
	UqiUKqt8VuWEwJ3GiTy4Zgwed43zznC9j1Mfkvs1LezI63ovVQk7wS0wMX/+lMU1
	mmZdK0BS36SNBIjXAxPgcGmffLIuVZDjUWrpdPzCSzhyMCOWLHpPG8UizVAyv78X
	BdCUk9PsbgK340X0pYgw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgwx38rt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 10:40:14 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409AeDbA018047
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 10:40:13 GMT
Received: from [10.253.39.94] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 9 Jan
 2024 02:40:11 -0800
Message-ID: <a35df10f-fd93-42f5-911e-26b015f8593a@quicinc.com>
Date: Tue, 9 Jan 2024 18:39:49 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] Bluetooth: hci_event: Fix wakeup BD_ADDR are
 wrongly recorded
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: <luiz.dentz@gmail.com>, <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <stable@vger.kernel.org>
References: <1704789450-17754-1-git-send-email-quic_zijuhu@quicinc.com>
 <a4ec8dd2-22aa-4337-b9f4-b35563aa404f@molgen.mpg.de>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <a4ec8dd2-22aa-4337-b9f4-b35563aa404f@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lgmXD_kgwwk-FI3RhFyDEiQU1hVN5nAt
X-Proofpoint-ORIG-GUID: lgmXD_kgwwk-FI3RhFyDEiQU1hVN5nAt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 impostorscore=0 clxscore=1011 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401090086

On 1/9/2024 5:58 PM, Paul Menzel wrote:
> Dear Zijun,
> 
> 
> Thank you very much for your patch. Should you resent, some nits for the commit message. For the summary, I suggest:
> 
> Bluetooth: hci_event: Fix wrongly recorded wakeup BD_ADDR
> 
will take your suggestions and send v2 patch
> Am 09.01.24 um 09:37 schrieb Zijun Hu:
>> hci_store_wake_reason() wrongly parses event HCI_Connection_Request
>> as HCI_Connection_Complete and HCI_Connection_Complete as
>> HCI_Connection_Request, so causes recording wakeup BD_ADDR error and
>> stability issue, it is fixed by this change.
> 
> Maybe: … stability issue. Fix it by using the correct field.
> will correct commit messages based on your suggestions.
> How did you reproduce the stability issues?
> 
> As you sent it to stable@vger.kernel.org, could you please add a Fixes: tag?
> 
i will take it as potential stability issue since it maybe access unexpected memory area.
don't send it to  stable@vger.kernel.org any more.

actually. i just read code and find this issue.

>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>   net/bluetooth/hci_event.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index ef8c3bed7361..22b22c264c2a 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -7420,10 +7420,10 @@ static void hci_store_wake_reason(struct hci_dev *hdev, u8 event,
>>        * keep track of the bdaddr of the connection event that woke us up.
>>        */
>>       if (event == HCI_EV_CONN_REQUEST) {
>> -        bacpy(&hdev->wake_addr, &conn_complete->bdaddr);
>> +        bacpy(&hdev->wake_addr, &conn_request->bdaddr);
>>           hdev->wake_addr_type = BDADDR_BREDR;
>>       } else if (event == HCI_EV_CONN_COMPLETE) {
>> -        bacpy(&hdev->wake_addr, &conn_request->bdaddr);
>> +        bacpy(&hdev->wake_addr, &conn_complete->bdaddr);
>>           hdev->wake_addr_type = BDADDR_BREDR;
>>       } else if (event == HCI_EV_LE_META) {
>>           struct hci_ev_le_meta *le_ev = (void *)skb->data;
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul


