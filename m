Return-Path: <stable+bounces-183453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 593BCBBEB89
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 18:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D18F534A8A7
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 16:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA8C2DE6E6;
	Mon,  6 Oct 2025 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LhTE/nSm"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168412DCF47
	for <stable@vger.kernel.org>; Mon,  6 Oct 2025 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769075; cv=none; b=Jybz1wpHVWfm6m1KYuSByXcbEKbqSDlAoTJTvQX9khAQmwlQlpxAoO+znkox6bddG/HpJSJkbYDSE0btaBL374rcPuwPNqAQL0QJjVN41vFwXtsE4CwUaUfWPc8TPnAlU7Js2hix1IV9eqSDbPKmBSxdaM1oHVTfmmKxnQ+JHLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769075; c=relaxed/simple;
	bh=aS8DHPhfdkLC1tCtAdARWrrRBS4/KNRMppS1z1bQeGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQQ1G7MK8uXbdeH3DJUoKr0xgx/OoQG2pNxbZVUSI4+oHHeFdAwOuz7/CnlFQkYDpa8zmkVdz93EBNZ95xTn9eckYLqeNucr43A0T1tLx/63YRUAg72IMFAt7/0ZJlKfADnhfgQSkeWY99WeDSWl7Em4PyxJPB4Xwm1Giczq8Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LhTE/nSm; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-3729f8eaa10so1220057fac.3
        for <stable@vger.kernel.org>; Mon, 06 Oct 2025 09:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759769071; x=1760373871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UpiAWiK/9gl7kXYpIGL8zpOpeJcq8aBMhlNX/1cVAiI=;
        b=LhTE/nSmgqNldERKIf6mNQlJGyyFzsTUuRawcKyH8/1iOBD6qY3y4W+bq0aVE52E6g
         VYE/DWosb4psMsmLP7P5ewz0fyHHm0ONPqpc18iggA4uIq7jGsj6Bch/H5atJVkagFXQ
         Oa7MMCWDO/A/QpZljZGCrnhDPiYL5Vqa3wgxO/F+cvV83QE/AnC7CU5nMkMg34mwW4j6
         ow6jY8BFYDkBEHwMHlAyjYmOugi22vIg8FRhsJ7FUA5xSll4wHcwos8l+DD8VwDlw+Dz
         FlLnYYo4MRBuPYcORaoTlnl2llvHMhlJqx97IRHVhtsdvygasoOVCOH8QLSbFh+zI9J9
         ucRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759769071; x=1760373871;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UpiAWiK/9gl7kXYpIGL8zpOpeJcq8aBMhlNX/1cVAiI=;
        b=Xcyew5kIlWVH+ZEXVR/CirqQq3mkEJnpE8/sm8Ve2bnpMTFwVOfJ9/+KkT1rqjPa5P
         2Sk6PwU/TtgglkXp+L4fmRu18mYOAtv2JjlyjnCJfQmitcDmNDQfkiCuChxctp1wA2j+
         j4CW59QMWrVX8eKL5obETg2pjBGAKA6POXkxaxc+7inNMO9kubkDBsX2PGT3bv5kctML
         P1K7qoXdTDkWKH24gGEmJKxdLZ3BE91WzynsMycPArzq8vJNyEmmOJtkgmqRyE66HGEj
         DKBV8FnXFPcy5BbeowM/OWjCuSTpp5rzLwMEP8Y1qwS20hsZRLtVu6czu8mJSKoI/iAQ
         /CpA==
X-Forwarded-Encrypted: i=1; AJvYcCVrZqKK3zyrsxnWuLTuTSFPQ4dGJqnEIYGUTDLRPkseCPZJdUjD6uOLk5cJL2jnS7mIclg1umM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk/z97deXcuF4/AwQEPqPHfFa3RamceBxbWByPfbabBSFj9V+h
	yPWdC85yqsd/vJMcX8M6HOS3rNBCddLcLC+Qm7HhysQ/YhIZMzgx7g4GrcTbXr39XYw=
X-Gm-Gg: ASbGncvvBzaxGSC/6YQSdBdZO/6AZtMtOGBQZicOmTeqchgooJC+Xx277TjMtg519lC
	5O7pPoelNv9/eZxElusFvs4/l1TXpdeSjpXfLccTeJeGgWCBNXcv1+ZjWGE6fIFeKTYGMji9MoZ
	ZbrpIE3932L/XBzJblrHtBJY1ymSri28P3p6UHpmR7JirbCb0jI+ChrLlOLUBKWsNYqXCF8S4Ak
	AzG4RnOxvKS1dWRtYq/FLLAUjqpVrorHquWRS5jfCleFFLr11LcF8TNGPWhzWJ6Yllvzv4AeSSA
	nf9LcbDjbrpH/s4Hq8xfhJVg2H2iPseKE/UwmIO9doTNPIGBKgIuYep3OJZt1m1+txl/x9hy9qF
	CZkzi6gqsfgAVl3TqyQLYeqFDyJB9Cg1w3bp9ICVttc3VnWrJr2PJvn+E5nJdlU2BIhi3y03A8B
	Kgjqs1Hc7/jIrfksNDRUVC32g=
