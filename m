Return-Path: <stable+bounces-154815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 432BDAE09BA
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 17:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B963188A9A1
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 15:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C38F25E44E;
	Thu, 19 Jun 2025 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ryX2jGkx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE6022D7A1
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750345147; cv=none; b=Rj7wq29qgPtbSr+m8sjg31izzSgXycG9T0pk8b1Uwiio0rBd4k3ZcMa3xECd1di1zMJvpF43C4Dx/R97/Z9yMBdKuabdylb4IpFTeoLZ1YMTmMS7JDJIcUVIkOv1TZz+oHI6Hu0duviyZd11IyAy/i/6rvpzrvJ6KZl9q+TeLJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750345147; c=relaxed/simple;
	bh=1zDbp04MJR2rOEZZQubXN0u0q2gp9kvtbea6XhIT9k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gcma5sd8l4pPvSPQdm93wCFoBupFvYpJ0sOyBVQzFZ3jjVYPD+WrN1EZKkE3wTKfQKNI73QnteVif40Sg+iN9XZ0yM6COhrO08r9+cSu7pP+q3IOMhlb7CGN7UtscwPAyWxyHyOXf3MUeM9nL18HkJ3Ytj/XPQ3RMhrWWsh+fHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ryX2jGkx; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so893757f8f.0
        for <stable@vger.kernel.org>; Thu, 19 Jun 2025 07:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750345144; x=1750949944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ECCoI/71JS3u+USP7IvsywfMmQCP+sHbNR0kEPdIEZI=;
        b=ryX2jGkxk5a6vSP114W9L1HOWkxuO+NsHOITOF7EcXwCzhVcB0sZ4SU5uxhd0CDD0X
         GRme6qfQ9raYMUROu8cloUj3RGbuG3w6J1CK/ue9nt/3y6PP9V1Uz25QX/wmE1D+rxSb
         u2YnCqMUP1VAyL6g2DX3uL8oVPxvrX7OrQkOeCmx6oaWA7WuqWQP1RdOqGLA+Jx4zgfy
         HYDXhM5QBy1hZ4XAM+YUENhJU3HH9F0HuBPezZZ+4L98nRYrCLa56wWwbVdDWwtQcfZi
         NTUZ+3HrO4zlKCSYzWCHP+VXk83f4NrSxC923QrmRbFgTBmfo8dao3W6Rf+rx+TlgUfY
         E4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750345144; x=1750949944;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ECCoI/71JS3u+USP7IvsywfMmQCP+sHbNR0kEPdIEZI=;
        b=MMEWeEonMtp/QFagtY5THF6PlthNbclJMsUbrzx3NyA3F12lSHtc+I+BI3YPQERweY
         ONkdQVOJJ8Uo53W1YtwffSE2cq3xNnfLPjmwCRqH1P8A/M0YHkm0aCvbRLHCutXJp9CF
         l7qaW4AaLYmBcWWJ7Wjeht+V3RiDrTVCFTN9qb2Eww+nOhiK82M6Bv174B0xL+40L/tS
         yBrLwhBuROoRUrI3f1tVI0ORQxGi+Kyfa1Pz5oCIlgy+fxwLJwVvrnsPL1cGNiAGib/z
         D2jztej9f6tKxbdFQExweH/2RB9UKm/n94vc0YWBiBN2UeznwU6S+5NsZ3D1WQL9sWrH
         6+IQ==
X-Gm-Message-State: AOJu0Yw3j184oRyLJV/09TruU6+IRMqcpx4NHD27zgd5xeo5yyUoPbVo
	rgH/3zak2WUhd8wlA3FTkrlz5/Wbxy5uwxq9fWB91dLbdgKJAE5/dIBhyI1kEM08uWTgmKf+7ep
	yv01Y
X-Gm-Gg: ASbGncs+LWTSt+mhbmgCUWs8MkboUr0/LF3RJ0vtaX4mZq2u44A+CzGGAUNtjx2F3Qc
	i88471ngxlhbZ94p906YPcTQV1WGMH0E8o9MmveOCuI6VjZLVdJn7QPj3DUpqNIxnKpmdayqjKV
	BG7S17mmN+npYvaJq7f93zRFyDOcsqJDvnBAArt6ixClfzfaZfcFtXp+ySF4gSGh26s04D/v+4D
	4Z4LV0WQ8qQ8ely3yxBpqpM1re28dU38Whs9ciW0Y9g7UFaCcTOtsR/5ap124l7Lveud6RV6ilN
	MB6+0QLUDniIFAIrmt510XvNKuldDAeX+ic8Y6VziaTwe9QEXvTaVazVfntxY6Y3sYJSzzX4fQG
	rEfofkjjRypp8mLvAbdhLrW4vffma+/dm41E=
