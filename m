Return-Path: <stable+bounces-120206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2057A4D4C5
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 08:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D153A947F
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 07:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CCD1F4E39;
	Tue,  4 Mar 2025 07:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QQsLH7M7"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E801F3B8B;
	Tue,  4 Mar 2025 07:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741073192; cv=none; b=VQlBTixwi5O2N40fB8Z38fTs0m/O3xx+6n4pfuYTXKRINEjC/8gF3hcX5KF7f3qSlSsEks85rk0CkDl9FoJ9ZOXy61oBuwQSQnP3SU9DMexm98EBS38VlmlPFa9ee90/CRn3m7mge+GtAgjYT25gwyDBGAofjxMxRo42jMVWmu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741073192; c=relaxed/simple;
	bh=+Ui5C9JG8pRJVx6WcFdHq5Id9wMBw/pJ1/wUpeSdzMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pjVlGtO/ddFgRv4q48axH6wgTuOSS2ocwdrLijTwdbHCRfvcZx2liSx7vOhZloHiNcmv47yVWdmY6jEnzSnTUE6DQKk6e2OIud8ntlMQv9JJCV+Q425X+ikD9WT5Fg4mp3o7MpSk8KI8Xtwfmbq8+BMHNJdTwfzOAQV5f4aJMCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QQsLH7M7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523NX4Cu017209;
	Tue, 4 Mar 2025 07:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ckNT9zT97qmSsY9ujs7VbRLG9X+HS54zgHMiqLy7EEg=; b=QQsLH7M73VHftWIk
	UCeiSKxPmmnMOZM4QTni7oHMeF6h1dwvH3OoLi1Nc24vn8Fmgs5JE1x+qbOKAuSK
	ysXwb+pUpT3q11qDF8EkMdrBI+IiwgY972pLXdrJFWd3JypzyUV1D7MU9NXxs4LT
	lHkNw/oQdwlRTlD2Mg4ToUfCOBJ6NkN6zPdBOB7sKazbTsOyeAP8ZIzOedcpfcBA
	qCBQjPmrSPpjw8dtT6XYJG3kNR5+5+Q//YnowFWHF72sdWpVQDx5PWTDf4Xy9ow6
	9M8CKQsH81DEKfWIr76LvDvNMAMWO/vRMUGY7UauRlyIHHY/qBcB2d1PM+1NEAN1
	cLjqvA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6th1yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 07:26:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5247Q2Pq012111
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Mar 2025 07:26:03 GMT
Received: from [10.253.15.36] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Mar 2025
 23:25:58 -0800
Message-ID: <b68799da-7290-418a-b7db-4cfad7b12e0f@quicinc.com>
Date: Tue, 4 Mar 2025 15:25:55 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] arm64: mm: Populate vmemmap at the page level if not
 section aligned
To: David Hildenbrand <david@redhat.com>, <anshuman.khandual@arm.com>,
        <catalin.marinas@arm.com>
CC: <will@kernel.org>, <ardb@kernel.org>, <ryan.roberts@arm.com>,
        <mark.rutland@arm.com>, <joey.gouly@arm.com>,
        <dave.hansen@linux.intel.com>, <akpm@linux-foundation.org>,
        <chenfeiyang@loongson.cn>, <chenhuacai@kernel.org>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <quic_tingweiz@quicinc.com>,
        <stable@vger.kernel.org>
References: <20250219084001.1272445-1-quic_zhenhuah@quicinc.com>
 <78d55e35-6cda-4f5e-8e52-0a54b1e64592@redhat.com>
Content-Language: en-US
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <78d55e35-6cda-4f5e-8e52-0a54b1e64592@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=PMb1+eqC c=1 sm=1 tr=0 ts=67c6ab0b cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=20KFwNOVAAAA:8
 a=OyIDkqIgn3q2G5mQ1iQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: qN3xRsxJfR6rENMgdFiS9cnF5DmYD864
X-Proofpoint-GUID: qN3xRsxJfR6rENMgdFiS9cnF5DmYD864
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_03,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040061



On 2025/3/3 18:01, David Hildenbrand wrote:
> On 19.02.25 09:40, Zhenhua Huang wrote:
>> On the arm64 platform with 4K base page config, SECTION_SIZE_BITS is set
>> to 27, making one section 128M. The related page struct which vmemmap
>> points to is 2M then.
>> Commit c1cc1552616d ("arm64: MMU initialisation") optimizes the
>> vmemmap to populate at the PMD section level which was suitable
>> initially since hot plug granule is always one section(128M). However,
>> commit ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
>> introduced a 2M(SUBSECTION_SIZE) hot plug granule, which disrupted the
>> existing arm64 assumptions.
>>
>> The first problem is that if start or end is not aligned to a section
>> boundary, such as when a subsection is hot added, populating the entire
>> section is wasteful.
>>
>> The next problem is if we hotplug something that spans part of 128 MiB
>> section (subsections, let's call it memblock1), and then hotplug 
>> something
>> that spans another part of a 128 MiB section(subsections, let's call it
>> memblock2), and subsequently unplug memblock1, vmemmap_free() will clear
>> the entire PMD entry which also supports memblock2 even though memblock2
>> is still active.
>>
>> Assuming hotplug/unplug sizes are guaranteed to be symmetric. Do the
>> fix similar to x86-64: populate to pages levels if start/end is not 
>> aligned
>> with section boundary.
>>
>> Cc: <stable@vger.kernel.org> # v5.4+
>> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
>> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
>> ---
>> Hi Catalin and David,
>> Following our latest discussion, I've updated the patch for your review.
>> I also removed Catalin's review tag since I've made significant 
>> modifications.
>>   arch/arm64/mm/mmu.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index b4df5bc5b1b8..de05ccf47f21 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1177,8 +1177,11 @@ int __meminit vmemmap_populate(unsigned long 
>> start, unsigned long end, int node,
>>           struct vmem_altmap *altmap)
>>   {
>>       WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
>> +    /* [start, end] should be within one section */
>> +    WARN_ON(end - start > PAGES_PER_SECTION * sizeof(struct page));
>> -    if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES))
>> +    if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES) ||
>> +        (end - start < PAGES_PER_SECTION * sizeof(struct page)))
> 
> Indentation should be
> 
>      if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES) ||
>          (end - start < PAGES_PER_SECTION * sizeof(struct page)))
> 

Thanks, I will repost with the above fix and WARN_ON_ONCE as you 
preferred in v7.

> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 
> 
> Thanks!
> 


