Return-Path: <stable+bounces-197974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A554EC98ADD
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 19:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37E6F4E1880
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 18:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779C63396E9;
	Mon,  1 Dec 2025 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGqW0Z/R"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FD0338586
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764612907; cv=none; b=bKE4IyYLbPrNIp6kYAe23ACVjSLulmEA2hdLbV1/zrDJmvjAk3q/zoLMs9L7L+udkKwOX05HTxgXpVMkxVp1PjPw7D7w9wBMEIeu6N3otxmwlmfHenOQkjjWkDkEyiDWQsd77y9A7hKvVbOulQmVz4SCLpS57qBbCTQh7j9VZJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764612907; c=relaxed/simple;
	bh=FtPZ8ln+Dko9c5ZxEj0xatlsrhAWF4UkBy4isk3edds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lL/o6pcBeElLcmLe+EY8T/eL8772/ZJrvMJ3dLjpcdESbJwZPIe9hpRe0gjAITl0z7kHRxpOrNyQsox9n+IpSLjDejzqiZAF4vvvb/7W4HFUrtIPe1nvK69OGaVtiPW8u+MfmP3RWdOLi15CArsPhwcQ1YQscZPhFc1znjPTYyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGqW0Z/R; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b735e278fa1so163889566b.0
        for <stable@vger.kernel.org>; Mon, 01 Dec 2025 10:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764612902; x=1765217702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uDFjPV2bCEcJMIJe+ovqNB08eGKarAnB/LsdrnkXVnc=;
        b=aGqW0Z/RKe5B4K0H5uKfcJL0toRM/Vn0ljPXHMTGKi5Lz+f3T0jhGG7grYNfAcUZrp
         NHklGa8KbQpp6ctUejGcrOYKfYVFHgyYmQCqKPRdX9/vW4uHnLnZAnzbUPYrou87U3rX
         63Am+Z1kIwhDNIbNRhp9geEZNlDH5n1/KwissDr+PNrlkhLIAtGlZhSBduEQjK2zzUG0
         XpflS5R6ATeLs1EnMfxDJw5gWQ25rSysQwZqq5fk1wgCS68J/LMO+8/bvQxggcomkkJc
         ZH75l44YPocEoT0XQQhLGFKwIci3lkxnEGPKy3e8bA5zloE1zkzwrcZqtRJqXa0ffq57
         nR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764612902; x=1765217702;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDFjPV2bCEcJMIJe+ovqNB08eGKarAnB/LsdrnkXVnc=;
        b=m/zhaY0+5h238CIrRzj6QzTMrw4MglXFT2np+/EuEyS4G6Y788+CRPBslW/XsCR5KQ
         L0n/Ipg6sW9ThjJ4b+I99zkwVj6Ds5HZNcGRErrrpDFMEX810HopdlDpeJZc1xIZaeKT
         7nnYfGOx8H2qs0NV4GIGMlqZuNXajyCWaCzPSu/rKDJPEY0jhKiOSFh+7foMWDTyOr1k
         w+vnOQqSeZhr4n8guoTzx8OSVHbJ6UvJ10z2iR/mjLXADMQeDpchN2ETiAuwVL8vMlGr
         3dHGRjEzA3qC6K4wESrK3l2GtTN8kXyFO7XYwwCHC0paU7rYVX9sNK5FybO8fyPfruEW
         8yvw==
X-Forwarded-Encrypted: i=1; AJvYcCXLFdMZQm+aa3QXQ15gt8I06CS9Tu8DlRXjglCdmIX8ocDZjHNi80ADliVrXbuY88mdOaFnhQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+q6omA+U1R2pyeTaINq2bvWu0c1vX7HNWGFXAOFujMjmzOZIq
	hHA5+swuat8niFFn2AfmvcjHIKTxwbtUFUUkb9S9ihh4WKrNPy+nRNQ=
