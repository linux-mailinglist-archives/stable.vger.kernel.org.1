Return-Path: <stable+bounces-115109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 854C1A33927
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 08:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A73703A5A54
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 07:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0A120B1E0;
	Thu, 13 Feb 2025 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Lw3o8Wtt"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47B520AF96;
	Thu, 13 Feb 2025 07:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739432791; cv=none; b=UnJI1l0ui1zvWBLtmETpXhakdh7QVBqhbDbAw+dMqor9oY7O2WJHCbAUgCfTm9wmJJAf8a/FhMsZaqhk74UPudDzfbUoE+ni3HcPq11n+a9XLZlcBp7swwwgUSOE81/+CeRow8T0E9vjCyZqTaawk4s8wzDwLWM/fZeB+9tuTcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739432791; c=relaxed/simple;
	bh=LTlk+Q+OqAOJUrN6UgQEpR0w+zfSfFCR6/DNGGUlgc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Qo8jqA3VvlxU/TKHms1pP1nvJzADOLdu3I2/RJKX8Mv9YMuwr99KpU4Rt70yDDthrSuT1Sqij4Nmw4icdQu/ngTe189CWkjTrArUze4xSqdYfMYXQ48UnmI6PsVxH24iHYJ2wG05dBQgA/8CzhKig5WfY/5QKKgIruoe74x8KH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Lw3o8Wtt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CIlBdn001335;
	Thu, 13 Feb 2025 07:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Nbm7pMR3sppbaW6MivVssSNUZKFF+Yg1bC2W6Ym5u8c=; b=Lw3o8WtttHYwMIEc
	eR0749HKN1mOosx+2n65ajRX7+SP0M0JS2mS/1SJwCP+new4pXVbgyw0nTJTBUYO
	84VvFZJlwnCUvLu3G5Q8WMto3pqD7i+H3d3i/Uf3uHO/rSzH2jf2DsOtx60aBD0s
	HgccnCr17KQfSNC7KhXrDYwTUgwjbcYflXram8et1Y0WQDztJMRMdejbP5yVnDMz
	OCA/AoOTJxjR03WIwARwKvZIOWJGez63NoEF9+rUrgoWRvAAoq3aLs3UpPXV4L6P
	qgXa0g8/dNE8mY/ROf8AiKMFkuGq8gW7/cww/4EL5ZXC7U9is2qFdwAYc+OR2udu
	NdbUgw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44rrnfu322-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 07:46:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51D7k1nO029626
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 07:46:01 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 12 Feb
 2025 23:45:57 -0800
Message-ID: <dc69cc0e-c3ca-4e2a-8d0e-998643f31ccf@quicinc.com>
Date: Thu, 13 Feb 2025 15:45:47 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] arm64: mm: Populate vmemmap/linear at the page level
 for hotplugged sections
To: Catalin Marinas <catalin.marinas@arm.com>
CC: <anshuman.khandual@arm.com>, <will@kernel.org>, <ardb@kernel.org>,
        <ryan.roberts@arm.com>, <mark.rutland@arm.com>, <joey.gouly@arm.com>,
        <dave.hansen@linux.intel.com>, <akpm@linux-foundation.org>,
        <chenfeiyang@loongson.cn>, <chenhuacai@kernel.org>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <quic_tingweiz@quicinc.com>,
        <stable@vger.kernel.org>
References: <20250109093824.452925-1-quic_zhenhuah@quicinc.com>
 <Z6zoWMejCDlN2YF9@arm.com>
Content-Language: en-US
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <Z6zoWMejCDlN2YF9@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oD5n2ERUG7vEUbsd4pslOiDQ1za_FgFG
X-Proofpoint-ORIG-GUID: oD5n2ERUG7vEUbsd4pslOiDQ1za_FgFG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_02,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=859 lowpriorityscore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130058



On 2025/2/13 2:28, Catalin Marinas wrote:
>> @@ -1339,9 +1349,27 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>   		    struct mhp_params *params)
>>   {
>>   	int ret, flags = NO_EXEC_MAPPINGS;
>> +	unsigned long start_pfn = PFN_DOWN(start);
>> +	struct mem_section *ms = __pfn_to_section(start_pfn);
>>   
>>   	VM_BUG_ON(!mhp_range_allowed(start, size, true));
>>   
>> +	/* should not be invoked by early section */
>> +	WARN_ON(early_section(ms));
> I don't remember the discussion, do we still need this warning here if
> the sections are not marked as early? I guess we can keep it if one does
> an arch_add_memory() on an early section.
> 
> I think I suggested to use a WARN_ON_ONCE(!present_section()) but I
> completely forgot the memory hotplug code paths.

Dear Catalin,

The previous discussion can be found at 
https://lore.kernel.org/lkml/aedbbc4f-8f6c-46d8-a8d7-53103675a816@quicinc.com/, 
I highlighted the key points from conversation between me and Anshuman 
for your reference:
"
 >>
 >> BTW, shall we remove the check for !early_section since 
arch_add_memory is only called during hotplugging case? Correct me 
please if I'm mistaken :)
 >
 > While this is true, still might be a good idea to keep the 
early_section()
 > check in place just to be extra careful here. Otherwise an WARN_ON() 
might
 > be needed.

Make sense. I would like to add some comments and WARN_ON() if
early_section().
"
Regarding your suggestion, I believed it was intended for the 
vmemmap_populate() function ?(Discussion: 
https://lore.kernel.org/linux-mm/Z3_d59kp4CuHQp97@arm.com/), but as 
workflow below indicates:
Hot plug:
1. section_activate -> vmemmap_populate
2. mark PRESENT

In contrast, the early flow:
1. memblocks_present -> mark PRESENT
2. __populate_section_memmap -> vmemmap_populate

Could this result in a false warning during hotplugging? I replied with 
the doubt in above link before but seems you missed :) Could you please 
share your thoughts if you have a different idea ?

I will include your tags, correct capitalization nit and post one new 
version.

