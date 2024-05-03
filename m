Return-Path: <stable+bounces-43031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CCB8BB377
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 20:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFBA71F23ED4
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 18:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6246912F391;
	Fri,  3 May 2024 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TjYSNkdr"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3FE2E646;
	Fri,  3 May 2024 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714762213; cv=none; b=D9p0YjrS/rxnunb2ar4bu5Z8biF1C8BvSU8tHnxvw1j3yDc5EAegJ4+O4OfguswVfVeEkprQQd1Lim0H83yI4Zi6G9rPWnT3QxV7rht/aHmxCrWylUsJBSHKez10tj0XiYSVk6UtpyupumvtvpfE7BssFXw/XCNN+R0brlHfKC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714762213; c=relaxed/simple;
	bh=T9yyH4IPlUtj52yTqtbjFNMjirTaNG94NKLfYu/p98Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VbBMAC33TnAksL+yX/G0A4YK0IxZ3yc9WJFZsVooOor3gBOW4CWBGVnVOE9Z4iW2zBjHy/CRSXosZpQxbP3/ArqwHyAFaFcG73ZtAr1m7MpH8h4UbyGK9sqXHtm8a6la1KkCeZRfsz/zNxW6FLRQO8nHwanP0nJhjy4papOReSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TjYSNkdr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 443DXVwX018105;
	Fri, 3 May 2024 18:49:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=9ObS9//9ExqshI6VNkIWIDdXgOoaGk6p+urWvswiWnU=; b=Tj
	YSNkdra9ctYQDTZocCUcjrI6ZgJPyp3L54Mdgw5WpI6Tg0mJO3gEQAvMVPEg05eZ
	h9EL2pI+91htaTdcewo8vlNHpVzNgx9TjXTv6N4B3lRJOks02s4ytW1SRnA/1X4S
	su8ymGdaFFCnnJmgSjLaKog4ZhTQ4qsmvRtaWmUT5G4KzXVAjF6CbciBat03wDTZ
	Q3dE35MoXB9iSKZ80EL5zNIQtYiWGKlrMAn7Hnlae9nNz9lLFMG/PPwAOaGBIXZf
	aI3GalGAGfa9/jJGatIVFTLkK0xVf7wFMZckgGEZ0f9U4paRXnVAVqJ0GmYD73GG
	ggaI1blmh3HIIcRuaq2w==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xvtbpse8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 18:49:47 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 443Inkvg023488
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 May 2024 18:49:46 GMT
Received: from [10.253.35.130] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 3 May 2024
 11:49:44 -0700
Message-ID: <8f6bc1a8-a1ec-45f1-a951-0ad5a9890cc2@quicinc.com>
Date: Sat, 4 May 2024 02:49:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: qca: Fix BT enable failure again for
 QCA6390 after warm reboot
To: Krzysztof Kozlowski <krzk@kernel.org>, <luiz.dentz@gmail.com>,
        <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <wt@penguintechs.org>,
        <regressions@lists.linux.dev>, <stable@vger.kernel.org>
References: <1714658761-15326-1-git-send-email-quic_zijuhu@quicinc.com>
 <5e5e869c-da12-4818-837e-55709f0c4db9@kernel.org>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <5e5e869c-da12-4818-837e-55709f0c4db9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ETf956c8RTAoRrb-gV64_u0EMkNVTx2-
X-Proofpoint-ORIG-GUID: ETf956c8RTAoRrb-gV64_u0EMkNVTx2-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_12,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 spamscore=0 clxscore=1015 mlxlogscore=973 lowpriorityscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405030131

On 5/3/2024 6:16 PM, Krzysztof Kozlowski wrote:
> On 02/05/2024 16:06, Zijun Hu wrote:
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
> 
> I don't think this is v1. Version your patches properly and provide
> changelog.
> 
i sent it as v1 to start a new and clean discussion.
> I asked already *two times*:
> 1. On which kernel did you test it?
> 2. On which hardware did you test it?
> 
will provide such info within next commit message.
> I am not interested in any replies like "I wrote something on bugzilla".
> I am really fed up with your elusive, time-wasting replies, so be
> specific here.
> 
are there any other concerns about this patch itself?
> Best regards,
> Krzysztof
> 