X-Google-Smtp-Source: AGHT+IG2R+E8ZzkCqqORbj5+wGHvn3wr2c/m6d94G6/GsMG/6CC6YBkDJyByDmXCeketeFDtbQyFNg==
X-Received: by 2002:a05:6870:3907:b0:395:9e1b:b0da with SMTP id 586e51a60fabf-3b0fb6a0778mr7105123fac.49.1759769071129;
        Mon, 06 Oct 2025 09:44:31 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a1fd:4fbd:e7a6:9246? ([2600:8803:e7e4:1d00:a1fd:4fbd:e7a6:9246])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ab7ce5655dsm4159051fac.13.2025.10.06.09.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 09:44:29 -0700 (PDT)
Message-ID: <118c3551-df86-4c23-b385-6f75d9bd5388@baylibre.com>
Date: Mon, 6 Oct 2025 11:44:29 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] iio: buffer: Fix DMABUF mapping in some systems
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>, nuno.sa@analog.com,
 linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 stable@vger.kernel.org
References: <20251006-fix-iio-dmabuf-get-dma-device-v2-0-d960bc9084da@analog.com>
 <7eeb3072-b54e-46c7-9fb2-c4d2422188d8@baylibre.com>
 <2fe00df37ad75591e437813f1c618c3decbdf2cb.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <2fe00df37ad75591e437813f1c618c3decbdf2cb.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/6/25 11:25 AM, Nuno Sá wrote:
> On Mon, 2025-10-06 at 11:18 -0500, David Lechner wrote:
>> On 10/6/25 11:06 AM, Nuno Sá via B4 Relay wrote:
>>> This series fixes an issue with DMABUF support in the IIO subsystem where
>>> the wrong DMA device could be used for buffer mapping operations. This
>>> becomes critical on systems like Xilinx/AMD ZynqMP Ultrascale where memory
>>> can be mapped above the 32-bit address range.
>>>
>>> Problem:
>>> --------
>>> The current IIO DMABUF implementation assumes it can use the parent device
>>> of the IIO device for DMA operations. However, this device may not have
>>> the appropriate DMA mask configuration for accessing high memory addresses.
>>> On systems where memory is mapped above 32-bits, this leads to the use of
>>> bounce buffers through swiotlb, significantly impacting performance.
>>>
>>> Solution:
>>> ---------
>>> This series introduces a new .get_dma_dev() callback in the buffer access
>>> functions that allows buffer implementations to specify the correct DMA
>>> device that should be used for DMABUF operations. The DMA buffer
>>> infrastructure implements this callback to return the device that actually
>>> owns the DMA channel, ensuring proper memory mapping without bounce buffers.
>>>
>>> Changes:
>>> --------
>>> 1. Add .get_dma_dev() callback to iio_buffer_access_funcs and update core
>>>    DMABUF code to use it when available
>>> 2. Implement the callback in the DMA buffer infrastructure
>>> 3. Wire up the callback in the dmaengine buffer implementation
>>>
>>> This ensures that DMABUF operations use the device with the correct DMA
>>> configuration, eliminating unnecessary bounce buffer usage and improving
>>> performance on high-memory systems.
>>>
>>> (AI generated cover. I would not be this formal but I guess is not
>>> that bad :))
>>>
>>> ---
>>> Changes in v2:
>>> - Dropped Fixes tags on the first two patches and Cc stable them instead
>>>   (as prerequisites for the third patch). 
>>> - Link to v1:
>>> https://lore.kernel.org/r/20251002-fix-iio-dmabuf-get-dma-device-v1-0-c1c9945029d0@analog.com
>>
>> Did you not care for my other suggestions in v1?
> 
> Completely missed them, sorry! I kind of stop reading in the stable stuff. I'm
> ok with the helper function. For the clarification I feel it's redundant. The

I was thinking extra clarification could be helpful for someone new to the IIO
subsystem. But it would be quite rare to add a new buffer implementation anyway.
So probably not too many people would actually ever read it. :-)

> field is called .get_dma_dev() and the description "called to get the DMA
> channel associated with this buffer" already implies is for DMA buffer. Same as
> ops like .enqueue_dmabuf().
> 
> - Nuno Sá

I don't feel too strongly about either change, so either way,

Reviewed-by: David Lechner <dlechner@baylibre.com>



