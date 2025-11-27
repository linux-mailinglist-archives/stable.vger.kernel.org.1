Return-Path: <stable+bounces-197525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA05C8FE06
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 19:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 410BA34F6BF
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 18:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8873A2FDC26;
	Thu, 27 Nov 2025 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/oLjezA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945B02D877B
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764267288; cv=none; b=Dm1yT2usHrgc96jkSwGrdZACCeZcd1zSkpiOqBy1l085CGLOhjhSTlsOiX7yvSiRZVFa+kw1iwpcPfidesbH0wwReHd/db0Vh6/BPjwtFwRrSrzSawpCwEjRpxwDeqt3Pd233wVjF75vX+8fOhpyq62GhXn1HvZvVYzzHRfLlIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764267288; c=relaxed/simple;
	bh=ia6SHQohiechg9nQ9nHZ1T6fV6EympZXMLpAndDTUS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7IZgoNvSVw51j9S17IAP2a3gU5eBx7VGG0qfNs8il4SKpFcsYX91kiMogpk09UzTg0ITA7F8INcvtqa6poBXD+e+uAHD8U/ob46Z7ZYvCBi7NlWwjm0S8QHfXTdNnVQKdgFFYubcnyhj1kNF1aBIz/vRNd6+oUkEnjyLO6cYbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/oLjezA; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-645a13e2b17so1779076a12.2
        for <stable@vger.kernel.org>; Thu, 27 Nov 2025 10:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764267285; x=1764872085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ceY0sHn48rRAcMonu5JKJvkpaxI/kuQGGI7CQ61F3IE=;
        b=S/oLjezAw4VIYGWJ94CDGeEcT9Pj1l6NUtJn8mgwx/ynhErW2LZvSQHrrBwv6RWNQg
         6s7U+mNpL5/+EBgJr31j6u6MhtfJD6XfHX4GAVjOauwNxuFtSztiRorkSTTasgVlyh05
         B4xUUtKVs8g68owR2D7YZBsB23+RgaOghpJTr+2dNwgbw6BIFC1H/8MXuEXvw/qE845x
         OM+MVnAjx3YAgUOMCArAFstdNIQA7AbIN3X9wyTJjoI6Et54qgM6XuAtjG9Ir0NYpVuP
         y2E1/23WSKZ3r/6b5umpCSXgdqiPpMBqTmwt+HNS9Ey+47+QtitFrw4MZGlgsVP8KUtB
         0Plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764267285; x=1764872085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ceY0sHn48rRAcMonu5JKJvkpaxI/kuQGGI7CQ61F3IE=;
        b=bIe1QUKX9YgBEgmAGIyZaR91Y5R+Vw0m8wlSKrlqHrjRUhn7cfgpM9qo9mt22j6rsb
         fqaF5YKoS2D+qKjJKz1LlZmnxwvVuj5nWYCk8Uc7omzQmA60JENh5zPs9duGHYk3hzLo
         fFQ/q922QhYp7WIjcDhyXn3Dzf+TJo2XyGVD+gmezoGz8+rp9FV2n74JtIDyYebt0ZPC
         2hNOkVjATV4taBP9BshKiY1o6spbw1x1gIC67hVVl0LCHtxcKywTi2SZmzeQ7+7XhDXc
         KUTHAclBpcHuRvfMhNUlfblSXXgF2+yB05HfJkU59YxHJvCfchMxetLj2ewOchjSV1Ie
         zJag==
X-Forwarded-Encrypted: i=1; AJvYcCV1AoSSEL7PecDW3SooX0XAWbUqmnYL+pS0L7sBW+QP5G6r8D+8eId0R+HXrskuDTtgZqEE3U8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpYv3ZiMrd7MvvsmkbVt260bKA9urIS9aqh7SPt3i+hI0ZLskr
	osrpC9/5r7RjsGy4ZKhydOQ8hUItJoJAp2a7e7VWB0tc2AT0i62Zpq8=
