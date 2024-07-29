Return-Path: <stable+bounces-62420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A153893F010
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1471F22101
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 08:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DC913210D;
	Mon, 29 Jul 2024 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIXp6msm"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FA31EA91;
	Mon, 29 Jul 2024 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722242720; cv=none; b=lwpHVRCaDsk781Nn0o9UVG6uDHGJ05EQMIOgs+2UADy+ROHaBjkOp++ImF49aPczejiHBVQYaX/IZ7GliIRYjXwphSCVLepEKYjfXvC2PuT3J4VGWEKTCu3FOb8TeApLh2kuGJoQ14YguI1qqe5BvarWTWzhUVOmfmGtN8vEo/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722242720; c=relaxed/simple;
	bh=D2EAHfRt9qwXP2nz/hapa8cl5ZuSjrrA0RZIW3dZk6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tX5e4eQKz2CZED4smeMTYMTH3KHBY4yIvxaPG7FOw3E0ZrJGO7v7rah+XQVPAFviyOoBjt5/lSN/abt3J8nr1dVRg9sC/JahlLCn9Y6D7NM+P1hWz/IFc2J6NX1AB2IsJjhQmi2qoczGkc5ogT7SFvP6FdjWPWtB7qn5lEdOGiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIXp6msm; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc3447fso4781076a12.1;
        Mon, 29 Jul 2024 01:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722242717; x=1722847517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xef+0qVtbo5Kd6IGTaNJI7UUdQxJlVioCywC7nYuO18=;
        b=AIXp6msmd+R/c8XVfw+52xGBI8y7S9PKsQUG71TTIH8+YP092iL6T6Woozph7z+V06
         kSnnWxvP6M2OuaEFQNHQ0+Uh+mZysO8z+qW6wH5+rHtih3AKiU4lzN6BUITuYFhvNIKt
         d66pOdP29hrOv21WOVKyLC4m6ALZfBoVHgj1bsKAgapbIJh4JSRrk+cALbcJUt+2f32D
         ebmSwgVeDSTi+ZGKeZCgz+Q3NkSETxGYSo9sSx/+M1ektBz1EW1L4EAkZcWHHI1a1GS6
         /ocxMi7aXEG/OvjvD3Dohb0LfHS+C+mpwd6dBbtxUFGHLuA1g7BEEChfLDZWrqKamjdY
         cu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722242717; x=1722847517;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xef+0qVtbo5Kd6IGTaNJI7UUdQxJlVioCywC7nYuO18=;
        b=uV+OhmTrpjJKaxzLV+BrNzxoBtSKkieyEMxdlgYlY0xbRkcnAVDYqsQ4Kn6WSa5F8v
         1Y0dhBHJ2vmhKMULFjQTxPTazspIaTm5oiWt1x+bALfoAN26KV3cnm2fWblcRV7u4Flp
         KYCL0pJHbwGJhqt9DFYeBXeP21F6kwpeUz4e6pjDZ+a5fPAhutGejoJmxfxSBZjhd2JX
         zktaO4BtmLxefLUxeYiAXNP2Xgb/25zvlsNOMNMOVnk0eM/lm9aqviFOiA8Hu+1ZjUuA
         fSG/RfVckmIEPkg88RdUNx31z2Ws50ueMZv+9IbpD0m/16gqrACXcSecMdoKh9Nwct1z
         GDuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrS4BV3VQjH0rmXXvJzsUPrWXLIgHPhjtlxoerNT2fIqu39bVfz3btD2bqxRUH3ZFAN7x9fk1MCfo5j+yHN3dzXvTbVz5krj+AEeLt/Sk/4syg59+s470vNd+t8rU+A93SjJjYEbDQYZ3Od9sInZ4B+zSOAUbuVU8FD2VV
X-Gm-Message-State: AOJu0Yze6kur6ir+9GmI6auKUIYw/29snxrGS82cQqVVpVGNUU5nwowb
	FgHtKwLi+Fw1MwA/qQ0tMJRcH4sjofo6SlFZelz+KzFBSNtb3xjP
X-Google-Smtp-Source: AGHT+IGzkt5+EOXcRanHeKXHGnEsewHbb7z+c2fzp+t3AakPi6zUAOdfs0iy1Vxx8Ru9XPejtlWCPQ==
X-Received: by 2002:a17:907:1c85:b0:a7a:8cfb:656b with SMTP id a640c23a62f3a-a7d4012b27fmr362886866b.60.1722242715504;
        Mon, 29 Jul 2024 01:45:15 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7233:9000:f5ea:7623:e535:b475? (dynamic-2a01-0c22-7233-9000-f5ea-7623-e535-b475.c22.pool.telefonica.de. [2a01:c22:7233:9000:f5ea:7623:e535:b475])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a7acad411d2sm478865166b.126.2024.07.29.01.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 01:45:15 -0700 (PDT)
Message-ID: <111ac84e-0d22-43cb-953e-fc5f029fe37c@gmail.com>
Date: Mon, 29 Jul 2024 10:45:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.10 03/27] r8169: remove detection of chip
 version 11 (early RTL8168b)
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, nic_swsd@realtek.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20240728005329.1723272-1-sashal@kernel.org>
 <20240728005329.1723272-3-sashal@kernel.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20240728005329.1723272-3-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28.07.2024 02:52, Sasha Levin wrote:
> From: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [ Upstream commit 982300c115d229565d7af8e8b38aa1ee7bb1f5bd ]
> 
> This early RTL8168b version was the first PCIe chip version, and it's
> quite quirky. Last sign of life is from more than 15 yrs ago.
> Let's remove detection of this chip version, we'll see whether anybody
> complains. If not, support for this chip version can be removed a few
> kernel versions later.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> Link: https://lore.kernel.org/r/875cdcf4-843c-420a-ad5d-417447b68572@gmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 7b9e04884575e..d2d46fe17631a 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -2274,7 +2274,9 @@ static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
>  
>  		/* 8168B family. */
>  		{ 0x7c8, 0x380,	RTL_GIGA_MAC_VER_17 },
> -		{ 0x7c8, 0x300,	RTL_GIGA_MAC_VER_11 },
> +		/* This one is very old and rare, let's see if anybody complains.
> +		 * { 0x7c8, 0x300,	RTL_GIGA_MAC_VER_11 },
> +		 */
>  
>  		/* 8101 family. */
>  		{ 0x7c8, 0x448,	RTL_GIGA_MAC_VER_39 },

It may be the case that there are still few users out there with this ancient hw.
We will know better once 6.11 is out for a few month. In this case we would have to
revert this change. 
I don't think it's a change which should go to stable.


