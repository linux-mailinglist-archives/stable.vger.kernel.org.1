Return-Path: <stable+bounces-26813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD3087241D
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 17:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB6871C22F3D
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 16:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5848C129A78;
	Tue,  5 Mar 2024 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IEUIzBpm"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAE1128805
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655774; cv=none; b=iYpkaJAVqQ5Pv4WbV17OoL1gvukNL7BK+V79Q56rd6P+qokUA3NGs6ZnYOTogagG2RxaWjP5nP55mzrRFnqBCL+v3Q/CybpKg++0tiEqXWT3iLwLHW7v2S7VMTNUzzo6EP4C2Pvm08h0d84nfw4wUEc4QTPY9F6aevnIerxgwwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655774; c=relaxed/simple;
	bh=TPme8O9VWJgkxIyf5KuebNSAg6B0dVbXIK2CiQTA+w0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qBz16my/DaIQu0momV6r+vrA6z5sYSmQBYCBZXbzicVNbGnUbPmJj95e9Qh/78MRV8yJS1Rq0UCMyyZ+6ME/+XLtRxg3oXME25H86400UwtUB2upv1weYVO0qtLAo6lFi8OmMUih9OU0Q9xzZN1clqFc+cAmEOREEsIWYhXGyhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IEUIzBpm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 425CLq65007611;
	Tue, 5 Mar 2024 16:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=GyoOYjG8AtCJtTRhGiNbiHQkvDveoZKQApi2jC3g58k=; b=IE
	UIzBpmbQ5oDCBbENjheptH8ZmQBzOAoIG55eYs11DgpGZERt5BqyvYQ26m9ct2ay
	N1mW97LLfrUrjhwDtzjPw/HPMMVf40RsQmqxB26GAq5JKJ4hDR1txyAthfMFosCv
	rSC51lh88boqgb30zsUktxMg+0o8O5JWt6GVkmhUjQwzIQLK+wj3VirzqE8R6srY
	UYudnXexe+MQZklXAa7W/W0V8M9qiwGZE6ZAX5K4owGOQh3b2+T7NNVq5BkZASOK
	baShFCQFslxDGw0QIDbp4ePpUHt+bU0CoVGAaamZsxp59YdU26Cf1wiXP7zjz2IW
	vGu+RsSOw7esP8SMiVGQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wp2uwrk43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 16:22:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 425GMHhb017244
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 16:22:17 GMT
Received: from [10.216.59.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Mar
 2024 08:22:14 -0800
Message-ID: <ce7f78bd-68ef-952e-ae6e-8cb2429d04a1@quicinc.com>
Date: Tue, 5 Mar 2024 21:52:10 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH STABLE v6.1.y] mm/migrate: set swap entry values of THP
 tail pages properly.
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, <gregkh@linuxfoundation.org>,
        <stable@vger.kernel.org>
CC: <linux-mm@kvack.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Naoya
 Horiguchi <naoya.horiguchi@linux.dev>
References: <20240305161313.90954-1-zi.yan@sent.com>
 <F242A2B9-8791-4446-A35D-110A77919115@nvidia.com>
From: Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <F242A2B9-8791-4446-A35D-110A77919115@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: e7we7gjyIBSNQjU32dfUfXrz-1EycYy3
X-Proofpoint-ORIG-GUID: e7we7gjyIBSNQjU32dfUfXrz-1EycYy3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_13,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 impostorscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050130

Thanks David for various inputs on this patch!!.

On 3/5/2024 9:47 PM, Zi Yan wrote:
> On 5 Mar 2024, at 11:13, Zi Yan wrote:
> 
>> From: Zi Yan <ziy@nvidia.com>
>>
>> The tail pages in a THP can have swap entry information stored in their
>> private field. When migrating to a new page, all tail pages of the new
>> page need to update ->private to avoid future data corruption.
> 
> Corresponding swapcache entries need to be updated as well.
> e71769ae5260 ("mm: enable thp migration for shmem thp") fixed it already.
> 
> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
> 

Thanks Zi Yan, for posting this patch. I think below tag too applicable?

Closes:
https://lore.kernel.org/linux-mm/1707814102-22682-1-git-send-email-quic_charante@quicinc.com/

> 
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  mm/migrate.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index c93dd6a31c31..c5968021fde0 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -423,8 +423,12 @@ int folio_migrate_mapping(struct address_space *mapping,
>>  	if (folio_test_swapbacked(folio)) {
>>  		__folio_set_swapbacked(newfolio);
>>  		if (folio_test_swapcache(folio)) {
>> +			int i;
>> +
>>  			folio_set_swapcache(newfolio);
>> -			newfolio->private = folio_get_private(folio);
>> +			for (i = 0; i < nr; i++)
>> +				set_page_private(folio_page(newfolio, i),
>> +					page_private(folio_page(folio, i)));
>>  		}
>>  		entries = nr;
>>  	} else {
>> -- 
>> 2.43.0
> 
> 
> --
> Best Regards,
> Yan, Zi

