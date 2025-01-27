Return-Path: <stable+bounces-110892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8C1A1DC29
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 19:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4BA163ADE
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 18:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4C018F2EF;
	Mon, 27 Jan 2025 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8TtL0yu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF76322619;
	Mon, 27 Jan 2025 18:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738003188; cv=none; b=jw5LhONPUnGeXMqnHI+5EHu5/im7ab8R4wVaIBEixy3D/DmvRJ1cqfWaGV5EoqVCHYWzJHSRQ7+rE/CvzsVA4YUOFJRXu9gCdYhVfAInNDZ1qiOMYGcXeTHGG6e5wv4eW9/T6G+Q7hV+KDWvr3Vu8g9hbmmxv/c8OYBCxF89s8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738003188; c=relaxed/simple;
	bh=qD204A3m62q8csP4Voci0FEHSe0jPBEPZ72jWYlHUFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+9HeyPMHgAIG51MZnBfRKqPJCZ/Meg6mBipQbRGweI2CS+7LyccnKCD3nw9BnY9/Av3ebOLiZ8UujtZfwySHcfzuykmnjCr0fGduH997vYNPkB9hCvVIS2EFsEB7np63p026mD79ivitUc0ISXYasY2daa2tUjPphlO85Nq2uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8TtL0yu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2163b0c09afso87428705ad.0;
        Mon, 27 Jan 2025 10:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738003186; x=1738607986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7xZfgq6sVuvos6ONTJEQGslC4Uzw06+5cwcQD5EqUfU=;
        b=d8TtL0yuIiHoIffEdrTxKR4ZCk2ZwQJZ5ny4ll7bmu74T1rzRWviqOVxKKMzpCio8c
         csBUUamiZBSKpdhRBkFCBpA+K7DTiKpw98s2++60OHc3QvMgPQtqZf8bm6bsDF2Ccwe7
         UroQTVq+pCnRSTERIs4437QN7tkL4cwBEZiEG+muIxruvcgovsvIycpcbPIjLK1ByhT6
         /6qbI1+YlL0mpZOzx6T4g5AvcaFyQx1R0WJeMcLNjeDg3LVBcYBS6utfdCJOPeMPxFQX
         oPnrZSdoXC1tPDwl3q2FrfVhtUPQ/XS5loYdN0ZFkahu80G94MDoEsgh6VSNVMApls7j
         2nVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738003186; x=1738607986;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xZfgq6sVuvos6ONTJEQGslC4Uzw06+5cwcQD5EqUfU=;
        b=pb1fwPr8QajFkBT7hto2QcxQ39mycUEpWrea+Q1k8akFeFk8vsAL8YtSxEDY0hSMH9
         qtifiT78A1j9NXcyeFsWz0WbYIatRxN0BVN7GtSgfBsc94IqRcUXrMN7aofU3YVv9uBQ
         xpDKuvMMSjSBbwj0xmT3NR/C8gpC/76ZEUkPcb9mUkPK3oqOLDL01Daal/bgzrCZgQtx
         1d/mi7+7OAU+WuB277XsVWmJmSN3jEFt8vPGZNswV/8aBRiYM96dF4vOb80Ip6UTe7xa
         Fd1Tg+Q/ypENzEntMGvvfqsosrFkOCed6b++DebIVSkH99O8sFCJiCUoX7dlXobZGcsz
         V/Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVLqNKVsQNfhu1pp45X6wJu8raRLtHFwR9zdQ/jaN3nseyoFZ3m0mnwoVXL+WLUJshWgeYgBSeXuNagrDob@vger.kernel.org, AJvYcCW9gVURv8DjhsZ2ue2KBNQ1RkZEMClZFDvMV4RHAlUXVmUPpHb278ycmN3b4599xAi7psTB7zVLlo00ig==@vger.kernel.org, AJvYcCWnpaSpwuPNgnuu9Z9SE5H/EwrU9AJ5L7U+JoUY1OICP9owRY+wAH75HOBIEJjy2SV93sLMT1tM@vger.kernel.org
X-Gm-Message-State: AOJu0Yysc66b5sblXyrIF+XTImTp1iWcfPKJC+91UuD4O0Uj88O6T1oE
	HVztN1PmG7Hv6mwII23l0BtWlAZ4gy0BjTzKoVeoy90DTSK6XYURDT2bow==
