Return-Path: <stable+bounces-62676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75AF940D3E
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14DB41C24182
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427FF194ADC;
	Tue, 30 Jul 2024 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ih71YULP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DAE194ACD
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331158; cv=none; b=oaExkr5i7GUPcpJzjdtmKL+XpjOEal9FoJ/dIPS4FPxy/damXDbOLM1WAslw6GX0ZsfJ+LwIxzD7dtvMMKqaavkcnbrwfVJ6qJzqjwE3uy0TVDY4f51FChE9QSNQemrxSzVnFulluid4hU/UeY2ljZunMUfMZV1m/9VSvuOBWoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331158; c=relaxed/simple;
	bh=KDzaNaqrAn1n9ujgeV97I37YCEBTMWgTsNjpyBzWfu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nW+h9RzxN3gzktRnbNCtiG5ZDD/qIWapPeqdnbyt+nMqADbo76c7ECFSA5bbh83aoWKV6PN4egt8TrFXs+HNCMamSKUfZNV3OdR89D4vAfYjf0kVeplHphV8pJcsys5TbsdA+Kcb5bWOEVG+OzpFk2/6FgL5lLbFgDXyHNOgRlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ih71YULP; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3685b3dbcdcso2273544f8f.3
        for <stable@vger.kernel.org>; Tue, 30 Jul 2024 02:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722331153; x=1722935953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S088lJjgnH/0TxsA8y/tDHIdAXTl0lFmJ+nczD1rhuw=;
        b=ih71YULPAemeknMqG8GRkQmWH+eR7Rva4wKM34NaBREVoVczx+uqxy40T7GuF6ztIw
         P0/NB1xZ++9440vgg+3F2NZ/8Cm0Xg77vFn87KAWcTl0q4BsYJFXDJtiMMPG3n9N/7c0
         qDyptpeeg/4dV2ZwcDVzHDMVvbcBnM8W6M7MrMQVgKKOGPBTnMg5wYPsTa7XR1SDGlN6
         N6B+OEUBjcQVIcC22FwVk6yLOpHyDxqq+11x9G1q1rbsIU9Lq2fYVRCVsY5z19u4XssK
         fV7u9XPxcVedvR03SXnWJjzvwrANjA7R5PYOIwQ8HkcrLu1PYuLFQUNfDmAwhRA5mYCS
         RhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722331153; x=1722935953;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S088lJjgnH/0TxsA8y/tDHIdAXTl0lFmJ+nczD1rhuw=;
        b=gF1iK4k9nSLfuIphYmSvLzoGqWnE72ZU74iA7V7RwJ5lgRNpYNzeaO8azN5aodq7BA
         Uanb/gdvJrMBsP8D/HcDa5WjRwG4+y/JRMBzd5gOYYD+jhHAmc6+y5MPa4ulkgwySXqe
         aZjBDwtcBTtjyNpJTtA5pPZYLSIJQwym1CFITjYtsA22ifBzExX7JFOjavodspmxDNYx
         WdDF13YYAmWn1Dt9WKM2tbQ5MXcNEPqKdSMD66F9ryClAmB8aJtma8BCJ/8RbIgydWkV
         nnRVKVmFSXvx5K9gRfO+V4s2PVmryQvamuL0DTgQkAnTThYuVLhgnwEd3PdWgAGvVEnl
         2Fhg==
X-Gm-Message-State: AOJu0YxNxjy+L7n4lx56XdZMcQUNoBxud2NCrVUubFmnZ9VammzKzujg
	yj3Dyh/XbEaHdRLop/52jIVW06d7EDPcOkzudw3igechIsLCOrsKpBpCj9KadAo2u6aieU8Hc7t
	c
X-Google-Smtp-Source: AGHT+IHusXzEXHvix+kVwRU3G7ctA2PyD+/THo+fXxyQC0ZWkfD5ao7nBrcNtisZd1bxiL6LO8ElRw==
X-Received: by 2002:a5d:64a1:0:b0:36b:555a:e966 with SMTP id ffacd0b85a97d-36b5d2c9cfemr8890486f8f.35.1722331153322;
        Tue, 30 Jul 2024 02:19:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c0338sm14380851f8f.1.2024.07.30.02.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 02:19:12 -0700 (PDT)
Message-ID: <7171817f-e8c6-4828-8423-0929644ff2df@linaro.org>
Date: Tue, 30 Jul 2024 11:19:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soundwire: stream: fix programming slave ports for
 non-continous port maps
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240729140157.326450-1-krzysztof.kozlowski@linaro.org>
 <095d7119-8221-450a-9616-2df6a0df4c77@linux.intel.com>
 <22b20ad7-8a25-4cb2-a24e-d6841b219977@linaro.org>
 <dc66cd0d-6807-4613-89a8-296ce5dd2daf@linaro.org>
 <62280458-3e74-43b0-b9a1-84df09abd30e@linux.intel.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <62280458-3e74-43b0-b9a1-84df09abd30e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/07/2024 10:59, Pierre-Louis Bossart wrote:
