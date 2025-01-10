Return-Path: <stable+bounces-108164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE014A085CA
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 04:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE1F16A1B6
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 03:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE20F1E32BD;
	Fri, 10 Jan 2025 03:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="llvQAqGW"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84D72942A;
	Fri, 10 Jan 2025 03:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736478839; cv=none; b=mawU+GszH6vOMUbQrdxDBa6fk8HJSOBs9e2ZFBO0GJaWNnoriIQ6v9D0sqsZoSyNGt3HJ2kTw3jYLFsvi4WiodBR+hh/xts/lU79UidLLLpL+Kw3lqluNk2FxX14ccNRwVqPRFM4Ci8dRAlF9g19/5cnc+Fcp8yemGm1AMXMdVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736478839; c=relaxed/simple;
	bh=nYP4OR7ERDy7/UxHS2vRSXCTyDH3zTpFpa17SZ+3V/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YnfsYBkKgg0DngCv/EziakbJjYdy4SIGOEM1Bz9oab23GgVs4iNIUYFBy1lYzNNbswG/8kXa+mUtj9/NlP7D7tqQ4k5eC6RDJ1udeBh1IUwf3YQ8K4g8njhkj+rEQeuRzBoip3nrzRW+uUIzi6ljIcK+fRerQuJc6un6YonYvUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=llvQAqGW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A0XX24028314;
	Fri, 10 Jan 2025 03:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fq7/wpTIKQ6rlSsWJvkOiFN+/C7V222Fj1m252h7CnU=; b=llvQAqGWITf76f2H
	9nrzWubDDE3tK0YKtSXoRzf4BBqed90mor9A+DSs+ZwOg+MZbldBxT87WvBuEwLW
	uwES6ADlc8R5MJGrbSf2abprAYxSW6a62W66UkzKVYLx6T53ncv5nF86FaNjJaUV
	yOHVYO45cR/ND03l9Vj8DMfxG399YqUFKfHXt/uTTNAJmUoqlKe3n90ppg51ldOL
	1n0noEHu2pOwym/0JRKyQQZwhdel+qvkmKueCxa4aZMNAZveJAusMwLKXJAFld4Y
	uS0njvetv0hMI3CcANzMUAiA3L1okcSngH0catIEi7Y8QrJ2MBUsVjR2C2l8En8k
	erYUzA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442s4509vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 03:13:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50A3DWd5001263
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 03:13:32 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 9 Jan 2025
 19:13:29 -0800
Message-ID: <bc843a93-42c7-4317-bd3d-dc48c63e095d@quicinc.com>
Date: Fri, 10 Jan 2025 11:13:27 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm64: mm: Populate vmemmap/linear at the page level
 for hotplugged sections
To: Catalin Marinas <catalin.marinas@arm.com>
CC: Anshuman Khandual <anshuman.khandual@arm.com>, <will@kernel.org>,
        <ardb@kernel.org>, <ryan.roberts@arm.com>, <mark.rutland@arm.com>,
        <joey.gouly@arm.com>, <dave.hansen@linux.intel.com>,
        <akpm@linux-foundation.org>, <chenfeiyang@loongson.cn>,
        <chenhuacai@kernel.org>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <quic_tingweiz@quicinc.com>, <stable@vger.kernel.org>
References: <20250107074252.1062127-1-quic_zhenhuah@quicinc.com>
 <Z31--x4unDHRU5Zo@arm.com> <406d5113-ff3d-4c2a-81f0-de791bcbeffb@quicinc.com>
 <1c1504a7-3515-48f2-8ca7-15b2379dea22@arm.com>
 <1515dae4-cb53-4645-8c72-d33b27ede7eb@quicinc.com> <Z3_d59kp4CuHQp97@arm.com>
Content-Language: en-US
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <Z3_d59kp4CuHQp97@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jr38wu0jPi1WyjFwWcsWSY7Xw3cGEs3-
X-Proofpoint-GUID: jr38wu0jPi1WyjFwWcsWSY7Xw3cGEs3-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=972
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100024



On 2025/1/9 22:32, Catalin Marinas wrote:
> On Thu, Jan 09, 2025 at 03:04:22PM +0800, Zhenhua Huang wrote:
>> On 2025/1/8 18:52, Anshuman Khandual wrote:
>>>> I found another bug, that even for early section, when
>>>> vmemmap_populate is called, SECTION_IS_EARLY is not set.
>>>> Therefore, early_section() always return false.
> [...]
>>>> Since vmemmap_populate() occurs during section initialization, it
>>>> may be hard to say it is a bug.. However, should we instead using
>>>> SECTION_MARKED_PRESENT to check? I tested well in my setup.
>>>>
>>>> Hot plug flow:
>>>> 1. section_activate -> vmemmap_populate
>>>> 2. mark PRESENT
>>>>
>>>> In contrast, the early flow:
>>>> 1. memblocks_present -> mark PRESENT
>>>> 2. __populate_section_memmap -> vmemmap_populate
>>>
>>> But from a semantics perspective, should SECTION_MARKED_PRESENT be marked on a
>>> section before SECTION_IS_EARLY ? Is it really the expected behaviour here or
>>> that needs to be fixed first ?
>>
>> The tricky part is vmemmap_populate initializes mem_map, that happens during
>> mem_section initialization process. PRESENT or EARLY tag is in the same
>> process as well. There doesn't appear to be a compelling reason to enforce a
>> specific sequence..
> 
> The order in which a section is marked as present and vmemmap created
> does seem a bit arbitrary. At least the early code seems to rely on the
> for_each_present_section_nr() loop, so we'll always have this first but
> it's not some internal kernel API that guarantees this.
> 
>>> Although SYSTEM_BOOTING state check might help but section flag seems to be the
>>> right thing to do here.
>>
>> Good idea, I prefer to vote for this alternative rather than PRESENT tag. As
>> I see we already took this stage to determine whether memmap pages are boot
>> pages or not in common mm code:
>> https://elixir.bootlin.com/linux/v6.13-rc3/source/mm/sparse-vmemmap.c#L465
> 
> The advantage of SYSTEM_BOOTING is that we don't need to rely on the
> section information at all, though we could add a WARN_ON_ONCE if the
> section is not present.

Hi Catalin,

Sorry, but I don't fully understand your comment here, IIUC we shouldn't 
  add WARN_ON_ONCE in vmemmap_populate(). As you mentioned above, early 
code relies on section present. while the hotplug code does not 
guarantee, it will set PRESENT after calling vmemmap_populate().
By the way, seems you're not opposed to using SYSTEM_BOOTING ? If so, 
please take a look at latest post:
https://lore.kernel.org/linux-mm/20250109093824.452925-1-quic_zhenhuah@quicinc.com/
Thanks very much!
> 