X-Gm-Gg: ASbGncuteXxJoMmIxjqq7hY1pexEga82qVcWsR9Nh/m6PHe4CCAfVjnpiB8FfEAS972
	VjCNf5dWQHCCRaItV95ZhBC93whBteK8w8godnlo/Bl8/XEmWQRdKIEPacWk6jybNrk8fPD0Mb9
	xm8dN6Ih4B2l9hs+Vwg9Bsk4WBnsuTOWzJYghDegxAjxOlHqooeONNuzmap56eQoK2VVfEdPobO
	8foted7ttr1lDX9eISdiGAJ5KVE30wU3r2mD7SfAwxjqQiJMaIZ00fcAzTjz/OqeeCRMz59DlFk
	k3XN3XfDlEn0yOG2n7mgcyREhTWJ2aCKuwF445Yx0Wb60iONztONs4NQYhwmL/HDGJGqLcdqFi4
	ngAxXRJcGiP5mPhtXFVdkUmnnTV560VFClbSBddrAZ9LDp5JiSCfMpMUyeUYBwcFg+hanxaQT9c
	0eJ21AcUO7hCYCaU2AWiQvzxAwvt+sc6E0oceoD2wEWtyb5p+h0Y2kY4IJlOJlVjrmbr6lCEhBu
	g==
X-Google-Smtp-Source: AGHT+IFrteTmdKpXbAPM5X2OBc2eatrHMRgNBwNQjniHBNZv/OV/UcAPIc4J1u1StehmefDeVyKnvw==
X-Received: by 2002:a17:907:6d1c:b0:b73:5936:77fc with SMTP id a640c23a62f3a-b76c54b85b0mr3000547266b.13.1764612902143;
        Mon, 01 Dec 2025 10:15:02 -0800 (PST)
