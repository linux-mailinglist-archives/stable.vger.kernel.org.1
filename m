Return-Path: <stable+bounces-119441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7BDA43349
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 03:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700DB176072
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 02:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2F015199C;
	Tue, 25 Feb 2025 02:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hacrBWY1"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD951420A8;
	Tue, 25 Feb 2025 02:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740451653; cv=none; b=r1aM5Tfq790YWMqS5NBo/b7krYp7FfkhT4LiuQmSO4wMeGwdWBOwUrgBC453JCPNJfAPidEilDJ45lTDTNK+erM5Gnsvbvcr/WUfSeDRC/Ym1yVRu5L2ouE6Mr3Ti8is2kE0gTsIbzd5QYebLDn42kmwWS+qJPDURb4zFIstMcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740451653; c=relaxed/simple;
	bh=x1KS6AqtfOZwtRXInSRfYPkWUb1M714+osbFq+Q48Ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ai5EXzx82ZEzkFKTExo2dzpyLYWvcmxwWir7X1S5yRsvvQyIe7bba/AurEFMuc7EqOG1boQkmx2UaYDFV6BQaGn+G0v3nORx3OrF8CUWYHkOZTsNmM4d/KFp+NDtkbGvkcxKr5pSXcHl7Xai9op7ofaBnWQKttjLwfrVPgauNnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hacrBWY1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OKOJjv013314;
	Tue, 25 Feb 2025 02:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aA6tZ8v8e+BA012PmW+ETz2ZzpvDZAOrVhEY0i8GYNk=; b=hacrBWY1XvmsWtnC
	iGejnx8L5eArOUtID8tzu5q4BN6O8UM33Dz63A4llf987DRUYBYTpBKxEEXjA6aZ
	vf+vz5nnHxx4jC6gZIB0qWenWDZOE537ecYmUCc35QLZuj9FTAnt45EwiGEAsaZI
	FBZ7nkEeu4xHTi1JXTtA/CCh9t+MzS68MHZyJx2qdwD0GhmhmKe7GfrUQkox12Ut
	y/7aoF3UiGrW6viMs8rfdwATPpM8ZAcJzIXjv+SVEMN0SCjIxu/4i/zHTGWh63gd
	MH9ACP7kCLHKXl/U0glV6TEDg271mNnhP0+7zVSRUSlvg9LL7JBUgNQedlFK9FOd
	t23gGQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y5wgq9gj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 02:46:59 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51P2kwPs020687
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 02:46:58 GMT
Received: from [10.133.33.36] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 24 Feb
 2025 18:46:54 -0800
Message-ID: <97ac58b1-e37c-4106-b32b-74e041d7db44@quicinc.com>
Date: Tue, 25 Feb 2025 10:46:51 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/14] of: reserved-memory: Fix using wrong number of
 cells to get property 'alignment'
To: William McVicker <willmcvicker@google.com>, Rob Herring <robh@kernel.org>
CC: Zijun Hu <zijun_hu@icloud.com>, Saravana Kannan <saravanak@google.com>,
        Maxime Ripard <mripard@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Grant Likely <grant.likely@secretlab.ca>,
        Marc Zyngier <maz@kernel.org>,
        Andreas Herrmann <andreas.herrmann@calxeda.com>,
        Marek Szyprowski
	<m.szyprowski@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Mike
 Rapoport" <rppt@kernel.org>,
        Oreoluwa Babatunde <quic_obabatun@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <kernel-team@android.com>
References: <20250109-of_core_fix-v4-0-db8a72415b8c@quicinc.com>
 <20250109-of_core_fix-v4-9-db8a72415b8c@quicinc.com>
 <20250113232551.GB1983895-robh@kernel.org> <Z70aTw45KMqTUpBm@google.com>
Content-Language: en-US
From: Zijun Hu <quic_zijuhu@quicinc.com>
In-Reply-To: <Z70aTw45KMqTUpBm@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0Y2V9zzDINZ_WQjiCfZNtwDTgE_RxUPw
X-Proofpoint-ORIG-GUID: 0Y2V9zzDINZ_WQjiCfZNtwDTgE_RxUPw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_12,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1011 adultscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250017

On 2/25/2025 9:18 AM, William McVicker wrote:
> Hi Zijun and Rob,
> 
> On 01/13/2025, Rob Herring wrote:
>> On Thu, Jan 09, 2025 at 09:27:00PM +0800, Zijun Hu wrote:
>>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>>
>>> According to DT spec, size of property 'alignment' is based on parent
>>> node’s #size-cells property.
>>>
>>> But __reserved_mem_alloc_size() wrongly uses @dt_root_addr_cells to get
>>> the property obviously.
>>>
>>> Fix by using @dt_root_size_cells instead of @dt_root_addr_cells.
>>
>> I wonder if changing this might break someone. It's been this way for 
>> a long time. It might be better to change the spec or just read 
>> 'alignment' as whatever size it happens to be (len / 4). It's not really 
>> the kernel's job to validate the DT. We should first have some 
>> validation in place to *know* if there are any current .dts files that 
>> would break. That would probably be easier to implement in dtc than 
>> dtschema. Cases of #address-cells != #size-cells should be pretty rare, 
>> but that was the default for OpenFirmware.
>>
>> As the alignment is the base address alignment, it can be argued that 
>> "#address-cells" makes more sense to use than "#size-cells". So maybe 
>> the spec was a copy-n-paste error.
> 
> Yes, this breaks our Pixel downstream DT :( Also, the upstream Pixel 6 device
> tree has cases where #address-cells != #size-cells.
> 

it seems upstream upstream Pixel 6 has no property 'alignment'
git grep alignment arch/arm64/boot/dts/exynos/google/
so it should not be broken.

> I would prefer to not have this change, but if that's not possible, could we
> not backport it to all the stable branches? That way we can just force new
> devices to fix this instead of existing devices on older LTS kernels?
> 

the fix have stable and fix tags. not sure if we can control its
backporting. the fix has been backported to 6.1/6.6/6.12/6.13 automatically.


> Thanks,
> Will
> 
>>
>>>
>>> Fixes: 3f0c82066448 ("drivers: of: add initialization code for dynamic reserved memory")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>> ---
>>>  drivers/of/of_reserved_mem.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
>>> index 45517b9e57b1add36bdf2109227ebbf7df631a66..d2753756d7c30adcbd52f57338e281c16d821488 100644
>>> --- a/drivers/of/of_reserved_mem.c
>>> +++ b/drivers/of/of_reserved_mem.c
>>> @@ -409,12 +409,12 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
>>>  
>>>  	prop = of_get_flat_dt_prop(node, "alignment", &len);
>>>  	if (prop) {
>>> -		if (len != dt_root_addr_cells * sizeof(__be32)) {
>>> +		if (len != dt_root_size_cells * sizeof(__be32)) {
>>>  			pr_err("invalid alignment property in '%s' node.\n",
>>>  				uname);
>>>  			return -EINVAL;
>>>  		}
>>> -		align = dt_mem_next_cell(dt_root_addr_cells, &prop);
>>> +		align = dt_mem_next_cell(dt_root_size_cells, &prop);
>>>  	}
>>>  
>>>  	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
>>>
>>> -- 
>>> 2.34.1
>>>


