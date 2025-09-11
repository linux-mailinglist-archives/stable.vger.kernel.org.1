Return-Path: <stable+bounces-179244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A81BB52BBD
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 10:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 843C87BEFB4
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 08:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D06E2E2852;
	Thu, 11 Sep 2025 08:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3Zijs6w"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DCC2E1757
	for <stable@vger.kernel.org>; Thu, 11 Sep 2025 08:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757579637; cv=none; b=t19B85HQU83oAusVkMiMS74SkyD19hl3lsESmLPTSLCJxJE0aW7i63hNNNwVK4VzLfQ0i0VSMn6jn7PTXepyNnabJQ/pBuyBCMr15dKVVpmUKX8iPBJFz9LDxcnB5eWsAzVAGZefUGF15V16Ox9ZIOd4/gawr/c1AU4qIfPOu4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757579637; c=relaxed/simple;
	bh=+A7fGShDNqqdZy6HpWVWV21HOJoZgYaeTiuzKGQtkck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cAIGHs7LHsueehN2vualCYyMnpaeTYp245uRjufvc2djuoHdn5TENvAsBRM1Ga6VGc0VbfOk0Uf0mX6DLnOAKFc5Nhv/BL/KGVGqayW6yxhOFQmsS1ahyNIS+QyoCCJtanxC40RS4FglEo4hh8RnGDD+mzriHdgvdFWJGKrq8p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3Zijs6w; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b0411b83aafso63546966b.1
        for <stable@vger.kernel.org>; Thu, 11 Sep 2025 01:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757579634; x=1758184434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jXNsoVwloZuRCuyn1AI31nY1y36rlJK9l0CGgUq9a2g=;
        b=Q3Zijs6wo2/T+bD6O+WAX1T8gPIWa7AvALIrEI03pacCGBiV4FpmRSJ7ilEgdZar3/
         lEPthYDD+LnjFRPz+jnqEDpQ311iUIqBZdOsPr+1FutAoYsKQXJ21Q9mmwJ/QxesuIaY
         EYvvStHr6dwFAAupCMKn1k42xZCySKcYYJCqSLzEdsqhkjjmfQYl4uhIdYvQGN+Mkh02
         u17Scs0GHbJMZfg9H67Gvr4+GBOYpxf7u/Dnwl2qAD07Fc+rA2q7GLwqik4Fb7VdMzcC
         KQQR4JJoFluZE63gw7Z1QLg1AG9veZQ3rbb6hsU8lc5e/jLdr6feiS27OKG3xVF/OMoc
         gJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757579634; x=1758184434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jXNsoVwloZuRCuyn1AI31nY1y36rlJK9l0CGgUq9a2g=;
        b=aLHzzih0P56nP9cFqHXzjK3frAar0bxg3GHO11lwOjoKSTz7fXOU8vp6kQk/35/X8z
         b3QuXTp2IOIJcPT5M90BymTN9Z73XjCBAz4JNSn/Je2u0VymYiZETB2Ju4475KMcy4Aa
         BtiVlZKChnePQWWSTUnWj+MShgNYQEWziKavzhZU/Qb2XStYrlu6dGwUI/Too4y/8XnR
         Woxr2YwtuoBxhuXfGO5hVsCYG45ul7/iLDA9wPTpFGFeqhUUHZHtPwpB3lOo3iP/QF5Z
         t6L66b8Tagj9Ne7L7kDRFb9wM6PPYFI0rlWd0OILUFz8w55QcpbFtM1K7HOUadcFaKeO
         9UrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6MaLnnivlIetA7SgroyX7ygedaeHPGydFtiT6SVyuFX/uWA7K8q0D6+2W5EvKR28j4honLp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiinE3ioyQ+2fmqcEJfoC8TRrhkmHvi5KC7YXd6MmSvsjt9Zzh
	u05gCq1j/mucNA/1nZOUHwrJI0inAubP0ysi5ulY/LM8SkQkm4EEuldg
