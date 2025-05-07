Return-Path: <stable+bounces-142013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A6AAADB95
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 11:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CB5D7AB6F1
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 09:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EE41F8EF6;
	Wed,  7 May 2025 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="2Ak/leVE"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E475A72603;
	Wed,  7 May 2025 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746610782; cv=none; b=fjHbr37A058q9HG8d6Qt8VOq8CLaBltlOeVN+a41zFA+1zJMtxYh4MFfYW6In9xmyufcLHp0RvAIo4bL+Phzt+YkJOZiO51bv8ZUU5jgUmw1lXxeqQcUfFbv/ZLfe2tL4s9ZvAAzBB+x4gnOP68n9N/tpd+6Dz6kBjRq2PEYtzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746610782; c=relaxed/simple;
	bh=yseu/fviG9sBphrbS2qyiH77DlvyLBg+mOtLnLd1bA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pgB4uNhqbl+RV44oy5LIWPWgda4BtJ4Fb9I1cxWM30RaKJJ6Tz2WwpJ8cPqPDYl8rf89Ul2y859m8Hxt8DkmYpos16TesuzehrQAOIw99ZMB7qaU6K7FLpB4S2VkW5oTBSou4UKzFv0HFXWFDyHMj2iSGfEjCGt39Zed8EfeFEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=2Ak/leVE; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5476w1Mb023422;
	Wed, 7 May 2025 11:39:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	UVmiCxdLxof6rR0pPlGnitzzGOICxyfJaM5FQQQz/ck=; b=2Ak/leVE5YIjnBvU
	g0TwjknBZS9E5swk9XOrwhfbnoaYHeRRhvroUbRkpMaSexAxds5NMzcC4tSts/Oc
	STfLli3xWmfxbZANGFMY7G8d4phpM1w/Ofac+kpqyETPt9fpEtKAaWabfGkdpEUo
	VBrcYTQaatocRdzFs+0+F07kzMyc3LSh/vbknC2pJ/2ME1GUVK02PJVBMhx0ugvK
	OGB43Bv1ODr01wNFXiNIE1+6IRvaRQ1cUdW0QBnY+CxgTSeh/i8l5tMZqgj7ijQZ
	6y4Xn0OtWrA5UGWDuxFUGFObjyn9M/e0lu/c5oV8Cav4e1WXdddhS6odFpzJ0AHP
	nhvirw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46dbkqfvs9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 11:39:31 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0D15E4004B;
	Wed,  7 May 2025 11:38:26 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DF38CA69980;
	Wed,  7 May 2025 11:37:59 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 May
 2025 11:37:59 +0200
Message-ID: <1139e046-b66a-445d-9e04-a0c4d059c438@foss.st.com>
Date: Wed, 7 May 2025 11:37:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bus: firewall: Fix missing static inline annotations for
 stubs
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <stable@vger.kernel.org>
References: <20250507092121.95121-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250507092121.95121-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_03,2025-05-06_01,2025-02-21_01



On 5/7/25 11:21, Krzysztof Kozlowski wrote:
> Stubs in the header file for !CONFIG_STM32_FIREWALL case should be both
> static and inline, because they do not come with earlier declaration and
> should be inlined in every unit including the header.
> 
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: <stable@vger.kernel.org>
> Fixes: 5c9668cfc6d7 ("firewall: introduce stm32_firewall framework")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  include/linux/bus/stm32_firewall_device.h | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/bus/stm32_firewall_device.h b/include/linux/bus/stm32_firewall_device.h
> index 5178b72bc920..eaa7a3f54450 100644
> --- a/include/linux/bus/stm32_firewall_device.h
> +++ b/include/linux/bus/stm32_firewall_device.h
> @@ -114,27 +114,30 @@ void stm32_firewall_release_access_by_id(struct stm32_firewall *firewall, u32 su
>  
>  #else /* CONFIG_STM32_FIREWALL */
>  
> -int stm32_firewall_get_firewall(struct device_node *np, struct stm32_firewall *firewall,
> -				unsigned int nb_firewall)
> +static inline int stm32_firewall_get_firewall(struct device_node *np,
> +					      struct stm32_firewall *firewall,
> +					      unsigned int nb_firewall)
>  {
>  	return -ENODEV;
>  }
>  
> -int stm32_firewall_grant_access(struct stm32_firewall *firewall)
> +static inline int stm32_firewall_grant_access(struct stm32_firewall *firewall)
>  {
>  	return -ENODEV;
>  }
>  
> -void stm32_firewall_release_access(struct stm32_firewall *firewall)
> +static inline void stm32_firewall_release_access(struct stm32_firewall *firewall)
>  {
>  }
>  
> -int stm32_firewall_grant_access_by_id(struct stm32_firewall *firewall, u32 subsystem_id)
> +static inline int stm32_firewall_grant_access_by_id(struct stm32_firewall *firewall,
> +						    u32 subsystem_id)
>  {
>  	return -ENODEV;
>  }
>  
> -void stm32_firewall_release_access_by_id(struct stm32_firewall *firewall, u32 subsystem_id)
> +static inline void stm32_firewall_release_access_by_id(struct stm32_firewall *firewall,
> +						       u32 subsystem_id)
>  {
>  }
>  
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice

