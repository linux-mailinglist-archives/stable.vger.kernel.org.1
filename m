Return-Path: <stable+bounces-54711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B87891037B
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 13:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDAB2B2149A
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 11:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09D8173332;
	Thu, 20 Jun 2024 11:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mzpGCkRL"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307EE13665D;
	Thu, 20 Jun 2024 11:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884622; cv=none; b=m2FvEhCf42Mv7qTmLipAjfV3ka37ixZNP4xasuPGJj51O9ioXifdX0LqC7ON3vRsKbwi72lgg1M1n3VYniC/E3ryCmgCpTk7voz0W1zYrDeQWOq644Cfyh+DOC62ratfY/g1Vr8mg9Abzq3k7q3nxs3jBHdaNtD7Pw1LvbL0yZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884622; c=relaxed/simple;
	bh=ca5SYE9/InF8c1SBWoxMxo9YUkiL/OjFI0M2rAUFdGk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=gSB7t5WyusDMwyRHHT2hp4ILM1bAu7i3t2Cj+6xkQOIFE1oeFNRJkg3IiMWVLr+sLMf5OSmmTP8voC3/Dls/zWpKSDWYWJ4vtMHhttFSvkns/DkujnB2qD9HujNVwsoEov/73Bjnnwd3khUQZ91PLI0PPhkwXGDSQPF32PC5gP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mzpGCkRL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KAcaBa011418;
	Thu, 20 Jun 2024 11:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	95+DKabi49hZWdVVvLr95Z2P8qbaL8Pc33dwAErXsQM=; b=mzpGCkRLRFFGV8in
	B3DS0VUY2be/6w+MVR16jrQr4uss6InJagTb/2GLI7UcSjSR69Z+02tYh1wK/rQY
	S0A3H6VJPNR5QR1hHfTt3MI8D3LNHZvTkqeK8oaf4AnqCX7QmerTQ+sW9cAUUzCY
	10Zxm+gcE41auBV7K8DSz+wt5GxR3yfZC0eAp/IPCR8KrTq5IIBK1FA3q5XuRuiW
	fPye4w3+4zrTZh/iQK3VwXE0toWIncHS/zMeRWBguWH1fZ1emNkKZd7AkO1seRCf
	IVYr8CTPQfqmpks55od0G91Kbc6u7FBuaXwkmeOnlWZhBls5hLphhnZuDlRSOo1q
	nweSJQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvjumr5dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 11:56:49 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45KBume2008507
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 11:56:48 GMT
Received: from [10.253.77.41] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Jun
 2024 04:56:47 -0700
Message-ID: <91853ea9-888c-4062-8d90-98627a0ce8d7@quicinc.com>
Date: Thu, 20 Jun 2024 19:56:45 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: quic_zijuhu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v1] devres: Fix memory leakage due to driver API
 devm_free_percpu()
To: Greg KH <gregkh@linuxfoundation.org>
CC: <rafael@kernel.org>, <davem@davemloft.net>, <madalin.bucur@nxp.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <1718804281-1796-1-git-send-email-quic_zijuhu@quicinc.com>
 <2024061949-dullness-snippet-da5a@gregkh>
Content-Language: en-US
In-Reply-To: <2024061949-dullness-snippet-da5a@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: U3BwW_XOkXjorhIO3DReu2P84uf6Jnbg
X-Proofpoint-GUID: U3BwW_XOkXjorhIO3DReu2P84uf6Jnbg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=383 bulkscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406200085

On 6/19/2024 10:53 PM, Greg KH wrote:
> On Wed, Jun 19, 2024 at 09:38:01PM +0800, Zijun Hu wrote:
>> It will cause memory leakage when use driver API devm_free_percpu()
>> to free memory allocated by devm_alloc_percpu(), fixed by using
>> devres_release() instead of devres_destroy() within devm_free_percpu().
>>
>> Fixes: ff86aae3b411 ("devres: add devm_alloc_percpu()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  drivers/base/devres.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
>> index 3df0025d12aa..082dbb296b6e 100644
>> --- a/drivers/base/devres.c
>> +++ b/drivers/base/devres.c
>> @@ -1222,7 +1222,11 @@ EXPORT_SYMBOL_GPL(__devm_alloc_percpu);
>>   */
>>  void devm_free_percpu(struct device *dev, void __percpu *pdata)
>>  {
>> -	WARN_ON(devres_destroy(dev, devm_percpu_release, devm_percpu_match,
>> +	/*
>> +	 * Use devres_release() to prevent memory leakage as
>> +	 * devm_free_pages() does.
>> +	 */
>> +	WARN_ON(devres_release(dev, devm_percpu_release, devm_percpu_match,
>>  			       (__force void *)pdata));
>>  }
>>  EXPORT_SYMBOL_GPL(devm_free_percpu);
>> -- 
>> 2.7.4
>>
>>
> 
> These are good fixes, how are you finding them?  Care to write up some
> kunit tests for the devres apis?
> 
find them by reading code.😀
> thanks,
> 
> greg k-h


