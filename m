Return-Path: <stable+bounces-119833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 381E8A47CAF
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 12:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2E31891EDF
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 11:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1575B22CBF5;
	Thu, 27 Feb 2025 11:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Kk9xEzm4"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-tydg10021701.me.com (pv50p00im-tydg10021701.me.com [17.58.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98578227B9C
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 11:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740657324; cv=none; b=C3xlpmb/5miaL7Mfq3e5exH35OGxoF1XhlUNjm0GX0PUpN+tcVAkukhYTQsVZPqmMnT4eJ10tOdHBzDsmCZFqF2xr2Ahkpe7b9RD92/b4LZYA27js5pCLvXiVR7wYDn8afBfyQWYJvGHMTCm4eFH7eaQgBVF//t9W3oOE2PL7Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740657324; c=relaxed/simple;
	bh=mX8bCrezi2SBEq307h0BDDNS0Y6aMAiuI3q63/7p04M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bL+gqgRVRCr7NxGOPGKmdX2wQJOETJCzccy8x/jIvPwZ8D1j5o4fX1jyD9aQx4qpa4eS7xqR17QxjvkPCPpQ0pk8NSEKhwrcoCneWh7knDOAOMomzazZ4qOFv4bJsAPYCZWKwrRcTQYfrNqjtwroKJd1cWlRiLYdge9RvLb8z9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Kk9xEzm4; arc=none smtp.client-ip=17.58.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=+dzuzJ1KREXh+9vUQU7cOm+oGt4rcpULKbxL92N/Xig=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=Kk9xEzm4C81PzXUuK2YXesJwRPNfQblUxs6NZFKWqOKPxMzD0+361uC8eJR+KQkKQ
	 6rsXMWuo1eQ3N30o1CvaUtY8ILrD9aSSw2gplUVEjhBzlLKoU0Ki9qJPiYOU7SYyhN
	 53uEow7ywL+QMh1FpcAAJxiNdxTHnsk6WGxFutITA+wU2t1cW3zPqoUY6JjvzgEcNF
	 dCBepQAPuFSQmzMkBAMx0azaPWP9z0rzGDVkdX+9yBoEnXXJiLRmu0qIOtuVqI1dDC
	 g4b4FNY73uk+O4Y/xttmvItjO3D+/ZUPr7TRSLBLDqZeA1rYb/ysFwK3d3GJKKi0ST
	 oXY0MTjTcnk2g==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id 9FE0ECC6B92;
	Thu, 27 Feb 2025 11:55:13 +0000 (UTC)
Message-ID: <5793c7cd-8223-48e2-9c91-f92be09d3dab@icloud.com>
Date: Thu, 27 Feb 2025 19:55:09 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/14] of: reserved-memory: Fix using wrong number of
 cells to get property 'alignment'
To: Rob Herring <robh@kernel.org>
Cc: William McVicker <willmcvicker@google.com>,
 Zijun Hu <quic_zijuhu@quicinc.com>, Saravana Kannan <saravanak@google.com>,
 Maxime Ripard <mripard@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Grant Likely <grant.likely@secretlab.ca>, Marc Zyngier <maz@kernel.org>,
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
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <CAL_Jsq+P=sZu6Wnqq7uEnGMnAQGNEDf_B+VgO8E8ob4RX8b=QA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Cx7SZ0iQSm1NDQb_GaTdhq14QIDycMOf
X-Proofpoint-ORIG-GUID: Cx7SZ0iQSm1NDQb_GaTdhq14QIDycMOf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_05,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 clxscore=1015 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=896
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2502270090

On 2025/2/27 05:30, Rob Herring wrote:
> Every time this code is touched, it breaks. This is not even the only
> breakage right now[1].
> 
>> 2) IMO, the spec may be right.
>>    The type of size is enough to express any alignment wanted.
>>    For several kernel allocators. type of 'alignment' should be the type
>>    of 'size', NOT the type of 'address'
> As I said previously, it can be argued either way.
> 
> Rob
> 
> [1] https://lore.kernel.org/all/20250226115044.zw44p5dxlhy5eoni@pengutronix.de/

this issue may be a downstream issue as well.

based on comments. they expects the CMA area is within 4G range.

but the wrong alloc-ranges config make the range (0x42000000 +
0xc0000000) > 4G across 4G boundary.


