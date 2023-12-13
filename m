Return-Path: <stable+bounces-6662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03C2811FA7
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 21:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0AA71C20DDA
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 20:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1667E540;
	Wed, 13 Dec 2023 20:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9o4dZNc"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3260DC
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 12:03:34 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7b3708b3eacso304509239f.2
        for <stable@vger.kernel.org>; Wed, 13 Dec 2023 12:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702497814; x=1703102614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qb0Chor65PZwcWQrckJnWHpUdZLfS48jXZAf3E2TW4A=;
        b=A9o4dZNcaIowUuCvXSLY65C2Ty/tLptnCZgEQjIOHJGR4y829aL9U/7NzSMATDehty
         Lr0LBmVGYmrqiYKbSzwNFoZiA8ruDJcJNdGF06WfTTfCbh4PvU2dc9tXV7Fq4IQZgfC/
         7VXKHSD+5hNbWsgBTWTLALibFyJ2qB8WlIPzr8aKdoSDevDCGz3MeADOJdyuxE27WH1W
         zKpp7dmEk/PKenYovXYpjlGepLiXf1NFXjbamKS/l+tOt2iMfXhvxJEpimYGwW7EdH3N
         +lm0MaJwlrxK3X1281e/35iWIfB398oB7Y0zp7GHborT3+CtiUjCcRYamRElh/5jvR0g
         rt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702497814; x=1703102614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qb0Chor65PZwcWQrckJnWHpUdZLfS48jXZAf3E2TW4A=;
        b=W/qteS7CGSQdu6X0ZNL1UuU4dOcQkBuWy6wD9RMsD+a/PBnNzekOoHZHLhQ+5i1CW8
         ce/pQ6WoMvZZ7md5H8H5uDwWHHeg4JcBTbhkXPgupIai2+eeMN1au1kM9Or3vgbOZgXk
         37VLkJUL200j/7gugWRJCFc/mDUfT9Bx5wWgEOCtCplWeU6cxiU2abWmCX1UaUD89wn6
         t5k18RucPwnUHwt8fF5+DHgNEXwBjqFKoGDpvQP6cl023UIJzR6H3OD3V1ZRnXvsYEEr
         VJJgm1ieVS1I7CP0s0f2exBpRwE9oMDT0ZoHT11ohsq7zFg9xhu19kE2P5jq0Ld40RuP
         sOWA==
X-Gm-Message-State: AOJu0YxX+19QtSjTBPN/vyn+mWNr6e0A/1yz/gwufEpWVy9cZHq7p/i0
	pEV657KoytVUQ352103akLw=
X-Google-Smtp-Source: AGHT+IFV/vrZBJsnC90uYksGEy6IktKmTZJpQ4bUjLwE2JNNQ4jAgOyDSOJMfeRgZgTnkpY+LF+gxA==
X-Received: by 2002:a05:6602:80b:b0:791:1b1c:b758 with SMTP id z11-20020a056602080b00b007911b1cb758mr8380586iow.19.1702497813983;
        Wed, 13 Dec 2023 12:03:33 -0800 (PST)
Received: from ?IPV6:2001:470:42c4:101:b11e:59d6:a73:7922? ([2001:470:42c4:101:b11e:59d6:a73:7922])
        by smtp.gmail.com with ESMTPSA id g14-20020a02cd0e000000b0046455c93317sm3089544jaq.92.2023.12.13.12.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 12:03:33 -0800 (PST)
Message-ID: <97abd266-3848-165e-001c-b5d3e0504323@gmail.com>
Date: Wed, 13 Dec 2023 13:03:32 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6.6 126/244] arm64: dts: rockchip: Fix eMMC Data Strobe PD
 on rk3588
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 Heiko Stuebner <heiko@sntech.de>, Sasha Levin <sashal@kernel.org>
References: <20231211182045.784881756@linuxfoundation.org>
 <20231211182051.468710881@linuxfoundation.org>
 <0584789e-2337-2d94-608c-81c09ca0d6d9@gmail.com>
 <2023121244-distrust-draw-d67b@gregkh>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <2023121244-distrust-draw-d67b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/23 03:36, Greg Kroah-Hartman wrote:
> On Mon, Dec 11, 2023 at 03:05:31PM -0700, Sam Edwards wrote:
>> - 6.6 isn't LTS
> 
> It isn't?  That's news to me, you might want to check the page:
> 	https://kernel.org/category/releases.html
> :)

Hi Greg,

Haha, oh man... the resource I referenced on Monday was out-of-date and 
didn't reflect that 6.6 was LTS until ~6 hours after I had clicked 
"send." Should have seen the look on my face when I got your reply and 
went to check it again; had a moment of doubting my own grip on reality 
until I saw the edit history. Serves me right for not relying on 
kernel.org *first,* I guess!

Okay, since 6.6 is LTS, it makes a ton of sense that this patch should 
be in stable-6.6 and I withdraw my prior apprehensions. Sorry for the 
confusion. :)

> thanks,
> 
> greg k-h

Thank you as well,
Sam

