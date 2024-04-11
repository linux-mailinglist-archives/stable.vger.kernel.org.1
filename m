Return-Path: <stable+bounces-38706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 709E88A0FF3
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE85A1F29789
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D951145330;
	Thu, 11 Apr 2024 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ug6cqTzI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424A8143C76
	for <stable@vger.kernel.org>; Thu, 11 Apr 2024 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831356; cv=none; b=uysGOUh1LqHkFJESr/3rXSeqyqd0xu2IpNlefdVTrNy6C295v1S+DkCqpmtulNlbpbOjWdMWymOVVyGvWLVxJcgzxXAttc763GiEkaLXJG6d4pJk77DHAcwKXoGexTFoxS3+laseb/93mvqJR2tztCSl3pFfKROUl8Q4wDesRaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831356; c=relaxed/simple;
	bh=TEDm0yRQ13fxmjpIsmF8RxRzdn8U5pXWbIiuchs/PGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oBHinrSJtjpniZCdFtWt1OsNJJaT9VSwabQAn7S6H11euxtBJrUPhjUSE0Vcs94ueQCBR/DhslRcsl4tUKmvgVaVeCbUKl89/jgEfZq+dn46Of+dl23cwxXSpk3VUEVWBOuJW8jOJf8ptIxEgoqcLkwFP0RCkNrwHa7PPTX9THk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ug6cqTzI; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-343e46ec237so4702728f8f.2
        for <stable@vger.kernel.org>; Thu, 11 Apr 2024 03:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712831352; x=1713436152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ISKH9dnh1aQWsltqN9UVLivJw0zyLjoG7+RHPHTqXeA=;
        b=ug6cqTzIN391enBD8ZykiiY98eM3Vw07YTqdH/teKgeRG3aBzTQHB86SH5874ayfEL
         voWN9MFK/b30MG6b54TpG1nSG6kp9QDGmO6zdJ/NHWvQhfhmI/nLmUNb4tvXaU8ZHEZL
         8qZom6h+pLblBkKhc1LXbXAM7YgyuRIJnHk7fT677AYN+vdP8OMT4IBZl84nbeFeSJk3
         RHCSV/k+WXib98visi2sgbsvSH695P0I60f2RKlml32mAyXYMnrqoXrACQdnXES2Uwwv
         Vrk6FiOFt2yQd4D2+1LBgqI+gFpDWkef/TcFjME7T0LxmicSMuI4gXyvj5Ql5O1vTjPL
         kHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712831353; x=1713436153;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISKH9dnh1aQWsltqN9UVLivJw0zyLjoG7+RHPHTqXeA=;
        b=r6i//GumZq0s2sBcIEHbBvaiU07aLZQJ0s4TBT5bJWy5ZpbdwuyhigG5CnW05XjUu8
         cAIx/AlzVIaHH3IILLAYiF/qE/O4/mxSNT1YGgO1DvLg032L5Tfvl1SdGIrJ42mqARK7
         poH1qY7+9rNOxEXJLkFHRKPbjrHSBn131DsvEpsRcD5MRZkiN4Cqn8v0HjR11acZcyzY
         XgTJt4oU3Aj4FiO5QHy/j6jZwsD6wP/cdczkWZHiUKh1OgniuMH4Cz4FXCi2UaUyCyoA
         c3dXXiYUYSDmZV1nW0czXwzvo1+kNbPg0Ap2MM5kgPzz1dfEBOYMVSoLE+tscKdYGfTX
         TwBw==
X-Forwarded-Encrypted: i=1; AJvYcCUGXJXwHOZcFYKPMSoPpXgHW9O+pkEw0NgCRjuvSjPJYlUHNgOzfP2wdXiOFca5bJICe7Y4I5zKQol2ie0KGjFxsq8DMxpg
X-Gm-Message-State: AOJu0YwBWglN+gBghz6bhl2WaYh8KLKXq2MGqJqIX5k+YNOsZyoYlU8V
	atk1eBiv42mOXXn4JuNBIZZLANkhXe1qVMcWSSgreDG/KbRv/7BymXRdRL3PoWM=
X-Google-Smtp-Source: AGHT+IFP1JaCM9jeyrrmkldGnJYxoqtYP0wWNPatQcXNE5r9GoHecqjJCZrDfbm1WhUKckK1C/j25A==
X-Received: by 2002:adf:f182:0:b0:345:603f:cd96 with SMTP id h2-20020adff182000000b00345603fcd96mr3795940wro.5.1712831352511;
        Thu, 11 Apr 2024 03:29:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id dd14-20020a0560001e8e00b00343e9f52903sm1429105wrb.57.2024.04.11.03.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 03:29:12 -0700 (PDT)
Message-ID: <4ebb922a-8b7f-4ab5-9a5a-b1c841b65433@linaro.org>
Date: Thu, 11 Apr 2024 12:29:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "arm64: dts: qcom: Add support for Xiaomi Redmi Note 9S"
 has been added to the 6.8-stable tree
To: Conor Dooley <conor.dooley@microchip.com>, Sasha Levin <sashal@kernel.org>
Cc: Greg KH <greg@kroah.com>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 stable@vger.kernel.org, stable-commits@vger.kernel.org,
 buddyjojo06@outlook.com, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>
