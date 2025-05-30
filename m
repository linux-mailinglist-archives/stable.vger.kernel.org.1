Return-Path: <stable+bounces-148332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91594AC974D
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 23:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67B4E1BA6AA6
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 21:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E798B188A0E;
	Fri, 30 May 2025 21:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VHtuZifs"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43B224A069
	for <stable@vger.kernel.org>; Fri, 30 May 2025 21:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748641808; cv=none; b=exMd/kSCWnMjsaizePX7TceA1GNk00S2teZLLzVslasXqNEVyvU+rlvrAKe8rJAdXhijYHIIuKuPcfepuPwxUm0oosN3QkWA6q3CyyuNI5A6pgY5tAgBrp/nzNzGUrXnT10IY0w6SAY/LOLHfOE5WNhquGh0YFHtRkMHxw9mbKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748641808; c=relaxed/simple;
	bh=qRNQr42BE3Yl7n3M8td8QtoNUy7g0M+m+RTxxoYs3m0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hzs5oJPUc9JNgukoRd4VtWW130Ia2v8kIEs/NWdbBsbqgfMXNEOsXCC/vV/HGjzqaeAZZoU81/bBuKYLyVyFAANj5IRy+bVRXqi0u1a68GFHH11dHHM9W6dqllN08Jf/4RtGjes0PlKivAfQHCTHyqCs8xPgfXHWCU06C7EoDD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VHtuZifs; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-72c27166ab3so1855858a34.1
        for <stable@vger.kernel.org>; Fri, 30 May 2025 14:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748641805; x=1749246605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yx81pqwwbBYn5lePt7BoAo7tJ3jt/JP5rfBYVw2pj3E=;
        b=VHtuZifsDhiCWEGs4kxuuMzKZWveI+Ixr0s8Wq26oS8UHF9ePfPfO72jQZoQvZs6E/
         L164wYVlRQzCTdsRna18R99G9D4IbghxZsACK/1aLgehhzHFUsUXnwNszWcWktstUyy5
         EQaYUCLsgOt19tEFpip5WsD+B/jk6huqovmnzXkwXhkS+IhkjnrBURrlE8lPEV8F6At9
         kIfZj6Gc0jvzkoSdUl6j0XKOoBl195Bjc6QB7RbOlL1n1IKwIy6MGT7ekFx0BhLF6U+Z
         y2NsAvDeXMojiUsOZyd1M385OFo3XMp3EFPsHf1XHP/XR7tX6G6L57yRgRmrlqV6Hj7K
         rR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748641805; x=1749246605;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yx81pqwwbBYn5lePt7BoAo7tJ3jt/JP5rfBYVw2pj3E=;
        b=Ssvh+PxCmrwXSQGHSOJWqj3eIqdxQ1Wm7SDxr0k2qTk6QzvU3qXwWX+qPQgQVeeSAo
         pEbnKeGzR9+BwP6fjmmgZy/F5EshcyeXrGom6UjycCUsgA4ZvoBaUNZXgoFz9AM89m0b
         Ww3wxjyydiFLxBrlAkP+r+h1KlCWXn834FdW0ySuvJBmvINxfJtRdYITQbNvupePch3k
         BTJSGtgR/FHmWhEUURBYqGHnbDZszcKiaUfgb3OLo1JfwhuTJ37kVtgvUIxGDtnJ4B2f
         VWfz+RaBW26yJ/gxFG+WhAS7SPS5OVkjO90DEjN1B543e9GUYABsqDTh6m14cDFq3Pxg
         cPIg==
X-Forwarded-Encrypted: i=1; AJvYcCVDEp3Kw5GDrx6r2wgmAz8W6WR7r2gJ5bc6t7+5MzYQ/HCvCB34wmgqNGFOHv3S/8EXp8iPSRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm5mdBZ3fMVHO0kiq9pQAOjy/gXD1v8WdOOAR0CuIoF2XMlMIt
	M/GbBaWLJYxLeHsn0+nRlOUkvR/OXgWmyNcclos3rpV3R/ywqdQNJT29QHOjslubpo0=
