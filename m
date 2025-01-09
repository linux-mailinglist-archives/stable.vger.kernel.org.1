Return-Path: <stable+bounces-108060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAF3A06E99
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 08:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B10167AA0
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 07:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9455A2144A3;
	Thu,  9 Jan 2025 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gWcjIkzW"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E992036F4;
	Thu,  9 Jan 2025 07:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736406295; cv=none; b=Qj8IJYtaFB84XAq7kDdEt26cDOERGVfFnC+atyoNZMQzCjnSM8TIa80lxmQPlMefeWMH5w+1dzPhdeGk3dSUVbZLNiPaM0C/bkiUvGqmuW5kHXZq8m4dWld54YEuNkm3CWOP0xrRYa6CzkBDI7BsGxTgl59bdqjzq2h2oUbD4x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736406295; c=relaxed/simple;
	bh=vF8v8mXSTae3aRf5twNyvWl9jOsfBDpruxzB6ALTiz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z2EOiGWHB4zHms195o0QYby7vVV8+ypwZnbhWGpoG0kO6NDuZTlXfcvINcSFVL+UZAj7PLA8t+GFt11mJ63sD0ELL6aQL2Jyt7K7hOoEWhCGca5QBNLK7hSVTXXn4ELe0TorfplskrXm4YJBvcyXf7bI1OLyP9fG/ipcolDh4iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gWcjIkzW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5094gd74018333;
	Thu, 9 Jan 2025 07:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	87FV4YrIQ7z0jxyKrabSGJYQLHTBVu6L6ppZv7huBcU=; b=gWcjIkzWjCPQEr/f
	1/XrfyWeVrLrNp9a1kMwPD+PycHjgQmkxj39IVopJdezCZlku10GgeyYYHkDBP4v
	1b7lTSSXYmrxeYmr50SEqOXcatEugwKcA+l/f55/M7Q2wxp1hl0hZya+4aw4Mw7j
	IV5hFY8YmoyxLIdSPnlYRO+DtB6DjN9xG2zMocRwIBlTHano4my0VW0h3vy6RLxE
	RgD6sxA+Yseujey4Z2+Bs3bzT7PiN/4GmQIRe13jIDu/xtx6KjFajmB6Rt3ZA/EB
	NmU7iPU2VC2/XwNAlhF0s5eOxWHxNhoyWy8gKmsuWeDU+3j2GHOxNHR8cMNGvTi3
	Kag6NA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4427nwr996-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 07:04:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50974SLv020305
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Jan 2025 07:04:28 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 8 Jan 2025
 23:04:24 -0800
Message-ID: <1515dae4-cb53-4645-8c72-d33b27ede7eb@quicinc.com>
Date: Thu, 9 Jan 2025 15:04:22 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm64: mm: Populate vmemmap/linear at the page level
 for hotplugged sections
To: Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas
	<catalin.marinas@arm.com>
CC: <will@kernel.org>, <ardb@kernel.org>, <ryan.roberts@arm.com>,
        <mark.rutland@arm.com>, <joey.gouly@arm.com>,
        <dave.hansen@linux.intel.com>, <akpm@linux-foundation.org>,
        <chenfeiyang@loongson.cn>, <chenhuacai@kernel.org>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <quic_tingweiz@quicinc.com>,
        <stable@vger.kernel.org>
References: <20250107074252.1062127-1-quic_zhenhuah@quicinc.com>
 <Z31--x4unDHRU5Zo@arm.com> <406d5113-ff3d-4c2a-81f0-de791bcbeffb@quicinc.com>
 <1c1504a7-3515-48f2-8ca7-15b2379dea22@arm.com>
Content-Language: en-US
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <1c1504a7-3515-48f2-8ca7-15b2379dea22@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xy9B2SvRFf9KMrsnmkiTJDZlnOkSlvK1
X-Proofpoint-GUID: xy9B2SvRFf9KMrsnmkiTJDZlnOkSlvK1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=850
 mlxscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090056



On 2025/1/8 18:52, Anshuman Khandual wrote:
>> I found another bug, that even for early section, when vmemmap_populate is called, SECTION_IS_EARLY is not set. Therefore, early_section() always return false.
> Hmm, well that's unexpected.
> 
>> Since vmemmap_populate() occurs during section initialization, it may be hard to say it is a bug..
>> However, should we instead using SECTION_MARKED_PRESENT to check? I tested well in my setup.
>>
>> Hot plug flow:
>> 1. section_activate -> vmemmap_populate
>> 2. mark PRESENT
>>
>> In contrast, the early flow:
>> 1. memblocks_present -> mark PRESENT
>> 2. __populate_section_memmap -> vmemmap_populate
> But from a semantics perspective, should SECTION_MARKED_PRESENT be marked on a
> section before SECTION_IS_EARLY ? Is it really the expected behaviour here or
> that needs to be fixed first ?

The tricky part is vmemmap_populate initializes mem_map, that happens 
during mem_section initialization process. PRESENT or EARLY tag is in 
the same process as well. There doesn't appear to be a compelling reason 
to enforce a specific sequence..

> 
> Although SYSTEM_BOOTING state check might help but section flag seems to be the
> right thing to do here.

Good idea, I prefer to vote for this alternative rather than PRESENT 
tag. As I see we already took this stage to determine whether memmap 
pages are boot pages or not in common mm code:
https://elixir.bootlin.com/linux/v6.13-rc3/source/mm/sparse-vmemmap.c#L465

Would like to hear Catalin's perspective ?:)

