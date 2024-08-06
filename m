Return-Path: <stable+bounces-65470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A92BA948A4B
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 09:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F61285B59
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 07:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CB8165F1C;
	Tue,  6 Aug 2024 07:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="aB9FlyEf"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DF8166F0C
	for <stable@vger.kernel.org>; Tue,  6 Aug 2024 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930034; cv=none; b=gQIsStOvnCkXNAvkvhl4f8WrDFhKEp9yL84FCVRS2qq5rNRJiPJgbAw8ahB9sKbPWC1RXC0X4SEfpc0WDVaGlQKXKstT7Lpbc39z+RLM9ccEgg/tA28q9LWXgTQ52iZUQ0MmLOGytvcK7LMlVjLwOlCEMybLvj1b2975uUB+uwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930034; c=relaxed/simple;
	bh=e7q7PuGomUmc8mDA+PRh5mc/fuHtDvXpByuSLXKRUw8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eX8QbZ0aWD1uo0l2Chp6IGcJYBAw3hF407CBAs+TFWZFybNwaDuhcgB2CkgL45rOsk40ZDIpWtMXcIfjzM5mp1bosYxeez6htFYmXeYh8H9+eT8/M22iYACeMgfmASrBq36sa1AkLAXtl3NPL+A73jsM47BuMw+wqAjEJEHJYcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=aB9FlyEf; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4266dc7591fso1775115e9.0
        for <stable@vger.kernel.org>; Tue, 06 Aug 2024 00:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1722930031; x=1723534831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:from:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e7q7PuGomUmc8mDA+PRh5mc/fuHtDvXpByuSLXKRUw8=;
        b=aB9FlyEf/P5azZR3cr7l3DvW3QsgokJ3o/Wwxxtpq9veWPxDSe6LXuyG+8IMouNnXK
         OhoPyCH66r8xFgmi9sU2IPZXGqASY0DSONBy2GTaVEWZFSNMDlx0COu+j2jrta5Z355V
         W+q7spufC8g7BC5ntDkr/hrjTUpmllQJq7CHJk6XR6pnf88+DKEQzxbOxHGKByImoifD
         RHywDtTn2SWxA4OP1aUPG0bUvJ18fXcLNzhQ92iBBaaljSZEFXSnANT/VCy/ZUceq6d6
         kdQq0gPqM3a1rzwjnUC/5ypdeCZOcxD32ZVSHc5Vu133deAvl8UUqFVzPSxwsDExRTAm
         NyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722930031; x=1723534831;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:from:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e7q7PuGomUmc8mDA+PRh5mc/fuHtDvXpByuSLXKRUw8=;
        b=EkYLa2h4y23OIr54YBOWDHDAtDb0SqQcDWENKfGe6xGTu2x9cZJa+2W0nMdg9DaA+v
         t9BTzqOsPIJpyr7TFpM6u6TMyBs+mNkki5vFMeBSkEB0z547O3eAOZv7Xu7S/ZtaKhOR
         vS3yC25CL8+4kYO4gAE+PcEEyVYmrTYJayBpi7TO/vRWpSpMvXtPQ5SGIP34ZiA0n/Nl
         wBITI4YLBLEvsiR4E5J3X3Crvp7/YfvKXVoevuRFCBIrFic2VT0MIB9UDw6QYTiwFoTS
         b+D+bGZM+m3JOw8PpGajTzl6cIj+XlThbAkaq8WL4Uphgcd29i60IY6qsoo9XBgdH3iF
         njKA==
X-Gm-Message-State: AOJu0Yz8oxY2vHomFz4hNaKGe0xPLntfW7uA0OGPVFQLgx1Q5bBNcdC8
	xRQuAcfRQwt/7WR5X1wN9qNFj6Vsz1dal2qQKFle0NOtHrB/uU+3aA+ChLdrSog7W91YYSs79/0
	+
X-Google-Smtp-Source: AGHT+IGCY7coCo4klSW6TQMqTFP1OGf4TPjvcIgkTlVlpPcsZBm6uOYHcXnWmJU+do3cp6jMXSuOaw==
X-Received: by 2002:a05:600c:4f06:b0:426:6d1a:d497 with SMTP id 5b1f17b1804b1-428e6af9d21mr96092185e9.12.1722930031495;
        Tue, 06 Aug 2024 00:40:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:400c:6f2d:f80c:1b34? ([2a01:e0a:b41:c160:400c:6f2d:f80c:1b34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282babaa39sm225750505e9.27.2024.08.06.00.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 00:40:30 -0700 (PDT)
Message-ID: <1a575070-6590-48ee-b157-e994a889fcdd@6wind.com>
Date: Tue, 6 Aug 2024 09:40:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: Patch "ipv4: fix source address selection with route leak" has
 been added to the 5.15-stable tree
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240803145547.888173-1-sashal@kernel.org>
 <fa631c09-60e4-4fec-98ce-3f02fd412408@6wind.com> <ZrC2VY4GfDRv5T5i@sashalap>
 <1d3b8483-446a-427a-b987-ed88248ede55@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <1d3b8483-446a-427a-b987-ed88248ede55@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 05/08/2024 à 14:56, Nicolas Dichtel a écrit :
> Le 05/08/2024 à 13:24, Sasha Levin a écrit :
>> On Mon, Aug 05, 2024 at 09:43:53AM +0200, Nicolas Dichtel wrote:
>>> Le 03/08/2024 à 16:55, Sasha Levin a écrit :
>>>> This is a note to let you know that I've just added the patch titled
>>>>
>>>>     ipv4: fix source address selection with route leak
>>>>
>>>> to the 5.15-stable tree which can be found at:
>>>>    
>>>> http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>>>
>>>> The filename of the patch is:
>>>>      ipv4-fix-source-address-selection-with-route-leak.patch
>>>> and it can be found in the queue-5.15 subdirectory.
>>>>
>>>> If you, or anyone else, feels it should not be added to the stable tree,
>>>> please let <stable@vger.kernel.org> know about it.
>>> I'm not sure I fully understand the process, but Greg already sent a mail
>>> because this patch doesn't compile on the 5.15 stable branch.
>>>
>>> I sent a backport:
>>> https://lore.kernel.org/stable/20240802085305.2749750-1-nicolas.dichtel@6wind.com/
>>
>> Appologies, I haven't seen your backport, but instead I've picked up
>> 40867d74c374 ("net: Add l3mdev index to flow struct and avoid oif reset
>> for port devices") as a dependency to address the build failure.
>>
> No problem, it's fine for me. I will launch the selftests to check the backport.
Tested-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