X-Gm-Gg: ASbGncvjBPaxlpPyazAcIQlYloPgztGz68j1Q8mNDd/uQCFt4tu/VDoCB6+ZGOfov3g
	nbiUMpSzBBRU0kFlBZBLEJKmxPakkRAasnIyUNVOHP29yFkKv2DOkQlagP1YBojR4aQwt3aID2h
	kGWMQlzUwxWtb2FWYFv+Tt6DcINqUFb9+l8uLWRseSjwajYvt1eAIjLIrIb9smEYhS3YIRTLQlB
	SVWkRMH1KjXlTVTE7YaL0Tw/trPPCG9W+78ou34JugytisgRoS4U+yHcIOPvc6g73HjdkLClRjj
	BKdqbkYLk5C0F7+KnEq8kGtE+22InWxYIpYnZvSH+Q1Jdqxz8hIMFA==
X-Google-Smtp-Source: AGHT+IFdz6LtDnVNY82Sug5rXeXslgqCogK7/oZyq+qUG5W6OGwDNUkMwQbT7tFAwMRigBfXQ9909Q==
X-Received: by 2002:a17:903:22cb:b0:21b:d105:26a5 with SMTP id d9443c01a7336-21c355becd3mr692005635ad.38.1738003186130;
        Mon, 27 Jan 2025 10:39:46 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3d9c605sm66702275ad.41.2025.01.27.10.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 10:39:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1dc793cd-d11d-441a-a734-465eb4872b2a@roeck-us.net>
Date: Mon, 27 Jan 2025 10:39:44 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (peci/dimmtemp) Do not provide fake thresholds
 data
To: Paul Fertser <fercerpav@gmail.com>
Cc: "Winiarska, Iwona" <iwona.winiarska@intel.com>,
 "jae.hyun.yoo@linux.intel.com" <jae.hyun.yoo@linux.intel.com>,
 "Rudolph, Patrick" <patrick.rudolph@9elements.com>,
 "pierre-louis.bossart@linux.dev" <pierre-louis.bossart@linux.dev>,
 "Solanki, Naresh" <naresh.solanki@9elements.com>,
 "jdelvare@suse.com" <jdelvare@suse.com>,
 "fr0st61te@gmail.com" <fr0st61te@gmail.com>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
 "joel@jms.id.au" <joel@jms.id.au>
References: <20250123122003.6010-1-fercerpav@gmail.com>
 <71b63aa1646af4ae30b59f6d70f3daaeb983b6f8.camel@intel.com>
 <7ee2f237-2c41-4857-838b-12152bc226a9@roeck-us.net>
 <Z5fQqxmlr09M8wr8@home.paul.comp>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <Z5fQqxmlr09M8wr8@home.paul.comp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/27/25 10:30, Paul Fertser wrote:
> Hi Guenter,
> 
> On Mon, Jan 27, 2025 at 09:29:39AM -0800, Guenter Roeck wrote:
>> On 1/27/25 08:40, Winiarska, Iwona wrote:
>>> On Thu, 2025-01-23 at 15:20 +0300, Paul Fertser wrote:
>>>> When an Icelake or Sapphire Rapids CPU isn't providing the maximum and
>>>> critical thresholds for particular DIMM the driver should return an
>>>> error to the userspace instead of giving it stale (best case) or wrong
>>>> (the structure contains all zeros after kzalloc() call) data.
>>>>
>>>> The issue can be reproduced by binding the peci driver while the host is
>>>> fully booted and idle, this makes PECI interaction unreliable enough.
>>>>
>>>> Fixes: 73bc1b885dae ("hwmon: peci: Add dimmtemp driver")
>>>> Fixes: 621995b6d795 ("hwmon: (peci/dimmtemp) Add Sapphire Rapids support")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Paul Fertser <fercerpav@gmail.com>
>>>
>>> Hi!
>>>
>>> Thank you for the patch.
>>> Did you have a chance to test it with OpenBMC dbus-sensors?
>>> In general, the change looks okay to me, but since it modifies the behavior
>>> (applications will need to handle this, and returning an error will happen more
>>> often) we need to confirm that it does not cause any regressions for userspace.
>>>
>>
>> I would also like to understand if the error is temporary or permanent.
>> If it is permanent, the attributes should not be created in the first
>> place. It does not make sense to have limit attributes which always report
>> -ENODATA.
> 
> The error is temporary. The underlying reason is that when host CPUs
> go to deep enough idle sleep state (probably C6) they stop responding
> to PECI requests from BMC. Once something starts running the CPU
> leaves C6 and starts responding and all the temperature data
> (including the thresholds) becomes available again.
> 

Thanks.

Next question: Is there evidence that the thresholds change while the CPU
is in a deep sleep state (or, in other words, that they are indeed stale) ?
Because if not it would be (much) better to only report -ENODATA if the
thresholds are uninitialized, and it would be even better than that if the
limits are read during initialization (and not updated at all) if they do
not change dynamically.

Guenter


