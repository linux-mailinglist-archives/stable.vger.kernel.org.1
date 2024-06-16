Return-Path: <stable+bounces-52323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207E2909D8E
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 14:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF961C217E6
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 12:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44961188CBA;
	Sun, 16 Jun 2024 12:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Me020fn6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B470E16C6AF;
	Sun, 16 Jun 2024 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718542367; cv=none; b=VVv9snDJZGnEvhw7xpgovZg6e77Gjld3wPDBDMYr+rO1qszAFuQjL4De/Ch3Ro6yvdUfsU1eYHdP+B4yuvufBnKw+I/7+cRQ4UycWoFA5vch7fA8zBRIX3Lvo+FBtLy3DGvM5FRp4e4rPldhIz3AAH082wh21nf0e5kE4XjULu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718542367; c=relaxed/simple;
	bh=0eE3zOyxXXJtLszGNLf4NPbc7xSbHicxoSYbuaLkyYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ipAGaBC5jKRmMH+JPEFlWQfDed70NM0YYqvF1dEMbFNG6ExA1KtIrE9xEqEFWNyGZ5k+dypovtsleLIVlf+vNP7iAgoYLuNZ6cLZecCAPSplXyNadwbdYWbeSNmH82uwljVHvGmPLcGpM6tlBt8cQq72uTgeukmYnunOGcC+lDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Me020fn6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f4a5344ec7so25313065ad.1;
        Sun, 16 Jun 2024 05:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718542365; x=1719147165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CC7zgLLtC8RLVpAcdWgmzc0wTBFL/MViDNIaGHGnN1o=;
        b=Me020fn61jyCxpCujEIRO0ozQ/7/mwfBESGD5SVVKRop9bocraEPeiX3KyurOew+R1
         fVyp2bsCYjYhze8KETf6hnq64nXXW1+knU+mTlQRQLOQgrfjIrBgIU/yH1ovJidMN8mW
         NPgG+IYxX9wL681AEaL3upE9+3yNF4Qwgd0veEjSEUW5xQ7YDj8E0MspL2G9dlI4XSgK
         DItNCgc6SE0plQ1t6OVor8yxLkgKjx4Q3ZdmqsKOfpElUWVIbTrfXgN/9FTNjMBg0K5x
         TrnzVWZaqg2CZ7r2Bm84qW8lzjykXSciDy/KXdE3JZtXCTVW23j+funjGEDgDPONnSF8
         8ZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718542365; x=1719147165;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CC7zgLLtC8RLVpAcdWgmzc0wTBFL/MViDNIaGHGnN1o=;
        b=v//sNKOZ4IQ9Jiiuos6BRh+JTO3uFtyZEWAPENBZ/2kVAXNxH9lgIkjSYpAur4lKlv
         h7D6Yh+qETPgjQNj+eZ/X4kUbWPppl6iX9lYpEsBiqduXGUMoxuOsKNw4TfRt9Pf3vFZ
         1WKBDyNre4/C/+tAu8e6NJf6ZOaEgKQxd3zWnzMB2C+6SD8gTcd922UcnTPlnJEvamno
         E+8NLgk9SFOinnjBvwPHee2k/CrNubkm6LBnSNv6GHx3QsPtION4EaefxHoaP2NlDsQI
         rF2zSO3dG9T7hf1ygEEoyO5fBmxhy45GMXpPteLQF1sYbyW1Swg0My0AU+JOt402zU8W
         Mfnw==
X-Forwarded-Encrypted: i=1; AJvYcCVUT2aeLnlj0/1LXAT1MTQzMCc2lDfGRvJ0q5Ulru+TEmc4G2EuQTaja9lyiSYosFMFzXFjd5337BA/enOme7lNSheMIL4CYkVHpbatJEHeQJzP3gT461L2XJlCuBSPbn20LoCs
X-Gm-Message-State: AOJu0YyyIrJVwN2rgqFxQNMaInY2mUHgT5gNDK0DYKs6j8MFyLrmsE72
	Om5bI8SDuV+fEC6XHexJMsdueiERQ2Jfinsvhy7PWzzJj8Ajul3/
X-Google-Smtp-Source: AGHT+IHv8Kh+K8T89kuupMq/Yvm64OxabRHqUQTZTdguj7CUQapcSOipTEoY5qP2As7xbUi8gfkpGg==
X-Received: by 2002:a17:903:1246:b0:1f6:e338:2a6 with SMTP id d9443c01a7336-1f8622ff5f3mr111784365ad.23.1718542364810;
        Sun, 16 Jun 2024 05:52:44 -0700 (PDT)
Received: from [192.168.1.114] ([196.64.245.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f1ac4bsm63260875ad.227.2024.06.16.05.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jun 2024 05:52:44 -0700 (PDT)
Message-ID: <7033e8ac-2732-4f38-b03a-12d9f88dfb5c@gmail.com>
Date: Sun, 16 Jun 2024 13:52:34 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/317] 5.10.219-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240613113247.525431100@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240613113247.525431100@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/13/2024 12:30 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.219 release.
> There are 317 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.219-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Seeing the same perf build failure already reported by Harshit aginst 5.15:

In file included from util/cache.h:7,
                  from builtin-annotate.c:13:
util/../ui/ui.h:5:10: fatal error: ../util/mutex.h: No such file or 
directory
     5 | #include "../util/mutex.h"
       |          ^~~~~~~~~~~~~~~~~
compilation terminated.

Thanks!
-- 
Florian