References: <20240410155728.1729320-1-sashal@kernel.org>
 <e06402a9-584f-4f0c-a61e-d415a8b0c441@linaro.org>
 <2024041016-scope-unfair-2b6a@gregkh>
 <addf37ca-f495-4531-86af-6baf1f3709c3@linaro.org>
 <2024041132-heaviness-jasmine-d2d5@gregkh>
 <641eb906-4539-4487-9ea4-4f93a9b7e3cc@linaro.org>
 <2024041112-shank-winking-0b54@gregkh> <ZheX3KdUA76wTYMF@sashalap>
 <20240411-expectant-daylight-398929f2733b@wendy>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+FiEE
 m9B+DgxR+NWWd7dUG5NDfTtBYpsFAmI+BxMCGwMFCRRfreEFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQG5NDfTtBYptgbhAAjAGunRoOTduBeC7V6GGOQMYIT5n3OuDSzG1oZyM4kyvO
 XeodvvYv49/ng473E8ZFhXfrre+c1olbr1A8pnz9vKVQs9JGVa6wwr/6ddH7/yvcaCQnHRPK
 mnXyP2BViBlyDWQ71UC3N12YCoHE2cVmfrn4JeyK/gHCvcW3hUW4i5rMd5M5WZAeiJj3rvYh
 v8WMKDJOtZFXxwaYGbvFJNDdvdTHc2x2fGaWwmXMJn2xs1ZyFAeHQvrp49mS6PBQZzcx0XL5
 cU9ZjhzOZDn6Apv45/C/lUJvPc3lo/pr5cmlOvPq1AsP6/xRXsEFX/SdvdxJ8w9KtGaxdJuf
 rpzLQ8Ht+H0lY2On1duYhmro8WglOypHy+TusYrDEry2qDNlc/bApQKtd9uqyDZ+rx8bGxyY
 qBP6bvsQx5YACI4p8R0J43tSqWwJTP/R5oPRQW2O1Ye1DEcdeyzZfifrQz58aoZrVQq+innR
 aDwu8qDB5UgmMQ7cjDSeAQABdghq7pqrA4P8lkA7qTG+aw8Z21OoAyZdUNm8NWJoQy8m4nUP
 gmeeQPRc0vjp5JkYPgTqwf08cluqO6vQuYL2YmwVBIbO7cE7LNGkPDA3RYMu+zPY9UUi/ln5
 dcKuEStFZ5eqVyqVoZ9eu3RTCGIXAHe1NcfcMT9HT0DPp3+ieTxFx6RjY3kYTGLOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCYDzvagUJFF+UtgAKCRAbk0N9O0Fim9JzD/0auoGtUu4mgnna
 oEEpQEOjgT7l9TVuO3Qa/SeH+E0m55y5Fjpp6ZToc481za3xAcxK/BtIX5Wn1mQ6+szfrJQ6
 59y2io437BeuWIRjQniSxHz1kgtFECiV30yHRgOoQlzUea7FgsnuWdstgfWi6LxstswEzxLZ
 Sj1EqpXYZE4uLjh6dW292sO+j4LEqPYr53hyV4I2LPmptPE9Rb9yCTAbSUlzgjiyyjuXhcwM
 qf3lzsm02y7Ooq+ERVKiJzlvLd9tSe4jRx6Z6LMXhB21fa5DGs/tHAcUF35hSJrvMJzPT/+u
 /oVmYDFZkbLlqs2XpWaVCo2jv8+iHxZZ9FL7F6AHFzqEFdqGnJQqmEApiRqH6b4jRBOgJ+cY
 qc+rJggwMQcJL9F+oDm3wX47nr6jIsEB5ZftdybIzpMZ5V9v45lUwmdnMrSzZVgC4jRGXzsU
 EViBQt2CopXtHtYfPAO5nAkIvKSNp3jmGxZw4aTc5xoAZBLo0OV+Ezo71pg3AYvq0a3/oGRG
 KQ06ztUMRrj8eVtpImjsWCd0bDWRaaR4vqhCHvAG9iWXZu4qh3ipie2Y0oSJygcZT7H3UZxq
 fyYKiqEmRuqsvv6dcbblD8ZLkz1EVZL6djImH5zc5x8qpVxlA0A0i23v5QvN00m6G9NFF0Le
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240411-expectant-daylight-398929f2733b@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/04/2024 12:23, Conor Dooley wrote:
>>>>>> Now if you backport only (5) above, without (4), it won't work. Might
>>>>>> compile, might not. Even if it compiles, might not work.
>>>>>>
>>>>>> The step (4) here might be small, but might be big as well.
>>>>>
>>>>> Fair enough.  So should we drop this change?
>>>>
>>>> I vote for dropping. Also, I think such DTS patches should not be picked
>>>> automatically via AUTOSEL. Manual backports or targetted Cc-stable,
>>>> assuming that backporter investigated it, seem ok.
>>>
>>> Sasha now dropped this, thanks.
>>>
>>> Sasha, want to add dts changes to the AUTOSEL "deny-list"?
>>
>> Sure, this makes sense.
> 
> Does it? Seems like a rather big hammer to me. I totally understand
> blocking the addition of new dts files to stable, but there's a whole
> load of different people maintaining dts files with differing levels of
> remembering to cc stable explicitly.
> 
> That said, often a dts backport depends on a driver (or binding) change
> too, so backporting one without the other may have no effect. I have no
> idea whether or not AUTOSEL is capable of picking out those sort of
> dependencies.


Uh, yes, I understood as "trivial quirks and new device ID" AUTOSEL
behavior. Not AUTOSEL for DTS patches in general.

Best regards,
Krzysztof


