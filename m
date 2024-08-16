Return-Path: <stable+bounces-69333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D905A954CA5
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 16:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6946A1F26840
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 14:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E981BD015;
	Fri, 16 Aug 2024 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvsIpUbJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5D91E505;
	Fri, 16 Aug 2024 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819416; cv=none; b=UBz98YQdGhd50ZBGOiGL2O3lUXPPjprghFfgFVfehBTQ7Yp9Yf/+LNnr8+ohZ7Beh92fZZev2rtWxGlyqcSmASUdaWnw1xk/DipHGCtPoQdw4rXJGbxHhY8QtnjcxLgYj9RGjLqSMpNyQYPl3IZDkbafKtb9BlZ48zF8YW2DR+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819416; c=relaxed/simple;
	bh=y6DPhRBgv7tF0It0PC7+tnJVK6xQeFWIJ/DE42M9+5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TLyjgj5pdv6uG9QyLSTKfgJW3lAtp5Q3g7Ux/l1eCkq8YMzqWLs2FIkxQlZbrhmcFoG1oM0KdqONK5WEITblCaZs97hKXovIEakdHkGXlg23PlKSTtErshx66zir3PzaCvpjcCyyDhU+0pJc2BLmgx0teA7emxVMhsRmb2pqX1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvsIpUbJ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7c3d8f260easo1430665a12.1;
        Fri, 16 Aug 2024 07:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723819414; x=1724424214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bUdYzfy/kbk/iCndT0EUPe6M3ipQHcW5VMuOHUvnJuA=;
        b=VvsIpUbJjc+c6XwzdR9R61IOphk8RZJSxer/l5SGXLlZCMwmI1OVbUIFdtrAth3/uz
         8x4PHCKDA+tmAAYbDj3Ck05WYJTrxQhojxCML5tSg11U+T27irmQaxyabdA7fcyjMdfu
         dePo7CIDmFacKHQPXhmo1D8pGWsIhUaYNBhLQ4vrqzW5PxTHEMQkYhkZLGxN8lCUdDf6
         pyEoy4mBgo23Rdle3iRH5Sw+yxRc/WzPBtm4A1np9EM3Y86aoKKqyHItIrVzW1/vl2Kz
         7P/wwjdbXW5rpZeZ5mEyo9XhyxlrmBlQUXDCnJjSI1OJKhTNjEXTp+ZfSwmUaElUsL/K
         llQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723819414; x=1724424214;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUdYzfy/kbk/iCndT0EUPe6M3ipQHcW5VMuOHUvnJuA=;
        b=dFV6UAcppS6u06ugzPpwVuT46WHKkVMuc58DOwVY7Lm8o6qgqFV7WyGrhgpiGI8IhU
         OjKU4Vha4TbzNWDeG/WH6fFyefCo9qcBF81k8EXX3JW1h8MNtDpVn6akUzZj3CuZAupk
         Yr+kOXpsGRRMRQzWYywz9nN/OJQKUW34BuCh6+e+igrigmSZITqY7B9EYjZ4OcVDDXWG
         X69RzEu4Scy7hi5yBfNyl87lAIiYiHPH//1AFTCf68FrfCB3pgUi5vv6RWck2pdD0pqI
         3s3bnsHPLxwnRUitIHcQVKxsIhfd/ubaQauBJaVuBjBUWgQYhDPqZg0jrTDKdlubgf0x
         adqw==
X-Forwarded-Encrypted: i=1; AJvYcCU85naboijPtYKyJ8uzduN/6t9tnioQ2OP6lvqHHH7sV0N+S/YceL2gCkkM889NElk3ZBakfDv4wm6SL4om01+lVw9IdvfMQxuZdloq
X-Gm-Message-State: AOJu0YwDQj4yUCbYVk3Sz8DOOTPQyHSq7vVx7LbPPgWcFnnxpwoU8UDU
	C/nfW+v1EhXcv5nclfKuHGbfh4H6X5HhMjnHtvzYtCRpiUIQr9S7
X-Google-Smtp-Source: AGHT+IF5PCkfXg54HpIQZ2apwzYs6QOhRNTprCrAxCgxEWFVeJmNY6EBl6w6Wu1FLYdukdkVbvtLIg==
X-Received: by 2002:a17:90a:b10f:b0:2d3:cd22:e66f with SMTP id 98e67ed59e1d1-2d3dfdaabc8mr3173592a91.9.1723819413745;
        Fri, 16 Aug 2024 07:43:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2b65aa7sm1975708a91.5.2024.08.16.07.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 07:43:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b27c5434-f1b1-4697-985b-91bb3e9a22df@roeck-us.net>
Date: Fri, 16 Aug 2024 07:43:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/263] 6.10.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240812160146.517184156@linuxfoundation.org>
 <8852e518-3867-4802-adea-0c0ee68d1010@roeck-us.net>
 <2024081616-gents-snowcap-0e5f@gregkh>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <2024081616-gents-snowcap-0e5f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/16/24 01:38, Greg Kroah-Hartman wrote:
> On Thu, Aug 15, 2024 at 07:21:00AM -0700, Guenter Roeck wrote:
>> On 8/12/24 09:00, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 6.10.5 release.
>>> There are 263 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Wed, 14 Aug 2024 16:00:26 +0000.
>>> Anything received after that time might be too late.
>>>
>>
>> I see various allmodconfig build failures on v6.10.5.
>>
>> Example from arm:
>>
>> Building arm:allmodconfig ... failed
>> --------------
>> Error log:
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:1581:13: error: 'is_dsc_common_config_possible' defined but not used [-Werror=unused-function]
>>   1581 | static bool is_dsc_common_config_possible(struct dc_stream_state *stream,
>>        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:1569:21: error: 'kbps_from_pbn' defined but not used [-Werror=unused-function]
>>   1569 | static unsigned int kbps_from_pbn(unsigned int pbn)
>>
>> The functions are built and used conditionally in mainline, behind CONFIG_DRM_AMD_DC_FP.
>> The conditional is missing in v6.10.5 (and v6.10.6-rc1).
> 
> Odd that other allmodconfig builds passed :(
> 

Yes, that is odd. Maybe they all build with clang nowadays ?

> I'll dig up where that conditional showed up, thanks for letting us
> know....
> 
> Ah, looks like it showed up in 00c391102abc ("drm/amd/display: Add misc
> DC changes for DCN401"), gotta love "fix a bunch of things" type of
> commits...
> 

I found that as well, but as you noticed it is a mess.

Your partially applied patch introduced other problems -
please see my other e-mail.

Guenter


