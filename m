Return-Path: <stable+bounces-9920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 877CC825802
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 17:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0570A1F2162A
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 16:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADC63219F;
	Fri,  5 Jan 2024 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="NB1mN6Ds"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D9131A81
	for <stable@vger.kernel.org>; Fri,  5 Jan 2024 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d8e7a50c1so19363885e9.2
        for <stable@vger.kernel.org>; Fri, 05 Jan 2024 08:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1704471753; x=1705076553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lomhMQTQuknXyilv/6O1Ig9F6eSFk3s039swGnXqBac=;
        b=NB1mN6DskExGrZ/j6pr6BfQkTB0pct+lUNMG8xewEypuxaoDfenelXMLkTYuqKP2YO
         iKSyqP7RxJhgKzh+f8sJatuV0x+juf086CTnN8hExscbZhLrY2kLE3pH5HiAEquNBUXx
         4YMndGXB3RomNooaOKj+NX3wBmAq2dEVtNHK4tnx5SEl+Ogqa/Fs0Q/iXsldOiDUFeOp
         8Q1Rj5d0ULxEnmz76BcM/sNG1jMOhgb8o8F0dU05CixezoI0XJFU8cAnC8JTlrX0Dc3f
         1mWWEKfQcsc4mdcAqBdtD0WyDmGwhEQO/56rasEhcnnuln40BZtoGJiv1H3wI4bQA4hW
         10NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704471753; x=1705076553;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lomhMQTQuknXyilv/6O1Ig9F6eSFk3s039swGnXqBac=;
        b=coU3Pnc+bRzMrKoI9Sq8YxldN7Zdimn/bamNYaICsIH0xg7Pv8DXsVLeBsKBA+hyBj
         BikCloH2d79IpIlHq8+AYhY6XgZlRSHRbYBFa1a9nUPfE40CkdfeP4ufRuxrOeRLcicm
         FFOfB54ee2NrxnJVDC9TE5S3T1/B15ZDKR+bXvic5aqUh3HySRUSUEDBHQwdz1w71Jse
         zU6WwYjS/JDpB6hti/bMK/nHAOuX5PyeNq/3KGtH9FRvsQEjucb0HXX2wTdc3szFm3Ph
         CsenV2Yq1H2zOvjst+Uvsq3cdtudtOFvXVQi66FJvhvVxIB3N6Tti4D12cUBzM1m7T/z
         8vdQ==
X-Gm-Message-State: AOJu0YwF3tfoXDGTFgOQ8hv3mwUxgLWRz1S8639Hw6sHZhdsH/YFoWN9
	wA0hEGunTLs5yQrc8Bw4WthDzX2GPocdUY9RM27tWhO3fAA=
X-Google-Smtp-Source: AGHT+IEgScjy5H+C5xtCpxZ33SYU+9VkmzyQvPVmiUjMUyLQjOmHkjbCAMr0Ip7uj2urEdGH2vNv5g==
X-Received: by 2002:a1c:7404:0:b0:40d:5a9c:f2e8 with SMTP id p4-20020a1c7404000000b0040d5a9cf2e8mr1116114wmc.174.1704471753533;
        Fri, 05 Jan 2024 08:22:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:144d:d8d:d728:b78b? ([2a01:e0a:b41:c160:144d:d8d:d728:b78b])
        by smtp.gmail.com with ESMTPSA id l3-20020a05600c4f0300b0040d8d11bd4esm2026741wmq.36.2024.01.05.08.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 08:22:32 -0800 (PST)
Message-ID: <8f5f1e0b-da1b-4b3e-8e55-33e46556ddc5@6wind.com>
Date: Fri, 5 Jan 2024 17:22:31 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v3 1/2] rtnetlink: allow to set iface down before
 enslaving it
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Phil Sutter <phil@nwl.cc>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 stable@vger.kernel.org
References: <20240104164300.3870209-1-nicolas.dichtel@6wind.com>
 <20240104164300.3870209-2-nicolas.dichtel@6wind.com>
 <ZZfvHEIGiL5OvWHk@nanopsycho>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <ZZfvHEIGiL5OvWHk@nanopsycho>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 05/01/2024 à 12:59, Jiri Pirko a écrit :
> Thu, Jan 04, 2024 at 05:42:59PM CET, nicolas.dichtel@6wind.com wrote:
>> The below commit adds support for:
>>> ip link set dummy0 down
>>> ip link set dummy0 master bond0 up
>>
>> but breaks the opposite:
>>> ip link set dummy0 up
>>> ip link set dummy0 master bond0 down
> 
> It is a bit weird to see these 2 and assume some ordering.
> The first one assumes:
> dummy0 master bond 0, dummy0 up
> The second one assumes:
> dummy0 down, dummy0 master bond 0
> But why?
> 
> What is the practival reason for a4abfa627c38 existence? I mean,
> bond/team bring up the device themselfs when needed. Phil?
> Wouldn't simple revert do better job here?
Yeah, I assumed there was a good reason, but you're right.


> 
> 
>>
>> Let's add a workaround to have both commands working.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: a4abfa627c38 ("net: rtnetlink: Enslave device before bringing it up")
>> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>> Acked-by: Phil Sutter <phil@nwl.cc>
>> Reviewed-by: David Ahern <dsahern@kernel.org>
>> ---
>> net/core/rtnetlink.c | 8 ++++++++
>> 1 file changed, 8 insertions(+)
>>
>> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
>> index e8431c6c8490..dd79693c2d91 100644
>> --- a/net/core/rtnetlink.c
>> +++ b/net/core/rtnetlink.c
>> @@ -2905,6 +2905,14 @@ static int do_setlink(const struct sk_buff *skb,
>> 		call_netdevice_notifiers(NETDEV_CHANGEADDR, dev);
>> 	}
>>
>> +	/* Backward compat: enable to set interface down before enslaving it */
>> +	if (!(ifm->ifi_flags & IFF_UP) && ifm->ifi_change & IFF_UP) {
>> +		err = dev_change_flags(dev, rtnl_dev_combine_flags(dev, ifm),
>> +				       extack);
>> +		if (err < 0)
>> +			goto errout;
>> +	}
>> +
>> 	if (tb[IFLA_MASTER]) {
>> 		err = do_set_master(dev, nla_get_u32(tb[IFLA_MASTER]), extack);
>> 		if (err)
>> -- 
>> 2.39.2
>>
>>

