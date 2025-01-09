Return-Path: <stable+bounces-108061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109B8A06E9C
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 08:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A14687A3706
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 07:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D8B1FFC7A;
	Thu,  9 Jan 2025 07:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O5Xa5hWT"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C271FFC52;
	Thu,  9 Jan 2025 07:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736406322; cv=none; b=rMcg9i/knaJnMXpZM6TlpleAu7269znbCo6B2YRt3x8hv1oLOPFp1+RhmmSBWOTgFbMKXqu9EKZa9XPVJYhCgYOAF/O2t96iZpGTzKFXSTBMl/VKsi99DdFpTwZsFkzBLimsDfMvgplsJzTeN7qn5Itic2cwie+gs1nONSX95V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736406322; c=relaxed/simple;
	bh=vqVD4Zca/DuwFnuDem+sE/2OysEmL354PJGaHAqoa84=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OG2PqtamnYvk/RFjLMxUd/ZMzkMcI3jIPKIvxozvDgr1pRBl3DC6SvPhvQmgMPwreuEizHCT5unZr+bXsTUE2ex0j6ma2gYibdz7GQ0JxVHappME3G6h7gBlXhzd5XKHvvnY9Y2Q7o180T5I18OFwgPvs9x+L8db8ROWGIwM7gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O5Xa5hWT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5094EvRY009614;
	Thu, 9 Jan 2025 07:04:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	faXKx5JyBLEPD6tryFnH16a9m3UBc5HuVMYyWfnWTQ0=; b=O5Xa5hWTTPHEDWYg
	/rs4WIueZxRilD6XHR15CzpvIApum2UBoJwBU0pIhFVpii/Hn0WJaHEwGOk6j00w
	I2TOIySvT54dTO91J582x0MVxx6fnD1/+Nq8Bix50AMgwqvHvbG6d0Uvmc0r441u
	8vxyBElYvqqsYlBEI+cRBKKecLW4Cmxi6PrWVM2Rr/Qa/PUehiBZyZmKBC4o1UFS
	4PdsVWWXKJ+IY9T8DMbPFuO8ube2mm/NF2cWPxlUUC5Bfj8M91QDCYYXvocY0B9A
	puOAYPIRSyTC40aB/eLWSb71tbqqqKX0hTUQiyRboiu4f4hfOYz5TPzwkFWsZTwM
	2730Uw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44278t8b03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 07:04:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50974s5Q010347
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Jan 2025 07:04:54 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 8 Jan 2025
 23:04:50 -0800
Message-ID: <169f8006-ff33-48ca-a680-37fe1cf0efe8@quicinc.com>
Date: Thu, 9 Jan 2025 15:04:48 +0800
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
 <Z31--x4unDHRU5Zo@arm.com> <fbb134e0-cfeb-4c6e-98b4-d945f95383db@arm.com>
Content-Language: en-US
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <fbb134e0-cfeb-4c6e-98b4-d945f95383db@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6sl83KDxCPtkIpOtbE4vMDGqTTuXFubv
X-Proofpoint-ORIG-GUID: 6sl83KDxCPtkIpOtbE4vMDGqTTuXFubv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 adultscore=0 mlxlogscore=724 suspectscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501090056



On 2025/1/8 18:11, Anshuman Khandual wrote:
> Just wondering why not start with PUD level itself ? Although SUBSECTION_SHIFT
> might never reach the PUD level but this will help keep the flags calculations
> bit simple and ready for all future changes.
> 

I suppose that it's because these are significantly larger than 2M, 
whereas Catalin assumed SUBSECTION_SIZE would not increase?
His comment:
"should cover any changes to SUBSECTION_SHIFT making it *smaller* than 
2MB. "

> 	flags = 0;
>   	if (SUBSECTION_SHIFT < PUD_SHIFT)
>   		flags |= NO_PUD_BLOCK_MAPPINGS;
>   	if (SUBSECTION_SHIFT < CONT_PMD_SHIFT)
>   		flags |= NO_PMD_CONT_MAPPINGS;


