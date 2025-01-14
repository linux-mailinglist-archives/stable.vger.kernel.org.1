Return-Path: <stable+bounces-108594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B743A107C1
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 14:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7AC3A60A9
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 13:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98F1232434;
	Tue, 14 Jan 2025 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NGUQ5Tqs"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F28232429
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736861213; cv=none; b=kSJPodHMlkdhGB3pu1lS37tBxSup2jrHUQ0eGpe2WnwCtJ9dR4w1joYiKQE+9yi2EXfy/Xk1JivroJ1XOFFYWA+VGPr6HWtsk8N/SrYmVBuBNGs+xW5xZX5Blz0wgN81jsYkBQj+s11W+hlYFGhgt3veImLcnMVoHyQ1JP5JCiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736861213; c=relaxed/simple;
	bh=oqkdaJc7d1RBWIakykFDEpoN4JG+P49yBNR8Zxvs5iM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JtPF6uP05t8D8CQvycV0r+TSwoa7PNURuw+XdWo6sCdFKTbrkzBIiPWqNHCH1CL9HLc4C5uAXpy3z6DSRt0NYI89WXRNJnFvHw1eBWxa9s94lQhCVdBmqLYHU4ezfmtQk3qbR+Xqk9Qh+Ryet5stfpGTt71qBTDO6q5JzNgdzTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NGUQ5Tqs; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d9f06f8cf2so2621261a12.3
        for <stable@vger.kernel.org>; Tue, 14 Jan 2025 05:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736861210; x=1737466010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SwP1fWlfGGErtp8bBZm5i5ifr1nN44Oj3Q18CXqmO5A=;
        b=NGUQ5TqsMQ3Da6DLf43INyMamZAQR+qLQiPkaIllr7qo+sBTrZ7DSy471GnLL3AYTe
         s+2uIsKy7HCiGw1hbOUfcplmg+ZEKzBE6wKt60Wcu/QC6qYIUKBA8dLmRftS/FQAMODx
         vcxNdIt+YF5qZ8iwuUSidU1A6gdusLHdDVLTRY+m7KS/xQnSj0UR50E7XKxH40dBejX8
         KhVp1JTOKE0/+2K5107kWe0LPpvxvTcT4T7DGa35XRaSYJABXfJ+N2CtqRDnrF91OoTR
         JiJgoOZE09el5LTRETpRQ9V/FkSkuBmaSmJUtUo+dUhUWGMQTp/Yk2vvokKSpDH/iLq7
         eL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736861210; x=1737466010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SwP1fWlfGGErtp8bBZm5i5ifr1nN44Oj3Q18CXqmO5A=;
        b=aVfIWnugo6pADF3Wx2ELSZu+vNp0I3pfjHgWvP50XxXK2EV8atXaHQpOssm1DXH98H
         gD6d+L0f+EYd+XhMhjLyrxXJzA1eIYmqk4dkBhY5RbS4pYsAvJtI3cMELo6j+c1MQuiV
         ILEga2/W4vwHN9wPpaNd0KETTjdTdwoNzKBrzRWYdVUbs/CKugqL50y3sWAwnP7cy56v
         Ox8Ztw4UB8KIAcAvos/dyPzqtKBArI4WPK3WvVFGeI7+ayUjWx6LN0UWoOfE+eCUo5nM
         Clk09Eup2g1qQ64895KfEnOfEgsA2Ybmkf1uQazSEduMd3Vkjxr0/XXoZehh4PKW56Df
         W6Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVqQ53rvqpPW+NiZnswjg67toKhKZ80jXAcIo8PyGgcq1G+qzvmsO2XERslP4zG3w+QvGa1MQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJY+yLpHbEfUnqqu0UJgPoDQ+XJbRMPSExlc87IKSbpltXbl+I
	bXJHYH8bugX65q59E6hSnXZNVQUkluQwpIv9+zv/VdqeASElN1R4vIINn9V1VsM=
X-Gm-Gg: ASbGncvCb9ds/c1vzC510WrLCx9IksAhOMMaiS2zdBVxQldi3UJjGkRZ4g90eh0uy3p
	M5GpEWL6RjJy/lHC0Dn2gOkffbx1QOueHFlPl4Trfr/VcA2qNcTZmXH4QJjqIF1XmRcj481j5jD
	/t9Xy451KZp0oO+bb1VempJz+GR25cp5L7GIzemQ+QVGTpoxCyJNx+DaVns0YG9Twm1mH2lbg41
	wqD9N/cnyzU1IS7PD9KyYbXxX+B2Org9VWNJ2SnPcIQIaXkPcBaXD0MGK9GSqpyiQ==
X-Google-Smtp-Source: AGHT+IHiyC46xplGJdklMtXND7RjzCQWOyPJKK3BjZRR0yKKUaFCWD64tUVUuhFaBnEGxcCpqnwQ7w==
X-Received: by 2002:a05:6402:5187:b0:5d9:adb:4692 with SMTP id 4fb4d7f45d1cf-5d972e06b4cmr23050698a12.9.1736861209943;
        Tue, 14 Jan 2025 05:26:49 -0800 (PST)
Received: from [192.168.0.14] ([188.26.60.120])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99008c496sm6287162a12.16.2025.01.14.05.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 05:26:49 -0800 (PST)
Message-ID: <a6a9dfce-6cac-4831-9c96-45471f5ee13a@linaro.org>
Date: Tue, 14 Jan 2025 13:26:47 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mtd: spi-nor: core: replace dummy buswidth from
 addr to data
