Return-Path: <stable+bounces-58240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D51F892A8D3
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 20:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91981F22273
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 18:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF0014900B;
	Mon,  8 Jul 2024 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Jyrcd/L2"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB79514A619
	for <stable@vger.kernel.org>; Mon,  8 Jul 2024 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462510; cv=none; b=LFf4K7I9mTzBEd9F3zmYqLGybkI5Tdy2By+HKnNIY7lyIcA9n0soD1FsEO6TEtKdQ6soIctlPHi1pZUf1TV1uR+ijsqJPLX3pRHgYeM05UuiDXst04A3HK8E1pHJe8yXQcJKROL01v0mVHFl721wHL+HE+TjXSaYjQ+Kqm3FA4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462510; c=relaxed/simple;
	bh=JbmYYJSvqhViRVzIx4K5YGWEU8GuuzB8tWKxdU5508w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibg4DBGBsPt1cWM3KDTKcSRfkJaw+RwGLnz0lqeT1zEo3nY1JLL5gdserLms1nIU4LRcOTZ78DLkWAOPCzUa8WBR2UXr+hVSCLxN/ILmqwhgPz7xGGGM8kWHbxPgLnhInEDs1nMIyCrdZfGXMmEpgPgUQsKhoSN9IuI0B2CnKvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Jyrcd/L2; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so7160191fa.2
        for <stable@vger.kernel.org>; Mon, 08 Jul 2024 11:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1720462507; x=1721067307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TGUQI4/4DcjCZH9utAokt3+b2pLoBeJNGqzMWE1DmXk=;
        b=Jyrcd/L20FPLZA6+/mBsQ/SYtT3ams074HDOlS9sWkak11RznSnISSQ2q9n5emkgqe
         /YDW4wL8UQ+84rvoKmU77vAedIKRGR8lw3BkHnvShNpjiFQjUENTHR+0m59D2qFdqBzr
         ULHVYUeCfVQ5EFjAr6wZWla2xZ5tMbp52I/R99eWXJQtU10kTNGfveS1L+y4VoyCo58N
         Pv8gxlvoAalA7++bVpUD00z9NSakf1Zqe0ve5Alm3BnFPVHzfap9gvmyMZ9ADzU/bY7V
         xtunExy4KR/dxvkbwiBsLjThW9td4yu8ItdlP5t/zOGwN1OOCQVt+eQsjGO8pXDuGE1S
         PWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720462507; x=1721067307;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGUQI4/4DcjCZH9utAokt3+b2pLoBeJNGqzMWE1DmXk=;
        b=ZoJrPSBNlRlxAGlMXdVohETbB9fjDpJZJbNcFZ4zeY9bnf+5i6TM/q8GS2hAi5nw8y
         7mAr1IFKlAjNvroHk9TkqTIVC70uRXLz2ERFrcW7oIScPCM5FmEm0yrANUW10N17AA2L
         pC/zPW04yK+QZ+lfiQbuFNOCejviegk7qOImn9gXNjce3O/rDPA9bWa75qz8g8IWgU+G
         CFq+ASA4dYTTVFE2vFHoO8aWjvtLLwGokgUJbuF1ousZ6JaTBU9RqOoAtbZUpst8ccXC
         oJ4NyrXZ9FUmiIUnkAnRYkwlDpgyikD2pJEfE/bgLeecy7zsYMFnksjzTwJWqBGRJ5Sf
         ICaA==
X-Forwarded-Encrypted: i=1; AJvYcCU374FoQS8QoAnaABNsHFHr8iSVTs/y8uw8B4fxRedCi+nO8/OTnB9JN1wcSqbeDwgK3qLjMWhJ2a5/O/nfh0HHYuCupYAr
X-Gm-Message-State: AOJu0YzuD2Ev753WBBV4cbAX8M3RACbwRWAenZOHPeZmXFEZRMQrWVmg
	c80kCp3yOWsvwAhhI9tH7F40kX9yW8KYBfK71e/SMpWjXWI/TgBH80zqUQK3YsU=
X-Google-Smtp-Source: AGHT+IFXM+0acYNWm3lR/O9kcynvIrBbhLvz33mMD2fL1P3DSzRZj5k/M5es6jBhOsbokuIqddq+Dw==
X-Received: by 2002:a2e:8558:0:b0:2ee:4e67:85e9 with SMTP id 38308e7fff4ca-2eeb31986b4mr2622431fa.47.1720462507072;
        Mon, 08 Jul 2024 11:15:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:f03c:44cd:8f8d:23c? ([2a01:e0a:b41:c160:f03c:44cd:8f8d:23c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f74159csm7297875e9.42.2024.07.08.11.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 11:15:06 -0700 (PDT)
Message-ID: <10327c0a-acf8-4aa5-a994-3049a7cb5abd@6wind.com>
Date: Mon, 8 Jul 2024 20:15:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v2 2/4] ipv6: fix source address selection with route
 leak
To: David Ahern <dsahern@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
References: <20240705145302.1717632-1-nicolas.dichtel@6wind.com>
 <20240705145302.1717632-3-nicolas.dichtel@6wind.com>
 <35638894-254f-4e30-98ee-5a3d6886d87a@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <35638894-254f-4e30-98ee-5a3d6886d87a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 07/07/2024 à 18:58, David Ahern a écrit :
> On 7/5/24 8:52 AM, Nicolas Dichtel wrote:
>> diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
>> index a18ed24fed94..a7c27f0c6bce 100644
>> --- a/include/net/ip6_route.h
>> +++ b/include/net/ip6_route.h
>> @@ -127,18 +127,23 @@ void rt6_age_exceptions(struct fib6_info *f6i, struct fib6_gc_args *gc_args,
>>  
>>  static inline int ip6_route_get_saddr(struct net *net, struct fib6_info *f6i,
>>  				      const struct in6_addr *daddr,
>> -				      unsigned int prefs,
>> +				      unsigned int prefs, int l3mdev_index,
>>  				      struct in6_addr *saddr)
>>  {
>> +	struct net_device *l3mdev;
>> +	struct net_device *dev;
>> +	bool same_vrf;
>>  	int err = 0;
>>  
>> -	if (f6i && f6i->fib6_prefsrc.plen) {
>> +	rcu_read_lock();
>> +	l3mdev = dev_get_by_index_rcu(net, l3mdev_index);
>> +	dev = f6i ? fib6_info_nh_dev(f6i) : NULL;
>> +	same_vrf = l3mdev == NULL || l3mdev_master_dev_rcu(dev) == l3mdev;
> 
> !l3mdev; checkpatch should complain
No. I was unaware of this preference, is there a rule written somewhere about this?

$ git grep '(![a-zA-Z])' net/ipv6/ | wc -l
43
$ git grep '== NULL' net/ipv6/ | wc -l
44

It seems both are used.


Regards,
Nicolas

