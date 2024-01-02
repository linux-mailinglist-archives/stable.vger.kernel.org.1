Return-Path: <stable+bounces-9179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23112821B73
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 13:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73111282F88
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 12:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E043AEAED;
	Tue,  2 Jan 2024 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="fImfiL01"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEF6F9CF
	for <stable@vger.kernel.org>; Tue,  2 Jan 2024 12:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-336788cb261so8472258f8f.3
        for <stable@vger.kernel.org>; Tue, 02 Jan 2024 04:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1704197663; x=1704802463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSLIIdVObXyVwnR590fH1wylxU49PILdHE+HMzdEH/4=;
        b=fImfiL010+lY2K2Fxa0kQcE5pWYIgrX6ALYOMgV5c6rpsaOoeMrRBocHmGJUowzE91
         xccN5/uOpaKHYDFY9hVigiTvLIrD2UyaxfejCM234iYzmnrmuv2zmSrf/21EDyL9knXv
         lPSMgFouEZzQ3F6WshMFCb3PNi8gXrziEK68yuTNxBHJrJedUJbtGHqgYj2a1bNh5RTz
         iP5m7dxt3XPyVjO7NRmdqbEjenzxO9kFz3hx1U3qlyC4r9ESbCYcnyx3INbXUaxbdGup
         cOnbH18W46FhuWX16AoksWemdhh54k36cryjxuCVBt+G46WnbnwVwBwSvwB7jBORX/SZ
         2cFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704197663; x=1704802463;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hSLIIdVObXyVwnR590fH1wylxU49PILdHE+HMzdEH/4=;
        b=ikVTbVWMclMRKr6yJDWg0Sl+yAxPYgZ6USaFTZmhj+KIC5BuDX/7TenkuzKeKrn7hy
         0PuVxEGRsSqGrSfIGsScMNpkJud34DxgMnF9aFD88+Yd2x4KvTVyUXyGJEzrgwwClJU2
         D4f/TOU+Ps6xHkwoM/Uhv6WsvmpIwWa8KM5pYL+j6+dV3iyHP/gcfskg715hf+wzjngK
         W/JJp4FJnZwemLLhpSA3KETxeIsG3rcbiUpxbc79INF9IIb8Q2KYah+C17v/pEBusm2x
         n7KFFtaJTjXIIdpJr/hp+k+ZOoznOnCQIFeqDVqwpPd7e40osMPfMXN1he0wl9xBt5TU
         1Thg==
X-Gm-Message-State: AOJu0Yw8VzY/DCD1Wi+ChdCbDC7R76la+6PjjYT1FlOXn9jybdJxpnGz
	T87sYueeQO7gSW0rqXzkwoVIm4rwCW6hGA==
X-Google-Smtp-Source: AGHT+IGd0wZvlbAugiY9MsTbS6QyHp89fdVRt/H5p6o1N9yplwlOmpKCy46WyxWgLWNpq0Nl3bwvEA==
X-Received: by 2002:a5d:46c2:0:b0:333:2f23:8708 with SMTP id g2-20020a5d46c2000000b003332f238708mr8115037wrs.29.1704197663128;
        Tue, 02 Jan 2024 04:14:23 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:2900:c6f1:e9ae:67a6? ([2a01:e0a:b41:c160:2900:c6f1:e9ae:67a6])
        by smtp.gmail.com with ESMTPSA id cg13-20020a5d5ccd000000b00336e6014263sm16874405wrb.98.2024.01.02.04.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 04:14:22 -0800 (PST)
Message-ID: <a5282f4c-21e5-4c1e-b0bb-10f222453099@6wind.com>
Date: Tue, 2 Jan 2024 13:14:21 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net] rtnetlink: allow to set iface down before enslaving
 it
To: Phil Sutter <phil@nwl.cc>, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, stable@vger.kernel.org
References: <20231229100835.3996906-1-nicolas.dichtel@6wind.com>
 <ZZM4Pa3KuD0uaTkx@orbyte.nwl.cc>
Content-Language: en-US
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <ZZM4Pa3KuD0uaTkx@orbyte.nwl.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 01/01/2024 à 23:10, Phil Sutter a écrit :
> On Fri, Dec 29, 2023 at 11:08:35AM +0100, Nicolas Dichtel wrote:
>> The below commit adds support for:
>>> ip link set dummy0 down
>>> ip link set dummy0 master bond0 up
>>
>> but breaks the opposite:
>>> ip link set dummy0 up
>>> ip link set dummy0 master bond0 down
>>
>> Let's add a workaround to have both commands working.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: a4abfa627c38 ("net: rtnetlink: Enslave device before bringing it up")
>> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>> ---
>>  net/core/rtnetlink.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
>> index e8431c6c8490..dd79693c2d91 100644
>> --- a/net/core/rtnetlink.c
>> +++ b/net/core/rtnetlink.c
>> @@ -2905,6 +2905,14 @@ static int do_setlink(const struct sk_buff *skb,
>>  		call_netdevice_notifiers(NETDEV_CHANGEADDR, dev);
>>  	}
>>  
>> +	/* Backward compat: enable to set interface down before enslaving it */
>> +	if (!(ifm->ifi_flags & IFF_UP) && ifm->ifi_change & IFF_UP) {
>> +		err = dev_change_flags(dev, rtnl_dev_combine_flags(dev, ifm),
>> +				       extack);
>> +		if (err < 0)
>> +			goto errout;
>> +	}
>> +
>>  	if (tb[IFLA_MASTER]) {
>>  		err = do_set_master(dev, nla_get_u32(tb[IFLA_MASTER]), extack);
>>  		if (err)
> 
> Doesn't this merely revert to the old behaviour of setting the interface
> up before enslaving if both IFF_UP and IFLA_MASTER are present? Did you
> test this with a bond-type master?
Yes, both command sequences (cf commit log) work after the patch.
dev_change_flags() is called before do_set_master() only if the user asks to
remove the flag IFF_UP.


Regards,
Nicolas