X-Gm-Gg: ASbGnctT9m47a4XmPpIRkG2wz9AcScpBpfnF/oBgOqctm5T4c66bQCHQkNc1Q3oSuj0
	Y7438gGboULlNGw9s8sBbIB+8E9I3ziZiu3LJV0G90rGl+eLNxFDYVWPEU866zRFNBz30XBTk89
	MarcyPzgtkbhx4IEw674yHtwIvri7S//mYPjqZVBojh7AR25zioevvK1rMns/nWiNnx5+gYsfEm
	6OI6t78Tx02DJGQ6u7t3/aFZy/EWtajeDpC89KRPbIt3Cu7lG3NvR2iHHPMcsLBa/3YkBhkjR0d
	uM0DLyM4Ftz5d8tj565mJCeQs1cbknSC8f5avdowFUofD4AgF5/BESJZxSP6nIyLFPKKtGoFGIZ
	xZUt+p+849UHxJFSN39TtBWuejc4IknCkb9bxH6x8xlgaeK+JSQ==
X-Google-Smtp-Source: AGHT+IGbtm1Vo+92Gwm8cAFKlbalOEtUOWP/1hEuC2BeNRcj8dxiGlx5vFgM94rzDENm2iMjXOyyfA==
X-Received: by 2002:a9d:3e03:0:b0:72b:7e3c:7284 with SMTP id 46e09a7af769-736eceeda85mr1547614a34.18.1748641804853;
        Fri, 30 May 2025 14:50:04 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4b52:4054:714f:5bf2? ([2600:8803:e7e4:1d00:4b52:4054:714f:5bf2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-735af9bc85bsm739875a34.46.2025.05.30.14.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 14:50:04 -0700 (PDT)
Message-ID: <77589639-6b2a-40be-b80e-47c10e1c908f@baylibre.com>
Date: Fri, 30 May 2025 16:50:02 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: adi-axi-adc: fix ad7606_bus_reg_read()
From: David Lechner <dlechner@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Angelo Dureghello <adureghello@baylibre.com>,
 Guillaume Stols <gstols@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250530-iio-adc-adi-axi-adc-fix-ad7606_bus_reg_read-v1-1-ce8f7cb4d663@baylibre.com>
 <90226114-646c-4af7-bd38-361ac383699f@baylibre.com>
Content-Language: en-US
In-Reply-To: <90226114-646c-4af7-bd38-361ac383699f@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/30/25 2:14 PM, David Lechner wrote:
> On 5/30/25 2:09 PM, David Lechner wrote:
>> Mask the value read before returning it. The value read over the
>> parallel bus via the AXI ADC IP block contains both the address and
>> the data, but callers expect val to only contain the data.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 79c47485e438 ("iio: adc: adi-axi-adc: add support for AD7606 register writing")
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  drivers/iio/adc/adi-axi-adc.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
>> index cf942c043457ccea49207c3900153ee371b3774f..d4759a98b4062bc25ea088e3868806e82db03e8d 100644
>> --- a/drivers/iio/adc/adi-axi-adc.c
>> +++ b/drivers/iio/adc/adi-axi-adc.c
>> @@ -457,6 +457,9 @@ static int ad7606_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val)
>>  	axi_adc_raw_write(back, addr);
>>  	axi_adc_raw_read(back, val);
>>  
>> +	/* Register value is 8 bits. Remove address bits. */
>> +	*val &= 0xFF;
> 
> I just found out that there is ADI_AXI_REG_VALUE_MASK we can use
> here instead of 0xFF.
> 
>> +
>>  	/* Write 0x0 on the bus to get back to ADC mode */
>>  	axi_adc_raw_write(back, 0);
>>  
>>
>> ---
>> base-commit: 7cdfbc0113d087348b8e65dd79276d0f57b89a10
>> change-id: 20250530-iio-adc-adi-axi-adc-fix-ad7606_bus_reg_read-f2bbb503db8b
>>
>> Best regards,
> 

Normally I would wait longer for comments, but this is rather small and
I've got some other changes that depend on this ready to go, so skip
ahead to v2.

