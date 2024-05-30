Return-Path: <stable+bounces-47685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F0B8D4757
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 10:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450591C22983
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 08:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E77517619F;
	Thu, 30 May 2024 08:41:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA9817618F;
	Thu, 30 May 2024 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717058471; cv=none; b=EZuWCuQetXaUDgmSSV1afCN4dNnYn1mbWboRFh/0ItnWrl4W7h1q2OIO7r90Ax+3RMxQ1emao3pTIg3J8GCLHDs+W4qoWt7ivBigjbR1+OAtznYnoTaMYTBk1ZQaVkgaPIHSPp0pWN4v0l4JgFqfl4VyPH0wZYHXT/hY0V96wCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717058471; c=relaxed/simple;
	bh=vNXsLx4YLa+k5jmJZka0O+9B23pM1FLkUtEOUnXLZ+Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=j2Cj2rMAyZJAV1jpoEIwtfTbqVv/HUvhXboejPNKEdjTib8rVXfT18uskdjazRcXPTxqROBVXVfCn3+xuZFxsl8TZAYB0dvQZo4xp5+9xno4QS5w7wjkwY4zPlCtml/tO03mK290+0tam9TUIMUxqDf5BuUtn8QRYCMLrNX4uv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e968e77515so7726801fa.0;
        Thu, 30 May 2024 01:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717058468; x=1717663268;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZv4+BlSGakHOy+YGxnox9Z8B/DUI14pHVDE+6Sat00=;
        b=kQZUBj9q6jGSRKXSqulYBlHPjq6YNdNp/tfEB2RTHgjdDHbtbAqyhBUmjU7JWWsqZC
         o69Zr8j9kL2l7d7QYmlCTQcyvou/sOByEiUVuF/rT6TIWehPmab+Mv+RF6lzdROKuOeo
         epN9fECKnLTY/dYJ+U7GavTW9CNOSbTSVvG9XHm/pT7lZCgChlniLTQruKWz/KIygU1L
         pnCKjWP25Q6Y8/6jF+3hLklirDhScpBJHND3grsvrRt7WjAYrKVEviN0xZUHzEZXmbbc
         vYna+WlFqMc/G5BpqljUM2CNEIOi+xD/GJNxJM5gorkmfX4ghvM7yHIZQIKeB3Km6gaP
         3rhw==
X-Forwarded-Encrypted: i=1; AJvYcCUqxABs8T89qTgm0L5FaoOObfOZflQ0ptgFMEdOzHqst1VSou7DwTHmqjSFONF3LEBFCMQYc0BRMpDqsmF/4UBgHSjM0NSAVuP1IgD2Rwwi1yPqzM0I+v5Tnjs3jsoOIkDQG/wjUNLgj6Df8PhXGPeiz6j6LlsPpdmq5ixxZ4Hy6UwGyGu7
X-Gm-Message-State: AOJu0YyHsk0wMPCr2/X97WBPYqttNPahgBSRJdP/ybW737zMotFy+44K
	L8XbZRzYZsWIadUNYzf3sMf5DI610ggLqvPl5GzLfIIDF7mWUtgL
X-Google-Smtp-Source: AGHT+IHTAsijZ4zBBGlMo44sYNh9u1hf3BwYBkucnjZPnVGPkHPPIsIk5rUUJ3Vnub0PLKpUyVTjmA==
X-Received: by 2002:a05:651c:1186:b0:2df:e0c4:8429 with SMTP id 38308e7fff4ca-2ea847fa4ebmr9127971fa.18.1717058467590;
        Thu, 30 May 2024 01:41:07 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212708a706sm17733315e9.42.2024.05.30.01.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 01:41:07 -0700 (PDT)
Message-ID: <6170ad64-ee1c-4049-97d3-33ce26b4b715@kernel.org>
Date: Thu, 30 May 2024 10:41:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: mxser: Remove __counted_by from mxser_board.ports[]
From: Jiri Slaby <jirislaby@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-serial@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev, patches@lists.linux.dev, stable@vger.kernel.org
References: <20240529-drop-counted-by-ports-mxser-board-v1-1-0ab217f4da6d@kernel.org>
 <d7c19866-6883-4f98-b178-a5ccf8726895@kernel.org>
 <2024053008-sadly-skydiver-92be@gregkh>
 <09445a96-4f86-4d34-9984-4769bd6f4bc1@embeddedor.com>
 <68293959-9141-4184-a436-ea67efa9aa7c@kernel.org>
Content-Language: en-US
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <68293959-9141-4184-a436-ea67efa9aa7c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30. 05. 24, 10:33, Jiri Slaby wrote:
> On 30. 05. 24, 10:12, Gustavo A. R. Silva wrote:
>>
>>
>> On 30/05/24 09:40, Greg Kroah-Hartman wrote:
>>> On Thu, May 30, 2024 at 08:22:03AM +0200, Jiri Slaby wrote:
>>>>>   This will be an error in a future compiler version 
>>>>> [-Werror,-Wbounds-safety-counted-by-elt-type-unknown-size]
>>>>>       291 |         struct mxser_port ports[] __counted_by(nports);
>>>>>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>     1 error generated.
>>>>>
>>>>> Remove this use of __counted_by to fix the warning/error. However,
>>>>> rather than remove it altogether, leave it commented, as it may be
>>>>> possible to support this in future compiler releases.
>>>>
>>>> This looks like a compiler bug/deficiency.
>>>
>>> I agree, why not just turn that option off in the compiler so that these
>>> "warnings" will not show up?
>>
>> It's not a compiler bug.
> 
> It is, provided the code compiles and runs.
> 
>> The flexible array is nested four struct layers deep, see:
>>
>> ports[].port.buf.sentinel.data[]
>>
>> The error report could be more specific, though.
> 
> Ah, ok. The assumption is sentinel.data[] shall be unused. That's why it 
> all works. The size is well known, [] is zero size, right?
> 
> Still, fix the compiler, not the code.

Or fix the code (properly).

Flex arrays (even empty) in the middle of structs (like 
ports[].port.buf.sentinel.data[] above is) are deprecated since gcc 14:
https://gcc.gnu.org/pipermail/gcc-patches/2023-August/626516.html

So we should get rid of all those. Sooner than later.

> thanks,
-- 
-- 
js
suse labs


