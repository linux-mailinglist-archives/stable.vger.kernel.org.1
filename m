Return-Path: <stable+bounces-119771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED89A46F60
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 00:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBA0D188D271
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 23:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B93F25DAFE;
	Wed, 26 Feb 2025 23:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="oi7wnh+G"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10011301.me.com (pv50p00im-ztdg10011301.me.com [17.58.6.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1413B25BAC2
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 23:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740612365; cv=none; b=HVvABCsz1SWNSgCe5uOUiL3JzvF+zXQvmAg1adcgwQfdTmUlbZQukTt1KQMK/lsTA/+luOworipBfyLOI+cfqZfvxtgYXmQg5s24OtKF25Ib87QvwvrQ1BQSZXBeFmeXwNsp/1eUr2qaDcJDfI4HbfG31BxmwxU1jUyJHhe3gUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740612365; c=relaxed/simple;
	bh=s4ncgw8Lea9rtYWCv4yfRyXlV4HCrm7tRPtcwpzOc94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/lLKSM2NDptmi430N+fD253f1qNX17aErYfk2So6CToXDcnhcjtl20CXMBDwI/2LGF8GxfzqAINCFg08rxYzpx63Lu9n+H47OAUydUZmBWDtFVqPFUXUpZWT2S00cF+DzctIRAxc7Xrmgxlpz95enlwadPJOpNBMYSSqYgSviY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=oi7wnh+G; arc=none smtp.client-ip=17.58.6.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=SLGhhg9zZBS351ed44ROn6vuM4DND2a8FR0tSO6T5zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=oi7wnh+GSG4IVh6zEGl2hvunJAT5gfh2Y2V0M7YmZzWEdj82iSUw4fsB80HEBcMOL
	 D+T5Ke5/SGfjGayNyViYFQdNguxb3zxX0IROZ9fQca3L/i77ErQhzV24Z19MbRgo4d
	 a46qVwJUJjhCb+nbTx5fxyNGEpa7sbWV79xORe/8Md8NPzS2LVepJnM6h+GhW8WNh6
	 bvEGn/TK7XwkqcQzOoLbZjsYdkt2748Tt2vtJTW5krjPyn/jyVZZjkpoc0liAk3BvT
	 V98umIK7+2rewTgu28soRQ85gCvjLXjubHU2+g01mzTbrQdXdBcvtxZmai4bi5pcAW
	 /ggw11PBRp2Nw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id C123B180415;
	Wed, 26 Feb 2025 23:25:52 +0000 (UTC)
Message-ID: <b3a103b8-7774-49c5-9d8a-04a9dae2c210@icloud.com>
Date: Thu, 27 Feb 2025 07:25:48 +0800
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
Cc: Zijun Hu <quic_zijuhu@quicinc.com>, Saravana Kannan
 <saravanak@google.com>, Maxime Ripard <mripard@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Grant Likely
 <grant.likely@secretlab.ca>, Marc Zyngier <maz@kernel.org>,
 Andreas Herrmann <andreas.herrmann@calxeda.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Mike Rapoport <rppt@kernel.org>,
 Oreoluwa Babatunde <quic_obabatun@quicinc.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel-team@android.com
References: <20250109-of_core_fix-v4-0-db8a72415b8c@quicinc.com>
 <20250109-of_core_fix-v4-9-db8a72415b8c@quicinc.com>
 <20250113232551.GB1983895-robh@kernel.org> <Z70aTw45KMqTUpBm@google.com>
 <97ac58b1-e37c-4106-b32b-74e041d7db44@quicinc.com>
 <Z74CDp6FNm9ih3Nf@google.com> <20250226194505.GA3407277-robh@kernel.org>
 <f81e6906-499c-4be3-a922-bcd6378768c4@icloud.com>
 <CAL_Jsq+P=sZu6Wnqq7uEnGMnAQGNEDf_B+VgO8E8ob4RX8b=QA@mail.gmail.com>
 <Z7-JY1jQnEVzEley@google.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <Z7-JY1jQnEVzEley@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: A6veUJNcRRIgOhpTKso4hHeD8JCvsce9
X-Proofpoint-ORIG-GUID: A6veUJNcRRIgOhpTKso4hHeD8JCvsce9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_07,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0 clxscore=1015
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502260182

On 2025/2/27 05:36, William McVicker wrote:
>> Every time this code is touched, it breaks. This is not even the only
>> breakage right now[1].
> You can find the Pixel 6/7/8/9 device trees on android.googlesource.com.
> You can see for zuma based devices (Pixel 9 for example) they have this [1]:
> 
>   &reserved_memory {
>         #address-cells = <2>;
>         #size-cells = <1>;
>         vstream: vstream {
>                 compatible = "shared-dma-pool";
>                 reusable;
>                 size = <0x4800000>;
>                 alignment = <0x0 0x00010000>;
>                 alloc-ranges = <0x9 0x80000000 0x80000000>,
>                                <0x9 0x00000000 0x80000000>,
>                                <0x8 0x80000000 0x80000000>,
>                                <0x0 0x80000000 0x80000000>;
>         };
> 
> I understand this code is downstream, but as a general principle we shouldn't
> break backwards compatibilty.

this is not backward compatibility issue. it is a downstream bug instead.

normally, you need to write DTS according to relevant DT binding spec or
DT spec.

i can't access the link you shared due to my country's GFW.
does google kernel have extra binding spec about size of property
'alignment'?

IMO, downstream maintainers may needs to fix this issue by if the
upstream fix is picked up.
- alignment = <0x0 0x00010000>;
+ alignment = <0x00010000>;

actually, "The importance of getting code into the mainline" within
Documentation/process/1.Intro.rst encourages upstream your code to
avoid such issue.


