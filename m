Return-Path: <stable+bounces-69367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17811955399
	for <lists+stable@lfdr.de>; Sat, 17 Aug 2024 01:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD9C1C21D2B
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 23:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1783C1482E6;
	Fri, 16 Aug 2024 23:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LynGNGhl"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E07A146D45;
	Fri, 16 Aug 2024 23:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723849362; cv=none; b=kJRikUB7MkaYPROeZprZHvZYJIc+J3dNZW9rw4GQB8QGVHwR4sC5/5WY4Mux6TcHbi/oJPP0r+siedqmqWt5I8zkQRmAWkYiQkq+OdCdl2CSZSV1SqwYTBrt1pWugdsUD6T5pep7HjUk4XNbsj+SCvZgH1dczJzFdHjmo2AouQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723849362; c=relaxed/simple;
	bh=psHNo8QoRwpPrz4+9QQcykcs3VY8ieDSbYRlAPUJTAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XhjYzEmlRjdTbZzTTMfWbkL4IEOg6uGJt7SD+vgrtqQmtc31w96UdgKtt3ThJKQgaClTod18ExWvC+1tvEoH2NC/5n51x5ZswZmWuj9Jl8X8b4VgI+ofFQV1xQgNKMD1dbRB0CtGEY6tFVWXx0lnP10nbCd0nb15zrcit2qQYEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LynGNGhl; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6bf7707dbb6so16444236d6.0;
        Fri, 16 Aug 2024 16:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723849359; x=1724454159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DXeUef4pwUJCviTKsFgKHcdSlWgkeHOfkWAHMZvvM70=;
        b=LynGNGhlGDmMhLT3qnhTzCapNBbSWzzs2gU4TKUdMHqIrTdvdPQU4iuMbJQjnGMRBt
         hxHjS6CWZ1LS8sMK77chz5Xfrr7oQCl0qOoCokUJxER5V9XPQHvEE0A7BMy6b1wCeo/r
         xphbfm+BY4UpjPieFcyRdG3GJ6vOaUAMELoBAx7aQqtaxZUMGQdmpCTZasHEffdRyzHB
         N9OP/NEllWT/aOd9+ljlrlofaJRf+JiQ5a1fYNmLX1OWyL23azxa4QgNoU8jeHtPdkFv
         mwj5G9LbvvOQ5I0EL7EKTN8A8GxgSoQu+yyfDqIMzYGXphbaZ1oIy4kJNiCc9ugbmqw8
         rzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723849359; x=1724454159;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DXeUef4pwUJCviTKsFgKHcdSlWgkeHOfkWAHMZvvM70=;
        b=tfFpCuIk5TWU2oLF5xd/6oTGCjG1rJrGisNCIfBEybkg1y81j+HxQzrM5rnHgvPP64
         OrvYNUNAS5yNVcdQFYAsXoQkluCQ27/iPg1JM2BptG8QAln3vvADaLgYTyqbsiynN17D
         063f1+D1aVmZw7btLIBCo9uT3sgESGs7Ej4L/3pcrANXI9HeeTX1/Nb67yKt55cR7RqG
         S/udazN/wXAqpaaGZ7txrlLkUJsleIkZ7LEQK8yaEHyI0JbqOIgfYqGKE+6CAjqB+k9E
         mOdAc2vhiNvxNskhld8Z7xg2HHLvMj55MuixEfy6NHYxH+ps8z5eqVrPXvpER5PHemnr
         Xbwg==
X-Forwarded-Encrypted: i=1; AJvYcCWtIQAjxh+xBz75sQHYhn4Yt8amklogGNfCRaBwg8fJ9W9EVNMl7O6hfUEoTadWEC+N56OEdaiybpsLSOw=@vger.kernel.org, AJvYcCXMzXuANXWfIGhlBAWkUo4wgZF+lWd538bGxtni+k/4bO1tp/HdqlEzBsnvGIvWNh8prStgz3f/@vger.kernel.org
X-Gm-Message-State: AOJu0YyYb4gd69mnFcDMyM8uWMkakJ80yj8lMz8pLDzE5o8wBtu73Zln
	Ol2iA4AuH7VWhSbrgEWB/7vmtKW0XRw5UQYnN1YKJ8xpQRVxmDeR
X-Google-Smtp-Source: AGHT+IHpH6p4F+lu5E8z5j/cQRTdIlpEuUxrF8Oe6HHWv27/V2l9lWxwjQZgoT5QSzAXVf47Q+jV5w==
X-Received: by 2002:a0c:f40d:0:b0:6b5:2f57:1a63 with SMTP id 6a1803df08f44-6bf7d5b11c0mr72745466d6.21.1723849358814;
        Fri, 16 Aug 2024 16:02:38 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6bf6fef7079sm22479926d6.126.2024.08.16.16.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 16:02:37 -0700 (PDT)
Message-ID: <f0aae4e7-80f3-492a-a43d-aa8c3929c20b@gmail.com>
Date: Fri, 16 Aug 2024 16:02:34 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/255] 5.4.282-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240816095317.548866608@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240816095317.548866608@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/16/24 03:14, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.282 release.
> There are 255 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 18 Aug 2024 09:52:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.282-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernel, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


