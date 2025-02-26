Return-Path: <stable+bounces-119751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B11A46C7C
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 21:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991843ADE51
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 20:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4BF20F060;
	Wed, 26 Feb 2025 20:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="vwRELQfF"
X-Original-To: stable@vger.kernel.org
Received: from ms11p00im-qufo17291201.me.com (ms11p00im-qufo17291201.me.com [17.58.38.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4CB1632F2
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 20:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.38.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740601874; cv=none; b=QZCFlo+HIWgJgOd13v6pCzSi01OtlAlxWNklkA+ESvtRKkrtamwH780E+tBTBDMpcUXILCHBvWvEVhn7jUGJwg6neZrFgjrqsqLs9Z2Bsy8LZ/NvY11NcZr6Vfaatp1vUyIs9AR90KBJhS7uqC7pPgAU5LfLyyMZJB2G0UV/CBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740601874; c=relaxed/simple;
	bh=xiJdXY+liRZWQBSJGmolnEALIPZZmEVT3jBhiygzaCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jEDatcCN3OF+Ul69RK0haomxpvYMTs2k1XVF8y3ZTvwt4ebnTsRn2A3y/IDsrPDkTB9/DXbtu4IIvn8Q/c6CdS9WNFqkANduA4iOkNhjS/DDwbppLBkvT1i3mxkzilGFJRVEh/21K/oODkwlseW3g285L45eQ2Re5EI1fZcpUl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=vwRELQfF; arc=none smtp.client-ip=17.58.38.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=Dgi7QNmZYJ2u237nJLmJytv4f1TM0UW/fOBb+6DRM4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=vwRELQfFht4gQtTLr7NivqqLGzh3KYy559SRxXdXntb/BMhHWwuSsB25ulbXHyszl
	 aU0CpG9pnWwtGbuPG/PMO++l9hUzW08WfUl6ZcDwqK/QXWgI45vUix2ksNZrE4jue6
	 EvT764q549OFsHKgGErZ2Aqg/2KLBz4WdRG7iVHL50YgzAah0vr2/bpsnpahyOqLKM
	 cZ/eP4bm8GLKyNx1Mu3GlTDVMC69W5KUpmeEOLm25SQ7hnAmS6nTr1xg+3lil3hG0p
	 HALKMEilRvapwkpd1ASq+4B62eNBnxSPlDeqLR08If5pzYzEfeu59goNG+2OIPpd0g
	 7QZDPf8Mlh7/A==
Received: from [192.168.1.26] (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
	by ms11p00im-qufo17291201.me.com (Postfix) with ESMTPSA id 26DBAC80315;
	Wed, 26 Feb 2025 20:31:05 +0000 (UTC)
Message-ID: <f81e6906-499c-4be3-a922-bcd6378768c4@icloud.com>
Date: Thu, 27 Feb 2025 04:31:02 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/14] of: reserved-memory: Fix using wrong number of
 cells to get property 'alignment'
To: Rob Herring <robh@kernel.org>, William McVicker <willmcvicker@google.com>
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
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20250226194505.GA3407277-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Bj0_CHyiMYshBhB0UNMQQCSmPdYk2pfI
X-Proofpoint-ORIG-GUID: Bj0_CHyiMYshBhB0UNMQQCSmPdYk2pfI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_06,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 clxscore=1011 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2502260161

On 2025/2/27 03:45, Rob Herring wrote:
>> Right, I think it's already backported to the LTS kernels, but if it breaks any
>> in-tree users then we'd have to revert it. I just like Rob's idea to instead
>> change the spec for obvious reasons 🙂
> While if it is downstream, it doesn't exist, I'm reverting this for now. 

perhaps, it is better for us to slow down here.

1) This change does not break any upstream code.
   is there downstream code which is publicly visible and is broken by
   this change ?

2) IMO, the spec may be right.
   The type of size is enough to express any alignment wanted.
   For several kernel allocators. type of 'alignment' should be the type
   of 'size', NOT the type of 'address'


> We need the tools to check this and look at other projects to see what 
> they expect. Then we can think about changing the spec.