X-Google-Smtp-Source: AGHT+IGmnPNdDdO/SCEtEybjm+3oFAXmRDg5jmS5KEozw5rxP3jACidjef48u3E+8nsnsfMd8Ti7wg==
X-Received: by 2002:a05:6000:4201:b0:3a4:d898:3e2d with SMTP id ffacd0b85a97d-3a572e2dabcmr17534877f8f.24.1750345144440;
        Thu, 19 Jun 2025 07:59:04 -0700 (PDT)
Received: from ?IPV6:2a0e:c5c1:0:100:b058:b8f5:b561:423c? ([2a0e:c5c1:0:100:b058:b8f5:b561:423c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535f7febcfsm25710235e9.18.2025.06.19.07.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 07:59:03 -0700 (PDT)
Message-ID: <3d50a859-d4bb-4d71-a493-d8a2a114dd6c@linaro.org>
Date: Thu, 19 Jun 2025 16:59:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 296/356] ath10k: snoc: fix unbalanced IRQ enable in
 crash recovery
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Sasha Levin <sashal@kernel.org>
References: <20250617152338.212798615@linuxfoundation.org>
 <20250617152350.087643471@linuxfoundation.org>
 <a91ca229-0603-4385-9f9e-01f3c3ede855@linaro.org>
 <2025061953-alarm-oxidize-1967@gregkh>
 <2ac47529-d72b-4de0-873e-247cce7c3c1c@linaro.org>
 <2025061946-squiggle-cheer-27c8@gregkh>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <2025061946-squiggle-cheer-27c8@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/19/25 16:53, Greg Kroah-Hartman wrote:
> On Thu, Jun 19, 2025 at 04:09:00PM +0200, Casey Connolly wrote:
>>
>>
>> On 6/19/25 06:21, Greg Kroah-Hartman wrote:
>>> On Wed, Jun 18, 2025 at 08:06:45PM +0200, Casey Connolly wrote:
>>>>
>>>>
>>>> On 6/17/25 17:26, Greg Kroah-Hartman wrote:
>>>>> 6.6-stable review patch.  If anyone has any objections, please let me know.
>>>>>
>>>>> ------------------
>>>>>
>>>>> From: Caleb Connolly <caleb.connolly@linaro.org>
>>>>>
>>>>> [ Upstream commit 1650d32b92b01db03a1a95d69ee74fcbc34d4b00 ]
>>>>>
>>>>> In ath10k_snoc_hif_stop() we skip disabling the IRQs in the crash
>>>>> recovery flow, but we still unconditionally call enable again in
>>>>> ath10k_snoc_hif_start().
>>>>>
>>>>> We can't check the ATH10K_FLAG_CRASH_FLUSH bit since it is cleared
>>>>> before hif_start() is called, so instead check the
>>>>> ATH10K_SNOC_FLAG_RECOVERY flag and skip enabling the IRQs during crash
>>>>> recovery.
>>>>>
>>>>> This fixes unbalanced IRQ enable splats that happen after recovering from
>>>>> a crash.
>>>>>
>>>>> Fixes: 0e622f67e041 ("ath10k: add support for WCN3990 firmware crash recovery")
>>>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>>>
>>>> If fixing my name is acceptable, that would be appreciated...
>>>
>>> I can, to what?  This was a cherry-pick from what is in Linus's tree
>>> right now, and what was sent to the mailing list, was that incorrect?
>>
>> s/Caleb/Casey/ I sent this patch before updating my name.
> 
> Ah, sorry, I already did the release.  I would recommend sending in a
> .mailmap update for the kernel so this gets caught going forward.

Ok, no worries.

I already updated mailmap and all the other references so this shouldn't 
happen again, just bad timing with this patch.

Kind regards,>
> thanks,
> 
> greg k-h
-- 
Casey (she/they)


