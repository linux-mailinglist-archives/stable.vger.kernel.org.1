Return-Path: <stable+bounces-170051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED484B2A0B4
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B14427B62B3
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 11:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D965F30E0D5;
	Mon, 18 Aug 2025 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tWW2/ElX"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD60F288C08
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755517672; cv=none; b=GAYAhGAB3IBdd6wFKTCxB47uFeGLWzC4yr8sjMlhJWnhQezenQU3ukdn55M30MtewFR1JRAannnXWQn7GcVJmwslDlGcwBE+x9LLLTOwR8vK5gDZzBWxe39mxDXOCRGKiHxDDa5SEkhVNrEQ5Zxlm2r06ZSJn1D4T0QD1qn0+sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755517672; c=relaxed/simple;
	bh=tGBqh60Un0TalerAF7oi+EQiBm/FcItRtvBszAhPCVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8q6ek9owjyWvyBVnjMPHw6iaGlsvnEerhzyHCH8FTj8zwPcmZr0bdwTCduRJEGVTyW3CwvTHPl5JnGwzHRQyEFE8sbgmHb/27ADfxIjpaEGyxKOFBdfLPU3C0FrF/a10x+9+CTrM7sgV6Aewb3NayYVqfj/IqjeOUgVm2zcKIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tWW2/ElX; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-618adbeff22so409141a12.3
        for <stable@vger.kernel.org>; Mon, 18 Aug 2025 04:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755517669; x=1756122469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wyRfBryJejL1jcHUi+Bp1Ubw25EetLDqaChcg3c+p3w=;
        b=tWW2/ElXDR2LouGbmaJdlOQBfr0wYzqFht5acK0oSN8UZwM/L5eoVksNbzXmL9yHDl
         fOuVaYrrG6j85PqpUK7sBifLVfh/slP1HApgHOAVrvZDjbdL57Rof0bYk5xYWa5KeT0s
         H+jX4ytSkVBGIm7CFcxSibzumGDrVG5E09EwnqgGcln+nGuZWPqJEibSu/GhYIwZOgqB
         VHVsfRDLkHDDL8l932Uj2UbPSrDH2bUcClq9IfBy/1e1WmiwrET+CeDP3UHfRVLco8PN
         qTJsHmHrbW95avjG0M17NTgaPj+jVzSCLyNjaaE7rjosogedm6cGldbddz5k2k0l+dfP
         OmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755517669; x=1756122469;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wyRfBryJejL1jcHUi+Bp1Ubw25EetLDqaChcg3c+p3w=;
        b=OgX4/kNaTIliRUxXB45QphHfUNLThiYH3kqOb/9wHEnEwqXz7pPwCIid0eo1kYOhQy
         y+ha9VQRs+73JnSF479UkouThD7its1LnshAzOMv59xoWc8mqEGz44aDZsV0Z2uDbTmE
         AZExnZHThqMwqnTWO0/ScAkzbU9100AQzNp3eyYh5G2stUGh8qy5F2n/nri3TQtulOUe
         o86wTLV4FnQllBFXxJvx+JkHu+Uiu6zsxsdseb3Xm9/olSoOiUyMv968msQ/WlL5dhvh
         /7+9DV0fApnHfIXDy3EZTjZgBPN5K81NsxhzaeH9s1h4neKTu9MTlvGgyG/qv9ORzrcv
         z2lg==
X-Gm-Message-State: AOJu0YwY7BvnYLlD9QOjtqVfavEM2CzijHHPar3mtFmEVmmTExVIWKEw
	LNSQxqQu5AmBK5Igm4lnGTNbU+8ByRNvXLDriCQQUcumZa9wxuVz8nOvecraYbRQClA=