X-Gm-Gg: ASbGncvzMGY/8OfqFCZEr0nuiYtVKVLSzMO9FxmiFmXhI63gDoVduhTku79P7rGs6bf
	kL69T+mTbyqiNP1u3djPIN8fRYg6WltS90uCzfz/NDC3eAc29SrPOwvd33YK6X5lIuTNWAHcsK0
	D6Pua5YVTvDExvZzRhPYtakgr8vBr9+U2/HgsIyRGRx1l5Ot7Q/k6K/jYGWwbxOeJpIqzp98kJY
	9fQjqSUd2eHNudalIIAqv24Pkpte/F3yn3hu/2Y/QThA8AK3RI1Ys9ov76yEOwQ5M9m3uKzUoXe
	mqcqTFGP5xIgHZ0KBfYHDhsjeXZnNYhu4fmPxMRqsqPO15HzU+ttKdCP6X3aXbEElnTpkDe4ZdG
	rDsulDAvg9KdCPOB+UB3XPFnu4VjX8cxnGVYkdLnmMmYmRhwbemPg2YrAXF5x71k=
X-Google-Smtp-Source: AGHT+IHUYAyMQxWcpnLNiuq6zNTJE+tEXDXpQeiPVv3fwWkOG53PV0tw2n6UBH0oKTKseQSWUZISug==
X-Received: by 2002:a17:907:3f18:b0:b04:7f7e:6d5e with SMTP id a640c23a62f3a-b04b1445bfbmr1497718566b.15.1757579633372;
        Thu, 11 Sep 2025 01:33:53 -0700 (PDT)
Received: from [192.168.20.170] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd5b4sm84832366b.70.2025.09.11.01.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 01:33:52 -0700 (PDT)
Message-ID: <a208824c-acf6-4a48-8fde-f9926a6e4db5@gmail.com>
Date: Thu, 11 Sep 2025 10:33:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: core: always verify OOB offset in
 mtd_check_oob_ops()
To: Miquel Raynal <miquel.raynal@bootlin.com>, Santhosh Kumar K <s-k6@ti.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Daniel Golle <daniel@makrotopia.org>
References: <20250901-mtd-validate-ooboffs-v2-1-c1df86a16743@gmail.com>
 <175708415877.334139.11409801733118104229.b4-ty@bootlin.com>
 <454e092d-5b75-4758-a0e9-dfbb7bf271d7@ti.com> <87348tbeqg.fsf@bootlin.com>
Content-Language: hu
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <87348tbeqg.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Miquel, Santhosh,

2025. 09. 11. 10:00 keltezéssel, Miquel Raynal írta:
> Hello,
> 
> On 11/09/2025 at 11:52:27 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:
> 
>> Hello,
>>
>> On 05/09/25 20:25, Miquel Raynal wrote:
>>> On Mon, 01 Sep 2025 16:24:35 +0200, Gabor Juhos wrote:
>>>> Using an OOB offset past end of the available OOB data is invalid,
>>>> irregardless of whether the 'ooblen' is set in the ops or not. Move
>>>> the relevant check out from the if statement to always verify that.
>>>>
>>>> The 'oobtest' module executes four tests to verify how reading/writing
>>>> OOB data past end of the devices is handled. It expects errors in case
>>>> of these tests, but this expectation fails in the last two tests on
>>>> MTD devices, which have no OOB bytes available.
>>>>
>>>> [...]
>>> Applied to mtd/next, thanks!
>>> [1/1] mtd: core: always verify OOB offset in mtd_check_oob_ops()
>>>        commit: bf7d0543b2602be5cb450d8ec5a8710787806f88
>>
>> I'm seeing a failure in SPI NOR flashes due to this patch:
>> (Tested on AM62x SK with S28HS512T OSPI NOR flash)

Sorry for the inconvenience.

> Gabor, can you check what happens with mtdblock?

The strange thing is that it works with (SPI) NAND flashes:

# cat /sys/class/mtd/mtd0/type
nand
# cat /sys/class/mtd/mtd0/oobavail
0
#
# hexdump -n 2048 /dev/mtd0
0000000 0f0f 0f0f 0f0f 0f0f 0f0f 0f0f 0f0f 0f0f
*
0000800
#

I will check why it fails with NOR devices.

> Otherwise this will need to be reverted.

Please drop the patch for now, or revert it if dropping not possible.

Either I will send a fixed version, or we will have to live without the change.


Regards,
Gabor

