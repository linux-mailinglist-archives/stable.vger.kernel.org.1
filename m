Return-Path: <stable+bounces-73044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FEC96BB28
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041171F27AFC
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6DE1D1F48;
	Wed,  4 Sep 2024 11:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mK2HEZW8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6192E1D1F49
	for <stable@vger.kernel.org>; Wed,  4 Sep 2024 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725450236; cv=none; b=T22l0L5Q+jVL5dQ3bYSr+Oc9VksxpUsznQrLBs3C85kSKtYft3ThJS2qh5MjEA9hD33pYTtT76f5eFp2LJ6no7nmGkSeWL4y2b5oLm8/KXOqLybyWL65N2RlUH2fkwuJ136kanNPzQoNLN0tiiFkcNJ0r0PFP/kv6bZQZA3HQ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725450236; c=relaxed/simple;
	bh=TcvvGUzUyW7y66QoYl9NDBgaKlbsu4UGU0sFU9wFjBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G65CVJ0YGndjcGCGKUxrNIHHnuR5IKJv7+vd7DeGh9bE2i6AsKGBigjsqlFDT4YDcEahIUiQKSq2u+Q0fl/cn2oRcj75FMuZ5/eOd1yYpo9C7MlyRdA0OrHwf/mNcyikcjNaHgXb37exf5BUJYVtR05OroIDGqTUW/UWa1SxbHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mK2HEZW8; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a86939e9d7cso24236666b.2
        for <stable@vger.kernel.org>; Wed, 04 Sep 2024 04:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725450233; x=1726055033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/59KpQl/ENj5YnZpXPnbSALUPXSSb5VrZ9vlG/9vrBQ=;
        b=mK2HEZW8wQpgglhp2jtn0eLt4O97fC84gi4uifiInt4nv/a/7+swAKhtGyhjZjZsoZ
         c2LCN7R+SQddz89FhnDxoqofTAgzG41Ll0DsQwcIcfTbRQ19itpRQBcjwUfCOx7pMciX
         j9QqGFUq9wcPZEhN1tjwQOr4Qwq4bc9VJ2TdganfUa37WnY0/Fw3T/0Nou4nZNJTxW/b
         qLBX4WhUYfqVkPDKCHBfsEtR7EsbFPJA6/Aktt0BwbhZ5cHXiqEHLLx5Uw6U9GSu7Tuy
         5frmeN2+DxBMZgvyfx/IflBocPsZFKsiqNiznhDPEtgFSIQrBRtP/F/v5fWT58szTqI5
         zLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725450233; x=1726055033;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/59KpQl/ENj5YnZpXPnbSALUPXSSb5VrZ9vlG/9vrBQ=;
        b=tuTRhTSQ78T8aw2GU1qHmfvtsZV7rTC8GtfWfQPnNsjESpMH1G5DCLT3NLVQjV8Lzb
         DzSGHlyx+1HHeZWEQ3JG/NEHDaCHee5eQQnVOH5UpsytqY5m+Qta5seyJO4GoJVMZGZE
         SqGRJ7+eUVsUNiLUxoV0E6mgPhKjGWtJtkAeacZfYqTRqSqDZy0rkl8H9Aq9q9GRJv2B
         cavcTefLHxbMk5EGLB2lv36xcRA4rZNBgAMqwi3uXWhc1ZKt+TkWDyhGfCKVfV1e+t2o
         pA111Dr791GRZgl8CHtxFM4IiX9G440x3Cw4QMUBha83009iN9erSiB1tZJY1dXSHwm1
         KGMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbSFDWYEqiHCX8fTO7PlM92NWG/SJK+MGeKNyRb+8aKq5ZSkhwT+sud+MijoWa6QmkO9u/zhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX+CqjpiWsEWHvzTZOf6bTxdZDhYkJRhwd6f0XPNvu9O/dyRcM
	DUCVqZJeOAohF39UNY/qOqQDIO13XRNmgyW0a6cYugUpslIjDsPIBFuEk/QBorc=
X-Google-Smtp-Source: AGHT+IGaWHDAbUbWROpXtvL3TzWtVqhkdhe/CfKY06N3Rz/z/TeQIlpyigCEhXFcyZnadufk631/bg==
X-Received: by 2002:a17:907:eac:b0:a79:a1b8:257b with SMTP id a640c23a62f3a-a89a3958e1dmr522577966b.10.1725450232555;
        Wed, 04 Sep 2024 04:43:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a1900d4fcsm266703266b.144.2024.09.04.04.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 04:43:51 -0700 (PDT)
Message-ID: <acec443c-f9ab-4c1d-b1ab-b8620dfef77f@linaro.org>
Date: Wed, 4 Sep 2024 13:43:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soundwire: stream: fix programming slave ports for
 non-continous port maps
To: "Liao, Bard" <bard.liao@intel.com>,
 "Liao, Bard" <yung-chuan.liao@linux.intel.com>, Vinod Koul
 <vkoul@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "Kale, Sanyog R" <sanyog.r.kale@intel.com>,
 Shreyas NC <shreyas.nc@intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20240729140157.326450-1-krzysztof.kozlowski@linaro.org>
 <095d7119-8221-450a-9616-2df6a0df4c77@linux.intel.com>
 <ZqngD56bXkx6vGma@matsya>
 <b6c75eee-761d-44c8-8413-2a5b34ee2f98@linux.intel.com>
 <f5110f23-6d73-45b5-87a3-380bb70b9ac8@linaro.org>
 <SJ2PR11MB84242BC3EAED16BEE6B46F85FF932@SJ2PR11MB8424.namprd11.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <SJ2PR11MB84242BC3EAED16BEE6B46F85FF932@SJ2PR11MB8424.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/09/2024 17:17, Liao, Bard wrote:

>>>
>>> then dpn_prop[0].num = 1 and dpn_prop[1].num = 3. And we need to go
>>>
>>> throuth dpn_prop[0] and dpn_prop[1] instead of dpn_prop[1] and
>> dpn_prop[3].
>>>
>>
>> What are the source or sink ports in your case? Maybe you just generate
>> wrong mask?
> 
> I checked my mask is 0xa when I do aplay and it matches the sink_ports of
> the rt722 codec.
> 
>>
>> It's not only my patch which uses for_each_set_bit(). sysfs_slave_dpn
>> does the same.
> 
> What sysfs_slave_dpn does is 
>         i = 0;                          
>         for_each_set_bit(bit, &mask, 32) {
>                 if (bit == N) {
>                         return sprintf(buf, format_string,
>                                        dpn[i].field);
>                 }
>                 i++;
>         }                         
> It uses a variable "i" to represent the array index of dpn[i].
> But, it is for_each_set_bit(i, &mask, 32) in your patch and the variable "i"
> which represents each bit of the mask is used as the index of dpn_prop[i].
> 
> Again, the point is that the bits of mask is not the index of the dpn_prop[]
> array.

Yes, you are right. I think I cannot achieve my initial goal of using
same dpn array with different indices. My patch should be reverted, I
believe.

I'll send a revert, sorry for the mess.

Best regards,
Krzysztof