X-Gm-Gg: ASbGnctJOvV4NP/6JOVJroHEvybto95vb4+jY1DtSYQnAKLK7Vig21CdMy3oWmLsZ4W
	MoO0yh/nQqZfIPiwzWWTEOfo4MiPpG0oTr/6qLIuOInY+2tKVkyJi7k7gu7gK1KxpD3DAcpwN1O
	RMqK5yheF7cfYclt5NJOe3SyuwpIjZae44Xvh1hgZu5H22sHuB8oI2UQGleK5Ow1aOUP+9v6MQN
	R+dDjEsj0B8IOAIPO27z7HI1NHH4fYbP4FVtkbUYlkGVbjsTwoY8JEhlY4UGkqiVxlOVfb7YPFA
	OcTbZZgfFvQCPfOC7LuE++ML6vhtQwKG3LIaSEn03D9OggSrhEYE55da1sFF/zJCgAdUgSK9IKu
	Slc7OjrSKe7rGyY4efb7/dyynsPrw3APXeTfYqt7i2YnH95yKnGzV1A==
X-Google-Smtp-Source: AGHT+IGL6fqxjaynuafgC5BqIzUloo+GykeyBNTQgTdgf+l4Lyt5a1MZcGz9r615RaktpZ8JU4TDbw==
X-Received: by 2002:a05:6402:520f:b0:618:227b:8848 with SMTP id 4fb4d7f45d1cf-618b0f2715cmr4571238a12.7.1755517669110;
        Mon, 18 Aug 2025 04:47:49 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-618af9da3e7sm7004184a12.13.2025.08.18.04.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 04:47:48 -0700 (PDT)
