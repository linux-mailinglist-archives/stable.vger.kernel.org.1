Return-Path: <stable+bounces-108604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3755A109EC
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 15:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18A1166A28
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 14:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1CC14B955;
	Tue, 14 Jan 2025 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="GqMYE55W"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-zteg10021301.me.com (pv50p00im-zteg10021301.me.com [17.58.6.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18551411C8
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736866376; cv=none; b=No0touSMUbtOOnQuItJv+v1VQ6qx7FfQ2WxfCNwRrYcdRbUfLXc7cL9NN9A8V1/EvhPKad4VHQLrn6Dj3ue217uGoi7QPrXnDUPMLdFzNI2XNXPb40KmZiITIMk4RbCCvmRXdc3US/Pu9yY+5mTWekTvO8I6tSr85m4qbTs5BFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736866376; c=relaxed/simple;
	bh=nm6KDBWSC6V2yQZSzSZpSXCbe/4IkXIekVdMlXyEIrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b8RwUBfHExPFFPGSUlGzFMTMO5VGaipJm4DYhZPHERu6Nc+nFo7QtPF/31SUtmxpvGZirTFa/dDR6DJ387fMzDSmSz+6Y3NyAlYweqJbstQmcnFKw0YSF0ePNtRLcoAQlE1KGK0899czQdyzQ6DHPDbaEeRSCwytfRLFJ3ZEUjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=GqMYE55W; arc=none smtp.client-ip=17.58.6.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1736866374;
	bh=6Zmvz4E6wN+/s7A8ScWWoIfWGpOhFeHcM8f2UgBgUwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=GqMYE55Wblj+O7p2Ecq2O+oFNCkhwTNQL3f6FoROtKYVMJ4loAHmlzSK3oD7YKxqg
	 zH6goQ5YLR+Tn3FOHQCidmrc78zImwkgd4XEKClnYixBfKYgXl95kPPAkQfBwjI9GG
	 3M3dCaYtc7dOgg0lnvKjmj3uDMQJJCCHf73DeyUQ/sajjktTE/cVZTgYZT7fBDsmsf
	 PM869q5eRoH9Jt1aLxoHEVHu8YKr6qihqi9lBPoAPI5vKsysIkk6hG6P57WBkrkryr
	 KdLRN5XsY6ylptoIuP3Ls+xpEl3zRh9cWrsjB+zgG3fJGuoQVagnD4ROoB9nHoYcDK
	 gwyNghk6sN33w==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021301.me.com (Postfix) with ESMTPSA id C378550037E;
	Tue, 14 Jan 2025 14:52:47 +0000 (UTC)
Message-ID: <8c593e1d-6c57-427f-9f09-f968ceba6713@icloud.com>
Date: Tue, 14 Jan 2025 22:52:43 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/14] of: reserved-memory: Warn for missing static
 reserved memory regions
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, Maxime Ripard
 <mripard@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Grant Likely <grant.likely@secretlab.ca>, Marc Zyngier <maz@kernel.org>,
 Andreas Herrmann <andreas.herrmann@calxeda.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Mike Rapoport <rppt@kernel.org>,
 Oreoluwa Babatunde <quic_obabatun@quicinc.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>,
 stable@vger.kernel.org
References: <20250109-of_core_fix-v4-0-db8a72415b8c@quicinc.com>
 <20250109-of_core_fix-v4-11-db8a72415b8c@quicinc.com>
 <20250113231619.GA1983895-robh@kernel.org>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20250113231619.GA1983895-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _ojIg84qqfQ7kKla5Jd0T_gDFFGoJ5Jw
X-Proofpoint-GUID: _ojIg84qqfQ7kKla5Jd0T_gDFFGoJ5Jw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_04,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=968 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501140118

On 2025/1/14 07:16, Rob Herring wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> For child node of /reserved-memory, its property 'reg' may contain
>> multiple regions, but fdt_scan_reserved_mem_reg_nodes() only takes
>> into account the first region, and miss remaining regions.
>>
>> Give warning message when missing remaining regions.
> Can't we just fix it to support more than 1 entry?

actually, i ever considered supporting more entries.
and find out there are no simple approach to achieve this aim.

it may need to change 'struct reserved_mem' to support multiple regions
that may also involve 4 RESERVEDMEM_OF_DECLARE instances.

RESERVEDMEM_OF_DECLARE(tegra210_emc_table, "nvidia,tegra210-emc-table",
                       tegra210_emc_table_init);
RESERVEDMEM_OF_DECLARE(dma, "shared-dma-pool", rmem_dma_setup);
RESERVEDMEM_OF_DECLARE(cma, "shared-dma-pool", rmem_cma_setup);
RESERVEDMEM_OF_DECLARE(dma, "restricted-dma-pool", rmem_swiotlb_setup);

so i finally chose this warning way due to simplification and low risk.


