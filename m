Return-Path: <stable+bounces-200183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42480CA8B58
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 18:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01C28300A9E1
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 17:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C81C2DEA70;
	Fri,  5 Dec 2025 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+2TeGC8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC8227A12B
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764957388; cv=none; b=hzkd6RGVzRjQGiFWurkgeSiqc53jbIcqKtsG0sRjmt9XQtmxBkw5P3+cxGCPm3Ef2JMo9UG2KkTIz08GdyWz4D7vOgZ2ePYyZ3i8D3Z1PfkGYFVvtVvVub9o2/lFzifwAo/lstB07l40Js9lYjz/ESsvTWPh6wCGp5V63t4+sAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764957388; c=relaxed/simple;
	bh=bmISz4wUHFCj2fNIPw8dlmlYdcyJ4m7YE6ev17DazPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QcEptuenhLeCyFjtvTOSwXi4e6FvegFMlnjO/7u3oNeD+s5CeB7xRU3THaAXKysn55OLk8WR8t05XqNHR84BScaSMpuO6nHuxMCFD8o1uWZo+UnFxeI830bmEZz6S35wX0BBEwY8wJNR7B/3+GvGIzDuXnbXsRuPYQfpjmo7gIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+2TeGC8; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42e2b78d45bso1153509f8f.0
        for <stable@vger.kernel.org>; Fri, 05 Dec 2025 09:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764957385; x=1765562185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kEgKo/l9HOuNeryVXSYMwjnWbEw58DLyjo3pfWvSHQE=;
        b=m+2TeGC8N9cllUvoblUUVMH3gaD0e298rjQi8yhxwcbAuP2EXSoQaT9rgpQKqoJ1v6
         eOxBcmnqh1deYPk5q1YLO+zzS7QG/nsxbBreGyyfekd12VTIcOGuyPaNe8K4+Ar78dpg
         iKZch7mJ/N6l7OO5vWPz4Afc48gBWEC5lnLFk+OIu96I803YdYIO5mUOfTcLvjGtkuld
         MHMWU4Rv6MCcy22rRPXXzAqeD/Szq5XNNci7VcCHFkjQadX31wsWm6Cx0lQ9hLdNFtO6
         FEsjGTvBG7TD85nd1ivEv69j/G595A6S6PenBrJ4x/ImvH67/HfMrTGYMahRzmtJpWyJ
         YUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764957385; x=1765562185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kEgKo/l9HOuNeryVXSYMwjnWbEw58DLyjo3pfWvSHQE=;
        b=T6/a6fe2r+sXfMSTgj/TVRqW1Agwz1BvMcy+jHamEKNJVkqMjJwgvqeOD0IpztgiVR
         UxLrt5eMO1FAjEJV2PXtNrAaSroARlXPccAF8DGuDqMR8FaIVlGj8tQBC7xYCvvs+OC2
         G2q3CBhmcuSGCi1MPJBWlc2lUCJ6K605LYoYGTjJgsR6GredJRPPc35fpG1PLGXQUkYl
         4wV+Kq3kEiDOdLEdgKxkBaVecRjIoNOdSmSWrXPTNreVcf6+JiIOFtmCNT7Sop1JUt0I
         c4ooVp7UEln6mVDZUUEX6vnQbfg52IXZA1cy/udb72mY6Y6uJHnQpvULasmkg64Mm7V0
         A19A==
X-Forwarded-Encrypted: i=1; AJvYcCVlbnjjiGwLHdszTtZwBQXkgUt88SqLukhqlB8EKsFs+1+xI3yXisHXneyEru7P5+EHPM/QXtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIKem0tdVrbs3syI8B+0m2+YLJWAUl3vYwbcjbI7BT8QP2HZc6
	x7McedU9iWPiyD8TY2Fcm18IHAhmx2U1Awa4GIv1zhBkO3OXi3wu1YJZ
X-Gm-Gg: ASbGncu82uirKFqIlstjviAqIBqx0sTdFoWh4r19IQTOdyMmNqUEPfAWVcrAB2FQAwI
	iYsQYejl67tZDJ+WAUpTm8smIRNlX/N12Lg1uQlSGxKx894IRyOIkO0/Kz1q1nfUAdCLds1SGqA
	frwjjA4s0g8Dyrhy4TZYVkG0kE1iYlYlDp6iWooNiR+P7kvoJtvXgb43w70mZa3RjU6D0FtAo8q
	UdmmKqMSaIPW0+rAj9YO4ycxxY2YCFIjdCuXy1xKdJDypWyx5XTNnFNapcTksecim7jry8oBQWw
	sOxQ+p3olqifWzNRdu2+YBgqJJsvGHGAhnTytdGcFa2cfi4km4Xa3x6dwvG3mOWHgCkTZqnb74v
	JV7BaSrSPo0+nZ7tg50TTtVuF9jj0kGXWbjjZQ4u3tj6JbJ5b+IDIfsmsfktgWx7Dt3/LWnkvTw
	ccswtM1t8Mu/KVAmOnufqvZWxGKSXztq7fQDqcdd0yaI6TMzFb
X-Google-Smtp-Source: AGHT+IENm9zx8V7Tz0VXVGQhR9hdKMItPaS3QDNcTYQiQgg6kiMV16jXfg5TmA44Yga6DhrQU/Zk5w==
X-Received: by 2002:a05:6000:22c9:b0:42b:30d4:e3f0 with SMTP id ffacd0b85a97d-42f89f0e237mr49229f8f.22.1764957384592;
        Fri, 05 Dec 2025 09:56:24 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d353be1sm9479087f8f.39.2025.12.05.09.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 09:56:22 -0800 (PST)
Message-ID: <198f8eb4-18a9-414b-bcec-fe44ea508e58@gmail.com>
Date: Fri, 5 Dec 2025 09:56:17 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/567] 6.1.159-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251204163841.693429967@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251204163841.693429967@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/25 08:44, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.159 release.
> There are 567 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 06 Dec 2025 16:37:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.159-rc2.gz
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