Message-ID: <63e044d1-ad3e-4971-9b7d-6b58c2ccc852@linaro.org>
Date: Mon, 18 Aug 2025 13:47:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: qcom: q6apm-lpass-dais: Fix NULL pointer
 dereference if source graph failed
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250815113915.168009-2-krzysztof.kozlowski@linaro.org>
 <70abcfee-e4c1-42d9-b623-266140aa2ff3@oss.qualcomm.com>
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
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+AhsD
 BQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEm9B+DgxR+NWWd7dUG5NDfTtBYpsFAmgXUEoF
 CRaWdJoACgkQG5NDfTtBYpudig/+Inb3Kjx1B7w2IpPKmpCT20QQQstx14Wi+rh2FcnV6+/9
 tyHtYwdirraBGGerrNY1c14MX0Tsmzqu9NyZ43heQB2uJuQb35rmI4dn1G+ZH0BD7cwR+M9m
 lSV9YlF7z3Ycz2zHjxL1QXBVvwJRyE0sCIoe+0O9AW9Xj8L/dmvmRfDdtRhYVGyU7fze+lsH
 1pXaq9fdef8QsAETCg5q0zxD+VS+OoZFx4ZtFqvzmhCs0eFvM7gNqiyczeVGUciVlO3+1ZUn
 eqQnxTXnqfJHptZTtK05uXGBwxjTHJrlSKnDslhZNkzv4JfTQhmERyx8BPHDkzpuPjfZ5Jp3
 INcYsxgttyeDS4prv+XWlT7DUjIzcKih0tFDoW5/k6OZeFPba5PATHO78rcWFcduN8xB23B4
 WFQAt5jpsP7/ngKQR9drMXfQGcEmqBq+aoVHobwOfEJTErdku05zjFmm1VnD55CzFJvG7Ll9
 OsRfZD/1MKbl0k39NiRuf8IYFOxVCKrMSgnqED1eacLgj3AWnmfPlyB3Xka0FimVu5Q7r1H/
 9CCfHiOjjPsTAjE+Woh+/8Q0IyHzr+2sCe4g9w2tlsMQJhixykXC1KvzqMdUYKuE00CT+wdK
 nXj0hlNnThRfcA9VPYzKlx3W6GLlyB6umd6WBGGKyiOmOcPqUK3GIvnLzfTXR5DOwU0EVUNc
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
 DFH41ZZ3t1Qbk0N9O0FimwUCaBdQXwUJFpZbKgAKCRAbk0N9O0Fim07TD/92Vcmzn/jaEBcq
 yT48ODfDIQVvg2nIDW+qbHtJ8DOT0d/qVbBTU7oBuo0xuHo+MTBp0pSTWbThLsSN1AuyP8wF
 KChC0JPcwOZZRS0dl3lFgg+c+rdZUHjsa247r+7fvm2zGG1/u+33lBJgnAIH5lSCjhP4VXiG
 q5ngCxGRuBq+0jNCKyAOC/vq2cS/dgdXwmf2aL8G7QVREX7mSl0x+CjWyrpFc1D/9NV/zIWB
 G1NR1fFb+oeOVhRGubYfiS62htUQjGLK7qbTmrd715kH9Noww1U5HH7WQzePt/SvC0RhQXNj
 XKBB+lwwM+XulFigmMF1KybRm7MNoLBrGDa3yGpAkHMkJ7NM4iSMdSxYAr60RtThnhKc2kLI
 zd8GqyBh0nGPIL+1ZVMBDXw1Eu0/Du0rWt1zAKXQYVAfBLCTmkOnPU0fjR7qVT41xdJ6KqQM
 NGQeV+0o9X91X6VBeK6Na3zt5y4eWkve65DRlk1aoeBmhAteioLZlXkqu0pZv+PKIVf+zFKu
 h0At/TN/618e/QVlZPbMeNSp3S3ieMP9Q6y4gw5CfgiDRJ2K9g99m6Rvlx1qwom6QbU06ltb
 vJE2K9oKd9nPp1NrBfBdEhX8oOwdCLJXEq83vdtOEqE42RxfYta4P3by0BHpcwzYbmi/Et7T
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <70abcfee-e4c1-42d9-b623-266140aa2ff3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/08/2025 17:56, Srinivas Kandagatla wrote:
> Thanks Krzysztof,
> On 8/15/25 12:39 PM, Krzysztof Kozlowski wrote:
>> If earlier opening of source graph fails (e.g. ADSP rejects due to
> 
> I think you are referring to the err patch in prepare.

True I am working on feature relying on that other patch, but the code
here is not really relevant to that other patch, I think.

> 
>> incorrect audioreach topology), the graph is closed and
>> "dai_data->graph[dai->id]" is assigned NULL.  Preparing the DAI for sink
>> graph continues though and next call to q6apm_lpass_dai_prepare()
>> receives dai_data->graph[dai->id]=NULL leading to NULL pointer
>> exception:
>>
>>   qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
>>   qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
>>   q6apm-lpass-dais 30000000.remoteproc:glink-edge:gpr:service@1:bedais: fail to start APM port 78
>>   q6apm-lpass-dais 30000000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC: error at snd_soc_pcm_dai_prepare on TX_CODEC_DMA_TX_3: -22
>>   Unable to handle kernel NULL pointer dereference at virtual address 00000000000000a8
>>   ...
>>   Call trace:
>>    q6apm_graph_media_format_pcm+0x48/0x120 (P)
>>    q6apm_lpass_dai_prepare+0x110/0x1b4
>>    snd_soc_pcm_dai_prepare+0x74/0x108
>>    __soc_pcm_prepare+0x44/0x160
>>    dpcm_be_dai_prepare+0x124/0x1c0
>>
>> Fixes: 30ad723b93ad ("ASoC: qdsp6: audioreach: add q6apm lpass dai support")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
>> index f90628d9b90e..7520e6f024c3 100644
>> --- a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
>> +++ b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
>> @@ -191,6 +191,12 @@ static int q6apm_lpass_dai_prepare(struct snd_pcm_substream *substream, struct s
>>  			return rc;
>>  		}
>>  		dai_data->graph[graph_id] = graph;
>> +	} else if (!dai_data->graph[dai->id]) {
>> +		/*
>> +		 * Loading source graph failed before, so abort loading the sink
>> +		 * as well.
>> +		 */
>> +		return -EINVAL;
>>  	}
> I guess this is the capture graph that is triggering the error, normally
> we do not open/close the capture graph in prepare, we do
> stop/prepare/start for capture graphs and handle open close in
> startup/shutdown.
> 
> Can you try this change and see if it fixes the issue, as prepare could
> be called multiple times and your patch will not give chance for trying
> new parameters incase the failure was due to unsupported params.


Yes, this works.

Best regards,
Krzysztof

