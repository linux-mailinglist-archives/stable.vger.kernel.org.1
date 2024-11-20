Return-Path: <stable+bounces-94456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F07F9D4207
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 19:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA84628212F
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 18:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFE2156678;
	Wed, 20 Nov 2024 18:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0Si0HbV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C3515624B;
	Wed, 20 Nov 2024 18:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732127511; cv=none; b=Y9EtKQJl4NQquHEo5nrHoxVlfychlRrOflJdcTHcgHk/Qysfc+gnCK6k5RjeV69HFbmhHvVOSfaZ+e32Y/Ut4JTes3i9bopojayewAjCOYiDmxF1RMyM+b7IL3OVxFN9/MajvrWOwNxLTmRKrBH4mCSQigVf1HqWTh/EudrJ4Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732127511; c=relaxed/simple;
	bh=QNS4lSvfBWWqq1i3XLVkcPtBNR3R8zpSyGyogyLolnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRQ3ZX14esinvrt6Fc95mfe8jIrjK2rCHZmH4+I+nJlwWktBomrwvzjwjVCx3eIJBny/Z3sO/Z4jHVsFPWkq8qOEqytGun8aF4s4WDU3jup/eirQWAIOGZCDJW8f40CYE5vyZyfguKAxaBhVO99OY5WyQOH6tqx2a0A6LU+aMao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0Si0HbV; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cb7139d9dso27895ad.1;
        Wed, 20 Nov 2024 10:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732127509; x=1732732309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vi2Asc5tiE3ZC85vvprYqDSKCa7e2QNRx9pZ/BNs+GA=;
        b=L0Si0HbV9ag1CU+arz+000+4eOFC9XEq9ytJ6IhbPMKazvI8r1JFPN1yhK69Yzi58d
         8l99WzGsKit6TBHnusAUPeLtbyUl/1tWXhBgU3rHi0dgrmXp4xUQSTYQ3VzT0rVHLnPd
         1CYPqsoWOhyaIYdRjwNgaYZmkyusc242En9YAJhUgdJrTuE5Nd21WY9tjXzpST0m4x4T
         oAdwS66Dnv8aQRwQxCn7coO8E0Ln0dmU6rxwiC55j2mC2YjjcNA6DNqVjECB/qzUj/JB
         B9m6UcGeVs9JtNZtRDeSufXPJFZSe4tDHFvcpAA8sT+aWl9ltsFNfSRSIaKSGxs+CPgf
         iyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732127509; x=1732732309;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vi2Asc5tiE3ZC85vvprYqDSKCa7e2QNRx9pZ/BNs+GA=;
        b=MRt+PmV1YTO32Gt/y3gH2KyTzuTGOPRM8CQzVoNKAgic6SKnp9mTOLEO8SkxPMnl85
         YrUAmNci0gZLjrftJGhe+fExTL5gFokP4QS4wyOHoJafucEUpUkZ5ur37idDwRaxLFw7
         CO4Vpg437W0PNwBU+Ma6bLQUwgKaVwJ1QpI7eNlWMZHxdU38YmHcqImSDClilotjDHSh
         vom+fWjMvqdcxCH9TCQtZPCWaSoy/pa8qt26pg+925vPrNFxiS4qQrL9UxFS0sXWH+DR
         lzwYckMPzrmqlngRXU+EGK2B9cdnPz8esyTCtxUAg/tjSGuTX/589Sd664W6+hNGINhE
         uHrA==
X-Forwarded-Encrypted: i=1; AJvYcCVLaK036IHg5mf4RZXaOg2yPcYpHGI9a73CeUL9rk82rhwyO3B8R/tckWW5qe2McGS0agffSBXs07fK204=@vger.kernel.org, AJvYcCWu5eePE4mS66VSABcAJBLt5SmIsciUIGah36QokNJnDqpmyWSd9zSoxc8OD9A9hdiA2HZTRrJB@vger.kernel.org
X-Gm-Message-State: AOJu0YwwwunvZlFgrAjhZCBmIzgVskHJQz1Q/8l+UXyNghnHpUXhiJak
	rsRVnfI77qWuF+RXTWRZxhvi6GcDtN9EOXEqRHYgysLK4KL7TQzR
X-Gm-Gg: ASbGnctN7o0fasIfNaikN2RpKemc86yygkKaLMrBO3y5YSRNdOxnr01+fLhB30+czJS
	gwsa8xgcYLpX5YWicGI9bhxYjBQ8R7vojNOB+EHFcysv0QosBwuakilxiI7lwKpfTJOp2lVas/6
	w8MtqDnrUtK8ebCwEaUlsT6KgaInUPKSQv/0sakNzlfMeRRl6z04T7f51TzEzb+CtX7BfQH1MPS
	q2ALGhCWZzWf6fbL+nNGB4MAqfv+C9/ceuXNlCavepx3XHrD8lvl+PwhNaF8R0R5368+v9YJ7HX
	Lw==
X-Google-Smtp-Source: AGHT+IEEjAvpZrjFNcybgsbVsok5/gtAHY0qcB/V8mRebZm7XF4GSSuv4ziu8QW4DBkhBh6Ckp31KQ==
X-Received: by 2002:a17:902:ce08:b0:211:9316:da12 with SMTP id d9443c01a7336-2126a3a43ccmr48345165ad.22.1732127508871;
        Wed, 20 Nov 2024 10:31:48 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2120c9a1579sm64803835ad.139.2024.11.20.10.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 10:31:48 -0800 (PST)
Message-ID: <ca410ddc-cae0-490b-9112-319dbcf52480@gmail.com>
Date: Wed, 20 Nov 2024 10:31:46 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/73] 6.1.119-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241120125809.623237564@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20241120125809.623237564@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/24 04:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.119 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Nov 2024 12:57:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.119-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

