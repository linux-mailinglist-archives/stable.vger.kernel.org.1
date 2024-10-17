Return-Path: <stable+bounces-86592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095E99A1FA2
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 12:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A6DCB22380
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 10:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33D71D9A6A;
	Thu, 17 Oct 2024 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="G8S+ypOr"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2776F1DA2E0
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 10:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729160451; cv=none; b=KWecJeXmP94Y9zt0bfk2hzBXS2nEECHOZlRcHne89Pcvz2rmbWmZwc24HK+be9p9S3k/U4b2g4GtjSL2GAe6qVABRTVZZGQfoSsV4Bqp8a+Foagi66qlbfCELMeq8OEkdznTGNpxnN7nV5THboQI6bDlN3qU7dsGICHBIzdzVdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729160451; c=relaxed/simple;
	bh=Ey4Rx3dwAeadfB0a36CEeuP4JBzTtrZ0qAXY7TXr01I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sq65J/GAhvg/f2V145M9J6VoPe6aOg8AQRkuD29yJzQg7YIkCGVs9dX5rEoGXdLbE4QxcB4xPHQ0QltwrRwTYYAwua4BGn+4LgVgajOAkL7xLoC3694TEAmilijf41OvLO+mIF7YMqM3Mxl/VK6/4EubB2tIxiFqKZMGDK0AS/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=G8S+ypOr; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H9sYET027926;
	Thu, 17 Oct 2024 12:19:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	qzkWqNr6Zah8fHLn9UTsESMYx5WWXc0P676Bj/YsVmA=; b=G8S+ypOriCAWBjdh
	DlKopcoQbmo2a9XHGHUNeiB1ISAbpfvzrycH46M3wv11dMvfApP4kI+AU3+O9Sqs
	p0Bznpfv38UTVLw1AOD30FgAWDzwwnW4BjmRuuyhFquuY/Vw12RFtl2xpVA51APs
	gfX/pOPUavTPlnX1QI6hR/7cFY8tqoCiFDooH6WfVVNQ/x6gSinpTVUc8Eb8OD2E
	jyqK+6rZKb8kVyFPafvJadJoxV46kVm/stVcG3HhB0ZiA+NrgIVmDVKhNXHvj29H
	1/rY8rsEE+qgHjqKOHVKsJzJwJmOPfJdo706Uto97LLr5dW5jRZ2iDOqI9FUHiXw
	O9hwmQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 427gex81y0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 12:19:53 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9F96740047;
	Thu, 17 Oct 2024 12:18:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CFA63279E69;
	Thu, 17 Oct 2024 12:17:28 +0200 (CEST)
Received: from [10.48.86.107] (10.48.86.107) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 17 Oct
 2024 12:17:28 +0200
Message-ID: <16e45f70-d1d6-4cca-95b0-24d3959e50be@foss.st.com>
Date: Thu, 17 Oct 2024 12:17:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ARM: entry: Do a dummy read from VMAP shadow
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
References: <20241016-arm-kasan-vmalloc-crash-v2-0-0a52fd086eef@linaro.org>
 <20241016-arm-kasan-vmalloc-crash-v2-2-0a52fd086eef@linaro.org>
Content-Language: en-US
From: Clement LE GOFFIC <clement.legoffic@foss.st.com>
In-Reply-To: <20241016-arm-kasan-vmalloc-crash-v2-2-0a52fd086eef@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

On 10/16/24 21:15, Linus Walleij wrote:
> When switching task, in addition to a dummy read from the new
> VMAP stack, also do a dummy read from the VMAP stack's
> corresponding KASAN shadow memory to sync things up in
> the new MM context.
> 
> Cc: stable@vger.kernel.org
> Fixes: a1c510d0adc6 ("ARM: implement support for vmap'ed stacks")
> Link: https://lore.kernel.org/linux-arm-kernel/a1a1d062-f3a2-4d05-9836-3b098de9db6d@foss.st.com/
> Reported-by: Clement LE GOFFIC <clement.legoffic@foss.st.com>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>   arch/arm/kernel/entry-armv.S | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index 1dfae1af8e31..12a4040a04ff 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -25,6 +25,7 @@
>   #include <asm/tls.h>
>   #include <asm/system_info.h>
>   #include <asm/uaccess-asm.h>
> +#include <asm/kasan_def.h>
>   
>   #include "entry-header.S"
>   #include <asm/probes.h>
> @@ -561,6 +562,13 @@ ENTRY(__switch_to)
>   	@ entries covering the vmalloc region.
>   	@
>   	ldr	r2, [ip]
> +#ifdef CONFIG_KASAN_VMALLOC
> +	@ Also dummy read from the KASAN shadow memory for the new stack if we
> +	@ are using KASAN
> +	mov_l	r2, KASAN_SHADOW_OFFSET
> +	add	r2, ip, lsr #KASAN_SHADOW_SCALE_SHIFT

Hello Linus,

While ARM TRM says that if Rd is the same of Rn then it can be omitted, 
such syntax causes error on my build.
Looking around for such syntax in the kernel, this line should be :
add	r2, r2, ip, lsr #KASAN_SHADOW_SCALE_SHIFT

Regards,

Clement

