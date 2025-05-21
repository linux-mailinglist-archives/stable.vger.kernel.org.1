Return-Path: <stable+bounces-145845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C5CABF7BE
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 16:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4DA14E38F2
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E0F1A3156;
	Wed, 21 May 2025 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PPGbrU2n"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C62919E97C;
	Wed, 21 May 2025 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747837394; cv=none; b=jQed4QGwtElFNgpuBv2L3sU3a/M5sUaVRXlhYCFUfBv2KdMxGAbA6yXEz4o8C7f7RTl0h6N5e9ibEkf5BIcCkXGGE7sd/rqPLTm3YA17z6n5sUqax9k6jbXDANynKH2hnlZbP+5R/FNk9slTcsga/sB3zeGNhNRCufiC2cMYuyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747837394; c=relaxed/simple;
	bh=iHhskWt3REXPFQt3U4rsyEt/YNK9o488HeapSlwvdTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HN0m+11Qm55bsz4am2VGeYNE9Edg/YYnFw6s5xpEyo+bMk99lIdPJc5mn/2UI1k8El51jzdefgZTZwR/vDvplXh4nXFNY+/j8Tyf6ZyjwgaNGx5tn+hjrztBmRM4g9v5oyXtdASZEZ+pDggyzKcmz+Avy8fJOT9d3bYvNmClAWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=PPGbrU2n; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so74354705e9.1;
        Wed, 21 May 2025 07:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1747837391; x=1748442191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hJdrh3L1t2pXOV+bbYlaC+xr2LBJsGiRXUAwh3/gxE0=;
        b=PPGbrU2n4PEYb4T7Kf9dCzMFqtMg1J8qPHnzhk0O+XG/ANGXBa3DMLduCa28cbEsYZ
         lBIgiWBQz6oymU46lpeIkv+zOC5awETTDT9bUCYAkgNqJ8/pVdg/jO2tUpK5AoWD9J0f
         f6clK4nVZjbytrQ1BYlBlvkZY6ygeFI2RJ8B8vDbd/W0qo4bIG5iS5nf9I9Ezz+QS0GB
         0AXwO40j+YYe9zmbvE6vkrS3Iiwpb94SOX4zToxYKX2wjPJSMS0Q9G/jebRHF4tIA1Nb
         8rWbUuaT+XXeCOQidPwO6uaIRlNehJ4QYVuypXNtdcslYSRf96SP876vZnxW9L/ewguq
         haQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747837391; x=1748442191;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hJdrh3L1t2pXOV+bbYlaC+xr2LBJsGiRXUAwh3/gxE0=;
        b=vzgGJmGZhG0DGr0Z3hvPqlCIs+4NquEVIK4KAAkICr4FuNvv9eDKNuVA/eCjRmydsK
         SyhVDRZrIsGSBZ/OeVv5ztX1ro0MG9K94qGhrU3X4TZ+dvgIdZn+o1+tZp2updBWb/z0
         YrLptN0ajkv3WGfMHUURHgA/qwKwaoA995bho9PnjRm6vGEuYY5h4ZOX2/+xrCZWkzsx
         VMka26m2U0KYLyyHzKdfhIYSXmcYb571MGbtqWiZwyqHZYxZRYCtP39bDCmJO+1GoChE
         BNycr+/LEwFvVCgHBUudiUR7NhiZ9TMBGvcSAFj/IgdpuS9w9w4TrJrYuvDMBoFn/+Ow
         Fd3w==
X-Forwarded-Encrypted: i=1; AJvYcCWIGiHLYuXMBCZfLko6RWm8dOw/VmaIlwdFPDr9+/Qqnrf8eTVpZvLw9GxWgmZMsekoyOtvJZ2mjdQ5eis=@vger.kernel.org, AJvYcCWOna0JGKjvhElHIa+kYAELnBRkUYZmq5opYCOThqr07lVnZuWF+85N7IrjE9XGCoufDK+26rhp@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7axxW1iAjI2BFzKxEsYptiIccdw2nEAH0bgSqgJfmt5qMEx39
	V445Au0HYbYffSWaOt4GEFj9BnZ9Zp/mH1xL4IDwDg2ST9mgU967BEY=
X-Gm-Gg: ASbGnctajh+GRcsv/aZouUKYRApBrKPRKJByu5SmLAMcZvf3xGqDyP0ePl6D+MfSMPD
	x2lc+YjAbEwRY0pr4dHlL4ZXkqMsaVM9CMq/ndSGVSZpVdZla3YiSxQLelqI8HYbdCjYTj8pjrI
	OjUlPHIQ/OF9ggeg6hX2U/U+nNZHzLJzQtm62hUTGuzAQyEePeP8KUtpwPaw3zapuhQ1KxHZShZ
	tvJtHJksq1T9VxoptronHXJ+bJh3pAHQdC4E+nuCdUrUI33ney9df3qEqE0uQ58czIhQMHI/i1d
	wcmg0NVVfE25IUoxGMnr7nvpWvOHwo5xGNNRlRymJiiIldVx8sPV6mJGu7YKPv4r+k78M4h28kT
	opk+A+iJfEq5GHFDPcEsZ0v25qzw=
X-Google-Smtp-Source: AGHT+IGtE5oKab5YMYXOizL8Nkh3l5Qve9bCmylWGg2p1Wz9sS6jb3o/Zpy/DJdRh4lj5xxkad2bCw==
X-Received: by 2002:a05:600c:6806:b0:43c:fb95:c76f with SMTP id 5b1f17b1804b1-442fd618ee7mr185274145e9.9.1747837391193;
        Wed, 21 May 2025 07:23:11 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac604.dip0.t-ipconnect.de. [91.42.198.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6b297easm75430375e9.6.2025.05.21.07.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 07:23:10 -0700 (PDT)
Message-ID: <0b7de680-f624-493e-a7d8-072ebe68dce3@googlemail.com>
Date: Wed, 21 May 2025 16:23:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/97] 6.1.140-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250520125800.653047540@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250520125800.653047540@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 20.05.2025 um 15:49 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.140 release.
> There are 97 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

