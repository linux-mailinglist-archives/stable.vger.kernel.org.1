Return-Path: <stable+bounces-9180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE78821B76
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 13:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB948282299
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 12:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21CFEAFF;
	Tue,  2 Jan 2024 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="WxwBsML1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3567AF4FC
	for <stable@vger.kernel.org>; Tue,  2 Jan 2024 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33686649b72so9528734f8f.3
        for <stable@vger.kernel.org>; Tue, 02 Jan 2024 04:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1704197684; x=1704802484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zhh5vYdTZsQ1BaZTdDhHiFjJyttFCie1hf7tVLjKe4E=;
        b=WxwBsML1xEmvYETHA+2azUPAb+bHBDmjJhXbGW3MuowA4Hr6NmzOJlwCWuaTIt4855
         sQvZVkXHc8hf1m12hmwa0mWPu7Zr1Ieds/3Ix+VyI9nzYxyMyXZcop8PiHRD1h+SVlhu
         0iUDrXRc3YVxA7+lgNEXsju6t8DX53gjFBptUTDl+HIypncD7I1G4at9MFNBCei4Yo05
         /K+G/s8Kr6vei5NiZo44DbAW3pwk89URSYt5wb7TyEWKFZfAlX3b+cezIG3SlA4bRP+9
         3HLsX/Pk6PfFNvby6cKT6dCAftsNTD5gIxIJCwC8YTxz9hk7nfrmZCfBaINNB/Xw3aTh
         1OEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704197684; x=1704802484;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zhh5vYdTZsQ1BaZTdDhHiFjJyttFCie1hf7tVLjKe4E=;
        b=w/2HUyp6ulqAN+0EZ5ha7md/9xzLKyc3zrR7FYFYsXQpyo2Y51DRf3++AvvY41pUhr
         QKufUWldDLnqrip93O/vBPYa0p3YGjVWH+grLOOMPYfgtjekhFsAGxX8561V4A6+BUcM
         2J/tT7cKEFYap8vEDvItZ6tlMIzjx6Emo9ptaLOH/zjzLzkf2746ryyfbsrv43EQtIuD
         ZxsBETCpTtf8s4lSrgDoxO0Ywzg9xZstxFNQCwvLTmIThIPZl0zpbCpC491kFSsVYZUb
         fez44O7WTPVBp7nI62rFf2il279jtKlY1LQskPBc1hyk9bipWAT1qIWKnDjMwIHDOWWK
         U/Kg==
X-Gm-Message-State: AOJu0YyJ8Q/IE2SHM/fvr6jSHeeCgKwq4nbSm2vQnH5g8b8As0UeNxgZ
	PP2UCUWofUqF4DaTmyC6PB2MEr1g1CET3syQHNuqCNouAmc=
X-Google-Smtp-Source: AGHT+IHKcvbQIsFBLDgIl79CiLExOpF73lYzXq3fNR05MEXO1/H2Asjz3awgiFru0mE28p5VPlXF3w==
X-Received: by 2002:adf:fdc7:0:b0:333:37f6:ad33 with SMTP id i7-20020adffdc7000000b0033337f6ad33mr8723122wrs.102.1704197684568;
        Tue, 02 Jan 2024 04:14:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:2900:c6f1:e9ae:67a6? ([2a01:e0a:b41:c160:2900:c6f1:e9ae:67a6])
        by smtp.gmail.com with ESMTPSA id cg13-20020a5d5ccd000000b00336e6014263sm16874405wrb.98.2024.01.02.04.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 04:14:43 -0800 (PST)
Message-ID: <a8b5e3fb-ff65-41c0-916c-58454cd0c810@6wind.com>
Date: Tue, 2 Jan 2024 13:14:43 +0100
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
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Phil Sutter <phil@nwl.cc>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
References: <20231229100835.3996906-1-nicolas.dichtel@6wind.com>
 <42ad4a1e-3a48-48aa-acd1-47d44b2ad0ba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <42ad4a1e-3a48-48aa-acd1-47d44b2ad0ba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 31/12/2023 à 17:36, David Ahern a écrit :
> On 12/29/23 5:08 AM, Nicolas Dichtel wrote:
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
> 
> add tests to tools/testing/selftests/net/rtnetlink.sh
> 
Will do.


Thanks,
Nicolas

