Return-Path: <stable+bounces-128340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C76AA7C203
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 19:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1DF179643
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 17:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1F220E339;
	Fri,  4 Apr 2025 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSbwa2QH"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169A6209673;
	Fri,  4 Apr 2025 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743786071; cv=none; b=TQRsV61fV12eqReKIe7r0uAaWvDK6Qzide3MV0RCZQdqQ5qacqugocOAMqqIjhRBu7BOAKJDkD56Wz1FCx+GqF7bR7XxIle8bqbg47yDC1qydG6qDLV79ZSQgAwFDZfzt+0c5d5XG/q3cJNOvoBsQPz88s2eY2zoqOXNcxTs/Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743786071; c=relaxed/simple;
	bh=Eey/maLP5t3GfmoMy7Epfg/3yPZrQ3AoX73XYqCw1II=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bMsuygGukgqpFOLK6pOQdJMF4GxcS5+R+TG3arOZ6aZ7zNOzlbdoLzNY/wbxxYg2JJiyuSNN2+Kjw1dIzM4ObV2ykwyXFeT13rLAMb8RInToFgi8dHwMakVODkE+/PWbXeAIvcCWbLC6oN8hcqAyN1TNumg3kf0VmDpLjRP10NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSbwa2QH; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-601ff283d70so647422eaf.3;
        Fri, 04 Apr 2025 10:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743786069; x=1744390869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JksFRRTKNUNfylutjBDAGCEzbkNldEBZJuwSZCc1wT8=;
        b=nSbwa2QHy31sKb0DyLxelbQsXulPV2P1s8TIMgdSwZvzM/bZxAXiPFBrj7/XUyEavl
         w/0i11k6d+DC4Hb/6rjt4fHyGv/dacinlF0VZweeEfNulZ+8nOFli1SlLPCZaG8gmRTV
         f/g5uDablnuwwzgCE+h0pir7RGYe2sOSUQPLMlqZFwBTYn5R0Sf0iGFr0l3m+rHEoJDE
         r40BDx8gB3BnLQ/rVn65se6ioE8hu0b/lW4gCKyBmYWANSg5UW44ObW6lPqRWqdSYmLr
         E+YmnEDKwaoz8xo/qu9t5GBPN8wL/BxJ8ErNwIB2dmfuJbLfyqaagGXkwH7vSbM6pSh7
         Zg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743786069; x=1744390869;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JksFRRTKNUNfylutjBDAGCEzbkNldEBZJuwSZCc1wT8=;
        b=bbDJjhxvpVo6Pe7g9UiA22oeo6lBX2iUzdfAw58SId8DSEuLv2uIxd/rhduvOd9tR9
         J8NVJnSp57nekFRBzPVzBGYazr1wSYdZ332vjVqT33k6LViRd2RHeNu53khI57D0GhUJ
         PvOV4sIG/qQoVDhK4SNI23LdMdzVCNU5FMOWKdsAqYte4Jg2tu3I9ZsYpwNX0WzbaNVm
         yZ8gwhoutaWEkL5PbBbkYrqECiGkQWxosnnrTnns5S7N9PzS3xQg0k9u48YlMx2C/4OO
         hbSmu3RmNxb+Bl6LAn8YZzCGEmxs5v/7yGKkGU+wRhceFYNkdhnlGUUpX5tduo9djAlK
         xk5g==
X-Forwarded-Encrypted: i=1; AJvYcCVcwjKMUJf+N33wXfjPqGiHPP0FpzLnniw4g55Lf8bhUZApB/qKQe895h6tJgtCLFXwp2bwgp/28vTiOvo=@vger.kernel.org, AJvYcCWEYX/szEnsfmZAKye2brrsG4Pb1D9fbWLkHv8/aDuAsLTlj7yGj7droRfNyRlaNiKAFenGZvvz@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9+MhYQaZRqA5FagWWSmsFrxYfx5Djk6d9twNcbQ7IJrROJe+c
	ujG/Na/jb7x0FprOfY4jTTbqCSo2YrtjnR08emVi5gsCj5x1E75l
X-Gm-Gg: ASbGncs7MPaBepbPqGdXlR+D+nUcmNOZvVle6alQpf6NoUChNWWUm9m/pBEKNV/NVR6
	E9jHctIQN5vzaQF/eaBjEc3Fg9knEIf4cv7uUe4x+NGk7zr+EDpY0tgfRrjbi9dZ2tY49beUeKW
	TV5INVKQWqXsuyzYDvZe1BE33Zn8UPLUKAx5S0DB2X8cwFfESPXU5BlbWPI41bB6iBztjQgOwas
	7cxxl31+Lh+AkTtDdEfpLLN8XJOhCVzHayyC+Wzm2NtTaCMi3lXPyts4LwL332bH9+sscy/tNav
	LuqCYC2RQgx5DlGyihM30tnGdjSvpy37JutOPn6bcRIgNb6gA/ULUJy6YnxJpdUSVlnDpqj0
X-Google-Smtp-Source: AGHT+IEEV78mhJS4Zh/Uy4Aa3TIaZb9tAPCVkb9g+HYyAtDg1fY5c490dSQeRm+stMXN2Up3i0EfXg==
X-Received: by 2002:a05:6871:418e:b0:2c1:461f:309a with SMTP id 586e51a60fabf-2cca18c7d0fmr1962290fac.8.1743786069034;
        Fri, 04 Apr 2025 10:01:09 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2cc845c99f9sm793344fac.16.2025.04.04.10.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 10:01:08 -0700 (PDT)
Message-ID: <5cae82be-7244-43f3-a009-045580087f08@gmail.com>
Date: Fri, 4 Apr 2025 10:01:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 00/21] 6.14.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250403151621.130541515@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250403151621.130541515@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/25 08:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.1 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 05 Apr 2025 15:16:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
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

