Return-Path: <stable+bounces-58239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9215A92A8CD
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 20:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19EB9B206B1
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 18:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5D0148FFC;
	Mon,  8 Jul 2024 18:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="HfiC+3et"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA371487DF
	for <stable@vger.kernel.org>; Mon,  8 Jul 2024 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462441; cv=none; b=aYx6PqYhxAdWRa3ICKoj00BCqrplTUaRJ5/0nOJT4SYI+4zjXTIQ/zaqYtTbsir+dGHmP6OpK6SelLy+lphRKNMlkHOoCIWrdmQEUzJ3sLtD4VEwj21XjI8D+aEdq4q+xmuPSnCoO/GBdrR/Vd37fyI7yU7l9j/GOVeB6A6rdp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462441; c=relaxed/simple;
	bh=jgPebNvvX3FxarOjrw+5rKXFP+1d9Igz+VIjr2w2P+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U0B9YRX2EPIRY/NpK3vVUgmF07e4IB4X9UPwXQkdOWdtMUleYqcv9ZxgxWc8ozuYZoGr822Qz81u0G9d80eFTKmphf4Au5YX0z4kcByiJqxoi5KYkGb3YPG06jo4AedWVexdOX8u6t8iKApbBOWyUvdmgye9ikS9kqwuwsAlHu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=HfiC+3et; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52e9a920e73so5288719e87.2
        for <stable@vger.kernel.org>; Mon, 08 Jul 2024 11:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1720462438; x=1721067238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NWzY5ZjITE8LLFoL5yewVVaedS7DmmcoMkckgpz+zWw=;
        b=HfiC+3etLdNvqpJdI3X+qNggUHsa/fbjnqHVT7FcKLBxNk08yui4Ezbs2xSbLecYjf
         MlyZG6+DONLe9cy5+3Y/fKsIq9OBksuyZr7WbZmM4+eWDY0z2LAP1XZpIIcBAbwvw2co
         nz+CgfHrw1Z/FiEn8vbfOsXEl5gA5PG6cnNvKY52i3nzOJJBaE7OdilS18JijFdEpgXi
         CU9W8rualcsQruwi6o9DUt18rft9rkG35MWLa6rY78L+FSaA1ppMt2PD/rcXb0a6oO/r
         L6Fe3xMBYnkAN4yVmnGaGgWY4pCu6erl+f8tTiKM1bCl2pc0KJ+/U2w3AXSY+VyR4KPN
         Bv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720462438; x=1721067238;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NWzY5ZjITE8LLFoL5yewVVaedS7DmmcoMkckgpz+zWw=;
        b=GtXYi4CRQtYGtUkte25D3FIHHE1eHmWQ+yRQ7RgOj2QSspRb2QxO/y0dMJ/l44Fmns
         Cco2V2mwYoZez7iFr7hKPp0O2zmi6T93oLcRtSsYPgV8IjUMaOGdCMTrjAGzEEPRCULF
         7SuXVyoCJD33iGJ0Gm3TeLpqxd3xeTN6xQYtCT7ShNGpTrnXsaAFYRxYYy8g7hQ+J2jN
         IT1by+/K111FvWEnYOwoMJAnWAygld19kf5+nTrXSr0o7sraCfTSNnyr3o1GDZTACVzb
         +M9pRg5RyRFhcBp4Xd2gs3PiQNFBxUWJwB+iSeKcqUz8vB+zb6NE2ccFtO+CBpuXY1vv
         Lzhg==
X-Forwarded-Encrypted: i=1; AJvYcCU5s/SDe3wwx7Aa+xwmhN8yEbvDaKFqxN6P0R2ftC+NKqSnqsPYOFCBoxOMha/W6Uvio4xya9+0WMlVf9/MmrniFq6Easek
X-Gm-Message-State: AOJu0YyK3aJzoC+HL4gMIc4m7XrlJLQ3cf4807r7bNzlf6efpp3t3mDT
	V1YyAvUVJUz3/aGwnn9RfZY93YZMMmFzRKKFtsYwIzd+XmpL86z45VLQEnv3kWvPNAdXrwLz49w
	p
X-Google-Smtp-Source: AGHT+IHI31cTol44vJq4n2ULd5AaGqhpPhjJeZtJ0yU+Zvsigsbmcc0ZdpVoPBYXNrr6pQIifYti7A==
X-Received: by 2002:a05:6512:b9e:b0:52e:9dee:a6f5 with SMTP id 2adb3069b0e04-52eb99cc67fmr99178e87.46.1720462437839;
        Mon, 08 Jul 2024 11:13:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:f03c:44cd:8f8d:23c? ([2a01:e0a:b41:c160:f03c:44cd:8f8d:23c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfb2327sm399564f8f.116.2024.07.08.11.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 11:13:57 -0700 (PDT)
Message-ID: <cc29ed8c-f0b2-4e6d-8347-21bb13d0bbbc@6wind.com>
Date: Mon, 8 Jul 2024 20:13:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v2 1/4] ipv4: fix source address selection with route
 leak
To: David Ahern <dsahern@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
References: <20240705145302.1717632-1-nicolas.dichtel@6wind.com>
 <20240705145302.1717632-2-nicolas.dichtel@6wind.com>
 <339873c4-1c6c-4d9c-873c-75a007d4b162@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <339873c4-1c6c-4d9c-873c-75a007d4b162@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 07/07/2024 à 18:58, David Ahern a écrit :
> On 7/5/24 8:52 AM, Nicolas Dichtel wrote:
>> By default, an address assigned to the output interface is selected when
>> the source address is not specified. This is problematic when a route,
>> configured in a vrf, uses an interface from another vrf (aka route leak).
>> The original vrf does not own the selected source address.
>>
>> Let's add a check against the output interface and call the appropriate
>> function to select the source address.
>>
>> CC: stable@vger.kernel.org
>> Fixes: 8cbb512c923d ("net: Add source address lookup op for VRF")
>> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>> ---
>>  net/ipv4/fib_semantics.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
>> index f669da98d11d..459082f4936d 100644
>> --- a/net/ipv4/fib_semantics.c
>> +++ b/net/ipv4/fib_semantics.c
>> @@ -2270,6 +2270,13 @@ void fib_select_path(struct net *net, struct fib_result *res,
>>  		fib_select_default(fl4, res);
>>  
>>  check_saddr:
>> -	if (!fl4->saddr)
>> -		fl4->saddr = fib_result_prefsrc(net, res);
>> +	if (!fl4->saddr) {
>> +		struct net_device *l3mdev = dev_get_by_index_rcu(net, fl4->flowi4_l3mdev);
> 
> long line length. separate setting the value:
> 
> 		struct net_device *l3mdev;
> 
> 		l3mdev = dev_get_by_index_rcu(net, fl4->flowi4_l3mdev);
The checkpatch limit is 100-column.
If the 80-column limit needs to be enforced in net/, maybe a special case should
be added in checkpatch.


Regards,
Nicolas

