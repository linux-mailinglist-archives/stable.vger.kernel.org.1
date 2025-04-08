Return-Path: <stable+bounces-131864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC8DA818E7
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 00:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D523E4C050E
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 22:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9B92550D0;
	Tue,  8 Apr 2025 22:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrAI89DS"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42D121CC47;
	Tue,  8 Apr 2025 22:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744152172; cv=none; b=X3m89mWrBg8L3nZYCyaonRiCiUoxvEs+a/PYRdc9zBKKHl0ca3TBnIxInzvuTQgUIMEn/r9PJEBVuZ4uK9K5eQrVkUEh6cPeTRYT2HLuHfiOwmTbSNvA8Y4p1oQsG+0AW+H6yQMMkodIIjINbFHNvcWzlVY754dcsWbHYfsJnCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744152172; c=relaxed/simple;
	bh=MMGyFU0ai24R96XUwEZvzI7AeGg0t6okiIIxZ7vICuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQTHjh1dXIoj1zS30Hel1mrDKtgA80daHaGAoYnsSR8ib2Oh2ylr0l9SBYyWSP+tLIbWuravyw6Uaf+hVN3MkFHupNlwJ0jj7jyLOQn2Me2zAFMGlt1LRWPavH9FpEfI8WoJBncExjbNiQtprqLPtaqOJ8OA1k/8n44xH91er6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrAI89DS; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-60219d9812bso1721370eaf.0;
        Tue, 08 Apr 2025 15:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744152169; x=1744756969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jC2t8OsWOeSzLz0xuFwhCnvAxOOMlUaiN6NqG4eYHEw=;
        b=UrAI89DSmCvLtsezzWRH3cf/dyR0DVOVvTeo40CcqZPxWhoj6K+nxzUW/EKKvV/If6
         ymZ3vO/s04/psk+azv6Y+gknQ4DHm6kzbMqtZJf6zRVBJ1dsFIxL0LJiiyncg2XHmxS+
         FLRqKl0ryU0A1EJe0G9O+WOKf0LCblWsyuYpLu8A10irOC8peZ6u4ExBo88g7ue1hMKo
         Bzt7hlRKX5CiG0anKZ/QzErqEDu6KEdgG1z5wHh+Yw9XQIIRz50c0g5TbWaNvbZCmAsD
         ta2FQviGPgLR+6rPYUtmtahKKKRDStpKm1Jxsvu1XQYPh/8mIiX71uexeBQghnI+cwEA
         Oz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744152169; x=1744756969;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jC2t8OsWOeSzLz0xuFwhCnvAxOOMlUaiN6NqG4eYHEw=;
        b=iKBQXVYJX0K/6dKOEXGfzhVfyaVT4txHna/qwlzLOEecvLEhi3Z9wEV7DdRRa4O5s9
         D+xn8hzWYKCWk40q4J0e3ioPtSItqcTaR4nPnFmVYOzL2oWm8LAHhGF/WF1dgZey67Vz
         67NFf/kkv186iTP7dZX3LOc7Wg66nZLs+PrrDJ/piPjcjiWKhlrLRZZSfHbmYAGN3kDj
         dvvcKh7yZ1//42+LK4NgV4xUXnmu+xHBg6kqUCtZaKdqord+7pRKXvRyXLOxT6UuraZ6
         NjicrF+QVVbVPx+0hSRRcsfsbwPRcgDzCULURyrsV5uJAeSI1/nomBNXtHIie4GYkd6Z
         cDRg==
X-Forwarded-Encrypted: i=1; AJvYcCV+OpHh3ojVoWnOyJoweUEXhKO5UeFHsndd01IZdwXylIsTShI/8wjTnAENKKloI0UP4ma2V2FX@vger.kernel.org, AJvYcCWUZ4J2Au+zvZ8fgB3e6sK/tYh1Jk4DBmvQt3rolQ5dq1P0dtKaKc7tZS7Izqp/u/J9xM0D3UQgPuhIb/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6OdbkEfL8dWSIxFwssO3fyM4q36tCqN40NXDKEmMwicPmuBaO
	CFUIO8u+d7L1N5kAoeZmynHyDQ1bhw+5ahQuckV4ZGNdXITHI1zw
X-Gm-Gg: ASbGncuRb5cDQtqAfmkyr4szvl51vf7+P56vXb3eCxMkWifqIMtq0e7ypBCuCgeK/Yk
	IzCDR69814tTP38GMK2ZRTR0fPqRlWOeJK7MPklUeXPEoHHP+STTj1OjkfiDnxTktxtUXlB3MId
	wP/pX6ijajBM2uBO7t7/TbOIhPE6G+3h7TlAehCklg/XbFeAhrfzYMWU4GhhePjSjv1g6GAAKz5
	1sT3pFv0nUjEqLQcjw7AQ35ds1jvjBDZCqBgAt6SY/kqgS2vhXcdRjFTwyG1r4mybVtCJEoEEs7
	02IX3wQsrnphYb7R5NcygfKduukpFDhXb2eY3lG+RLDfwwoKxgSPEW31ExZfvVVYrjhI0H8t
X-Google-Smtp-Source: AGHT+IH3fGo7fEnnX1/uos1Q9JygvkVOfmqlmjmpV6JzDUYYBb7akW9C+GUHLtLthwCeqF9qLNhXig==
X-Received: by 2002:a05:6871:aa11:b0:2c7:6f57:3645 with SMTP id 586e51a60fabf-2d08dde79e5mr430138fac.18.1744152169494;
        Tue, 08 Apr 2025 15:42:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d0930cefa3sm20333fac.14.2025.04.08.15.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 15:42:48 -0700 (PDT)
Message-ID: <82d02940-cce1-4cf5-874c-cc998e151b66@gmail.com>
Date: Tue, 8 Apr 2025 15:42:46 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/423] 6.12.23-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250408154121.378213016@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250408154121.378213016@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/25 08:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.23 release.
> There are 423 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Apr 2025 15:40:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.23-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