>>>>
>>>> 	/* Read dpn properties for source port(s) */
>>>> 	sdw_slave_read_dpn(slave, prop->src_dpn_prop, nval,
>>>> 			   prop->source_ports, "source");
>>>>
>>>> IOW, this is a valid change, but it's an optimization, not a fix in the
>>>> usual sense of 'kernel oops otherwise'.
>>>>
>>>> Am I missing something?
>>>>
>>>> BTW, the notion of DPn is that n > 0. DP0 is a special case with
>>>> different properties, BIT(0) cannot be set for either of the sink/source
>>>> port bitmask.
>>>
>>> I think we speak about two different things. port num > 1, that's
>>> correct. But index for src_dpn_prop array is something different. Look
>>> at mipi-disco sdw_slave_read_dpn():
>>>
>>> 173         u32 bit, i = 0;
>>> ...
>>> 178         addr = ports;
>>> 179         /* valid ports are 1 to 14 so apply mask */
>>> 180         addr &= GENMASK(14, 1);
>>> 181
>>> 182         for_each_set_bit(bit, &addr, 32) {
>>> ...
>>> 186                 dpn[i].num = bit;
>>>
>>>
>>> so dpn[0..i] = 1..n
>>> where i is also the bit in the mask.
> 
> yes, agreed on the indexing.
> 
> But are we in agreement that the case of non-contiguous ports would not
> create any issues? the existing code is not efficient but it wouldn't
> crash, would it?
> 
> There are multiple cases of non-contiguous ports, I am not aware of any
> issues...
> 
> rt700-sdw.c:    prop->source_ports = 0x14; /* BITMAP: 00010100 */
> rt711-sdca-sdw.c:       prop->source_ports = 0x14; /* BITMAP: 00010100
> rt712-sdca-sdw.c:       prop->source_ports = BIT(8) | BIT(4);
> rt715-sdca-sdw.c:       prop->source_ports = 0x50;/* BITMAP: 01010000 */
> rt722-sdca-sdw.c:       prop->source_ports = BIT(6) | BIT(2); /* BITMAP:
> 01000100 */
> 
> same for sinks:
> 
> rt712-sdca-sdw.c:       prop->sink_ports = BIT(3) | BIT(1); /* BITMAP:
> 00001010 */
> rt722-sdca-sdw.c:       prop->sink_ports = BIT(3) | BIT(1); /* BITMAP:
> 00001010 */

All these work because they have separate source and sink dpn_prop
arrays. Separate arrays, separate number of ports, separate masks - all
this is good. Now going to my code...

> 
>>> Similar implementation was done in Qualcomm wsa and wcd codecs like:
>>> array indexed from 0:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/codecs/wcd938x-sdw.c?h=v6.11-rc1#n51
>>>
>>> genmask from 0, with a mistake:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/codecs/wcd938x-sdw.c?h=v6.11-rc1#n1255
>>>
>>> The mistake I corrected here:
>>> https://lore.kernel.org/all/20240726-asoc-wcd-wsa-swr-ports-genmask-v1-0-d4d7a8b56f05@linaro.org/
>>>
>>> To summarize, the mask does not denote port numbers (1...14) but indices
>>> of the dpn array which are from 0..whatever (usually -1 from port number).
>>>
>>
>> Let me also complete this with a real life example of my work in
>> progress. I want to use same dpn_prop array for sink and source ports
>> and use different masks. The code in progress is:
>>
>> https://git.codelinaro.org/krzysztof.kozlowski/linux/-/commit/ef709a0e8ab2498751305367e945df18d7a05c78#6f965d7b74e712a5cfcbc1cca407b85443a66bac_2147_2157
>>
>> Without this patch, I get -EINVAL from sdw_get_slave_dpn_prop():
>>   soundwire sdw-master-1-0: Program transport params failed: -2
> 
> Not following, sorry. The sink and source masks are separate on purpose,
> to allow for bi-directional ports. The SoundWire spec allows a port to
> be configured at run-time either as source or sink. In practice I've
> never seen this happen, all existing hardware relies on ports where the
> direction is hard-coded/fixed, but still we want to follow the spec.

The ports are indeed hard-coded/fixed.

> 
> So if ports can be either source or sink, I am not sure how the
> properties could be shared with a single array?

Because I could, just easier to code. :) Are you saying the code is not
correct? If I understand the concept of source/sink dpn port mask, it
should be correct. I have some array with source and sink ports. I pass
it to Soundwire with a mask saying which ports are source and which are
sink.

> 
> Those two lines aren't clear to me at all:
> 
> 	pdev->prop.sink_dpn_prop = wsa884x_sink_dpn_prop;
> 	pdev->prop.src_dpn_prop = wsa884x_sink_dpn_prop;

I could do: s/wsa884x_sink_dpn_prop/wsa884x_dpn_prop/ and expect the
code to be correct.

Best regards,
Krzysztof