Received: from [192.168.1.17] (host-79-32-234-137.retail.telecomitalia.it. [79.32.234.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f51c67e2sm1295011566b.27.2025.12.01.10.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 10:15:01 -0800 (PST)
Message-ID: <2f93530c-7917-4169-8e17-9842f1b0c4ea@gmail.com>
Date: Mon, 1 Dec 2025 19:15:00 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/msm: Fix a7xx per pipe register programming
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251128-gras_nc_mode_fix-v2-1-634cda7b810f@gmail.com>
 <17b0f475-6c67-4cef-9277-251f45c1837c@oss.qualcomm.com>
Content-Language: en-US
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
In-Reply-To: <17b0f475-6c67-4cef-9277-251f45c1837c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/25 5:14 AM, Akhil P Oommen wrote:
> On 11/28/2025 10:47 PM, Anna Maniscalco wrote:
>> GEN7_GRAS_NC_MODE_CNTL was only programmed for BR and not for BV pipe
>> but it needs to be programmed for both.
>>
>> Program both pipes in hw_init and introducea separate reglist for it in
>> order to add this register to the dynamic reglist which supports
>> restoring registers per pipe.
>>
>> Fixes: 91389b4e3263 ("drm/msm/a6xx: Add a pwrup_list field to a6xx_info")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
>> ---
>> Changes in v2:
>> - Added missing Cc: stable to commit
>> - Added pipe_regs to all 7xx gens
>> - Null check pipe_regs in a7xx_patch_pwrup_reglist
>> - Added parentheses around bitwise and in a7xx_patch_pwrup_reglist
>> - Use A7XX_PIPE_{BR, BV, NONE} enum values
>> - Link to v1: https://lore.kernel.org/r/20251127-gras_nc_mode_fix-v1-1-5c0cf616401f@gmail.com
>> ---
>>   drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 12 ++++++++++-
>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 34 +++++++++++++++++++++++++++----
>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
>>   drivers/gpu/drm/msm/adreno/adreno_gpu.h   | 13 ++++++++++++
>>   4 files changed, 55 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> index 29107b362346..10732062d681 100644
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
>> +static const struct adreno_reglist_pipe a7xx_reglist_pipe_regs[] = {
>> +	{ REG_A7XX_GRAS_NC_MODE_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
>> +};
>> +
>> +DECLARE_ADRENO_REGLIST_PIPE_LIST(a7xx_reglist_pipe);
>> +
>>   static const struct adreno_info a7xx_gpus[] = {
>>   	{
>>   		.chip_ids = ADRENO_CHIP_IDS(0x07000200),
>> @@ -1491,6 +1496,7 @@ static const struct adreno_info a7xx_gpus[] = {
>>   			.hwcg = a730_hwcg,
>>   			.protect = &a730_protect,
>>   			.pwrup_reglist = &a7xx_pwrup_reglist,
>> +			.pipe_reglist = &a7xx_reglist_pipe,
>>   			.gbif_cx = a640_gbif,
>>   			.gmu_cgc_mode = 0x00020000,
>>   		},
>> @@ -1513,6 +1519,7 @@ static const struct adreno_info a7xx_gpus[] = {
>>   			.hwcg = a740_hwcg,
>>   			.protect = &a730_protect,
>>   			.pwrup_reglist = &a7xx_pwrup_reglist,
>> +			.pipe_reglist = &a7xx_reglist_pipe,
>>   			.gbif_cx = a640_gbif,
>>   			.gmu_chipid = 0x7020100,
>>   			.gmu_cgc_mode = 0x00020202,
>> @@ -1548,6 +1555,7 @@ static const struct adreno_info a7xx_gpus[] = {
>>   			.protect = &a730_protect,
>>   			.pwrup_reglist = &a7xx_pwrup_reglist,
>>   			.ifpc_reglist = &a750_ifpc_reglist,
>> +			.pipe_reglist = &a7xx_reglist_pipe,
>>   			.gbif_cx = a640_gbif,
>>   			.gmu_chipid = 0x7050001,
>>   			.gmu_cgc_mode = 0x00020202,
>> @@ -1590,6 +1598,7 @@ static const struct adreno_info a7xx_gpus[] = {
>>   			.protect = &a730_protect,
>>   			.pwrup_reglist = &a7xx_pwrup_reglist,
>>   			.ifpc_reglist = &a750_ifpc_reglist,
>> +			.pipe_reglist = &a7xx_reglist_pipe,
>>   			.gbif_cx = a640_gbif,
>>   			.gmu_chipid = 0x7090100,
>>   			.gmu_cgc_mode = 0x00020202,
>> @@ -1623,6 +1632,7 @@ static const struct adreno_info a7xx_gpus[] = {
>>   			.hwcg = a740_hwcg,
>>   			.protect = &a730_protect,
>>   			.pwrup_reglist = &a7xx_pwrup_reglist,
>> +			.pipe_reglist = &a7xx_reglist_pipe,
>>   			.gbif_cx = a640_gbif,
>>   			.gmu_chipid = 0x70f0000,
>>   			.gmu_cgc_mode = 0x00020222,
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> index 0200a7e71cdf..422ce4c97f70 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> @@ -849,9 +849,16 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
>>   		  min_acc_len_64b << 3 |
>>   		  hbb_lo << 1 | ubwc_mode);
>>   
>> -	if (adreno_is_a7xx(adreno_gpu))
>> -		gpu_write(gpu, REG_A7XX_GRAS_NC_MODE_CNTL,
>> -			  FIELD_PREP(GENMASK(8, 5), hbb_lo));
>> +	if (adreno_is_a7xx(adreno_gpu)) {
>> +		for (u32 pipe_id = A7XX_PIPE_BR; pipe_id <= A7XX_PIPE_BV; pipe_id++) {
>> +			gpu_write(gpu, REG_A7XX_CP_APERTURE_CNTL_HOST,
>> +				  A7XX_CP_APERTURE_CNTL_HOST_PIPE(pipe_id));
>> +			gpu_write(gpu, REG_A7XX_GRAS_NC_MODE_CNTL,
>> +				  FIELD_PREP(GENMASK(8, 5), hbb_lo));
>> +		}
>> +		gpu_write(gpu, REG_A7XX_CP_APERTURE_CNTL_HOST,
>> +			  A7XX_CP_APERTURE_CNTL_HOST_PIPE(A7XX_PIPE_NONE));
>> +	}
>>   
>>   	gpu_write(gpu, REG_A6XX_UCHE_MODE_CNTL,
>>   		  min_acc_len_64b << 23 | hbb_lo << 21);
>> @@ -865,9 +872,11 @@ static void a7xx_patch_pwrup_reglist(struct msm_gpu *gpu)
>>   	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>>   	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
>>   	const struct adreno_reglist_list *reglist;
>> +	const struct adreno_reglist_pipe_list *pipe_reglist;
>>   	void *ptr = a6xx_gpu->pwrup_reglist_ptr;
>>   	struct cpu_gpu_lock *lock = ptr;
>>   	u32 *dest = (u32 *)&lock->regs[0];
>> +	u32 pipe_reglist_count = 0;
>>   	int i;
>>   
>>   	lock->gpu_req = lock->cpu_req = lock->turn = 0;
>> @@ -907,7 +916,24 @@ static void a7xx_patch_pwrup_reglist(struct msm_gpu *gpu)
>>   	 * (<aperture, shifted 12 bits> <address> <data>), and the length is
>>   	 * stored as number for triplets in dynamic_list_len.
>>   	 */
>> -	lock->dynamic_list_len = 0;
>> +	pipe_reglist = adreno_gpu->info->a6xx->pipe_reglist;
>> +	if (pipe_reglist) {
>> +		for (u32 pipe_id = A7XX_PIPE_BR; pipe_id <= A7XX_PIPE_BV; pipe_id++) {
> This patch is probably not rebased on msm-next. On msm-next tip, we have
> removed A7XX prefix for pipe enums.

Oh no it is rebased that was down to some confusion I made when I was 
testing with an older branch.

Fixed in v3

>
>> +			gpu_write(gpu, REG_A7XX_CP_APERTURE_CNTL_HOST,
>> +				  A7XX_CP_APERTURE_CNTL_HOST_PIPE(pipe_id));
>> +			for (i = 0; i < pipe_reglist->count; i++) {
>> +				if ((pipe_reglist->regs[i].pipe & BIT(pipe_id)) == 0)
>> +					continue;
>> +				*dest++ = A7XX_CP_APERTURE_CNTL_HOST_PIPE(pipe_id);
>> +				*dest++ = pipe_reglist->regs[i].offset;
>> +				*dest++ = gpu_read(gpu, pipe_reglist->regs[i].offset);
>> +				pipe_reglist_count++;
>> +			}
>> +		}
>> +		gpu_write(gpu, REG_A7XX_CP_APERTURE_CNTL_HOST,
>> +			  A7XX_CP_APERTURE_CNTL_HOST_PIPE(A7XX_PIPE_NONE));
>> +	}
>> +	lock->dynamic_list_len = pipe_reglist_count;
>>   }
>>   
>>   static int a7xx_preempt_start(struct msm_gpu *gpu)
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> index 6820216ec5fc..0a1d6acbc638 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> @@ -46,6 +46,7 @@ struct a6xx_info {
>>   	const struct adreno_protect *protect;
>>   	const struct adreno_reglist_list *pwrup_reglist;
>>   	const struct adreno_reglist_list *ifpc_reglist;
>> +	const struct adreno_reglist_pipe_list *pipe_reglist;
> nit: Maybe dyn_pwrup_reglist is a better name.
>
> Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Agreed, I changed the name in v3. Thx for the review!
>
> -Akhil
>
>
>>   	const struct adreno_reglist *gbif_cx;
>>   	const struct adreno_reglist_pipe *nonctxt_reglist;
>>   	u32 max_slices;
>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>> index 0f8d3de97636..1d0145f8b3ec 100644
>> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>> @@ -188,6 +188,19 @@ static const struct adreno_reglist_list name = {		\
>>   	.count = ARRAY_SIZE(name ## _regs),		\
>>   };
>>   
>> +struct adreno_reglist_pipe_list {
>> +	/** @reg: List of register **/
>> +	const struct adreno_reglist_pipe *regs;
>> +	/** @count: Number of registers in the list **/
>> +	u32 count;
>> +};
>> +
>> +#define DECLARE_ADRENO_REGLIST_PIPE_LIST(name)	\
>> +static const struct adreno_reglist_pipe_list name = {		\
>> +	.regs = name ## _regs,				\
>> +	.count = ARRAY_SIZE(name ## _regs),		\
>> +};
>> +
>>   struct adreno_gpu {
>>   	struct msm_gpu base;
>>   	const struct adreno_info *info;
>>
>> ---
>> base-commit: 7bc29d5fb6faff2f547323c9ee8d3a0790cd2530
>> change-id: 20251126-gras_nc_mode_fix-7224ee506a39
>>
>> Best regards,


Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>


