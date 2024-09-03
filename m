Return-Path: <stable+bounces-72835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB896969E53
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 14:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF7F28854B
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09C41CA6A6;
	Tue,  3 Sep 2024 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LPUZvfJd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A2A1CA6A2
	for <stable@vger.kernel.org>; Tue,  3 Sep 2024 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367809; cv=none; b=W/FLG7nQgIG7Ulhu4J66tKITtHelxXk0KWCmalJTqELCGXGDCPuTBUfTTg6G0TgNflIkB9Y7vrERdROtqqkbruRt9ibj+9qwy0BkM3XEzKdUeDoHbdd/4em3ttdI/NVJWxkblxPCXqRq9joqfk8Fekz27AecWZdM0O3TqXedAWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367809; c=relaxed/simple;
	bh=MBN2xSpa52DkQGJGADarQjT9otV416Df2mREl3d5SG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tunpUkwVPsPSCK8iT07QXSLFjY+03sI0fkmIvGG2P8cWqQKwvhX+NJszHKPrniGctNB1wa+EMACdcQtiOm7aMfn2pIW/CE8CeZ2Dwc5Oiq7XBL3nLThc+FYQsGJ51Q65KLRWXJj0XTJxVhMJafewOYYjcM40JuLIOZAm6YVs9ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LPUZvfJd; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42c53379a3fso4392725e9.0
        for <stable@vger.kernel.org>; Tue, 03 Sep 2024 05:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725367806; x=1725972606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GMwzvxOZu7c9r9nfXkgYTBixdNqC/XNfFaHtD+JuuUs=;
        b=LPUZvfJdmnpDsiJyRXSgOind+416epU+bUTUrMeEWYiL8o7MIkKFJf5avKlHr5WY1w
         wN5tzK/JR9cwaANRiiV27AsNiT+ZL4y+DO+9pEqcF+Gk+6EmJQ0F4wC9cp+ESbvt2aD/
         hhFEbhRYAFkA6tZKKX3lSE5ANvQTQSUbFIgU5xsb1hjAKNkJTPC/XjADhDDD4NvTelAw
         UVnCX4rPsJZgnc2sPqYlDtzNF1cbtXGQ6cyQ4QJflXVpcZSwFlIYy4sdMHewHHllz7/R
         w3UF0h44SIye75ZISIRUcpBIjhYJTtKe75fD8kxjkeITUBd9RC0SlbtvtKNBnWD4WuX/
         FwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725367806; x=1725972606;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMwzvxOZu7c9r9nfXkgYTBixdNqC/XNfFaHtD+JuuUs=;
        b=Sumbr3jC1ZiQgh/l8y+KtrVUQdNZ2685Fjbuv54gL0m17AU0KfUBsrFBwn4Iv6Anmm
         /T6xLjIQ3okIPpW1HHo/CpJZPeE6CB5cE34QaqT55+iHi65yPWJC2KUIk2wU3jQj3WjE
         3C8AUl17EBy++QF/n3U5g17jNjE2mw3pPHsQZNh7lr0MgQBiVDEqv+S2NIcQfgqmbQqC
         rPABb9WExukjqv5GIlToy5zLMZBYUFt0VeK/b7AK21ucQMRTTnuc1yzrsrWU1oUIAbjH
         G9kQdBJHqMFADOoic/nJ/sTWOyWMN/9T2gi+m1RmnQz2SH9tt82JP2Wgbof0zeJWWUyW
         2aIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK4oc9ONFJWrOmsvg1yORR9JYyJ8g3fY407IcX52hnlg74ZGIxdlo6Igt2bPyLb6IKrKf25rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0pz4qAWRgcWOY/gj74JfMslGrEL/2thwt0uzb2L9CQz95ZslZ
	G6x11QIhL/DGXZQ8+MhCOipd6Bud/0nUWMgsdrqNMnubmPgvqa2svjcDMLHocI4=
X-Google-Smtp-Source: AGHT+IFmQKlidYWjVF/1rxWjYYQwPYgkvnUUXvUCJWOG8ApJA+XwVKlQUikv2dr78p5yqIzv0WXaHA==
X-Received: by 2002:a05:600c:510d:b0:426:5f08:542b with SMTP id 5b1f17b1804b1-42bbb0ab351mr54178885e9.0.1725367805839;
        Tue, 03 Sep 2024 05:50:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba639d512sm203369545e9.18.2024.09.03.05.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 05:50:05 -0700 (PDT)
Message-ID: <f5110f23-6d73-45b5-87a3-380bb70b9ac8@linaro.org>
Date: Tue, 3 Sep 2024 14:50:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soundwire: stream: fix programming slave ports for
 non-continous port maps
