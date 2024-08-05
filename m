Return-Path: <stable+bounces-65379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3786947B77
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 14:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2080A1C2121A
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 12:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3BE15A86A;
	Mon,  5 Aug 2024 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="GJwuZrx3"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFD615A865
	for <stable@vger.kernel.org>; Mon,  5 Aug 2024 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862615; cv=none; b=hBXjk3vxC7ipmJHt+aE/idDXGTP2lf8CQ+vjO8m4Z/jbR+G3p5rT8wP1Yv7xcHg0BKPdFFwkEqJKdwztrAHzz5/ncQT+AWRQtPXLWZi5CEcF3LlJH7jZe0e57lofcUueC1V0pFwN6eTJr0G6GF4qe07p+iJ/O5L9lazSS9mH9Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862615; c=relaxed/simple;
	bh=meap2/Rvum81A9212ej+lOTfNq9jT8DdvVTkvZKz4pA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qIaOVnjvy0VjNHpZRfxyxEg3An3zb4qzlzKXmljtF+w9Q3qXNWNyq2snUpi07xkrRGZTdn0NXHK9tNfqBiQucGfQTfkmtRFjMqkEkobIi9M8AHRAVJ7mgApYO397wkTMYTjV6k3I6lqNXLenk/PiTnTvDJiA3oEw2oZC1lXlKB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=GJwuZrx3; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso129592671fa.2
        for <stable@vger.kernel.org>; Mon, 05 Aug 2024 05:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1722862611; x=1723467411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ucAW2YItCVD1AvFmAIVer0cm7JI4a2OFw03lJ7TlpOA=;
        b=GJwuZrx3Fftukzlt0Zmel2PJp8BvFx/NsR8y9nz3i0E6SOkQTmqCcoeJNwoqGtZZSo
         afCzP2si83fCKh844HdvaNdb7qyyf53D8Z7RzcRULKx2YTxoq1LoC8Rhdpz2oGqR794+
         rCbJPS60ufnNgn+PKjTXJ37zdJBjkngSkIaAFCclFoLdwwFfDjjHQY397BhOO5brhYgu
         yrG66xrYQ8NZ7hhgYvkh3ew9zxGZKZkWyGjnCAtSu/lTu0+1AYmXx0asNiyeDnQnzLS2
         hUcqG7t7Vmv1qAl0K6zXqQEYf/qLmPaXdXvGaBU1TWkXhYPrwIAqUN6v6nd4xDTwIjLL
         NAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722862611; x=1723467411;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ucAW2YItCVD1AvFmAIVer0cm7JI4a2OFw03lJ7TlpOA=;
        b=rXvoqEhWUI90vq+pkwrMcXCa/xEVp/2KzGt8X/4puSxkep2aPTeux4p++8a3+qdB4N
         hKjJD73UJXFVzmyik+igN70jk8vxYQ+12CA/DDLWDmhc4cpucrk5DHGRWZAjWgaKdltI
         nr/2GymgbC+45f8OZnxMWSRPAkIlivjL/3pwvw9otXG+VYiRLFV2QiBfHQXZgqs41t3P
         WhEW4V7u6jDM+PIOw+XNpddyYoDe5rMduRO2Z21Y7a8B+by+Ct5ItZGnIzUufCxQY2A9
         AiRzvkF5gDs6SK7NkL1HQGAxdBhc/yNpVMiO01vYafsINfT6StA7rw0e0XO5F7RFIHo6
         AxOg==
X-Gm-Message-State: AOJu0YxDtuUkgi+akvh5nqG35+yN2y+m+5Kv5rmg0uquOjAAM3fZLegD
	2fRQlhRSmAo/zHeCD2LlbZbjmPiojVDZmJhS0WqhZt9+iAkFII+EYT8aSy7CMfI=
X-Google-Smtp-Source: AGHT+IGyN3Pyr2wYhLf+g+0wD7OW/YEv6/2pS7z42VReoLlQ8SUdeSHB3FTdMkYtirTJAIBlBSzrCw==
X-Received: by 2002:a2e:96d1:0:b0:2ef:208f:9ec0 with SMTP id 38308e7fff4ca-2f15aa92e12mr83757761fa.14.1722862611191;
        Mon, 05 Aug 2024 05:56:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:215c:4f6d:331d:d824? ([2a01:e0a:b41:c160:215c:4f6d:331d:d824])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb97fbasm199948345e9.41.2024.08.05.05.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 05:56:50 -0700 (PDT)
Message-ID: <1d3b8483-446a-427a-b987-ed88248ede55@6wind.com>
Date: Mon, 5 Aug 2024 14:56:49 +0200
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
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240803145547.888173-1-sashal@kernel.org>
 <fa631c09-60e4-4fec-98ce-3f02fd412408@6wind.com> <ZrC2VY4GfDRv5T5i@sashalap>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <ZrC2VY4GfDRv5T5i@sashalap>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 05/08/2024 à 13:24, Sasha Levin a écrit :
> On Mon, Aug 05, 2024 at 09:43:53AM +0200, Nicolas Dichtel wrote:
>> Le 03/08/2024 à 16:55, Sasha Levin a écrit :
>>> This is a note to let you know that I've just added the patch titled
>>>
>>>     ipv4: fix source address selection with route leak
>>>
>>> to the 5.15-stable tree which can be found at:
>>>    
>>> http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>>
>>> The filename of the patch is:
>>>      ipv4-fix-source-address-selection-with-route-leak.patch
>>> and it can be found in the queue-5.15 subdirectory.
>>>
>>> If you, or anyone else, feels it should not be added to the stable tree,
>>> please let <stable@vger.kernel.org> know about it.
>> I'm not sure I fully understand the process, but Greg already sent a mail
>> because this patch doesn't compile on the 5.15 stable branch.
>>
>> I sent a backport:
>> https://lore.kernel.org/stable/20240802085305.2749750-1-nicolas.dichtel@6wind.com/
> 
> Appologies, I haven't seen your backport, but instead I've picked up
> 40867d74c374 ("net: Add l3mdev index to flow struct and avoid oif reset
> for port devices") as a dependency to address the build failure.
> 
No problem, it's fine for me. I will launch the selftests to check the backport.
I've just sent another backport for the last patch of the series.

https://lore.kernel.org/stable/2024072906-causation-conceal-2567@gregkh/T/#m7065a276c15cc43e31b92b49465a6e6c6b85d7a2