To: Alexander Stein <alexander.stein@ew.tq-group.com>, pratyush@kernel.org,
 mwalle@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: alvinzhou@mxic.com.tw, leoyu@mxic.com.tw,
 Cheng Ming Lin <chengminglin@mxic.com.tw>, stable@vger.kernel.org,
 Cheng Ming Lin <linchengming884@gmail.com>
References: <20241112075242.174010-1-linchengming884@gmail.com>
 <20241112075242.174010-2-linchengming884@gmail.com>
 <3342163.44csPzL39Z@steina-w>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <3342163.44csPzL39Z@steina-w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/25 12:57 PM, Alexander Stein wrote:
> Hello everyone,

Hi,

> 
> Am Dienstag, 12. November 2024, 08:52:42 CET schrieb Cheng Ming Lin:
>> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>>
>> The default dummy cycle for Macronix SPI NOR flash in Octal Output
>> Read Mode(1-1-8) is 20.
>>
>> Currently, the dummy buswidth is set according to the address bus width.
>> In the 1-1-8 mode, this means the dummy buswidth is 1. When converting
>> dummy cycles to bytes, this results in 20 x 1 / 8 = 2 bytes, causing the
>> host to read data 4 cycles too early.
>>
>> Since the protocol data buswidth is always greater than or equal to the
>> address buswidth. Setting the dummy buswidth to match the data buswidth
>> increases the likelihood that the dummy cycle-to-byte conversion will be
>> divisible, preventing the host from reading data prematurely.
>>
>> Fixes: 0e30f47232ab5 ("mtd: spi-nor: add support for DTR protocol")
>> Cc: stable@vger.kernel.org
>> Reviewd-by: Pratyush Yadav <pratyush@kernel.org>
>> Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
>> ---
>>  drivers/mtd/spi-nor/core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> index f9c189ed7353..c7aceaa8a43f 100644
>> --- a/drivers/mtd/spi-nor/core.c
>> +++ b/drivers/mtd/spi-nor/core.c
>> @@ -89,7 +89,7 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
>>  		op->addr.buswidth = spi_nor_get_protocol_addr_nbits(proto);
>>  
>>  	if (op->dummy.nbytes)
>> -		op->dummy.buswidth = spi_nor_get_protocol_addr_nbits(proto);
>> +		op->dummy.buswidth = spi_nor_get_protocol_data_nbits(proto);
>>  
>>  	if (op->data.nbytes)
>>  		op->data.buswidth = spi_nor_get_protocol_data_nbits(proto);
>>
> 
> I just noticed this commit caused a regression on my i.MX8M Plus based board,
> detected using git bisect.
> DT: arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
> Starting with this patch read is only 1S-1S-1S, before it was
> 1S-1S-4S.
> 
> before:
>> cat /sys/kernel/debug/spi-nor/spi0.0/params
>> name            mt25qu512a
>> id              20 bb 20 10 44 00
>> size            64.0 MiB
>> write size      1
>> page size       256
>> address nbytes  4
>> flags           HAS_SR_TB | 4B_OPCODES | HAS_4BAIT | HAS_LOCK | HAS_4BIT_BP
>> | HAS_SR_BP3_BIT6 | SOFT_RESET
>>
>> opcodes
>>
>>  read           0x6c
>>  
>>   dummy cycles  8
>>  
>>  erase          0xdc
>>  program        0x12
>>  8D extension   none
>>
>> protocols
>>
>>  read           1S-1S-4S
>>  write          1S-1S-1S
>>  register       1S-1S-1S
>>
>> erase commands
>>
>>  21 (4.00 KiB) [1]
>>  dc (64.0 KiB) [3]
>>  c7 (64.0 MiB)
>>
>> sector map
>>
>>  region (in hex)   | erase mask | overlaid
>>  ------------------+------------+----------
>>  00000000-03ffffff |     [   3] | no
> 
> after:
>> cat /sys/kernel/debug/spi-nor/spi0.0/params
>> name            mt25qu512a
>> id              20 bb 20 10 44 00
>> size            64.0 MiB
>> write size      1
>> page size       256
>> address nbytes  4
>> flags           HAS_SR_TB | 4B_OPCODES | HAS_4BAIT | HAS_LOCK | HAS_4BIT_BP
>> | HAS_SR_BP3_BIT6 | SOFT_RESET
>>
>> opcodes
>>
>>  read           0x13
>>  
>>   dummy cycles  0
>>  
>>  erase          0xdc
>>  program        0x12
>>  8D extension   none
>>
>> protocols
>>
>>  read           1S-1S-1S
>>  write          1S-1S-1S
>>  register       1S-1S-1S
>>
>> erase commands
>>
>>  21 (4.00 KiB) [1]
>>  dc (64.0 KiB) [3]
>>  c7 (64.0 MiB)
>>
>> sector map
>>
>>  region (in hex)   | erase mask | overlaid
>>  ------------------+------------+----------
>>  00000000-03ffffff |     [   3] | no
> 
> AFAICT the patch seems sane, so it probably just uncovered another
> problem already lurking somewhere deeper.
> Given the HW similarity I expect imx8mn and imx8mm based platforms to be
> affected as well.
> Reverting this commit make the read to be 1S-1S-4S again.
> Any ideas ow to tackling down this problem?
> 

My guess is that 1S-1S-4S is stripped out in
spi_nor_spimem_adjust_hwcaps(). Maybe the controller has some limitation
in nxp_fspi_supports_op(). Would you add some prints, and check these
chunks of code?

Cheers,
ta

