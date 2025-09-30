Return-Path: <stable+bounces-182875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EE7BAE6C2
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 21:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401A64A036B
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 19:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE2F23C4F9;
	Tue, 30 Sep 2025 19:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRuF/9aS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10231D63D8
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 19:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759259893; cv=none; b=sc0o3GsWB6M4DNJzcVw+xSlerEb0wie6qdapqJzSygGguXBdBta+PB5EFzxERG61gn01ths48B6FZ27/fBdh6w2yHYJCGNcbzve/ojijS7d7XbfTlcZaNgaXdX0gLlBMn+9O4uUNtHJJqsPl36H7xFDZKX7SxB/5yf5y4rQZEzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759259893; c=relaxed/simple;
	bh=GUeNVxovE4BIxA+RJnKhUwvmZ83v9T2HTqZpUMa6g18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VfM/z8pek1VsK5FAFPuz+O5YF80w9A36W6LHz1qFv4BQZ7VC6M+oaOJU1BJ7IDWTrwswSTBbua7YK6X4WtWxlK+eXDKfi/ehbOfzD8PvorevzhkZ3Yr7PrzKIgGGl1b65i+o1cu+GYBZkZCvdkeC70NSgZLv3idyPsE/10fX3lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRuF/9aS; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27c369f8986so61361015ad.3
        for <stable@vger.kernel.org>; Tue, 30 Sep 2025 12:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759259891; x=1759864691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QcSOOec7hYWNPWAHG6CqMpEpK2JyhPXuWUtKRek37zE=;
        b=cRuF/9aS2OxhyxCezxcu/Oczw9oSHQJxQD8cOWby8iv4XRKAmGWa75NRgVCt1ksOOp
         /oMAqNEzLhOXASeKXe4gxh2HT7T33li83kv3XibKI+AopSkUILEgYwf+Xj/IYHdpzsyS
         Z8qhQ80mYqc5gNNblWxlT1KoCnS6guQiDboc1qNKfWNvL/tAUeZWXuckHZYGt41Hilqm
         UckuuKJJWDRTucZhIYGtEn+W/pPibzaShOr7a4YkbhOTypZ9eeeCKKvjQUgnFzmnr3EP
         C5LrP2HQLyK58p6+3SOoDJIfwjJLlMxfMNzRj0RC7TqAbqPKQMgnT6stK1hTvCoGXOGU
         RgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759259891; x=1759864691;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcSOOec7hYWNPWAHG6CqMpEpK2JyhPXuWUtKRek37zE=;
        b=M8qVykDaGeUQn5zLG2LtDQWX/6cO8bulWPmGq7QgcDW56D5PQJDO0GqwgjVP3Vr9rK
         KhyQGVdT8wYu5fnyoCOwuQa2mLbeof3o/aLvMhaMsizTpmRLTlfI34yKFQJEZWwF6ay/
         PYlLjoLWgLLtkGv2lO7OVfqCBxXFjLH4GwGs/BeefvRV7sQFC99yEB8YAqnzCo2Z1Wve
         j80UZohshhVrw4mvqPnobZFtis+84IObJg0dcbe/kkSQUORSZHapZnZHTwWCrc8v82Ds
         Rv+U+/5bFeDbcoXtKUs/bNrCexeo5GNknNAWtJXSt3OBUhWgpJwHjWBE5rQV566yGiSW
         0U8A==
X-Forwarded-Encrypted: i=1; AJvYcCXkwh1lMSdkEo0tqfCU9pp7b3F5XWxrBTgWie7qCQ1yRAC0IDZSj8qG1Q0OkJLQ8oBTjWZOD3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv5hVwWqSnqIyMpvW2an7dG4QiJRsOnq92IARKVisedc8cPQo9
	zKw/wiTsEA5okS7FV4vGfj+su+czpHRZTrcmhH5X5Z9awJGBXKVA5ezu
X-Gm-Gg: ASbGncuYF+qbIxSWb2sEgJ+dJRhUVaQ5JSXxWM4Xab7qQfl/wRxBCr1fgzqCbvzl8mZ
	vOZaCC8FV3weGf6MDrbJ3wqSNBf75WhulrJpNAnHLHXPy45xdq6515mqBhXPY/IBxMHllI3pEDv
	5gFp8GDx8+PY0PezhJQeO3j+VsqTqpmciA5oO1/onHy3MXtjvtPTyrk/T6lKNbTqnx1U3xuerPC
	0iiTMc0GtilvC1X9LGYsixcBtT3K4k1q/hu67fyrJIuAfMshQPSr6a5LUdlgO3CCP7aLgus9gs5
	MYJDXN1TkMm4xEZpJteAdQhHj9WOGkHRQ0K45w4rdXFU/qRzCd8cPlQNcAlcHcDolcy77CJZhOx
	i+eZCWZSxGxK2Y57hhPnrNBQLCtd8MjFYltBK3n8twf3YyxUoMVh3hi/fhKCAdvYFQxWuOawyuk
	gh1Ir3WF1pT2UumAhvow4=
X-Google-Smtp-Source: AGHT+IH4EhVoqYoTbW8cYWDiUID1BS7rnxsPGKrbnyydJAA2t10EkE4eohbrK83caN5GEcZLC7ZMyg==
X-Received: by 2002:a17:903:144e:b0:27d:69de:edd3 with SMTP id d9443c01a7336-28e7f2a2aa3mr9555435ad.20.1759259891002;
        Tue, 30 Sep 2025 12:18:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671738esm167446725ad.46.2025.09.30.12.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 12:18:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7c481b23-d623-4fc8-9b31-78db6d1f7245@roeck-us.net>
Date: Tue, 30 Sep 2025 12:18:08 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/89] 6.12.50-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250930143821.852512002@linuxfoundation.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250930143821.852512002@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 07:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.50 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
> 

s390:allmodconfig:
parisc:allmodconfig:

drivers/gpu/drm/i915/display/intel_backlight.c: In function 'scale':
././include/linux/compiler_types.h:536:45: error:
	call to '__compiletime_assert_666' declared with attribute error: clamp() low limit source_min greater than high limit source_max
include/linux/compiler_types.h:517:25: note: in definition of macro '__compiletime_assert'
   517 |                         prefix ## suffix();                             \
       |                         ^~~~~~
include/linux/compiler_types.h:536:9: note: in expansion of macro '_compiletime_assert'
   536 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
       |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
       |                                     ^~~~~~~~~~~~~~~~~~
include/linux/minmax.h:188:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
   188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),                            \
       |         ^~~~~~~~~~~~~~~~
include/linux/minmax.h:195:9: note: in expansion of macro '__clamp_once'
   195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
       |         ^~~~~~~~~~~~
include/linux/minmax.h:206:28: note: in expansion of macro '__careful_clamp'
   206 | #define clamp(val, lo, hi) __careful_clamp(__auto_type, val, lo, hi)
       |                            ^~~~~~~~~~~~~~~
drivers/gpu/drm/i915/display/intel_backlight.c:47:22: note: in expansion of macro 'clamp'
    47 |         source_val = clamp(source_val, source_min, source_max);

This is exposed by the minmax patch series, as with 6.12.49.

Fixed upstream with commit 6f7150741584 ("drm/i915/backlight: Return immediately
when scale() finds invalid parameters"). This patch also includes an explanation
of what exactly happens (and thanks again to Linus for the analysis).

Guenter


