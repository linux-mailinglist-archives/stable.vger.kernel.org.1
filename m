Return-Path: <stable+bounces-86634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B40E19A24E9
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 16:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A57D1F2186D
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 14:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AB31DD0CE;
	Thu, 17 Oct 2024 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="dV3Z7oaH"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0680199944
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174978; cv=none; b=OGkLZhBKsekHuziQn2hH59djgRyHyy4/JTgJohbVaGvPJ4aAi2letbhakxc2I/HC7Nwmth4DdFwxndpc9xTWzpE9WXZYCnaDzSvAswKFgfUQz9EtU+jJHNNbhrn09wqtmY3L0Fyta2Is0mLLI0+WzUxIgzcsqK+Z9hzPi59iREo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174978; c=relaxed/simple;
	bh=1Cs5m8Wq/FFgHLGr6VPTVj6wElhiBzUhoA3TnYC3bDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b0IV0Fr6hSScIecCuP1zw0jspoejMCdHB5EYgcz/ztELoOIPjKBKIeLOTuRijBXAejfFf+8Y1CKC72xLTc0m1Id76K7l7pVWmgvKyJHyHoyo0RhzPn6UsTY4RRNv7by3prUrAsL9PA0i+b0lP5zODtJCPQGtrswwTblt5hZQW9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=dV3Z7oaH; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HECOBX011443;
	Thu, 17 Oct 2024 16:22:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	M5IH4NYx4I75X9RNzmg//dnlErgU4vaCdoHfvnZ3qZM=; b=dV3Z7oaH5XInNfPu
	FyiSRgArV2wYBLAl4UsyJbCtr7OiIptw7ILxlUzkkjr/nm+xL47gcOheGVNRRude
	vUiF3E+PX2kJUPEKbg/owHG4mcw1Td4bIuu3Ne25vt1MMjejsftPEMPD/mS8OQvY
	JtI62i0lIu9bOFYGVm/n1s3keAwzdYcJintcEPeJac8AlQgk1KON5xBzXoX6qxrZ
	tuAiOaMTrpx8Mqav/+8bcFJG4DcCe8YV9ff4Ov3eOjVevcFcvT6Z+BcS3WvRLYLh
	RYqL4Xx8F64Uu6Ni8neckeuWl3WrCKvl787xAupScC8RjryGtPtpSndb3Jq1uEo6
	6OMafg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 429qybktr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 16:22:18 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D290740045;
	Thu, 17 Oct 2024 16:20:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 046AB24390A;
	Thu, 17 Oct 2024 16:20:00 +0200 (CEST)
Received: from [10.48.86.107] (10.48.86.107) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 17 Oct
 2024 16:19:59 +0200
Message-ID: <69f71ac8-4ba6-46ed-b2ab-e575dcada47b@foss.st.com>
Date: Thu, 17 Oct 2024 16:19:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] ARM: ioremap: Sync PGDs for VMALLOC shadow
To: Linus Walleij <linus.walleij@linaro.org>,
        Russell King
	<linux@armlinux.org.uk>, Kees Cook <kees@kernel.org>,
        AngeloGioacchino Del
 Regno <angelogioacchino.delregno@collabora.com>,
        Mark Brown
	<broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel
	<ardb@kernel.org>
CC: Antonio Borneo <antonio.borneo@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <stable@vger.kernel.org>
References: <20241017-arm-kasan-vmalloc-crash-v3-0-d2a34cd5b663@linaro.org>
 <20241017-arm-kasan-vmalloc-crash-v3-1-d2a34cd5b663@linaro.org>
Content-Language: en-US
From: Clement LE GOFFIC <clement.legoffic@foss.st.com>
In-Reply-To: <20241017-arm-kasan-vmalloc-crash-v3-1-d2a34cd5b663@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

On 10/17/24 14:59, Linus Walleij wrote:
> [...]
>   
> +static unsigned long arm_kasan_mem_to_shadow(unsigned long addr)
> +{
> +	return (unsigned long)kasan_mem_to_shadow((void *)addr);
> +}
> +

`kasan_mem_to_shadow` function symbol is only exported with :
CONFIG_KASAN_GENERIC or defined(CONFIG_KASAN_SW_TAGS) from kasan.h

To me, the if condition you added below should be expanded with those 
two macros.

> [...]
>   void __check_vmalloc_seq(struct mm_struct *mm)
>   {
>   	int seq;
>   
>   	do {
>   		seq = atomic_read(&init_mm.context.vmalloc_seq);
> -		memcpy(pgd_offset(mm, VMALLOC_START),
> -		       pgd_offset_k(VMALLOC_START),
> -		       sizeof(pgd_t) * (pgd_index(VMALLOC_END) -
> -					pgd_index(VMALLOC_START)));
> +		memcpy_pgd(mm, VMALLOC_START, VMALLOC_END);
> +		if (IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
> +			unsigned long start =
> +				arm_kasan_mem_to_shadow(VMALLOC_START);
> +			unsigned long end =
> +				arm_kasan_mem_to_shadow(VMALLOC_END);
> +			memcpy_pgd(mm, start, end);
> +		}
>   		/*
>   		 * Use a store-release so that other CPUs that observe the
>   		 * counter's new value are guaranteed to see the results of the
>
Otherwise it compiles with KASAN enabled, I am running some tests with 
your patches.

Regards,

Clément