To: "Liao, Bard" <yung-chuan.liao@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, bard.liao@intel.com
References: <20240729140157.326450-1-krzysztof.kozlowski@linaro.org>
 <095d7119-8221-450a-9616-2df6a0df4c77@linux.intel.com>
 <ZqngD56bXkx6vGma@matsya>
 <b6c75eee-761d-44c8-8413-2a5b34ee2f98@linux.intel.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
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
In-Reply-To: <b6c75eee-761d-44c8-8413-2a5b34ee2f98@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/09/2024 09:34, Liao, Bard wrote:
> 
> On 7/31/2024 2:56 PM, Vinod Koul wrote:
>> On 29-07-24, 16:25, Pierre-Louis Bossart wrote:
>>>
>>> On 7/29/24 16:01, Krzysztof Kozlowski wrote:
>>>> Two bitmasks in 'struct sdw_slave_prop' - 'source_ports' and
>>>> 'sink_ports' - define which ports to program in
>>>> sdw_program_slave_port_params().  The masks are used to get the
>>>> appropriate data port properties ('struct sdw_get_slave_dpn_prop') from
>>>> an array.
>>>>
>>>> Bitmasks can be non-continuous or can start from index different than 0,
>>>> thus when looking for matching port property for given port, we must
>>>> iterate over mask bits, not from 0 up to number of ports.
>>>>
>>>> This fixes allocation and programming slave ports, when a source or sink
>>>> masks start from further index.
>>>>
>>>> Fixes: f8101c74aa54 ("soundwire: Add Master and Slave port programming")
>>>> Cc: <stable@vger.kernel.org>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> This is a valid change to optimize how the port are accessed.
>>>
>>> But the commit message is not completely clear, the allocation in
>>> mipi_disco.c is not modified and I don't think there's anything that
>>> would crash. If there are non-contiguous ports, we will still allocate
>>> space that will not be initialized/used.
>>>
>>> 	/* Allocate memory for set bits in port lists */
>>> 	nval = hweight32(prop->source_ports);
>>> 	prop->src_dpn_prop = devm_kcalloc(&slave->dev, nval,
>>> 					  sizeof(*prop->src_dpn_prop),
>>> 					  GFP_KERNEL);
>>> 	if (!prop->src_dpn_prop)
>>> 		return -ENOMEM;
>>>
>>> 	/* Read dpn properties for source port(s) */
>>> 	sdw_slave_read_dpn(slave, prop->src_dpn_prop, nval,
>>> 			   prop->source_ports, "source");
>>>
>>> IOW, this is a valid change, but it's an optimization, not a fix in the
>>> usual sense of 'kernel oops otherwise'.
>>>
>>> Am I missing something?
>>>
>>> BTW, the notion of DPn is that n > 0. DP0 is a special case with
>>> different properties, BIT(0) cannot be set for either of the sink/source
>>> port bitmask.
>> The fix seems right to me, we cannot have assumption that ports are
>> contagious, so we need to iterate over all valid ports and not to N
>> ports which code does now!
> 
> 
> Sorry to jump in after the commit was applied. But, it breaks my test.
> 
> The point is that dpn_prop[i].num where the i is the array index, and
> 
> num is the port number. So, `for (i = 0; i < num_ports; i++)` will iterate

Please fix your email client so it will write proper paragraphs.
Inserting blank lines after each sentence reduces the readability.

> 
> over all valid ports.
> 
> We can see in below drivers/soundwire/mipi_disco.c
> 
>          nval = hweight32(prop->sink_ports);
> 
>          prop->sink_dpn_prop = devm_kcalloc(&slave->dev, nval,
> 
> sizeof(*prop->sink_dpn_prop),
> 
>                                             GFP_KERNEL);
> 
> And sdw_slave_read_dpn() set data port properties one by one.
> 
> `for_each_set_bit(i, &mask, 32)` will break the system when port numbers

The entire point of the commit is to fix it for non-continuous masks.
And I tested it with non-continuous masks.

> 
> are not continuous. For example, a codec has source port number = 1 and 3,

Which codec? Can you give a link to exact line in *UPSTREAM* kernel.

> 
> then dpn_prop[0].num = 1 and dpn_prop[1].num = 3. And we need to go
> 
> throuth dpn_prop[0] and dpn_prop[1] instead of dpn_prop[1] and dpn_prop[3].
> 

What are the source or sink ports in your case? Maybe you just generate
wrong mask?

It's not only my patch which uses for_each_set_bit(). sysfs_slave_dpn
does the same.

Best regards,
Krzysztof