X-Gm-Gg: ASbGncsuYchmLoZEGkQxTBUJ01fbGH0nzmKeg1IXQRnfUO1Wj1neN1hVd6kMB6f/yFO
	tss5xFIJn8a/AqFkuBAX4l/ISRCVj6avywTLhpLPqbjijE+ySRNwoN4+iuWGOnbxX2q4YSe3wCI
	61CboPIQuKOfmwPx+0nD6it5hJsenZs+JU97CJA4NT/xcaWlgtLdrsv9Z0zFaZgFgiUYJe/gv8X
	41lU8hY6nP3ebOIYHtiVyVp1GUTxQmTGakMeiotLDgDl/OLfVXXAdRIRy/vx4o+9w8eT5Sm5dBi
	sSurfs4el8l5NHj6nKKBe4zkqlIvzWm3VrG1rQmJaOlsYnICL1DVnYOiwtRhYqG+6UtR75TmXe9
	aDu7L8a7gbTrcvTIKTaP5ue/7nECp+unUKBPNY+bO3ziVBK3k4eD/BKTprZQOlZPx0SHNevuh0B
	cJamZZuGPoug7XAdre37Ohr8KIHgCuQyJej9wisOnqC3XNWUiNnxzfw8eBGSCRnTai71cXjEoLp
	EJnAl9iuw==
X-Google-Smtp-Source: AGHT+IGRUoCmVJ8/5fdmTyuQWpZViuuejagy86jo7A4HW53phUVP0SJulYD9Y2kxyuKuF6EnaU2ukQ==
X-Received: by 2002:a05:6402:2688:b0:640:8bdb:65f0 with SMTP id 4fb4d7f45d1cf-645eb23bc21mr11606430a12.11.1764267284699;
        Thu, 27 Nov 2025 10:14:44 -0800 (PST)
Received: from [192.168.1.17] (host-79-53-175-79.retail.telecomitalia.it. [79.53.175.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64751050a63sm2219261a12.24.2025.11.27.10.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 10:14:44 -0800 (PST)
Message-ID: <951138f1-d325-4764-a689-e1c3db12bb90@gmail.com>
Date: Thu, 27 Nov 2025 19:14:41 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm: Fix a7xx per pipe register programming
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251127-gras_nc_mode_fix-v1-1-5c0cf616401f@gmail.com>
 <58570d98-f8f1-4e8c-8ae2-5f70a1ced67a@oss.qualcomm.com>
Content-Language: en-US
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
In-Reply-To: <58570d98-f8f1-4e8c-8ae2-5f70a1ced67a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/27/25 3:25 PM, Konrad Dybcio wrote:
> On 11/27/25 12:46 AM, Anna Maniscalco wrote:
>> GEN7_GRAS_NC_MODE_CNTL was only programmed for BR and not for BV pipe
>> but it needs to be programmed for both.
>>
>> Program both pipes in hw_init and introducea separate reglist for it in
>> order to add this register to the dynamic reglist which supports
>> restoring registers per pipe.
>>
>> Fixes: 91389b4e3263 ("drm/msm/a6xx: Add a pwrup_list field to a6xx_info")
>> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
>> ---
>>   drivers/gpu/drm/msm/adreno/a6xx_catalog.c |  9 ++-
>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 91 +++++++++++++++++++++++++++++--
>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
>>   drivers/gpu/drm/msm/adreno/adreno_gpu.h   | 13 +++++
>>   4 files changed, 109 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> index 29107b362346..c8d0b1d59b68 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> @@ -1376,7 +1376,6 @@ static const uint32_t a7xx_pwrup_reglist_regs[] = {
>>   	REG_A6XX_UCHE_MODE_CNTL,
>>   	REG_A6XX_RB_NC_MODE_CNTL,
>>   	REG_A6XX_RB_CMP_DBG_ECO_CNTL,
>> -	REG_A7XX_GRAS_NC_MODE_CNTL,
>>   	REG_A6XX_RB_CONTEXT_SWITCH_GMEM_SAVE_RESTORE_ENABLE,
>>   	REG_A6XX_UCHE_GBIF_GX_CONFIG,
>>   	REG_A6XX_UCHE_CLIENT_PF,
>> @@ -1448,6 +1447,12 @@ static const u32 a750_ifpc_reglist_regs[] = {
>>   
>>   DECLARE_ADRENO_REGLIST_LIST(a750_ifpc_reglist);
>>   
>> +static const struct adreno_reglist_pipe a750_reglist_pipe_regs[] = {
>> +	{ REG_A7XX_GRAS_NC_MODE_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
> At a glance at kgsl, all gen7 GPUs that support concurrent binning (i.e.
> not gen7_3_0/a710? and gen7_14_0/whatever that translates to) need this

Right.

I wonder if gen7_14_0 could be a702?

If we do support one of those a7xx GPUs that don't have concurrent 
binning then I need to have a condition in hw_init for it when 
initializing REG_A7XX_GRAS_NC_MODE_CNTL

>
> Konrad


Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>


