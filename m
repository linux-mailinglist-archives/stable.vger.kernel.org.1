Return-Path: <stable+bounces-66363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E700A94E1A9
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 16:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A371C20A95
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 14:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0F4148825;
	Sun, 11 Aug 2024 14:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhG+5zRZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF421798C;
	Sun, 11 Aug 2024 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723386731; cv=none; b=tCpHM4vV36aeyLVDoh7tYOpIocHeyTtlN3+SpJmK7qK47saQTZoAB8qzpnP7DwXqee7YBdK+9mZByVxV/y7VwCFI9VkHvi+HxyE8AshkaLqRtq5I4sC3eBXfVxRf/W0JJLQ6Ij+zZPERR3jGxe3th4OXblbg5fGzNaUzFmyRo6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723386731; c=relaxed/simple;
	bh=8wlOlKEv1P2u6aMLa1BbhYFSivgyaJ10HmRu/onwV6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLNjhO53nPmUU+qLrQv1p0iA81oYeWFlvdBdkPxTv5oM197KKjbSCdjUPKNSmSgtwjWOI2RMWCIdaXpz8rzePIaSWcBFpCSvc2+BWe7YAiemThc8i4SB1vtsPHCoPhry2j71pbJTWw4LmYrSNh0+a5b9CxTN9GgZrNCw/DolnUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhG+5zRZ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-530ad969360so3738017e87.0;
        Sun, 11 Aug 2024 07:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723386728; x=1723991528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lRZPDQeJi8gV5FjG+WOyNGRr8ce7b4ax/xgMOADtm0Y=;
        b=AhG+5zRZqwIG1e3vx4aehXSmBLaitHQZMjWekiig8rW/lsCuOl2d2eH96SBzntsWjA
         qaJHo7TWi6l/XWThiOYRbT7jSOtPS/gvoVyhKbzd253QPXKE3mAf/ZFt+C8YddR1flJS
         hi82zGqPDXZ+IUqT/3xsiXLg0z3HkFkRvEmIQe9g/EqRmcgR60EAsFZvU4fbgR8JxuFr
         etii8/k/g39kMExY9I4nJjsGfhfONcXq3PFaDTtGBumXBm0yLSB9AMyC5xcoBnaT4lQI
         NXegUtYQIo8+iyqwXl+NdtyZrB1zcrVe1Y8ps1algRqFPxyKaUHKP9hPI2po6zMnj80b
         Z6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723386728; x=1723991528;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRZPDQeJi8gV5FjG+WOyNGRr8ce7b4ax/xgMOADtm0Y=;
        b=kF3+Glhw+2Vr6lafEg73B9uTKLQTbbSK+S0PnXXLTaRZpMQ033EBO36lCPZK88rViL
         9k7gLD+1XApOw/zmX+zu50eElGuZqPE4/rKzuUx4ed9Z0H+DGs1kEHGXYeaGYFzdnzdA
         i7CADnbyeW/DS/W4LtP6VuCT5PESWo0SwDtoqcXm/PKiVkiKdDGfAb4LGqecp+UXXZYW
         rIG5/mDsl42RFIpWJouDQTPA6qUI2/FGnqAI3T+2lAeaPyk5hVpIGhuWsxhP+Ku3D32C
         FWCGFg1t4YBlJQOJG4/hg+cx4mIfKZrhdbhH6nVPw+sq6F1fClJOF6J9VIDbeSrhlzS2
         LDIg==
X-Forwarded-Encrypted: i=1; AJvYcCVwY+qu0kZdo44x5U/iCBSwfV3YSAvmOcvQIJ+WQYH4aU/czzP3vj/WR7AFL5v957LWH5DR+P9655u620f0cUe4cL6mEjsTc1A+Vb5UIIHo88/nkJvWHTTtVZzpspF+
X-Gm-Message-State: AOJu0YzNNNAUiyX9XrvXxWbtoUiz64enBCTxgYEWQlqIl8+hf4rnmR0g
	lnYxKRPte7tznObYAJu2OeE9voeBVw4WwdvMEhtEKVGyS21XIyT0
X-Google-Smtp-Source: AGHT+IHuqBgINOZtfRlI8H+UyUlqnCWQjYa3wuCYd5xj0DdASVkL/x1Ho7y7mQOdMzWYRjmHHNXR8A==
X-Received: by 2002:a05:6512:138d:b0:52f:cffd:39f9 with SMTP id 2adb3069b0e04-530ee984473mr4735154e87.24.1723386727199;
        Sun, 11 Aug 2024 07:32:07 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bdf7:500:55ff:b5b3:d77:9d3a? (dynamic-2a01-0c23-bdf7-0500-55ff-b5b3-0d77-9d3a.c23.pool.telefonica.de. [2a01:c23:bdf7:500:55ff:b5b3:d77:9d3a])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5bd187f4fe2sm1370276a12.9.2024.08.11.07.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 07:32:06 -0700 (PDT)
Message-ID: <39b2fc1f-421a-4547-b7bb-47b207975d73@gmail.com>
Date: Sun, 11 Aug 2024 16:32:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.10 03/27] r8169: remove detection of chip
 version 11 (early RTL8168b)
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, nic_swsd@realtek.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org
References: <20240728005329.1723272-1-sashal@kernel.org>
 <20240728005329.1723272-3-sashal@kernel.org>
 <111ac84e-0d22-43cb-953e-fc5f029fe37c@gmail.com> <Zrcu7-CfCIoGO18V@sashalap>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <Zrcu7-CfCIoGO18V@sashalap>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10.08.2024 11:12, Sasha Levin wrote:
> On Mon, Jul 29, 2024 at 10:45:15AM +0200, Heiner Kallweit wrote:
>> On 28.07.2024 02:52, Sasha Levin wrote:
>>> From: Heiner Kallweit <hkallweit1@gmail.com>
>>>
>>> [ Upstream commit 982300c115d229565d7af8e8b38aa1ee7bb1f5bd ]
>>>
>>> This early RTL8168b version was the first PCIe chip version, and it's
>>> quite quirky. Last sign of life is from more than 15 yrs ago.
>>> Let's remove detection of this chip version, we'll see whether anybody
>>> complains. If not, support for this chip version can be removed a few
>>> kernel versions later.
>>>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> Link: https://lore.kernel.org/r/875cdcf4-843c-420a-ad5d-417447b68572@gmail.com
>>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>>> ---
>>>  drivers/net/ethernet/realtek/r8169_main.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>>> index 7b9e04884575e..d2d46fe17631a 100644
>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>> @@ -2274,7 +2274,9 @@ static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
>>>
>>>          /* 8168B family. */
>>>          { 0x7c8, 0x380,    RTL_GIGA_MAC_VER_17 },
>>> -        { 0x7c8, 0x300,    RTL_GIGA_MAC_VER_11 },
>>> +        /* This one is very old and rare, let's see if anybody complains.
>>> +         * { 0x7c8, 0x300,    RTL_GIGA_MAC_VER_11 },
>>> +         */
>>>
>>>          /* 8101 family. */
>>>          { 0x7c8, 0x448,    RTL_GIGA_MAC_VER_39 },
>>
>> It may be the case that there are still few users out there with this ancient hw.
>> We will know better once 6.11 is out for a few month. In this case we would have to
>> revert this change.
>> I don't think it's a change which should go to stable.
> 
> Sure, I'll drop it.
> 
Just saw that this patch has been added to stable again an hour ago.
Technical issue?


